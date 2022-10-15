Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D405FF8DF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJOGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJOGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 02:45:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455D32DBD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 23:45:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 70so6771603pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSLPR2Q4l9Xvh6e71iA4cwlDfkgBH0aV6+SZhDEbGFs=;
        b=dwxr+rizvsCajPUg1FYGSSAlaOxvHhsLNMiLhL1YhQiocWXTkUyp2RR5ME69D8IwpK
         GgFoZeP6uOfBwEzXZe6/VQQvns/13YrVySY8yV2K9144ynekR5mP+VhaxxVEDwB9T/BG
         jWoDHoneUwcvxurOezRn2qKFyAcB3RzTpYq1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSLPR2Q4l9Xvh6e71iA4cwlDfkgBH0aV6+SZhDEbGFs=;
        b=qv5xhNjjQ+MAdwonZ8gLsmjdWC+d+zdKtQFVsMbaT+q9hceLfUj2xPzYTlrPbL0vVi
         HlSGD0/vSfEqqMDEBvAa6rW8RwrIobF84aaGr01MzDuHx6H5Slfh9cLtYUqdOTn1Dgdw
         Oy3i7XQOgSXpQnBwO4iBj7dxrjlwlz/k3oxeFTMzW6GgZHPDQ7cTjBH2M+oquCa6BF4R
         NysB7xPKho9/tVmflISlYGb3LidalmjkIbkLer1Ycbr8tOVigLCUafAni7dU5ii60p+5
         wax+B3TYty5ckhlrY1KV2wVj+UfietfU1jjjDfGEmdwaD4kNH14XiVVoPEIGVjsSFp5d
         w4ew==
X-Gm-Message-State: ACrzQf1uN1n5xDMxokQddFHQuGZHrmz5nr+7K4/X1c0lUhK+KWCTHPmb
        WsmzIVoRfwRBACLr2Km0WDWcHQ==
X-Google-Smtp-Source: AMsMyM7T2BIK7aEqnP0Sa3vAp9nexgL6yHja3MNMBjS6XTb90jz+bJ+/D75kzBr1GXMRVCXTC/JCKg==
X-Received: by 2002:a17:902:ef96:b0:17e:e7f3:31db with SMTP id iz22-20020a170902ef9600b0017ee7f331dbmr1623980plb.127.1665816320247;
        Fri, 14 Oct 2022 23:45:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r15-20020aa79ecf000000b00535da15a252sm2812330pfq.165.2022.10.14.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 23:45:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] tty: Move sysctl setup into "core" tty logic
Date:   Fri, 14 Oct 2022 23:45:14 -0700
Message-Id: <20221015064517.1554119-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015064222.gonna.435-kees@kernel.org>
References: <20221015064222.gonna.435-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3545; h=from:subject; bh=oqWbZtlJ6MGMIx/LzLNuza7GPjxoRoljDcfXy+Qysx0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSlb78J/G0sNEqputLzoIxc98iGUESR4bTk2mDnBl 2g3lP7SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0pW+wAKCRCJcvTf3G3AJvpRD/ wNuVfbYOhzxajn6a+L8PoDw0j4FHzHO5FKyd1IsEmu6oovuSJGDx/cw+9fRNF5uCtgTmxH9TQ/Dg2E m37YpYODcnit5gvfp719aBe/hm5wqnybXIUMJTiyNtI/2AuUjL11+3nKuHw/Ox0fjs8B44eCgnFeZF SXFBS6Vh1Jq9ogSDYxA4rGs5Yhs3YvCpRiqxkdYjXF8oYYeIV99SuUH9n/y7rM5QwIhILZLOu/UyHt 2vGmd9SxyDnN0nnkzTzi5UHL5sY4HwkZl+2Rh+Cm0bOczkXarxMGQ/yOILWvglh7DtbiaD89wTkvRd DRssyCyK/K5oL0krUgFsIvpn6h6NAlxb0VS/OiOEF7ZLwUtf0Odn/3qd6qq1HugL6jOFcEA+VcPMaO HbZXuaRp/ptxMKjN6Qnl3x8tj5VaEEc2NHFPFJUZUoW5gB7s4j6USXgR8Fl11ocDMYv2Q91p+afuUG VchRcIVAuvwhFtXW9cXkSaBVcV4GSqTGqB5xXjs1d4dsxRfbCyZUUO4coCJygbtDAqSfUtfjMYMaBq XunqNNriNSl5gxfv+vGfYS6BtBfRfek47qHklGpRA3plBy9wJVm6OQS/rgVac/MbRapzEj5r0H2WJb 0UOpUL+QVDV7tyYzKMDQW1Y+JlNeCJ7nLU35KuofeF8JYSrUHdOWCZjlRQ3Q==
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

In preparation for adding another sysctl to the tty subsystem, move the
tty setup code into the "core" tty code, which contains tty_init() itself.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/tty.h       |  2 +-
 drivers/tty/tty_io.c    | 34 ++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ldisc.c | 38 +-------------------------------------
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f310a8274df1..b1f22259ed4c 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -93,7 +93,7 @@ void tty_ldisc_release(struct tty_struct *tty);
 int __must_check tty_ldisc_init(struct tty_struct *tty);
 void tty_ldisc_deinit(struct tty_struct *tty);
 
-void tty_sysctl_init(void);
+extern int tty_ldisc_autoload;
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 82a8855981f7..b397b223eada 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3581,13 +3581,44 @@ void console_sysfs_notify(void)
 		sysfs_notify(&consdev->kobj, NULL, "active");
 }
 
+static struct ctl_table tty_table[] = {
+	{
+		.procname	= "ldisc_autoload",
+		.data		= &tty_ldisc_autoload,
+		.maxlen		= sizeof(tty_ldisc_autoload),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static struct ctl_table tty_dir_table[] = {
+	{
+		.procname	= "tty",
+		.mode		= 0555,
+		.child		= tty_table,
+	},
+	{ }
+};
+
+static struct ctl_table tty_root_table[] = {
+	{
+		.procname	= "dev",
+		.mode		= 0555,
+		.child		= tty_dir_table,
+	},
+	{ }
+};
+
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
 int __init tty_init(void)
 {
-	tty_sysctl_init();
+	register_sysctl_table(tty_root_table);
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
@@ -3609,4 +3640,3 @@ int __init tty_init(void)
 #endif
 	return 0;
 }
-
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 776d8a62f77c..e758f44729e7 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -117,7 +117,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 }
 
-static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
+int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
 
 /**
  * tty_ldisc_get	-	take a reference to an ldisc
@@ -817,39 +817,3 @@ void tty_ldisc_deinit(struct tty_struct *tty)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
 }
-
-static struct ctl_table tty_table[] = {
-	{
-		.procname	= "ldisc_autoload",
-		.data		= &tty_ldisc_autoload,
-		.maxlen		= sizeof(tty_ldisc_autoload),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{ }
-};
-
-static struct ctl_table tty_dir_table[] = {
-	{
-		.procname	= "tty",
-		.mode		= 0555,
-		.child		= tty_table,
-	},
-	{ }
-};
-
-static struct ctl_table tty_root_table[] = {
-	{
-		.procname	= "dev",
-		.mode		= 0555,
-		.child		= tty_dir_table,
-	},
-	{ }
-};
-
-void tty_sysctl_init(void)
-{
-	register_sysctl_table(tty_root_table);
-}
-- 
2.34.1

