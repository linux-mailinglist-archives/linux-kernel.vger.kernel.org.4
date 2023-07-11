Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994174F0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjGKNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjGKNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:48:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86410EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:48:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9047741e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689083301; x=1691675301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5EedEwkl5J8ikSWamj8/bT29Jk0x5y+zOZZoU4f4Fs=;
        b=X4aw4pWp3bfHrehMtc03Qwq7ayblhgLn7BoJzIWch64Uz9DD4QXpy92GyaFvkms9+c
         eNxWauaYk4GO53S6FCUbLRgqV/dz9D9V879VWcq5E7UGANpMQP200Fgp9gm2hKu3Lw15
         ogi/2fNZC+h1RleI6oj8drgggYxvgq10nR+hZr36oRW1YyGKEduWWWlQjfk/eExIMTbZ
         EBGhGzjorF9TbKSLLllhztiBQQAqTcC/nwyWxkdus3QXSfPrfm4SUTqNra75tkMMWk1r
         kLXWlmdddeg+RljApkXVdkeyiTv4lwOL4Xl+g8ppMsC5MyVIasxM3d8deLNatLs+iGEd
         WZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083301; x=1691675301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5EedEwkl5J8ikSWamj8/bT29Jk0x5y+zOZZoU4f4Fs=;
        b=b+/P8iYvOp/nF6H6jJcrKCCSg9EjxrnTBOCeNkkCuUXyLa7slYtVpTklxo33zOTRms
         wMBTlTO4h2w0GcgxlOMeJVJncHBVSH3JR4orWo+VseyNHlM93JMSxtGJTVlkKUcsceQL
         NruKPFcNpeCgg9+NsdcvWZzWcEgrkPaUZDruMNvoMxqXA6DZdrh3ItppqGcJ4T5kR+nU
         ZkteJUESnpXeLo4DX0Icy01Blb/KUAdDL5SzcfiH7RNUGtTeWkq27Dg26dKv8OQigiCT
         cXyNAo0XuerHBsOFlQ/NBsXjiatsganh/wRSgB8nflge0Jqnecdmto6L7q66gfZiitjD
         0KCQ==
X-Gm-Message-State: ABy/qLaNgyDAN6KupOeooBH0URBNymDDGDZayVis5F899s9zEn7UTMxl
        WJwvPLWn6e/VNEKYNqzthFp0DQ==
X-Google-Smtp-Source: APBJJlFHx8lUGT2+uQzWVA3tc2jJSPEyOlEbpeAeElkyPsI6KTbhcDTkUgXSXPZ3LV+KX8TKCzMC3A==
X-Received: by 2002:a19:3814:0:b0:4fb:8fde:f60d with SMTP id f20-20020a193814000000b004fb8fdef60dmr11486483lfa.22.1689083300953;
        Tue, 11 Jul 2023 06:48:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t11-20020a7bc3cb000000b003fc04eb92cbsm2569797wmj.44.2023.07.11.06.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:48:18 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:48:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Tom Gall <tom.gall@linaro.org>, kernel-janitors@vger.kernel.org
Subject: [PATCH v4] checkpatch: check for missing Fixes tags
Message-ID: <f3ac6084-8def-4b57-9e6e-0497555e2784@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check looks for common words that probably indicate a patch
is a fix.  For now the regex is:

	(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/)

Why are stable patches encouraged to have a fixes tag?  Some people mark
their stable patches as "# 5.10" etc.  This is useful but a Fixes tag is
still a good idea.  For example, the Fixes tag helps in review.  It
helps people to not cherry-pick buggy patches without also
cherry-picking the fix.

Also if a bug affects the 5.7 kernel some people will round it up to
5.10+ because 5.7 is not supported on kernel.org.  It's possible the Bad
Binder bug was caused by this sort of gap where companies outside of
kernel.org are supporting different kernels from kernel.org.

Should it be counted as a Fix when a patch just silences harmless
WARN_ON() stack trace.  Yes.  Definitely.

Is silencing compiler warnings a fix?  It seems unfair to the original
authors, but we use -Werror now, and warnings break the build so let's
just add Fixes tags.  I tell people that silencing static checker
warnings is not a fix but the rules on this vary by subsystem.

Is fixing a minor LTP issue (Linux Test Project) a fix?  Probably?  It's
hard to know what to do if the LTP test has technically always been
broken.

One clear false positive from this check is when someone updated their
debug output and included before and after Call Traces.  Or when crashes
are introduced deliberately for testing.  In those cases, you should
just ignore checkpatch.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4: Fix another formatting issue.
v3: Add UBSAN to the regex as Kees suggested.
v2: I fixed the formatting issues Joe pointed out.  I also silenced the
    warning if the commit was a Revert because revert patches already
    include the hash.

 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..ac617a976dcf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -28,6 +28,7 @@ my %verbose_messages = ();
 my %verbose_emitted = ();
 my $tree = 1;
 my $chk_signoff = 1;
+my $chk_fixes_tag = 1;
 my $chk_patch = 1;
 my $tst_only;
 my $emacs = 0;
@@ -86,6 +87,7 @@ Options:
   -v, --verbose              verbose mode
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
+  --no-fixes-tag             do not check for 'Fixes:' tag
   --patch                    treat FILE as patchfile (default)
   --emacs                    emacs compile window format
   --terse                    one line per report
@@ -293,6 +295,7 @@ GetOptions(
 	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
+	'fixes-tag!'	=> \$chk_fixes_tag,
 	'patch!'	=> \$chk_patch,
 	'emacs!'	=> \$emacs,
 	'terse!'	=> \$terse,
@@ -1254,6 +1257,7 @@ sub git_commit_info {
 }
 
 $chk_signoff = 0 if ($file);
+$chk_fixes_tag = 0 if ($file);
 
 my @rawlines = ();
 my @lines = ();
@@ -2633,6 +2637,9 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $fixes_tag = 0;
+	my $is_revert = 0;
+	my $needs_fixes_tag = 0;
 	my $author = '';
 	my $authorsignoff = 0;
 	my $author_sob = '';
@@ -3186,6 +3193,16 @@ sub process {
 			}
 		}
 
+# These indicate a bug fix
+		if (!$in_header_lines && !$is_patch &&
+			$line =~ /^This reverts commit/) {
+			$is_revert = 1;
+		}
+
+		if (!$in_header_lines && !$is_patch &&
+		    $line =~ /(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/) {
+			$needs_fixes_tag = 1;
+		}
 
 # Check Fixes: styles is correct
 		if (!$in_header_lines &&
@@ -3198,6 +3215,7 @@ sub process {
 			my $id_length = 1;
 			my $id_case = 1;
 			my $title_has_quotes = 0;
+			$fixes_tag = 1;
 
 			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
 				my $tag = $1;
@@ -7636,6 +7654,12 @@ sub process {
 		ERROR("NOT_UNIFIED_DIFF",
 		      "Does not appear to be a unified-diff format patch\n");
 	}
+	if ($is_patch && $has_commit_log && $chk_fixes_tag) {
+		if ($needs_fixes_tag && !$is_revert && !$fixes_tag) {
+			WARN("MISSING_FIXES_TAG",
+			     "This looks like a fix but there is no Fixes: tag\n");
+		}
+	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
-- 
2.39.2

