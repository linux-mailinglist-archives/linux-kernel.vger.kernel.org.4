Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE67E723C5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjFFI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjFFI5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:57:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A010D7;
        Tue,  6 Jun 2023 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=iAvSNf9q5H7Fglw+xBqescyQX0+5g18cx1WVw0mtFJM=; t=1686041835; x=1687251435; 
        b=ucRmKruXVABKqw2i94E4yzYRB+HPv6sk4wqVlkVlVrE8DzJ2ED+brrSIvomsBO86XjbreHH9M0u
        R+Zg/MA3j5afqmXG0NYBtMBTRUx7bn8zOdURnWRuenCXTjpanDUBROnN6TFv+1W2B8r225g80HK7L
        St/kPH7gza2FGS87PNxP4zQhFlty+YGgZMioa4BKM23jkI6n+QHkHZVlx04bONT44oRBtddiGgCMm
        t4JDSz5PqmByALNoxitFcrwxi3BzWLeN273avf2s9Nty+Q9xzHnDvtCG5wI9nTdUlXAB572fDoX45
        qrULDZr6h/CszuZdr8zJDfWrqzxaKZ2FXh1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6SV6-00FTy6-35;
        Tue, 06 Jun 2023 10:57:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/2] kernel-doc: don't let V=1 change outcome
Date:   Tue,  6 Jun 2023 10:57:05 +0200
Message-Id: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
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
---
 scripts/Makefile.build |  7 ++++++-
 scripts/kernel-doc     | 28 +++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f94fc83f086..90bb5badb0e9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -101,7 +101,12 @@ else ifeq ($(KBUILD_CHECKSRC),2)
 endif
 
 ifneq ($(KBUILD_EXTRA_WARN),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
+  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none \
+        $(if $(KDOC_WALL), -Wall) \
+        $(if $(KDOC_WRETURN), -Wreturn) \
+        $(if $(KDOC_WSHORT_DESC), -Wshort-desc) \
+        $(if $(KDOC_WSHORT_DESC), -Wcontents-before-sections) \
+        $<
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

