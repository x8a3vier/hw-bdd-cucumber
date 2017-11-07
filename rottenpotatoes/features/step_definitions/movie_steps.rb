# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create({ :title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'] })
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  if page.respond_to? :should
    expect(page.body =~/#{e1}.*#{e2}/m).to be >= 0
  else
    assert page.body =~ /#{e1}.*#{e2}/m
  end  
  #fail "Unimplemented"
end

Then /I should (not )?see movies with titles: (.*)/ do |not_see, titles|
  titles.split(/,\s?/).each do |title|
    if page.respond_to? :should
      if !!not_see

        page.should not(have_content(text))
      else
        page.should have_content(text)
      end
    
    else
      if !!not_see
        assert !page.has_content?(text)
      else
        assert page.has_content?(text)
      end
    end
  end
  true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |field|
    field = field.strip
    if uncheck
      uncheck("ratings_#{field}")
      
    else
      check("ratings_#{field}")
    end
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table

  movies = Movie.all
  movies.each do |movie|
    if page.respond_to? :should
      page.should have_content(movie[:title])
    else
      assert page.has_content?(movie[:title])
    end
  end
  true
  #fail "Unimplemented"
end
end