Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC665504F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiLWMY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiLWMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:24:52 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02109E73;
        Fri, 23 Dec 2022 04:24:51 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:cd5d:4e48:3b91:9262:9565])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0050C881;
        Fri, 23 Dec 2022 13:24:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671798289;
        bh=tIdAUZYjasufFp7wMiuzuyAHMdDEdT9Du3sMKJopgTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfkRzrl6aSbL34btBK/BoJ8c3DrHfO4eOxilqWBpYkZc7f51+XaAivKiNsRLT3gmP
         74dvif4RNvGQzrVhGsWYLClg924pO6gySYKJ5nC+2N8v3RIkhxY+m0QUDSnka+3T0r
         CnuLO+sa9u51TCmF2ysTY/8ut5FLckHeGFMM9UPY=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
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
Subject: [PATCH v3 4/7] staging: vc04_services: Drop VCHIQ_RETRY usage
Date:   Fri, 23 Dec 2022 17:54:01 +0530
Message-Id: <20221223122404.170585-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223122404.170585-1-umang.jain@ideasonboard.com>
References: <20221223122404.170585-1-umang.jain@ideasonboard.com>
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

Drop the usage of VCHIQ_RETRY vchiq_status enum type in most of the
places and replace it with -EAGAIN. The exception to this replacement
is vchiq_send_remote_use() and vchiq_send_remote_use_active() which will
be addressed in the subsequent commit.

This patch acts as intermediatory to address the TODO item:
    * Get rid of custom function return values
for vc04_services/interface.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 18 ++---
 .../interface/vchiq_arm/vchiq_core.c          | 76 +++++++++----------
 .../interface/vchiq_arm/vchiq_dev.c           | 12 +--
 3 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 2415baeccc9c..5cfad840bd18 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -728,7 +728,7 @@ int vchiq_shutdown(struct vchiq_instance *instance)
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex))
-		return VCHIQ_RETRY;
+		return -EAGAIN;
 
 	/* Remove all services */
 	vchiq_shutdown_internal(state, instance);
@@ -756,7 +756,7 @@ int vchiq_connect(struct vchiq_instance *instance)
 
 	if (mutex_lock_killable(&state->mutex)) {
 		vchiq_log_trace(vchiq_core_log_level, "%s: call to mutex_lock failed", __func__);
-		status = VCHIQ_RETRY;
+		status = -EAGAIN;
 		goto failed;
 	}
 	status = vchiq_connect_internal(state, instance);
@@ -859,11 +859,11 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 		}
 
 		/*
-		 * vchiq_*_bulk_transfer() may return VCHIQ_RETRY, so we need
+		 * vchiq_*_bulk_transfer() may return -EAGAIN, so we need
 		 * to implement a retry mechanism since this function is
 		 * supposed to block until queued
 		 */
-		if (status != VCHIQ_RETRY)
+		if (status != -EAGAIN)
 			break;
 
 		msleep(1);
@@ -896,11 +896,11 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		}
 
 		/*
-		 * vchiq_*_bulk_transfer() may return VCHIQ_RETRY, so we need
+		 * vchiq_*_bulk_transfer() may return -EAGAIN, so we need
 		 * to implement a retry mechanism since this function is
 		 * supposed to block until queued
 		 */
-		if (status != VCHIQ_RETRY)
+		if (status != -EAGAIN)
 			break;
 
 		msleep(1);
@@ -961,7 +961,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	status = vchiq_bulk_transfer(instance, handle, data, NULL, size,
 				     &waiter->bulk_waiter,
 				     VCHIQ_BULK_MODE_BLOCKING, dir);
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
+	if ((status != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
 		if (bulk) {
@@ -1001,7 +1001,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
 		if (wait_for_completion_interruptible(&instance->remove_event)) {
 			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
-			return VCHIQ_RETRY;
+			return -EAGAIN;
 		} else if (instance->closing) {
 			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
 			return 0;
@@ -1122,7 +1122,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
-				return VCHIQ_RETRY;
+				return -EAGAIN;
 			} else if (instance->closing) {
 				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 640fdb28d1c0..9c64d5de810e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -474,7 +474,7 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 			header, bulk_userdata);
 	status = service->base.callback(service->instance, reason, header, service->handle,
 					bulk_userdata);
-	if (status && (status != VCHIQ_RETRY)) {
+	if (status && (status != -EAGAIN)) {
 		vchiq_log_warning(vchiq_core_log_level,
 				  "%d: ignoring ERROR from callback to service %x",
 				  service->state->id, service->handle);
@@ -922,7 +922,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 	if (!(flags & QMFLAGS_NO_MUTEX_LOCK) &&
 	    mutex_lock_killable(&state->slot_mutex))
-		return VCHIQ_RETRY;
+		return -EAGAIN;
 
 	if (type == VCHIQ_MSG_DATA) {
 		int tx_end_index;
@@ -963,7 +963,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			mutex_unlock(&state->slot_mutex);
 
 			if (wait_for_completion_interruptible(&state->data_quota_event))
-				return VCHIQ_RETRY;
+				return -EAGAIN;
 
 			mutex_lock(&state->slot_mutex);
 			spin_lock(&quota_spinlock);
@@ -987,11 +987,11 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
 			if (wait_for_completion_interruptible(&quota->quota_event))
-				return VCHIQ_RETRY;
+				return -EAGAIN;
 			if (service->closing)
 				return -EHOSTDOWN;
 			if (mutex_lock_killable(&state->slot_mutex))
-				return VCHIQ_RETRY;
+				return -EAGAIN;
 			if (service->srvstate != VCHIQ_SRVSTATE_OPEN) {
 				/* The service has been closed */
 				mutex_unlock(&state->slot_mutex);
@@ -1015,7 +1015,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		 */
 		if (!(flags & QMFLAGS_NO_MUTEX_LOCK))
 			mutex_unlock(&state->slot_mutex);
-		return VCHIQ_RETRY;
+		return -EAGAIN;
 	}
 
 	if (type == VCHIQ_MSG_DATA) {
@@ -1154,7 +1154,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 
 	if (VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_RESUME &&
 	    mutex_lock_killable(&state->sync_mutex))
-		return VCHIQ_RETRY;
+		return -EAGAIN;
 
 	remote_event_wait(&state->sync_release_event, &local->sync_release);
 
@@ -1348,7 +1348,7 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 						get_bulk_reason(bulk);
 				status = make_service_callback(service, reason,	NULL,
 							       bulk->userdata);
-				if (status == VCHIQ_RETRY)
+				if (status == -EAGAIN)
 					break;
 			}
 		}
@@ -1359,7 +1359,7 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 	if (!retry_poll)
 		status = 0;
 
-	if (status == VCHIQ_RETRY)
+	if (status == -EAGAIN)
 		request_poll(service->state, service, (queue == &service->bulk_tx) ?
 			     VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
 
@@ -1526,14 +1526,14 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 		/* Acknowledge the OPEN */
 		if (service->sync) {
 			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callback,
-					       &ack_payload, sizeof(ack_payload), 0) == VCHIQ_RETRY)
+					       &ack_payload, sizeof(ack_payload), 0) == -EAGAIN)
 				goto bail_not_ready;
 
 			/* The service is now open */
 			set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
 		} else {
 			if (queue_message(state, NULL, openack_id, memcpy_copy_callback,
-					  &ack_payload, sizeof(ack_payload), 0) == VCHIQ_RETRY)
+					  &ack_payload, sizeof(ack_payload), 0) == -EAGAIN)
 				goto bail_not_ready;
 
 			/* The service is now open */
@@ -1548,7 +1548,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 fail_open:
 	/* No available service, or an invalid request - send a CLOSE */
 	if (queue_message(state, NULL, MAKE_CLOSE(0, VCHIQ_MSG_SRCPORT(msgid)),
-			  NULL, NULL, 0, 0) == VCHIQ_RETRY)
+			  NULL, NULL, 0, 0) == -EAGAIN)
 		goto bail_not_ready;
 
 	return 1;
@@ -1687,7 +1687,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 
 		mark_service_closing_internal(service, 1);
 
-		if (vchiq_close_service_internal(service, CLOSE_RECVD) == VCHIQ_RETRY)
+		if (vchiq_close_service_internal(service, CLOSE_RECVD) == -EAGAIN)
 			goto bail_not_ready;
 
 		vchiq_log_info(vchiq_core_log_level, "Close Service %c%c%c%c s:%u d:%d",
@@ -1704,7 +1704,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			claim_slot(state->rx_info);
 			DEBUG_TRACE(PARSE_LINE);
 			if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-						  NULL) == VCHIQ_RETRY) {
+						  NULL) == -EAGAIN) {
 				DEBUG_TRACE(PARSE_LINE);
 				goto bail_not_ready;
 			}
@@ -1802,7 +1802,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
 			/* Send a PAUSE in response */
 			if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-					  QMFLAGS_NO_MUTEX_UNLOCK) == VCHIQ_RETRY)
+					  QMFLAGS_NO_MUTEX_UNLOCK) == -EAGAIN)
 				goto bail_not_ready;
 		}
 		/* At this point slot_mutex is held */
@@ -1919,7 +1919,7 @@ handle_poll(struct vchiq_state *state)
 
 	case VCHIQ_CONNSTATE_PAUSING:
 		if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-				  QMFLAGS_NO_MUTEX_UNLOCK) != VCHIQ_RETRY) {
+				  QMFLAGS_NO_MUTEX_UNLOCK) != -EAGAIN) {
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSE_SENT);
 		} else {
 			/* Retry later */
@@ -1929,7 +1929,7 @@ handle_poll(struct vchiq_state *state)
 
 	case VCHIQ_CONNSTATE_RESUMING:
 		if (queue_message(state, NULL, MAKE_RESUME, NULL, NULL, 0,
-				  QMFLAGS_NO_MUTEX_LOCK) != VCHIQ_RETRY) {
+				  QMFLAGS_NO_MUTEX_LOCK) != -EAGAIN) {
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
 		} else {
 			/*
@@ -2085,9 +2085,9 @@ sync_func(void *v)
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
 				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-							  NULL) == VCHIQ_RETRY)
+							  NULL) == -EAGAIN)
 					vchiq_log_error(vchiq_sync_log_level,
-							"synchronous callback to service %d returns VCHIQ_RETRY",
+							"synchronous callback to service %d returns -EAGAIN",
 							localport);
 			}
 			break;
@@ -2510,7 +2510,7 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 
 	/* Wait for the ACK/NAK */
 	if (wait_for_completion_interruptible(&service->remove_event)) {
-		status = VCHIQ_RETRY;
+		status = -EAGAIN;
 		vchiq_release_service_internal(service);
 	} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
 		   (service->srvstate != VCHIQ_SRVSTATE_OPENSYNC)) {
@@ -2643,7 +2643,7 @@ close_service_complete(struct vchiq_service *service, int failstate)
 
 	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL);
 
-	if (status != VCHIQ_RETRY) {
+	if (status != -EAGAIN) {
 		int uc = service->service_use_count;
 		int i;
 		/* Complete the close process */
@@ -2724,7 +2724,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_OPEN:
 		if (close_recvd) {
 			if (!do_abort_bulks(service))
-				status = VCHIQ_RETRY;
+				status = -EAGAIN;
 		}
 
 		release_service_messages(service);
@@ -2763,7 +2763,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 			break;
 
 		if (!do_abort_bulks(service)) {
-			status = VCHIQ_RETRY;
+			status = -EAGAIN;
 			break;
 		}
 
@@ -2847,15 +2847,15 @@ vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instanc
 
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED) {
 		if (queue_message(state, NULL, MAKE_CONNECT, NULL, NULL, 0,
-				  QMFLAGS_IS_BLOCKING) == VCHIQ_RETRY)
-			return VCHIQ_RETRY;
+				  QMFLAGS_IS_BLOCKING) == -EAGAIN)
+			return -EAGAIN;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTING);
 	}
 
 	if (state->conn_state == VCHIQ_CONNSTATE_CONNECTING) {
 		if (wait_for_completion_interruptible(&state->connect))
-			return VCHIQ_RETRY;
+			return -EAGAIN;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
 		complete(&state->connect);
@@ -2902,7 +2902,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 
 	if (current == service->state->slot_handler_thread) {
 		status = vchiq_close_service_internal(service, NO_CLOSE_RECVD);
-		WARN_ON(status == VCHIQ_RETRY);
+		WARN_ON(status == -EAGAIN);
 	} else {
 		/* Mark the service for termination by the slot handler */
 		request_poll(service->state, service, VCHIQ_POLL_TERMINATE);
@@ -2910,7 +2910,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 
 	while (1) {
 		if (wait_for_completion_interruptible(&service->remove_event)) {
-			status = VCHIQ_RETRY;
+			status = -EAGAIN;
 			break;
 		}
 
@@ -2965,14 +2965,14 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 		service->public_fourcc = VCHIQ_FOURCC_INVALID;
 
 		status = vchiq_close_service_internal(service, NO_CLOSE_RECVD);
-		WARN_ON(status == VCHIQ_RETRY);
+		WARN_ON(status == -EAGAIN);
 	} else {
 		/* Mark the service for removal by the slot handler */
 		request_poll(service->state, service, VCHIQ_POLL_REMOVE);
 	}
 	while (1) {
 		if (wait_for_completion_interruptible(&service->remove_event)) {
-			status = VCHIQ_RETRY;
+			status = -EAGAIN;
 			break;
 		}
 
@@ -2996,7 +2996,7 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 
 /*
  * This function may be called by kernel threads or user threads.
- * User threads may receive VCHIQ_RETRY to indicate that a signal has been
+ * User threads may receive -EAGAIN to indicate that a signal has been
  * received and the call should be retried after being returned to user
  * context.
  * When called in blocking mode, the userdata field points to a bulk_waiter
@@ -3053,7 +3053,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 		&service->bulk_tx : &service->bulk_rx;
 
 	if (mutex_lock_killable(&service->bulk_mutex)) {
-		status = VCHIQ_RETRY;
+		status = -EAGAIN;
 		goto error_exit;
 	}
 
@@ -3062,11 +3062,11 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 		do {
 			mutex_unlock(&service->bulk_mutex);
 			if (wait_for_completion_interruptible(&service->bulk_remove_event)) {
-				status = VCHIQ_RETRY;
+				status = -EAGAIN;
 				goto error_exit;
 			}
 			if (mutex_lock_killable(&service->bulk_mutex)) {
-				status = VCHIQ_RETRY;
+				status = -EAGAIN;
 				goto error_exit;
 			}
 		} while (queue->local_insert == queue->remove +
@@ -3099,7 +3099,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	 * claim it here to ensure that isn't happening
 	 */
 	if (mutex_lock_killable(&state->slot_mutex)) {
-		status = VCHIQ_RETRY;
+		status = -EAGAIN;
 		goto cancel_bulk_error_exit;
 	}
 
@@ -3139,7 +3139,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	if (bulk_waiter) {
 		bulk_waiter->bulk = bulk;
 		if (wait_for_completion_interruptible(&bulk_waiter->event))
-			status = VCHIQ_RETRY;
+			status = -EAGAIN;
 		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
 			status = -EINVAL;
 	}
@@ -3219,11 +3219,11 @@ int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int han
 					     data, size);
 
 		/*
-		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
+		 * vchiq_queue_message() may return -EAGAIN, so we need to
 		 * implement a retry mechanism since this function is supposed
 		 * to block until queued
 		 */
-		if (status != VCHIQ_RETRY)
+		if (status != -EAGAIN)
 			break;
 
 		msleep(1);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index df274192937e..841e1a535642 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -132,7 +132,7 @@ vchiq_ioc_queue_message(struct vchiq_instance *instance, unsigned int handle,
 
 	if (status == -EINVAL)
 		return -EIO;
-	else if (status == VCHIQ_RETRY)
+	else if (status == -EAGAIN)
 		return -EINTR;
 	return 0;
 }
@@ -192,7 +192,7 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 		status = vchiq_open_service_internal(service, instance->pid);
 		if (status) {
 			vchiq_remove_service(instance, service->handle);
-			return (status == VCHIQ_RETRY) ?
+			return (status == -EAGAIN) ?
 				-EINTR : -EIO;
 		}
 	}
@@ -338,7 +338,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		goto out;
 	}
 
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
+	if ((status != -EAGAIN) || fatal_signal_pending(current) ||
 	    !waiter->bulk_waiter.bulk) {
 		if (waiter->bulk_waiter.bulk) {
 			/* Cancel the signal when the transfer completes. */
@@ -366,7 +366,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		return ret;
 	else if (status == -EINVAL)
 		return -EIO;
-	else if (status == VCHIQ_RETRY)
+	else if (status == -EAGAIN)
 		return -EINTR;
 	return 0;
 }
@@ -686,7 +686,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 */
 		if (user_service->close_pending &&
 		    wait_for_completion_interruptible(&user_service->close_event))
-			status = VCHIQ_RETRY;
+			status = -EAGAIN;
 		break;
 	}
 
@@ -864,7 +864,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ret == 0) {
 		if (status == -EINVAL)
 			ret = -EIO;
-		else if (status == VCHIQ_RETRY)
+		else if (status == -EAGAIN)
 			ret = -EINTR;
 	}
 
-- 
2.38.1

