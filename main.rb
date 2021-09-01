#Problem 1:
#Each note of the same denomination has its own serial number. Up through Series
#1995, all Federal Reserve notes had serial numbers consisting of one letter,
#eight digits, and one letter, such as A12345678B; now only the $1 and $2 notes
#still use this form.
#
#The first letter of such a serial number identifies the Federal Reserve Bank
#(FRB) which issued the note; since there are 12 FRBs, this letter is always
#between A and L. The last letter advances through the alphabet when all eight
#character serial numbers have been printed for a specific Federal Reserve Bank
#within the same series. At the time of a series change, the suffix letter
#returns to the letter A and repeats the cycle.
#
#The letter O is not used because of its similarity to the digit 0, and the
#letter Z is not used because it is reserved for test printings. On some notes,
#a star appears in place of the last letter. When an imperfect sheet is detected
#during the manufacturing process after the serial number has been overprinted,
#it must be replaced with a new sheet. A "star" sheet is used to replace the
#imperfect sheet. Reusing an exact serial number to replace an imperfect note is
#costly and time consuming. A "star" note has its own special serial number
#followed by a star in place of a suffix letter.
#
# Input is a string
# Output is a boolean value of whether or not the string is a valid serial number
def validSerialNumber?(s)
  regex = /^[A-L]([1-9]{8})([A-NP-X]|\*)/
  return true ? s.match(regex) != nil : false
end

#Problem 2
# Input is a string of a filename
# Output is a hash of the characters and their corresponding frequencies
def charFreq(someFile)
text = ""
File.open(someFile, 'r') do |file|
  text = file.to_a.to_s.downcase.gsub(/[^a-z\s]/, '')
end

freq = {}
char = text.split("")
freq = char.uniq.each{|c| freq[c] = char.count(c)}

counts = {}
for c in char 
  if counts.key?(c)
    counts[c] += 1
  else 
    counts[c] = 1
  end
end 

print(counts)
end

#Problem 3
# Input are strings: the name of a directory, a file extension, e.g., txt, and a string
# Output is an array of all the filenames in the directory containing the string
def searchABatch(directory, extension, searchString)
  return Dir.entries(directory).select{|file| File.open(file, "r").include?(searchString)}
end

#Problem 4
# Input is a string of a file or directory name
# Output is the sum of the sizes of all the files, not directories, in the directory and all sub-directories
# Can include iteration, but must be recursive
def sizeOnDisk(someFile)
  #get directory
  #size of file in directories
  #add
  return Dir.glob(File.join(someFile, '**', '*')).map{|f| File.size(f)}.inject(:+)
end

#Problem 5
# Input is a number
# Output is a Roman numeral string
def convertToRoman(n)
  #divide by roman num taken out
  #num is remainder 
  #repeat
  roman = { 1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC", 50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I" }

  ans = ""
  roman.keys.each do |divisor|
    quotient, modulus = n.divmod(divisor)
    ans << roman[divisor] * quotient
    n = modulus
  end
  return ans 
end

puts('validSerialNumber?:')
puts("Case A12345678B: #{validSerialNumber?('A12345678B') == true}")
puts("Case A123456780: #{validSerialNumber?('A12345678O') == false}")
puts('Testing charFreq:')
puts("#{charFreq('text.txt')}")
puts('Testing searchABatch?:')
puts("#{searchABatch?('Documents', 'txt', 'lorem')}")
puts('Testing sizeOnDisk:')
puts("Case Documents: #{sizeOnDisk('Documents')}")
puts('Testing convertToRoman:')
puts("Case 5: #{convertToRoman(5) == 'V'}" % ['I'])
puts("Case 4999: #{convertToRoman(4999) == 'MMMMCMXCIX'}")
