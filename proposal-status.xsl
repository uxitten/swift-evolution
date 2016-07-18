<!--
This file renders the contents of proposals.xml as a nicely-formatted HTML page.
The proposal data and this template are loaded using JavaScript (see index.html
on the gh-pages branch).
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <!-- The main template, which renders the page body. -->
  <xsl:template match="/proposals">
    <html>
      <head>
        <title>Swift-Evolution Proposal Status</title>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <xsl:call-template name="css"/>
      </head>
      <body>
        <h1>Swift Programming Language Evolution: Proposal Status</h1>
      
        <p>The <a href="https://github.com/apple/swift-evolution/blob/master/process.md">Swift evolution process</a> describes the process by which Swift evolves. This page tracks the currently active proposals in that process.</p>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Active reviews</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='active']"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Upcoming reviews</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='scheduled']"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Proposals awaiting scheduling</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='awaiting']"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Accepted (awaiting implementation)</xsl:with-param>
          <xsl:with-param name="description">This is the list of proposals which have been accepted for inclusion into Swift, but they are not implemented yet, and may not have anyone signed up to implement them. If they are not implemented in time for Swift 3, they will roll into a subsequent release.</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='accepted']"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Implemented for Swift 3</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='implemented'][@swift-version = 3]"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Implemented for Swift 2.2</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='implemented'][@swift-version = 2.2]"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Deferred for future discussion</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='deferred']"/>
        </xsl:call-template>
      
        <xsl:call-template name="section">
          <xsl:with-param name="title">Rejected or withdrawn</xsl:with-param>
          <xsl:with-param name="proposals" select="proposal[@status='rejected']"/>
        </xsl:call-template>
      </body>
    </html>
  </xsl:template>

  <!-- Renders a section header and a table of proposals. -->
  <xsl:template name="section">
    <xsl:param name="title"/>
    <xsl:param name="description"/>
    <xsl:param name="proposals"/>
    <section>
      <h2><xsl:value-of select="$title"/></h2>
      <xsl:if test="$description"><p><xsl:value-of select="$description"/></p></xsl:if>
      <xsl:choose>
        <xsl:when test="count($proposals) = 0">
          <p>(none)</p>
        </xsl:when>
        <xsl:otherwise>
          <table>
            <xsl:apply-templates select="$proposals">
              <xsl:sort select="@id" order="descending"/>
            </xsl:apply-templates>
          </table>
        </xsl:otherwise>
      </xsl:choose>
    </section>
  </xsl:template>

  <!-- Renders a single proposal. -->
  <xsl:template match="proposal">
    <tr class="proposal">
      <td><a class="number status-{@status}" href="https://github.com/apple/swift-evolution/blob/master/proposals/{@filename}">SE-<xsl:value-of select="@id"/></a></td>
      <td><a class="title" href="https://github.com/apple/swift-evolution/blob/master/proposals/{@filename}"><xsl:value-of select="@name"/></a></td>
    </tr>
  </xsl:template>
  
  <xsl:template name="css">
    <style type="text/css">
      * {
        margin: 0;
        padding: 0;
      }
      body {
        font-family: -apple-system, BlinkMacSystemFont, HelveticaNeue, Helvetica, Arial, sans-serif;
        -webkit-text-size-adjust: none;
      }
      body > h1, body > p, section > table, section > p {
        margin-left: 1rem;
        margin-right: 1rem;
      }
      p {
        margin-top: 1em;
        margin-bottom: 1em;
        line-height: 1.5em;
      }
      h1 {
        margin-top: 0.6em;
        margin-bottom: 0.6em;
      }
      h2 {
        margin: 0.5em 0em 0em;
        padding: 0.3em 1rem 0.4em;
        position: -webkit-sticky;
        position: -moz-sticky;
        position: -ms-sticky;
        position: -o-sticky;
        position: sticky;
        top: 0px;
        background-color: #fff;
      }
      @supports (backdrop-filter: blur(10px)) or (-webkit-backdrop-filter: blur(10px)) {
        h2 {
          background-color: rgba(255, 255, 255, 0.5);
          backdrop-filter: blur(10px);
          -webkit-backdrop-filter: blur(10px);
        }
      }
      h2 + p {
        margin-top: 0;
      }
      a {
        color: #4078c0;
        text-decoration: none;
      }
      a:hover, a:visited:hover {
        text-decoration: underline;
      }
      .proposal a.title {
        color: #666;
      }
      .proposal a.title:visited {
        color: #999;
      }
      .proposal a.title:hover, .proposal a.title:visited:hover {
        color: #222;
      }
      table {
        margin-bottom: 1rem;
        border-spacing: 0.5em;
      }
      table, tr, td {
        padding: 0;
      }
      .proposal {
        font-size: 1.1em;
      }
      .proposal td {
        vertical-align: top;
      }
      .number {
        text-align: center;
        border-radius: 5px;
        font-size: 0.7em;
        font-weight: bold;
        padding: 0.2em 0.5em;
        display: block;
        white-space: nowrap;
        color: #fff;
      }
      .proposal a.number {
        color: #fff;
        text-decoration: none;
      }
      a.number.status-implemented {
        background-color: #319021;
      }
      a.number.status-accepted {
        background-color: #5abc4e;
      }
      a.number.status-active {
        background-color: #297de4;
      }
      a.number.status-scheduled {
        background-color: #78b8fb;
      }
      a.number.status-awaiting, a.number.status-deferred {
        background-color: #dddddd;
        color: #000;
      }
      a.number.status-returned {
        background-color: #f1b6b7;
      }
      a.number.status-rejected {
        background-color: #de5b60;
      }
    </style>
  </xsl:template>

</xsl:stylesheet>
