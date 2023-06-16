Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6B7326DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbjFPFxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjFPFxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:08 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807162D5A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EE931A033D;
        Fri, 16 Jun 2023 07:43:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D9F61A05B8;
        Fri, 16 Jun 2023 07:43:05 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 094A61820F58;
        Fri, 16 Jun 2023 13:43:03 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 4/8] ethosu: Add suspend/resume power management
Date:   Fri, 16 Jun 2023 13:59:09 +0800
Message-Id: <20230616055913.2360-5-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend and resume power management support. The
corresponding message will be sent to Cortex-M core via RPMsg protocol.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Feng Guo <feng.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/ethosu/ethosu_buffer.c       |  3 ++
 .../firmware/ethosu/ethosu_core_interface.h   | 14 ++++++++
 drivers/firmware/ethosu/ethosu_device.c       | 36 +++++++++++++++++++
 drivers/firmware/ethosu/ethosu_device.h       | 10 ++++++
 drivers/firmware/ethosu/ethosu_driver.c       | 29 +++++++++++++++
 drivers/firmware/ethosu/ethosu_rpmsg.c        | 30 ++++++++++++++++
 drivers/firmware/ethosu/ethosu_rpmsg.h        | 11 ++++++
 7 files changed, 133 insertions(+)

diff --git a/drivers/firmware/ethosu/ethosu_buffer.c b/drivers/firmware/ethosu/ethosu_buffer.c
index 43a433355f30..c8aa8031a8de 100644
--- a/drivers/firmware/ethosu/ethosu_buffer.c
+++ b/drivers/firmware/ethosu/ethosu_buffer.c
@@ -222,6 +222,9 @@ int ethosu_buffer_create(struct ethosu_device *edev,
 	struct ethosu_buffer *buf;
 	int ret = -ENOMEM;
 
+	if (!capacity)
+		return -EINVAL;
+
 	buf = devm_kzalloc(edev->dev, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/drivers/firmware/ethosu/ethosu_core_interface.h b/drivers/firmware/ethosu/ethosu_core_interface.h
index b60508e4792f..9267e96aec9b 100644
--- a/drivers/firmware/ethosu/ethosu_core_interface.h
+++ b/drivers/firmware/ethosu/ethosu_core_interface.h
@@ -60,6 +60,8 @@ enum ethosu_core_msg_type {
 	ETHOSU_CORE_MSG_VERSION_RSP,
 	ETHOSU_CORE_MSG_CAPABILITIES_REQ,
 	ETHOSU_CORE_MSG_CAPABILITIES_RSP,
+	ETHOSU_CORE_MSG_POWER_REQ,
+	ETHOSU_CORE_MSG_POWER_RSP,
 	ETHOSU_CORE_MSG_MAX
 };
 
@@ -161,6 +163,18 @@ struct ethosu_core_msg_capabilities_rsp {
 	uint32_t custom_dma;
 };
 
+enum ethosu_core_power_req_type {
+	ETHOSU_CORE_POWER_REQ_SUSPEND = 0,
+	ETHOSU_CORE_POWER_REQ_RESUME
+};
+
+/**
+ * struct ethosu_core_power_req - Message power request
+ */
+struct ethosu_core_power_req {
+	enum ethosu_core_power_req_type type;
+};
+
 /**
  * enum ethosu_core_msg_err_type - Error types
  */
diff --git a/drivers/firmware/ethosu/ethosu_device.c b/drivers/firmware/ethosu/ethosu_device.c
index b2d4737080ac..1627f25c8a95 100644
--- a/drivers/firmware/ethosu/ethosu_device.c
+++ b/drivers/firmware/ethosu/ethosu_device.c
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/remoteproc.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
@@ -49,6 +50,8 @@
 
 #define CAPABILITIES_RESP_TIMEOUT_MS 2000
 
+#define ETHOSU_FIRMWARE_NAME "ethosu_firmware"
+
 /****************************************************************************
  * Types
  ****************************************************************************/
@@ -161,6 +164,9 @@ static int ethosu_handle_msg(struct ethosu_device *edev, void *data)
 	case ETHOSU_CORE_MSG_PONG:
 		dev_info(edev->dev, "Msg: Pong\n");
 		break;
+	case ETHOSU_CORE_MSG_POWER_RSP:
+		dev_info(edev->dev, "Msg: Power response\n");
+		break;
 	case ETHOSU_CORE_MSG_INFERENCE_RSP:
 		if (header->length != sizeof(struct ethosu_core_inference_rsp)) {
 			dev_warn(edev->dev,
@@ -243,11 +249,41 @@ static int ethosu_open(struct inode *inode,
 {
 	struct ethosu_device *edev =
 		container_of(inode->i_cdev, struct ethosu_device, cdev);
+	phandle rproc_phandle;
+	struct rproc *rproc;
+	int ret = 0;
 
 	file->private_data = edev;
 
 	dev_info(edev->dev, "Opening device node.\n");
 
+	if (of_property_read_u32(edev->dev->of_node, "fsl,cm33-proc",
+				 &rproc_phandle)) {
+		dev_err(edev->dev, "could not get rproc phandle\n");
+		return -ENODEV;
+	}
+
+	rproc = rproc_get_by_phandle(rproc_phandle);
+	if (!rproc) {
+		dev_err(edev->dev, "could not get rproc handle\n");
+		return -EINVAL;
+	}
+
+	ret = rproc_set_firmware(rproc, ETHOSU_FIRMWARE_NAME);
+
+	if (!ret && atomic_read(&rproc->power) == 0) {
+		init_completion(&edev->erp.rpmsg_ready);
+		ret = rproc_boot(rproc);
+		if (ret)
+			dev_err(edev->dev, "could not boot a remote processor\n");
+		else
+			wait_for_completion_interruptible(&edev->erp.rpmsg_ready);
+	} else {
+		dev_err(edev->dev, "can't change firmware or remote processor is running\n");
+	}
+
+	edev->open = true;
+
 	return nonseekable_open(inode, file);
 }
 
diff --git a/drivers/firmware/ethosu/ethosu_device.h b/drivers/firmware/ethosu/ethosu_device.h
index 3943c8df8f28..da470241b6a1 100644
--- a/drivers/firmware/ethosu/ethosu_device.h
+++ b/drivers/firmware/ethosu/ethosu_device.h
@@ -51,6 +51,7 @@ struct ethosu_device {
 	struct ethosu_rpmsg   erp;
 	struct list_head      capabilities_list;
 	struct list_head      inference_list;
+	bool                  open;
 };
 
 /**
@@ -83,4 +84,13 @@ int ethosu_dev_init(struct ethosu_device *edev,
  */
 void ethosu_dev_deinit(struct ethosu_device *edev);
 
+/**
+ * ethosu_suspend() - Suspend the device
+ */
+int ethosu_suspend(struct device *dev);
+/**
+ * ethosu_resume() - Resume the device
+ */
+int ethosu_resume(struct device *dev);
+
 #endif /* ETHOSU_DEVICE_H */
diff --git a/drivers/firmware/ethosu/ethosu_driver.c b/drivers/firmware/ethosu/ethosu_driver.c
index 27931e9aa97c..d3306ef625ae 100644
--- a/drivers/firmware/ethosu/ethosu_driver.c
+++ b/drivers/firmware/ethosu/ethosu_driver.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 
+#include "ethosu_core_interface.h"
 #include "ethosu_device.h"
 
 /****************************************************************************
@@ -101,6 +102,33 @@ static int ethosu_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+int ethosu_suspend(struct device *dev)
+{
+	struct ethosu_device *edev = dev->driver_data;
+	int ret = 0;
+
+	if (edev->open)
+		ret = ethosu_rpmsg_power_request(&edev->erp, ETHOSU_CORE_POWER_REQ_SUSPEND);
+
+	return ret;
+}
+
+int ethosu_resume(struct device *dev)
+{
+	struct ethosu_device *edev = dev->driver_data;
+	int ret = 0;
+
+	if (edev->open)
+		ret = ethosu_rpmsg_power_request(&edev->erp, ETHOSU_CORE_POWER_REQ_RESUME);
+
+	return ret;
+}
+
+struct dev_pm_ops ethosu_pm_ops = {
+	.suspend = ethosu_suspend,
+	.resume = ethosu_resume,
+};
+
 static const struct of_device_id ethosu_pdev_match[] = {
 	{ .compatible = "arm,ethosu" },
 	{ /* Sentinel */ },
@@ -115,6 +143,7 @@ static struct platform_driver ethosu_pdev_driver = {
 		.name           = ETHOSU_DRIVER_NAME,
 		.owner          = THIS_MODULE,
 		.of_match_table = of_match_ptr(ethosu_pdev_match),
+		.pm		= &ethosu_pm_ops,
 	},
 };
 
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
index e4cf398468e4..a0320b8407d1 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.c
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -98,6 +98,35 @@ int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp, void *user_arg)
 	return 0;
 }
 
+int ethosu_rpmsg_power_request(struct ethosu_rpmsg *erp,
+			       enum ethosu_core_power_req_type power_type)
+{
+	struct ethosu_core_msg msg = {
+		.magic  = ETHOSU_CORE_MSG_MAGIC,
+		.type   = ETHOSU_CORE_MSG_POWER_REQ,
+		.length = sizeof(struct ethosu_core_power_req)
+	};
+	struct ethosu_core_power_req req;
+	struct rpmsg_device *rpdev = erp->rpdev;
+	uint8_t data[sizeof(struct ethosu_core_msg) +
+		sizeof(struct ethosu_core_power_req)];
+	int ret;
+
+	req.type = power_type;
+	memcpy(data, &msg, sizeof(struct ethosu_core_msg));
+	memcpy(data + sizeof(struct ethosu_core_msg), &req,
+	       sizeof(struct ethosu_core_power_req));
+
+	ret = rpmsg_send(rpdev->ept, (void *)&data,
+			 sizeof(struct ethosu_core_msg) +
+			 sizeof(struct ethosu_core_power_req));
+	if (ret) {
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
 int ethosu_rpmsg_inference(struct ethosu_rpmsg *erp,
 			   void *user_arg,
 			   uint32_t ifm_count,
@@ -193,6 +222,7 @@ static int ethosu_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (ret) {
 		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
 	}
+	complete(&grp->rpmsg_ready);
 
 	return 0;
 }
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.h b/drivers/firmware/ethosu/ethosu_rpmsg.h
index a4a639997a26..cee3d96c7895 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.h
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -7,6 +7,8 @@
 #define ETHOSU_RPMSG_H
 
 #include <linux/types.h>
+#include <linux/completion.h>
+#include "ethosu_core_interface.h"
 
 struct device;
 struct ethosu_buffer;
@@ -19,6 +21,7 @@ struct ethosu_rpmsg {
 	struct rpmsg_device	*rpdev;
 	ethosu_rpmsg_cb		callback;
 	void			*user_arg;
+	struct completion       rpmsg_ready;
 };
 /**
  * ethosu_rpmsg_ping() - Send ping message
@@ -49,6 +52,14 @@ int ethosu_rpmsg_version_request(struct ethosu_rpmsg *erp);
 int ethosu_rpmsg_capabilities_request(struct ethosu_rpmsg *erp,
 				      void *user_arg);
 
+/**
+ * ethosu_rpmsg_power_request - Send power request
+ *
+ * Return: 0 on success, else error code
+ */
+int ethosu_rpmsg_power_request(struct ethosu_rpmsg *erp,
+			       enum ethosu_core_power_req_type power_type);
+
 /**
  * ethosu_rpmsg_inference() - Send inference
  *
-- 
2.17.1

