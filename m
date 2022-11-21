Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB3631961
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKUFKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKUFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:10:15 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335C2BB00;
        Sun, 20 Nov 2022 21:10:12 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669007410;
        bh=QIeowsk5HLgajMN1xFHSXe66V1zSDio/IapbVc7+FlQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GyAGRJQ8YD4Il+l7lA464JQ3wQMvXZQ3/QAZO7SOwIjTV49NX5SY5azNbAUQmPY7z
         qwcdB6F1bMxvzeDVMlHH7OA0d7/11xZl5YmGp7Zfs9IpCvzUcq3aQ/Dd/sn9wLaK7T
         Yj33hmNCeDuSX3QNAfM3Kr6dyQoDlhCV3eAWvSN0=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] power: process: use explicit levels for printk continuations
Date:   Mon, 21 Nov 2022 06:09:46 +0100
Message-Id: <20221121050946.3540-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669007383; l=2673; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=QIeowsk5HLgajMN1xFHSXe66V1zSDio/IapbVc7+FlQ=; b=F7f6T1eBqzLUPGSTBtC3tKsQxZX8q3PPm0cAKrihOWPyxUq/sjdD4o2Bo9H4DrGgggxayf4xfxf0 53Jh1NqzDEgUPCm31XKCCOYjl1KdzRAFxf14dzA0pKJ6DX1O2k2I
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
 kernel/power/process.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index ddd9988327fe..0a828edc6d30 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -82,7 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
 	elapsed_msecs = ktime_to_ms(elapsed);
 
 	if (todo) {
-		pr_cont("\n");
+		pr_info(KERN_CONT "\n");
 		pr_err("Freezing of tasks %s after %d.%03d seconds "
 		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
 		       wakeup ? "aborted" : "failed",
@@ -101,7 +101,7 @@ static int try_to_freeze_tasks(bool user_only)
 			read_unlock(&tasklist_lock);
 		}
 	} else {
-		pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
+		pr_info(KERN_CONT "(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
 			elapsed_msecs % 1000);
 	}
 
@@ -135,9 +135,9 @@ int freeze_processes(void)
 	error = try_to_freeze_tasks(true);
 	if (!error) {
 		__usermodehelper_set_disable_depth(UMH_DISABLED);
-		pr_cont("done.");
+		pr_info(KERN_CONT "done.");
 	}
-	pr_cont("\n");
+	pr_info(KERN_CONT "\n");
 	BUG_ON(in_atomic());
 
 	/*
@@ -171,9 +171,9 @@ int freeze_kernel_threads(void)
 	pm_nosig_freezing = true;
 	error = try_to_freeze_tasks(false);
 	if (!error)
-		pr_cont("done.");
+		pr_info(KERN_CONT "done.");
 
-	pr_cont("\n");
+	pr_info(KERN_CONT "\n");
 	BUG_ON(in_atomic());
 
 	if (error)
@@ -215,7 +215,7 @@ void thaw_processes(void)
 	usermodehelper_enable();
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info(KERN_CONT "done.\n");
 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
 }
 
@@ -236,5 +236,5 @@ void thaw_kernel_threads(void)
 	read_unlock(&tasklist_lock);
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info(KERN_CONT "done.\n");
 }

base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.38.1

