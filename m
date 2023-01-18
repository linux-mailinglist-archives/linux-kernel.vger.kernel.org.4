Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA33671C33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjARMfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjARMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:34:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B264347A;
        Wed, 18 Jan 2023 03:58:29 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA10218ED;
        Wed, 18 Jan 2023 12:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674043108;
        bh=p5Y5wGrreKvHW0p+dHp3R6dv18Nnd1z4zzSh/vsUOrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfDosWufH3dxI2HXLNNqJOY0PIy3epTRf0UEdf8TgplXQO9ZKBSeW2Lw/elDl9R8E
         QWQoydVFXnhP1LcXwwBzOl6BVkZidUgEbM2fbheXLQ9DkvLgnyO+QU4FWlGhXZGsD5
         2v/a4Uq5CKDlVrAhCcylIZdwnRZ0gk0DoJCsYdtU=
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
Subject: [RFC PATCH 2/4] staging: vc04_services: vchiq_arm: Drop custom logging
Date:   Wed, 18 Jan 2023 17:28:08 +0530
Message-Id: <20230118115810.21979-3-umang.jain@ideasonboard.com>
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

Drop custom logging from the vchiq_arm.c and use standard kernel
logging infrastructure (dev_dbg and friends for struct Device
stuff) and pr_info (and similar) for vchiq services/instances things.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 147 ++++++++----------
 1 file changed, 66 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 86c8e5df7cf6..ed3773b996a3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -296,7 +296,7 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 	pagelist = dma_alloc_coherent(instance->state->dev, pagelist_size, &dma_addr,
 				      GFP_KERNEL);
 
-	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK", __func__, pagelist);
+	dev_dbg(instance->state->dev, "%s - %pK", __func__, pagelist);
 
 	if (!pagelist)
 		return NULL;
@@ -351,9 +351,8 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 						   type == PAGELIST_READ, pages);
 
 		if (actual_pages != num_pages) {
-			vchiq_log_info(vchiq_arm_log_level,
-				       "%s - only %d/%d pages locked",
-				       __func__, actual_pages, num_pages);
+			dev_info(instance->state->dev, "%s - only %d/%d pages locked",
+				 __func__, actual_pages, num_pages);
 
 			/* This is probably due to the process being killed */
 			if (actual_pages > 0)
@@ -447,8 +446,8 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 	struct page **pages = pagelistinfo->pages;
 	unsigned int num_pages = pagelistinfo->num_pages;
 
-	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK, %d",
-			__func__, pagelistinfo->pagelist, actual);
+	dev_dbg(instance->state->dev, "%s - %pK, %d", __func__,
+		pagelistinfo->pagelist, actual);
 
 	/*
 	 * NOTE: dma_unmap_sg must be called before the
@@ -590,8 +589,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 		return err ? : -ENXIO;
 	}
 
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_init - done (slots %pK, phys %pad)",
-		       vchiq_slot_zero, &slot_phys);
+	dev_info(dev, "vchiq_init - done (slots %pK, phys %pad)",
+		 vchiq_slot_zero, &slot_phys);
 
 	vchiq_call_connected_callbacks();
 
@@ -721,18 +720,16 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 		usleep_range(500, 600);
 	}
 	if (i == VCHIQ_INIT_RETRIES) {
-		vchiq_log_error(vchiq_core_log_level, "%s: videocore not initialized\n", __func__);
+		pr_err("vchiq: %s: videocore not initialized\n", __func__);
 		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%s: videocore initialized after %d retries\n", __func__, i);
+		pr_warn("vchiq: %s: videocore initialized after %d retries\n", __func__, i);
 	}
 
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
-		vchiq_log_error(vchiq_core_log_level,
-				"%s: error allocating vchiq instance\n", __func__);
+		pr_err("vchiq: %s: error allocating vchiq instance\n", __func__);
 		ret = -ENOMEM;
 		goto failed;
 	}
@@ -747,7 +744,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 	ret = 0;
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, ret);
+	pr_debug("vchiq: %s(%p): returning %d", __func__, instance, ret);
 
 	return ret;
 }
@@ -760,8 +757,8 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 	list_for_each_entry_safe(waiter, next,
 				 &instance->bulk_waiter_list, list) {
 		list_del(&waiter->list);
-		vchiq_log_info(vchiq_arm_log_level, "bulk_waiter - cleaned up %pK for pid %d",
-			       waiter, waiter->pid);
+		dev_info(instance->state->dev, "bulk_waiter - cleaned up %pK for pid %d",
+			 waiter, waiter->pid);
 		kfree(waiter);
 	}
 }
@@ -779,7 +776,7 @@ int vchiq_shutdown(struct vchiq_instance *instance)
 
 	mutex_unlock(&state->mutex);
 
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	pr_debug("vchiq: %s(%p): returning %d", __func__, instance, status);
 
 	free_bulk_waiter(instance);
 	kfree(instance);
@@ -799,7 +796,7 @@ int vchiq_connect(struct vchiq_instance *instance)
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex)) {
-		vchiq_log_trace(vchiq_core_log_level, "%s: call to mutex_lock failed", __func__);
+		pr_debug("vchiq: %s: call to mutex_lock failed", __func__);
 		status = -EAGAIN;
 		goto failed;
 	}
@@ -811,7 +808,7 @@ int vchiq_connect(struct vchiq_instance *instance)
 	mutex_unlock(&state->mutex);
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	pr_debug("vchiq: %s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -842,7 +839,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 		status = -EINVAL;
 	}
 
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	pr_debug("vchiq: %s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -873,7 +870,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 	}
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	pr_debug("vchiq: %s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -997,7 +994,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	} else {
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter) {
-			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
+			dev_err(instance->state->dev, "%s - out of memory", __func__);
 			return -ENOMEM;
 		}
 	}
@@ -1020,8 +1017,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level, "saved bulk_waiter %pK for pid %d", waiter,
-			       current->pid);
+		dev_info(instance->state->dev, "saved bulk_waiter %pK for pid %d", waiter,
+			 current->pid);
 	}
 
 	return status;
@@ -1041,13 +1038,13 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
 		/* Out of space - wait for the client */
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-		vchiq_log_trace(vchiq_arm_log_level, "%s - completion queue full", __func__);
+		dev_dbg(instance->state->dev, "%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
 		if (wait_for_completion_interruptible(&instance->remove_event)) {
-			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
+			dev_info(instance->state->dev, "service_callback interrupted");
 			return -EAGAIN;
 		} else if (instance->closing) {
-			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
+			dev_info(instance->state->dev, "service_callback closing");
 			return 0;
 		}
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
@@ -1127,11 +1124,10 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 	vchiq_service_get(service);
 	rcu_read_unlock();
 
-	vchiq_log_trace(vchiq_arm_log_level,
-			"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
-			__func__, (unsigned long)user_service, service->localport,
-			user_service->userdata, reason, (unsigned long)header,
-			(unsigned long)instance, (unsigned long)bulk_userdata);
+	dev_dbg(service->state->dev, "%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
+		 __func__, (unsigned long)user_service, service->localport,
+		 user_service->userdata, reason, (unsigned long)header,
+		 (unsigned long)instance, (unsigned long)bulk_userdata);
 
 	if (header && user_service->is_vchi) {
 		spin_lock(&msg_queue_spinlock);
@@ -1140,7 +1136,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
-			vchiq_log_trace(vchiq_arm_log_level, "%s - msg queue full", __func__);
+			dev_dbg(service->state->dev, "%s - msg queue full", __func__);
 			/*
 			 * If there is no MESSAGE_AVAILABLE in the completion
 			 * queue, add one
@@ -1149,8 +1145,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 				instance->completion_remove) < 0) {
 				int status;
 
-				vchiq_log_info(vchiq_arm_log_level,
-					       "Inserting extra MESSAGE_AVAILABLE");
+				dev_info(service->state->dev, "Inserting extra MESSAGE_AVAILABLE");
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				status = add_completion(instance, reason, NULL, user_service,
 							bulk_userdata);
@@ -1163,12 +1158,12 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			if (wait_for_completion_interruptible(&user_service->remove_event)) {
-				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
+				dev_info(service->state->dev, "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
 				return -EAGAIN;
 			} else if (instance->closing) {
-				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
+				dev_info(service->state->dev, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
 				return -EINVAL;
@@ -1364,7 +1359,7 @@ vchiq_keepalive_vchiq_callback(struct vchiq_instance *instance,
 			       struct vchiq_header *header,
 			       unsigned int service_user, void *bulk_user)
 {
-	vchiq_log_error(vchiq_susp_log_level, "%s callback reason %d", __func__, reason);
+	dev_err(instance->state->dev, "%s callback reason %d", __func__, reason);
 	return 0;
 }
 
@@ -1388,22 +1383,19 @@ vchiq_keepalive_thread_func(void *v)
 
 	ret = vchiq_initialise(&instance);
 	if (ret) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_initialise failed %d", __func__,
-				ret);
+		pr_err("vchiq: %s vchiq_initialise failed %d", __func__, ret);
 		goto exit;
 	}
 
 	status = vchiq_connect(instance);
 	if (status) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
-				status);
+		pr_err("vchiq: %s vchiq_connect failed %d", __func__, status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
 	if (status) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
-				status);
+		pr_err("vchiq: %s vchiq_open_service failed %d", __func__, status);
 		goto shutdown;
 	}
 
@@ -1411,7 +1403,7 @@ vchiq_keepalive_thread_func(void *v)
 		long rc = 0, uc = 0;
 
 		if (wait_for_completion_interruptible(&arm_state->ka_evt)) {
-			vchiq_log_error(vchiq_susp_log_level, "%s interrupted", __func__);
+			pr_err("vchiq: %s interrupted", __func__);
 			flush_signals(current);
 			continue;
 		}
@@ -1431,16 +1423,14 @@ vchiq_keepalive_thread_func(void *v)
 			atomic_inc(&arm_state->ka_use_ack_count);
 			status = vchiq_use_service(instance, ka_handle);
 			if (status) {
-				vchiq_log_error(vchiq_susp_log_level,
-						"%s vchiq_use_service error %d", __func__, status);
+				pr_err("vchiq: %s vchiq_use_service error %d", __func__, status);
 			}
 		}
 		while (rc--) {
 			status = vchiq_release_service(instance, ka_handle);
 			if (status) {
-				vchiq_log_error(vchiq_susp_log_level,
-						"%s vchiq_release_service error %d", __func__,
-						status);
+				pr_err("vchiq: %s vchiq_release_service error %d", __func__,
+					status);
 			}
 		}
 	}
@@ -1475,7 +1465,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 			service->client_id);
 		entity_uc = &service->service_use_count;
 	} else {
-		vchiq_log_error(vchiq_susp_log_level, "%s null service ptr", __func__);
+		pr_err("vchiq: %s null service ptr", __func__);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1484,8 +1474,8 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	local_uc = ++arm_state->videocore_use_count;
 	++(*entity_uc);
 
-	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
-			*entity_uc, local_uc);
+	pr_debug("vchiq: %s %s count %d, state count %d", __func__, entity,
+		 *entity_uc, local_uc);
 
 	write_unlock_bh(&arm_state->susp_res_lock);
 
@@ -1504,7 +1494,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	}
 
 out:
-	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
+	pr_debug("vchiq: %s exit %d", __func__, ret);
 	return ret;
 }
 
@@ -1542,14 +1532,14 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	--arm_state->videocore_use_count;
 	--(*entity_uc);
 
-	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
-			*entity_uc, arm_state->videocore_use_count);
+	pr_debug("vchiq: %s %s count %d, state count %d", __func__, entity,
+		 *entity_uc, arm_state->videocore_use_count);
 
 unlock:
 	write_unlock_bh(&arm_state->susp_res_lock);
 
 out:
-	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
+	pr_debug("vchiq: %s exit %d", __func__, ret);
 	return ret;
 }
 
@@ -1723,18 +1713,17 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
-				  active_services, found);
+		pr_warn("vchiq: Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+			active_services, found);
 
 	for (i = 0; i < found; i++) {
-		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
-				  VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
-				  service_data[i].clientid, service_data[i].use_count,
-				  service_data[i].use_count ? nz : "");
+		pr_warn("vchiq: %c%c%c%c:%d service count %d %s",
+			VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
+			service_data[i].clientid, service_data[i].use_count,
+			service_data[i].use_count ? nz : "");
 	}
-	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
-	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
-			  vc_use_count);
+	pr_warn("vchiq: VCHIQ use count %d", peer_count);
+	pr_warn("vchiq: Overall vchiq instance use count %d", vc_use_count);
 
 	kfree(service_data);
 }
@@ -1756,10 +1745,9 @@ vchiq_check_service(struct vchiq_service *service)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (ret) {
-		vchiq_log_error(vchiq_susp_log_level,
-				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
-				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
-				service->service_use_count, arm_state->videocore_use_count);
+		pr_err("vchiq: %s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
+			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
+			service->service_use_count, arm_state->videocore_use_count);
 		vchiq_dump_service_use_state(service->state);
 	}
 out:
@@ -1773,8 +1761,8 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
 	char threadname[16];
 
-	vchiq_log_info(vchiq_susp_log_level, "%d: %s->%s", state->id,
-		       get_conn_state_name(oldstate), get_conn_state_name(newstate));
+	dev_info(state->dev, "%d: %s->%s", state->id, get_conn_state_name(oldstate),
+		 get_conn_state_name(newstate));
 	if (state->conn_state != VCHIQ_CONNSTATE_CONNECTED)
 		return;
 
@@ -1792,9 +1780,8 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 					      (void *)state,
 					      threadname);
 	if (IS_ERR(arm_state->ka_thread)) {
-		vchiq_log_error(vchiq_susp_log_level,
-				"vchiq: FATAL: couldn't create thread %s",
-				threadname);
+		dev_crit(state->dev, "vchiq: FATAL: couldn't create thread %s",
+			 threadname);
 	} else {
 		wake_up_process(arm_state->ka_thread);
 	}
@@ -1887,9 +1874,8 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	vchiq_debugfs_init();
 
-	vchiq_log_info(vchiq_arm_log_level,
-		       "vchiq: platform initialised - version %d (min %d)",
-		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
+	dev_info(&pdev->dev, "vchiq: platform initialised - version %d (min %d)",
+		 VCHIQ_VERSION, VCHIQ_VERSION_MIN);
 
 	/*
 	 * Simply exit on error since the function handles cleanup in
@@ -1897,8 +1883,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	 */
 	err = vchiq_register_chrdev(&pdev->dev);
 	if (err) {
-		vchiq_log_warning(vchiq_arm_log_level,
-				  "Failed to initialize vchiq cdev");
+		dev_warn(&pdev->dev, "Failed to initialize vchiq cdev");
 		goto error_exit;
 	}
 
@@ -1912,7 +1897,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	return 0;
 
 failed_platform_init:
-	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
+	pr_warn("vchiq: could not initialize vchiq platform\n");
 error_exit:
 	return err;
 }
-- 
2.39.0

