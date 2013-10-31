def hitme(cardArray)
  return cardArray.pop
end

def card_value(card_array)
  new_array = card_array.map{|x| x[0]}
  total = 0
  first_ace = 'true'
  new_array.each do |value|
	if value == "A"
	  if first_ace
	  	if (total < 11)
	      total += 11
	    else
	      total += 1
	    end
	    first_ace = 'false'
	  else
	    total += 1
	  end
	elsif value.to_i == 0
	  total += 10
	else
	  total += value.to_i
	end
  end
  return total
end

def game_over
  puts "Do you want to play again? 1 for yes and 2 for no"
  answer = gets.chomp
  if answer == '1'
  	play_again = true
  	puts "Let's play again"
  else
    puts "Thank you for playing Blackjack"
    exit
  end
end

puts "Welcome to my Blackjack Game"
puts "What is your name"
name = gets.chomp
puts "Welcome" + name

play_again = true
while play_again
  puts "Let's get started"
  puts
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  suits = ['H', 'D', 'S', 'C']
  deck = cards.product(suits)
  deck.shuffle!

  my_cards = []
  dealer_cards = []
  my_cards << deck.pop
  dealer_cards << deck.pop
  my_cards << deck.pop
  dealer_cards << deck.pop
  my_value = card_value(my_cards)
  dealer_value = card_value(dealer_cards)

  puts name + "- you have " + my_cards.to_s + " with a value of " + my_value.to_s
  puts "The dealer has " + dealer_cards.to_s + " with a value of " + dealer_value.to_s
  puts

  if my_value == 21
    puts "BLACKJACK!  Congratulations, " + name + " you win"
    game_over
    next
  elsif dealer_value == 21
    puts "Dealer has blackjack.  Sorry, " + name + " you lose"
    game_over
    next
  else puts name +  " - Do you want another card?"
    answer = gets.chomp
    while answer == 'yes' && my_value < 22
	  my_cards << hitme(deck)
	  my_value = card_value(my_cards)
	  puts name + " - You have " + my_cards.to_s + " with a value of " + my_value.to_s
      puts
	  if my_value == 21
		puts "BLACKJACK!  Congratulations " + name + " you win"
		game_over
		next
	  elsif my_value < 22
		puts name + " - do you want another card?"
		answer = gets.chomp
	  end
	end
  end

  if my_value > 21
  	puts "Sorry you are over 21.  Game over"
  	game_over
  	next
  end
  puts "you now have " + my_cards.to_s + " with a value of " + my_value.to_s
  puts

  if dealer_value > my_value
	puts "Sorry " + name + " the dealer beat you"
	game_over
	next
  end

  while dealer_value <= my_value
	dealer_cards << hitme(deck)
	dealer_value = card_value(dealer_cards)
	puts "Dealer has " + dealer_cards.to_s + " with a value is #{dealer_value}"
	if dealer_value > 21
	  puts "Congratulations, " + name + " you won!"
	  game_over
	  next
	elsif dealer_value > my_value
	  puts "Sorry " + name + " the dealer beat you"
      game_over
      next
	end
  end
end