Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA665504B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiLWMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiLWMYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:24:37 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D09FCCF;
        Fri, 23 Dec 2022 04:24:35 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:cd5d:4e48:3b91:9262:9565])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C471BAE;
        Fri, 23 Dec 2022 13:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671798274;
        bh=UjcTFXFjoNpWqCvsrrzjGIni3777MtPVvHGdzIyiSxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJIKtTXo7ATc5up+NFValgfLUSQUVWTMoGXEtaq4aVZtBXW0IwpZ998WeTBYlHH+7
         tC4U5Imv+bLtmzKCrItwruAF2mPR9ghsP3xZ5Dn4Zqc3vWmvz4n3dMDBALHRWZUen3
         u2dKcaeilq76RVyvY1SOVFM9HuyuKD4EmFesYtTA=
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
Subject: [PATCH v3 2/7] staging: vc04_services: Drop VCHIQ_SUCCESS usage
Date:   Fri, 23 Dec 2022 17:53:59 +0530
Message-Id: <20221223122404.170585-3-umang.jain@ideasonboard.com>
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

Drop the usage of VCHIQ_SUCCESS vchiq_status enum type. Replace it with
0 to report the success status.

This patch acts as intermediatory to address the TODO item:
	* Get rid of custom function return values
for vc04_services/interface.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  4 +-
 .../include/linux/raspberrypi/vchiq.h         |  1 -
 .../interface/vchiq_arm/vchiq_arm.c           | 36 ++++++-------
 .../interface/vchiq_arm/vchiq_core.c          | 54 +++++++++----------
 .../interface/vchiq_arm/vchiq_dev.c           | 18 +++----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  4 +-
 6 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 0fd92affc264..d74110ca17ab 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -101,7 +101,7 @@ static int audio_vchi_callback(struct vchiq_instance *vchiq_instance,
 	struct vc_audio_msg *m;
 
 	if (reason != VCHIQ_MESSAGE_AVAILABLE)
-		return VCHIQ_SUCCESS;
+		return 0;
 
 	m = (void *)header->data;
 	if (m->type == VC_AUDIO_MSG_TYPE_RESULT) {
@@ -119,7 +119,7 @@ static int audio_vchi_callback(struct vchiq_instance *vchiq_instance,
 	}
 
 	vchiq_release_message(vchiq_instance, instance->service_handle, header);
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 static int
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 71f4cb5d5cfd..52c513e5cf3b 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -19,7 +19,6 @@ enum vchiq_reason {
 
 enum vchiq_status {
 	VCHIQ_ERROR   = -1,
-	VCHIQ_SUCCESS = 0,
 	VCHIQ_RETRY   = 1
 };
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index fa92c34890e0..6e4e17272dad 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -724,7 +724,7 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 
 int vchiq_shutdown(struct vchiq_instance *instance)
 {
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex))
@@ -761,7 +761,7 @@ int vchiq_connect(struct vchiq_instance *instance)
 	}
 	status = vchiq_connect_internal(state, instance);
 
-	if (status == VCHIQ_SUCCESS)
+	if (!status)
 		instance->connected = 1;
 
 	mutex_unlock(&state->mutex);
@@ -793,7 +793,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 
 	if (service) {
 		*phandle = service->handle;
-		status = VCHIQ_SUCCESS;
+		status = 0;
 	} else {
 		status = VCHIQ_ERROR;
 	}
@@ -822,7 +822,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 	if (service) {
 		*phandle = service->handle;
 		status = vchiq_open_service_internal(service, current->pid);
-		if (status != VCHIQ_SUCCESS) {
+		if (status) {
 			vchiq_remove_service(instance, service->handle);
 			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
 		}
@@ -1004,7 +1004,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 			return VCHIQ_RETRY;
 		} else if (instance->closing) {
 			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
-			return VCHIQ_SUCCESS;
+			return 0;
 		}
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 	}
@@ -1041,7 +1041,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 
 	complete(&instance->insert_event);
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 int
@@ -1066,14 +1066,14 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 	service = handle_to_service(instance, handle);
 	if (WARN_ON(!service)) {
 		rcu_read_unlock();
-		return VCHIQ_SUCCESS;
+		return 0;
 	}
 
 	user_service = (struct user_service *)service->base.userdata;
 
 	if (!instance || instance->closing) {
 		rcu_read_unlock();
-		return VCHIQ_SUCCESS;
+		return 0;
 	}
 
 	/*
@@ -1110,7 +1110,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				status = add_completion(instance, reason, NULL, user_service,
 							bulk_userdata);
-				if (status != VCHIQ_SUCCESS) {
+				if (status) {
 					DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 					vchiq_service_put(service);
 					return status;
@@ -1158,7 +1158,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 	vchiq_service_put(service);
 
 	if (skip_completion)
-		return VCHIQ_SUCCESS;
+		return 0;
 
 	return add_completion(instance, reason, header, user_service,
 		bulk_userdata);
@@ -1350,14 +1350,14 @@ vchiq_keepalive_thread_func(void *v)
 	}
 
 	status = vchiq_connect(instance);
-	if (status != VCHIQ_SUCCESS) {
+	if (status) {
 		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
 				status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
-	if (status != VCHIQ_SUCCESS) {
+	if (status) {
 		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
 				status);
 		goto shutdown;
@@ -1386,14 +1386,14 @@ vchiq_keepalive_thread_func(void *v)
 		while (uc--) {
 			atomic_inc(&arm_state->ka_use_ack_count);
 			status = vchiq_use_service(instance, ka_handle);
-			if (status != VCHIQ_SUCCESS) {
+			if (status) {
 				vchiq_log_error(vchiq_susp_log_level,
 						"%s vchiq_use_service error %d", __func__, status);
 			}
 		}
 		while (rc--) {
 			status = vchiq_release_service(instance, ka_handle);
-			if (status != VCHIQ_SUCCESS) {
+			if (status) {
 				vchiq_log_error(vchiq_susp_log_level,
 						"%s vchiq_release_service error %d", __func__,
 						status);
@@ -1446,13 +1446,13 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	write_unlock_bh(&arm_state->susp_res_lock);
 
 	if (!ret) {
-		enum vchiq_status status = VCHIQ_SUCCESS;
+		int status = 0;
 		long ack_cnt = atomic_xchg(&arm_state->ka_use_ack_count, 0);
 
-		while (ack_cnt && (status == VCHIQ_SUCCESS)) {
+		while (ack_cnt && !status) {
 			/* Send the use notify to videocore */
 			status = vchiq_send_remote_use_active(state);
-			if (status == VCHIQ_SUCCESS)
+			if (!status)
 				ack_cnt--;
 			else
 				atomic_add(ack_cnt, &arm_state->ka_use_ack_count);
@@ -1708,7 +1708,7 @@ vchiq_check_service(struct vchiq_service *service)
 
 	read_lock_bh(&arm_state->susp_res_lock);
 	if (service->service_use_count)
-		ret = VCHIQ_SUCCESS;
+		ret = 0;
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (ret == VCHIQ_ERROR) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index a543c29b1598..8b8f9e56d924 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -478,7 +478,7 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		vchiq_log_warning(vchiq_core_log_level,
 				  "%d: ignoring ERROR from callback to service %x",
 				  service->state->id, service->handle);
-		status = VCHIQ_SUCCESS;
+		status = 0;
 	}
 
 	if (reason != VCHIQ_MESSAGE_AVAILABLE)
@@ -1135,7 +1135,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 	remote_event_signal(&state->remote->trigger);
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 /* Called by the slot handler and application threads */
@@ -1223,7 +1223,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	if (VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_PAUSE)
 		mutex_unlock(&state->sync_mutex);
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 static inline void
@@ -1303,7 +1303,7 @@ static int
 notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 	     int retry_poll)
 {
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	vchiq_log_trace(vchiq_core_log_level, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
 			service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
@@ -1357,7 +1357,7 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		complete(&service->bulk_remove_event);
 	}
 	if (!retry_poll)
-		status = VCHIQ_SUCCESS;
+		status = 0;
 
 	if (status == VCHIQ_RETRY)
 		request_poll(service->state, service, (queue == &service->bulk_tx) ?
@@ -1398,13 +1398,12 @@ poll_services_of_group(struct vchiq_state *state, int group)
 			 */
 			service->public_fourcc = VCHIQ_FOURCC_INVALID;
 
-			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) !=
-							 VCHIQ_SUCCESS)
+			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_REMOVE);
 		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
 			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
 				       state->id, service->localport, service->remoteport);
-			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) != VCHIQ_SUCCESS)
+			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_TERMINATE);
 		}
 		if (service_flags & BIT(VCHIQ_POLL_TXNOTIFY))
@@ -2495,7 +2494,7 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 		service->version,
 		service->version_min
 	};
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	service->client_id = client_id;
 	vchiq_use_service_internal(service);
@@ -2506,7 +2505,7 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 			       sizeof(payload),
 			       QMFLAGS_IS_BLOCKING);
 
-	if (status != VCHIQ_SUCCESS)
+	if (status)
 		return status;
 
 	/* Wait for the ACK/NAK */
@@ -2602,11 +2601,11 @@ do_abort_bulks(struct vchiq_service *service)
 	mutex_unlock(&service->bulk_mutex);
 
 	status = notify_bulks(service, &service->bulk_tx, NO_RETRY_POLL);
-	if (status != VCHIQ_SUCCESS)
+	if (status)
 		return 0;
 
 	status = notify_bulks(service, &service->bulk_rx, NO_RETRY_POLL);
-	return (status == VCHIQ_SUCCESS);
+	return !status;
 }
 
 static int
@@ -2678,7 +2677,7 @@ int
 vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 {
 	struct vchiq_state *state = service->state;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	int is_server = (service->public_fourcc != VCHIQ_FOURCC_INVALID);
 	int close_id = MAKE_CLOSE(service->localport,
 				  VCHIQ_MSG_DSTPORT(service->remoteport));
@@ -2730,11 +2729,11 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 
 		release_service_messages(service);
 
-		if (status == VCHIQ_SUCCESS)
+		if (!status)
 			status = queue_message(state, service, close_id, NULL,
 					       NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK);
 
-		if (status != VCHIQ_SUCCESS) {
+		if (status) {
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)
 				mutex_unlock(&state->sync_mutex);
 			break;
@@ -2768,7 +2767,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 			break;
 		}
 
-		if (status == VCHIQ_SUCCESS)
+		if (!status)
 			status = close_service_complete(service, VCHIQ_SRVSTATE_CLOSERECVD);
 		break;
 
@@ -2862,7 +2861,7 @@ vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instanc
 		complete(&state->connect);
 	}
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 void
@@ -2884,7 +2883,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	if (!service)
 		return VCHIQ_ERROR;
@@ -2926,7 +2925,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 				  srvstate_names[service->srvstate]);
 	}
 
-	if ((status == VCHIQ_SUCCESS) &&
+	if (!status &&
 	    (service->srvstate != VCHIQ_SRVSTATE_FREE) &&
 	    (service->srvstate != VCHIQ_SRVSTATE_LISTENING))
 		status = VCHIQ_ERROR;
@@ -2942,7 +2941,7 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	if (!service)
 		return VCHIQ_ERROR;
@@ -2987,8 +2986,7 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 				  srvstate_names[service->srvstate]);
 	}
 
-	if ((status == VCHIQ_SUCCESS) &&
-	    (service->srvstate != VCHIQ_SRVSTATE_FREE))
+	if (!status && (service->srvstate != VCHIQ_SRVSTATE_FREE))
 		status = VCHIQ_ERROR;
 
 	vchiq_service_put(service);
@@ -3028,7 +3026,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	if (!offset && !uoffset)
 		goto error_exit;
 
-	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
+	if (vchiq_check_service(service))
 		goto error_exit;
 
 	switch (mode) {
@@ -3121,7 +3119,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 			       QMFLAGS_IS_BLOCKING |
 			       QMFLAGS_NO_MUTEX_LOCK |
 			       QMFLAGS_NO_MUTEX_UNLOCK);
-	if (status != VCHIQ_SUCCESS)
+	if (status)
 		goto unlock_both_error_exit;
 
 	queue->local_insert++;
@@ -3136,7 +3134,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 waiting:
 	vchiq_service_put(service);
 
-	status = VCHIQ_SUCCESS;
+	status = 0;
 
 	if (bulk_waiter) {
 		bulk_waiter->bulk = bulk;
@@ -3175,7 +3173,7 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 	if (!service)
 		goto error_exit;
 
-	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
+	if (vchiq_check_service(service))
 		goto error_exit;
 
 	if (!size) {
@@ -3286,14 +3284,14 @@ vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle, sho
 	if (!service)
 		goto exit;
 
-	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
+	if (vchiq_check_service(service))
 		goto exit;
 
 	if (!peer_version)
 		goto exit;
 
 	*peer_version = service->peer_version;
-	status = VCHIQ_SUCCESS;
+	status = 0;
 
 exit:
 	if (service)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 7e297494437e..d9c4d550412e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -112,7 +112,7 @@ vchiq_ioc_queue_message(struct vchiq_instance *instance, unsigned int handle,
 			struct vchiq_element *elements, unsigned long count)
 {
 	struct vchiq_io_copy_callback_context context;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	unsigned long i;
 	size_t total_size = 0;
 
@@ -142,7 +142,7 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 {
 	struct user_service *user_service = NULL;
 	struct vchiq_service *service;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	struct vchiq_service_params_kernel params;
 	int srvstate;
 
@@ -190,7 +190,7 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 
 	if (args->is_open) {
 		status = vchiq_open_service_internal(service, instance->pid);
-		if (status != VCHIQ_SUCCESS) {
+		if (status) {
 			vchiq_remove_service(instance, service->handle);
 			return (status == VCHIQ_RETRY) ?
 				-EINTR : -EIO;
@@ -577,7 +577,7 @@ static long
 vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct vchiq_instance *instance = file->private_data;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	struct vchiq_service *service = NULL;
 	long ret = 0;
 	int i, rc;
@@ -598,12 +598,12 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 							   instance, &i))) {
 			status = vchiq_remove_service(instance, service->handle);
 			vchiq_service_put(service);
-			if (status != VCHIQ_SUCCESS)
+			if (status)
 				break;
 		}
 		service = NULL;
 
-		if (status == VCHIQ_SUCCESS) {
+		if (!status) {
 			/* Wake the completion thread and ask it to exit */
 			instance->closing = 1;
 			complete(&instance->insert_event);
@@ -627,7 +627,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		status = vchiq_connect_internal(instance->state, instance);
 		mutex_unlock(&instance->state->mutex);
 
-		if (status == VCHIQ_SUCCESS)
+		if (!status)
 			instance->connected = 1;
 		else
 			vchiq_log_error(vchiq_arm_log_level,
@@ -675,7 +675,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
 				 vchiq_close_service(instance, service->handle) :
 				 vchiq_remove_service(instance, service->handle);
-			if (status != VCHIQ_SUCCESS)
+			if (status)
 				break;
 		}
 
@@ -868,7 +868,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			ret = -EINTR;
 	}
 
-	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
+	if (!status && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
 		vchiq_log_info(vchiq_arm_log_level,
 			       "  ioctl instance %pK, cmd %s -> status %d, %ld",
 			       instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 038881827336..6b5879a33780 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -559,7 +559,7 @@ static int service_callback(struct vchiq_instance *vchiq_instance,
 
 	if (!instance) {
 		pr_err("Message callback passed NULL instance\n");
-		return VCHIQ_SUCCESS;
+		return 0;
 	}
 
 	switch (reason) {
@@ -643,7 +643,7 @@ static int service_callback(struct vchiq_instance *vchiq_instance,
 		break;
 	}
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
-- 
2.38.1

