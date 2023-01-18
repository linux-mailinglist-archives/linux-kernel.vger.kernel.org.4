Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B3671C36
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjARMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjARMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:34:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB79298EC;
        Wed, 18 Jan 2023 03:58:26 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56FFB188D;
        Wed, 18 Jan 2023 12:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674043104;
        bh=MX/VKhRygTucZHrXs2ejjwm8W6G9SpqsUr+mFCsD8LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGohQyrcEeZndmNLCC1gihJnArbdeDyu+g0+pQmqfT6VqN1yFkTv5ZCpKJ+Mc0ZR0
         k42pWeOAKF1ClW4B4681G3eIn5h9VgCtnZTBVbHEhErhdRWh+VsiN1tRCME89f8aVR
         qLxLndUnkqEBk2JFVlzvzaSYHEXYAomBQgkZbAeI=
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
Subject: [RFC PATCH 1/4] staging: vc04_services: vchiq_core: Drop custom logging
Date:   Wed, 18 Jan 2023 17:28:07 +0530
Message-Id: <20230118115810.21979-2-umang.jain@ideasonboard.com>
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

Drop custom logging from the vchiq_core.c and use standard kernel
logging infrastructure (dev_dbg() and friends for struct Device
stuff) and pr_info (and similar) for vchiq_services/instances things.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 450 ++++++++----------
 1 file changed, 204 insertions(+), 246 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 4e705a447a62..7b3c57326d28 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -227,10 +227,11 @@ static const char *msg_type_str(unsigned int msg_type)
 static inline void
 set_service_state(struct vchiq_service *service, int newstate)
 {
-	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
-		       service->state->id, service->localport,
-		       srvstate_names[service->srvstate],
-		       srvstate_names[newstate]);
+	struct vchiq_state *state = service->state;
+
+	dev_info(state->dev, "%d: srv:%d %s->%s", state->id,
+		 service->localport, srvstate_names[service->srvstate],
+		 srvstate_names[newstate]);
 	service->srvstate = newstate;
 }
 
@@ -255,8 +256,7 @@ find_service_by_handle(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid service handle 0x%x", handle);
+	pr_info("vchiq: Invalid service handle 0x%x", handle);
 	return NULL;
 }
 
@@ -276,8 +276,7 @@ find_service_by_port(struct vchiq_state *state, unsigned int localport)
 		}
 		rcu_read_unlock();
 	}
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid port %u", localport);
+	dev_info(state->dev, "Invalid port %u", localport);
 	return NULL;
 }
 
@@ -297,8 +296,7 @@ find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid service handle 0x%x", handle);
+	pr_info("vchiq: Invalid service handle 0x%x", handle);
 	return NULL;
 }
 
@@ -320,8 +318,7 @@ find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int h
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid service handle 0x%x", handle);
+	pr_info("vchiq: Invalid service handle 0x%x", handle);
 	return service;
 }
 
@@ -469,15 +466,15 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 {
 	int status;
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
-			service->state->id, service->localport, reason_names[reason],
-			header, bulk_userdata);
+	dev_dbg(service->state->dev, "%d: callback:%d (%s, %pK, %pK)",
+		service->state->id, service->localport, reason_names[reason],
+		header, bulk_userdata);
 	status = service->base.callback(service->instance, reason, header, service->handle,
 					bulk_userdata);
 	if (status && (status != -EAGAIN)) {
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%d: ignoring ERROR from callback to service %x",
-				  service->state->id, service->handle);
+		dev_warn(service->state->dev,
+			 "%d: ignoring ERROR from callback to service %x",
+			 service->state->id, service->handle);
 		status = 0;
 	}
 
@@ -492,8 +489,8 @@ vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate)
 {
 	enum vchiq_connstate oldstate = state->conn_state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: %s->%s", state->id, conn_state_names[oldstate],
-		       conn_state_names[newstate]);
+	dev_info(state->dev, "%d: %s->%s", state->id, conn_state_names[oldstate],
+		 conn_state_names[newstate]);
 	state->conn_state = newstate;
 	vchiq_platform_conn_state_changed(state, oldstate, newstate);
 }
@@ -741,10 +738,9 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 		 */
 		complete(&quota->quota_event);
 	} else if (count == 0) {
-		vchiq_log_error(vchiq_core_log_level,
-				"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
-				port, quota->message_use_count, header, msgid, header->msgid,
-				header->size);
+		dev_err(state->dev,
+			"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
+			port, quota->message_use_count, header, msgid, header->msgid, header->size);
 		WARN(1, "invalid message use count\n");
 	}
 	if (!BITSET_IS_SET(service_found, port)) {
@@ -763,12 +759,12 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			 * it has dropped below its quota
 			 */
 			complete(&quota->quota_event);
-			vchiq_log_trace(vchiq_core_log_level, "%d: pfq:%d %x@%pK - slot_use->%d",
-					state->id, port, header->size, header, count - 1);
+			dev_dbg(state->dev, "%d: pfq:%d %x@%pK - slot_use->%d",
+				state->id, port, header->size, header, count - 1);
 		} else {
-			vchiq_log_error(vchiq_core_log_level,
-					"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
-					port, count, header, msgid, header->msgid, header->size);
+			dev_dbg(state->dev,
+				"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
+				port, count, header, msgid, header->msgid, header->size);
 			WARN(1, "bad slot use count\n");
 		}
 	}
@@ -809,9 +805,8 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 		 */
 		rmb();
 
-		vchiq_log_trace(vchiq_core_log_level, "%d: pfq %d=%pK %x %x",
-				state->id, slot_index, data, local->slot_queue_recycle,
-				slot_queue_available);
+		dev_dbg(state->dev, "%d: pfq %d=%pK %x %x", state->id, slot_index,
+			data, local->slot_queue_recycle, slot_queue_available);
 
 		/* Initialise the bitmask for services which have used this slot */
 		memset(service_found, 0, length);
@@ -831,9 +826,9 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
-				vchiq_log_error(vchiq_core_log_level,
-						"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
-						pos, header, msgid, header->msgid, header->size);
+				dev_err(state->dev,
+					"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
+					pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -980,10 +975,10 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		       ((tx_end_index != quota->previous_tx_index) &&
 			(quota->slot_use_count == quota->slot_quota))) {
 			spin_unlock(&quota_spinlock);
-			vchiq_log_trace(vchiq_core_log_level,
-					"%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
-					state->id, service->localport, msg_type_str(type), size,
-					quota->message_use_count, quota->slot_use_count);
+			dev_dbg(state->dev,
+				"%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
+				state->id, service->localport, msg_type_str(type), size,
+				quota->message_use_count, quota->slot_use_count);
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
 			if (wait_for_completion_interruptible(&quota->quota_event))
@@ -1023,9 +1018,9 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		int tx_end_index;
 		int slot_use_count;
 
-		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
-			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
+		dev_info(state->dev, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+			 msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
+			 VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
 		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
 				 QMFLAGS_NO_MUTEX_UNLOCK));
@@ -1075,17 +1070,17 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		spin_unlock(&quota_spinlock);
 
 		if (slot_use_count)
-			vchiq_log_trace(vchiq_core_log_level,
-					"%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
-					service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-					size, slot_use_count, header);
+			dev_dbg(state->dev,
+				"%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
+				service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+				size, slot_use_count, header);
 
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
-		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
-			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
+		dev_dbg(state->dev, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+			msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
+			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
 			/*
 			 * It is assumed for now that this code path
@@ -1113,11 +1108,11 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		vchiq_log_info(SRVTRACE_LEVEL(service),
-			       "Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
-			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-			       VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
-			       VCHIQ_MSG_DSTPORT(msgid), size);
+		dev_info(state->dev,
+			 "Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
+			 msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+			 VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+			 VCHIQ_MSG_DSTPORT(msgid), size);
 	}
 
 	/* Make sure the new header is visible to the peer. */
@@ -1168,15 +1163,15 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		int oldmsgid = header->msgid;
 
 		if (oldmsgid != VCHIQ_MSGID_PADDING)
-			vchiq_log_error(vchiq_core_log_level, "%d: qms - msgid %x, not PADDING",
-					state->id, oldmsgid);
+			dev_err(state->dev, "%d: qms - msgid %x, not PADDING",
+				state->id, oldmsgid);
 	}
 
-	vchiq_log_info(vchiq_sync_log_level,
-		       "%d: qms %s@%pK,%x (%d->%d)", state->id,
-		       msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-		       header, size, VCHIQ_MSG_SRCPORT(msgid),
-		       VCHIQ_MSG_DSTPORT(msgid));
+	dev_info(state->dev,
+		 "%d: qms %s@%pK,%x (%d->%d)", state->id,
+		 msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+		 header, size, VCHIQ_MSG_SRCPORT(msgid),
+		 VCHIQ_MSG_DSTPORT(msgid));
 
 	callback_result =
 		copy_message_data(copy_callback, context,
@@ -1211,11 +1206,11 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		vchiq_log_trace(vchiq_sync_log_level,
-				"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
-				msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-				VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
-				VCHIQ_MSG_DSTPORT(msgid), size);
+		dev_dbg(state->dev,
+			"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
+			msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+			VCHIQ_MSG_DSTPORT(msgid), size);
 	}
 
 	remote_event_signal(&state->remote->sync_trigger);
@@ -1268,9 +1263,9 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
 			VCHIQ_SLOT_QUEUE_MASK] =
 			SLOT_INDEX_FROM_INFO(state, slot_info);
 		state->remote->slot_queue_recycle = slot_queue_recycle + 1;
-		vchiq_log_info(vchiq_core_log_level, "%d: %s %d - recycle->%x", state->id, __func__,
-			       SLOT_INDEX_FROM_INFO(state, slot_info),
-			       state->remote->slot_queue_recycle);
+		dev_info(state->dev, "%d: %s %d - recycle->%x", state->id, __func__,
+			 SLOT_INDEX_FROM_INFO(state, slot_info),
+			 state->remote->slot_queue_recycle);
 
 		/*
 		 * A write barrier is necessary, but remote_event_signal
@@ -1305,9 +1300,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 {
 	int status = 0;
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
-			service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
-			queue->process, queue->remote_notify, queue->remove);
+	dev_dbg(service->state->dev, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
+		service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
+		queue->process, queue->remote_notify, queue->remove);
 
 	queue->remote_notify = queue->process;
 
@@ -1387,9 +1382,8 @@ poll_services_of_group(struct vchiq_state *state, int group)
 
 		service_flags = atomic_xchg(&service->poll_flags, 0);
 		if (service_flags & BIT(VCHIQ_POLL_REMOVE)) {
-			vchiq_log_info(vchiq_core_log_level, "%d: ps - remove %d<->%d",
-				       state->id, service->localport,
-				       service->remoteport);
+			dev_info(state->dev, "%d: ps - remove %d<->%d",
+				 state->id, service->localport, service->remoteport);
 
 			/*
 			 * Make it look like a client, because
@@ -1401,8 +1395,8 @@ poll_services_of_group(struct vchiq_state *state, int group)
 			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_REMOVE);
 		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
-			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
-				       state->id, service->localport, service->remoteport);
+			dev_dbg(state->dev, "%d: ps - terminate %d<->%d",
+				state->id, service->localport, service->remoteport);
 			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_TERMINATE);
 		}
@@ -1431,9 +1425,9 @@ abort_outstanding_bulks(struct vchiq_service *service,
 {
 	int is_tx = (queue == &service->bulk_tx);
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: aob:%d %cx - li=%x ri=%x p=%x",
-			service->state->id, service->localport, is_tx ? 't' : 'r',
-			queue->local_insert, queue->remote_insert, queue->process);
+	dev_dbg(service->state->dev, "%d: aob:%d %cx - li=%x ri=%x p=%x",
+		service->state->id, service->localport, is_tx ? 't' : 'r',
+		queue->local_insert, queue->remote_insert, queue->process);
 
 	WARN_ON((int)(queue->local_insert - queue->process) < 0);
 	WARN_ON((int)(queue->remote_insert - queue->process) < 0);
@@ -1452,11 +1446,11 @@ abort_outstanding_bulks(struct vchiq_service *service,
 		if (queue->process != queue->local_insert) {
 			vchiq_complete_bulk(service->instance, bulk);
 
-			vchiq_log_info(SRVTRACE_LEVEL(service),
-				       "%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
-				       is_tx ? "Send Bulk to" : "Recv Bulk from",
-				       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-				       service->remoteport, bulk->size, bulk->remote_size);
+			dev_dbg(service->state->dev,
+				"%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
+				is_tx ? "Send Bulk to" : "Recv Bulk from",
+				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+				service->remoteport, bulk->size, bulk->remote_size);
 		} else {
 			/* fabricate a matching dummy bulk */
 			bulk->data = 0;
@@ -1489,8 +1483,8 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	payload = (struct vchiq_open_payload *)header->data;
 	fourcc = payload->fourcc;
-	vchiq_log_info(vchiq_core_log_level, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
-		       state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
+	dev_info(state->dev, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
+		 state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
 
 	service = get_listening_service(state, fourcc);
 	if (!service)
@@ -1502,11 +1496,9 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	if ((service->version < version_min) || (version < service->version_min)) {
 		/* Version mismatch */
-		vchiq_loud_error_header();
-		vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
-				 state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
-				 service->version, service->version_min, version, version_min);
-		vchiq_loud_error_footer();
+		pr_err("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
+		       state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
+		       service->version, service->version_min, version, version_min);
 		vchiq_service_put(service);
 		service = NULL;
 		goto fail_open;
@@ -1614,17 +1606,17 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				vchiq_service_put(service);
 			service = get_connected_service(state, remoteport);
 			if (service)
-				vchiq_log_warning(vchiq_core_log_level,
-						  "%d: prs %s@%pK (%d->%d) - found connected service %d",
-						  state->id, msg_type_str(type), header,
-						  remoteport, localport, service->localport);
+				dev_warn(state->dev,
+					 "%d: prs %s@%pK (%d->%d) - found connected service %d",
+					 state->id, msg_type_str(type), header,
+					 remoteport, localport, service->localport);
 		}
 
 		if (!service) {
-			vchiq_log_error(vchiq_core_log_level,
-					"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
-					state->id, msg_type_str(type), header, remoteport,
-					localport, localport);
+			dev_err(state->dev,
+				"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
+				state->id, msg_type_str(type), header, remoteport,
+				localport, localport);
 			goto skip_message;
 		}
 		break;
@@ -1638,19 +1630,19 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		svc_fourcc = service
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
-		vchiq_log_info(SRVTRACE_LEVEL(service),
-			       "Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
-			       msg_type_str(type), type, VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-			       remoteport, localport, size);
+		dev_info(service->state->dev,
+			 "Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
+			 msg_type_str(type), type, VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
+			 remoteport, localport, size);
 		if (size > 0)
 			vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
 	}
 
 	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
 	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
-		vchiq_log_error(vchiq_core_log_level,
-				"header %pK (msgid %x) - size %x too big for slot",
-				header, (unsigned int)msgid, (unsigned int)size);
+		dev_err(service->state->dev,
+			"header %pK (msgid %x) - size %x too big for slot",
+			header, (unsigned int)msgid, (unsigned int)size);
 		WARN(1, "oversized for slot\n");
 	}
 
@@ -1667,36 +1659,36 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				header->data;
 			service->peer_version = payload->version;
 		}
-		vchiq_log_info(vchiq_core_log_level, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
-			       state->id, header, size, remoteport, localport,
-			       service->peer_version);
+		dev_info(state->dev, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
+			 state->id, header, size, remoteport, localport,
+			 service->peer_version);
 		if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 			service->remoteport = remoteport;
 			set_service_state(service, VCHIQ_SRVSTATE_OPEN);
 			complete(&service->remove_event);
 		} else {
-			vchiq_log_error(vchiq_core_log_level, "OPENACK received in state %s",
-					srvstate_names[service->srvstate]);
+			dev_err(state->dev, "OPENACK received in state %s",
+				srvstate_names[service->srvstate]);
 		}
 		break;
 	case VCHIQ_MSG_CLOSE:
 		WARN_ON(size); /* There should be no data */
 
-		vchiq_log_info(vchiq_core_log_level, "%d: prs CLOSE@%pK (%d->%d)",
-			       state->id, header, remoteport, localport);
+		dev_info(state->dev, "%d: prs CLOSE@%pK (%d->%d)",
+			 state->id, header, remoteport, localport);
 
 		mark_service_closing_internal(service, 1);
 
 		if (vchiq_close_service_internal(service, CLOSE_RECVD) == -EAGAIN)
 			goto bail_not_ready;
 
-		vchiq_log_info(vchiq_core_log_level, "Close Service %c%c%c%c s:%u d:%d",
-			       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-			       service->localport, service->remoteport);
+		dev_info(state->dev, "Close Service %c%c%c%c s:%u d:%d",
+			 VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+			 service->localport, service->remoteport);
 		break;
 	case VCHIQ_MSG_DATA:
-		vchiq_log_info(vchiq_core_log_level, "%d: prs DATA@%pK,%x (%d->%d)",
-			       state->id, header, size, remoteport, localport);
+		dev_info(state->dev, "%d: prs DATA@%pK,%x (%d->%d)",
+			 state->id, header, size, remoteport, localport);
 
 		if ((service->remoteport == remoteport) &&
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN)) {
@@ -1715,7 +1707,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_CONNECT:
-		vchiq_log_info(vchiq_core_log_level, "%d: prs CONNECT@%pK", state->id, header);
+		dev_info(state->dev, "%d: prs CONNECT@%pK", state->id, header);
 		state->version_common =	((struct vchiq_slot_zero *)
 					 state->slot_data)->version;
 		complete(&state->connect);
@@ -1746,19 +1738,17 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			}
 			if ((int)(queue->remote_insert -
 				queue->local_insert) >= 0) {
-				vchiq_log_error(vchiq_core_log_level,
-						"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
-						state->id, msg_type_str(type), header, remoteport,
-						localport, queue->remote_insert,
-						queue->local_insert);
+				dev_err(state->dev,
+					"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
+					state->id, msg_type_str(type), header, remoteport,
+					localport, queue->remote_insert,
+					queue->local_insert);
 				mutex_unlock(&service->bulk_mutex);
 				break;
 			}
 			if (queue->process != queue->remote_insert) {
-				pr_err("%s: p %x != ri %x\n",
-				       __func__,
-				       queue->process,
-				       queue->remote_insert);
+				pr_err("%s: p %x != ri %x\n", __func__,
+				       queue->process, queue->remote_insert);
 				mutex_unlock(&service->bulk_mutex);
 				goto bail_not_ready;
 			}
@@ -1767,14 +1757,14 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			bulk->actual = *(int *)header->data;
 			queue->remote_insert++;
 
-			vchiq_log_info(vchiq_core_log_level, "%d: prs %s@%pK (%d->%d) %x@%pad",
-				       state->id, msg_type_str(type), header, remoteport, localport,
-				       bulk->actual, &bulk->data);
+			dev_info(state->dev, "%d: prs %s@%pK (%d->%d) %x@%pad",
+				 state->id, msg_type_str(type), header, remoteport, localport,
+				 bulk->actual, &bulk->data);
 
-			vchiq_log_trace(vchiq_core_log_level, "%d: prs:%d %cx li=%x ri=%x p=%x",
-					state->id, localport,
-					(type == VCHIQ_MSG_BULK_RX_DONE) ? 'r' : 't',
-					queue->local_insert, queue->remote_insert, queue->process);
+			dev_dbg(state->dev, "%d: prs:%d %cx li=%x ri=%x p=%x",
+				state->id, localport,
+				(type == VCHIQ_MSG_BULK_RX_DONE) ? 'r' : 't',
+				queue->local_insert, queue->remote_insert, queue->process);
 
 			DEBUG_TRACE(PARSE_LINE);
 			WARN_ON(queue->process == queue->local_insert);
@@ -1787,16 +1777,14 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_PADDING:
-		vchiq_log_trace(vchiq_core_log_level, "%d: prs PADDING@%pK,%x",
-				state->id, header, size);
+		dev_dbg(state->dev, "%d: prs PADDING@%pK,%x", state->id, header, size);
 		break;
 	case VCHIQ_MSG_PAUSE:
 		/* If initiated, signal the application thread */
-		vchiq_log_trace(vchiq_core_log_level, "%d: prs PAUSE@%pK,%x",
-				state->id, header, size);
+		dev_dbg(state->dev, "%d: prs PAUSE@%pK,%x", state->id, header, size);
 		if (state->conn_state == VCHIQ_CONNSTATE_PAUSED) {
-			vchiq_log_error(vchiq_core_log_level, "%d: PAUSE received in state PAUSED",
-					state->id);
+			dev_dbg(state->dev, "%d: PAUSE received in state PAUSED",
+				state->id);
 			break;
 		}
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
@@ -1809,8 +1797,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSED);
 		break;
 	case VCHIQ_MSG_RESUME:
-		vchiq_log_trace(vchiq_core_log_level, "%d: prs RESUME@%pK,%x",
-				state->id, header, size);
+		dev_dbg(state->dev, "%d: prs RESUME@%pK,%x", state->id, header, size);
 		/* Release the slot mutex */
 		mutex_unlock(&state->slot_mutex);
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
@@ -1826,8 +1813,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%d: prs invalid msgid %x@%pK,%x",
-				state->id, msgid, header, size);
+		dev_err(state->dev, "%d: prs invalid msgid %x@%pK,%x",
+			state->id, msgid, header, size);
 		WARN(1, "invalid message\n");
 		break;
 	}
@@ -1937,7 +1924,7 @@ handle_poll(struct vchiq_state *state)
 			 * since the PAUSE should have flushed
 			 * through outstanding messages.
 			 */
-			vchiq_log_error(vchiq_core_log_level, "Failed to send RESUME message");
+			dev_info(state->dev, "Failed to send RESUME message");
 		}
 		break;
 	default:
@@ -2036,10 +2023,10 @@ sync_func(void *v)
 		service = find_service_by_port(state, localport);
 
 		if (!service) {
-			vchiq_log_error(vchiq_sync_log_level,
-					"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
-					state->id, msg_type_str(type), header,
-					remoteport, localport, localport);
+			dev_err(state->dev,
+				"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
+				state->id, msg_type_str(type), header,
+				remoteport, localport, localport);
 			release_message_sync(state, header);
 			continue;
 		}
@@ -2050,10 +2037,10 @@ sync_func(void *v)
 			svc_fourcc = service
 				? service->base.fourcc
 				: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
-			vchiq_log_trace(vchiq_sync_log_level,
-					"Rcvd Msg %s from %c%c%c%c s:%d d:%d len:%d",
-					msg_type_str(type), VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-					remoteport, localport, size);
+			dev_dbg(state->dev,
+				"Rcvd Msg %s from %c%c%c%c s:%d d:%d len:%d",
+				msg_type_str(type), VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
+				remoteport, localport, size);
 			if (size > 0)
 				vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
 		}
@@ -2066,9 +2053,9 @@ sync_func(void *v)
 					header->data;
 				service->peer_version = payload->version;
 			}
-			vchiq_log_info(vchiq_sync_log_level, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
-				       state->id, header, size, remoteport, localport,
-				       service->peer_version);
+			dev_info(state->dev, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
+				 state->id, header, size, remoteport, localport,
+				 service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 				service->remoteport = remoteport;
 				set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
@@ -2079,22 +2066,22 @@ sync_func(void *v)
 			break;
 
 		case VCHIQ_MSG_DATA:
-			vchiq_log_trace(vchiq_sync_log_level, "%d: sf DATA@%pK,%x (%d->%d)",
-					state->id, header, size, remoteport, localport);
+			dev_dbg(state->dev, "%d: sf DATA@%pK,%x (%d->%d)",
+				state->id, header, size, remoteport, localport);
 
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
 				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
 							  NULL) == -EAGAIN)
-					vchiq_log_error(vchiq_sync_log_level,
-							"synchronous callback to service %d returns -EAGAIN",
-							localport);
+					dev_err(state->dev,
+						"synchronous callback to service %d returns -EAGAIN",
+						localport);
 			}
 			break;
 
 		default:
-			vchiq_log_error(vchiq_sync_log_level, "%d: sf unexpected msgid %x@%pK,%x",
-					state->id, msgid, header, size);
+			dev_err(state->dev, "%d: sf unexpected msgid %x@%pK,%x",
+				state->id, msgid, header, size);
 			release_message_sync(state, header);
 			break;
 		}
@@ -2127,8 +2114,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
 	num_slots -= first_data_slot;
 
 	if (num_slots < 4) {
-		vchiq_log_error(vchiq_core_log_level, "%s - insufficient memory %x bytes",
-				__func__, mem_size);
+		pr_err("vchiq: %s - insufficient memory %x bytes", __func__, mem_size);
 		return NULL;
 	}
 
@@ -2164,12 +2150,10 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	remote = &slot_zero->master;
 
 	if (local->initialised) {
-		vchiq_loud_error_header();
 		if (remote->initialised)
-			vchiq_loud_error("local state has already been initialised");
+			pr_err("vchiq: local state has already been initialised");
 		else
-			vchiq_loud_error("master/slave mismatch two slaves");
-		vchiq_loud_error_footer();
+			pr_err("vchiq: master/slave mismatch two slaves");
 		return -EINVAL;
 	}
 
@@ -2247,9 +2231,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	state->slot_handler_thread = kthread_create(&slot_handler_func, (void *)state, threadname);
 
 	if (IS_ERR(state->slot_handler_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		pr_err("vchiq: couldn't create thread %s", threadname);
 		return PTR_ERR(state->slot_handler_thread);
 	}
 	set_user_nice(state->slot_handler_thread, -19);
@@ -2257,9 +2239,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	snprintf(threadname, sizeof(threadname), "vchiq-recy/%d", state->id);
 	state->recycle_thread = kthread_create(&recycle_func, (void *)state, threadname);
 	if (IS_ERR(state->recycle_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		pr_err("vchiq: couldn't create thread %s", threadname);
 		ret = PTR_ERR(state->recycle_thread);
 		goto fail_free_handler_thread;
 	}
@@ -2268,9 +2248,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	snprintf(threadname, sizeof(threadname), "vchiq-sync/%d", state->id);
 	state->sync_thread = kthread_create(&sync_func, (void *)state, threadname);
 	if (IS_ERR(state->sync_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		pr_err("vchiq: couldn't create thread %s", threadname);
 		ret = PTR_ERR(state->sync_thread);
 		goto fail_free_recycle_thread;
 	}
@@ -2346,7 +2324,7 @@ EXPORT_SYMBOL(vchiq_msg_hold);
 static int vchiq_validate_params(const struct vchiq_service_params_kernel *params)
 {
 	if (!params->callback || !params->fourcc) {
-		vchiq_loud_error("Can't add service, invalid params\n");
+		pr_err("vchiq: Can't add service, invalid params\n");
 		return -EINVAL;
 	}
 
@@ -2476,9 +2454,9 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	/* Bring this service online */
 	set_service_state(service, srvstate);
 
-	vchiq_log_info(vchiq_core_msg_log_level, "%s Service %c%c%c%c SrcPort:%d",
-		       (srvstate == VCHIQ_SRVSTATE_OPENING) ? "Open" : "Add",
-		       VCHIQ_FOURCC_AS_4CHARS(params->fourcc), service->localport);
+	pr_info("vchiq: %s Service %c%c%c%c SrcPort:%d",
+		(srvstate == VCHIQ_SRVSTATE_OPENING) ? "Open" : "Add",
+		VCHIQ_FOURCC_AS_4CHARS(params->fourcc), service->localport);
 
 	/* Don't unlock the service - leave it with a ref_count of 1. */
 
@@ -2515,11 +2493,11 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 	} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
 		   (service->srvstate != VCHIQ_SRVSTATE_OPENSYNC)) {
 		if (service->srvstate != VCHIQ_SRVSTATE_CLOSEWAIT)
-			vchiq_log_error(vchiq_core_log_level,
-					"%d: osi - srvstate = %s (ref %u)",
-					service->state->id,
-					srvstate_names[service->srvstate],
-					kref_read(&service->ref_count));
+			dev_err(service->state->dev,
+				"%d: osi - srvstate = %s (ref %u)",
+				service->state->id,
+				srvstate_names[service->srvstate],
+				kref_read(&service->ref_count));
 		status = -EINVAL;
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
 		vchiq_release_service_internal(service);
@@ -2574,14 +2552,14 @@ release_service_messages(struct vchiq_service *service)
 			int port = VCHIQ_MSG_DSTPORT(msgid);
 
 			if ((port == service->localport) && (msgid & VCHIQ_MSGID_CLAIMED)) {
-				vchiq_log_info(vchiq_core_log_level, "  fsi - hdr %pK", header);
+				dev_info(state->dev, "  fsi - hdr %pK", header);
 				release_slot(state, slot_info, header, NULL);
 			}
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
-				vchiq_log_error(vchiq_core_log_level,
-						"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
-						pos, header, msgid, header->msgid, header->size);
+				dev_err(state->dev,
+					"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
+					pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -2635,8 +2613,8 @@ close_service_complete(struct vchiq_service *service, int failstate)
 	case VCHIQ_SRVSTATE_LISTENING:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%s(%x) called in state %s", __func__,
-				service->handle, srvstate_names[service->srvstate]);
+		dev_err(service->state->dev, "%s(%x) called in state %s", __func__,
+			service->handle, srvstate_names[service->srvstate]);
 		WARN(1, "%s in unexpected state\n", __func__);
 		return -EINVAL;
 	}
@@ -2682,8 +2660,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	int close_id = MAKE_CLOSE(service->localport,
 				  VCHIQ_MSG_DSTPORT(service->remoteport));
 
-	vchiq_log_info(vchiq_core_log_level, "%d: csi:%d,%d (%s)", service->state->id,
-		       service->localport, close_recvd, srvstate_names[service->srvstate]);
+	dev_err(state->dev, "%d: csi:%d,%d (%s)", service->state->id,
+		service->localport, close_recvd, srvstate_names[service->srvstate]);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_CLOSED:
@@ -2691,8 +2669,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_LISTENING:
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		if (close_recvd) {
-			vchiq_log_error(vchiq_core_log_level, "%s(1) called in state %s",
-					__func__, srvstate_names[service->srvstate]);
+			dev_err(state->dev, "%s(1) called in state %s",
+				__func__, srvstate_names[service->srvstate]);
 		} else if (is_server) {
 			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
 				status = -EINVAL;
@@ -2779,8 +2757,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%s(%d) called in state %s", __func__,
-				close_recvd, srvstate_names[service->srvstate]);
+		dev_err(state->dev, "%s(%d) called in state %s", __func__,
+			close_recvd, srvstate_names[service->srvstate]);
 		break;
 	}
 
@@ -2793,8 +2771,8 @@ vchiq_terminate_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: tsi - (%d<->%d)", state->id,
-		       service->localport, service->remoteport);
+	dev_info(state->dev, "%d: tsi - (%d<->%d)", state->id,
+		 service->localport, service->remoteport);
 
 	mark_service_closing(service);
 
@@ -2808,7 +2786,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: fsi - (%d)", state->id, service->localport);
+	dev_info(state->dev, "%d: fsi - (%d)", state->id, service->localport);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPENING:
@@ -2818,8 +2796,8 @@ vchiq_free_service_internal(struct vchiq_service *service)
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%d: fsi - (%d) in state %s", state->id,
-				service->localport, srvstate_names[service->srvstate]);
+		dev_err(state->dev, "%d: fsi - (%d) in state %s", state->id,
+			service->localport, srvstate_names[service->srvstate]);
 		return;
 	}
 
@@ -2888,8 +2866,8 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 	if (!service)
 		return -EINVAL;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: close_service:%d",
-		       service->state->id, service->localport);
+	dev_info(service->state->dev, "%d: close_service:%d",
+		 service->state->id, service->localport);
 
 	if ((service->srvstate == VCHIQ_SRVSTATE_FREE) ||
 	    (service->srvstate == VCHIQ_SRVSTATE_LISTENING) ||
@@ -2919,10 +2897,10 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN))
 			break;
 
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%d: close_service:%d - waiting in state %s",
-				  service->state->id, service->localport,
-				  srvstate_names[service->srvstate]);
+		dev_warn(service->state->dev,
+			 "%d: close_service:%d - waiting in state %s",
+			 service->state->id, service->localport,
+			 srvstate_names[service->srvstate]);
 	}
 
 	if (!status &&
@@ -2946,8 +2924,8 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 	if (!service)
 		return -EINVAL;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: remove_service:%d",
-		       service->state->id, service->localport);
+	dev_info(service->state->dev, "%d: remove_service:%d",
+		 service->state->id, service->localport);
 
 	if (service->srvstate == VCHIQ_SRVSTATE_FREE) {
 		vchiq_service_put(service);
@@ -2980,10 +2958,10 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN))
 			break;
 
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%d: remove_service:%d - waiting in state %s",
-				  service->state->id, service->localport,
-				  srvstate_names[service->srvstate]);
+		dev_warn(service->state->dev,
+			 "%d: remove_service:%d - waiting in state %s",
+			 service->state->id, service->localport,
+			 srvstate_names[service->srvstate]);
 	}
 
 	if (!status && (service->srvstate != VCHIQ_SRVSTATE_FREE))
@@ -3090,9 +3068,9 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	 */
 	wmb();
 
-	vchiq_log_info(vchiq_core_log_level, "%d: bt (%d->%d) %cx %x@%pad %pK",
-		       state->id, service->localport, service->remoteport,
-		       dir_char, size, &bulk->data, userdata);
+	dev_info(state->dev, "%d: bt (%d->%d) %cx %x@%pad %pK",
+		 state->id, service->localport, service->remoteport,
+		 dir_char, size, &bulk->data, userdata);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
@@ -3127,9 +3105,9 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	mutex_unlock(&state->slot_mutex);
 	mutex_unlock(&service->bulk_mutex);
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: bt:%d %cx li=%x ri=%x p=%x",
-			state->id, service->localport, dir_char, queue->local_insert,
-			queue->remote_insert, queue->process);
+	dev_err(state->dev, "%d: bt:%d %cx li=%x ri=%x p=%x",
+		state->id, service->localport, dir_char, queue->local_insert,
+		queue->remote_insert, queue->process);
 
 waiting:
 	vchiq_service_put(service);
@@ -3618,26 +3596,6 @@ int vchiq_dump_service_state(void *dump_context, struct vchiq_service *service)
 	return err;
 }
 
-void
-vchiq_loud_error_header(void)
-{
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level, "=====");
-}
-
-void
-vchiq_loud_error_footer(void)
-{
-	vchiq_log_error(vchiq_core_log_level, "=====");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-}
-
 int vchiq_send_remote_use(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
@@ -3684,9 +3642,9 @@ void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_
 		*s++ = '\0';
 
 		if (label && (*label != '\0'))
-			vchiq_log_trace(VCHIQ_LOG_TRACE, "%s: %08x: %s", label, addr, line_buf);
+			pr_debug("vchiq: %s: %08x: %s", label, addr, line_buf);
 		else
-			vchiq_log_trace(VCHIQ_LOG_TRACE, "%08x: %s", addr, line_buf);
+			pr_debug("vchiq: %08x: %s", addr, line_buf);
 
 		addr += 16;
 		mem += 16;
-- 
2.39.0

