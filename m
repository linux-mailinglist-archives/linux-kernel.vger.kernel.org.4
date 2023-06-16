Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1A7326D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjFPFvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjFPFvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:51:17 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 22:51:14 PDT
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A92702
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:51:14 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A9E0B20029D;
        Fri, 16 Jun 2023 07:43:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AABE200231;
        Fri, 16 Jun 2023 07:43:07 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EC4D91820F57;
        Fri, 16 Jun 2023 13:43:05 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 6/8] ethosu: Add core message about network info
Date:   Fri, 16 Jun 2023 13:59:11 +0800
Message-Id: <20230616055913.2360-7-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core message that allows user space to fetch information about
network models built into the firmware.

Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
Signed-off-by: Per Åstrand <per.astrand@arm.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Feng Guo <feng.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/ethosu/Makefile              |   1 +
 .../firmware/ethosu/ethosu_core_interface.h   |  62 +++++-
 drivers/firmware/ethosu/ethosu_device.c       |  28 ++-
 drivers/firmware/ethosu/ethosu_inference.c    |   1 +
 drivers/firmware/ethosu/ethosu_network.c      |  62 ++++--
 drivers/firmware/ethosu/ethosu_network.h      |   5 +-
 drivers/firmware/ethosu/ethosu_network_info.c | 184 ++++++++++++++++++
 drivers/firmware/ethosu/ethosu_network_info.h |  56 ++++++
 drivers/firmware/ethosu/ethosu_rpmsg.c        |  50 ++++-
 drivers/firmware/ethosu/ethosu_rpmsg.h        |  11 ++
 drivers/firmware/ethosu/uapi/ethosu.h         |  42 +++-
 11 files changed, 470 insertions(+), 32 deletions(-)
 create mode 100644 drivers/firmware/ethosu/ethosu_network_info.c
 create mode 100644 drivers/firmware/ethosu/ethosu_network_info.h

diff --git a/drivers/firmware/ethosu/Makefile b/drivers/firmware/ethosu/Makefile
index fa0731adad35..a162a3bd32e3 100644
--- a/drivers/firmware/ethosu/Makefile
+++ b/drivers/firmware/ethosu/Makefile
@@ -26,4 +26,5 @@ ethosu-objs := ethosu_driver.o \
                ethosu_inference.o \
                ethosu_rpmsg.o \
                ethosu_network.o \
+               ethosu_network_info.o \
                ethosu_capabilities.o
diff --git a/drivers/firmware/ethosu/ethosu_core_interface.h b/drivers/firmware/ethosu/ethosu_core_interface.h
index 11b695a5219d..f804de40b004 100644
--- a/drivers/firmware/ethosu/ethosu_core_interface.h
+++ b/drivers/firmware/ethosu/ethosu_core_interface.h
@@ -32,7 +32,9 @@ namespace EthosU {
 #endif
 
 /** Maximum number of IFM/OFM buffers per inference */
-#define ETHOSU_CORE_BUFFER_MAX 16
+#define ETHOSU_CORE_BUFFER_MAX 4
+/** Maximum number of dimensions for input and output */
+#define ETHOSU_CORE_DIM_MAX 4
 
 /** Maximum number of PMU counters to be returned for inference */
 #define ETHOSU_CORE_PMU_MAX 4
@@ -60,6 +62,8 @@ enum ethosu_core_msg_type {
 	ETHOSU_CORE_MSG_VERSION_RSP,
 	ETHOSU_CORE_MSG_CAPABILITIES_REQ,
 	ETHOSU_CORE_MSG_CAPABILITIES_RSP,
+	ETHOSU_CORE_MSG_NETWORK_INFO_REQ,
+	ETHOSU_CORE_MSG_NETWORK_INFO_RSP,
 	ETHOSU_CORE_MSG_POWER_REQ,
 	ETHOSU_CORE_MSG_POWER_RSP,
 	ETHOSU_CORE_MSG_MAX
@@ -116,13 +120,35 @@ struct ethosu_core_buffer {
 	uint32_t size;
 };
 
+/**
+ * enum ethosu_core_network_type - Network buffer type
+ */
+enum ethosu_core_network_type {
+	ETHOSU_CORE_NETWORK_BUFFER = 1,
+	ETHOSU_CORE_NETWORK_INDEX
+};
+
+/**
+ * struct ethosu_core_network_buffer - Network buffer
+ */
+struct ethosu_core_network_buffer {
+	u32 type;
+	union {
+		struct ethosu_core_buffer buffer;
+		u32                       index;
+	};
+};
+
+/**
+ * struct ethosu_core_inference_req - Inference request
+ */
 struct ethosu_core_inference_req {
 	uint64_t                  user_arg;
 	uint32_t                  ifm_count;
 	struct ethosu_core_buffer ifm[ETHOSU_CORE_BUFFER_MAX];
 	uint32_t                  ofm_count;
 	struct ethosu_core_buffer ofm[ETHOSU_CORE_BUFFER_MAX];
-	struct ethosu_core_buffer network;
+	struct ethosu_core_network_buffer network;
 	uint8_t                   pmu_event_config[ETHOSU_CORE_PMU_MAX];
 	uint32_t                  pmu_cycle_counter_enable;
 	uint32_t                  inference_type;
@@ -143,7 +169,37 @@ struct ethosu_core_inference_rsp {
 };
 
 /**
- * struct ethosu_core_msg_verson - Message protocol version
+ * struct ethosu_core_network_info_req - Network information request
+ */
+struct ethosu_core_network_info_req {
+	u64                               user_arg;
+	struct ethosu_core_network_buffer network;
+};
+
+/**
+ * struct ethosu_core_network_info_rsp - Network information response
+ */
+struct ethosu_core_network_info_rsp {
+	u64      user_arg;
+	char     desc[32];
+	u32      is_vela;
+	u32      ifm_count;
+	u32      ifm_size[ETHOSU_CORE_BUFFER_MAX];
+	u32      ifm_types[ETHOSU_CORE_BUFFER_MAX];
+	u32      ifm_offset[ETHOSU_CORE_BUFFER_MAX];
+	u32      ifm_dims[ETHOSU_CORE_BUFFER_MAX];
+	u32      ifm_shapes[ETHOSU_CORE_BUFFER_MAX][ETHOSU_CORE_DIM_MAX];
+	u32      ofm_count;
+	u32      ofm_size[ETHOSU_CORE_BUFFER_MAX];
+	u32      ofm_types[ETHOSU_CORE_BUFFER_MAX];
+	u32      ofm_offset[ETHOSU_CORE_BUFFER_MAX];
+	u32      ofm_dims[ETHOSU_CORE_BUFFER_MAX];
+	u32      ofm_shapes[ETHOSU_CORE_BUFFER_MAX][ETHOSU_CORE_DIM_MAX];
+	u32      status;
+};
+
+/**
+ * struct ethosu_core_msg_version - Message protocol version
  */
 struct ethosu_core_msg_version {
 	uint8_t major;
diff --git a/drivers/firmware/ethosu/ethosu_device.c b/drivers/firmware/ethosu/ethosu_device.c
index 6643a7aaad5b..b0be4bcba7a1 100644
--- a/drivers/firmware/ethosu/ethosu_device.c
+++ b/drivers/firmware/ethosu/ethosu_device.c
@@ -30,6 +30,7 @@
 #include "ethosu_capabilities.h"
 #include "ethosu_inference.h"
 #include "ethosu_network.h"
+#include "ethosu_network_info.h"
 #include "uapi/ethosu.h"
 
 #include <linux/dma-mapping.h>
@@ -75,6 +76,9 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 	struct ethosu_core_msg_capabilities_rsp *capabilities =
 			(struct ethosu_core_msg_capabilities_rsp *)
 			((char *)data + sizeof(struct ethosu_core_msg));
+	struct ethosu_core_network_info_rsp *network_info =
+			(struct ethosu_core_network_info_rsp *)
+			((char *)data + sizeof(struct ethosu_core_msg));
 
 	switch (header->type) {
 	case ETHOSU_CORE_MSG_ERR:
@@ -168,6 +172,22 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 
 		ethosu_capability_rsp(edev, capabilities);
 		break;
+	case ETHOSU_CORE_MSG_NETWORK_INFO_RSP:
+		if (header->length != sizeof(struct ethosu_core_network_info_rsp)) {
+			dev_warn(edev->dev,
+				 "Msg: Network info response of incorrect size. size=%u, expected=%zu\n",
+				 header->length, sizeof(struct ethosu_core_network_info_rsp));
+			ret = -EBADMSG;
+			break;
+		}
+
+		dev_dbg(edev->dev,
+			"Msg: Network info response. user_arg=0x%llx, status=%u",
+			network_info->user_arg,
+			network_info->status);
+
+		ethosu_network_info_rsp(edev, network_info);
+		break;
 	default:
 		/* This should not happen due to version checks */
 		dev_warn(edev->dev, "Msg: Protocol error\n");
@@ -208,10 +228,8 @@ static int ethosu_open(struct inode *inode,
 	if (!ret && atomic_read(&rproc->power) == 0) {
 		init_completion(&edev->erp.rpmsg_ready);
 		ret = rproc_boot(rproc);
-		if (ret)
+		if (ret || wait_for_completion_interruptible(&edev->erp.rpmsg_ready))
 			dev_err(edev->dev, "could not boot a remote processor\n");
-		else
-			wait_for_completion_interruptible(&edev->erp.rpmsg_ready);
 	} else {
 		dev_err(edev->dev, "can't change firmware or remote processor is running\n");
 	}
@@ -279,8 +297,8 @@ static long ethosu_ioctl(struct file *file,
 			break;
 
 		dev_dbg(edev->dev,
-			"Device ioctl: Network create. fd=%u\n",
-			uapi.fd);
+			"Device ioctl: Network create. type=%u, fd/index=%u\n",
+			uapi.type, uapi.fd);
 
 		ret = ethosu_network_create(edev, &uapi);
 		break;
diff --git a/drivers/firmware/ethosu/ethosu_inference.c b/drivers/firmware/ethosu/ethosu_inference.c
index 947988507792..4e5fa214c5d6 100644
--- a/drivers/firmware/ethosu/ethosu_inference.c
+++ b/drivers/firmware/ethosu/ethosu_inference.c
@@ -99,6 +99,7 @@ static int ethosu_inference_send(struct ethosu_inference *inf)
 				     inf->ifm_count, inf->ifm,
 				     inf->ofm_count, inf->ofm,
 				     inf->net->buf,
+				     inf->net->index,
 				     inf->pmu_event_config,
 				     ETHOSU_PMU_EVENT_MAX,
 				     inf->pmu_cycle_counter_enable,
diff --git a/drivers/firmware/ethosu/ethosu_network.c b/drivers/firmware/ethosu/ethosu_network.c
index a7249619291b..e85e79073306 100644
--- a/drivers/firmware/ethosu/ethosu_network.c
+++ b/drivers/firmware/ethosu/ethosu_network.c
@@ -27,6 +27,7 @@
 #include "ethosu_buffer.h"
 #include "ethosu_device.h"
 #include "ethosu_inference.h"
+#include "ethosu_network_info.h"
 #include "uapi/ethosu.h"
 
 #include <linux/anon_inodes.h>
@@ -69,7 +70,9 @@ static void ethosu_network_destroy(struct kref *kref)
 
 	dev_dbg(net->edev->dev, "Network destroy. net=0x%pK\n", net);
 
-	ethosu_buffer_put(net->buf);
+	if (net->buf)
+		ethosu_buffer_put(net->buf);
+
 	devm_kfree(net->edev->dev, net);
 }
 
@@ -103,6 +106,23 @@ static long ethosu_network_ioctl(struct file *file,
 		file, net, cmd, arg);
 
 	switch (cmd) {
+	case ETHOSU_IOCTL_NETWORK_INFO: {
+		struct ethosu_uapi_network_info uapi;
+
+		if (copy_from_user(&uapi, udata, sizeof(uapi)))
+			break;
+
+		dev_dbg(net->edev->dev,
+			 "Network ioctl: Network info. net=0x%pK\n",
+			 net);
+
+		ret = ethosu_network_info_request(net, &uapi);
+		if (ret)
+			break;
+
+		ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
+		break;
+	}
 	case ETHOSU_IOCTL_INFERENCE_CREATE: {
 		struct ethosu_uapi_inference_create uapi;
 
@@ -131,44 +151,48 @@ static long ethosu_network_ioctl(struct file *file,
 int ethosu_network_create(struct ethosu_device *edev,
 			  struct ethosu_uapi_network_create *uapi)
 {
-	struct ethosu_buffer *buf;
 	struct ethosu_network *net;
 	int ret = -ENOMEM;
 
-	buf = ethosu_buffer_get_from_fd(uapi->fd);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
 	net = devm_kzalloc(edev->dev, sizeof(*net), GFP_KERNEL);
-	if (!net) {
-		ret = -ENOMEM;
-		goto put_buf;
-	}
+	if (!net)
+		return -ENOMEM;
 
 	net->edev = edev;
-	net->buf = buf;
+	net->buf = NULL;
 	kref_init(&net->kref);
 
+	if (uapi->type == ETHOSU_UAPI_NETWORK_BUFFER) {
+		net->buf = ethosu_buffer_get_from_fd(uapi->fd);
+		if (IS_ERR(net->buf)) {
+			ret = PTR_ERR(net->buf);
+			goto free_net;
+		}
+	} else {
+		net->index = uapi->index;
+	}
+
 	ret = anon_inode_getfd("ethosu-network", &ethosu_network_fops, net,
 			       O_RDWR | O_CLOEXEC);
 	if (ret < 0)
-		goto free_net;
+		goto put_buf;
 
 	net->file = fget(ret);
 	fput(net->file);
 
 	dev_dbg(edev->dev,
-		"Network create. file=0x%pK, fd=%d, net=0x%pK, buf=0x%pK",
-		net->file, ret, net, net->buf);
+		"Network create. file=0x%pK, fd=%d, net=0x%pK, buf=0x%pK, index=%u",
+		net->file, ret, net, net->buf, net->index);
 
 	return ret;
 
+put_buf:
+	if (net->buf)
+		ethosu_buffer_put(net->buf);
+
 free_net:
 	devm_kfree(edev->dev, net);
 
-put_buf:
-	ethosu_buffer_put(buf);
-
 	return ret;
 }
 
@@ -199,7 +223,7 @@ void ethosu_network_get(struct ethosu_network *net)
 	kref_get(&net->kref);
 }
 
-void ethosu_network_put(struct ethosu_network *net)
+int ethosu_network_put(struct ethosu_network *net)
 {
-	kref_put(&net->kref, ethosu_network_destroy);
+	return kref_put(&net->kref, ethosu_network_destroy);
 }
diff --git a/drivers/firmware/ethosu/ethosu_network.h b/drivers/firmware/ethosu/ethosu_network.h
index 4236e1586efb..8ca2dd61886e 100644
--- a/drivers/firmware/ethosu/ethosu_network.h
+++ b/drivers/firmware/ethosu/ethosu_network.h
@@ -43,6 +43,7 @@ struct ethosu_network {
 	struct file          *file;
 	struct kref          kref;
 	struct ethosu_buffer *buf;
+	u32                  index;
 };
 
 /****************************************************************************
@@ -75,7 +76,9 @@ void ethosu_network_get(struct ethosu_network *net);
 
 /**
  * ethosu_network_put() - Put network
+ *
+ * Return: 1 if object was removed, else 0.
  */
-void ethosu_network_put(struct ethosu_network *net);
+int ethosu_network_put(struct ethosu_network *net);
 
 #endif /* ETHOSU_NETWORK_H */
diff --git a/drivers/firmware/ethosu/ethosu_network_info.c b/drivers/firmware/ethosu/ethosu_network_info.c
new file mode 100644
index 000000000000..3b8ad935505a
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_network_info.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Arm Limited.
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_network_info.h"
+
+#include "ethosu_device.h"
+#include "ethosu_network.h"
+#include "ethosu_rpmsg.h"
+#include "uapi/ethosu.h"
+
+#define NETWORK_INFO_RESP_TIMEOUT_MS 30000
+
+static inline int ethosu_network_info_send(struct ethosu_network_info *info)
+{
+	/* Send network info request to firmware */
+	return ethosu_rpmsg_network_info_request(&info->edev->erp,
+						 &info->msg,
+						 info->net->buf,
+						 info->net->index);
+}
+
+static void ethosu_network_info_fail(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_network_info *info =
+		container_of(msg, typeof(*info), msg);
+
+	if (completion_done(&info->done))
+		return;
+
+	info->errno = -EFAULT;
+	complete(&info->done);
+}
+
+static int ethosu_network_info_resend(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_network_info *info =
+		container_of(msg, typeof(*info), msg);
+	int ret;
+
+	/* Don't resend request if response has already been received */
+	if (completion_done(&info->done))
+		return 0;
+
+	/* Resend request */
+	ret = ethosu_network_info_send(info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int ethosu_network_info_request(struct ethosu_network *net,
+				struct ethosu_uapi_network_info *uapi)
+{
+	struct ethosu_network_info *info;
+	int ret;
+	int timeout;
+
+	info = devm_kzalloc(net->edev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->edev = net->edev;
+	info->net = net;
+	info->uapi = uapi;
+	init_completion(&info->done);
+	info->msg.fail = ethosu_network_info_fail;
+	info->msg.resend = ethosu_network_info_resend;
+
+	ret = ethosu_rpmsg_register(&info->edev->erp, &info->msg);
+	if (ret < 0)
+		goto kfree;
+
+	/* Get reference to network */
+	ethosu_network_get(info->net);
+
+	ret = ethosu_network_info_send(info);
+	if (ret)
+		goto deregister;
+
+	dev_dbg(info->edev->dev,
+		"Network info create. info=0x%pK, net=0x%pK, msg.id=0x%x\n",
+		info, info->net, info->msg.id);
+
+	/* Unlock the device mutex and wait for completion */
+	mutex_unlock(&info->edev->mutex);
+	timeout = wait_for_completion_timeout(&info->done,
+					      msecs_to_jiffies(NETWORK_INFO_RESP_TIMEOUT_MS));
+	mutex_lock(&info->edev->mutex);
+
+	if (timeout == 0) {
+		dev_warn(info->edev->dev, "Network info timed out. info=0x%pK",
+			 info);
+
+		ret = -ETIME;
+		goto deregister;
+	}
+
+	ret = info->errno;
+
+deregister:
+	ethosu_rpmsg_deregister(&info->edev->erp, &info->msg);
+	ethosu_network_put(info->net);
+
+kfree:
+	dev_dbg(info->edev->dev,
+		"Network info destroy. info=0x%pK, msg.id=0x%x\n",
+		info, info->msg.id);
+	devm_kfree(info->edev->dev, info);
+
+	return ret;
+}
+
+void ethosu_network_info_rsp(struct ethosu_device *edev,
+			     struct ethosu_core_network_info_rsp *rsp)
+{
+	int ret;
+	int id = (int)rsp->user_arg;
+	struct ethosu_rpmsg_msg *msg;
+	struct ethosu_network_info *info;
+	u32 i, j;
+
+	msg = ethosu_rpmsg_find(&edev->erp, id);
+	if (IS_ERR(msg)) {
+		dev_warn(edev->dev,
+			 "Id for network info msg not found. msg.id=0x%x\n",
+			 id);
+
+		return;
+	}
+
+	info = container_of(msg, typeof(*info), msg);
+
+	if (completion_done(&info->done))
+		return;
+
+	info->errno = 0;
+
+	if (rsp->status != ETHOSU_CORE_STATUS_OK) {
+		info->errno = -EBADF;
+		goto signal_complete;
+	}
+
+	if (rsp->ifm_count > ETHOSU_CORE_BUFFER_MAX || rsp->ofm_count > ETHOSU_CORE_BUFFER_MAX) {
+		info->errno = -ENFILE;
+		goto signal_complete;
+	}
+
+	ret = strscpy(info->uapi->desc, rsp->desc, sizeof(info->uapi->desc));
+	if (ret < 0) {
+		info->errno = ret;
+		goto signal_complete;
+	}
+
+	info->uapi->is_vela = rsp->is_vela;
+	info->uapi->ifm_count = rsp->ifm_count;
+	for (i = 0; i < rsp->ifm_count; i++) {
+		info->uapi->ifm_size[i] = rsp->ifm_size[i];
+		info->uapi->ifm_types[i] = rsp->ifm_types[i];
+		info->uapi->ifm_offset[i] = rsp->ifm_offset[i];
+		info->uapi->ifm_dims[i] = rsp->ifm_dims[i];
+		for (j = 0; j < rsp->ifm_dims[i]; j++)
+			info->uapi->ifm_shapes[i][j] = rsp->ifm_shapes[i][j];
+        }
+
+	info->uapi->ofm_count = rsp->ofm_count;
+	for (i = 0; i < rsp->ofm_count; i++) {
+		info->uapi->ofm_size[i] = rsp->ofm_size[i];
+		info->uapi->ofm_types[i] = rsp->ofm_types[i];
+		info->uapi->ofm_offset[i] = rsp->ofm_offset[i];
+		info->uapi->ofm_dims[i] = rsp->ofm_dims[i];
+		for (j = 0; j < rsp->ofm_dims[i]; j++)
+			info->uapi->ofm_shapes[i][j] = rsp->ofm_shapes[i][j];
+	}
+
+signal_complete:
+	complete(&info->done);
+}
diff --git a/drivers/firmware/ethosu/ethosu_network_info.h b/drivers/firmware/ethosu/ethosu_network_info.h
new file mode 100644
index 000000000000..b5bc00f8e34a
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_network_info.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Arm Limited.
+ */
+
+#ifndef ETHOSU_NETWORK_INFO_H
+#define ETHOSU_NETWORK_INFO_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_core_interface.h"
+#include "ethosu_rpmsg.h"
+
+#include <linux/types.h>
+#include <linux/completion.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+struct ethosu_device;
+struct ethosu_network;
+struct ethosu_uapi_network_info;
+
+struct ethosu_network_info {
+	struct ethosu_device            *edev;
+	struct ethosu_network           *net;
+	struct ethosu_uapi_network_info *uapi;
+	struct completion               done;
+	int                             errno;
+	struct ethosu_rpmsg_msg         msg;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_network_info_request() - Send a network info request
+ *
+ * This function must be called in the context of a user space process.
+ *
+ * Return: 0 on success, .
+ */
+int ethosu_network_info_request(struct ethosu_network *net,
+				struct ethosu_uapi_network_info *uapi);
+
+/**
+ * ethosu_network_info_rsp() - Handle network info response.
+ */
+void ethosu_network_info_rsp(struct ethosu_device *edev,
+			     struct ethosu_core_network_info_rsp *rsp);
+
+#endif /* ETHOSU_NETWORK_INFO_H */
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
index a92439b81c96..368a519e36b1 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.c
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -190,6 +190,7 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 			   uint32_t ofm_count,
 			   struct ethosu_buffer **ofm,
 			   struct ethosu_buffer *network,
+			   u32 network_index,
 			   uint8_t *pmu_event_config,
 			   uint8_t pmu_event_config_count,
 			   uint8_t pmu_cycle_counter_enable,
@@ -229,7 +230,13 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 	for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++)
 		req.pmu_event_config[i] = pmu_event_config[i];
 
-	ethosu_core_set_size(network, &req.network);
+	if (network) {
+		req.network.type = ETHOSU_CORE_NETWORK_BUFFER;
+		ethosu_core_set_size(network, &req.network.buffer);
+	} else {
+		req.network.type = ETHOSU_CORE_NETWORK_INDEX;
+		req.network.index = network_index;
+	}
 
 	memcpy(data, &msg, sizeof(struct ethosu_core_msg));
 	memcpy(data + sizeof(struct ethosu_core_msg), &req,
@@ -246,6 +253,47 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 	return 0;
 }
 
+int ethosu_rpmsg_network_info_request(struct ethosu_rpmsg *erp,
+				      struct ethosu_rpmsg_msg *rpmsg,
+				      struct ethosu_buffer *network,
+				      uint32_t network_index)
+{
+	struct ethosu_core_msg msg = {
+		.magic  = ETHOSU_CORE_MSG_MAGIC,
+		.type   = ETHOSU_CORE_MSG_NETWORK_INFO_REQ,
+		.length = sizeof(struct ethosu_core_network_info_req)
+	};
+	struct ethosu_core_network_info_req req;
+	struct rpmsg_device *rpdev = erp->rpdev;
+	u8 data[sizeof(struct ethosu_core_msg) +
+		sizeof(struct ethosu_core_network_info_req)];
+	int ret;
+
+	req.user_arg = rpmsg->id;
+
+	if (network) {
+		req.network.type = ETHOSU_CORE_NETWORK_BUFFER;
+		ethosu_core_set_size(network, &req.network.buffer);
+	} else {
+		req.network.type = ETHOSU_CORE_NETWORK_INDEX;
+		req.network.index = network_index;
+	}
+
+	memcpy(data, &msg, sizeof(struct ethosu_core_msg));
+	memcpy(data + sizeof(struct ethosu_core_msg), &req,
+	       sizeof(struct ethosu_core_network_info_req));
+
+	ret = rpmsg_send(rpdev->ept, (void *)&data,
+			 sizeof(struct ethosu_core_msg) +
+			 sizeof(struct ethosu_core_network_info_req));
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
index 74ee2fdea5cb..ba6fb8fd5869 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.h
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -84,12 +84,23 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 			   uint32_t ofm_count,
 			   struct ethosu_buffer **ofm,
 			   struct ethosu_buffer *network,
+			   u32 network_index,
 			   uint8_t *pmu_event_config,
 			   uint8_t pmu_event_config_count,
 			   uint8_t pmu_cycle_counter_enable,
 			   uint32_t inference_type
 			   );
 
+/**
+ * ethosu_rpmsg_network_info_request() - Send network info request
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_rpmsg_network_info_request(struct ethosu_rpmsg *erp,
+				      struct ethosu_rpmsg_msg *rpmsg,
+				      struct ethosu_buffer *network,
+				      uint32_t network_index);
+
 int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
 		      ethosu_rpmsg_cb callback, void *user_arg);
 
diff --git a/drivers/firmware/ethosu/uapi/ethosu.h b/drivers/firmware/ethosu/uapi/ethosu.h
index 648cec40473b..64a7d9d4885e 100644
--- a/drivers/firmware/ethosu/uapi/ethosu.h
+++ b/drivers/firmware/ethosu/uapi/ethosu.h
@@ -44,7 +44,8 @@ namespace EthosU {
 
 #define ETHOSU_IOCTL_PING               ETHOSU_IO(0x00)
 #define ETHOSU_IOCTL_VERSION_REQ        ETHOSU_IO(0x01)
-#define ETHOSU_IOCTL_CAPABILITIES_REQ   ETHOSU_IO(0x02)
+#define ETHOSU_IOCTL_CAPABILITIES_REQ   ETHOSU_IOR(0x02, \
+						   struct ethosu_uapi_device_capabilities)
 #define ETHOSU_IOCTL_BUFFER_CREATE      ETHOSU_IOR(0x10, \
 						   struct ethosu_uapi_buffer_create)
 #define ETHOSU_IOCTL_BUFFER_SET         ETHOSU_IOR(0x11, \
@@ -53,6 +54,8 @@ namespace EthosU {
 						   struct ethosu_uapi_buffer)
 #define ETHOSU_IOCTL_NETWORK_CREATE     ETHOSU_IOR(0x20, \
 						   struct ethosu_uapi_network_create)
+#define ETHOSU_IOCTL_NETWORK_INFO       ETHOSU_IOR(0x21, \
+						   struct ethosu_uapi_network_info)
 #define ETHOSU_IOCTL_INFERENCE_CREATE   ETHOSU_IOR(0x30, \
 						   struct ethosu_uapi_inference_create)
 #define ETHOSU_IOCTL_INFERENCE_STATUS   ETHOSU_IOR(0x31, \
@@ -100,12 +103,45 @@ struct ethosu_uapi_buffer {
 	__u32 size;
 };
 
+/**
+ * enum ethosu_uapi_network_create - Network buffer type.
+ * @ETHOSU_UAPI_NETWORK_BUFFER:	Network is stored in a buffer handle.
+ * @ETHOSU_UAPI_NETWORK_INDEX:	Network is built into firmware and referenced by
+ *                              index.
+ */
+enum ethosu_uapi_network_type {
+	ETHOSU_UAPI_NETWORK_BUFFER = 1,
+	ETHOSU_UAPI_NETWORK_INDEX
+};
+
 /**
  * struct ethosu_uapi_network_create - Create network request
+ * @type:	Buffer type. See @ethosu_uapi_network_type.
  * @fd:		Buffer file descriptor
+ * @index:	Buffer index compiled into firmware binary.
  */
 struct ethosu_uapi_network_create {
-	__u32 fd;
+	u32 type;
+	union {
+		__u32 fd;
+		__u32 index;
+	};
+};
+
+/**
+ * struct ethosu_uapi_network_info - Network info
+ * @desc:		Network description
+ * @ifm_count:		Number of IFM buffers
+ * @ifm_size:		IFM buffer sizes
+ * @ofm_count:		Number of OFM buffers
+ * @ofm_size:		OFM buffer sizes
+ */
+struct ethosu_uapi_network_info {
+	char  desc[32];
+	__u32 ifm_count;
+	__u32 ifm_size[ETHOSU_FD_MAX];
+	__u32 ofm_count;
+	__u32 ofm_size[ETHOSU_FD_MAX];
 };
 
 /**
@@ -162,7 +198,7 @@ struct ethosu_uapi_device_hw_cfg {
 };
 
 /**
- * struct ethosu_uapi_capabilities - Device capabilities
+ * struct ethosu_uapi_device_capabilities - Device capabilities
  * @hw_id:                     Hardware identification
  * @hw_cfg:                    Hardware configuration
  * @driver_patch_rev:          Driver version patch
-- 
2.17.1

