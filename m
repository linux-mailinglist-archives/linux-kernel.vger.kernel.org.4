Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2CE5FDEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJMR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJMR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:29:29 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CDC3541;
        Thu, 13 Oct 2022 10:29:28 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        by ms.lwn.net (Postfix) with ESMTPA id E49D9845;
        Thu, 13 Oct 2022 17:29:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E49D9845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665682168; bh=0opHrZqvXrL6VtcOxiAU4dw/b0sguVWD5kn6y9m/afo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzbjjyF5THDuiifk7pwCcR2BT3lwHJ1v5ySNvbHfr+iosLF/ruylselyA+DC2cr7k
         weO48FqSQpscOjHUOaMT0rande9wdUNRhRwmwrfsuyNC61y2XEgDygTxApMMj73Xv3
         YTx5SpYKE1hI0hkKu6n31+T8rKqr0JJ0uLHVelp+xg7qFM07Sc3WnKvUHbWf7VK38d
         KXVvscZ1f3llbQC9dVR6YS+LrcL7+bVd6Xmm9HmocARTEiEIOriAgKhD2GYGrddIJ/
         DdcHJCEcCo0eizwMAXzE0CpwT/e7OBGYCcxU5bvrZZ4j4pFXPVhxBPx7wqkEAvFw1K
         6PVo4JdcFzIXQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] docs: improve the HTML formatting of kerneldoc comments
Date:   Thu, 13 Oct 2022 11:29:17 -0600
Message-Id: <20221013172918.846856-6-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221013172918.846856-1-corbet@lwn.net>
References: <20221013172918.846856-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx-static/custom.css | 16 +++++++-
 scripts/kernel-doc                     | 52 ++++++++++++++++----------
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
index 6b0e554cea0a..9b36f7abd24f 100644
--- a/Documentation/sphinx-static/custom.css
+++ b/Documentation/sphinx-static/custom.css
@@ -10,5 +10,19 @@ div.body h3 { font-size: 130%; }
 
 /* Tighten up the layout slightly */
 div.body { padding: 0 15px 0 10px; }
-div.document { margin: 20px 10px 0 10px; }
 div.sphinxsidebarwrapper { padding: 1em 0.4em; }
+/* Tweak document margins and don't force width */
+div.document {
+    margin: 20px 10px 0 10px; 
+    width: auto;
+}
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
index aea04365bc69..85ea80fb5154 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -866,48 +866,53 @@ sub output_function_rst(%) {
 	print "\n";
     }
 
-    print "**Parameters**\n\n";
+    #
+    # Put our descriptive text into a container (thus an HTML <div>) to help
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

