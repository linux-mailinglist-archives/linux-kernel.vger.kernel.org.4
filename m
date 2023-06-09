Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F6729399
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjFIIq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjFIIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:46:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962471730;
        Fri,  9 Jun 2023 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=rYsZ7NUM9QnsnZDvOA2XVbvmpJGN8lxYjvG/P+i1FWY=; t=1686300408; x=1687510008; 
        b=HqA2KMqsn9ICFDaWj4YroeLzOFnG0XLVJeQiIglFG9YZAwT7CreIyStCebg+ylxuZcCE5/zCLpr
        gy4rdI+WZc01zd5d8rN+6JiN33VruWNL4oiIEo1paR9WxOFUouKKl8pIfpF1Gx5sJ32qCB1/hGj5Q
        WxuvUC9ls050/93+6jGhhsIRhvgD04qhOdtsVfM+KwTnia2x5PlY/RkUDgNGyGPusk5p6eovVsmzY
        LIKRsXi7icdf+fCJ0BhMkii0www8oJsmNBKRGwKNGIveZIOTRO/piu/VxhIX92EpENLhAZLPLbGod
        gSn9PAMs8cR91ErEj7Ld7QERZWyDF2YpB3nQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q7Xld-000seH-1T;
        Fri, 09 Jun 2023 10:46:45 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 1/2] kernel-doc: don't let V=1 change outcome
Date:   Fri,  9 Jun 2023 10:46:41 +0200
Message-Id: <20230609104642.0a5f030f59a5.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The kernel-doc script currently reports a number of issues
only in "verbose" mode, but that's initialized from V=1
(via KBUILD_VERBOSE), so if you use KDOC_WERROR=1 then
adding V=1 might actually break the build. This is rather
unexpected.

Change kernel-doc to not change its behaviour wrt. errors
(or warnings) when verbose mode is enabled, but rather add
separate warning flags (and -Wall) for it. Allow enabling
those flags via environment/make variables in the kernel's
build system for easier user use, but to not have to parse
them in the script itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: - parse environment variables in build system rather than
      the script itself, as suggested by Masahiro Yamada
    - fix indentation
v3: - use a single KDOCFLAGS variable
---
 Documentation/kbuild/kbuild.rst |  6 ++++++
 scripts/Makefile.build          |  2 +-
 scripts/kernel-doc              | 28 +++++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 2a22ddb1b848..bd906407e307 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -150,6 +150,12 @@ the UTS_MACHINE variable, and on some architectures also the kernel config.
 The value of KBUILD_DEBARCH is assumed (not checked) to be a valid Debian
 architecture.
 
+KDOCFLAGS
+---------
+Specify extra (warning/error) flags for kernel-doc checks during the build,
+see scripts/kernel-doc for which flags are supported. Note that this doesn't
+(currently) apply to documentation builds.
+
 ARCH
 ----
 Set ARCH to the architecture to be built.
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f94fc83f086..a0b4fb58201c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -101,7 +101,7 @@ else ifeq ($(KBUILD_CHECKSRC),2)
 endif
 
 ifneq ($(KBUILD_EXTRA_WARN),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
+  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) $<
 endif
 
 # Compile C sources (.c)
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2486689ffc7b..8f8440870a0f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -23,7 +23,7 @@ kernel-doc - Print formatted kernel documentation to stdout
 
 =head1 SYNOPSIS
 
- kernel-doc [-h] [-v] [-Werror]
+ kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-description] [-Wcontents-before-sections]
    [ -man |
      -rst [-sphinx-version VERSION] [-enable-lineno] |
      -none
@@ -133,6 +133,9 @@ my $dohighlight = "";
 
 my $verbose = 0;
 my $Werror = 0;
+my $Wreturn = 0;
+my $Wshort_desc = 0;
+my $Wcontents_before_sections = 0;
 my $output_mode = "rst";
 my $output_preformatted = 0;
 my $no_doc_sections = 0;
@@ -187,9 +190,14 @@ if (defined($ENV{'KCFLAGS'})) {
 	}
 }
 
+# reading this variable is for backwards compat just in case
+# someone was calling it with the variable from outside the
+# kernel's build system
 if (defined($ENV{'KDOC_WERROR'})) {
 	$Werror = "$ENV{'KDOC_WERROR'}";
 }
+# other environment variables are converted to command-line
+# arguments in cmd_checkdoc in the build system
 
 # Generated docbook code is inserted in a template at a point where
 # docbook v3.1 requires a non-zero sequence of RefEntry's; see:
@@ -318,6 +326,16 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	$verbose = 1;
     } elsif ($cmd eq "Werror") {
 	$Werror = 1;
+    } elsif ($cmd eq "Wreturn") {
+	$Wreturn = 1;
+    } elsif ($cmd eq "Wshort-desc") {
+	$Wshort_desc = 1;
+    } elsif ($cmd eq "Wcontents-before-sections") {
+	$Wcontents_before_sections = 1;
+    } elsif ($cmd eq "Wall") {
+        $Wreturn = 1;
+        $Wshort_desc = 1;
+        $Wcontents_before_sections = 1;
     } elsif (($cmd eq "h") || ($cmd eq "help")) {
 		pod2usage(-exitval => 0, -verbose => 2);
     } elsif ($cmd eq 'no-doc-sections') {
@@ -1748,9 +1766,9 @@ sub dump_function($$) {
     # This check emits a lot of warnings at the moment, because many
     # functions don't have a 'Return' doc section. So until the number
     # of warnings goes sufficiently down, the check is only performed in
-    # verbose mode.
+    # -Wreturn mode.
     # TODO: always perform the check.
-    if ($verbose && !$noret) {
+    if ($Wreturn && !$noret) {
 	    check_return_section($file, $declaration_name, $return_type);
     }
 
@@ -2054,7 +2072,7 @@ sub process_name($$) {
 	    $state = STATE_NORMAL;
 	}
 
-	if (($declaration_purpose eq "") && $verbose) {
+	if (($declaration_purpose eq "") && $Wshort_desc) {
 	    emit_warning("${file}:$.", "missing initial short description on line:\n$_");
 	}
 
@@ -2103,7 +2121,7 @@ sub process_body($$) {
 	}
 
 	if (($contents ne "") && ($contents ne "\n")) {
-	    if (!$in_doc_sect && $verbose) {
+	    if (!$in_doc_sect && $Wcontents_before_sections) {
 		emit_warning("${file}:$.", "contents before sections\n");
 	    }
 	    dump_section($file, $section, $contents);
-- 
2.40.1

