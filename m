Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A105FF86A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 06:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJOEQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 00:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 00:16:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7716A497
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so6430807pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zhd+IrU4jdtHIjl5cwKXHkAtq/ao6g5qBaiCZACrNE=;
        b=eKzl19ovq5OG+t8XnvGfWR1OvcArXyvG9mkw0CKMUwYYVjX691mO+wrpOo+zkwmmTR
         Jj8vKsc46HvtvWOQyzHPRc3V68Z6fjecVH0KshVGn3l8ArzRAovZJDBl4zHu8GY4jtQ8
         A4uLljfGvnTtw1ZJT1XKaP8JOvK7U8GggE9eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zhd+IrU4jdtHIjl5cwKXHkAtq/ao6g5qBaiCZACrNE=;
        b=zupawbWxKVwCsyK75z4nMIeaZkPQsC5JBMVufSJXfTrEYg32cN8iTqfHplw/oHfD/h
         KveQITlWkNDtGBgfKe4wTTxh87zGNqW82g6MW17uBFiKysN+NrJRNV7QBF9Vd9go3W3O
         bxmzI7Cv/OVlDxKVitV0bYziCe+3dP0pIOPu68Kgsu7uTtGUoLzMafW3uxQT86apexTt
         GsxgFZeOTUEu5Ef5nN8HBVhexPuBZ2ONN2Kd+n0PnSR3ybtad6vCxezuFjtHCwwjn3p2
         7Rbm6AgyToos6xBI6S5aE6Ccg5k8Fc+SVa84/PRE+bjMdgbj49Ra5GsH6nQNsR+o27Dm
         TH4A==
X-Gm-Message-State: ACrzQf3i5HvFCdLECJB8klLqZO03W4qMoU3EqscLAKm1xFjKB7WQztHF
        W8PJ5ErWM18FGkrSxhDjscEQHw==
X-Google-Smtp-Source: AMsMyM4RA0/+xXyzB7ntwgC1whlwlVKc36cked5j5EoDP9EUDD80ayXiBpWbUeD0aFFoU+5ZEnRwOg==
X-Received: by 2002:a17:902:8205:b0:185:33e:2a0e with SMTP id x5-20020a170902820500b00185033e2a0emr1146421pln.92.1665807389274;
        Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b00176be23bbb3sm2421738plb.172.2022.10.14.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:16:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] tty: Move sysctl setup into "core" tty logic
Date:   Fri, 14 Oct 2022 21:16:23 -0700
Message-Id: <20221015041626.1467372-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015041352.never.966-kees@kernel.org>
References: <20221015041352.never.966-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538; h=from:subject; bh=UfHWy9+3SRLAJXHVd4eYVy04EbNnVYsHoiv7mjWvzd0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSjQY8BlG6QlYL+LP5sq2Ex0rIi4OkDlCnsJriKUh vYr86t6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0o0GAAKCRCJcvTf3G3AJnMZD/ 4ywyAmxaAppPe90zfX9UHpj/BtWNCK2vBmpwT5/+vq5qGOnOwB82XyKnY+IpBe76u6jrPBvs48s0mS jm1fuCT/vDpeOkN+HvLC/aNUGuEGf4YYr6AcbvZYi46q2pCajEQKGcOAlUtvXk7mVNjpdb7w9sb/R0 h9Yzxb4YKmMLFVeTA5oMq8BpMVyg/wXcpvCgnYudyz98y0NyMKSrS2JaMy62t4lY8VEBUFypHddd0L 4qqQfD9LSEx7fLR/o4K2zHkJFojDUriV8ZIlmTlNl4qIfU3DRbY1VBMa+Ng2sAzzn93SgPgDXgoFuH US9tSvBqxvUtscehs3TFIsmbuBtzEVA5PhET/4BkqUNfGSEzmc3AmX1bxCbYhukNoXbc/1zfnqjZzc Q+OGWNQg7ml4Zd+FvEupwNNUUISQyvi2roENwKQtf+Ipiu1Po7TE5ZLwbDK2stc98MyD+EHplAU2vk 5hvvx+WMGtlzLPA78hhfA8dmnTrKaOlnKbTQ2ONR5K86b+H52b2XJ3x05Qy2zAkHTVxyoZ6P/ZMj+x 8xtcqSOOz1BzZfXcUSWBlV0Es/LFzEe6w2fcM52x+F/6zNOrvbFL2z6pe+ZnvJ1Q/6vGnKBTI6BB47 3gPxAFKWcW/wnczv+KwY9VpIrrjlcHZPippJkcACFos8zwJUmRc/3iqzbGzw==
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
index f310a8274df1..4938ed3a44a5 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -93,7 +93,7 @@ void tty_ldisc_release(struct tty_struct *tty);
 int __must_check tty_ldisc_init(struct tty_struct *tty);
 void tty_ldisc_deinit(struct tty_struct *tty);
 
-void tty_sysctl_init(void);
+int tty_ldisc_autoload;
 
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

