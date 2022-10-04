Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233105F4A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJDUM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJDUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:12:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE02222A9;
        Tue,  4 Oct 2022 13:12:37 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 384BF7DC;
        Tue,  4 Oct 2022 20:12:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 384BF7DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664914357; bh=SFg4DeLOFXhMPlmb11hADxqed3o6ZbUJFfnUFY8QYcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0+Txb0N/fxdI/+iyKeVPBDbXqxcS8GWL0XzB8yFClxAVSNWZ2XCqDuRzgjcwgShH
         iojoJW+AMUtwEm8dniSUcoISmu+zcRBDBUNDr6n3OywJ656JayR08eVLbJLibarqm/
         e9LXkLRazlcpLdqgoqRWErCBlqzRgpmHv0WN3Fmr5P6xpmnbBczYJQJ43aATOKLZxp
         9bQwIizpZeL9FSh21qjNvazVHsbHiPZAzIOsT3Gw3nQZngKkImTZn933vt9LWWi/GU
         IPeZTm7dAraYUhbatrrLzcwH/rt1U7uKG6CUFmoAWAoXXfikh3/3t26FWbSx/8I8kr
         Vhs3AnEC6yZeg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc comments
Date:   Tue,  4 Oct 2022 14:12:22 -0600
Message-Id: <20221004201222.281845-6-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221004201222.281845-1-corbet@lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a few changes to cause functions documented by kerneldoc to stand out
better in the rendered documentation.  Specifically, change kernel-doc to
put the description section into a ".. container::" section, then add a bit
of CSS to indent that section relative to the function prototype (or struct
or enum definition).  Tweak a few other CSS parameters while in the
neighborhood to improve the formatting.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx-static/custom.css | 13 +++++++
 scripts/kernel-doc                     | 52 ++++++++++++++++----------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
index c465251e840a..d8823fbbd27b 100644
--- a/Documentation/sphinx-static/custom.css
+++ b/Documentation/sphinx-static/custom.css
@@ -10,3 +10,16 @@ div.body h3 { font-size: 130%; }
 
 /* Tighten up the layout slightly */
 div.body { padding: 0 15px 0 10px; }
+
+/* Don't force the document width */
+div.document { width: auto; max-width: 60em; }
+
+/*
+ * Parameters for the display of function prototypes and such included
+ * from C source files.
+ */
+dl.function, dl.struct, dl.enum { margin-top: 2em; background-color: #ecf0f3; }
+/* indent lines 2+ of multi-line function prototypes */
+dl.function dt { margin-left: 10em; text-indent: -10em; }
+dt.sig-object { font-size: larger; }
+div.kernelindent { margin-left: 2em; margin-right: 4em; }
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index aea04365bc69..13d42857bce2 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -866,48 +866,53 @@ sub output_function_rst(%) {
 	print "\n";
     }
 
-    print "**Parameters**\n\n";
+    #
+    # Put our descriptive text into a container (thus an HTML <div> to help
+    # set the function prototypes apart.
+    #
+    print ".. container:: kernelindent\n\n";
     $lineprefix = "  ";
+    print $lineprefix . "**Parameters**\n\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 	$type = $args{'parametertypes'}{$parameter};
 
 	if ($type ne "") {
-	    print "``$type``\n";
+	    print $lineprefix . "``$type``\n";
 	} else {
-	    print "``$parameter``\n";
+	    print $lineprefix . "``$parameter``\n";
 	}
 
         print_lineno($parameterdesc_start_lines{$parameter_name});
 
+	$lineprefix = "    ";
 	if (defined($args{'parameterdescs'}{$parameter_name}) &&
 	    $args{'parameterdescs'}{$parameter_name} ne $undescribed) {
 	    output_highlight_rst($args{'parameterdescs'}{$parameter_name});
 	} else {
-	    print "  *undescribed*\n";
+	    print $lineprefix . "*undescribed*\n";
 	}
+	$lineprefix = "  ";
 	print "\n";
     }
 
-    $lineprefix = $oldprefix;
     output_section_rst(@_);
+    $lineprefix = $oldprefix;
 }
 
 sub output_section_rst(%) {
     my %args = %{$_[0]};
     my $section;
     my $oldprefix = $lineprefix;
-    $lineprefix = "";
 
     foreach $section (@{$args{'sectionlist'}}) {
-	print "**$section**\n\n";
+	print $lineprefix . "**$section**\n\n";
         print_lineno($section_start_lines{$section});
 	output_highlight_rst($args{'sections'}{$section});
 	print "\n";
     }
     print "\n";
-    $lineprefix = $oldprefix;
 }
 
 sub output_enum_rst(%) {
@@ -915,6 +920,7 @@ sub output_enum_rst(%) {
     my ($parameter);
     my $oldprefix = $lineprefix;
     my $count;
+    my $outer;
 
     if ($sphinx_major < 3) {
 	my $name = "enum " . $args{'enum'};
@@ -924,14 +930,17 @@ sub output_enum_rst(%) {
 	print "\n\n.. c:enum:: " . $name . "\n\n";
     }
     print_lineno($declaration_start_line);
-    $lineprefix = "   ";
+    $lineprefix = "  ";
     output_highlight_rst($args{'purpose'});
     print "\n";
 
-    print "**Constants**\n\n";
-    $lineprefix = "  ";
+    print ".. container:: kernelindent\n\n";
+    $outer = $lineprefix . "  ";
+    $lineprefix = $outer . "  ";
+    print $outer . "**Constants**\n\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
-	print "``$parameter``\n";
+	print $outer . "``$parameter``\n";
+
 	if ($args{'parameterdescs'}{$parameter} ne $undescribed) {
 	    output_highlight_rst($args{'parameterdescs'}{$parameter});
 	} else {
@@ -939,7 +948,7 @@ sub output_enum_rst(%) {
 	}
 	print "\n";
     }
-
+    print "\n";
     $lineprefix = $oldprefix;
     output_section_rst(@_);
 }
@@ -982,18 +991,19 @@ sub output_struct_rst(%) {
 	}
     }
     print_lineno($declaration_start_line);
-    $lineprefix = "   ";
+    $lineprefix = "  ";
     output_highlight_rst($args{'purpose'});
     print "\n";
 
-    print "**Definition**\n\n";
-    print "::\n\n";
+    print ".. container:: kernelindent\n\n";
+    print $lineprefix . "**Definition**::\n\n";
     my $declaration = $args{'definition'};
-    $declaration =~ s/\t/  /g;
-    print "  " . $args{'type'} . " " . $args{'struct'} . " {\n$declaration  };\n\n";
+    $lineprefix = $lineprefix . "  ";
+    $declaration =~ s/\t/$lineprefix/g;
+    print $lineprefix . $args{'type'} . " " . $args{'struct'} . " {\n$declaration" . $lineprefix . "};\n\n";
 
-    print "**Members**\n\n";
     $lineprefix = "  ";
+    print $lineprefix . "**Members**\n\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
 	($parameter =~ /^#/) && next;
 
@@ -1003,8 +1013,10 @@ sub output_struct_rst(%) {
 	($args{'parameterdescs'}{$parameter_name} ne $undescribed) || next;
 	$type = $args{'parametertypes'}{$parameter};
         print_lineno($parameterdesc_start_lines{$parameter_name});
-	print "``" . $parameter . "``\n";
+	print $lineprefix . "``" . $parameter . "``\n";
+	$lineprefix = "    ";
 	output_highlight_rst($args{'parameterdescs'}{$parameter_name});
+	$lineprefix = "  ";
 	print "\n";
     }
     print "\n";
-- 
2.37.2

