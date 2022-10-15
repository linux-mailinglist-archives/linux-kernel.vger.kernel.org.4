Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9D5FF8E0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJOGph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 02:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJOGpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 02:45:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CEA33A06
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 23:45:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so6619509plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKvoXK/MW48t9MwyWpeLn78cutQ1/AuUErTpoyAp4pw=;
        b=iRpHiPtMi3dUnwjROUmCYDz3L06j/0iq48p0NvuJkL6l00uZx25ixBf2qej6qcMfr1
         CY5gLPdJJY5kWcMVCS9s+f0eWEb3F3sAWht05lihdNmtUyyKL9QKAPCovc2EgznBxbvn
         SepY6equs/0nk7ruhzNzrOYL/BSUvys3Qgjy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKvoXK/MW48t9MwyWpeLn78cutQ1/AuUErTpoyAp4pw=;
        b=dHK7OoyQ24jOzi8djBJHEpTqM22EY6aJCweb/ZMtmCg+ppc0aNNB6IMl+gEsDmaef6
         reLevWVvR0P7dpUXgC1izB1z6/IXr3APVvFGo6qXVrBvqP/g3jNI+ijSTmUf12ASM6lb
         uiWA/jKWeR/3jPY+GWOALQ1peGpWuqZYViS2apCa8bwHkfjYGJ/EbfUw7UyOfFoZbLKX
         tOQUqxdDgjgwW+DhYGibNe27/3fM8jvDLYedRInSysWEuckn9XyYD6hPYhHaKRmi+Tri
         PGlnK2Y4O9gdCgjkz8z5o79lILSAAHgAhr2LAK/x5D4m85c+G6T0kEveTOJWxSgjaa1I
         P41Q==
X-Gm-Message-State: ACrzQf2WNNOtxOsb6CqdWXxDQ+dHSMpxKwPm1Kq0Xgij/9kXAbq9nzgr
        XCsRh3SEexqwkKdyN36O+LBywg==
X-Google-Smtp-Source: AMsMyM5gG1n7ZLAMQnXnv8BdATvWenNB8iLpH3NHQvYofvyW1U2/aJiVSjqNGF0eZSp0nD2P81n8GQ==
X-Received: by 2002:a17:90a:bb94:b0:209:618f:46ac with SMTP id v20-20020a17090abb9400b00209618f46acmr21913383pjr.240.1665816320971;
        Fri, 14 Oct 2022 23:45:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b0017f7628cbddsm2682023plb.30.2022.10.14.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 23:45:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] tty: Allow TIOCSTI to be disabled
Date:   Fri, 14 Oct 2022 23:45:15 -0700
Message-Id: <20221015064517.1554119-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015064222.gonna.435-kees@kernel.org>
References: <20221015064222.gonna.435-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3580; h=from:subject; bh=kjqVbumXKmpYQu5g+0jngSz3qjLAeN7VzRJkUWWFCAo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSlb7Te+AzPWEJwitcFI9OGMy97KUI9l2gFWD3tbS B0aN6f2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0pW+wAKCRCJcvTf3G3AJqm+D/ kBsaao5QXORYsXZ6tMoSk1qbF2cqCrh4sImxv9FzAPjhnD1er1Ff438V7Q0KYFh/q83pWtJRotFGBT QU8ZtVKPrtdOlQ+pn7+NbyXorwitwyyC9BCNdrU5ucbAo8xVCWgevYXYTpLrLG9nTOgYphzO2peCIS d7GU50JzErxaXhemK9uQdK2QS8H0XfcUV3rLbcyMD9JSMvI9fIv32/Tn8aU4bXR3GKbFAtByiEll6g b0w59cyuup1kESLx4UNX9EFvJQxap3zx1YZbWIu2YUFUC5wGFSeSmYBdGrrMb7sCeCNFueOtlQncBG MnkneyO334jImK70V/H4Ct2t4iEYSfik+z0HBC1qZCqwyuIKZsP8+e/K6E+e62rgzLL0bjuHlyBPhU cgdRAkIqLCZvFsS2uLklsE+28n+m9xBIDMEJ1cvDAHUvgsT/4k9l69yhubmwERLTUSuA6sVP0T7gXV m1rBbwxEG98C4/UYRH11ToRjUS+EwWYpakcqeR3auZgTfNxekmf+AmNH8QILMrNKNp72dFFywBXcVA J8HCKgLlguJLC/nQfI7CEv181xlDUJlQFiBRT1DPZZ62zEEFSAT2b/4qKJYd2RaWdcpiSuXz4Snnel kVmm2rHyemTv0O1Xl3Bu44zVQWAu2ENBcfOBPWpr3BX6IHT3hht7Zj6o3Q1Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSTI continues its long history of being used in privilege escalation
attacks[1]. Prior attempts to provide a mechanism to disable this have
devolved into discussions around creating full-blown LSMs to provide
arbitrary ioctl filtering, which is hugely over-engineered -- only
TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
had historically used TIOCSTI either do not need it, are not commonly
built with it, or have had its use removed.

Provide a simple CONFIG and global sysctl to disable this for the system
builders who have wanted this functionality for literally decades now,
much like the ldisc_autoload CONFIG and sysctl.

[1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
[2] https://undeadly.org/cgi?action=article;sid=20170701132619
[3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Simon Brand <simon.brand@postadigitale.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/Kconfig  | 19 +++++++++++++++++++
 drivers/tty/tty_io.c | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index cc30ff93e2e4..d35fc068da74 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -149,6 +149,25 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
+config LEGACY_TIOCSTI
+	bool "Allow legacy TIOCSTI usage"
+	default y
+	help
+	  Historically the kernel has allowed TIOCSTI, which will push
+	  characters into a controlling TTY. This continues to be used
+	  as a malicious privilege escalation mechanism, and provides no
+	  meaningful real-world utility any more. Its use is considered
+	  a dangerous legacy operation, and can be disabled on most
+	  systems.
+
+	  Say 'Y here only if you have confirmed that your system's
+	  userspace depends on this functionality to continue operating
+	  normally.
+
+	  This functionality can be changed at runtime with the
+	  dev.tty.legacy_tiocsti sysctl. This configuration option sets
+	  the default value of the sysctl.
+
 config LDISC_AUTOLOAD
 	bool "Automatically load TTY Line Disciplines"
 	default y
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index b397b223eada..fa36dac7559e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2275,11 +2275,15 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *  * Called functions take tty_ldiscs_lock
  *  * current->signal->tty check is safe without locks
  */
+static int tty_legacy_tiocsti __read_mostly = IS_BUILTIN(CONFIG_LEGACY_TIOCSTI);
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
 	struct tty_ldisc *ld;
 
+	if (!tty_legacy_tiocsti)
+		return -EIO;
+
 	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (get_user(ch, p))
@@ -3582,6 +3586,15 @@ void console_sysfs_notify(void)
 }
 
 static struct ctl_table tty_table[] = {
+	{
+		.procname	= "legacy_tiocsti",
+		.data		= &tty_legacy_tiocsti,
+		.maxlen		= sizeof(tty_legacy_tiocsti),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "ldisc_autoload",
 		.data		= &tty_ldisc_autoload,
-- 
2.34.1

