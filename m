Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731F608EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJVSaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJVS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:29:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005245998
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:29:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ez6so5062330pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHhvxulLghF+vBS1CMcuNS4a1S3LavBD3tiqXSCICpE=;
        b=AafR3/M+ug0+nvsEqQpBtXxnG8Fx6fJvb/F5VyxLfeKxTkcaQRxNy9widlva+POEd2
         l69QoIeWbB9nX1uzjqJXWpYutRLXsbUxyzlWQ9SE9mF4hCanBut+nLIWrs2L5zhasmVH
         56Rz4NuzJPs89s7gTDjFKxKTXCwnmz2nVjAns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHhvxulLghF+vBS1CMcuNS4a1S3LavBD3tiqXSCICpE=;
        b=frrPnyEsVbZELMCp4TdpYdY87th+R2HZCJI8IMMKaR6HnjkCXbw1MMxVjNO34wcI1s
         sNZ9qwoNtqQ6O6oLlg1T8/oFpmUASpbxYjBqb2m73bmVLFHnMoWixQF0WjnXqypd5dRm
         QReDIZEtkRUzG0akNzBm8Bqvf+gp6uybYQXDZphul7mZmbVxgbr5NKqGNcXbmSlUqH6M
         U2Gi+PF+zmnqCHJp8MLG2PAGOQ3D8h2TPkrthjlriBGyJrK15sXEqmrPW3rFPHZMZfIq
         dHTqQNy1MmtRfn0U/uUA1YZUfgbVNVps+xgZWGNxICi+4i0wRvm+wNTaD6hUEccjQqdg
         9ssg==
X-Gm-Message-State: ACrzQf3JC3POZX6njDV8SZUGTYMug4dhuTu+k91Qwp3i4BRCgXinzAdf
        9vtnhkLyl3WVwcU1ueeMdJhezKuoDHg3lg==
X-Google-Smtp-Source: AMsMyM77bUlNqCeWOt/w09z1nhThIFKbIhxtQytvJhsUBig7bRTueopUQti5/Gsbn/S+Ctot3glaWw==
X-Received: by 2002:a17:90b:2812:b0:20d:7a3b:df3e with SMTP id qb18-20020a17090b281200b0020d7a3bdf3emr65327223pjb.169.1666463392500;
        Sat, 22 Oct 2022 11:29:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b0017bb38e4591sm3822240pll.41.2022.10.22.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:29:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Date:   Sat, 22 Oct 2022 11:29:49 -0700
Message-Id: <20221022182949.2684794-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022182828.give.717-kees@kernel.org>
References: <20221022182828.give.717-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; h=from:subject; bh=JIl7HOU/ElX414nbe5g4/ExXJarRYqkuhmz9GGmO2pw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVDaccwzraGBf+oCRGY9wtTvemKlYckYVJh940e1k Fpe8K/iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1Q2nAAKCRCJcvTf3G3AJlydD/ 9ekv6HRzYt9CJtEJ2xHytL/yPSnjzvfeUNKwGzahN6kuwiLRtM8fFfjsYMFnCKRIjyDd05VpYo28fY IyRz3jvMIMaS2vF8CGekYplbhzbpMtyIsi2nu5v2FIufVHyBzgQ6PsIYKh8oFa70JW9LBKTrnb/Ilv nFZfLtKgnG581LreZy4D63ejpIyAsisGZHMs510EVFWTLsLw/eh5v3WDcLPoP+9/zzfpvrmyQJFkv0 2TNHyeF2C0Rn+I4nueCzQyHuzzmg/dmQNicIgtbKLCSJ1582jlZbfNFfYBH5XQj2jhYhqpZ7au1yMl qWLOYI1K9WxMmakKwtpaCsE0VTntNY7JA8YrBHsrmhVe0j0AdD9HQ/Hwf72JgyMbK7t1nEKsXVWx2w fSdsSQjM7XW0ihcQ2Z7PuZjTtB4JTUsuG10LvtUE6vq9Ad6L0x0nMkwI9A2VkmaPxcpGKODWiwavnC FoMGr0xMiozIJz7bHSxs3nwwVZp9ccJj8l5dmQvCtVjOwK10atr5jOkVInCt4/CNG+S30N1pjnbld5 NUdV8irF2YG8OZxEh9Emd9n2milDAsAWev/KYSlj1VWGmGvDDlzbUZ2OcyLW/UzImWF0gdldy9iTQy AQ0TPHVKpK8hVPqZerX5gj4B/N3uYfObMlEz9N+8sZk5BbRIp78ZXxx0yGKg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/tty/tty_io.c | 11 +++++++++++
 2 files changed, 30 insertions(+)

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
index fe77a3d41326..a6a16cf986b7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2268,11 +2268,15 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *  * Called functions take tty_ldiscs_lock
  *  * current->signal->tty check is safe without locks
  */
+static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI);
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
@@ -3573,6 +3577,13 @@ void console_sysfs_notify(void)
 }
 
 static struct ctl_table tty_table[] = {
+	{
+		.procname	= "legacy_tiocsti",
+		.data		= &tty_legacy_tiocsti,
+		.maxlen		= sizeof(tty_legacy_tiocsti),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
 	{
 		.procname	= "ldisc_autoload",
 		.data		= &tty_ldisc_autoload,
-- 
2.34.1

