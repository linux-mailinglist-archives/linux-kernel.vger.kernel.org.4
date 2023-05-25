Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60768711423
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbjEYSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjEYSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998E1721;
        Thu, 25 May 2023 11:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD6F660A4D;
        Thu, 25 May 2023 18:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABE3C433D2;
        Thu, 25 May 2023 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039621;
        bh=ZgdiypEPt9M4XPZg8uoKvG0ycjYi70CExDzRN4CGuDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUmxkHnoSUiYnOuBun0P4zcps1AZoq7XG5ixJp5LiqP24poiDaEGeuCjbItMjRQRz
         gH4rzesq8UJ8ZRQeDSDV8NSSAOuGdbzpTtTuecphN40b7Tyl0ZQTV802mMkGl6GgHX
         e+EWfDsqU+TS6Sst+znHVlqiHoZRJSt6Nl7XGqzUzr/dKxHZMMJ8Xq/KvFh2eIP/vp
         TXuKJT+PwXIUMiohTtMqCT9qSrMjFZ7Tr9PfVO4exF4auz8zlL2EA7qgjEleiHT0fl
         ioD4KWkHjq/86FnGAIYt/fycKOkXhWKGgeNkCAT59b+ae+Mp2dPLEhOG+WUv+CODnK
         gPXnIm89aokCA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, robert_s@gmx.net,
        chenzhongjin@huawei.com, tiwai@suse.de, linma@zju.edu.cn,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 26/67] media: dvb-core: Fix use-after-free on race condition at dvb_frontend
Date:   Thu, 25 May 2023 14:31:03 -0400
Message-Id: <20230525183144.1717540-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f ]

If the device node of dvb_frontend is open() and the device is
disconnected, many kinds of UAFs may occur when calling close()
on the device node.

The root cause of this is that wake_up() for dvbdev->wait_queue
is implemented in the dvb_frontend_release() function, but
wait_event() is not implemented in the dvb_frontend_stop() function.

So, implement wait_event() function in dvb_frontend_stop() and
add 'remove_mutex' which prevents race condition for 'fe->exit'.

[mchehab: fix a couple of checkpatch warnings and some mistakes at the error handling logic]

Link: https://lore.kernel.org/linux-media/20221117045925.14297-2-imv4bel@gmail.com
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 53 ++++++++++++++++++++++-----
 include/media/dvb_frontend.h          |  6 ++-
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index cc0a789f09ae5..947b61959b2b8 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -809,15 +809,26 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
+	mutex_lock(&fe->remove_mutex);
+
 	if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
 
-	if (!fepriv->thread)
+	if (!fepriv->thread) {
+		mutex_unlock(&fe->remove_mutex);
 		return;
+	}
 
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
 
@@ -2761,9 +2772,13 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	struct dvb_adapter *adapter = fe->dvb;
 	int ret;
 
+	mutex_lock(&fe->remove_mutex);
+
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
-	if (fe->exit == DVB_FE_DEVICE_REMOVED)
-		return -ENODEV;
+	if (fe->exit == DVB_FE_DEVICE_REMOVED) {
+		ret = -ENODEV;
+		goto err_remove_mutex;
+	}
 
 	if (adapter->mfe_shared == 2) {
 		mutex_lock(&adapter->mfe_lock);
@@ -2771,7 +2786,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			if (adapter->mfe_dvbdev &&
 			    !adapter->mfe_dvbdev->writers) {
 				mutex_unlock(&adapter->mfe_lock);
-				return -EBUSY;
+				ret = -EBUSY;
+				goto err_remove_mutex;
 			}
 			adapter->mfe_dvbdev = dvbdev;
 		}
@@ -2794,8 +2810,10 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			while (mferetry-- && (mfedev->users != -1 ||
 					      mfepriv->thread)) {
 				if (msleep_interruptible(500)) {
-					if (signal_pending(current))
-						return -EINTR;
+					if (signal_pending(current)) {
+						ret = -EINTR;
+						goto err_remove_mutex;
+					}
 				}
 			}
 
@@ -2807,7 +2825,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				if (mfedev->users != -1 ||
 				    mfepriv->thread) {
 					mutex_unlock(&adapter->mfe_lock);
-					return -EBUSY;
+					ret = -EBUSY;
+					goto err_remove_mutex;
 				}
 				adapter->mfe_dvbdev = dvbdev;
 			}
@@ -2866,6 +2885,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
+
+	mutex_unlock(&fe->remove_mutex);
 	return ret;
 
 err3:
@@ -2887,6 +2908,9 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err0:
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
+
+err_remove_mutex:
+	mutex_unlock(&fe->remove_mutex);
 	return ret;
 }
 
@@ -2897,6 +2921,8 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int ret;
 
+	mutex_lock(&fe->remove_mutex);
+
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
@@ -2918,10 +2944,18 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
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
@@ -3022,6 +3056,7 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	fepriv = fe->frontend_priv;
 
 	kref_init(&fe->refcount);
+	mutex_init(&fe->remove_mutex);
 
 	/*
 	 * After initialization, there need to be two references: one
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index e7c44870f20de..367d5381217b5 100644
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
2.39.2

