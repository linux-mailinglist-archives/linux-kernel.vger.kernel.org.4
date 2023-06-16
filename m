Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C757326E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbjFPFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbjFPFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:12 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE42D62
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:06 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A452B1A05B8;
        Fri, 16 Jun 2023 07:43:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13DF91A068F;
        Fri, 16 Jun 2023 07:43:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E567D181D0C0;
        Fri, 16 Jun 2023 13:43:04 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 5/8] ethosu: Use ids for identifying messages sent to Ethos-U firmware
Date:   Fri, 16 Jun 2023 13:59:10 +0800
Message-Id: <20230616055913.2360-6-alison.wang@nxp.com>
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

Avoid to use pointers to kernel memory as identify messages, prior this
change, if memory is reused that can lead to unexpected conflicts.

Remove ref counting from capabilities since memory is freed in only one
place.

Finally, extract the capabilities code in its own files.

Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 drivers/firmware/ethosu/Kconfig               |   2 +-
 drivers/firmware/ethosu/Makefile              |   5 +-
 drivers/firmware/ethosu/ethosu_buffer.c       |  34 +--
 drivers/firmware/ethosu/ethosu_buffer.h       |   2 +-
 drivers/firmware/ethosu/ethosu_capabilities.c | 157 ++++++++++++
 drivers/firmware/ethosu/ethosu_capabilities.h |  47 ++++
 .../firmware/ethosu/ethosu_core_interface.h   |  20 +-
 drivers/firmware/ethosu/ethosu_device.c       | 229 +++++-------------
 drivers/firmware/ethosu/ethosu_device.h       |  17 +-
 drivers/firmware/ethosu/ethosu_driver.c       |   4 +-
 drivers/firmware/ethosu/ethosu_inference.c    | 229 ++++++++++++------
 drivers/firmware/ethosu/ethosu_inference.h    |  14 +-
 drivers/firmware/ethosu/ethosu_network.c      |  22 +-
 drivers/firmware/ethosu/ethosu_network.h      |   2 +-
 drivers/firmware/ethosu/ethosu_rpmsg.c        |  72 +++++-
 drivers/firmware/ethosu/ethosu_rpmsg.h        |  53 +++-
 drivers/firmware/ethosu/uapi/ethosu.h         |   8 +-
 17 files changed, 606 insertions(+), 311 deletions(-)
 create mode 100644 drivers/firmware/ethosu/ethosu_capabilities.c
 create mode 100644 drivers/firmware/ethosu/ethosu_capabilities.h

diff --git a/drivers/firmware/ethosu/Kconfig b/drivers/firmware/ethosu/Kconfig
index ce837f45f8e5..4d3b1b86aabe 100644
--- a/drivers/firmware/ethosu/Kconfig
+++ b/drivers/firmware/ethosu/Kconfig
@@ -1,5 +1,5 @@
 #
-# (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+# (C) COPYRIGHT 2020,2022 ARM Limited.
 #
 # This program is free software and is provided to you under the terms of the
 # GNU General Public License version 2 as published by the Free Software
diff --git a/drivers/firmware/ethosu/Makefile b/drivers/firmware/ethosu/Makefile
index 0b3fe72c9c4f..fa0731adad35 100644
--- a/drivers/firmware/ethosu/Makefile
+++ b/drivers/firmware/ethosu/Makefile
@@ -1,5 +1,5 @@
 #
-# (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+# Copyright (c) 2020,2022 Arm Limited.
 #
 # This program is free software and is provided to you under the terms of the
 # GNU General Public License version 2 as published by the Free Software
@@ -25,4 +25,5 @@ ethosu-objs := ethosu_driver.o \
                ethosu_device.o \
                ethosu_inference.o \
                ethosu_rpmsg.o \
-               ethosu_network.o
+               ethosu_network.o \
+               ethosu_capabilities.o
diff --git a/drivers/firmware/ethosu/ethosu_buffer.c b/drivers/firmware/ethosu/ethosu_buffer.c
index c8aa8031a8de..d71db348a240 100644
--- a/drivers/firmware/ethosu/ethosu_buffer.c
+++ b/drivers/firmware/ethosu/ethosu_buffer.c
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020-2021 Arm Limited. All rights reserved.
+ * Copyright (c) 2020-2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -126,7 +126,7 @@ static void ethosu_buffer_destroy(struct kref *kref)
 	struct ethosu_buffer *buf =
 		container_of(kref, struct ethosu_buffer, kref);
 
-	dev_info(buf->edev->dev, "Buffer destroy. handle=0x%pK\n", buf);
+	dev_dbg(buf->edev->dev, "Buffer destroy. buf=0x%pK\n", buf);
 
 	dma_free_coherent(buf->edev->dev, buf->capacity, buf->cpu_addr,
 			  buf->dma_addr_orig);
@@ -138,7 +138,8 @@ static int ethosu_buffer_release(struct inode *inode,
 {
 	struct ethosu_buffer *buf = file->private_data;
 
-	dev_info(buf->edev->dev, "Buffer release. handle=0x%pK\n", buf);
+	dev_dbg(buf->edev->dev, "Buffer release. file=0x%pK, buf=0x%pK\n",
+		file, buf);
 
 	ethosu_buffer_put(buf);
 
@@ -151,7 +152,8 @@ static int ethosu_buffer_mmap(struct file *file,
 	struct ethosu_buffer *buf = file->private_data;
 	int ret;
 
-	dev_info(buf->edev->dev, "Buffer mmap. handle=0x%pK\n", buf);
+	dev_dbg(buf->edev->dev, "Buffer mmap. file=0x%pK, buf=0x%pK\n",
+		file, buf);
 
 	ret = dma_mmap_coherent(buf->edev->dev, vma, buf->cpu_addr,
 				buf->dma_addr_orig,
@@ -172,7 +174,9 @@ static long ethosu_buffer_ioctl(struct file *file,
 	if (ret)
 		return ret;
 
-	dev_info(buf->edev->dev, "Ioctl. cmd=%u, arg=%lu\n", cmd, arg);
+	dev_dbg(buf->edev->dev,
+		"Buffer ioctl. file=0x%pK, buf=0x%pK, cmd=0x%x, arg=%lu\n",
+		file, buf, cmd, arg);
 
 	switch (cmd) {
 	case ETHOSU_IOCTL_BUFFER_SET: {
@@ -181,9 +185,9 @@ static long ethosu_buffer_ioctl(struct file *file,
 		if (copy_from_user(&uapi, udata, sizeof(uapi)))
 			break;
 
-		dev_info(buf->edev->dev,
-			 "Ioctl: Buffer set. size=%u, offset=%u\n",
-			 uapi.size, uapi.offset);
+		dev_dbg(buf->edev->dev,
+			"Buffer ioctl: Buffer set. size=%u, offset=%u\n",
+			uapi.size, uapi.offset);
 
 		ret = ethosu_buffer_resize(buf, uapi.size, uapi.offset);
 		break;
@@ -194,9 +198,9 @@ static long ethosu_buffer_ioctl(struct file *file,
 		uapi.size = buf->size;
 		uapi.offset = buf->offset;
 
-		dev_info(buf->edev->dev,
-			 "Ioctl: Buffer get. size=%u, offset=%u\n",
-			 uapi.size, uapi.offset);
+		dev_dbg(buf->edev->dev,
+			"Buffer ioctl: Buffer get. size=%u, offset=%u\n",
+			uapi.size, uapi.offset);
 
 		if (copy_to_user(udata, &uapi, sizeof(uapi)))
 			break;
@@ -252,10 +256,10 @@ int ethosu_buffer_create(struct ethosu_device *edev,
 	buf->file = fget(ret);
 	fput(buf->file);
 
-	dev_info(buf->edev->dev,
-		 "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
-		 buf, capacity, buf->cpu_addr, buf->dma_addr,
-		 buf->dma_addr_orig, virt_to_phys(buf->cpu_addr));
+	dev_dbg(buf->edev->dev,
+		"Buffer create. file=0x%pK, fd=%d, buf=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
+		buf->file, ret, buf, capacity, buf->cpu_addr, buf->dma_addr,
+		buf->dma_addr_orig, virt_to_phys(buf->cpu_addr));
 
 	return ret;
 
diff --git a/drivers/firmware/ethosu/ethosu_buffer.h b/drivers/firmware/ethosu/ethosu_buffer.h
index 14f26c2b0a9d..7a21fcb36b2d 100644
--- a/drivers/firmware/ethosu/ethosu_buffer.h
+++ b/drivers/firmware/ethosu/ethosu_buffer.h
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020,2022 ARM Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
diff --git a/drivers/firmware/ethosu/ethosu_capabilities.c b/drivers/firmware/ethosu/ethosu_capabilities.c
new file mode 100644
index 000000000000..5d7818feafe1
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_capabilities.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Arm Limited.
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_capabilities.h"
+
+#include "ethosu_device.h"
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+
+/****************************************************************************
+ * Defines
+ ****************************************************************************/
+
+#define CAPABILITIES_RESP_TIMEOUT_MS 2000
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+static inline int ethosu_capabilities_send(struct ethosu_capabilities *cap)
+{
+	return ethosu_rpmsg_capabilities_request(&cap->edev->erp,
+						 &cap->msg);
+}
+
+static void ethosu_capabilities_fail(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_capabilities *cap =
+		container_of(msg, typeof(*cap), msg);
+
+	if (completion_done(&cap->done))
+		return;
+
+	cap->errno = -EFAULT;
+	complete(&cap->done);
+}
+
+static int ethosu_capabilities_resend(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_capabilities *cap =
+		container_of(msg, typeof(*cap), msg);
+
+	/* Don't resend request if response has already been received */
+	if (completion_done(&cap->done))
+		return 0;
+
+	/* Resend request */
+	return ethosu_capabilities_send(cap);
+}
+
+void ethosu_capability_rsp(struct ethosu_device *edev,
+			   struct ethosu_core_msg_capabilities_rsp *rsp)
+{
+	int id = (int)rsp->user_arg;
+	struct ethosu_rpmsg_msg *msg;
+	struct ethosu_capabilities *cap;
+
+	msg = ethosu_rpmsg_find(&edev->erp, id);
+	if (IS_ERR(msg)) {
+		dev_warn(edev->dev,
+			 "Id for capabilities msg not found. id=%d\n",
+			 id);
+
+		return;
+	}
+
+	cap = container_of(msg, typeof(*cap), msg);
+
+	if (completion_done(&cap->done))
+		return;
+
+	cap->uapi->hw_id.version_status = rsp->version_status;
+	cap->uapi->hw_id.version_minor = rsp->version_minor;
+	cap->uapi->hw_id.version_major = rsp->version_major;
+	cap->uapi->hw_id.product_major = rsp->product_major;
+	cap->uapi->hw_id.arch_patch_rev = rsp->arch_patch_rev;
+	cap->uapi->hw_id.arch_minor_rev = rsp->arch_minor_rev;
+	cap->uapi->hw_id.arch_major_rev = rsp->arch_major_rev;
+	cap->uapi->driver_patch_rev = rsp->driver_patch_rev;
+	cap->uapi->driver_minor_rev = rsp->driver_minor_rev;
+	cap->uapi->driver_major_rev = rsp->driver_major_rev;
+	cap->uapi->hw_cfg.macs_per_cc = rsp->macs_per_cc;
+	cap->uapi->hw_cfg.cmd_stream_version = rsp->cmd_stream_version;
+	cap->uapi->hw_cfg.custom_dma = rsp->custom_dma;
+
+	cap->errno = 0;
+	complete(&cap->done);
+}
+
+int ethosu_capabilities_request(struct ethosu_device *edev,
+				struct ethosu_uapi_device_capabilities *uapi)
+{
+	struct ethosu_capabilities *cap;
+	int ret;
+	int timeout;
+
+	cap = devm_kzalloc(edev->dev, sizeof(struct ethosu_capabilities),
+			   GFP_KERNEL);
+	if (!cap)
+		return -ENOMEM;
+
+	cap->edev = edev;
+	cap->uapi = uapi;
+	init_completion(&cap->done);
+	cap->msg.fail = ethosu_capabilities_fail;
+	cap->msg.resend = ethosu_capabilities_resend;
+
+	ret = ethosu_rpmsg_register(&cap->edev->erp, &cap->msg);
+	if (ret < 0)
+		goto kfree;
+
+	dev_dbg(edev->dev, "Capabilities create. Id=%d, handle=0x%p\n",
+		cap->msg.id, cap);
+
+	ret = ethosu_capabilities_send(cap);
+	if (ret != 0)
+		goto deregister;
+
+	/* Unlock the mutex before going to block on the condition */
+	mutex_unlock(&edev->mutex);
+
+	/* wait for response to arrive back */
+	timeout = wait_for_completion_timeout(&cap->done,
+					      msecs_to_jiffies(CAPABILITIES_RESP_TIMEOUT_MS));
+
+	/* take back the mutex before resuming to do anything */
+	mutex_lock(&edev->mutex);
+
+	if (timeout == 0) {
+		dev_warn(edev->dev, "Capabilities response timeout");
+		ret = -ETIME;
+		goto deregister;
+	}
+
+	if (cap->errno) {
+		ret = cap->errno;
+		goto deregister;
+	}
+
+deregister:
+	ethosu_rpmsg_deregister(&cap->edev->erp, &cap->msg);
+
+kfree:
+	dev_dbg(cap->edev->dev, "Capabilities destroy. Id=%d, handle=0x%p\n",
+		cap->msg.id, cap);
+	devm_kfree(cap->edev->dev, cap);
+
+	return ret;
+}
diff --git a/drivers/firmware/ethosu/ethosu_capabilities.h b/drivers/firmware/ethosu/ethosu_capabilities.h
new file mode 100644
index 000000000000..87ddac3f635c
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_capabilities.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Arm Limited.
+ */
+
+#ifndef ETHOSU_CAPABILITIES_H
+#define ETHOSU_CAPABILITIES_H
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
+struct ethosu_uapi_device_capabilities;
+
+/**
+ * struct ethosu_capabilities - Capabilities internal struct
+ */
+struct ethosu_capabilities {
+	struct ethosu_device                   *edev;
+	struct completion                      done;
+	struct ethosu_uapi_device_capabilities *uapi;
+	struct ethosu_rpmsg_msg                msg;
+	int                                    errno;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+int ethosu_capabilities_request(struct ethosu_device *edev,
+				struct ethosu_uapi_device_capabilities *uapi);
+
+void ethosu_capability_rsp(struct ethosu_device *edev,
+			   struct ethosu_core_msg_capabilities_rsp *rsp);
+
+#endif
diff --git a/drivers/firmware/ethosu/ethosu_core_interface.h b/drivers/firmware/ethosu/ethosu_core_interface.h
index 9267e96aec9b..11b695a5219d 100644
--- a/drivers/firmware/ethosu/ethosu_core_interface.h
+++ b/drivers/firmware/ethosu/ethosu_core_interface.h
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020-2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -93,11 +93,24 @@ struct ethosu_core_queue {
 	uint8_t                         data[];
 };
 
+/**
+ * enum ethosu_core_status - Status
+ */
 enum ethosu_core_status {
 	ETHOSU_CORE_STATUS_OK,
-	ETHOSU_CORE_STATUS_ERROR
+	ETHOSU_CORE_STATUS_ERROR,
+	ETHOSU_CORE_STATUS_RUNNING,
+	ETHOSU_CORE_STATUS_REJECTED,
+	ETHOSU_CORE_STATUS_ABORTED,
+	ETHOSU_CORE_STATUS_ABORTING,
 };
 
+/**
+ * struct ethosu_core_buffer - Buffer descriptor
+ *
+ * Pointer and size to a buffer within the Ethos-U
+ * address space.
+ */
 struct ethosu_core_buffer {
 	uint32_t ptr;
 	uint32_t size;
@@ -115,6 +128,9 @@ struct ethosu_core_inference_req {
 	uint32_t                  inference_type;
 };
 
+/**
+ * struct ethosu_core_inference_rsp - Inference response
+ */
 struct ethosu_core_inference_rsp {
 	uint64_t user_arg;
 	uint32_t ofm_count;
diff --git a/drivers/firmware/ethosu/ethosu_device.c b/drivers/firmware/ethosu/ethosu_device.c
index 1627f25c8a95..6643a7aaad5b 100644
--- a/drivers/firmware/ethosu/ethosu_device.c
+++ b/drivers/firmware/ethosu/ethosu_device.c
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020-2022 Arm Limited.
  * Copyright 2020-2022 NXP
  *
  * This program is free software and is provided to you under the terms of the
@@ -27,11 +27,11 @@
 
 #include "ethosu_buffer.h"
 #include "ethosu_core_interface.h"
+#include "ethosu_capabilities.h"
 #include "ethosu_inference.h"
 #include "ethosu_network.h"
 #include "uapi/ethosu.h"
 
-#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -48,8 +48,6 @@
 
 #define DMA_ADDR_BITS 32 /* Number of address bits */
 
-#define CAPABILITIES_RESP_TIMEOUT_MS 2000
-
 #define ETHOSU_FIRMWARE_NAME "ethosu_firmware"
 
 /****************************************************************************
@@ -60,70 +58,6 @@
  * Functions
  ****************************************************************************/
 
-static void ethosu_capabilities_destroy(struct kref *kref)
-{
-	struct ethosu_capabilities *cap =
-		container_of(kref, struct ethosu_capabilities, refcount);
-
-	list_del(&cap->list);
-
-	devm_kfree(cap->edev->dev, cap);
-}
-
-static int ethosu_capabilities_find(struct ethosu_capabilities *cap,
-				    struct list_head *capabilties_list)
-{
-	struct ethosu_capabilities *cur;
-
-	list_for_each_entry(cur, capabilties_list, list) {
-		if (cur == cap)
-			return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int ethosu_capability_rsp(struct ethosu_device *edev,
-				 struct ethosu_core_msg_capabilities_rsp *msg)
-{
-	struct ethosu_capabilities *cap;
-	struct ethosu_uapi_device_capabilities *capabilities;
-	int ret;
-
-	cap = (struct ethosu_capabilities *)msg->user_arg;
-	ret = ethosu_capabilities_find(cap, &edev->capabilities_list);
-	if (0 != ret) {
-		dev_warn(edev->dev,
-			 "Handle not found in capabilities list. handle=0x%p\n",
-			 cap);
-
-		/* NOTE: do not call complete or kref_put on invalid data! */
-		return ret;
-	}
-
-	capabilities = cap->capabilities;
-
-	capabilities->hw_id.version_status = msg->version_status;
-	capabilities->hw_id.version_minor = msg->version_minor;
-	capabilities->hw_id.version_major = msg->version_major;
-	capabilities->hw_id.product_major = msg->product_major;
-	capabilities->hw_id.arch_patch_rev = msg->arch_patch_rev;
-	capabilities->hw_id.arch_minor_rev = msg->arch_minor_rev;
-	capabilities->hw_id.arch_major_rev = msg->arch_major_rev;
-	capabilities->driver_patch_rev = msg->driver_patch_rev;
-	capabilities->driver_minor_rev = msg->driver_minor_rev;
-	capabilities->driver_major_rev = msg->driver_major_rev;
-	capabilities->hw_cfg.macs_per_cc = msg->macs_per_cc;
-	capabilities->hw_cfg.cmd_stream_version = msg->cmd_stream_version;
-	capabilities->hw_cfg.custom_dma = msg->custom_dma;
-
-	complete(&cap->done);
-
-	kref_put(&cap->refcount, ethosu_capabilities_destroy);
-
-	return 0;
-}
-
 /* Incoming messages */
 static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 {
@@ -158,14 +92,14 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 		ret = -EBADMSG;
 		break;
 	case ETHOSU_CORE_MSG_PING:
-		dev_info(edev->dev, "Msg: Ping\n");
+		dev_dbg(edev->dev, "Msg: Ping\n");
 		ret = ethosu_rpmsg_pong(&edev->erp);
 		break;
 	case ETHOSU_CORE_MSG_PONG:
-		dev_info(edev->dev, "Msg: Pong\n");
+		dev_dbg(edev->dev, "Msg: Pong\n");
 		break;
 	case ETHOSU_CORE_MSG_POWER_RSP:
-		dev_info(edev->dev, "Msg: Power response\n");
+		dev_dbg(edev->dev, "Msg: Power response\n");
 		break;
 	case ETHOSU_CORE_MSG_INFERENCE_RSP:
 		if (header->length != sizeof(struct ethosu_core_inference_rsp)) {
@@ -176,10 +110,10 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 			break;
 		}
 
-		dev_info(edev->dev,
-			 "Msg: Inference response. user_arg=0x%llx, ofm_count=%u, status=%u\n",
-			 rsp->user_arg, rsp->ofm_count,
-			 rsp->status);
+		dev_dbg(edev->dev,
+			"Msg: Inference response. user_arg=0x%llx, ofm_count=%u, status=%u\n",
+			rsp->user_arg, rsp->ofm_count,
+			rsp->status);
 		ethosu_inference_rsp(edev, rsp);
 		break;
 	case ETHOSU_CORE_MSG_VERSION_RSP:
@@ -191,9 +125,9 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 			break;
 		}
 
-		dev_info(edev->dev, "Msg: Version response v%u.%u.%u\n",
-			 version->major, version->minor,
-			 version->patch);
+		dev_dbg(edev->dev, "Msg: Version response v%u.%u.%u\n",
+			version->major, version->minor,
+			version->patch);
 
 		/* Check major and minor version match, else return error */
 		if (version->major != ETHOSU_CORE_MSG_VERSION_MAJOR ||
@@ -215,24 +149,24 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 			break;
 		}
 
-		dev_info(edev->dev,
-			 "Msg: Capabilities response ua%llx vs%hhu v%hhu.%hhu p%hhu av%hhu.%hhu.%hhu dv%hhu.%hhu.%hhu mcc%hhu csv%hhu cd%hhu\n",
-			 capabilities->user_arg,
-			 capabilities->version_status,
-			 capabilities->version_major,
-			 capabilities->version_minor,
-			 capabilities->product_major,
-			 capabilities->arch_major_rev,
-			 capabilities->arch_minor_rev,
-			 capabilities->arch_patch_rev,
-			 capabilities->driver_major_rev,
-			 capabilities->driver_minor_rev,
-			 capabilities->driver_patch_rev,
-			 capabilities->macs_per_cc,
-			 capabilities->cmd_stream_version,
-			 capabilities->custom_dma);
-
-		ret = ethosu_capability_rsp(edev, capabilities);
+		dev_dbg(edev->dev,
+			"Msg: Capabilities response ua%llx vs%hhu v%hhu.%hhu p%hhu av%hhu.%hhu.%hhu dv%hhu.%hhu.%hhu mcc%hhu csv%hhu cd%hhu\n",
+			capabilities->user_arg,
+			capabilities->version_status,
+			capabilities->version_major,
+			capabilities->version_minor,
+			capabilities->product_major,
+			capabilities->arch_major_rev,
+			capabilities->arch_minor_rev,
+			capabilities->arch_patch_rev,
+			capabilities->driver_major_rev,
+			capabilities->driver_minor_rev,
+			capabilities->driver_patch_rev,
+			capabilities->macs_per_cc,
+			capabilities->cmd_stream_version,
+			capabilities->custom_dma);
+
+		ethosu_capability_rsp(edev, capabilities);
 		break;
 	default:
 		/* This should not happen due to version checks */
@@ -255,7 +189,7 @@ static int ethosu_open(struct inode *inode,
 
 	file->private_data = edev;
 
-	dev_info(edev->dev, "Opening device node.\n");
+	dev_dbg(edev->dev, "Device open. file=0x%pK\n", file);
 
 	if (of_property_read_u32(edev->dev->of_node, "fsl,cm33-proc",
 				 &rproc_phandle)) {
@@ -287,64 +221,6 @@ static int ethosu_open(struct inode *inode,
 	return nonseekable_open(inode, file);
 }
 
-static int ethosu_send_capabilities_request(struct ethosu_device *edev,
-					    void __user *udata)
-{
-	struct ethosu_uapi_device_capabilities uapi;
-	struct ethosu_capabilities *cap;
-	int ret;
-	int timeout;
-
-	cap = devm_kzalloc(edev->dev, sizeof(struct ethosu_capabilities),
-			   GFP_KERNEL);
-	if (!cap)
-		return -ENOMEM;
-
-	cap->edev = edev;
-	cap->capabilities = &uapi;
-	kref_init(&cap->refcount);
-	init_completion(&cap->done);
-	list_add(&cap->list, &edev->capabilities_list);
-
-	ret = ethosu_rpmsg_capabilities_request(&edev->erp, cap);
-	if (0 != ret)
-		goto put_kref;
-
-	/*
-	 * Increase ref counter since we sent the pointer out to
-	 * response handler thread. That thread is responsible to
-	 * decrease the ref counter before exiting. So the memory
-	 * can be freed.
-	 *
-	 * NOTE: if no response is received back, the memory is leaked.
-	 */
-	kref_get(&cap->refcount);
-	/* Unlock the mutex before going to block on the condition */
-	mutex_unlock(&edev->mutex);
-	/* wait for response to arrive back */
-	timeout = wait_for_completion_timeout(&cap->done,
-					      msecs_to_jiffies(
-						      CAPABILITIES_RESP_TIMEOUT_MS));
-	/* take back the mutex before resuming to do anything */
-	ret = mutex_lock_interruptible(&edev->mutex);
-	if (0 != ret)
-		goto put_kref;
-
-	if (0 == timeout /* timed out*/) {
-		dev_warn(edev->dev,
-			 "Msg: Capabilities response lost - timeout\n");
-		ret = -EIO;
-		goto put_kref;
-	}
-
-	ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
-
-put_kref:
-	kref_put(&cap->refcount, ethosu_capabilities_destroy);
-
-	return ret;
-}
-
 static long ethosu_ioctl(struct file *file,
 			 unsigned int cmd,
 			 unsigned long arg)
@@ -357,32 +233,41 @@ static long ethosu_ioctl(struct file *file,
 	if (ret)
 		return ret;
 
-	dev_info(edev->dev, "Ioctl. cmd=%u, arg=%lu\n", cmd, arg);
+	dev_dbg(edev->dev, "Device ioctl. file=0x%pK, cmd=0x%x, arg=0x%lx\n",
+		file, cmd, arg);
 
 	switch (cmd) {
 	case ETHOSU_IOCTL_VERSION_REQ:
-		dev_info(edev->dev, "Ioctl: Send version request\n");
+		dev_dbg(edev->dev, "Device ioctl: Send version request\n");
 		ret = ethosu_rpmsg_version_request(&edev->erp);
 		break;
-	case ETHOSU_IOCTL_CAPABILITIES_REQ:
-		dev_info(edev->dev, "Ioctl: Send capabilities request\n");
-		ret = ethosu_send_capabilities_request(edev, udata);
+	case ETHOSU_IOCTL_CAPABILITIES_REQ: {
+		struct ethosu_uapi_device_capabilities uapi;
+
+		dev_dbg(edev->dev,
+			"Device ioctl: Send capabilities request\n");
+
+		ret = ethosu_capabilities_request(edev, &uapi);
+		if (ret)
+			break;
+
+		ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
 		break;
+	}
 	case ETHOSU_IOCTL_PING: {
-		dev_info(edev->dev, "Ioctl: Send ping\n");
+		dev_dbg(edev->dev, "Device ioctl: Send ping\n");
 		ret = ethosu_rpmsg_ping(&edev->erp);
 		break;
 	}
 	case ETHOSU_IOCTL_BUFFER_CREATE: {
 		struct ethosu_uapi_buffer_create uapi;
 
-		dev_info(edev->dev, "Ioctl: Buffer create\n");
-
 		if (copy_from_user(&uapi, udata, sizeof(uapi)))
 			break;
 
-		dev_info(edev->dev, "Ioctl: Buffer. capacity=%u\n",
-			 uapi.capacity);
+		dev_dbg(edev->dev,
+			"Device ioctl: Buffer create. capacity=%u\n",
+			uapi.capacity);
 
 		ret = ethosu_buffer_create(edev, uapi.capacity);
 		break;
@@ -393,7 +278,9 @@ static long ethosu_ioctl(struct file *file,
 		if (copy_from_user(&uapi, udata, sizeof(uapi)))
 			break;
 
-		dev_info(edev->dev, "Ioctl: Network. fd=%u\n", uapi.fd);
+		dev_dbg(edev->dev,
+			"Device ioctl: Network create. fd=%u\n",
+			uapi.fd);
 
 		ret = ethosu_network_create(edev, &uapi);
 		break;
@@ -444,8 +331,6 @@ int ethosu_dev_init(struct ethosu_device *edev,
 	edev->class = class;
 	edev->devt = devt;
 	mutex_init(&edev->mutex);
-	INIT_LIST_HEAD(&edev->capabilities_list);
-	INIT_LIST_HEAD(&edev->inference_list);
 
 	ret = of_reserved_mem_device_init(edev->dev);
 	if (ret)
@@ -474,9 +359,9 @@ int ethosu_dev_init(struct ethosu_device *edev,
 		goto del_cdev;
 	}
 
-	dev_info(edev->dev,
-		 "Created Arm Ethos-U device. name=%s, major=%d, minor=%d\n",
-		 dev_name(sysdev), MAJOR(edev->devt), MINOR(edev->devt));
+	dev_dbg(edev->dev,
+		"Created Arm Ethos-U device. name=%s, major=%d, minor=%d\n",
+		dev_name(sysdev), MAJOR(edev->devt), MINOR(edev->devt));
 
 	return 0;
 
@@ -498,6 +383,4 @@ void ethosu_dev_deinit(struct ethosu_device *edev)
 	device_destroy(edev->class, edev->cdev.dev);
 	cdev_del(&edev->cdev);
 	of_reserved_mem_device_release(edev->dev);
-
-	dev_info(edev->dev, "%s\n", __FUNCTION__);
 }
diff --git a/drivers/firmware/ethosu/ethosu_device.h b/drivers/firmware/ethosu/ethosu_device.h
index da470241b6a1..d027d8d9b11d 100644
--- a/drivers/firmware/ethosu/ethosu_device.h
+++ b/drivers/firmware/ethosu/ethosu_device.h
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020-2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -32,8 +32,6 @@
 #include <linux/cdev.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
-#include <linux/workqueue.h>
-#include <linux/completion.h>
 
 /****************************************************************************
  * Types
@@ -49,22 +47,9 @@ struct ethosu_device {
 	dev_t                 devt;
 	struct mutex          mutex;
 	struct ethosu_rpmsg   erp;
-	struct list_head      capabilities_list;
-	struct list_head      inference_list;
 	bool                  open;
 };
 
-/**
- * struct ethosu_capabilities - Capabilities internal struct
- */
-struct ethosu_capabilities {
-	struct ethosu_device                   *edev;
-	struct completion                      done;
-	struct kref                            refcount;
-	struct ethosu_uapi_device_capabilities *capabilities;
-	struct list_head                       list;
-};
-
 /****************************************************************************
  * Functions
  ****************************************************************************/
diff --git a/drivers/firmware/ethosu/ethosu_driver.c b/drivers/firmware/ethosu/ethosu_driver.c
index d3306ef625ae..59ae79256564 100644
--- a/drivers/firmware/ethosu/ethosu_driver.c
+++ b/drivers/firmware/ethosu/ethosu_driver.c
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020-2022 Arm Limited.
  * Copyright 2020-2022 NXP
  *
  * This program is free software and is provided to you under the terms of the
@@ -60,7 +60,7 @@ static int ethosu_pdev_probe(struct platform_device *pdev)
 	int minor;
 	int ret;
 
-	dev_info(&pdev->dev, "Probe\n");
+	dev_dbg(&pdev->dev, "Probe\n");
 
 	minor = find_first_zero_bit(minors, MINOR_COUNT);
 	if (minor >= MINOR_COUNT) {
diff --git a/drivers/firmware/ethosu/ethosu_inference.c b/drivers/firmware/ethosu/ethosu_inference.c
index b5e94e19bce0..947988507792 100644
--- a/drivers/firmware/ethosu/ethosu_inference.c
+++ b/drivers/firmware/ethosu/ethosu_inference.c
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020,2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -71,6 +71,18 @@ static const char *status_to_string(const enum ethosu_uapi_status status)
 	case ETHOSU_UAPI_STATUS_ERROR: {
 		return "Error";
 	}
+	case ETHOSU_UAPI_STATUS_RUNNING: {
+		return "Running";
+	}
+	case ETHOSU_UAPI_STATUS_REJECTED: {
+		return "Rejected";
+	}
+	case ETHOSU_UAPI_STATUS_ABORTED: {
+		return "Aborted";
+	}
+	case ETHOSU_UAPI_STATUS_ABORTING: {
+		return "Aborting";
+	}
 	default: {
 		return "Unknown";
 	}
@@ -81,40 +93,82 @@ static int ethosu_inference_send(struct ethosu_inference *inf)
 {
 	int ret;
 
-	if (inf->pending)
-		return -EINVAL;
-
 	inf->status = ETHOSU_UAPI_STATUS_ERROR;
 
-	ret = ethosu_rpmsg_inference(&inf->edev->erp, inf,
-				       inf->ifm_count, inf->ifm,
-				       inf->ofm_count, inf->ofm,
-				       inf->net->buf,
-				       inf->pmu_event_config,
-				       ETHOSU_PMU_EVENT_MAX,
-				       inf->pmu_cycle_counter_enable,
-				       inf->inference_type);
-	if (ret)
+	ret = ethosu_rpmsg_inference(&inf->edev->erp, &inf->msg,
+				     inf->ifm_count, inf->ifm,
+				     inf->ofm_count, inf->ofm,
+				     inf->net->buf,
+				     inf->pmu_event_config,
+				     ETHOSU_PMU_EVENT_MAX,
+				     inf->pmu_cycle_counter_enable,
+				     inf->inference_type);
+	if (ret) {
+		dev_warn(inf->edev->dev,
+			 "Failed to send inference request. inf=0x%pK, ret=%d",
+			 inf, ret);
+
 		return ret;
+	}
 
-	inf->pending = true;
+	inf->status = ETHOSU_UAPI_STATUS_RUNNING;
 
 	ethosu_inference_get(inf);
 
 	return 0;
 }
 
-static int ethosu_inference_find(struct ethosu_inference *inf,
-				 struct list_head *inference_list)
+static void ethosu_inference_fail(struct ethosu_rpmsg_msg *msg)
+{
+	struct ethosu_inference *inf =
+		container_of(msg, typeof(*inf), msg);
+	int ret;
+
+	if (inf->done)
+		return;
+
+	/* Decrement reference count if inference was pending response */
+	ret = ethosu_inference_put(inf);
+	if (ret)
+		return;
+
+	/* Set status accordingly to the inference state */
+	inf->status = inf->status == ETHOSU_UAPI_STATUS_ABORTING ?
+		      ETHOSU_UAPI_STATUS_ABORTED :
+		      ETHOSU_UAPI_STATUS_ERROR;
+	/* Mark it done and wake up the waiting process */
+	inf->done = true;
+	wake_up_interruptible(&inf->waitq);
+}
+
+static int ethosu_inference_resend(struct ethosu_rpmsg_msg *msg)
 {
-	struct ethosu_inference *cur;
+	struct ethosu_inference *inf =
+		container_of(msg, typeof(*inf), msg);
+	int ret;
 
-	list_for_each_entry(cur, inference_list, list) {
-		if (cur == inf)
-			return 0;
+	/* Don't resend request if response has already been received */
+	if (inf->done)
+		return 0;
+
+	/* If marked as ABORTING simply fail it and return */
+	if (inf->status == ETHOSU_UAPI_STATUS_ABORTING) {
+		ethosu_inference_fail(msg);
+
+		return 0;
 	}
 
-	return -EINVAL;
+	/* Decrement reference count for pending request */
+	ret = ethosu_inference_put(inf);
+	if (ret)
+		return 0;
+
+	/* Resend request */
+	ret = ethosu_inference_send(inf);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static bool ethosu_inference_verify(struct file *file)
@@ -127,11 +181,11 @@ static void ethosu_inference_kref_destroy(struct kref *kref)
 	struct ethosu_inference *inf =
 		container_of(kref, struct ethosu_inference, kref);
 
-	dev_info(inf->edev->dev,
-		 "Inference destroy. handle=0x%pK, status=%d\n",
-		 inf, inf->status);
+	dev_dbg(inf->edev->dev,
+		"Inference destroy. inf=0x%pK, status=%d, ifm_count=%u, ofm_count=%u",
+		inf, inf->status, inf->ifm_count, inf->ofm_count);
 
-	list_del(&inf->list);
+	ethosu_rpmsg_deregister(&inf->edev->erp, &inf->msg);
 
 	while (inf->ifm_count-- > 0)
 		ethosu_buffer_put(inf->ifm[inf->ifm_count]);
@@ -148,9 +202,9 @@ static int ethosu_inference_release(struct inode *inode,
 {
 	struct ethosu_inference *inf = file->private_data;
 
-	dev_info(inf->edev->dev,
-		 "Inference release. handle=0x%pK, status=%d\n",
-		 inf, inf->status);
+	dev_dbg(inf->edev->dev,
+		"Inference release. file=0x%pK, inf=0x%pK",
+		file, inf);
 
 	ethosu_inference_put(inf);
 
@@ -165,7 +219,7 @@ static unsigned int ethosu_inference_poll(struct file *file,
 
 	poll_wait(file, &inf->waitq, wait);
 
-	if (!inf->pending)
+	if (inf->done)
 		ret |= POLLIN;
 
 	return ret;
@@ -183,7 +237,9 @@ static long ethosu_inference_ioctl(struct file *file,
 	if (ret)
 		return ret;
 
-	dev_info(inf->edev->dev, "Ioctl: cmd=%u, arg=%lu\n", cmd, arg);
+	dev_dbg(inf->edev->dev,
+		"Inference ioctl: file=0x%pK, inf=0x%pK, cmd=0x%x, arg=%lu",
+		file, inf, cmd, arg);
 
 	switch (cmd) {
 	case ETHOSU_IOCTL_INFERENCE_STATUS: {
@@ -202,16 +258,16 @@ static long ethosu_inference_ioctl(struct file *file,
 		uapi.pmu_config.cycle_count = inf->pmu_cycle_counter_enable;
 		uapi.pmu_count.cycle_count = inf->pmu_cycle_counter_count;
 
-		dev_info(inf->edev->dev,
-			 "Ioctl: Inference status. status=%s (%d)\n",
-			 status_to_string(uapi.status), uapi.status);
+		dev_dbg(inf->edev->dev,
+			"Inference ioctl: Inference status. status=%s (%d)\n",
+			status_to_string(uapi.status), uapi.status);
 
 		ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
 
 		break;
 	}
 	default: {
-		dev_err(inf->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu",
+		dev_err(inf->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu\n",
 			cmd, arg);
 		break;
 	}
@@ -231,9 +287,19 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	int fd;
 	int ret = -ENOMEM;
 
+	if (uapi->ifm_count > ETHOSU_FD_MAX ||
+	    uapi->ofm_count > ETHOSU_FD_MAX) {
+		dev_warn(edev->dev,
+			 "Too many IFM and/or OFM buffers for inference. ifm_count=%u, ofm_count=%u",
+			 uapi->ifm_count, uapi->ofm_count);
+
+		return -EFAULT;
+	}
+
 	inf = devm_kzalloc(edev->dev, sizeof(*inf), GFP_KERNEL);
 	if (!inf)
 		return -ENOMEM;
+
 	switch (uapi->inference_type) {
 	case ETHOSU_UAPI_INFERENCE_MODEL:
 		inf->inference_type = ETHOSU_CORE_INFERENCE_MODEL;
@@ -248,10 +314,17 @@ int ethosu_inference_create(struct ethosu_device *edev,
 
 	inf->edev = edev;
 	inf->net = net;
-	inf->pending = false;
+	inf->done = false;
 	inf->status = ETHOSU_UAPI_STATUS_ERROR;
 	kref_init(&inf->kref);
 	init_waitqueue_head(&inf->waitq);
+	inf->msg.fail = ethosu_inference_fail;
+	inf->msg.resend = ethosu_inference_resend;
+
+	/* Add inference to pending list */
+	ret = ethosu_rpmsg_register(&edev->erp, &inf->msg);
+	if (ret < 0)
+		goto kfree;
 
 	/* Get pointer to IFM buffers */
 	for (i = 0; i < uapi->ifm_count; i++) {
@@ -276,10 +349,10 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	}
 
 	/* Configure PMU and cycle counter */
-	dev_info(inf->edev->dev,
-		 "Configuring events for PMU. events=[%u, %u, %u, %u]\n",
-		 uapi->pmu_config.events[0], uapi->pmu_config.events[1],
-		 uapi->pmu_config.events[2], uapi->pmu_config.events[3]);
+	dev_dbg(inf->edev->dev,
+		"Configuring events for PMU. events=[%u, %u, %u, %u]\n",
+		uapi->pmu_config.events[0], uapi->pmu_config.events[1],
+		uapi->pmu_config.events[2], uapi->pmu_config.events[3]);
 
 	/* Configure events and reset count for all events */
 	for (i = 0; i < ETHOSU_PMU_EVENT_MAX; i++) {
@@ -288,7 +361,7 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	}
 
 	if (uapi->pmu_config.cycle_count)
-		dev_info(inf->edev->dev, "Enabling cycle counter\n");
+		dev_dbg(inf->edev->dev, "Enabling cycle counter\n");
 
 	/* Configure cycle counter and reset any previous count */
 	inf->pmu_cycle_counter_enable = uapi->pmu_config.cycle_count;
@@ -297,6 +370,11 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	/* Increment network reference count */
 	ethosu_network_get(net);
 
+	/* Send inference request to Arm Ethos-U subsystem */
+	ret = ethosu_inference_send(inf);
+	if (ret)
+		goto put_net;
+
 	/* Create file descriptor */
 	ret = fd = anon_inode_getfd("ethosu-inference", &ethosu_inference_fops,
 				    inf, O_RDWR | O_CLOEXEC);
@@ -307,14 +385,9 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	inf->file = fget(ret);
 	fput(inf->file);
 
-	/* Add inference to inference list */
-	list_add(&inf->list, &edev->inference_list);
-
-	/* Send inference request to Arm Ethos-U subsystem */
-	(void)ethosu_inference_send(inf);
-
-	dev_info(edev->dev, "Inference create. handle=0x%pK, fd=%d",
-		 inf, fd);
+	dev_dbg(edev->dev,
+		"Inference create. file=0x%pK, fd=%d, inf=0x%p, net=0x%pK, msg.id=0x%x",
+		 inf->file, fd, inf, inf->net, inf->msg.id);
 
 	return fd;
 
@@ -329,6 +402,7 @@ int ethosu_inference_create(struct ethosu_device *edev,
 	while (inf->ifm_count-- > 0)
 		ethosu_buffer_put(inf->ifm[inf->ifm_count]);
 
+kfree:
 	devm_kfree(edev->dev, inf);
 
 	return ret;
@@ -361,29 +435,30 @@ void ethosu_inference_get(struct ethosu_inference *inf)
 	kref_get(&inf->kref);
 }
 
-void ethosu_inference_put(struct ethosu_inference *inf)
+int ethosu_inference_put(struct ethosu_inference *inf)
 {
-	kref_put(&inf->kref, &ethosu_inference_kref_destroy);
+	return kref_put(&inf->kref, &ethosu_inference_kref_destroy);
 }
 
 void ethosu_inference_rsp(struct ethosu_device *edev,
 			  struct ethosu_core_inference_rsp *rsp)
 {
-	struct ethosu_inference *inf =
-		(struct ethosu_inference *)rsp->user_arg;
+	int id = (int)rsp->user_arg;
+	struct ethosu_rpmsg_msg *msg;
+	struct ethosu_inference *inf;
 	int ret;
 	int i;
 
-	ret = ethosu_inference_find(inf, &edev->inference_list);
-	if (ret) {
+	msg = ethosu_rpmsg_find(&edev->erp, id);
+	if (IS_ERR(msg)) {
 		dev_warn(edev->dev,
-			 "Handle not found in inference list. handle=0x%p\n",
-			 rsp);
+			 "Id for inference msg not found. Id=%d\n",
+			 id);
 
 		return;
 	}
 
-	inf->pending = false;
+	inf = container_of(msg, typeof(*inf), msg);
 
 	if (rsp->status == ETHOSU_CORE_STATUS_OK &&
 	    inf->ofm_count <= ETHOSU_CORE_BUFFER_MAX) {
@@ -400,29 +475,37 @@ void ethosu_inference_rsp(struct ethosu_device *edev,
 			if (ret)
 				inf->status = ETHOSU_UAPI_STATUS_ERROR;
 		}
+	} else if (rsp->status == ETHOSU_CORE_STATUS_REJECTED) {
+		inf->status = ETHOSU_UAPI_STATUS_REJECTED;
+	} else if (rsp->status == ETHOSU_CORE_STATUS_ABORTED) {
+		inf->status = ETHOSU_UAPI_STATUS_ABORTED;
 	} else {
 		inf->status = ETHOSU_UAPI_STATUS_ERROR;
 	}
 
-	for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++) {
-		inf->pmu_event_config[i] = rsp->pmu_event_config[i];
-		inf->pmu_event_count[i] = rsp->pmu_event_count[i];
-	}
+	if (inf->status == ETHOSU_UAPI_STATUS_OK) {
+		for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++) {
+			inf->pmu_event_config[i] = rsp->pmu_event_config[i];
+			inf->pmu_event_count[i] = rsp->pmu_event_count[i];
+		}
+
+		inf->pmu_cycle_counter_enable = rsp->pmu_cycle_counter_enable;
+		inf->pmu_cycle_counter_count = rsp->pmu_cycle_counter_count;
 
-	inf->pmu_cycle_counter_enable = rsp->pmu_cycle_counter_enable;
-	inf->pmu_cycle_counter_count = rsp->pmu_cycle_counter_count;
+		dev_dbg(edev->dev,
+			"PMU events. config=[%u, %u, %u, %u], count=[%u, %u, %u, %u]\n",
+			inf->pmu_event_config[0], inf->pmu_event_config[1],
+			inf->pmu_event_config[2], inf->pmu_event_config[3],
+			inf->pmu_event_count[0], inf->pmu_event_count[1],
+			inf->pmu_event_count[2], inf->pmu_event_count[3]);
 
-	dev_info(edev->dev,
-		 "PMU events. config=[%u, %u, %u, %u], count=[%u, %u, %u, %u]\n",
-		 inf->pmu_event_config[0], inf->pmu_event_config[1],
-		 inf->pmu_event_config[2], inf->pmu_event_config[3],
-		 inf->pmu_event_count[0], inf->pmu_event_count[1],
-		 inf->pmu_event_count[2], inf->pmu_event_count[3]);
+		dev_dbg(edev->dev,
+			"PMU cycle counter. enable=%u, count=%llu\n",
+			inf->pmu_cycle_counter_enable,
+			inf->pmu_cycle_counter_count);
+	}
 
-	dev_info(edev->dev,
-		 "PMU cycle counter. enable=%u, count=%llu\n",
-		 inf->pmu_cycle_counter_enable,
-		 inf->pmu_cycle_counter_count);
+	inf->done = true;
 	wake_up_interruptible(&inf->waitq);
 
 	ethosu_inference_put(inf);
diff --git a/drivers/firmware/ethosu/ethosu_inference.h b/drivers/firmware/ethosu/ethosu_inference.h
index 8414eadbda92..311c727b2897 100644
--- a/drivers/firmware/ethosu/ethosu_inference.h
+++ b/drivers/firmware/ethosu/ethosu_inference.h
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020,2022 ARM Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -25,6 +25,7 @@
  * Includes
  ****************************************************************************/
 
+#include "ethosu_rpmsg.h"
 #include "uapi/ethosu.h"
 
 #include <linux/kref.h>
@@ -48,34 +49,35 @@ struct file;
  * @file:			File handle
  * @kref:			Reference counter
  * @waitq:			Wait queue
+ * @done:			Wait condition is done
  * @ifm:			Pointer to IFM buffer
  * @ofm:			Pointer to OFM buffer
  * @net:			Pointer to network
- * @pending:			Pending response from the firmware
  * @status:			Inference status
  * @pmu_event_config:		PMU event configuration
  * @pmu_event_count:		PMU event count after inference
  * @pmu_cycle_counter_enable:	PMU cycle counter config
  * @pmu_cycle_counter_count:	PMU cycle counter count after inference
+ * @msg:			Rpmsg message
  */
 struct ethosu_inference {
 	struct ethosu_device    *edev;
 	struct file             *file;
 	struct kref             kref;
 	wait_queue_head_t       waitq;
+	bool                    done;
 	uint32_t                ifm_count;
 	struct ethosu_buffer    *ifm[ETHOSU_FD_MAX];
 	uint32_t                ofm_count;
 	struct ethosu_buffer    *ofm[ETHOSU_FD_MAX];
 	struct ethosu_network   *net;
-	bool                    pending;
 	enum ethosu_uapi_status status;
 	uint8_t                 pmu_event_config[ETHOSU_PMU_EVENT_MAX];
 	uint32_t                pmu_event_count[ETHOSU_PMU_EVENT_MAX];
 	uint32_t                pmu_cycle_counter_enable;
 	uint64_t                pmu_cycle_counter_count;
 	uint32_t                inference_type;
-	struct list_head        list;
+	struct ethosu_rpmsg_msg msg;
 };
 
 /****************************************************************************
@@ -109,8 +111,10 @@ void ethosu_inference_get(struct ethosu_inference *inf);
 
 /**
  * ethosu_inference_put() - Put inference
+ *
+ * Return: 1 if object was removed, else 0.
  */
-void ethosu_inference_put(struct ethosu_inference *inf);
+int ethosu_inference_put(struct ethosu_inference *inf);
 
 /**
  * ethosu_inference_rsp() - Handle inference response
diff --git a/drivers/firmware/ethosu/ethosu_network.c b/drivers/firmware/ethosu/ethosu_network.c
index 4d68f0537e38..a7249619291b 100644
--- a/drivers/firmware/ethosu/ethosu_network.c
+++ b/drivers/firmware/ethosu/ethosu_network.c
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020,2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -67,7 +67,7 @@ static void ethosu_network_destroy(struct kref *kref)
 	struct ethosu_network *net =
 		container_of(kref, struct ethosu_network, kref);
 
-	dev_info(net->edev->dev, "Network destroy. handle=0x%pK\n", net);
+	dev_dbg(net->edev->dev, "Network destroy. net=0x%pK\n", net);
 
 	ethosu_buffer_put(net->buf);
 	devm_kfree(net->edev->dev, net);
@@ -78,7 +78,8 @@ static int ethosu_network_release(struct inode *inode,
 {
 	struct ethosu_network *net = file->private_data;
 
-	dev_info(net->edev->dev, "Network release. handle=0x%pK\n", net);
+	dev_dbg(net->edev->dev, "Network release. file=0x%pK, net=0x%pK\n",
+		file, net);
 
 	ethosu_network_put(net);
 
@@ -97,7 +98,9 @@ static long ethosu_network_ioctl(struct file *file,
 	if (ret)
 		return ret;
 
-	dev_info(net->edev->dev, "Ioctl: cmd=%u, arg=%lu\n", cmd, arg);
+	dev_dbg(net->edev->dev,
+		"Network ioctl: file=0x%pK, net=0x%pK, cmd=0x%x, arg=0x%lx\n",
+		file, net, cmd, arg);
 
 	switch (cmd) {
 	case ETHOSU_IOCTL_INFERENCE_CREATE: {
@@ -106,9 +109,9 @@ static long ethosu_network_ioctl(struct file *file,
 		if (copy_from_user(&uapi, udata, sizeof(uapi)))
 			break;
 
-		dev_info(net->edev->dev,
-			 "Ioctl: Inference. ifm_fd=%u, ofm_fd=%u\n",
-			 uapi.ifm_fd[0], uapi.ofm_fd[0]);
+		dev_dbg(net->edev->dev,
+			"Network ioctl: Inference. ifm_fd=%u, ofm_fd=%u\n",
+			uapi.ifm_fd[0], uapi.ofm_fd[0]);
 
 		ret = ethosu_inference_create(net->edev, net, &uapi);
 		break;
@@ -154,8 +157,9 @@ int ethosu_network_create(struct ethosu_device *edev,
 	net->file = fget(ret);
 	fput(net->file);
 
-	dev_info(edev->dev, "Network create. handle=0x%pK",
-		 net);
+	dev_dbg(edev->dev,
+		"Network create. file=0x%pK, fd=%d, net=0x%pK, buf=0x%pK",
+		net->file, ret, net, net->buf);
 
 	return ret;
 
diff --git a/drivers/firmware/ethosu/ethosu_network.h b/drivers/firmware/ethosu/ethosu_network.h
index bb70afcb2572..4236e1586efb 100644
--- a/drivers/firmware/ethosu/ethosu_network.h
+++ b/drivers/firmware/ethosu/ethosu_network.h
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020,2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
index a0320b8407d1..a92439b81c96 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.c
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -32,6 +32,61 @@ static void ethosu_core_set_capacity(struct ethosu_buffer *buf,
 	cbuf->size = (uint32_t)buf->capacity - buf->offset - buf->size;
 }
 
+int ethosu_rpmsg_register(struct ethosu_rpmsg *erp,
+			  struct ethosu_rpmsg_msg *msg)
+{
+	msg->id = idr_alloc_cyclic(&erp->msg_idr, msg, 0, INT_MAX, GFP_KERNEL);
+	if (msg->id < 0)
+		return msg->id;
+
+	return 0;
+}
+
+void ethosu_rpmsg_deregister(struct ethosu_rpmsg *erp,
+			     struct ethosu_rpmsg_msg *msg)
+{
+	idr_remove(&erp->msg_idr, msg->id);
+}
+
+struct ethosu_rpmsg_msg *ethosu_rpmsg_find(struct ethosu_rpmsg *erp,
+					   int msg_id)
+{
+	struct ethosu_rpmsg_msg *ptr =
+		(struct ethosu_rpmsg_msg *)idr_find(&erp->msg_idr, msg_id);
+
+	if (!ptr)
+		return ERR_PTR(-EINVAL);
+
+	return ptr;
+}
+
+void ethosu_rpmsg_fail(struct ethosu_rpmsg *erp)
+{
+	struct ethosu_rpmsg_msg *cur;
+	int id;
+
+	idr_for_each_entry(&erp->msg_idr, cur, id) {
+		cur->fail(cur);
+	}
+}
+
+void ethosu_rpmsg_resend(struct ethosu_rpmsg *erp)
+{
+	struct ethosu_rpmsg_msg *cur;
+	struct rpmsg_device *rpdev = erp->rpdev;
+	int id;
+	int ret;
+
+	idr_for_each_entry(&erp->msg_idr, cur, id) {
+		ret = cur->resend(cur);
+		if (ret) {
+			dev_warn(&rpdev->dev, "Failed to resend msg. ret=%d",
+				 ret);
+			cur->fail(cur);
+		}
+	}
+}
+
 static int ethosu_rpmsg_send(struct ethosu_rpmsg *erp, uint32_t type)
 {
 	struct ethosu_core_msg msg;
@@ -69,7 +124,8 @@ int ethosu_rpmsg_version_request(struct ethosu_rpmsg *erp)
 	return ethosu_rpmsg_send(erp, ETHOSU_CORE_MSG_VERSION_REQ);
 }
 
-int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp, void *user_arg)
+int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp,
+				      struct ethosu_rpmsg_msg *rpmsg)
 {
 	struct ethosu_core_msg msg = {
 		.magic  = ETHOSU_CORE_MSG_MAGIC,
@@ -77,7 +133,7 @@ int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp, void *user_arg)
 		.length = sizeof(struct ethosu_core_capabilities_req)
 	};
 	struct ethosu_core_capabilities_req req = {
-		.user_arg = (uint64_t)user_arg
+		.user_arg = rpmsg->id
 	};
 	struct rpmsg_device *rpdev = erp->rpdev;
 	uint8_t data[sizeof(struct ethosu_core_msg) +
@@ -128,7 +184,7 @@ int ethosu_rpmsg_power_request(struct ethosu_rpmsg *erp,
 }
 
 int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
-			   void *user_arg,
+			   struct ethosu_rpmsg_msg *rpmsg,
 			   uint32_t ifm_count,
 			   struct ethosu_buffer **ifm,
 			   uint32_t ofm_count,
@@ -158,7 +214,7 @@ int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 		return -EINVAL;
 	}
 
-	req.user_arg = (uint64_t)user_arg;
+	req.user_arg = rpmsg->id;
 	req.ifm_count = ifm_count;
 	req.ofm_count = ofm_count;
 	req.pmu_cycle_counter_enable = pmu_cycle_counter_enable;
@@ -215,8 +271,8 @@ static int ethosu_rpmsg_probe(struct rpmsg_device *rpdev)
 	grp->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, grp);
 
-	dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
-		 rpdev->src, rpdev->dst);
+	dev_dbg(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
+		rpdev->src, rpdev->dst);
 
 	ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
 	if (ret) {
@@ -229,7 +285,7 @@ static int ethosu_rpmsg_probe(struct rpmsg_device *rpdev)
 
 static void ethosu_rpmsg_remove(struct rpmsg_device *rpdev)
 {
-	dev_info(&rpdev->dev, "rpmsg ethosu driver is removed\n");
+	dev_dbg(&rpdev->dev, "rpmsg ethosu driver is removed\n");
 }
 
 static struct rpmsg_device_id rpmsg_driver_ethosu_id_table[] = {
@@ -252,6 +308,8 @@ int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
 	grp = erp;
 	erp->callback = callback;
 	erp->user_arg = user_arg;
+	erp->ping_count = 0;
+	idr_init(&erp->msg_idr);
 
 	return register_rpmsg_driver(&ethosu_rpmsg_driver);
 }
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.h b/drivers/firmware/ethosu/ethosu_rpmsg.h
index cee3d96c7895..74ee2fdea5cb 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.h
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -6,8 +6,11 @@
 #ifndef ETHOSU_RPMSG_H
 #define ETHOSU_RPMSG_H
 
+#include <linux/idr.h>
 #include <linux/types.h>
 #include <linux/completion.h>
+#include <linux/workqueue.h>
+
 #include "ethosu_core_interface.h"
 
 struct device;
@@ -22,7 +25,16 @@ struct ethosu_rpmsg {
 	ethosu_rpmsg_cb		callback;
 	void			*user_arg;
 	struct completion       rpmsg_ready;
+	struct idr              msg_idr;
+	unsigned int            ping_count;
+};
+
+struct ethosu_rpmsg_msg {
+	int  id;
+	void (*fail)(struct ethosu_rpmsg_msg *msg);
+	int  (*resend)(struct ethosu_rpmsg_msg *msg);
 };
+
 /**
  * ethosu_rpmsg_ping() - Send ping message
  *
@@ -50,7 +62,7 @@ int ethosu_rpmsg_version_request(struct ethosu_rpmsg *erp);
  * Return: 0 on success, else error code
  */
 int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp,
-				      void *user_arg);
+				      struct ethosu_rpmsg_msg *rpmsg);
 
 /**
  * ethosu_rpmsg_power_request - Send power request
@@ -66,7 +78,7 @@ int ethosu_rpmsg_power_request(struct ethosu_rpmsg *erp,
  * Return: 0 on success, else error code.
  */
 int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
-			   void *user_arg,
+			   struct ethosu_rpmsg_msg *rpmsg,
 			   uint32_t ifm_count,
 			   struct ethosu_buffer **ifm,
 			   uint32_t ofm_count,
@@ -82,4 +94,41 @@ int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
 		      ethosu_rpmsg_cb callback, void *user_arg);
 
 int ethosu_rpmsg_deinit(struct ethosu_rpmsg *erp);
+
+/**
+ * ethosu_rpmsg_register() - Register the ethosu_rpmsg_msg in ethosu_rpmsg
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_rpmsg_register(struct ethosu_rpmsg *erp,
+			  struct ethosu_rpmsg_msg *msg);
+
+/**
+ * ethosu_rpmsg_free_id() - Free the id of the ethosu_rpmsg_msg
+ */
+void ethosu_rpmsg_deregister(struct ethosu_rpmsg *erp,
+			     struct ethosu_rpmsg_msg *msg);
+
+/**
+ * ethosu_rpmsg_find() - Find rpmsg message
+ *
+ * Return: a valid pointer on success, otherwise an error ptr.
+ */
+struct ethosu_rpmsg_msg *ethosu_rpmsg_find(struct ethosu_rpmsg *erq,
+					   int msg_id);
+
+/**
+ * ethosu_rpmsg_fail() - Fail rpmsg messages
+ *
+ * Call fail() callback on all messages in pending list.
+ */
+void ethosu_rpmsg_fail(struct ethosu_rpmsg *erp);
+
+/**
+ * ethosu_rpmsg_resend() - Resend rpmsg messages
+ *
+ * Call resend() callback on all messages in pending list.
+ */
+void ethosu_rpmsg_resend(struct ethosu_rpmsg *erp);
+
 #endif /* ETHOSU_RPMSG_H */
diff --git a/drivers/firmware/ethosu/uapi/ethosu.h b/drivers/firmware/ethosu/uapi/ethosu.h
index c4a0df67336c..648cec40473b 100644
--- a/drivers/firmware/ethosu/uapi/ethosu.h
+++ b/drivers/firmware/ethosu/uapi/ethosu.h
@@ -1,5 +1,5 @@
 /*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright (c) 2020-2022 Arm Limited.
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -73,7 +73,11 @@ namespace EthosU {
  */
 enum ethosu_uapi_status {
 	ETHOSU_UAPI_STATUS_OK,
-	ETHOSU_UAPI_STATUS_ERROR
+	ETHOSU_UAPI_STATUS_ERROR,
+	ETHOSU_UAPI_STATUS_RUNNING,
+	ETHOSU_UAPI_STATUS_REJECTED,
+	ETHOSU_UAPI_STATUS_ABORTED,
+	ETHOSU_UAPI_STATUS_ABORTING,
 };
 
 /**
-- 
2.17.1

