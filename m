Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11516605183
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiJSUrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiJSUqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:46:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 735C81BBEE1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:46:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542031A25;
        Wed, 19 Oct 2022 13:46:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285ED3F792;
        Wed, 19 Oct 2022 13:46:44 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 02/11] firmware: arm_scmi: Simplify chan_available transport operation
Date:   Wed, 19 Oct 2022 21:46:17 +0100
Message-Id: <20221019204626.3813043-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019204626.3813043-1-cristian.marussi@arm.com>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
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
index 61aba7447c32..096b66442d84 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -150,7 +150,7 @@ struct scmi_chan_info {
  */
 struct scmi_transport_ops {
 	int (*link_supplier)(struct device *dev);
-	bool (*chan_available)(struct device *dev, int idx);
+	bool (*chan_available)(struct device_node *of_node, int idx);
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e5193da2ce09..62e02b6475ff 100644
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
index 08ff4d110beb..ed7e66788134 100644
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
index f42dad997ac9..59e688767af2 100644
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
index 745acfdd0b3d..0e21bd01348b 100644
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
index 14709dbc96a1..e0c92037a9e6 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -392,7 +392,7 @@ static int virtio_link_supplier(struct device *dev)
 	return 0;
 }
 
-static bool virtio_chan_available(struct device *dev, int idx)
+static bool virtio_chan_available(struct device_node *of_node, int idx)
 {
 	struct scmi_vio_channel *channels, *vioch = NULL;
 
-- 
2.34.1

