Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202E723BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjFFIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjFFIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:32:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1F10D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:31:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso50333285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686040233; x=1688632233;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwUjQvbewj5SnzEYimDrTgn7H3O6EHtl4JsnBhWTTfY=;
        b=kC/lU5IQeT3R/QxIqpNTWFK5Axd73FzhQcdkQGS1cniNUMLr21NaAarDSyGUao2uAj
         bVVx6IrjrjDQj/O0W8frv+3/P3rVtg0qYE29TGTsZzcVRdhhyzrFB9RmgDNGCMiVtLEU
         3PHydvSyHsRe5svAA3bh5akniJaRQkc6SmGVRFvC/PhEpTs/fHPd/YIAm69QP2t0Yb6Z
         F8FVo30McV/QxiwN3oik08YQLiFhXksohVB0MekBp2nngduXZqKRkafwXpBMdGI1ePLK
         fm+BoaSeHD7RzFTH7uI2UNwT6qJ3g26gNKIeFSaygUMWD/ajdPKLZKy0ABpgRR/D9IGi
         fL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040233; x=1688632233;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUjQvbewj5SnzEYimDrTgn7H3O6EHtl4JsnBhWTTfY=;
        b=G+OPndoA34OkqDMBWTGCDjmdfTzmw0Y52wVBaSKWok2D5r5MHfcJSYun7fvCA8gsQf
         tftLDRxf7kHnHE7iBf/qk622VYLtBTpOQkcZ+TNxBGq3gHdhqBYVBrBQ1F+Ufg4RhmxX
         d14HvQ/46QjOiMNkSYcfoXC8p+D2SSNU4yj7IKFQJiyxEXYzilQ0PGZxStqcqoM6m08T
         I1mIgu6io3oc0toXGX4PPNERavPZehJM3lFUgIE2PWumHeSvJ2SXkMo7FjwozhABajzl
         pTgzr2+EJqQobJ5ENf3H/FHoeHu58qHTMHfVLGmoqHDXc6+0T4wJ2cpYNeqhOHo/dxs0
         x1yw==
X-Gm-Message-State: AC+VfDxfauTBSJscNQ/lU2lp5LldBqEeOlsaUSfJcuLmKJK5AMhqXxE1
        c71B3o9BUJYyBRydBa9ScgQOtw==
X-Google-Smtp-Source: ACHHUZ5OiHJejRzlhAsHC0pei/h3QehCOVlov2VGDV/AQXo7e9Znzxx2615UdXNJBkZZb+3hv3ltvA==
X-Received: by 2002:a05:600c:2190:b0:3f7:e605:287c with SMTP id e16-20020a05600c219000b003f7e605287cmr1219833wme.40.1686040232727;
        Tue, 06 Jun 2023 01:30:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b002fda1b12a0bsm11948553wrt.2.2023.06.06.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:30:31 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:30:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, Tom Gall <tom.gall@linaro.org>
Subject: [PATCH] checkpatch: check for missing Fixes tags
Message-ID: <ZH7uo6ph8nhidxcV@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check looks for common words that probably indicate a patch
is a fix.  For now the regex is:

	(BUG: KASAN|Call Trace:|syzkaller|stable\@)

Why are stable patches encouraged to have a fixes tag?  Some people mark
their stable patches as "# 5.10" etc.  This is not as useful as a Fixes
tag.  The Fixes tag helps in review.  It helps people to not cherry-pick
buggy patches without also cherry-picking the fix.

Also if a bug affects the 5.7 kernel some people will round it up to
5.10+ because 5.7 is not supported on kernel.org.  It's possible the Bad
Binder bug was caused by this sort of gap where companies outside of
kernel.org are supporting different kernels from kernel.org?

Should it be counted as a Fix when a patch just silences harmless
WARN_ON() stack trace.  Yes.  Definitely.

Is silencing compiler warnings a fix?  It seems unfair to the original
authors, but we use -Werror now, and warnings break the build so let's
just add Fixes tags for those.  I tell people that silencing static
checker warnings is not a fix but the rules on this vary by subsystem.

Is fixing a minor LTP issue (Linux Test Project) a fix?  Probably?  It's
hard to know what to do if the LTP test has technically always been
broken.

One clear false positive from this check is when a patch updated the
debug output and the commit message included before and after Call
Traces.  Sometimes you should just ignore checkpatch.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I tested this by looking at the latest 500 commits in linux-next.
93 commits had Fixes tags.  Out of the remaining 407 commits then this
warning said that 9 of them should have had Fixes tags.

Of course the big rule change here is encouraging all stable@kernel.org
patches to add a Fix.  If everyone followed this checkpatch rule then
instead of 65% of stable patches having a Fixes tag it would be 75%.
(The stable tree includes a lot of other patches besides Fixes like
Stable-dep: patches etc, so it should never be 100%).

 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30b0b4fdb3bf..4e68de51e480 100755
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
@@ -2633,6 +2637,8 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $fixes_tag = 0;
+	my $needs_fixes_tag = 0;
 	my $author = '';
 	my $authorsignoff = 0;
 	my $author_sob = '';
@@ -3186,6 +3192,12 @@ sub process {
 			}
 		}
 
+# These indicate a bug fix
+		if (!$in_header_lines &&
+			$line =~ /(BUG: KASAN|Call Trace:|syzkaller|stable\@)/) {
+			$needs_fixes_tag++;
+		}
+
 
 # Check Fixes: styles is correct
 		if (!$in_header_lines &&
@@ -3198,6 +3210,7 @@ sub process {
 			my $id_length = 1;
 			my $id_case = 1;
 			my $title_has_quotes = 0;
+			$fixes_tag++;
 
 			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
 				my $tag = $1;
@@ -7636,6 +7649,12 @@ sub process {
 		ERROR("NOT_UNIFIED_DIFF",
 		      "Does not appear to be a unified-diff format patch\n");
 	}
+	if ($is_patch && $has_commit_log && $chk_fixes_tag) {
+		if ($needs_fixes_tag && $fixes_tag == 0) {
+			ERROR("MISSING_FIXES_TAG",
+			"This looks like a fix but there is no Fixes: tag\n");
+		}
+	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
-- 
2.39.2

