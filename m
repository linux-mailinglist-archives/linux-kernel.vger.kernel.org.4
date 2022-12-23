Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7827D655049
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiLWMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiLWMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:24:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A013722D;
        Fri, 23 Dec 2022 04:24:28 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:cd5d:4e48:3b91:9262:9565])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41BF1881;
        Fri, 23 Dec 2022 13:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671798266;
        bh=i+l5WvbdnzZvotT55RfMmOFaGgJdX/zxUqBtEXLbNJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGx0wLoN+oS6yp+YTlIesB2KwWJUSeCvUWzj4tg0I3BfFQ5izfJjyM/6E+vD3eiIa
         1hjQRqxrsmDYdH5hTEbnNNAuNvGWvr9rnMvfHBB1taLPn5L2efe4RogNIDeMtqLyHq
         Viyf/FtNFsK0923pznBhpZEfpNBU5lfnHcgcEFQs=
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
Subject: [PATCH v3 1/7] staging: vc04_services: Replace vchiq_status return type to int
Date:   Fri, 23 Dec 2022 17:53:58 +0530
Message-Id: <20221223122404.170585-2-umang.jain@ideasonboard.com>
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

Modify the functions' signature using enum vchiq_status to return int.
Currently, this patch only touches the function signatures and
in subsequent patches each vchiq_status enumerated value will be
replaced by a integer value.

This patch acts as an initial point to address the TODO item:
	* Get rid of custom function return values
for vc04_services/interface.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  8 +--
 .../include/linux/raspberrypi/vchiq.h         | 59 +++++++++----------
 .../interface/vchiq_arm/vchiq_arm.c           | 32 +++++-----
 .../interface/vchiq_arm/vchiq_arm.h           | 12 ++--
 .../interface/vchiq_arm/vchiq_core.c          | 34 +++++------
 .../interface/vchiq_arm/vchiq_core.h          | 18 +++---
 .../interface/vchiq_arm/vchiq_ioctl.h         |  8 +--
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  7 +--
 8 files changed, 88 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index f4c2c9506d86..0fd92affc264 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -91,10 +91,10 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 	return bcm2835_audio_send_msg(instance, &m, wait);
 }
 
-static enum vchiq_status audio_vchi_callback(struct vchiq_instance *vchiq_instance,
-					     enum vchiq_reason reason,
-					     struct vchiq_header *header,
-					     unsigned int handle, void *userdata)
+static int audio_vchi_callback(struct vchiq_instance *vchiq_instance,
+			       enum vchiq_reason reason,
+			       struct vchiq_header *header,
+			       unsigned int handle, void *userdata)
 {
 	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(vchiq_instance,
 									     handle);
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index db1441c0cc66..71f4cb5d5cfd 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -57,11 +57,11 @@ struct vchiq_instance;
 
 struct vchiq_service_base {
 	int fourcc;
-	enum vchiq_status (*callback)(struct vchiq_instance *instance,
-				      enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
+	int (*callback)(struct vchiq_instance *instance,
+			enum vchiq_reason reason,
+			struct vchiq_header *header,
+			unsigned int handle,
+			void *bulk_userdata);
 	void *userdata;
 };
 
@@ -74,11 +74,11 @@ struct vchiq_completion_data_kernel {
 
 struct vchiq_service_params_kernel {
 	int fourcc;
-	enum vchiq_status (*callback)(struct vchiq_instance *instance,
-				      enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
+	int (*callback)(struct vchiq_instance *instance,
+			enum vchiq_reason reason,
+			struct vchiq_header *header,
+			unsigned int handle,
+			void *bulk_userdata);
 	void *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
@@ -86,33 +86,32 @@ struct vchiq_service_params_kernel {
 
 struct vchiq_instance;
 
-extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
-extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
-	const struct vchiq_service_params_kernel *params,
-	unsigned int *pservice);
-extern enum vchiq_status vchiq_close_service(struct vchiq_instance *instance,
-					     unsigned int service);
-extern enum vchiq_status vchiq_use_service(struct vchiq_instance *instance, unsigned int service);
-extern enum vchiq_status vchiq_release_service(struct vchiq_instance *instance,
-					       unsigned int service);
+extern int vchiq_initialise(struct vchiq_instance **pinstance);
+extern int vchiq_shutdown(struct vchiq_instance *instance);
+extern int vchiq_connect(struct vchiq_instance *instance);
+extern int vchiq_open_service(struct vchiq_instance *instance,
+			      const struct vchiq_service_params_kernel *params,
+			      unsigned int *pservice);
+extern int vchiq_close_service(struct vchiq_instance *instance,
+			       unsigned int service);
+extern int vchiq_use_service(struct vchiq_instance *instance, unsigned int service);
+extern int vchiq_release_service(struct vchiq_instance *instance,
+				 unsigned int service);
 extern void vchiq_msg_queue_push(struct vchiq_instance *instance, unsigned int handle,
 				 struct vchiq_header *header);
 extern void vchiq_release_message(struct vchiq_instance *instance, unsigned int service,
 				  struct vchiq_header *header);
 extern int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle,
 				      void *data, unsigned int size);
-extern enum vchiq_status vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int service,
-					     const void *data, unsigned int size, void *userdata,
-					     enum vchiq_bulk_mode mode);
-extern enum vchiq_status vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int service,
-					    void *data, unsigned int size, void *userdata,
-					    enum vchiq_bulk_mode mode);
+extern int vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int service,
+			       const void *data, unsigned int size, void *userdata,
+			       enum vchiq_bulk_mode mode);
+extern int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int service,
+			      void *data, unsigned int size, void *userdata,
+			      enum vchiq_bulk_mode mode);
 extern void *vchiq_get_service_userdata(struct vchiq_instance *instance, unsigned int service);
-extern enum vchiq_status vchiq_get_peer_version(struct vchiq_instance *instance,
-						unsigned int handle,
-						short *peer_version);
+extern int vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle,
+				  short *peer_version);
 extern struct vchiq_header *vchiq_msg_hold(struct vchiq_instance *instance, unsigned int handle);
 
 #endif /* VCHIQ_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index dc33490ba7fb..fa92c34890e0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -151,7 +151,7 @@ static struct semaphore g_free_fragments_sema;
 
 static DEFINE_SEMAPHORE(g_free_fragments_mutex);
 
-static enum vchiq_status
+static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
 			     unsigned int size, enum vchiq_bulk_dir dir);
 
@@ -722,7 +722,7 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 	}
 }
 
-enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance)
+int vchiq_shutdown(struct vchiq_instance *instance)
 {
 	enum vchiq_status status = VCHIQ_SUCCESS;
 	struct vchiq_state *state = instance->state;
@@ -749,7 +749,7 @@ static int vchiq_is_connected(struct vchiq_instance *instance)
 	return instance->connected;
 }
 
-enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
+int vchiq_connect(struct vchiq_instance *instance)
 {
 	enum vchiq_status status;
 	struct vchiq_state *state = instance->state;
@@ -773,7 +773,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 }
 EXPORT_SYMBOL(vchiq_connect);
 
-static enum vchiq_status
+static int
 vchiq_add_service(struct vchiq_instance *instance,
 		  const struct vchiq_service_params_kernel *params,
 		  unsigned int *phandle)
@@ -803,7 +803,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 	return status;
 }
 
-enum vchiq_status
+int
 vchiq_open_service(struct vchiq_instance *instance,
 		   const struct vchiq_service_params_kernel *params,
 		   unsigned int *phandle)
@@ -835,7 +835,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 }
 EXPORT_SYMBOL(vchiq_open_service);
 
-enum vchiq_status
+int
 vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const void *data,
 		    unsigned int size, void *userdata, enum vchiq_bulk_mode mode)
 {
@@ -873,9 +873,9 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 }
 EXPORT_SYMBOL(vchiq_bulk_transmit);
 
-enum vchiq_status vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
-				     void *data, unsigned int size, void *userdata,
-				     enum vchiq_bulk_mode mode)
+int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
+		       void *data, unsigned int size, void *userdata,
+		       enum vchiq_bulk_mode mode)
 {
 	enum vchiq_status status;
 
@@ -910,7 +910,7 @@ enum vchiq_status vchiq_bulk_receive(struct vchiq_instance *instance, unsigned i
 }
 EXPORT_SYMBOL(vchiq_bulk_receive);
 
-static enum vchiq_status
+static int
 vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *data,
 			     unsigned int size, enum vchiq_bulk_dir dir)
 {
@@ -983,7 +983,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	return status;
 }
 
-static enum vchiq_status
+static int
 add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	       struct vchiq_header *header, struct user_service *user_service,
 	       void *bulk_userdata)
@@ -1044,7 +1044,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	return VCHIQ_SUCCESS;
 }
 
-enum vchiq_status
+int
 service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata)
 {
@@ -1314,7 +1314,7 @@ vchiq_get_state(void)
  * Autosuspend related functionality
  */
 
-static enum vchiq_status
+static int
 vchiq_keepalive_vchiq_callback(struct vchiq_instance *instance,
 			       enum vchiq_reason reason,
 			       struct vchiq_header *header,
@@ -1587,7 +1587,7 @@ vchiq_instance_set_trace(struct vchiq_instance *instance, int trace)
 	instance->trace = (trace != 0);
 }
 
-enum vchiq_status
+int
 vchiq_use_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	enum vchiq_status ret = VCHIQ_ERROR;
@@ -1601,7 +1601,7 @@ vchiq_use_service(struct vchiq_instance *instance, unsigned int handle)
 }
 EXPORT_SYMBOL(vchiq_use_service);
 
-enum vchiq_status
+int
 vchiq_release_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	enum vchiq_status ret = VCHIQ_ERROR;
@@ -1695,7 +1695,7 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	kfree(service_data);
 }
 
-enum vchiq_status
+int
 vchiq_check_service(struct vchiq_service *service)
 {
 	struct vchiq_arm_state *arm_state;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2851ef6b9cd0..2fb31f9b527f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -85,13 +85,13 @@ extern struct vchiq_state g_state;
 extern struct vchiq_state *
 vchiq_get_state(void);
 
-enum vchiq_status
+int
 vchiq_use_service(struct vchiq_instance *instance, unsigned int handle);
 
-extern enum vchiq_status
+extern int
 vchiq_release_service(struct vchiq_instance *instance, unsigned int handle);
 
-extern enum vchiq_status
+extern int
 vchiq_check_service(struct vchiq_service *service);
 
 extern void
@@ -100,10 +100,10 @@ vchiq_dump_platform_use_state(struct vchiq_state *state);
 extern void
 vchiq_dump_service_use_state(struct vchiq_state *state);
 
-extern enum vchiq_status
+extern int
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type);
-extern enum vchiq_status
+extern int
 vchiq_release_internal(struct vchiq_state *state,
 		       struct vchiq_service *service);
 
@@ -137,7 +137,7 @@ static inline int vchiq_register_chrdev(struct device *parent) { return 0; }
 
 #endif /* IS_ENABLED(CONFIG_VCHIQ_CDEV) */
 
-extern enum vchiq_status
+extern int
 service_callback(struct vchiq_instance *vchiq_instance, enum vchiq_reason reason,
 		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 45ed30bfdbf5..a543c29b1598 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -463,7 +463,7 @@ mark_service_closing(struct vchiq_service *service)
 	mark_service_closing_internal(service, 0);
 }
 
-static inline enum vchiq_status
+static inline int
 make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		      struct vchiq_header *header, void *bulk_userdata)
 {
@@ -900,7 +900,7 @@ copy_message_data(ssize_t (*copy_callback)(void *context, void *dest, size_t off
 }
 
 /* Called by the slot handler and application threads */
-static enum vchiq_status
+static int
 queue_message(struct vchiq_state *state, struct vchiq_service *service,
 	      int msgid,
 	      ssize_t (*copy_callback)(void *context, void *dest,
@@ -1139,7 +1139,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 }
 
 /* Called by the slot handler and application threads */
-static enum vchiq_status
+static int
 queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		   int msgid,
 		   ssize_t (*copy_callback)(void *context, void *dest,
@@ -1299,7 +1299,7 @@ get_bulk_reason(struct vchiq_bulk *bulk)
 }
 
 /* Called by the slot handler - don't hold the bulk mutex */
-static enum vchiq_status
+static int
 notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 	     int retry_poll)
 {
@@ -2486,7 +2486,7 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	return service;
 }
 
-enum vchiq_status
+int
 vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 {
 	struct vchiq_open_payload payload = {
@@ -2609,7 +2609,7 @@ do_abort_bulks(struct vchiq_service *service)
 	return (status == VCHIQ_SUCCESS);
 }
 
-static enum vchiq_status
+static int
 close_service_complete(struct vchiq_service *service, int failstate)
 {
 	enum vchiq_status status;
@@ -2674,7 +2674,7 @@ close_service_complete(struct vchiq_service *service, int failstate)
 }
 
 /* Called by the slot handler */
-enum vchiq_status
+int
 vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 {
 	struct vchiq_state *state = service->state;
@@ -2832,7 +2832,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 	vchiq_service_put(service);
 }
 
-enum vchiq_status
+int
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance)
 {
 	struct vchiq_service *service;
@@ -2879,7 +2879,7 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 	}
 }
 
-enum vchiq_status
+int
 vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
@@ -2937,7 +2937,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 }
 EXPORT_SYMBOL(vchiq_close_service);
 
-enum vchiq_status
+int
 vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
@@ -3004,9 +3004,9 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
  * When called in blocking mode, the userdata field points to a bulk_waiter
  * structure.
  */
-enum vchiq_status vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
-				      void *offset, void __user *uoffset, int size, void *userdata,
-				      enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
+int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
+			void *offset, void __user *uoffset, int size, void *userdata,
+			enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct vchiq_bulk_queue *queue;
@@ -3161,7 +3161,7 @@ enum vchiq_status vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned
 	return status;
 }
 
-enum vchiq_status
+int
 vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
 					     size_t offset, size_t maxsize),
@@ -3277,7 +3277,7 @@ release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
 	remote_event_signal(&state->remote->sync_release);
 }
 
-enum vchiq_status
+int
 vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle, short *peer_version)
 {
 	enum vchiq_status status = VCHIQ_ERROR;
@@ -3640,7 +3640,7 @@ vchiq_loud_error_footer(void)
 			"============================================================================");
 }
 
-enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state)
+int vchiq_send_remote_use(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
 		return VCHIQ_RETRY;
@@ -3648,7 +3648,7 @@ enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state)
 	return queue_message(state, NULL, MAKE_REMOTE_USE, NULL, NULL, 0, 0);
 }
 
-enum vchiq_status vchiq_send_remote_use_active(struct vchiq_state *state)
+int vchiq_send_remote_use_active(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
 		return VCHIQ_RETRY;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 8b4a38f5b3f2..ec3505424718 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -458,7 +458,7 @@ vchiq_init_slots(void *mem_base, int mem_size);
 extern int
 vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev);
 
-extern enum vchiq_status
+extern int
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance);
 
 struct vchiq_service *
@@ -467,10 +467,10 @@ vchiq_add_service_internal(struct vchiq_state *state,
 			   int srvstate, struct vchiq_instance *instance,
 			   void (*userdata_term)(void *userdata));
 
-extern enum vchiq_status
+extern int
 vchiq_open_service_internal(struct vchiq_service *service, int client_id);
 
-extern enum vchiq_status
+extern int
 vchiq_close_service_internal(struct vchiq_service *service, int close_recvd);
 
 extern void
@@ -485,7 +485,7 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 extern void
 remote_event_pollall(struct vchiq_state *state);
 
-extern enum vchiq_status
+extern int
 vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle, void *offset,
 		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_mode mode,
 		    enum vchiq_bulk_dir dir);
@@ -536,7 +536,7 @@ vchiq_service_get(struct vchiq_service *service);
 extern void
 vchiq_service_put(struct vchiq_service *service);
 
-extern enum vchiq_status
+extern int
 vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
 					     size_t offset, size_t maxsize),
@@ -568,13 +568,13 @@ void vchiq_on_remote_release(struct vchiq_state *state);
 
 int vchiq_platform_init_state(struct vchiq_state *state);
 
-enum vchiq_status vchiq_check_service(struct vchiq_service *service);
+int vchiq_check_service(struct vchiq_service *service);
 
 void vchiq_on_remote_use_active(struct vchiq_state *state);
 
-enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state);
+int vchiq_send_remote_use(struct vchiq_state *state);
 
-enum vchiq_status vchiq_send_remote_use_active(struct vchiq_state *state);
+int vchiq_send_remote_use_active(struct vchiq_state *state);
 
 void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 				       enum vchiq_connstate oldstate,
@@ -584,7 +584,7 @@ void vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newsta
 
 void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes);
 
-enum vchiq_status vchiq_remove_service(struct vchiq_instance *instance, unsigned int service);
+int vchiq_remove_service(struct vchiq_instance *instance, unsigned int service);
 
 int vchiq_get_client_id(struct vchiq_instance *instance, unsigned int service);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 86d77f2eeea5..96f50beace44 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -12,10 +12,10 @@
 
 struct vchiq_service_params {
 	int fourcc;
-	enum vchiq_status __user (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
+	int __user (*callback)(enum vchiq_reason reason,
+			       struct vchiq_header *header,
+			       unsigned int handle,
+			       void *bulk_userdata);
 	void __user *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 294b184d4a49..038881827336 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -548,10 +548,9 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 }
 
 /* incoming event service callback */
-static enum vchiq_status service_callback(struct vchiq_instance *vchiq_instance,
-					  enum vchiq_reason reason,
-					  struct vchiq_header *header,
-					  unsigned int handle, void *bulk_ctx)
+static int service_callback(struct vchiq_instance *vchiq_instance,
+			    enum vchiq_reason reason, struct vchiq_header *header,
+			    unsigned int handle, void *bulk_ctx)
 {
 	struct vchiq_mmal_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
 	u32 msg_len;
-- 
2.38.1

