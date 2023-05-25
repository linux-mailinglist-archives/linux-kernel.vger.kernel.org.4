Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC303711621
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbjEYS4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbjEYSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0852D4C;
        Thu, 25 May 2023 11:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53983616F0;
        Thu, 25 May 2023 18:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BCDC433D2;
        Thu, 25 May 2023 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040202;
        bh=Kas1xQPjBktSRhV2HEOqzlM9qDKpxvz00yIAwJjfYEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8nyRykV0LYXuS1WgVQNn5AWFxQB25EB/rhO4mxNNiiLJyZugGJfVVswJ5q4pm8io
         HKCaHJ2b6J1Xb9u43rvYfYR1IZ/yyhR9TsbIi7ne+CHVpBE0sz8psBZn6IGX3O9xze
         IFXd9cToFnoauuXNGprfsVlSDH7HCJylWsTDxS8BYcJ1d1zCp9ITwXQCnZ4CGOd4E6
         AK5lQyqVOxD6b0GaG00g6ySdi3OaHKmTj5fZs8rkW2pYRK17q+bFUpT9VgXfsy7jsP
         8IMUWcbC42Nm+IF/+9tF6dkfoT9Je7jVK1+yQqliITkFOCHOTLo4POfmd9Pq45K9M8
         w+lnOgqav0f/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/27] media: dvb-core: Fix use-after-free due on race condition at dvb_net
Date:   Thu, 25 May 2023 14:42:24 -0400
Message-Id: <20230525184238.1943072-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 4172385b0c9ac366dcab78eda48c26814b87ed1a ]

A race condition may occur between the .disconnect function, which
is called when the device is disconnected, and the dvb_device_open()
function, which is called when the device node is open()ed.
This results in several types of UAFs.

The root cause of this is that you use the dvb_device_open() function,
which does not implement a conditional statement
that checks 'dvbnet->exit'.

So, add 'remove_mutex` to protect 'dvbnet->exit' and use
locked_dvb_net_open() function to check 'dvbnet->exit'.

[mchehab: fix a checkpatch warning]

Link: https://lore.kernel.org/linux-media/20221117045925.14297-3-imv4bel@gmail.com
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_net.c | 38 +++++++++++++++++++++++++++++---
 include/media/dvb_net.h          |  4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index 9fed06ba88efb..ccaaabaaeb571 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -1564,15 +1564,43 @@ static long dvb_net_ioctl(struct file *file,
 	return dvb_usercopy(file, cmd, arg, dvb_net_do_ioctl);
 }
 
+static int locked_dvb_net_open(struct inode *inode, struct file *file)
+{
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_net *dvbnet = dvbdev->priv;
+	int ret;
+
+	if (mutex_lock_interruptible(&dvbnet->remove_mutex))
+		return -ERESTARTSYS;
+
+	if (dvbnet->exit) {
+		mutex_unlock(&dvbnet->remove_mutex);
+		return -ENODEV;
+	}
+
+	ret = dvb_generic_open(inode, file);
+
+	mutex_unlock(&dvbnet->remove_mutex);
+
+	return ret;
+}
+
 static int dvb_net_close(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_net *dvbnet = dvbdev->priv;
 
+	mutex_lock(&dvbnet->remove_mutex);
+
 	dvb_generic_release(inode, file);
 
-	if(dvbdev->users == 1 && dvbnet->exit == 1)
+	if (dvbdev->users == 1 && dvbnet->exit == 1) {
+		mutex_unlock(&dvbnet->remove_mutex);
 		wake_up(&dvbdev->wait_queue);
+	} else {
+		mutex_unlock(&dvbnet->remove_mutex);
+	}
+
 	return 0;
 }
 
@@ -1580,7 +1608,7 @@ static int dvb_net_close(struct inode *inode, struct file *file)
 static const struct file_operations dvb_net_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = dvb_net_ioctl,
-	.open =	dvb_generic_open,
+	.open =	locked_dvb_net_open,
 	.release = dvb_net_close,
 	.llseek = noop_llseek,
 };
@@ -1599,10 +1627,13 @@ void dvb_net_release (struct dvb_net *dvbnet)
 {
 	int i;
 
+	mutex_lock(&dvbnet->remove_mutex);
 	dvbnet->exit = 1;
+	mutex_unlock(&dvbnet->remove_mutex);
+
 	if (dvbnet->dvbdev->users < 1)
 		wait_event(dvbnet->dvbdev->wait_queue,
-				dvbnet->dvbdev->users==1);
+				dvbnet->dvbdev->users == 1);
 
 	dvb_unregister_device(dvbnet->dvbdev);
 
@@ -1621,6 +1652,7 @@ int dvb_net_init (struct dvb_adapter *adap, struct dvb_net *dvbnet,
 	int i;
 
 	mutex_init(&dvbnet->ioctl_mutex);
+	mutex_init(&dvbnet->remove_mutex);
 	dvbnet->demux = dmx;
 
 	for (i=0; i<DVB_NET_DEVICES_MAX; i++)
diff --git a/include/media/dvb_net.h b/include/media/dvb_net.h
index 5e31d37f25fac..cc01dffcc9f35 100644
--- a/include/media/dvb_net.h
+++ b/include/media/dvb_net.h
@@ -41,6 +41,9 @@
  * @exit:		flag to indicate when the device is being removed.
  * @demux:		pointer to &struct dmx_demux.
  * @ioctl_mutex:	protect access to this struct.
+ * @remove_mutex:	mutex that avoids a race condition between a callback
+ *			called when the hardware is disconnected and the
+ *			file_operations of dvb_net.
  *
  * Currently, the core supports up to %DVB_NET_DEVICES_MAX (10) network
  * devices.
@@ -53,6 +56,7 @@ struct dvb_net {
 	unsigned int exit:1;
 	struct dmx_demux *demux;
 	struct mutex ioctl_mutex;
+	struct mutex remove_mutex;
 };
 
 /**
-- 
2.39.2

