Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D07292FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbjFII0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240936AbjFIIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B7449E;
        Fri,  9 Jun 2023 01:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFC861A9F;
        Fri,  9 Jun 2023 08:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873CDC433EF;
        Fri,  9 Jun 2023 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298970;
        bh=YfV8/z3WHCv2jJSuGJ6eoccOlItaMltntTC7qqebuJw=;
        h=From:To:Cc:Subject:Date:From;
        b=G+Z41XrlwK4FyJ9E2F7IiEaz0Eafix+n3pMMFai90Rijdrba0bWhWiKLe6D+DswIn
         53PMMvpRMBvGU2MBn33haQn55SSHaBcd0SMHaoYQ5FrSPkb+VJ9/UZTbqWTLjeZF/u
         10nrCu+IIVYwCCiIlkVWoi/80haQy+PhrTkESAzMszmCNy9jj/RlCMblbMynipzcUe
         4O3PHsP1lRXKqfKlcMZgWGZhqAz+Q4hKMEnqMjIUCv+SOAqzhGU8ZPjcLyhOT6KjD3
         iPWobq27+DRMCOlT6ZLiC75FiEh2p7GehCpaP74DU8fmd6fDZb8WU83Y2n2lkpRgrs
         Z7kAhKuYDrfJw==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1q7XOR-00FP6S-0a;
        Fri, 09 Jun 2023 09:22:47 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"
Date:   Fri,  9 Jun 2023 09:22:38 +0100
Message-Id: <20230609082238.3671398-1-mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Thomas Voegtle <tv@lio96.de>, sometimes a DVB card does
not initialize properly booting Linux 6.4-rc4. This is not always, maybe
in 3 out of 4 attempts.

After double-checking, the root cause seems to be related to the
UAF fix, which is causing a race issue:

[   26.332149] tda10071 7-0005: found a 'NXP TDA10071' in cold state, will try to load a firmware
[   26.340779] tda10071 7-0005: downloading firmware from file 'dvb-fe-tda10071.fw'
[  989.277402] INFO: task vdr:743 blocked for more than 491 seconds.
[  989.283504]       Not tainted 6.4.0-rc5-i5 #249
[  989.288036] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.295860] task:vdr             state:D stack:0     pid:743   ppid:711    flags:0x00004002
[  989.295865] Call Trace:
[  989.295867]  <TASK>
[  989.295869]  __schedule+0x2ea/0x12d0
[  989.295877]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  989.295881]  schedule+0x57/0xc0
[  989.295884]  schedule_preempt_disabled+0xc/0x20
[  989.295887]  __mutex_lock.isra.16+0x237/0x480
[  989.295891]  ? dvb_get_property.isra.10+0x1bc/0xa50
[  989.295898]  ? dvb_frontend_stop+0x36/0x180
[  989.338777]  dvb_frontend_stop+0x36/0x180
[  989.338781]  dvb_frontend_open+0x2f1/0x470
[  989.338784]  dvb_device_open+0x81/0xf0
[  989.338804]  ? exact_lock+0x20/0x20
[  989.338808]  chrdev_open+0x7f/0x1c0
[  989.338811]  ? generic_permission+0x1a2/0x230
[  989.338813]  ? link_path_walk.part.63+0x340/0x380
[  989.338815]  ? exact_lock+0x20/0x20
[  989.338817]  do_dentry_open+0x18e/0x450
[  989.374030]  path_openat+0xca5/0xe00
[  989.374031]  ? terminate_walk+0xec/0x100
[  989.374034]  ? path_lookupat+0x93/0x140
[  989.374036]  do_filp_open+0xc0/0x140
[  989.374038]  ? __call_rcu_common.constprop.91+0x92/0x240
[  989.374041]  ? __check_object_size+0x147/0x260
[  989.374043]  ? __check_object_size+0x147/0x260
[  989.374045]  ? alloc_fd+0xbb/0x180
[  989.374048]  ? do_sys_openat2+0x243/0x310
[  989.374050]  do_sys_openat2+0x243/0x310
[  989.374052]  do_sys_open+0x52/0x80
[  989.374055]  do_syscall_64+0x5b/0x80
[  989.421335]  ? __task_pid_nr_ns+0x92/0xa0
[  989.421337]  ? syscall_exit_to_user_mode+0x20/0x40
[  989.421339]  ? do_syscall_64+0x67/0x80
[  989.421341]  ? syscall_exit_to_user_mode+0x20/0x40
[  989.421343]  ? do_syscall_64+0x67/0x80
[  989.421345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  989.421348] RIP: 0033:0x7fe895d067e3
[  989.421349] RSP: 002b:00007fff933c2ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[  989.421351] RAX: ffffffffffffffda RBX: 00007fff933c2c10 RCX: 00007fe895d067e3
[  989.421352] RDX: 0000000000000802 RSI: 00005594acdce160 RDI: 00000000ffffff9c
[  989.421353] RBP: 0000000000000802 R08: 0000000000000000 R09: 0000000000000000
[  989.421353] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
[  989.421354] R13: 00007fff933c2ca0 R14: 00000000ffffffff R15: 00007fff933c2c90
[  989.421355]  </TASK>

This reverts commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 53 +++++----------------------
 include/media/dvb_frontend.h          |  6 +--
 2 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index bc6950a5740f..9293b058ab99 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -817,26 +817,15 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
-	mutex_lock(&fe->remove_mutex);
-
 	if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
 
-	if (!fepriv->thread) {
-		mutex_unlock(&fe->remove_mutex);
+	if (!fepriv->thread)
 		return;
-	}
 
 	kthread_stop(fepriv->thread);
 
-	mutex_unlock(&fe->remove_mutex);
-
-	if (fepriv->dvbdev->users < -1) {
-		wait_event(fepriv->dvbdev->wait_queue,
-			   fepriv->dvbdev->users == -1);
-	}
-
 	sema_init(&fepriv->sem, 1);
 	fepriv->state = FESTATE_IDLE;
 
@@ -2780,13 +2769,9 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	struct dvb_adapter *adapter = fe->dvb;
 	int ret;
 
-	mutex_lock(&fe->remove_mutex);
-
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
-	if (fe->exit == DVB_FE_DEVICE_REMOVED) {
-		ret = -ENODEV;
-		goto err_remove_mutex;
-	}
+	if (fe->exit == DVB_FE_DEVICE_REMOVED)
+		return -ENODEV;
 
 	if (adapter->mfe_shared == 2) {
 		mutex_lock(&adapter->mfe_lock);
@@ -2794,8 +2779,7 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			if (adapter->mfe_dvbdev &&
 			    !adapter->mfe_dvbdev->writers) {
 				mutex_unlock(&adapter->mfe_lock);
-				ret = -EBUSY;
-				goto err_remove_mutex;
+				return -EBUSY;
 			}
 			adapter->mfe_dvbdev = dvbdev;
 		}
@@ -2818,10 +2802,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			while (mferetry-- && (mfedev->users != -1 ||
 					      mfepriv->thread)) {
 				if (msleep_interruptible(500)) {
-					if (signal_pending(current)) {
-						ret = -EINTR;
-						goto err_remove_mutex;
-					}
+					if (signal_pending(current))
+						return -EINTR;
 				}
 			}
 
@@ -2833,8 +2815,7 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				if (mfedev->users != -1 ||
 				    mfepriv->thread) {
 					mutex_unlock(&adapter->mfe_lock);
-					ret = -EBUSY;
-					goto err_remove_mutex;
+					return -EBUSY;
 				}
 				adapter->mfe_dvbdev = dvbdev;
 			}
@@ -2893,8 +2874,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
-
-	mutex_unlock(&fe->remove_mutex);
 	return ret;
 
 err3:
@@ -2916,9 +2895,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err0:
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
-
-err_remove_mutex:
-	mutex_unlock(&fe->remove_mutex);
 	return ret;
 }
 
@@ -2929,8 +2905,6 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int ret;
 
-	mutex_lock(&fe->remove_mutex);
-
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
@@ -2952,18 +2926,10 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		}
 		mutex_unlock(&fe->dvb->mdev_lock);
 #endif
+		if (fe->exit != DVB_FE_NO_EXIT)
+			wake_up(&dvbdev->wait_queue);
 		if (fe->ops.ts_bus_ctrl)
 			fe->ops.ts_bus_ctrl(fe, 0);
-
-		if (fe->exit != DVB_FE_NO_EXIT) {
-			mutex_unlock(&fe->remove_mutex);
-			wake_up(&dvbdev->wait_queue);
-		} else {
-			mutex_unlock(&fe->remove_mutex);
-		}
-
-	} else {
-		mutex_unlock(&fe->remove_mutex);
 	}
 
 	dvb_frontend_put(fe);
@@ -3064,7 +3030,6 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	fepriv = fe->frontend_priv;
 
 	kref_init(&fe->refcount);
-	mutex_init(&fe->remove_mutex);
 
 	/*
 	 * After initialization, there need to be two references: one
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index 367d5381217b..e7c44870f20d 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -686,10 +686,7 @@ struct dtv_frontend_properties {
  * @id:			Frontend ID
  * @exit:		Used to inform the DVB core that the frontend
  *			thread should exit (usually, means that the hardware
- *			got disconnected).
- * @remove_mutex:	mutex that avoids a race condition between a callback
- *			called when the hardware is disconnected and the
- *			file_operations of dvb_frontend.
+ *			got disconnected.
  */
 
 struct dvb_frontend {
@@ -707,7 +704,6 @@ struct dvb_frontend {
 	int (*callback)(void *adapter_priv, int component, int cmd, int arg);
 	int id;
 	unsigned int exit;
-	struct mutex remove_mutex;
 };
 
 /**
-- 
2.40.1

