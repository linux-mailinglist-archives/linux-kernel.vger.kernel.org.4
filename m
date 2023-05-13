Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EFB7018D7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjEMR6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjEMR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8C2D47;
        Sat, 13 May 2023 10:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A19361C36;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A94CC43442;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=wQLhhjc/nu1gKQyvfutHSjiIwSyWN5kCMhdc5rNzry4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNaozJB/E/zHWbvpcNPvBHIW0aqcrTtLeI37AkOeiH/20A4MsmVtVRXp3WSsBwqn2
         MIrNv2vrL469S3HtuMNcZ+bP3lZrdvVvQxHtQ/TAEVGuEPlRM601PnGW4eZQ87zFx5
         O/ckYQuVjqodt/wo/yhI5we7z3xl78C40I//CM4A1I+pakpZHa6/9Sbn5Bn9PBzbib
         rs26QpXas9fV6/tTTufIMcrp4vZX6FUpV++yNVjeeHBTmPVEXTWxiTsOkbxdWJa0Lv
         cyecYxPd/PMLKpgkbqegbwfF3o8OYQuT8QBm4yGmpKNMTVVF/X6YxOY6W7aS24+7Cq
         A8DTz0ulGkI5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001ty5-1b;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 14/24] media: dvb-core: Fix use-after-free due to race condition occurring in dvb_frontend
Date:   Sat, 13 May 2023 18:57:31 +0100
Message-Id: <de324b9b0fb496e84645d001e10db9451c73e0a2.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunwoo Kim <imv4bel@gmail.com>

If the device node of dvb_frontend is open() and the device is
disconnected, many kinds of UAFs may occur when calling close()
on the device node.

The root cause of this is that wake_up() for dvbdev->wait_queue
is implemented in the dvb_frontend_release() function, but
wait_event() is not implemented in the dvb_frontend_stop() function.

So, implement wait_event() function in dvb_frontend_stop() and
add 'remove_mutex' which prevents race condition for 'fe->exit'.

[mchehab: fix a couple of checkpatch warnings]

Link: https://lore.kernel.org/linux-media/20221117045925.14297-2-imv4bel@gmail.com
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 39 ++++++++++++++++++++++++---
 include/media/dvb_frontend.h          |  6 ++++-
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index cc0a789f09ae..375eb255df9e 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -809,6 +809,8 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
+	mutex_lock(&fe->remove_mutex);
+
 	if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
@@ -818,6 +820,13 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 
 	kthread_stop(fepriv->thread);
 
+	mutex_unlock(&fe->remove_mutex);
+
+	if (fepriv->dvbdev->users < -1) {
+		wait_event(fepriv->dvbdev->wait_queue,
+			   fepriv->dvbdev->users == -1);
+	}
+
 	sema_init(&fepriv->sem, 1);
 	fepriv->state = FESTATE_IDLE;
 
@@ -2761,9 +2770,13 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	struct dvb_adapter *adapter = fe->dvb;
 	int ret;
 
+	mutex_lock(&fe->remove_mutex);
+
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
-	if (fe->exit == DVB_FE_DEVICE_REMOVED)
+	if (fe->exit == DVB_FE_DEVICE_REMOVED) {
+		mutex_unlock(&fe->remove_mutex);
 		return -ENODEV;
+	}
 
 	if (adapter->mfe_shared == 2) {
 		mutex_lock(&adapter->mfe_lock);
@@ -2794,8 +2807,10 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			while (mferetry-- && (mfedev->users != -1 ||
 					      mfepriv->thread)) {
 				if (msleep_interruptible(500)) {
-					if (signal_pending(current))
+					if (signal_pending(current)) {
+						mutex_unlock(&fe->remove_mutex);
 						return -EINTR;
+					}
 				}
 			}
 
@@ -2807,6 +2822,7 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				if (mfedev->users != -1 ||
 				    mfepriv->thread) {
 					mutex_unlock(&adapter->mfe_lock);
+					mutex_unlock(&fe->remove_mutex);
 					return -EBUSY;
 				}
 				adapter->mfe_dvbdev = dvbdev;
@@ -2866,6 +2882,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
+
+	mutex_unlock(&fe->remove_mutex);
 	return ret;
 
 err3:
@@ -2887,6 +2905,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err0:
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
+
+	mutex_unlock(&fe->remove_mutex);
 	return ret;
 }
 
@@ -2897,6 +2917,8 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int ret;
 
+	mutex_lock(&fe->remove_mutex);
+
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
@@ -2918,10 +2940,18 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		}
 		mutex_unlock(&fe->dvb->mdev_lock);
 #endif
-		if (fe->exit != DVB_FE_NO_EXIT)
-			wake_up(&dvbdev->wait_queue);
 		if (fe->ops.ts_bus_ctrl)
 			fe->ops.ts_bus_ctrl(fe, 0);
+
+		if (fe->exit != DVB_FE_NO_EXIT) {
+			mutex_unlock(&fe->remove_mutex);
+			wake_up(&dvbdev->wait_queue);
+		} else {
+			mutex_unlock(&fe->remove_mutex);
+		}
+
+	} else {
+		mutex_unlock(&fe->remove_mutex);
 	}
 
 	dvb_frontend_put(fe);
@@ -3022,6 +3052,7 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	fepriv = fe->frontend_priv;
 
 	kref_init(&fe->refcount);
+	mutex_init(&fe->remove_mutex);
 
 	/*
 	 * After initialization, there need to be two references: one
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index e7c44870f20d..367d5381217b 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -686,7 +686,10 @@ struct dtv_frontend_properties {
  * @id:			Frontend ID
  * @exit:		Used to inform the DVB core that the frontend
  *			thread should exit (usually, means that the hardware
- *			got disconnected.
+ *			got disconnected).
+ * @remove_mutex:	mutex that avoids a race condition between a callback
+ *			called when the hardware is disconnected and the
+ *			file_operations of dvb_frontend.
  */
 
 struct dvb_frontend {
@@ -704,6 +707,7 @@ struct dvb_frontend {
 	int (*callback)(void *adapter_priv, int component, int cmd, int arg);
 	int id;
 	unsigned int exit;
+	struct mutex remove_mutex;
 };
 
 /**
-- 
2.40.1

