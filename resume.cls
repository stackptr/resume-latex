% Resume Class file

\ProvidesClass{resume}[2013/01/25 v1.0 Resume class]

% Set font size, paper type, and document margins
\LoadClass[11pt,letterpaper]{article}
\usepackage[left=0.75in,top=0.6in,right=0.75in,bottom=0.6in]{geometry}

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array}            % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen}           % Required for ifthenelse statements
\pagestyle{empty}             % Remove page numbers


%---------------------------------------------------------------------
%	Heading
%---------------------------------------------------------------------

\def \name#1{\def\@name{#1}}  % Define \name
\def \@name {}                % \@name is empty by default
\def \contactSep {$-$}        % Set default address separator

% Define \printname to style name in heading
\def \printname {
  \begingroup
    \hfil{\MakeUppercase{\namesize\bf \@name}}\hfil
    \nameskip\break
  \endgroup
}

% Define contact lines: allow one or two lines to display
\let \@contactone \relax
\let \@contacttwo \relax
\def \contact #1{
  \@ifundefined{@contacttwo}{
    \def \@contacttwo {#1}
  }{
    \def \@contactone {#1}
  }
}

% Define \printcontactline to style each line of contact info
\def \printcontactline #1{
  \begingroup
    \def \\ {\contactSep\ }
    \centerline{#1}
  \endgroup
  \par
  \contactskip
}

% Render heading
\let\ori@document=\document
\renewcommand{\document}{
  \ori@document
  \printname
  \@ifundefined{@contactone}{}{
    \printcontactline{\@contactone}}
  \@ifundefined{@contacttwo}{}{
    \printcontactline{\@contacttwo}}
}

%---------------------------------------------------------------------
%	Section formatting
%---------------------------------------------------------------------

% Define the rSection environment for the large sections within the CV
% Takes section name as the argument
\newenvironment{rSection}[1]{
  \sectionskip
  \MakeUppercase{\bf #1}            % Section title
  \sectionlineskip
  \hrule                            % Horizontal line
  \begin{list}{}{                   % List for each individual item in the section
    \setlength{\leftmargin}{1.5em}  % Margin within the section
  }
  \item[]
}{
  \end{list}
}

%---------------------------------------------------------------------
%	Work experience formatting
%---------------------------------------------------------------------

% Define rSubsection environment to list work experience
% Arguments: company name, year(s) employed, job title, and location
\newenvironment{rSubsection}[4]{
 {\bf #1} \hfill {#2}                     % Bold company name and date on the right
 \ifthenelse{\equal{#3}{}}{}{             % If no job title is given, omit job title and location line
  \\
  {\em #3} \hfill {\em #4}                % Italic job title and location
  }\smallskip
  \begin{list}{$\cdot$}{\leftmargin=0em}  % \cdot used for bullets, no indentation
   \itemsep -0.5em \vspace{-0.5em}        % Compress items in list together for aesthetics
  }{
  \end{list}
  \vspace{0.5em}                          % Bottom margin for list items
}

%---------------------------------------------------------------------
%	Whitespace
%---------------------------------------------------------------------

\def\namesize{\huge}            % Size of the name at the top of the document
\def\contactskip{\smallskip}    % The space between the two contact lines
\def\sectionlineskip{\medskip}  % The space above the horizontal line for each section 
\def\nameskip{\bigskip}         % The space after your name at the top
\def\sectionskip{\medskip}      % The space after the heading section
