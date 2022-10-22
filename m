Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8156608EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJVS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJVS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:29:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740BF40039
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:29:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f9so919638pgj.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhK+n74IwfoEYJVpbYYVgx8zMlbePkYd2jvvQVl1DNI=;
        b=S24Vm63cnb/pQmXYC/Ji63qErM6N77P6FtUKv7pvhBPH9G2MNErakkWEYF4lZkUjPK
         afrGZX5qWhYQMm0S7qGGO3J7KvVYD0wYfO9ZN48fYvf6rdOnHxhfMsgAgMN1q7TS8VVV
         TP9HD40o8yDBNqSFof/ACZ0yRJUF5TWBEEVEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhK+n74IwfoEYJVpbYYVgx8zMlbePkYd2jvvQVl1DNI=;
        b=6V5fSWkQil3I1oz5QN5MEJqNgSQCBJpFx+QoRgLi6ivzFQ1punfo6D+Je6sOaQi8v6
         bVuxOF2opJ1klLesTXKKDyj9prtC8iL5WHABCiRHYGo0kNM72mjzgQwTr+saM/VPuP13
         +XkrCO1l7U5sH/Yg5fGh2M6hZQy8h61lFJZiiPLvFUrdkj4KtkZ1xY1Ycpf3YGBT73oF
         ZzSQ0k8CaBSUizWii2bL4Mv93rqYMeEG1uETZG7QbN7PWy9coRQQC2tCdH3U0d9dvij3
         dYKPM2Y4Xhy0gWtOf/uhbmyrvTHvVuyWmjlRXn9etXmZwVQfEgSxvmJDNGQ9HqaZPXAm
         DUYA==
X-Gm-Message-State: ACrzQf0NQgz4x3cblCzqoPW2LKrEVHXjkGJPlZvo7tYTJxwKbZTao+WK
        SekPPbBjK90MJnXDUUJh5z1k/Q==
X-Google-Smtp-Source: AMsMyM4uvRb7t66BcaoZTcBtmGv4XGRHd4gPsGXjh2vTSaHbYHsQ00QsQt+mWBhgTyvrBoBiY+7+WA==
X-Received: by 2002:a05:6a00:21ce:b0:569:9dc2:a6c7 with SMTP id t14-20020a056a0021ce00b005699dc2a6c7mr12205646pfj.38.1666463391890;
        Sat, 22 Oct 2022 11:29:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001788ccecbf5sm17117951plf.31.2022.10.22.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:29:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/2] tty: Move sysctl setup into "core" tty logic
Date:   Sat, 22 Oct 2022 11:29:48 -0700
Message-Id: <20221022182949.2684794-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022182828.give.717-kees@kernel.org>
References: <20221022182828.give.717-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3545; h=from:subject; bh=Nyuo2IvupAQIigzsfxaAoDN3LMdaMzP0RYaZjpUzMxE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVDac8Ddo6K7F5HHzJjCDjWjPgrobDOvuScnUkqg3 YkeqaLSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1Q2nAAKCRCJcvTf3G3AJkdwD/ 4rcSf2MSyYi0KOsvmUZvR/2jPe8raIT9H7agWXL6ThO/s75kx/SSFKDBhGBbsDRq7HK4Trla4qCCeR yyU71/X2FDErb6ika6NGdmD7ew5SAYke3TWP8VHWZvz3F/iSEY+lJB5vKl5jitIbyVinP9IHM0BfAA VvUSjntsswdXvEBRTHPihaijb/SSkGtC8VHT43fnOmowYi0WJIchQUAaivkexO9N3rchAKveGQO/+k wzjVTZ9mp+kUNm/KbK5scDpPYHm6enZM43NhkzEYlaRpYYm9hRRJxgg44pCLbQl/fMnK3Y1nZ+NKHX aMrm0X//dDKsyU4vYSD1ZKRkFzZRLdfeDZLDBMMhn5SFv1u+ShuguGtvu3SwsXcf2q4MLTJBJgr/GD Yxs1aPnYaex2Xb+wAKN22VRcK9FrFPVTX6GGSNpcDbSHq6eOdoaYKDkBGDNAIl/uvDucrzqFgPcgoU P4PzbRur4uA+UrO8FeOB9mr17gZofZB+USuNjOKM5wYoIjyKdD9dkwZRflmhZlRmRAop+3PvVhb3iC C1z4TrBwaOeSp4BUenQ5boYBpKZgES1iMJzN9RWL7OsH3N7YyTbsxdSLgInoWK2ocsYhyLAWGnQ2l2 x/7tro215lOVgCOUU+jhVRcwDEZjAQKub/j3MYB66XMAguVP/Ybj8bBlJqjQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 1c08c9b67b16..f45cd683c02e 100644
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
index de06c3c2ff70..fe77a3d41326 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3572,13 +3572,44 @@ void console_sysfs_notify(void)
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
@@ -3600,4 +3631,3 @@ int __init tty_init(void)
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

