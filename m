Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD9605185
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiJSUrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJSUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:46:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B63E81BE439
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:46:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF6A41D6F;
        Wed, 19 Oct 2022 13:46:56 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 848923F792;
        Wed, 19 Oct 2022 13:46:48 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 04/11] firmware: arm_scmi: Refactor polling helpers
Date:   Wed, 19 Oct 2022 21:46:19 +0100
Message-Id: <20221019204626.3813043-5-cristian.marussi@arm.com>
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

Refactor polling helpers to receive scmi_desc directly as a parameter and
move all of them to common.h.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 18 ++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 34 ++++++++----------------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 096b66442d84..30d056febef1 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -212,6 +212,24 @@ struct scmi_desc {
 	const bool atomic_enabled;
 };
 
+static inline bool is_polling_required(struct scmi_chan_info *cinfo,
+				       const struct scmi_desc *desc)
+{
+	return cinfo->no_completion_irq || desc->force_polling;
+}
+
+static inline bool is_transport_polling_capable(const struct scmi_desc *desc)
+{
+	return desc->ops->poll_done || desc->sync_cmds_completed_on_ret;
+}
+
+static inline bool is_polling_enabled(struct scmi_chan_info *cinfo,
+				      const struct scmi_desc *desc)
+{
+	return is_polling_required(cinfo, desc) &&
+		is_transport_polling_capable(desc);
+}
+
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 032d1140d631..9c77c931d91b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -648,25 +648,6 @@ static inline void scmi_clear_channel(struct scmi_info *info,
 		info->desc->ops->clear_channel(cinfo);
 }
 
-static inline bool is_polling_required(struct scmi_chan_info *cinfo,
-				       struct scmi_info *info)
-{
-	return cinfo->no_completion_irq || info->desc->force_polling;
-}
-
-static inline bool is_transport_polling_capable(struct scmi_info *info)
-{
-	return info->desc->ops->poll_done ||
-		info->desc->sync_cmds_completed_on_ret;
-}
-
-static inline bool is_polling_enabled(struct scmi_chan_info *cinfo,
-				      struct scmi_info *info)
-{
-	return is_polling_required(cinfo, info) &&
-		is_transport_polling_capable(info);
-}
-
 static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 				     u32 msg_hdr, void *priv)
 {
@@ -909,7 +890,8 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct scmi_chan_info *cinfo;
 
 	/* Check for polling request on custom command xfers at first */
-	if (xfer->hdr.poll_completion && !is_transport_polling_capable(info)) {
+	if (xfer->hdr.poll_completion &&
+	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
 		return -EINVAL;
@@ -920,7 +902,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	/* True ONLY if also supported by transport. */
-	if (is_polling_enabled(cinfo, info))
+	if (is_polling_enabled(cinfo, info->desc))
 		xfer->hdr.poll_completion = true;
 
 	/*
@@ -1854,7 +1836,8 @@ static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
 	bool ret;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	ret = info->desc->atomic_enabled && is_transport_polling_capable(info);
+	ret = info->desc->atomic_enabled &&
+		is_transport_polling_capable(info->desc);
 	if (ret && atomic_threshold)
 		*atomic_threshold = info->atomic_threshold;
 
@@ -2061,8 +2044,8 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 		return ret;
 	}
 
-	if (tx && is_polling_required(cinfo, info)) {
-		if (is_transport_polling_capable(info))
+	if (tx && is_polling_required(cinfo, info->desc)) {
+		if (is_transport_polling_capable(info->desc))
 			dev_info(&tdev->dev,
 				 "Enabled polling mode TX channel - prot_id:%d\n",
 				 prot_id);
@@ -2491,7 +2474,8 @@ static int scmi_probe(struct platform_device *pdev)
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
-	if (info->desc->atomic_enabled && !is_transport_polling_capable(info))
+	if (info->desc->atomic_enabled &&
+	    !is_transport_polling_capable(info->desc))
 		dev_err(dev,
 			"Transport is not polling capable. Atomic mode not supported.\n");
 
-- 
2.34.1

