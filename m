Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584D8659050
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiL2SY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiL2SYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6734713E9A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94BAA1692;
        Thu, 29 Dec 2022 10:24:46 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269C53F71A;
        Thu, 29 Dec 2022 10:24:03 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 07/17] firmware: arm_scmi: Add internal platform/channel IDs
Date:   Thu, 29 Dec 2022 18:22:43 +0000
Message-Id: <20221229182253.948175-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229182253.948175-1-cristian.marussi@arm.com>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of unique identifiers to channel and platform instance
descriptors in order to emit more descriptive message dump traces.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  3 +++
 drivers/firmware/arm_scmi/driver.c | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 049607280ea5..bf3883f169e3 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -157,6 +157,8 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
 /**
  * struct scmi_chan_info - Structure representing a SCMI channel information
  *
+ * @id: An identifier for this channel: this matches the protocol number
+ *      used to initialize this channel
  * @dev: Reference to device in the SCMI hierarchy corresponding to this
  *	 channel
  * @rx_timeout_ms: The configured RX timeout in milliseconds.
@@ -168,6 +170,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
  * @transport_info: Transport layer related information
  */
 struct scmi_chan_info {
+	int id;
 	struct device *dev;
 	unsigned int rx_timeout_ms;
 	struct scmi_handle *handle;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fefa01dbf9ee..af34324e923b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -39,6 +39,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
+static DEFINE_IDA(scmi_id);
+
 static DEFINE_IDR(scmi_protocols);
 static DEFINE_SPINLOCK(protocol_lock);
 
@@ -98,6 +100,7 @@ struct scmi_protocol_instance {
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
+ * @id: A sequence number starting from zero identifying this instance
  * @dev: Device pointer
  * @desc: SoC description for this instance
  * @version: SCMI revision information containing protocol version,
@@ -131,6 +134,7 @@ struct scmi_protocol_instance {
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  */
 struct scmi_info {
+	int id;
 	struct device *dev;
 	const struct scmi_desc *desc;
 	struct scmi_revision_info version;
@@ -2270,6 +2274,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	}
 	of_node_get(of_node);
 
+	cinfo->id = prot_id;
 	cinfo->dev = &tdev->dev;
 	ret = info->desc->ops->chan_setup(cinfo, info->dev, tx);
 	if (ret) {
@@ -2486,6 +2491,10 @@ static int scmi_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	info->id = ida_alloc_min(&scmi_id, 0, GFP_KERNEL);
+	if (info->id < 0)
+		return info->id;
+
 	info->dev = dev;
 	info->desc = desc;
 	info->bus_nb.notifier_call = scmi_bus_notifier;
@@ -2518,13 +2527,13 @@ static int scmi_probe(struct platform_device *pdev)
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
 		if (ret)
-			return ret;
+			goto clear_ida;
 	}
 
 	/* Setup all channels described in the DT at first */
 	ret = scmi_channels_setup(info);
 	if (ret)
-		return ret;
+		goto clear_ida;
 
 	ret = bus_register_notifier(&scmi_bus_type, &info->bus_nb);
 	if (ret)
@@ -2604,6 +2613,8 @@ static int scmi_probe(struct platform_device *pdev)
 	bus_unregister_notifier(&scmi_bus_type, &info->bus_nb);
 clear_txrx_setup:
 	scmi_cleanup_txrx_channels(info);
+clear_ida:
+	ida_free(&scmi_id, info->id);
 	return ret;
 }
 
@@ -2637,6 +2648,8 @@ static int scmi_remove(struct platform_device *pdev)
 	/* Safe to free channels since no more users */
 	scmi_cleanup_txrx_channels(info);
 
+	ida_free(&scmi_id, info->id);
+
 	return 0;
 }
 
-- 
2.34.1

