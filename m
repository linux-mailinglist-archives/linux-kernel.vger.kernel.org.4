Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EAD5FF869
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJOEQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 00:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJOEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 00:16:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D31696F2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p14so6613604pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZHH+G6x30+/1izQi/oxOuO2T5/3nIdMv8v68SVvGTY=;
        b=aDPituHhzFtnk38jDFo7U2mVpu1yKW8iKuh2KxLxBsO4z7tBkl8PBsIjhT0hKbeLuE
         6YwTdk3W2w/+8qJdhSj5UujeuqHfe062tfhZJXqKK4M0qB9KRafuMUvE5lI9cxRiSY93
         4XeydxFTyFhmvzUMp7+gjQdtB8IiCFTTVCOKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZHH+G6x30+/1izQi/oxOuO2T5/3nIdMv8v68SVvGTY=;
        b=tXCYYa3X/K7pk8/H1hmXRH+24VaO26o1JH5bvPAPY//UV2ZtCBAU7XbBVCNC0kNbJo
         v/RwnQqj5ncdr6U1GaBNUE6OPTuBEmZoP7hpYPnjWoXeKWRFWhk4NzRhczkhrtrMF+NI
         mg2V7vRXGWYX4FZs6cm0PJvrxSMmggIRTB7UEmAKA6e/yjZk4uZUu4+MOLABL+Rel7C4
         fz0+YcFPDDpukC/MEafJf3SmDFITYjVtHOsc28vRTykbkRydKYhOeQPAP3qSec37RUTO
         ZTFyis5rLQH8mo0apz/Shrk/BhXQqaEQ8YIT6TFOKL1/F2Wz2K4cfyt1kahzoVwqrzAd
         bPsg==
X-Gm-Message-State: ACrzQf3d8qN/XdqeJu7jCYMaHvgUrEqccjEXFqs2wFM+qpVLykaykP85
        L0U2gtQ/va6kw1d0Yk9759RB0w==
X-Google-Smtp-Source: AMsMyM5yENby/w6DnsM607zqpycxRY+ZNA+6OUdIr5nL4SLgx8vhfsvGtNrE10++QvyngTUbvRpbsg==
X-Received: by 2002:aa7:8895:0:b0:565:e8b7:8494 with SMTP id z21-20020aa78895000000b00565e8b78494mr1273946pfe.82.1665807388938;
        Fri, 14 Oct 2022 21:16:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g20-20020aa796b4000000b00561beff1e09sm2486377pfk.164.2022.10.14.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:16:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] tty: Allow TIOCSTI to be disabled
Date:   Fri, 14 Oct 2022 21:16:24 -0700
Message-Id: <20221015041626.1467372-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015041352.never.966-kees@kernel.org>
References: <20221015041352.never.966-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; h=from:subject; bh=KrYqJjY//fTGi+hxHkKSxhOoF4X4ro3v63esb67QcXE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSjQYOqf4IDT3hGIyRgfciwgCGZXKO9Tqt2gpIa+s ZvVCwMWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0o0GAAKCRCJcvTf3G3AJv3mD/ 9iBDYh+cnm7f+yTDU+sFNRNWREo+3hSR7QgfvS4PSRPQkmMObiiBOPKeOo287WzLuWgMja11TI7UQM MrW9PXxo49EA8GbdeLdlRPY30CM6XnChQYUFNIo/zOMZh4veciVu+NxFsj2A1AT8iC572UfOn2WI+n W5F5Z0b5Y3e2T5Tvm5IJwQ7XwGJcjxVyetgkyc0md+ZfQYjcAlJT6DYzEvLDpi4uwcY0ul7+4P+Hb0 AYy6tANGtC/RfzHoWuZ15r7h9ZYQunBT8mjk0Lf0HaeyxM/83axJNxcQzqRCSFMMwGwJNOXR+w/R8m vlCrPvrk3VTibCp6llt7EjQOuzmzFPCz+jLwuTHPTlu2vO6y0xxicS749Nd4Yib55FIDKhyw2rD/r8 4w9tUYXm3fwKKvcPhjuK2GOEpcW+ekJX1D2joihuBR+60tHrlxjIqqKU3wrVYqFECw6EnPvaAQpR1B qjlivJ0QhKQJYOj4EYw6m0cbDNWUiBms5hC5GJ3Ln5sYGJFk7xBQBw70TNGCK0XzLdtx8BDVMVPvWj /+jqieXkIZlviocmXP46hxFrFGxHPUKGBg7CAuFGFYKJ0X25Y9QEtPattPYf9sJc3oEBXWRiL3T4TU pTbHIcYf9QWiUsx2RaxOz+G7ghXHjRSsWPZZKX/XMta95w50XqPnTSGXJDZQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index b397b223eada..29956c5d7778 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2275,11 +2275,15 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *  * Called functions take tty_ldiscs_lock
  *  * current->signal->tty check is safe without locks
  */
+int tty_legacy_tiocsti __read_mostly = IS_BUILTIN(CONFIG_LEGACY_TIOCSTI);
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

