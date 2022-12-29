Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F065904D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiL2SYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiL2SXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:23:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F0B13EB0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:23:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 685901042;
        Thu, 29 Dec 2022 10:24:35 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037723F71A;
        Thu, 29 Dec 2022 10:23:51 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 02/17] firmware: arm_scmi: Refactor polling helpers
Date:   Thu, 29 Dec 2022 18:22:38 +0000
Message-Id: <20221229182253.948175-3-cristian.marussi@arm.com>
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

Refactor polling helpers to receive scmi_desc directly as a parameter and
move all of them to common.h.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 18 ++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 34 ++++++++----------------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 80f63fc8ca14..f785f0ff2090 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -211,6 +211,24 @@ struct scmi_desc {
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
index 3400bd124a38..d7f21e81bd11 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -748,25 +748,6 @@ static inline void scmi_clear_channel(struct scmi_info *info,
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
@@ -1009,7 +990,8 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct scmi_chan_info *cinfo;
 
 	/* Check for polling request on custom command xfers at first */
-	if (xfer->hdr.poll_completion && !is_transport_polling_capable(info)) {
+	if (xfer->hdr.poll_completion &&
+	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
 		return -EINVAL;
@@ -1020,7 +1002,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	/* True ONLY if also supported by transport. */
-	if (is_polling_enabled(cinfo, info))
+	if (is_polling_enabled(cinfo, info->desc))
 		xfer->hdr.poll_completion = true;
 
 	/*
@@ -1956,7 +1938,8 @@ static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
 	bool ret;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	ret = info->desc->atomic_enabled && is_transport_polling_capable(info);
+	ret = info->desc->atomic_enabled &&
+		is_transport_polling_capable(info->desc);
 	if (ret && atomic_threshold)
 		*atomic_threshold = info->atomic_threshold;
 
@@ -2180,8 +2163,8 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 		return ret;
 	}
 
-	if (tx && is_polling_required(cinfo, info)) {
-		if (is_transport_polling_capable(info))
+	if (tx && is_polling_required(cinfo, info->desc)) {
+		if (is_transport_polling_capable(info->desc))
 			dev_info(&tdev->dev,
 				 "Enabled polling mode TX channel - prot_id:%d\n",
 				 prot_id);
@@ -2443,7 +2426,8 @@ static int scmi_probe(struct platform_device *pdev)
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
-	if (info->desc->atomic_enabled && !is_transport_polling_capable(info))
+	if (info->desc->atomic_enabled &&
+	    !is_transport_polling_capable(info->desc))
 		dev_err(dev,
 			"Transport is not polling capable. Atomic mode not supported.\n");
 
-- 
2.34.1

