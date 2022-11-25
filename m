Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8886163902E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKYTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKYTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:10:15 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C92255C9C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:10:12 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669403409;
        bh=s6KcxTNSDlbspLXYkAwhQ7ixHOFLXXeH4opgjulE3Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpSyhfLLpJafJPxciAM1hvxxl3WMxPo3EpdLtlKqczTp/ZZ0/Ekc9ZqON3/B86Gbe
         aIsyj0Z9IOpA940sugiPplWBhAHkXPkTGuHAQHt51PmcxiKrGBH21aHRQRpH7jrnXH
         L8p0AJFOS8GOTMPD/yB2WECXSNAdqbQ4bgSinlKk=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 3/3] power: process: use explicit levels for printk continuations
Date:   Fri, 25 Nov 2022 20:09:48 +0100
Message-Id: <20221125190948.2062-4-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125190948.2062-1-linux@weissschuh.net>
References: <20221125190948.2062-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669403373; l=2640; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=s6KcxTNSDlbspLXYkAwhQ7ixHOFLXXeH4opgjulE3Dk=; b=GkGBljbJ6DHMkREQP115g4j9iS5KQRe8ZSb8HRM6GJfL3NuL56f01HHVCLvxCka9QRIwmeEyQw7O fnNTXMAsBF9mGgmkSiAuSl04zDZTLsQxO5eLurZ64NmjKYbyBHjg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the printk messages emitted during suspend and resume are
emitted in fragments using pr_cont()/KERN_CONT.

As during suspend and resume a lot of operations are happing in the
kernel the chances are high that the fragments are interspersed with
unrelated messages.

In this case if no explicit level is specified for the fragments the
standard level is applied, which by default is KERN_WARNING.

If the user is only observing KERN_WARNING and *not* KERN_INFO messages
they will see incomplete message fragments.

By specifing the correct printk level also with the continuations this
mismatch can be avoided.
Also it reduces the amount of false-positive KERN_WARNING messages.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/power/process.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index ddd9988327fe..698a823033e4 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -82,7 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
 	elapsed_msecs = ktime_to_ms(elapsed);
 
 	if (todo) {
-		pr_cont("\n");
+		pr_info_cont("\n");
 		pr_err("Freezing of tasks %s after %d.%03d seconds "
 		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
 		       wakeup ? "aborted" : "failed",
@@ -101,8 +101,8 @@ static int try_to_freeze_tasks(bool user_only)
 			read_unlock(&tasklist_lock);
 		}
 	} else {
-		pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
-			elapsed_msecs % 1000);
+		pr_info_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
+			     elapsed_msecs % 1000);
 	}
 
 	return todo ? -EBUSY : 0;
@@ -135,9 +135,9 @@ int freeze_processes(void)
 	error = try_to_freeze_tasks(true);
 	if (!error) {
 		__usermodehelper_set_disable_depth(UMH_DISABLED);
-		pr_cont("done.");
+		pr_info_cont("done.");
 	}
-	pr_cont("\n");
+	pr_info_cont("\n");
 	BUG_ON(in_atomic());
 
 	/*
@@ -171,9 +171,9 @@ int freeze_kernel_threads(void)
 	pm_nosig_freezing = true;
 	error = try_to_freeze_tasks(false);
 	if (!error)
-		pr_cont("done.");
+		pr_info_cont("done.");
 
-	pr_cont("\n");
+	pr_info_cont("\n");
 	BUG_ON(in_atomic());
 
 	if (error)
@@ -215,7 +215,7 @@ void thaw_processes(void)
 	usermodehelper_enable();
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info_cont("done.\n");
 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
 }
 
@@ -236,5 +236,5 @@ void thaw_kernel_threads(void)
 	read_unlock(&tasklist_lock);
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info_cont("done.\n");
 }
-- 
2.38.1

