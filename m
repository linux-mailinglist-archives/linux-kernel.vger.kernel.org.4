Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC3650B02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiLSL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiLSL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:58:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF4E0C8;
        Mon, 19 Dec 2022 03:58:03 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8107B825;
        Mon, 19 Dec 2022 12:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671451081;
        bh=jgCyZNJXEhgbzd190FOhZ3vzlFoOsks0ZBObJlTIa9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmUgGjo1zpuwcuF51FrczmnDP6HpxxpFLahvmcbuNTn2b+SP+fr3qwnV0+77rA5tA
         g9160Q5ow7K+fhvEEMpCHmYF6GJi3TJTCotgHOQw8LecPSu9aCO2/knfAiHqHqeUo9
         /kFziI+Ml4EoIE5MNpzAepA/b5gserf83F5v9t1s=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 3/7] staging: vc04_services: Drop VCHIQ_ERROR usage
Date:   Mon, 19 Dec 2022 17:27:21 +0530
Message-Id: <20221219115725.11992-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219115725.11992-1-umang.jain@ideasonboard.com>
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
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

Drop the usage of VCHIQ_ERROR vchiq_status enum type. Replace it with
-EINVAL to report the error in most cases, -ENOMEM for out-of-memory
errors and -EHOSTDOWN for service shutdown.

This patch acts as intermediatory to address the TODO item:
    * Get rid of custom function return values
for vc04_services/interface.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../include/linux/raspberrypi/vchiq.h         |  1 -
 .../interface/vchiq_arm/vchiq_arm.c           | 24 +++++-----
 .../interface/vchiq_arm/vchiq_core.c          | 44 +++++++++----------
 .../interface/vchiq_arm/vchiq_dev.c           |  6 +--
 4 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 52c513e5cf3b..2ca4461d26ee 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -18,7 +18,6 @@ enum vchiq_reason {
 };
 
 enum vchiq_status {
-	VCHIQ_ERROR   = -1,
 	VCHIQ_RETRY   = 1
 };
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6e4e17272dad..2415baeccc9c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -501,7 +501,7 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 
 	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
 	if (!vchiq_slot_zero)
-		return -EINVAL;
+		return -ENOMEM;
 
 	vchiq_slot_zero->platform_data[VCHIQ_PLATFORM_FRAGMENTS_OFFSET_IDX] =
 		(int)slot_phys + slot_mem_size;
@@ -795,7 +795,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 		*phandle = service->handle;
 		status = 0;
 	} else {
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 	}
 
 	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
@@ -808,7 +808,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 		   const struct vchiq_service_params_kernel *params,
 		   unsigned int *phandle)
 {
-	enum vchiq_status   status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	struct vchiq_state   *state = instance->state;
 	struct vchiq_service *service = NULL;
 
@@ -855,7 +855,7 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 							      VCHIQ_BULK_TRANSMIT);
 			break;
 		default:
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		/*
@@ -892,7 +892,7 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 							      VCHIQ_BULK_RECEIVE);
 			break;
 		default:
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		/*
@@ -920,7 +920,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 
 	service = find_service_by_handle(instance, handle);
 	if (!service)
-		return VCHIQ_ERROR;
+		return -EINVAL;
 
 	vchiq_service_put(service);
 
@@ -954,7 +954,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter) {
 			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
-			return VCHIQ_ERROR;
+			return -ENOMEM;
 		}
 	}
 
@@ -1127,7 +1127,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
-				return VCHIQ_ERROR;
+				return -EINVAL;
 			}
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			spin_lock(&msg_queue_spinlock);
@@ -1590,7 +1590,7 @@ vchiq_instance_set_trace(struct vchiq_instance *instance, int trace)
 int
 vchiq_use_service(struct vchiq_instance *instance, unsigned int handle)
 {
-	enum vchiq_status ret = VCHIQ_ERROR;
+	int ret = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 
 	if (service) {
@@ -1604,7 +1604,7 @@ EXPORT_SYMBOL(vchiq_use_service);
 int
 vchiq_release_service(struct vchiq_instance *instance, unsigned int handle)
 {
-	enum vchiq_status ret = VCHIQ_ERROR;
+	int ret = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 
 	if (service) {
@@ -1699,7 +1699,7 @@ int
 vchiq_check_service(struct vchiq_service *service)
 {
 	struct vchiq_arm_state *arm_state;
-	enum vchiq_status ret = VCHIQ_ERROR;
+	int ret = -EINVAL;
 
 	if (!service || !service->state)
 		goto out;
@@ -1711,7 +1711,7 @@ vchiq_check_service(struct vchiq_service *service)
 		ret = 0;
 	read_unlock_bh(&arm_state->susp_res_lock);
 
-	if (ret == VCHIQ_ERROR) {
+	if (ret) {
 		vchiq_log_error(vchiq_susp_log_level,
 				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
 				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8b8f9e56d924..640fdb28d1c0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -467,14 +467,14 @@ static inline int
 make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		      struct vchiq_header *header, void *bulk_userdata)
 {
-	enum vchiq_status status;
+	int status;
 
 	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
 			service->state->id, service->localport, reason_names[reason],
 			header, bulk_userdata);
 	status = service->base.callback(service->instance, reason, header, service->handle,
 					bulk_userdata);
-	if (status == VCHIQ_ERROR) {
+	if (status && (status != VCHIQ_RETRY)) {
 		vchiq_log_warning(vchiq_core_log_level,
 				  "%d: ignoring ERROR from callback to service %x",
 				  service->state->id, service->handle);
@@ -930,7 +930,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		if (!service) {
 			WARN(1, "%s: service is NULL\n", __func__);
 			mutex_unlock(&state->slot_mutex);
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
@@ -939,7 +939,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		if (service->closing) {
 			/* The service has been closed */
 			mutex_unlock(&state->slot_mutex);
-			return VCHIQ_ERROR;
+			return -EHOSTDOWN;
 		}
 
 		quota = &state->service_quotas[service->localport];
@@ -989,13 +989,13 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			if (wait_for_completion_interruptible(&quota->quota_event))
 				return VCHIQ_RETRY;
 			if (service->closing)
-				return VCHIQ_ERROR;
+				return -EHOSTDOWN;
 			if (mutex_lock_killable(&state->slot_mutex))
 				return VCHIQ_RETRY;
 			if (service->srvstate != VCHIQ_SRVSTATE_OPEN) {
 				/* The service has been closed */
 				mutex_unlock(&state->slot_mutex);
-				return VCHIQ_ERROR;
+				return -EHOSTDOWN;
 			}
 			spin_lock(&quota_spinlock);
 			tx_end_index = SLOT_QUEUE_INDEX_FROM_POS(state->local_tx_pos + stride - 1);
@@ -1037,7 +1037,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		if (callback_result < 0) {
 			mutex_unlock(&state->slot_mutex);
 			VCHIQ_SERVICE_STATS_INC(service, error_count);
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		if (SRVTRACE_ENABLED(service,
@@ -1185,7 +1185,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	if (callback_result < 0) {
 		mutex_unlock(&state->slot_mutex);
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	if (service) {
@@ -2520,7 +2520,7 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 					service->state->id,
 					srvstate_names[service->srvstate],
 					kref_read(&service->ref_count));
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
 		vchiq_release_service_internal(service);
 	}
@@ -2638,7 +2638,7 @@ close_service_complete(struct vchiq_service *service, int failstate)
 		vchiq_log_error(vchiq_core_log_level, "%s(%x) called in state %s", __func__,
 				service->handle, srvstate_names[service->srvstate]);
 		WARN(1, "%s in unexpected state\n", __func__);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL);
@@ -2695,7 +2695,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 					__func__, srvstate_names[service->srvstate]);
 		} else if (is_server) {
 			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
-				status = VCHIQ_ERROR;
+				status = -EINVAL;
 			} else {
 				service->client_id = 0;
 				service->remoteport = VCHIQ_PORT_FREE;
@@ -2886,7 +2886,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 	int status = 0;
 
 	if (!service)
-		return VCHIQ_ERROR;
+		return -EINVAL;
 
 	vchiq_log_info(vchiq_core_log_level, "%d: close_service:%d",
 		       service->state->id, service->localport);
@@ -2895,7 +2895,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 	    (service->srvstate == VCHIQ_SRVSTATE_LISTENING) ||
 	    (service->srvstate == VCHIQ_SRVSTATE_HIDDEN)) {
 		vchiq_service_put(service);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	mark_service_closing(service);
@@ -2928,7 +2928,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 	if (!status &&
 	    (service->srvstate != VCHIQ_SRVSTATE_FREE) &&
 	    (service->srvstate != VCHIQ_SRVSTATE_LISTENING))
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 
 	vchiq_service_put(service);
 
@@ -2944,14 +2944,14 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 	int status = 0;
 
 	if (!service)
-		return VCHIQ_ERROR;
+		return -EINVAL;
 
 	vchiq_log_info(vchiq_core_log_level, "%d: remove_service:%d",
 		       service->state->id, service->localport);
 
 	if (service->srvstate == VCHIQ_SRVSTATE_FREE) {
 		vchiq_service_put(service);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	mark_service_closing(service);
@@ -2987,7 +2987,7 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 	}
 
 	if (!status && (service->srvstate != VCHIQ_SRVSTATE_FREE))
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 
 	vchiq_service_put(service);
 
@@ -3014,7 +3014,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	const char dir_char = (dir == VCHIQ_BULK_TRANSMIT) ? 't' : 'r';
 	const int dir_msgtype = (dir == VCHIQ_BULK_TRANSMIT) ?
 		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
-	enum vchiq_status status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	int payload[2];
 
 	if (!service)
@@ -3141,7 +3141,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 		if (wait_for_completion_interruptible(&bulk_waiter->event))
 			status = VCHIQ_RETRY;
 		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
-			status = VCHIQ_ERROR;
+			status = -EINVAL;
 	}
 
 	return status;
@@ -3167,7 +3167,7 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    size_t size)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	enum vchiq_status status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	int data_id;
 
 	if (!service)
@@ -3198,7 +3198,7 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 					    copy_callback, context, size, 1);
 		break;
 	default:
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 		break;
 	}
 
@@ -3278,7 +3278,7 @@ release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
 int
 vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle, short *peer_version)
 {
-	enum vchiq_status status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 
 	if (!service)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index d9c4d550412e..df274192937e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -130,7 +130,7 @@ vchiq_ioc_queue_message(struct vchiq_instance *instance, unsigned int handle,
 	status = vchiq_queue_message(instance, handle, vchiq_ioc_copy_element_data,
 				     &context, total_size);
 
-	if (status == VCHIQ_ERROR)
+	if (status == -EINVAL)
 		return -EIO;
 	else if (status == VCHIQ_RETRY)
 		return -EINTR;
@@ -364,7 +364,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 	vchiq_service_put(service);
 	if (ret)
 		return ret;
-	else if (status == VCHIQ_ERROR)
+	else if (status == -EINVAL)
 		return -EIO;
 	else if (status == VCHIQ_RETRY)
 		return -EINTR;
@@ -862,7 +862,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		vchiq_service_put(service);
 
 	if (ret == 0) {
-		if (status == VCHIQ_ERROR)
+		if (status == -EINVAL)
 			ret = -EIO;
 		else if (status == VCHIQ_RETRY)
 			ret = -EINTR;
-- 
2.38.1

