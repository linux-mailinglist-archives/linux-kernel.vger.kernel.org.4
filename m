Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7108654627
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiLVSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiLVSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AE5D23BCA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC372F4;
        Thu, 22 Dec 2022 10:51:59 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE6F63FA32;
        Thu, 22 Dec 2022 10:51:16 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 8/9] firmware: arm_scmi: Introduce a new lifecycle for protocol devices
Date:   Thu, 22 Dec 2022 18:50:48 +0000
Message-Id: <20221222185049.737625-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222185049.737625-1-cristian.marussi@arm.com>
References: <20221222185049.737625-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protocol devices are created or destroyed depending on the related device
request/unrequest events emitted on the scmi_requested_devices_nh
notification chain by the SCMI bus and served in the driver by the
scmi_device_request_notifier.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 83a43a5f7bb4..115baaa4aca9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -14,6 +14,8 @@
  * Copyright (C) 2018-2021 ARM Ltd.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -140,6 +142,7 @@ struct scmi_protocol_instance {
  * @bus_nb: A notifier to listen for device bind/unbind on the scmi bus
  * @dev_req_nb: A notifier to listen for device request/unrequest on the scmi
  *		bus
+ * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  */
 struct scmi_info {
 	struct device *dev;
@@ -161,6 +164,8 @@ struct scmi_info {
 	int users;
 	struct notifier_block bus_nb;
 	struct notifier_block dev_req_nb;
+	/* Serialize device creation process for this instance */
+	struct mutex devreq_mtx;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -255,6 +260,40 @@ void scmi_protocol_unregister(const struct scmi_protocol *proto)
 }
 EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
 
+/**
+ * scmi_create_protocol_devices  - Create devices for all pending requests for
+ * this SCMI instance.
+ *
+ * @np: The device node describing the protocol
+ * @info: The SCMI instance descriptor
+ * @prot_id: The protocol ID
+ * @name: The optional name of the device to be created: if not provided this
+ *	  call will lead to the creation of all the devices currently requested
+ *	  for the specified protocol.
+ */
+static void scmi_create_protocol_devices(struct device_node *np,
+					 struct scmi_info *info,
+					 int prot_id, const char *name)
+{
+	struct scmi_device *sdev;
+
+	mutex_lock(&info->devreq_mtx);
+	sdev = scmi_device_create(np, info->dev, prot_id, name);
+	if (name && !sdev)
+		dev_err(info->dev,
+			"failed to create device for protocol 0x%X (%s)\n",
+			prot_id, name);
+	mutex_unlock(&info->devreq_mtx);
+}
+
+static void scmi_destroy_protocol_devices(struct scmi_info *info,
+					  int prot_id, const char *name)
+{
+	mutex_lock(&info->devreq_mtx);
+	scmi_device_destroy(info->dev, prot_id, name);
+	mutex_unlock(&info->devreq_mtx);
+}
+
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv)
 {
@@ -2283,8 +2322,12 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case SCMI_BUS_NOTIFY_DEVICE_REQUEST:
+		scmi_create_protocol_devices(np, info, id_table->protocol_id,
+					     id_table->name);
 		break;
 	case SCMI_BUS_NOTIFY_DEVICE_UNREQUEST:
+		scmi_destroy_protocol_devices(info, id_table->protocol_id,
+					      id_table->name);
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -2318,6 +2361,7 @@ static int scmi_probe(struct platform_device *pdev)
 	idr_init(&info->protocols);
 	mutex_init(&info->protocols_mtx);
 	idr_init(&info->active_protocols);
+	mutex_init(&info->devreq_mtx);
 
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
@@ -2412,6 +2456,7 @@ static int scmi_probe(struct platform_device *pdev)
 		}
 
 		of_node_get(child);
+		scmi_create_protocol_devices(child, info, prot_id, NULL);
 	}
 
 	return 0;
-- 
2.34.1

