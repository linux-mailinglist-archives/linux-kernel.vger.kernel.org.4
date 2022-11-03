Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5116188FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKCTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiKCTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B1E11E3D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:52:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB13111FB;
        Thu,  3 Nov 2022 12:53:00 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68EF13F534;
        Thu,  3 Nov 2022 12:52:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 02/14] firmware: arm_scmi: Simplify chan_available transport operation
Date:   Thu,  3 Nov 2022 19:52:13 +0000
Message-Id: <20221103195225.1028864-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103195225.1028864-1-cristian.marussi@arm.com>
References: <20221103195225.1028864-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI transport operation .chan_available determines in a transport-specific
way if an SCMI channel is still available and to be configured: such
information is derived analyzing bits of DT in a transport specific way;
all it needs is a DT node to operate upon, not necessarily a full blown
device.

Simplify the helper to receive in input a reference to a device_node
instead of a device carrying a pointer to such device_node.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fixes in commmit message
---
 drivers/firmware/arm_scmi/common.h  | 2 +-
 drivers/firmware/arm_scmi/driver.c  | 2 +-
 drivers/firmware/arm_scmi/mailbox.c | 4 ++--
 drivers/firmware/arm_scmi/optee.c   | 4 ++--
 drivers/firmware/arm_scmi/smc.c     | 4 ++--
 drivers/firmware/arm_scmi/virtio.c  | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index a1c0154c31c6..16db1e177123 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -153,7 +153,7 @@ struct scmi_chan_info {
  */
 struct scmi_transport_ops {
 	int (*link_supplier)(struct device *dev);
-	bool (*chan_available)(struct device *dev, int idx);
+	bool (*chan_available)(struct device_node *of_node, int idx);
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c16fd3a4d8ca..474fec4c0b3a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2035,7 +2035,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	if (cinfo)
 		return 0;
 
-	if (!info->desc->ops->chan_available(dev, idx)) {
+	if (!info->desc->ops->chan_available(dev->of_node, idx)) {
 		cinfo = idr_find(idr, SCMI_PROTOCOL_BASE);
 		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
 			return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 1e40cb035044..c33dcadafea8 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -46,9 +46,9 @@ static void rx_callback(struct mbox_client *cl, void *m)
 	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
 }
 
-static bool mailbox_chan_available(struct device *dev, int idx)
+static bool mailbox_chan_available(struct device_node *of_node, int idx)
 {
-	return !of_parse_phandle_with_args(dev->of_node, "mboxes",
+	return !of_parse_phandle_with_args(of_node, "mboxes",
 					   "#mbox-cells", idx, NULL);
 }
 
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 2a7aeab40e54..5a11091c72da 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -328,11 +328,11 @@ static int scmi_optee_link_supplier(struct device *dev)
 	return 0;
 }
 
-static bool scmi_optee_chan_available(struct device *dev, int idx)
+static bool scmi_optee_chan_available(struct device_node *of_node, int idx)
 {
 	u32 channel_id;
 
-	return !of_property_read_u32_index(dev->of_node, "linaro,optee-channel-id",
+	return !of_property_read_u32_index(of_node, "linaro,optee-channel-id",
 					   idx, &channel_id);
 }
 
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 87a7b13cf868..122128d56d2f 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -52,9 +52,9 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static bool smc_chan_available(struct device *dev, int idx)
+static bool smc_chan_available(struct device_node *of_node, int idx)
 {
-	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
+	struct device_node *np = of_parse_phandle(of_node, "shmem", 0);
 	if (!np)
 		return false;
 
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 33c9b81a55cd..46c5ea3c8f54 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -386,7 +386,7 @@ static int virtio_link_supplier(struct device *dev)
 	return 0;
 }
 
-static bool virtio_chan_available(struct device *dev, int idx)
+static bool virtio_chan_available(struct device_node *of_node, int idx)
 {
 	struct scmi_vio_channel *channels, *vioch = NULL;
 
-- 
2.34.1

