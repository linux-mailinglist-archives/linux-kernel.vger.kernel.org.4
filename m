Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B3671C37
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjARMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjARMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:35:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6836FC1;
        Wed, 18 Jan 2023 03:58:36 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51AF21643;
        Wed, 18 Jan 2023 12:58:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674043115;
        bh=54fyp56C8zG+m4xs/lXWL4IFVTrJQGYK0w0NLdazNA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIKCMGmT0gK+neJMDeYe3e+bJPBEPsNophIC7vZTWTBTDC9aXoIE9o9WIj4yq3vjM
         KYI9EyYV1uSmnfDoqyMdTAjD/Th/1NCuxKbdh8hPKniBiLIVR53q4Nuf+Qeyi/Hd8L
         P94O+pBocuMLGzdriH8BfUyQWJXQWhaw+XvU0ueE=
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
Subject: [RFC PATCH 4/4] staging: vc04_services: Drop remnants of custom logging
Date:   Wed, 18 Jan 2023 17:28:10 +0530
Message-Id: <20230118115810.21979-5-umang.jain@ideasonboard.com>
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

Drop remnants of custom logging such as header definitions and such.
Also migrate the vchiq_debugfs to use the log levels coming from
include/linux/kern_levels.h instead.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           |  4 --
 .../interface/vchiq_arm/vchiq_core.c          | 39 +++++++------------
 .../interface/vchiq_arm/vchiq_core.h          | 39 -------------------
 .../interface/vchiq_arm/vchiq_debugfs.c       | 26 ++++++++-----
 4 files changed, 31 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index ed3773b996a3..45e28ca368ee 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -60,10 +60,6 @@
 #define KEEPALIVE_VER 1
 #define KEEPALIVE_VER_MIN KEEPALIVE_VER
 
-/* Run time control of log level, based on KERN_XXX level. */
-int vchiq_arm_log_level = VCHIQ_LOG_DEFAULT;
-int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
-
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7b3c57326d28..4cf710a3ca28 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -9,6 +9,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/kern_levels.h>
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
@@ -103,10 +104,8 @@ static_assert((unsigned int)VCHIQ_PORT_MAX <
 
 #define BULK_INDEX(x) ((x) & (VCHIQ_NUM_SERVICE_BULKS - 1))
 
-#define SRVTRACE_LEVEL(srv) \
-	(((srv) && (srv)->trace) ? VCHIQ_LOG_TRACE : vchiq_core_msg_log_level)
 #define SRVTRACE_ENABLED(srv, lev) \
-	(((srv) && (srv)->trace) || (vchiq_core_msg_log_level >= (lev)))
+	(((srv) && (srv)->trace) || (LOGLEVEL_DEFAULT >= (lev)))
 
 #define NO_CLOSE_RECVD	0
 #define CLOSE_RECVD	1
@@ -154,11 +153,6 @@ static inline void check_sizes(void)
 	BUILD_BUG_ON_NOT_POWER_OF_2(VCHIQ_MAX_SERVICES);
 }
 
-/* Run time control of log level, based on KERN_XXX level. */
-int vchiq_core_log_level = VCHIQ_LOG_DEFAULT;
-int vchiq_core_msg_log_level = VCHIQ_LOG_DEFAULT;
-int vchiq_sync_log_level = VCHIQ_LOG_DEFAULT;
-
 DEFINE_SPINLOCK(bulk_waiter_spinlock);
 static DEFINE_SPINLOCK(quota_spinlock);
 
@@ -1035,8 +1029,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			return -EINVAL;
 		}
 
-		if (SRVTRACE_ENABLED(service,
-				     VCHIQ_LOG_INFO))
+		if (SRVTRACE_ENABLED(service, LOGLEVEL_INFO))
 			vchiq_log_dump_mem("Sent", 0,
 					   header->data,
 					   min_t(size_t, 16, callback_result));
@@ -1144,6 +1137,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	struct vchiq_shared_state *local;
 	struct vchiq_header *header;
 	ssize_t callback_result;
+	int svc_fourcc;
 
 	local = state->local;
 
@@ -1184,8 +1178,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	}
 
 	if (service) {
-		if (SRVTRACE_ENABLED(service,
-				     VCHIQ_LOG_INFO))
+		if (SRVTRACE_ENABLED(service, LOGLEVEL_INFO))
 			vchiq_log_dump_mem("Sent", 0,
 					   header->data,
 					   min_t(size_t, 16, callback_result));
@@ -1199,19 +1192,15 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	header->size = size;
 	header->msgid = msgid;
 
-	if (vchiq_sync_log_level >= VCHIQ_LOG_TRACE) {
-		int svc_fourcc;
 
-		svc_fourcc = service
-			? service->base.fourcc
-			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
+	svc_fourcc = service ? service->base.fourcc
+			     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		dev_dbg(state->dev,
-			"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid), size);
-	}
+	dev_dbg(state->dev,
+		"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
+		msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+		VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+		VCHIQ_MSG_DSTPORT(msgid), size);
 
 	remote_event_signal(&state->remote->sync_trigger);
 
@@ -1624,7 +1613,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 	}
 
-	if (SRVTRACE_ENABLED(service, VCHIQ_LOG_INFO)) {
+	if (SRVTRACE_ENABLED(service, LOGLEVEL_INFO)) {
 		int svc_fourcc;
 
 		svc_fourcc = service
@@ -2031,7 +2020,7 @@ sync_func(void *v)
 			continue;
 		}
 
-		if (vchiq_sync_log_level >= VCHIQ_LOG_TRACE) {
+		if (vchiq_sync_log_level >= LOGLEVEL_DEBUG) {
 			int svc_fourcc;
 
 			svc_fourcc = service
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index ec3505424718..960bf4efeab5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -30,39 +30,6 @@
 #define VCHIQ_SLOT_SIZE     4096
 #define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
 
-/* Run time control of log level, based on KERN_XXX level. */
-#define VCHIQ_LOG_DEFAULT  4
-#define VCHIQ_LOG_ERROR    3
-#define VCHIQ_LOG_WARNING  4
-#define VCHIQ_LOG_INFO     6
-#define VCHIQ_LOG_TRACE    7
-
-#define VCHIQ_LOG_PREFIX   KERN_INFO "vchiq: "
-
-#ifndef vchiq_log_error
-#define vchiq_log_error(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_ERROR) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-#ifndef vchiq_log_warning
-#define vchiq_log_warning(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_WARNING) \
-		 printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-#ifndef vchiq_log_info
-#define vchiq_log_info(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_INFO) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-#ifndef vchiq_log_trace
-#define vchiq_log_trace(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_TRACE) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-
-#define vchiq_loud_error(...) \
-	vchiq_log_error(vchiq_core_log_level, "===== " __VA_ARGS__)
-
 #define VCHIQ_SLOT_MASK        (VCHIQ_SLOT_SIZE - 1)
 #define VCHIQ_SLOT_QUEUE_MASK  (VCHIQ_MAX_SLOTS_PER_SIDE - 1)
 #define VCHIQ_SLOT_ZERO_SLOTS  DIV_ROUND_UP(sizeof(struct vchiq_slot_zero), \
@@ -496,12 +463,6 @@ vchiq_dump_state(void *dump_context, struct vchiq_state *state);
 extern int
 vchiq_dump_service_state(void *dump_context, struct vchiq_service *service);
 
-extern void
-vchiq_loud_error_header(void);
-
-extern void
-vchiq_loud_error_footer(void);
-
 extern void
 request_poll(struct vchiq_state *state, struct vchiq_service *service,
 	     int poll_type);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index dc667afd1f8c..1d142752351d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/kern_levels.h>
+
 #include "vchiq_core.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
@@ -22,6 +24,12 @@
 static struct dentry *vchiq_dbg_dir;
 static struct dentry *vchiq_dbg_clients;
 
+int vchiq_arm_log_level = LOGLEVEL_DEFAULT;
+int vchiq_susp_log_level = LOGLEVEL_ERR;
+int vchiq_core_log_level = LOGLEVEL_DEFAULT;
+int vchiq_core_msg_log_level = LOGLEVEL_DEFAULT;
+int vchiq_sync_log_level = LOGLEVEL_DEFAULT;
+
 /* Log category debugfs entries */
 struct vchiq_debugfs_log_entry {
 	const char *name;
@@ -42,16 +50,16 @@ static int debugfs_log_show(struct seq_file *f, void *offset)
 	char *log_value = NULL;
 
 	switch (*levp) {
-	case VCHIQ_LOG_ERROR:
+	case LOGLEVEL_ERR:
 		log_value = VCHIQ_LOG_ERROR_STR;
 		break;
-	case VCHIQ_LOG_WARNING:
+	case LOGLEVEL_WARNING:
 		log_value = VCHIQ_LOG_WARNING_STR;
 		break;
-	case VCHIQ_LOG_INFO:
+	case LOGLEVEL_INFO:
 		log_value = VCHIQ_LOG_INFO_STR;
 		break;
-	case VCHIQ_LOG_TRACE:
+	case LOGLEVEL_DEBUG:
 		log_value = VCHIQ_LOG_TRACE_STR;
 		break;
 	default:
@@ -85,15 +93,15 @@ static ssize_t debugfs_log_write(struct file *file,
 	kbuf[count - 1] = 0;
 
 	if (strncmp("error", kbuf, strlen("error")) == 0)
-		*levp = VCHIQ_LOG_ERROR;
+		*levp = LOGLEVEL_ERR;
 	else if (strncmp("warning", kbuf, strlen("warning")) == 0)
-		*levp = VCHIQ_LOG_WARNING;
+		*levp = LOGLEVEL_WARNING;
 	else if (strncmp("info", kbuf, strlen("info")) == 0)
-		*levp = VCHIQ_LOG_INFO;
+		*levp = LOGLEVEL_INFO;
 	else if (strncmp("trace", kbuf, strlen("trace")) == 0)
-		*levp = VCHIQ_LOG_TRACE;
+		*levp = LOGLEVEL_DEBUG;
 	else
-		*levp = VCHIQ_LOG_DEFAULT;
+		*levp = LOGLEVEL_DEFAULT;
 
 	*ppos += count;
 
-- 
2.39.0

