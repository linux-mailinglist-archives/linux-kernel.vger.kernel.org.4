Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD61671C38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjARMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjARMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:35:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23947088;
        Wed, 18 Jan 2023 03:58:33 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 976DB1B5C;
        Wed, 18 Jan 2023 12:58:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674043111;
        bh=TBsbR7oiP57NsJJYhX/WoXpbozaJauNQ1lOkJtxXczg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlpDKSHZ/eVAP11xXrI/+IZKQNfuvwTct71rNjYikPGqEzDvKUBTcxZzFLTVCpGIN
         ydgCuyZ3lPJt5TwpinFrtAkoOgm+qBvLep2yT0ZrBEf9G/vG63GjCxYGIfpzpUQCh1
         9HaWozT982WbtpfM8BERDQeDrX18E1iG7dicduVA=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [RFC PATCH 3/4] staging: vc04_services: Drop custom logging
Date:   Wed, 18 Jan 2023 17:28:09 +0530
Message-Id: <20230118115810.21979-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118115810.21979-1-umang.jain@ideasonboard.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop custom logging from the vchiq_connected and vchiq_dev.
Use standard kernel logging infrastructure (dev_dbg and friends
for struct Device stuff) and pr_info (and similar) for vchiq_instance
related things.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_connected.c     |  5 +-
 .../interface/vchiq_arm/vchiq_dev.c           | 78 ++++++++-----------
 2 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index bdb0ab617d8b..c769014ae2ac 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -39,9 +39,8 @@ void vchiq_add_connected_callback(void (*callback)(void))
 		callback();
 	} else {
 		if (g_num_deferred_callbacks >= MAX_CALLBACKS) {
-			vchiq_log_error(vchiq_core_log_level,
-					"There already %d callback registered - please increase MAX_CALLBACKS",
-					g_num_deferred_callbacks);
+			pr_err("vchiq: There is already %d callback registered - please increase MAX_CALLBACKS",
+				g_num_deferred_callbacks);
 		} else {
 			g_deferred_callback[g_num_deferred_callbacks] =
 				callback;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 841e1a535642..2524a435e5ce 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -47,9 +47,8 @@ user_service_free(void *userdata)
 
 static void close_delivered(struct user_service *user_service)
 {
-	vchiq_log_info(vchiq_arm_log_level,
-		       "%s(handle=%x)",
-		       __func__, user_service->service->handle);
+	pr_info("vchiq: %s(handle=%x)", __func__,
+		user_service->service->handle);
 
 	if (user_service->close_pending) {
 		/* Allow the underlying service to be culled */
@@ -235,8 +234,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
 			if (wait_for_completion_interruptible(&user_service->insert_event)) {
-				vchiq_log_info(vchiq_arm_log_level,
-					       "DEQUEUE_MESSAGE interrupted");
+				pr_info("vchiq: DEQUEUE_MESSAGE interrupted\n");
 				ret = -EINTR;
 				break;
 			}
@@ -271,9 +269,8 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 			ret = -EFAULT;
 		}
 	} else {
-		vchiq_log_error(vchiq_arm_log_level,
-				"header %pK: bufsize %x < size %x",
-				header, args->bufsize, header->size);
+		pr_err("vchiq: header %pK: bufsize %x < size %x",
+			header, args->bufsize, header->size);
 		WARN(1, "invalid size\n");
 		ret = -EMSGSIZE;
 	}
@@ -318,13 +315,11 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		}
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
 		if (!waiter) {
-			vchiq_log_error(vchiq_arm_log_level,
-					"no bulk_waiter found for pid %d", current->pid);
+			pr_err("vchiq: no bulk_waiter found for pid %d", current->pid);
 			ret = -ESRCH;
 			goto out;
 		}
-		vchiq_log_info(vchiq_arm_log_level,
-			       "found bulk_waiter %pK for pid %d", waiter, current->pid);
+		pr_info("vchiq: found bulk_waiter %pK for pid %d", waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
 	} else {
 		userdata = args->userdata;
@@ -355,8 +350,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
-			       "saved bulk_waiter %pK for pid %d", waiter, current->pid);
+		pr_info("vchiq: saved bulk_waiter %pK for pid %d", waiter, current->pid);
 
 		ret = put_user(mode_waiting, mode);
 	}
@@ -455,8 +449,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 		mutex_lock(&instance->completion_mutex);
 		if (rc) {
 			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-			vchiq_log_info(vchiq_arm_log_level,
-				       "AWAIT_COMPLETION interrupted");
+			pr_info("vchiq: AWAIT_COMPLETION interrupted");
 			ret = -EINTR;
 			goto out;
 		}
@@ -501,10 +494,9 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 			msglen = header->size + sizeof(struct vchiq_header);
 			/* This must be a VCHIQ-style service */
 			if (args->msgbufsize < msglen) {
-				vchiq_log_error(vchiq_arm_log_level,
-						"header %pK: msgbufsize %x < msglen %x",
-						header, args->msgbufsize, msglen);
-						WARN(1, "invalid message size\n");
+				pr_err("vchiq: header %pK: msgbufsize %x < msglen %x",
+				       header, args->msgbufsize, msglen);
+				       WARN(1, "invalid message size\n");
 				if (ret == 0)
 					ret = -EMSGSIZE;
 				break;
@@ -582,10 +574,9 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long ret = 0;
 	int i, rc;
 
-	vchiq_log_trace(vchiq_arm_log_level,
-			"%s - instance %pK, cmd %s, arg %lx", __func__, instance,
-			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
-			ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
+	pr_debug("vchiq: %s - instance %pK, cmd %s, arg %lx", __func__, instance,
+		 ((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
+		 ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
 
 	switch (cmd) {
 	case VCHIQ_IOC_SHUTDOWN:
@@ -618,9 +609,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		rc = mutex_lock_killable(&instance->state->mutex);
 		if (rc) {
-			vchiq_log_error(vchiq_arm_log_level,
-					"vchiq: connect: could not lock mutex for state %d: %d",
-					instance->state->id, rc);
+			pr_err("vchiq: connect: could not lock mutex for state %d: %d",
+			       instance->state->id, rc);
 			ret = -EINTR;
 			break;
 		}
@@ -630,8 +620,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (!status)
 			instance->connected = 1;
 		else
-			vchiq_log_error(vchiq_arm_log_level,
-					"vchiq: could not connect: %d", status);
+			pr_err("vchiq: could not connect: %d", status);
 		break;
 
 	case VCHIQ_IOC_CREATE_SERVICE: {
@@ -700,11 +689,10 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				vchiq_use_service_internal(service) :
 				vchiq_release_service_internal(service);
 			if (ret) {
-				vchiq_log_error(vchiq_susp_log_level,
-						"%s: cmd %s returned error %ld for service %c%c%c%c:%03d",
-						__func__, (cmd == VCHIQ_IOC_USE_SERVICE) ?
-						"VCHIQ_IOC_USE_SERVICE" :
-						"VCHIQ_IOC_RELEASE_SERVICE",
+				pr_err("vchiq:%s: cmd %s returned error %ld for service %c%c%c%c:%03d",
+					__func__, (cmd == VCHIQ_IOC_USE_SERVICE) ?
+					"VCHIQ_IOC_USE_SERVICE" :
+					"VCHIQ_IOC_RELEASE_SERVICE",
 					ret,
 					VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
 					service->client_id);
@@ -869,15 +857,13 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	if (!status && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
-		vchiq_log_info(vchiq_arm_log_level,
-			       "  ioctl instance %pK, cmd %s -> status %d, %ld",
-			       instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-			       ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
+		pr_info("vchiq: ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
+			ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 	else
-		vchiq_log_trace(vchiq_arm_log_level,
-				"  ioctl instance %pK, cmd %s -> status %d, %ld",
-				instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
+		pr_debug("vchiq: ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
+			ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 
 	return ret;
 }
@@ -1170,11 +1156,10 @@ static int vchiq_open(struct inode *inode, struct file *file)
 	struct vchiq_state *state = vchiq_get_state();
 	struct vchiq_instance *instance;
 
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
+	pr_info("vchiq: %s\n", __func__);
 
 	if (!state) {
-		vchiq_log_error(vchiq_arm_log_level,
-				"vchiq has no connection to VideoCore");
+		pr_err("vchiq: vchiq has no connection to VideoCore\n");
 		return -ENOTCONN;
 	}
 
@@ -1206,8 +1191,7 @@ static int vchiq_release(struct inode *inode, struct file *file)
 	int ret = 0;
 	int i;
 
-	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
-		       (unsigned long)instance);
+	pr_info("%s: instance=%lx", __func__, (unsigned long)instance);
 
 	if (!state) {
 		ret = -EPERM;
-- 
2.39.0

