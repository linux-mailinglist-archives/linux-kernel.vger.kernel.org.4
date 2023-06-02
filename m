Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421E720AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjFBVAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjFBVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:00:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85C819B;
        Fri,  2 Jun 2023 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=qRgq5U/n9Ip9t5IBpxq+Q3tveoCjRKpwVurL75b8pPY=; t=1685739626; x=1686949226; 
        b=vTqJotCK7xpxTZoS9CJTIV358rzDwcnvSD6igpgFCaMBzRGk39c9Nravr0ETyW6xgw35CrsoBbS
        icIHGA0rNrUb+g1oISrYMCn3vKy+KWoonsg9jLOpTu8GT7r6BSHwwNRwvIlRZOPzwsgUsNVt14GIz
        eTG6uddN9cbWyGpS/gA0g4FtaEiPO9deac+a0xJ5NSqiKWpotQGKJfiQRS9sb/+rCzxFMMnZyx4OK
        gGZiUxYBwFYkm2Ip4cadhb5eKEyG03gLvTjEzH7H2zcf+ykLDPrvMQFjFsT6AhenZHV8vGvwr//Wq
        gd11Fq9D4KbqNx99EIRIXiBj+bnRRCe9HKnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q5Bsk-00BgEs-1p;
        Fri, 02 Jun 2023 23:00:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] kernel-doc: don't let V=1 change outcome
Date:   Fri,  2 Jun 2023 23:00:13 +0200
Message-Id: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
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
separate warning flags (and -Wall) for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 scripts/kernel-doc | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2486689ffc7b..1eb1819fbe13 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -23,7 +23,7 @@ kernel-doc - Print formatted kernel documentation to stdout
 
 =head1 SYNOPSIS
 
- kernel-doc [-h] [-v] [-Werror]
+ kernel-doc [-h] [-v] [-Werror] [-Wreturn] [-Wshort-description] [-Wcontents-before-sections] [-Wall]
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
@@ -191,6 +194,24 @@ if (defined($ENV{'KDOC_WERROR'})) {
 	$Werror = "$ENV{'KDOC_WERROR'}";
 }
 
+if (defined($ENV{'KDOC_WRETURN'})) {
+	$Wreturn = "$ENV{'KDOC_WRETURN'}";
+}
+
+if (defined($ENV{'KDOC_WSHORT_DESC'})) {
+	$Wshort_desc = "$ENV{'KDOC_WSHORT_DESC'}";
+}
+
+if (defined($ENV{'KDOC_WCONTENTS_BEFORE_SECTION'})) {
+	$Wcontents_before_sections = "$ENV{'KDOC_WCONTENTS_BEFORE_SECTION'}";
+}
+
+if (defined($ENV{'KDOC_WALL'})) {
+	$Wreturn = "$ENV{'KDOC_WALL'}";
+	$Wshort_desc = "$ENV{'KDOC_WALL'}";
+	$Wcontents_before_sections = "$ENV{'KDOC_WALL'}";
+}
+
 # Generated docbook code is inserted in a template at a point where
 # docbook v3.1 requires a non-zero sequence of RefEntry's; see:
 # https://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
@@ -318,6 +339,16 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
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
+	$Wcontents_before_sections = 1;
     } elsif (($cmd eq "h") || ($cmd eq "help")) {
 		pod2usage(-exitval => 0, -verbose => 2);
     } elsif ($cmd eq 'no-doc-sections') {
@@ -1748,9 +1779,9 @@ sub dump_function($$) {
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
 
@@ -2054,7 +2085,7 @@ sub process_name($$) {
 	    $state = STATE_NORMAL;
 	}
 
-	if (($declaration_purpose eq "") && $verbose) {
+	if (($declaration_purpose eq "") && $Wshort_desc) {
 	    emit_warning("${file}:$.", "missing initial short description on line:\n$_");
 	}
 
@@ -2103,7 +2134,7 @@ sub process_body($$) {
 	}
 
 	if (($contents ne "") && ($contents ne "\n")) {
-	    if (!$in_doc_sect && $verbose) {
+	    if (!$in_doc_sect && $Wcontents_before_sections) {
 		emit_warning("${file}:$.", "contents before sections\n");
 	    }
 	    dump_section($file, $section, $contents);
-- 
2.40.1

