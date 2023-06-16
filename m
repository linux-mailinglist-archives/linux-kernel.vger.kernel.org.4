Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB37326E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbjFPFxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjFPFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:05 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B22D54
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 478071A249D;
        Fri, 16 Jun 2023 07:43:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D99421A068F;
        Fri, 16 Jun 2023 07:43:07 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D56D91820F58;
        Fri, 16 Jun 2023 13:43:06 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 7/8] ethosu: Add core message about inference cancellation
Date:   Fri, 16 Jun 2023 13:59:12 +0800
Message-Id: <20230616055913.2360-8-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds core message about sending cancel inference message to
Ethos-U subsystem to abort inference execution.

Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/ethosu/Makefile              |   3 +-
 .../firmware/ethosu/ethosu_cancel_inference.c | 185 ++++++++++++++++++
 .../firmware/ethosu/ethosu_cancel_inference.h |  55 ++++++
 .../firmware/ethosu/ethosu_core_interface.h   |  37 ++--
 drivers/firmware/ethosu/ethosu_inference.c    |  16 ++
 drivers/firmware/ethosu/ethosu_rpmsg.c        |  33 ++++
 drivers/firmware/ethosu/ethosu_rpmsg.h        |   9 +
 drivers/firmware/ethosu/uapi/ethosu.h         |  29 +++
 8 files changed, 349 insertions(+), 18 deletions(-)
 create mode 100644 drivers/firmware/ethosu/ethosu_cancel_inference.c
 create mode 100644 drivers/firmware/ethosu/ethosu_cancel_inference.h

diff --git a/drivers/firmware/ethosu/Makefile b/drivers/firmware/ethosu/Makefile
index a162a3bd32e3..88a352690ddd 100644
--- a/drivers/firmware/ethosu/Makefile
+++ b/drivers/firmware/ethosu/Makefile
@@ -27,4 +27,5 @@ ethosu-objs := ethosu_driver.o \
                ethosu_rpmsg.o \
                ethosu_network.o \
                ethosu_network_info.o \
-               ethosu_capabilities.o
+               ethosu_capabilities.o \
+               ethosu_cancel_inference.o
diff --git a/drivers/firmware/ethosu/ethosu_cancel_inference.c b/drivers/firmware/ethosu/ethosu_cancel_inference.c
new file mode 100644
index 000000000000..911955889197
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_cancel_inference.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Arm Limited.
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_cancel_inference.h"
+
+#include "ethosu_core_interface.h"
+#include "ethosu_device.h"
+#include "ethosu_inference.h"
+
+#include <linux/wait.h>
+
+/****************************************************************************
+ * Defines
+ ****************************************************************************/
+
+#define CANCEL_INFERENCE_RESP_TIMEOUT_MS 2000
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+static int ethosu_cancel_inference_send(struct ethosu_cancel_inference *cancellation)
+{
+	return ethosu_rpmsg_cancel_inference(&cancellation->edev->erp,
+					     &cancellation->msg,
+					     cancellation->inf->msg.id);
+}
+
+static void ethosu_cancel_inference_fail(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_cancel_inference *cancellation =
+		container_of(msg, typeof(*cancellation), msg);
+
+	if (completion_done(&cancellation->done))
+		return;
+
+	cancellation->errno = -EFAULT;
+	cancellation->uapi->status = ETHOSU_UAPI_STATUS_ERROR;
+	complete(&cancellation->done);
+}
+
+static int ethosu_cancel_inference_complete(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_cancel_inference *cancellation =
+		container_of(msg, typeof(*cancellation), msg);
+
+	if (completion_done(&cancellation->done))
+		return 0;
+
+	cancellation->errno = 0;
+	cancellation->uapi->status =
+		cancellation->inf->done &&
+		cancellation->inf->status != ETHOSU_UAPI_STATUS_OK ?
+		ETHOSU_UAPI_STATUS_OK :
+		ETHOSU_UAPI_STATUS_ERROR;
+	complete(&cancellation->done);
+
+	return 0;
+}
+
+int ethosu_cancel_inference_request(struct ethosu_inference *inf,
+				    struct ethosu_uapi_cancel_inference_status *uapi)
+{
+	struct ethosu_cancel_inference *cancellation;
+	int ret;
+	int timeout;
+
+	if (inf->done) {
+		uapi->status = ETHOSU_UAPI_STATUS_ERROR;
+
+		return 0;
+	}
+
+	cancellation =
+		devm_kzalloc(inf->edev->dev,
+			     sizeof(struct ethosu_cancel_inference),
+			     GFP_KERNEL);
+	if (!cancellation)
+		return -ENOMEM;
+
+	/* increase ref count on the inference we are referring to */
+	ethosu_inference_get(inf);
+	/* mark inference ABORTING to avoid resending the inference message */
+	inf->status = ETHOSU_UAPI_STATUS_ABORTING;
+
+	cancellation->edev = inf->edev;
+	cancellation->inf = inf;
+	cancellation->uapi = uapi;
+	init_completion(&cancellation->done);
+	cancellation->msg.fail = ethosu_cancel_inference_fail;
+
+	/* Never resend messages but always complete, since we have restart the
+	 * whole firmware and marked the inference as aborted
+	 */
+	cancellation->msg.resend = ethosu_cancel_inference_complete;
+
+	ret = ethosu_rpmsg_register(&cancellation->edev->erp,
+				    &cancellation->msg);
+	if (ret < 0)
+		goto kfree;
+
+	dev_dbg(cancellation->edev->dev,
+		"Inference cancellation create. cancel=0x%pK, msg.id=%d\n",
+		cancellation, cancellation->msg.id);
+
+	ret = ethosu_cancel_inference_send(cancellation);
+	if (ret != 0)
+		goto deregister;
+
+	/* Unlock the mutex before going to block on the condition */
+	mutex_unlock(&cancellation->edev->mutex);
+	/* wait for response to arrive back */
+	timeout = wait_for_completion_timeout(&cancellation->done,
+					      msecs_to_jiffies(CANCEL_INFERENCE_RESP_TIMEOUT_MS));
+
+	/* take back the mutex before resuming to do anything */
+	ret = mutex_lock_interruptible(&cancellation->edev->mutex);
+	if (ret != 0)
+		goto deregister;
+
+	if (timeout == 0) {
+		dev_warn(inf->edev->dev,
+			 "Msg: Cancel Inference response lost - timeout\n");
+		ret = -EIO;
+		goto deregister;
+	}
+
+	if (cancellation->errno) {
+		ret = cancellation->errno;
+		goto deregister;
+	}
+
+deregister:
+	ethosu_rpmsg_deregister(&cancellation->edev->erp,
+				&cancellation->msg);
+
+kfree:
+	dev_dbg(cancellation->edev->dev,
+		"Cancel inference destroy. cancel=0x%pK\n", cancellation);
+	/* decrease the reference on the inference we are referring to */
+	ethosu_inference_put(cancellation->inf);
+	devm_kfree(cancellation->edev->dev, cancellation);
+
+	return ret;
+}
+
+void ethosu_cancel_inference_rsp(struct ethosu_device *edev,
+				 struct ethosu_core_cancel_inference_rsp *rsp)
+{
+	int id = (int)rsp->user_arg;
+	struct ethosu_rpmsg_msg *msg;
+	struct ethosu_cancel_inference *cancellation;
+
+	msg = ethosu_rpmsg_find(&edev->erp, id);
+	if (IS_ERR(msg)) {
+		dev_warn(edev->dev,
+			 "Handle not found in cancel inference list. handle=0x%p\n",
+			 rsp);
+
+		return;
+	}
+
+	cancellation = container_of(msg, typeof(*cancellation), msg);
+
+	if (completion_done(&cancellation->done))
+		return;
+
+	cancellation->errno = 0;
+	switch (rsp->status) {
+	case ETHOSU_CORE_STATUS_OK:
+		cancellation->uapi->status = ETHOSU_UAPI_STATUS_OK;
+		break;
+	case ETHOSU_CORE_STATUS_ERROR:
+		cancellation->uapi->status = ETHOSU_UAPI_STATUS_ERROR;
+		break;
+	}
+
+	complete(&cancellation->done);
+}
diff --git a/drivers/firmware/ethosu/ethosu_cancel_inference.h b/drivers/firmware/ethosu/ethosu_cancel_inference.h
new file mode 100644
index 000000000000..940e0589959a
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_cancel_inference.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Arm Limited.
+ */
+
+#ifndef ETHOSU_CANCEL_INFERENCE_H
+#define ETHOSU_CANCEL_INFERENCE_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_rpmsg.h"
+#include "uapi/ethosu.h"
+
+#include <linux/types.h>
+#include <linux/completion.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+struct ethosu_core_cancel_inference_rsp;
+struct ethosu_device;
+struct ethosu_uapi_cancel_inference_status;
+struct ethosu_inference;
+
+struct ethosu_cancel_inference {
+	struct ethosu_device                       *edev;
+	struct ethosu_inference                    *inf;
+	struct ethosu_uapi_cancel_inference_status *uapi;
+	struct completion                          done;
+	struct ethosu_rpmsg_msg                    msg;
+	int                                        errno;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_cancel_inference_request() - Send cancel inference request
+ *
+ * Return: 0 on success, error code otherwise.
+ */
+int ethosu_cancel_inference_request(struct ethosu_inference *inf,
+				    struct ethosu_uapi_cancel_inference_status *uapi);
+
+/**
+ * ethosu_cancel_inference_rsp() - Handle cancel inference response
+ */
+void ethosu_cancel_inference_rsp(struct ethosu_device *edev,
+				 struct ethosu_core_cancel_inference_rsp *rsp);
+
+#endif /* ETHOSU_CANCEL_INFERENCE_H */
diff --git a/drivers/firmware/ethosu/ethosu_core_interface.h b/drivers/firmware/ethosu/ethosu_core_interface.h
index f804de40b004..b1244ce28d39 100644
--- a/drivers/firmware/ethosu/ethosu_core_interface.h
+++ b/drivers/firmware/ethosu/ethosu_core_interface.h
@@ -1,21 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2020-2022 Arm Limited.
- *
- * This program is free software and is provided to you under the terms of the
- * GNU General Public License version 2 as published by the Free Software
- * Foundation, and any use by you of this program is subject to the terms
- * of such GNU licence.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, you can access it online at
- * http://www.gnu.org/licenses/gpl-2.0.html.
- *
- * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) 2022 Arm Limited.
  */
 
 #ifndef ETHOSU_CORE_INTERFACE_H
@@ -64,6 +49,8 @@ enum ethosu_core_msg_type {
 	ETHOSU_CORE_MSG_CAPABILITIES_RSP,
 	ETHOSU_CORE_MSG_NETWORK_INFO_REQ,
 	ETHOSU_CORE_MSG_NETWORK_INFO_RSP,
+	ETHOSU_CORE_MSG_CANCEL_INFERENCE_REQ,
+	ETHOSU_CORE_MSG_CANCEL_INFERENCE_RSP,
 	ETHOSU_CORE_MSG_POWER_REQ,
 	ETHOSU_CORE_MSG_POWER_RSP,
 	ETHOSU_CORE_MSG_MAX
@@ -235,6 +222,22 @@ struct ethosu_core_msg_capabilities_rsp {
 	uint32_t custom_dma;
 };
 
+/**
+ * struct ethosu_core_cancel_inference_req - Message cancel inference request
+ */
+struct ethosu_core_cancel_inference_req {
+	u64 user_arg;
+	u64 inference_handle;
+};
+
+/**
+ * struct ethosu_core_cancel_inference_rsp - Message cancel inference response
+ */
+struct ethosu_core_cancel_inference_rsp {
+	u64 user_arg;
+	u32 status;
+};
+
 enum ethosu_core_power_req_type {
 	ETHOSU_CORE_POWER_REQ_SUSPEND = 0,
 	ETHOSU_CORE_POWER_REQ_RESUME
diff --git a/drivers/firmware/ethosu/ethosu_inference.c b/drivers/firmware/ethosu/ethosu_inference.c
index 4e5fa214c5d6..8c0c59242650 100644
--- a/drivers/firmware/ethosu/ethosu_inference.c
+++ b/drivers/firmware/ethosu/ethosu_inference.c
@@ -28,6 +28,7 @@
 #include "ethosu_core_interface.h"
 #include "ethosu_device.h"
 #include "ethosu_network.h"
+#include "ethosu_cancel_inference.h"
 #include "uapi/ethosu.h"
 
 #include <linux/anon_inodes.h>
@@ -267,6 +268,21 @@ static long ethosu_inference_ioctl(struct file *file,
 
 		break;
 	}
+	case ETHOSU_IOCTL_INFERENCE_CANCEL: {
+		struct ethosu_uapi_cancel_inference_status uapi;
+
+		dev_dbg(inf->edev->dev,
+			"Inference ioctl: Cancel Inference. Handle=%p\n",
+			inf);
+
+		ret = ethosu_cancel_inference_request(inf, &uapi);
+		if (ret)
+			break;
+
+		ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
+
+		break;
+	}
 	default: {
 		dev_err(inf->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu\n",
 			cmd, arg);
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
index 368a519e36b1..351a1046e65e 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.c
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -294,6 +294,39 @@ int ethosu_rpmsg_network_info_request(struct ethosu_rpmsg *erp,
 	return 0;
 }
 
+int ethosu_rpmsg_cancel_inference(struct ethosu_rpmsg *erp,
+				  struct ethosu_rpmsg_msg *rpmsg,
+				  int inference_handle)
+{
+	struct ethosu_core_msg msg = {
+		.magic  = ETHOSU_CORE_MSG_MAGIC,
+		.type   = ETHOSU_CORE_MSG_CAPABILITIES_REQ,
+		.length = sizeof(struct ethosu_core_cancel_inference_req)
+	};
+	struct ethosu_core_cancel_inference_req req;
+	struct rpmsg_device *rpdev = erp->rpdev;
+	u8 data[sizeof(struct ethosu_core_msg) +
+		sizeof(struct ethosu_core_cancel_inference_req)];
+	int ret;
+
+	req.user_arg = rpmsg->id;
+	req.inference_handle = inference_handle;
+
+	memcpy(data, &msg, sizeof(struct ethosu_core_msg));
+	memcpy(data + sizeof(struct ethosu_core_msg), &req,
+	       sizeof(struct ethosu_core_cancel_inference_req));
+
+	ret = rpmsg_send(rpdev->ept, (void *)&data,
+			 sizeof(struct ethosu_core_msg) +
+			 sizeof(struct ethosu_core_cancel_inference_req));
+	if (ret) {
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rpmsg_ethosu_cb(struct rpmsg_device *rpdev,
 		void *data, int len, void *priv, u32 src)
 {
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.h b/drivers/firmware/ethosu/ethosu_rpmsg.h
index ba6fb8fd5869..283d401a0dbf 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.h
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -101,6 +101,15 @@ int ethosu_rpmsg_network_info_request(struct ethosu_rpmsg *erp,
 				      struct ethosu_buffer *network,
 				      uint32_t network_index);
 
+/**
+ * ethosu_rpmsg_cancel_inference() - Send inference cancellation
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_rpmsg_cancel_inference(struct ethosu_rpmsg *erp,
+				  struct ethosu_rpmsg_msg *rpmsg,
+				  int inference_handle);
+
 int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
 		      ethosu_rpmsg_cb callback, void *user_arg);
 
diff --git a/drivers/firmware/ethosu/uapi/ethosu.h b/drivers/firmware/ethosu/uapi/ethosu.h
index 64a7d9d4885e..3375b1d83ab0 100644
--- a/drivers/firmware/ethosu/uapi/ethosu.h
+++ b/drivers/firmware/ethosu/uapi/ethosu.h
@@ -60,10 +60,15 @@ namespace EthosU {
 						   struct ethosu_uapi_inference_create)
 #define ETHOSU_IOCTL_INFERENCE_STATUS   ETHOSU_IOR(0x31, \
 						   struct ethosu_uapi_result_status)
+#define ETHOSU_IOCTL_INFERENCE_CANCEL   ETHOSU_IOR(0x32, \
+						   struct ethosu_uapi_cancel_inference_status)
 
 /* Maximum number of IFM/OFM file descriptors per network */
 #define ETHOSU_FD_MAX                   16
 
+/* Maximum number of dimensions for input and output */
+#define ETHOSU_DIM_MAX                   8
+
 /* Maximum number of PMUs available */
 #define ETHOSU_PMU_EVENT_MAX             4
 
@@ -133,15 +138,31 @@ struct ethosu_uapi_network_create {
  * @desc:		Network description
  * @ifm_count:		Number of IFM buffers
  * @ifm_size:		IFM buffer sizes
+ * @ifm_types:          IFM data types
+ * @ifm_offset:         IFM data offset in arena
+ * @ifm_dims:           IFM buffer dimensions
+ * @ifm_shapes:         IFM buffer shapes
  * @ofm_count:		Number of OFM buffers
  * @ofm_size:		OFM buffer sizes
+ * @ofm_offset:         OFM data offset in arena
+ * @ofm_dims:           OFM buffer dimensions
+ * @ofm_shapes:         OFM buffer shapes
  */
 struct ethosu_uapi_network_info {
 	char  desc[32];
+	__u32 is_vela;
 	__u32 ifm_count;
 	__u32 ifm_size[ETHOSU_FD_MAX];
+	__u32 ifm_types[ETHOSU_FD_MAX];
+	__u32 ifm_offset[ETHOSU_FD_MAX];
+	__u32 ifm_dims[ETHOSU_FD_MAX];
+	__u32 ifm_shapes[ETHOSU_FD_MAX][ETHOSU_DIM_MAX];
 	__u32 ofm_count;
 	__u32 ofm_size[ETHOSU_FD_MAX];
+	__u32 ofm_types[ETHOSU_FD_MAX];
+	__u32 ofm_offset[ETHOSU_FD_MAX];
+	__u32 ofm_dims[ETHOSU_FD_MAX];
+	__u32 ofm_shapes[ETHOSU_FD_MAX][ETHOSU_DIM_MAX];
 };
 
 /**
@@ -250,6 +271,14 @@ struct ethosu_uapi_result_status {
 	struct ethosu_uapi_pmu_counts pmu_count;
 };
 
+/**
+ * struct ethosu_uapi_cancel_status - Status of inference cancellation.
+ * @status	OK if inference cancellation was performed, ERROR otherwise.
+ */
+struct ethosu_uapi_cancel_inference_status {
+	enum ethosu_uapi_status status;
+};
+
 #ifdef __cplusplus
 } /* namespace EthosU */
 #endif
-- 
2.17.1

