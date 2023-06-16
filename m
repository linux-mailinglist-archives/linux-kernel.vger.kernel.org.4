Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985007326DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbjFPFx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjFPFxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:09 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7402D57
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CBBC1A249A;
        Fri, 16 Jun 2023 07:43:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 928521A0696;
        Fri, 16 Jun 2023 07:43:03 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 397E91820F57;
        Fri, 16 Jun 2023 13:43:02 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 2/8] ethosu: Use RPMsg messaging protocol based on i.MX Rpmsg implementation
Date:   Fri, 16 Jun 2023 13:59:07 +0800
Message-Id: <20230616055913.2360-3-alison.wang@nxp.com>
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

RPMsg is used for the communication mechanism between Cortex-A and
Cortex-M for Ethos-U driver.

Signed-off-by: Lei Xu <lei.xu@nxp.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/ethosu/Makefile           |   2 +-
 drivers/firmware/ethosu/ethosu_device.c    | 143 ++++----
 drivers/firmware/ethosu/ethosu_device.h    |   8 +-
 drivers/firmware/ethosu/ethosu_driver.c    |  23 +-
 drivers/firmware/ethosu/ethosu_inference.c |   2 +-
 drivers/firmware/ethosu/ethosu_mailbox.c   | 377 ---------------------
 drivers/firmware/ethosu/ethosu_mailbox.h   | 140 --------
 drivers/firmware/ethosu/ethosu_rpmsg.c     | 235 +++++++++++++
 drivers/firmware/ethosu/ethosu_rpmsg.h     |  73 ++++
 9 files changed, 383 insertions(+), 620 deletions(-)
 delete mode 100644 drivers/firmware/ethosu/ethosu_mailbox.c
 delete mode 100644 drivers/firmware/ethosu/ethosu_mailbox.h
 create mode 100644 drivers/firmware/ethosu/ethosu_rpmsg.c
 create mode 100644 drivers/firmware/ethosu/ethosu_rpmsg.h

diff --git a/drivers/firmware/ethosu/Makefile b/drivers/firmware/ethosu/Makefile
index 933efee1b22f..0b3fe72c9c4f 100644
--- a/drivers/firmware/ethosu/Makefile
+++ b/drivers/firmware/ethosu/Makefile
@@ -24,5 +24,5 @@ ethosu-objs := ethosu_driver.o \
                ethosu_buffer.o \
                ethosu_device.o \
                ethosu_inference.o \
-               ethosu_mailbox.o \
+               ethosu_rpmsg.o \
                ethosu_network.o
diff --git a/drivers/firmware/ethosu/ethosu_device.c b/drivers/firmware/ethosu/ethosu_device.c
index e6f1e8012b06..b2d4737080ac 100644
--- a/drivers/firmware/ethosu/ethosu_device.c
+++ b/drivers/firmware/ethosu/ethosu_device.c
@@ -1,5 +1,6 @@
 /*
  * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright 2020-2022 NXP
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -121,76 +122,76 @@ static int ethosu_capability_rsp(struct ethosu_device *edev,
 }
 
 /* Incoming messages */
-static int ethosu_handle_msg(struct ethosu_device *edev)
+static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 {
-	int ret;
-	struct ethosu_core_msg header;
-
-	union {
-		struct ethosu_core_msg_err              error;
-		struct ethosu_core_inference_rsp        inf;
-		struct ethosu_core_msg_version          version;
-		struct ethosu_core_msg_capabilities_rsp capabilities;
-	} data;
-
-	/* Read message */
-	ret = ethosu_mailbox_read(&edev->mailbox, &header, &data, sizeof(data));
-	if (ret)
-		return ret;
-
-	switch (header.type) {
+	int ret = 0;
+	struct ethosu_core_msg *header = (struct ethosu_core_msg *)data;
+	struct ethosu_core_msg_err *error =
+			(struct ethosu_core_msg_err *)
+			((char *)data + sizeof(struct ethosu_core_msg));
+	struct ethosu_core_inference_rsp *rsp =
+			(struct ethosu_core_inference_rsp *)
+			((char *)data + sizeof(struct ethosu_core_msg));
+	struct ethosu_core_msg_version *version =
+			(struct ethosu_core_msg_version *)
+			((char *)data + sizeof(struct ethosu_core_msg));
+	struct ethosu_core_msg_capabilities_rsp *capabilities =
+			(struct ethosu_core_msg_capabilities_rsp *)
+			((char *)data + sizeof(struct ethosu_core_msg));
+
+	switch (header->type) {
 	case ETHOSU_CORE_MSG_ERR:
-		if (header.length != sizeof(data.error)) {
+		if (header->length != sizeof(struct ethosu_core_msg_err)) {
 			dev_warn(edev->dev,
-				 "Msg: Error message of incorrect size. size=%u, expected=%zu\n", header.length,
-				 sizeof(data.error));
+				 "Msg: Error message of incorrect size. size=%u, expected=%zu\n", header->length,
+				 sizeof(struct ethosu_core_msg_err));
 			ret = -EBADMSG;
 			break;
 		}
 
-		data.error.msg[sizeof(data.error.msg) - 1] = '\0';
+		error->msg[sizeof(error->msg) - 1] = '\0';
 		dev_warn(edev->dev, "Msg: Error. type=%u, msg=\"%s\"\n",
-			 data.error.type, data.error.msg);
+			 error->type, error->msg);
 		ret = -EBADMSG;
 		break;
 	case ETHOSU_CORE_MSG_PING:
 		dev_info(edev->dev, "Msg: Ping\n");
-		ret = ethosu_mailbox_pong(&edev->mailbox);
+		ret = ethosu_rpmsg_pong(&edev->erp);
 		break;
 	case ETHOSU_CORE_MSG_PONG:
 		dev_info(edev->dev, "Msg: Pong\n");
 		break;
 	case ETHOSU_CORE_MSG_INFERENCE_RSP:
-		if (header.length != sizeof(data.inf)) {
+		if (header->length != sizeof(struct ethosu_core_inference_rsp)) {
 			dev_warn(edev->dev,
-				 "Msg: Inference response of incorrect size. size=%u, expected=%zu\n", header.length,
-				 sizeof(data.inf));
+				 "Msg: Inference response of incorrect size. size=%u, expected=%zu\n", header->length,
+				 sizeof(struct ethosu_core_inference_rsp));
 			ret = -EBADMSG;
 			break;
 		}
 
 		dev_info(edev->dev,
 			 "Msg: Inference response. user_arg=0x%llx, ofm_count=%u, status=%u\n",
-			 data.inf.user_arg, data.inf.ofm_count,
-			 data.inf.status);
-		ethosu_inference_rsp(edev, &data.inf);
+			 rsp->user_arg, rsp->ofm_count,
+			 rsp->status);
+		ethosu_inference_rsp(edev, rsp);
 		break;
 	case ETHOSU_CORE_MSG_VERSION_RSP:
-		if (header.length != sizeof(data.version)) {
+		if (header->length != sizeof(struct ethosu_core_msg_version)) {
 			dev_warn(edev->dev,
-				 "Msg: Version response of incorrect size. size=%u, expected=%zu\n", header.length,
-				 sizeof(data.version));
+				 "Msg: Version response of incorrect size. size=%u, expected=%zu\n", header->length,
+				 sizeof(struct ethosu_core_msg_version));
 			ret = -EBADMSG;
 			break;
 		}
 
 		dev_info(edev->dev, "Msg: Version response v%u.%u.%u\n",
-			 data.version.major, data.version.minor,
-			 data.version.patch);
+			 version->major, version->minor,
+			 version->patch);
 
 		/* Check major and minor version match, else return error */
-		if (data.version.major != ETHOSU_CORE_MSG_VERSION_MAJOR ||
-		    data.version.minor != ETHOSU_CORE_MSG_VERSION_MINOR) {
+		if (version->major != ETHOSU_CORE_MSG_VERSION_MAJOR ||
+		    version->minor != ETHOSU_CORE_MSG_VERSION_MINOR) {
 			dev_warn(edev->dev, "Msg: Version mismatch detected! ");
 			dev_warn(edev->dev, "Local version: v%u.%u.%u\n",
 				 ETHOSU_CORE_MSG_VERSION_MAJOR,
@@ -200,32 +201,32 @@ static int ethosu_handle_msg(struct ethosu_device *edev)
 
 		break;
 	case ETHOSU_CORE_MSG_CAPABILITIES_RSP:
-		if (header.length != sizeof(data.capabilities)) {
+		if (header->length != sizeof(struct ethosu_core_msg_capabilities_rsp)) {
 			dev_warn(edev->dev,
-				 "Msg: Capabilities response of incorrect size. size=%u, expected=%zu\n", header.length,
-				 sizeof(data.capabilities));
+				 "Msg: Capabilities response of incorrect size. size=%u, expected=%zu\n", header->length,
+				 sizeof(struct ethosu_core_msg_capabilities_rsp));
 			ret = -EBADMSG;
 			break;
 		}
 
 		dev_info(edev->dev,
 			 "Msg: Capabilities response ua%llx vs%hhu v%hhu.%hhu p%hhu av%hhu.%hhu.%hhu dv%hhu.%hhu.%hhu mcc%hhu csv%hhu cd%hhu\n",
-			 data.capabilities.user_arg,
-			 data.capabilities.version_status,
-			 data.capabilities.version_major,
-			 data.capabilities.version_minor,
-			 data.capabilities.product_major,
-			 data.capabilities.arch_major_rev,
-			 data.capabilities.arch_minor_rev,
-			 data.capabilities.arch_patch_rev,
-			 data.capabilities.driver_major_rev,
-			 data.capabilities.driver_minor_rev,
-			 data.capabilities.driver_patch_rev,
-			 data.capabilities.macs_per_cc,
-			 data.capabilities.cmd_stream_version,
-			 data.capabilities.custom_dma);
-
-		ret = ethosu_capability_rsp(edev, &data.capabilities);
+			 capabilities->user_arg,
+			 capabilities->version_status,
+			 capabilities->version_major,
+			 capabilities->version_minor,
+			 capabilities->product_major,
+			 capabilities->arch_major_rev,
+			 capabilities->arch_minor_rev,
+			 capabilities->arch_patch_rev,
+			 capabilities->driver_major_rev,
+			 capabilities->driver_minor_rev,
+			 capabilities->driver_patch_rev,
+			 capabilities->macs_per_cc,
+			 capabilities->cmd_stream_version,
+			 capabilities->custom_dma);
+
+		ret = ethosu_capability_rsp(edev, capabilities);
 		break;
 	default:
 		/* This should not happen due to version checks */
@@ -269,7 +270,7 @@ static int ethosu_send_capabilities_request(struct ethosu_device *edev,
 	init_completion(&cap->done);
 	list_add(&cap->list, &edev->capabilities_list);
 
-	ret = ethosu_mailbox_capabilities_request(&edev->mailbox, cap);
+	ret = ethosu_rpmsg_capabilities_request(&edev->erp, cap);
 	if (0 != ret)
 		goto put_kref;
 
@@ -325,7 +326,7 @@ static long ethosu_ioctl(struct file *file,
 	switch (cmd) {
 	case ETHOSU_IOCTL_VERSION_REQ:
 		dev_info(edev->dev, "Ioctl: Send version request\n");
-		ret = ethosu_mailbox_version_request(&edev->mailbox);
+		ret = ethosu_rpmsg_version_request(&edev->erp);
 		break;
 	case ETHOSU_IOCTL_CAPABILITIES_REQ:
 		dev_info(edev->dev, "Ioctl: Send capabilities request\n");
@@ -333,7 +334,7 @@ static long ethosu_ioctl(struct file *file,
 		break;
 	case ETHOSU_IOCTL_PING: {
 		dev_info(edev->dev, "Ioctl: Send ping\n");
-		ret = ethosu_mailbox_ping(&edev->mailbox);
+		ret = ethosu_rpmsg_ping(&edev->erp);
 		break;
 	}
 	case ETHOSU_IOCTL_BUFFER_CREATE: {
@@ -373,7 +374,7 @@ static long ethosu_ioctl(struct file *file,
 	return ret;
 }
 
-static void ethosu_mbox_rx(void *user_arg)
+static void ethosu_rpmsg_rx(void *user_arg, void *data)
 {
 	struct ethosu_device *edev = user_arg;
 	int ret;
@@ -381,13 +382,8 @@ static void ethosu_mbox_rx(void *user_arg)
 	mutex_lock(&edev->mutex);
 
 	do {
-		ret = ethosu_handle_msg(edev);
-		if (ret && ret != -ENOMSG)
-			/* Need to start over in case of error, empty the queue
-			 * by fast-forwarding read position to write position.
-			 * */
-			ethosu_mailbox_reset(&edev->mailbox);
-	} while (ret == 0);
+		ret = ethosu_handle_msg(edev, data);
+	} while (ret != 0);
 
 	mutex_unlock(&edev->mutex);
 }
@@ -395,9 +391,7 @@ static void ethosu_mbox_rx(void *user_arg)
 int ethosu_dev_init(struct ethosu_device *edev,
 		    struct device *dev,
 		    struct class *class,
-		    dev_t devt,
-		    struct resource *in_queue,
-		    struct resource *out_queue)
+		    dev_t devt)
 {
 	static const struct file_operations fops = {
 		.owner          = THIS_MODULE,
@@ -423,8 +417,7 @@ int ethosu_dev_init(struct ethosu_device *edev,
 
 	dma_set_mask_and_coherent(edev->dev, DMA_BIT_MASK(DMA_ADDR_BITS));
 
-	ret = ethosu_mailbox_init(&edev->mailbox, dev, in_queue, out_queue,
-				  ethosu_mbox_rx, edev);
+	ret = ethosu_rpmsg_init(&edev->erp, ethosu_rpmsg_rx, edev);
 	if (ret)
 		goto release_reserved_mem;
 
@@ -434,7 +427,7 @@ int ethosu_dev_init(struct ethosu_device *edev,
 	ret = cdev_add(&edev->cdev, edev->devt, 1);
 	if (ret) {
 		dev_err(edev->dev, "Failed to add character device.\n");
-		goto deinit_mailbox;
+		goto deinit_rpmsg;
 	}
 
 	sysdev = device_create(edev->class, NULL, edev->devt, edev,
@@ -454,8 +447,8 @@ int ethosu_dev_init(struct ethosu_device *edev,
 del_cdev:
 	cdev_del(&edev->cdev);
 
-deinit_mailbox:
-	ethosu_mailbox_deinit(&edev->mailbox);
+deinit_rpmsg:
+	ethosu_rpmsg_deinit(&edev->erp);
 
 release_reserved_mem:
 	of_reserved_mem_device_release(edev->dev);
@@ -465,7 +458,7 @@ int ethosu_dev_init(struct ethosu_device *edev,
 
 void ethosu_dev_deinit(struct ethosu_device *edev)
 {
-	ethosu_mailbox_deinit(&edev->mailbox);
+	ethosu_rpmsg_deinit(&edev->erp);
 	device_destroy(edev->class, edev->cdev.dev);
 	cdev_del(&edev->cdev);
 	of_reserved_mem_device_release(edev->dev);
diff --git a/drivers/firmware/ethosu/ethosu_device.h b/drivers/firmware/ethosu/ethosu_device.h
index 3afdda84862d..3943c8df8f28 100644
--- a/drivers/firmware/ethosu/ethosu_device.h
+++ b/drivers/firmware/ethosu/ethosu_device.h
@@ -26,7 +26,7 @@
  ****************************************************************************/
 
 #include "uapi/ethosu.h"
-#include "ethosu_mailbox.h"
+#include "ethosu_rpmsg.h"
 
 #include <linux/device.h>
 #include <linux/cdev.h>
@@ -48,7 +48,7 @@ struct ethosu_device {
 	struct                class *class;
 	dev_t                 devt;
 	struct mutex          mutex;
-	struct ethosu_mailbox mailbox;
+	struct ethosu_rpmsg   erp;
 	struct list_head      capabilities_list;
 	struct list_head      inference_list;
 };
@@ -76,9 +76,7 @@ struct ethosu_capabilities {
 int ethosu_dev_init(struct ethosu_device *edev,
 		    struct device *dev,
 		    struct class *class,
-		    dev_t devt,
-		    struct resource *in_queue,
-		    struct resource *out_queue);
+		    dev_t devt);
 
 /**
  * ethosu_dev_deinit() - Initialize the device
diff --git a/drivers/firmware/ethosu/ethosu_driver.c b/drivers/firmware/ethosu/ethosu_driver.c
index 9d02431d3194..27931e9aa97c 100644
--- a/drivers/firmware/ethosu/ethosu_driver.c
+++ b/drivers/firmware/ethosu/ethosu_driver.c
@@ -1,5 +1,6 @@
 /*
  * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ * Copyright 2020-2022 NXP
  *
  * This program is free software and is provided to you under the terms of the
  * GNU General Public License version 2 as published by the Free Software
@@ -55,8 +56,6 @@ static DECLARE_BITMAP(minors, MINOR_COUNT);
 static int ethosu_pdev_probe(struct platform_device *pdev)
 {
 	struct ethosu_device *edev;
-	struct resource *in_queue_res;
-	struct resource *out_queue_res;
 	int minor;
 	int ret;
 
@@ -69,23 +68,6 @@ static int ethosu_pdev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	/* Get path to TCM memory */
-	in_queue_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						    "in_queue");
-	if (IS_ERR(in_queue_res)) {
-		dev_err(&pdev->dev, "Failed to get in_queue resource.\n");
-
-		return PTR_ERR(in_queue_res);
-	}
-
-	out_queue_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						     "out_queue");
-	if (IS_ERR(out_queue_res)) {
-		dev_err(&pdev->dev, "Failed to get out_queue resource.\n");
-
-		return PTR_ERR(out_queue_res);
-	}
-
 	/* Allocate memory for Arm Ethos-U device */
 	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
 	if (!edev)
@@ -95,8 +77,7 @@ static int ethosu_pdev_probe(struct platform_device *pdev)
 
 	/* Initialize device */
 	ret = ethosu_dev_init(edev, &pdev->dev, ethosu_class,
-			      MKDEV(MAJOR(devt), minor), in_queue_res,
-			      out_queue_res);
+			      MKDEV(MAJOR(devt), minor));
 	if (ret)
 		goto free_dev;
 
diff --git a/drivers/firmware/ethosu/ethosu_inference.c b/drivers/firmware/ethosu/ethosu_inference.c
index 6fde92c148a0..853947a2334e 100644
--- a/drivers/firmware/ethosu/ethosu_inference.c
+++ b/drivers/firmware/ethosu/ethosu_inference.c
@@ -86,7 +86,7 @@ static int ethosu_inference_send(struct ethosu_inference *inf)
 
 	inf->status = ETHOSU_UAPI_STATUS_ERROR;
 
-	ret = ethosu_mailbox_inference(&inf->edev->mailbox, inf,
+	ret = ethosu_rpmsg_inference(&inf->edev->erp, inf,
 				       inf->ifm_count, inf->ifm,
 				       inf->ofm_count, inf->ofm,
 				       inf->net->buf,
diff --git a/drivers/firmware/ethosu/ethosu_mailbox.c b/drivers/firmware/ethosu/ethosu_mailbox.c
deleted file mode 100644
index 7f159f3b0a60..000000000000
--- a/drivers/firmware/ethosu/ethosu_mailbox.c
+++ /dev/null
@@ -1,377 +0,0 @@
-/*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
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
- */
-
-/****************************************************************************
- * Includes
- ****************************************************************************/
-
-#include "ethosu_mailbox.h"
-
-#include "ethosu_buffer.h"
-#include "ethosu_core_interface.h"
-#include "ethosu_device.h"
-
-#include <linux/resource.h>
-#include <linux/uio.h>
-
-/****************************************************************************
- * Functions
- ****************************************************************************/
-
-static void ethosu_core_set_size(struct ethosu_buffer *buf,
-				 struct ethosu_core_buffer *cbuf)
-{
-	cbuf->ptr = (uint32_t)buf->dma_addr + buf->offset;
-	cbuf->size = (uint32_t)buf->size;
-}
-
-static void ethosu_core_set_capacity(struct ethosu_buffer *buf,
-				     struct ethosu_core_buffer *cbuf)
-{
-	cbuf->ptr = (uint32_t)buf->dma_addr + buf->offset + buf->size;
-	cbuf->size = (uint32_t)buf->capacity - buf->offset - buf->size;
-}
-
-static size_t ethosu_queue_available(struct ethosu_core_queue *queue)
-{
-	size_t size = queue->header.write - queue->header.read;
-
-	if (queue->header.read > queue->header.write)
-		size += queue->header.size;
-
-	return size;
-}
-
-static size_t ethosu_queue_capacity(struct ethosu_core_queue *queue)
-{
-	return queue->header.size - ethosu_queue_available(queue);
-}
-
-static int ethosu_queue_write(struct ethosu_mailbox *mbox,
-			      const struct kvec *vec,
-			      size_t length)
-{
-	struct ethosu_core_queue *queue = mbox->in_queue;
-	uint8_t *dst = &queue->data[0];
-	uint32_t wpos = queue->header.write;
-	size_t total_size;
-	size_t i;
-	int ret;
-
-	for (i = 0, total_size = 0; i < length; i++)
-		total_size += vec[i].iov_len;
-
-	if (total_size > ethosu_queue_capacity(queue))
-		return -EINVAL;
-
-	for (i = 0; i < length; i++) {
-		const uint8_t *src = vec[i].iov_base;
-		const uint8_t *end = src + vec[i].iov_len;
-
-		while (src < end) {
-			dst[wpos] = *src++;
-			wpos = (wpos + 1) % queue->header.size;
-		}
-	}
-
-	queue->header.write = wpos;
-
-	ret = mbox_send_message(mbox->tx, queue);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int ethosu_queue_write_msg(struct ethosu_mailbox *mbox,
-				  uint32_t type,
-				  void *data,
-				  size_t length)
-{
-	struct ethosu_core_msg msg = {
-		.magic = ETHOSU_CORE_MSG_MAGIC,
-		.type  = type,                 .length= length
-	};
-	const struct kvec vec[2] = {
-		{ &msg, sizeof(msg) },
-		{ data, length      }
-	};
-
-	return ethosu_queue_write(mbox, vec, 2);
-}
-
-static int ethosu_queue_read(struct ethosu_mailbox *mbox,
-			     void *data,
-			     size_t length)
-{
-	struct ethosu_core_queue *queue = mbox->out_queue;
-	uint8_t *src = &queue->data[0];
-	uint8_t *dst = (uint8_t *)data;
-	const uint8_t *end = dst + length;
-	uint32_t rpos = queue->header.read;
-	size_t queue_avail = ethosu_queue_available(queue);
-
-	if (length == 0)
-		return 0;
-	else if (queue_avail == 0)
-		return -ENOMSG;
-	else if (length > queue_avail)
-		return -EBADMSG;
-
-	while (dst < end) {
-		*dst++ = src[rpos];
-		rpos = (rpos + 1) % queue->header.size;
-	}
-
-	queue->header.read = rpos;
-
-	return 0;
-}
-
-void ethosu_mailbox_reset(struct ethosu_mailbox *mbox)
-{
-	mbox->out_queue->header.read = mbox->out_queue->header.write;
-}
-
-int ethosu_mailbox_read(struct ethosu_mailbox *mbox,
-			struct ethosu_core_msg *header,
-			void *data,
-			size_t length)
-{
-	int ret;
-
-	/* Read message header magic */
-	ret = ethosu_queue_read(mbox, header, sizeof(*header));
-	if (ret) {
-		if (ret != -ENOMSG)
-			dev_warn(mbox->dev,
-				 "Msg: Failed to read message header\n");
-
-		return ret;
-	}
-
-	if (header->magic != ETHOSU_CORE_MSG_MAGIC) {
-		dev_warn(mbox->dev,
-			 "Msg: Invalid magic. Got: %08X but expected %08X\n",
-			 header->magic, ETHOSU_CORE_MSG_MAGIC);
-
-		return -EINVAL;
-	}
-
-	dev_info(mbox->dev,
-		 "mbox: Read msg header. magic=%08X, type=%u, length=%u",
-		 header->magic, header->type, header->length);
-
-	/* Check that payload is not larger than allocated buffer */
-	if (header->length > length) {
-		dev_warn(mbox->dev,
-			 "Msg: Buffer size (%zu) too small for message (%u)\n",
-			 sizeof(data), header->length);
-
-		return -ENOMEM;
-	}
-
-	/* Read payload data */
-	ret = ethosu_queue_read(mbox, data, header->length);
-	if (ret) {
-		dev_warn(mbox->dev, "Msg: Failed to read payload data\n");
-
-		return -EBADMSG;
-	}
-
-	return 0;
-}
-
-int ethosu_mailbox_ping(struct ethosu_mailbox *mbox)
-{
-	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_PING, NULL, 0);
-}
-
-int ethosu_mailbox_pong(struct ethosu_mailbox *mbox)
-{
-	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_PONG, NULL, 0);
-}
-
-int ethosu_mailbox_version_request(struct ethosu_mailbox *mbox)
-{
-	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_VERSION_REQ, NULL,
-				      0);
-}
-
-int ethosu_mailbox_capabilities_request(struct ethosu_mailbox *mbox,
-					void *user_arg)
-{
-	struct ethosu_core_capabilities_req req = {
-		.user_arg = (ptrdiff_t)user_arg
-	};
-
-	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_CAPABILITIES_REQ,
-				      &req,
-				      sizeof(req));
-}
-
-int ethosu_mailbox_inference(struct ethosu_mailbox *mbox,
-			     void *user_arg,
-			     uint32_t ifm_count,
-			     struct ethosu_buffer **ifm,
-			     uint32_t ofm_count,
-			     struct ethosu_buffer **ofm,
-			     struct ethosu_buffer *network,
-			     uint8_t *pmu_event_config,
-			     uint8_t pmu_event_config_count,
-			     uint8_t pmu_cycle_counter_enable)
-{
-	struct ethosu_core_inference_req inf;
-	uint32_t i;
-
-	/* Verify that the uapi and core has the same number of pmus */
-	if (pmu_event_config_count != ETHOSU_CORE_PMU_MAX) {
-		dev_err(mbox->dev, "PMU count misconfigured.\n");
-
-		return -EINVAL;
-	}
-
-	inf.user_arg = (ptrdiff_t)user_arg;
-	inf.ifm_count = ifm_count;
-	inf.ofm_count = ofm_count;
-	inf.pmu_cycle_counter_enable = pmu_cycle_counter_enable;
-
-	for (i = 0; i < ifm_count; i++)
-		ethosu_core_set_size(ifm[i], &inf.ifm[i]);
-
-	for (i = 0; i < ofm_count; i++)
-		ethosu_core_set_capacity(ofm[i], &inf.ofm[i]);
-
-	for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++)
-		inf.pmu_event_config[i] = pmu_event_config[i];
-
-	ethosu_core_set_size(network, &inf.network);
-
-	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_INFERENCE_REQ,
-				      &inf, sizeof(inf));
-}
-
-static void ethosu_mailbox_rx_work(struct work_struct *work)
-{
-	struct ethosu_mailbox *mbox = container_of(work, typeof(*mbox), work);
-
-	mbox->callback(mbox->user_arg);
-}
-
-static void ethosu_mailbox_rx_callback(struct mbox_client *client,
-				       void *message)
-{
-	struct ethosu_mailbox *mbox =
-		container_of(client, typeof(*mbox), client);
-
-	dev_info(mbox->dev, "mbox: Received message.\n");
-
-	queue_work(mbox->wq, &mbox->work);
-}
-
-static void ethosu_mailbox_tx_done(struct mbox_client *client,
-				   void *message,
-				   int r)
-{
-	if (r)
-		dev_warn(client->dev, "mbox: Failed sending message (%d)\n", r);
-	else
-		dev_info(client->dev, "mbox: Message sent\n");
-}
-
-int ethosu_mailbox_init(struct ethosu_mailbox *mbox,
-			struct device *dev,
-			struct resource *in_queue,
-			struct resource *out_queue,
-			ethosu_mailbox_cb callback,
-			void *user_arg)
-{
-	int ret;
-
-	mbox->dev = dev;
-	mbox->callback = callback;
-	mbox->user_arg = user_arg;
-
-	mbox->client.dev = dev;
-	mbox->client.rx_callback = ethosu_mailbox_rx_callback;
-	mbox->client.tx_prepare = NULL; /* preparation of data is handled
-	                                 * through the
-	                                 * queue functions */
-	mbox->client.tx_done = ethosu_mailbox_tx_done;
-	mbox->client.tx_block = true;
-	mbox->client.knows_txdone = false;
-	mbox->client.tx_tout = 500;
-
-	mbox->in_queue = devm_ioremap_resource(mbox->dev, in_queue);
-	if (IS_ERR(mbox->in_queue))
-		return PTR_ERR(mbox->in_queue);
-
-	mbox->out_queue = devm_ioremap_resource(mbox->dev, out_queue);
-	if (IS_ERR(mbox->out_queue)) {
-		ret = PTR_ERR(mbox->out_queue);
-		goto unmap_in_queue;
-	}
-
-	mbox->wq = create_singlethread_workqueue("ethosu_workqueue");
-	if (!mbox->wq) {
-		dev_err(mbox->dev, "Failed to create work queue\n");
-		ret = -EINVAL;
-		goto unmap_out_queue;
-	}
-
-	INIT_WORK(&mbox->work, ethosu_mailbox_rx_work);
-
-	mbox->tx = mbox_request_channel_byname(&mbox->client, "tx");
-	if (IS_ERR(mbox->tx)) {
-		dev_warn(mbox->dev, "mbox: Failed to request tx channel\n");
-		ret = PTR_ERR(mbox->tx);
-		goto workqueue_destroy;
-	}
-
-	mbox->rx = mbox_request_channel_byname(&mbox->client, "rx");
-	if (IS_ERR(mbox->rx)) {
-		dev_info(dev, "mbox: Using same channel for RX and TX\n");
-		mbox->rx = mbox->tx;
-	}
-
-	return 0;
-
-workqueue_destroy:
-	destroy_workqueue(mbox->wq);
-
-unmap_out_queue:
-	devm_iounmap(mbox->dev, mbox->out_queue);
-
-unmap_in_queue:
-	devm_iounmap(mbox->dev, mbox->in_queue);
-
-	return ret;
-}
-
-void ethosu_mailbox_deinit(struct ethosu_mailbox *mbox)
-{
-	if (mbox->rx != mbox->tx)
-		mbox_free_channel(mbox->rx);
-
-	mbox_free_channel(mbox->tx);
-	destroy_workqueue(mbox->wq);
-	devm_iounmap(mbox->dev, mbox->out_queue);
-	devm_iounmap(mbox->dev, mbox->in_queue);
-}
diff --git a/drivers/firmware/ethosu/ethosu_mailbox.h b/drivers/firmware/ethosu/ethosu_mailbox.h
deleted file mode 100644
index 5cd5e62198b8..000000000000
--- a/drivers/firmware/ethosu/ethosu_mailbox.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
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
- */
-
-#ifndef ETHOSU_MAILBOX_H
-#define ETHOSU_MAILBOX_H
-
-/****************************************************************************
- * Includes
- ****************************************************************************/
-#include "ethosu_core_interface.h"
-
-#include <linux/types.h>
-#include <linux/mailbox_client.h>
-#include <linux/workqueue.h>
-
-/****************************************************************************
- * Types
- ****************************************************************************/
-
-struct device;
-struct ethosu_buffer;
-struct ethosu_device;
-struct ethosu_core_msg;
-struct ethosu_core_queue;
-struct resource;
-
-typedef void (*ethosu_mailbox_cb)(void *user_arg);
-
-struct ethosu_mailbox {
-	struct device            *dev;
-	struct workqueue_struct  *wq;
-	struct work_struct       work;
-	struct ethosu_core_queue __iomem *in_queue;
-	struct ethosu_core_queue __iomem *out_queue;
-	struct mbox_client       client;
-	struct mbox_chan         *rx;
-	struct mbox_chan         *tx;
-	ethosu_mailbox_cb        callback;
-	void                     *user_arg;
-};
-
-/****************************************************************************
- * Functions
- ****************************************************************************/
-
-/**
- * ethosu_mailbox_init() - Initialize mailbox
- *
- * Return: 0 on success, else error code.
- */
-int ethosu_mailbox_init(struct ethosu_mailbox *mbox,
-			struct device *dev,
-			struct resource *in_queue,
-			struct resource *out_queue,
-			ethosu_mailbox_cb callback,
-			void *user_arg);
-
-/**
- * ethosu_mailbox_deinit() - Deinitialize mailbox
- */
-void ethosu_mailbox_deinit(struct ethosu_mailbox *mbox);
-
-/**
- * ethosu_mailbox_read() - Read message from mailbox
- *
- * Return: 0 message read, else error code.
- */
-int ethosu_mailbox_read(struct ethosu_mailbox *mbox,
-			struct ethosu_core_msg *header,
-			void *data,
-			size_t length);
-
-/**
- * ethosu_mailbox_reset() - Reset to end of queue
- */
-void ethosu_mailbox_reset(struct ethosu_mailbox *mbox);
-
-/**
- * ethosu_mailbox_ping() - Send ping message
- *
- * Return: 0 on success, else error code.
- */
-int ethosu_mailbox_ping(struct ethosu_mailbox *mbox);
-
-/**
- * ethosu_mailbox_pong() - Send pong response
- *
- * Return: 0 on success, else error code.
- */
-int ethosu_mailbox_pong(struct ethosu_mailbox *mbox);
-
-/**
- * ethosu_mailbox_version_response - Send version request
- *
- * Return: 0 on succes, else error code
- */
-int ethosu_mailbox_version_request(struct ethosu_mailbox *mbox);
-
-/**
- * ethosu_mailbox_capabilities_request() - Send capabilities request
- *
- * Return: 0 on success, else error code.
- */
-int ethosu_mailbox_capabilities_request(struct ethosu_mailbox *mbox,
-					void *user_arg);
-
-/**
- * ethosu_mailbox_inference() - Send inference
- *
- * Return: 0 on success, else error code.
- */
-int ethosu_mailbox_inference(struct ethosu_mailbox *mbox,
-			     void *user_arg,
-			     uint32_t ifm_count,
-			     struct ethosu_buffer **ifm,
-			     uint32_t ofm_count,
-			     struct ethosu_buffer **ofm,
-			     struct ethosu_buffer *network,
-			     uint8_t *pmu_event_config,
-			     uint8_t pmu_event_config_count,
-			     uint8_t pmu_cycle_counter_enable);
-
-#endif /* ETHOSU_MAILBOX_H */
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
new file mode 100644
index 000000000000..cb7e4556f635
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2022 NXP
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/resource.h>
+#include <linux/rpmsg.h>
+#include <linux/uio.h>
+#include <linux/virtio.h>
+
+#include "ethosu_buffer.h"
+#include "ethosu_core_interface.h"
+#include "ethosu_device.h"
+
+struct ethosu_rpmsg *grp;
+
+#define MSG "ethosu say hello!"
+
+static void ethosu_core_set_size(struct ethosu_buffer *buf,
+				 struct ethosu_core_buffer *cbuf)
+{
+	cbuf->ptr = (uint32_t)buf->dma_addr + buf->offset;
+	cbuf->size = (uint32_t)buf->size;
+}
+
+static void ethosu_core_set_capacity(struct ethosu_buffer *buf,
+				     struct ethosu_core_buffer *cbuf)
+{
+	cbuf->ptr = (uint32_t)buf->dma_addr + buf->offset + buf->size;
+	cbuf->size = (uint32_t)buf->capacity - buf->offset - buf->size;
+}
+
+static int ethosu_rpmsg_send(struct ethosu_rpmsg *erp, uint32_t type)
+{
+	struct ethosu_core_msg msg;
+	struct rpmsg_device *rpdev = erp->rpdev;
+	int ret;
+
+	msg.magic = ETHOSU_CORE_MSG_MAGIC;
+	msg.type = type;
+	msg.length = 0;
+
+	print_hex_dump(KERN_DEBUG, __func__, DUMP_PREFIX_NONE, 16, 1,
+			(void *)&msg, sizeof(msg),  true);
+
+	ret = rpmsg_send(rpdev->ept, (void *)&msg, sizeof(msg));
+	if (ret) {
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ethosu_rpmsg_ping(struct ethosu_rpmsg *erp)
+{
+	return ethosu_rpmsg_send(erp, ETHOSU_CORE_MSG_PING);
+}
+
+int ethosu_rpmsg_pong(struct ethosu_rpmsg *erp)
+{
+	return ethosu_rpmsg_send(erp, ETHOSU_CORE_MSG_PONG);
+}
+
+int ethosu_rpmsg_version_request(struct ethosu_rpmsg *erp)
+{
+	return ethosu_rpmsg_send(erp, ETHOSU_CORE_MSG_VERSION_REQ);
+}
+
+int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp, void *user_arg)
+{
+	struct ethosu_core_msg msg = {
+		.magic  = ETHOSU_CORE_MSG_MAGIC,
+		.type   = ETHOSU_CORE_MSG_CAPABILITIES_REQ,
+		.length = sizeof(struct ethosu_core_capabilities_req)
+	};
+	struct ethosu_core_capabilities_req req = {
+		.user_arg = (uint64_t)user_arg
+	};
+	struct rpmsg_device *rpdev = erp->rpdev;
+	uint8_t data[sizeof(struct ethosu_core_msg) +
+		sizeof(struct ethosu_core_capabilities_req)];
+	int ret;
+
+	memcpy(data, &msg, sizeof(struct ethosu_core_msg));
+	memcpy(data + sizeof(struct ethosu_core_msg), &req,
+	       sizeof(struct ethosu_core_capabilities_req));
+
+	ret = rpmsg_send(rpdev->ept, (void *)&data,
+			 sizeof(struct ethosu_core_msg) +
+			 sizeof(struct ethosu_core_capabilities_req));
+	if (ret) {
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
+			   void *user_arg,
+			   uint32_t ifm_count,
+			   struct ethosu_buffer **ifm,
+			   uint32_t ofm_count,
+			   struct ethosu_buffer **ofm,
+			   struct ethosu_buffer *network,
+			   uint8_t *pmu_event_config,
+			   uint8_t pmu_event_config_count,
+			   uint8_t pmu_cycle_counter_enable)
+{
+	struct ethosu_core_msg msg = {
+		.magic  = ETHOSU_CORE_MSG_MAGIC,
+		.type   = ETHOSU_CORE_MSG_INFERENCE_REQ,
+		.length = sizeof(struct ethosu_core_inference_req)
+	};
+	struct ethosu_core_inference_req req;
+	struct rpmsg_device *rpdev = erp->rpdev;
+	uint8_t data[sizeof(struct ethosu_core_msg) +
+		sizeof(struct ethosu_core_inference_req)];
+	int ret;
+	uint32_t i;
+
+	/* Verify that the uapi and core has the same number of pmus */
+	if (pmu_event_config_count != ETHOSU_CORE_PMU_MAX) {
+		dev_err(&rpdev->dev, "PMU count misconfigured.\n");
+
+		return -EINVAL;
+	}
+
+	req.user_arg = (uint64_t)user_arg;
+	req.ifm_count = ifm_count;
+	req.ofm_count = ofm_count;
+	req.pmu_cycle_counter_enable = pmu_cycle_counter_enable;
+
+	for (i = 0; i < ifm_count; i++)
+		ethosu_core_set_size(ifm[i], &req.ifm[i]);
+
+	for (i = 0; i < ofm_count; i++)
+		ethosu_core_set_capacity(ofm[i], &req.ofm[i]);
+
+	for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++)
+		req.pmu_event_config[i] = pmu_event_config[i];
+
+	ethosu_core_set_size(network, &req.network);
+
+	memcpy(data, &msg, sizeof(struct ethosu_core_msg));
+	memcpy(data + sizeof(struct ethosu_core_msg), &req,
+	       sizeof(struct ethosu_core_inference_req));
+
+	ret = rpmsg_send(rpdev->ept, (void *)&data,
+			 sizeof(struct ethosu_core_msg) +
+			 sizeof(struct ethosu_core_inference_req));
+	if (ret) {
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rpmsg_ethosu_cb(struct rpmsg_device *rpdev,
+		void *data, int len, void *priv, u32 src)
+{
+	struct ethosu_rpmsg *rpmsg = dev_get_drvdata(&rpdev->dev);
+
+	if (len == 0)
+		return 0;
+
+	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
+
+	print_hex_dump(KERN_DEBUG, __func__, DUMP_PREFIX_NONE, 16, 1,
+			data, len,  true);
+
+	rpmsg->callback(rpmsg->user_arg, data);
+
+	return 0;
+}
+
+static int ethosu_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	int ret;
+
+	grp->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, grp);
+
+	dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
+		 rpdev->src, rpdev->dst);
+
+	ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
+	if (ret) {
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+	}
+
+	return 0;
+}
+
+static void ethosu_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	dev_info(&rpdev->dev, "rpmsg ethosu driver is removed\n");
+}
+
+static struct rpmsg_device_id rpmsg_driver_ethosu_id_table[] = {
+	{ .name = "rpmsg-ethosu-channel" },
+	{ },
+};
+
+static struct rpmsg_driver ethosu_rpmsg_driver = {
+	.drv.name       = KBUILD_MODNAME,
+	.drv.owner      = THIS_MODULE,
+	.id_table       = rpmsg_driver_ethosu_id_table,
+	.probe          = ethosu_rpmsg_probe,
+	.callback	= rpmsg_ethosu_cb,
+	.remove         = ethosu_rpmsg_remove,
+};
+
+int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
+		ethosu_rpmsg_cb callback, void *user_arg)
+{
+	grp = erp;
+	erp->callback = callback;
+	erp->user_arg = user_arg;
+
+	return register_rpmsg_driver(&ethosu_rpmsg_driver);
+}
+
+int ethosu_rpmsg_deinit(struct ethosu_rpmsg *erp)
+{
+	erp->callback = NULL;
+	erp->user_arg = NULL;
+	erp->rpdev = NULL;
+
+	unregister_rpmsg_driver(&ethosu_rpmsg_driver);
+	return 0;
+}
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.h b/drivers/firmware/ethosu/ethosu_rpmsg.h
new file mode 100644
index 000000000000..dd08e0d7945b
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2022 NXP
+ */
+
+#ifndef ETHOSU_RPMSG_H
+#define ETHOSU_RPMSG_H
+
+#include <linux/types.h>
+
+struct device;
+struct ethosu_buffer;
+struct ethosu_device;
+struct ethosu_core_msg;
+
+typedef void (*ethosu_rpmsg_cb)(void *user_arg, void *data);
+
+struct ethosu_rpmsg {
+	struct rpmsg_device	*rpdev;
+	ethosu_rpmsg_cb		callback;
+	void			*user_arg;
+};
+/**
+ * ethosu_rpmsg_ping() - Send ping message
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_rpmsg_ping(struct ethosu_rpmsg *erp);
+
+/**
+ * ethosu_rpmsg_pong() - Send pong message
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_rpmsg_pong(struct ethosu_rpmsg *erp);
+
+/**
+ * ethosu_rpmsg_version_response - Send version request
+ *
+ * Return: 0 on success, else error code
+ */
+int ethosu_rpmsg_version_request(struct ethosu_rpmsg *erp);
+
+/**
+ * ethosu_rpmsg_capabilities_request - Send capabilities request
+ *
+ * Return: 0 on success, else error code
+ */
+int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp,
+				      void *user_arg);
+
+/**
+ * ethosu_rpmsg_inference() - Send inference
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
+			   void *user_arg,
+			   uint32_t ifm_count,
+			   struct ethosu_buffer **ifm,
+			   uint32_t ofm_count,
+			   struct ethosu_buffer **ofm,
+			   struct ethosu_buffer *network,
+			   uint8_t *pmu_event_config,
+			   uint8_t pmu_event_config_count,
+			   uint8_t pmu_cycle_counter_enable
+			   );
+
+int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
+		      ethosu_rpmsg_cb callback, void *user_arg);
+
+int ethosu_rpmsg_deinit(struct ethosu_rpmsg *erp);
+#endif /* ETHOSU_RPMSG_H */
-- 
2.17.1

