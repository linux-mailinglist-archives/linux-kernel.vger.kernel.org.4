Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D7F5B329B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiIIJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiIIJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39927DCA;
        Fri,  9 Sep 2022 02:00:29 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yI7dxCqlQROcoGzifv3SioX6jvh+D7Y0tqiFjcLPG/Q=;
        b=ZnSZVtEUiTbLeG40XTFG4Z2sq91b/ujn22kPWOEFgWc0312vVkjIRfNhgsA6nOQW7oLhey
        lbRelDJEfTha5/F673+i0JuEENL7w05Nd96qz/XLM159+kRTNVn7NcdlUYsSDr1aMr9K+f
        ekK8F2ORbvAwqtKsM8MZIFws1lWkxV0b/FcI1hj5IsN5sHn8k0dFp2W+DdnM9SJY7E2PmF
        1adaHetAMz1UTmFmYhyE4vEqIYiqFBGmLZffxIsF7RZ/mAif6JpeGmnHecHniklCMy3+hD
        OXCiaR7rS89u6Fr/jpFUNkN6yjiqMp5gv1Ii50UvPidLFoexA5vX+qMT9iGUZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yI7dxCqlQROcoGzifv3SioX6jvh+D7Y0tqiFjcLPG/Q=;
        b=CQ/Yh3Zu57rkdRh1idLLbzDkfpZhfU4tshwqcfiJ1nR5vZnrJ4JKesiWXd88Py1qReKfps
        b0qrR5HoJfrfFqCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] freezer,umh: Clean up freezer/initrd interaction
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822114648.791019324@infradead.org>
References: <20220822114648.791019324@infradead.org>
MIME-Version: 1.0
Message-ID: <166271402382.401.12830005444429437607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1fbcaa923ce2d7e6de17abd74fa076dc1e0be1a2
Gitweb:        https://git.kernel.org/tip/1fbcaa923ce2d7e6de17abd74fa076dc1e0be1a2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Aug 2022 13:18:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:48 +02:00

freezer,umh: Clean up freezer/initrd interaction

handle_initrd() marks itself as PF_FREEZER_SKIP in order to ensure
that the UMH, which is going to freeze the system, doesn't
indefinitely wait for it's caller.

Rework things by adding UMH_FREEZABLE to indicate the completion is
freezable.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20220822114648.791019324@infradead.org
---
 include/linux/umh.h     |  9 +++++----
 init/do_mounts_initrd.c | 10 +---------
 kernel/umh.c            |  8 ++++++++
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 244aff6..5d1f612 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -11,10 +11,11 @@
 struct cred;
 struct file;
 
-#define UMH_NO_WAIT	0	/* don't wait at all */
-#define UMH_WAIT_EXEC	1	/* wait for the exec, but not the process */
-#define UMH_WAIT_PROC	2	/* wait for the process to complete */
-#define UMH_KILLABLE	4	/* wait for EXEC/PROC killable */
+#define UMH_NO_WAIT	0x00	/* don't wait at all */
+#define UMH_WAIT_EXEC	0x01	/* wait for the exec, but not the process */
+#define UMH_WAIT_PROC	0x02	/* wait for the process to complete */
+#define UMH_KILLABLE	0x04	/* wait for EXEC/PROC killable */
+#define UMH_FREEZABLE	0x08	/* wait for EXEC/PROC freezable */
 
 struct subprocess_info {
 	struct work_struct work;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 327962e..3473124 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -99,19 +99,11 @@ static void __init handle_initrd(void)
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
-	/*
-	 * In case that a resume from disk is carried out by linuxrc or one of
-	 * its children, we need to tell the freezer not to wait for us.
-	 */
-	current->flags |= PF_FREEZER_SKIP;
-
 	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
 	if (!info)
 		return;
-	call_usermodehelper_exec(info, UMH_WAIT_PROC);
-
-	current->flags &= ~PF_FREEZER_SKIP;
+	call_usermodehelper_exec(info, UMH_WAIT_PROC|UMH_FREEZABLE);
 
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
diff --git a/kernel/umh.c b/kernel/umh.c
index b989736..8945eaf 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -28,6 +28,7 @@
 #include <linux/async.h>
 #include <linux/uaccess.h>
 #include <linux/initrd.h>
+#include <linux/freezer.h>
 
 #include <trace/events/module.h>
 
@@ -436,6 +437,9 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
+	if (wait & UMH_FREEZABLE)
+		freezer_do_not_count();
+
 	if (wait & UMH_KILLABLE) {
 		retval = wait_for_completion_killable(&done);
 		if (!retval)
@@ -448,6 +452,10 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	}
 
 	wait_for_completion(&done);
+
+	if (wait & UMH_FREEZABLE)
+		freezer_count();
+
 wait_done:
 	retval = sub_info->retval;
 out:
