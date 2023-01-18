Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B22671CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjARMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjARMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CD8C49543
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:15:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E14F16F8;
        Wed, 18 Jan 2023 04:16:18 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39DB3F71A;
        Wed, 18 Jan 2023 04:15:33 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v8 15/17] firmware: arm_scmi: Call Raw mode hooks from the core stack
Date:   Wed, 18 Jan 2023 12:14:24 +0000
Message-Id: <20230118121426.492864-16-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118121426.492864-1-cristian.marussi@arm.com>
References: <20230118121426.492864-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few call sites where, if SCMI Raw mode access had been enabled in
Kconfig, the needed SCMI Raw initialization and hooks are called.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v7 --> v8
- refactor RAw mode initialization
v5 --> v6
- fix error path for RAW mode in scmi_probe
- use new debugfs Raw rootdir
v4 --> v5
- rework to use multiple SCMI instances
v3 --> v4
- add call hooks to support polled transports
v1 --> v2
- fixes need to use multiple cinfo if available
---
 drivers/firmware/arm_scmi/driver.c | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2b96d9c3489d..ad4e53f0c342 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -37,6 +37,8 @@
 #include "common.h"
 #include "notify.h"
 
+#include "raw_mode.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
@@ -150,6 +152,7 @@ struct scmi_debug_info {
  *		bus
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  * @dbg: A pointer to debugfs related data (if any)
+ * @raw: An opaque reference handle used by SCMI Raw mode.
  */
 struct scmi_info {
 	int id;
@@ -175,6 +178,7 @@ struct scmi_info {
 	/* Serialize device creation process for this instance */
 	struct mutex devreq_mtx;
 	struct scmi_debug_info *dbg;
+	void *raw;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -890,6 +894,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   MSG_TYPE_NOTIFICATION);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		xfer->hdr.seq = MSG_XTRACT_TOKEN(msg_hdr);
+		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_NOTIF_QUEUE);
+	}
+
 	__scmi_xfer_put(minfo, xfer);
 
 	scmi_clear_channel(info, cinfo);
@@ -903,6 +912,9 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+			scmi_raw_error_report(info->raw, cinfo, msg_hdr, priv);
+
 		if (MSG_XTRACT_TYPE(msg_hdr) == MSG_TYPE_DELAYED_RESP)
 			scmi_clear_channel(info, cinfo);
 		return;
@@ -936,6 +948,16 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		complete(&xfer->done);
 	}
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		/*
+		 * When in polling mode avoid to queue the Raw xfer on the IRQ
+		 * RX path since it will be already queued at the end of the TX
+		 * poll loop.
+		 */
+		if (!xfer->hdr.poll_completion)
+			scmi_raw_message_report(info->raw, xfer, SCMI_RAW_REPLY_QUEUE);
+	}
+
 	scmi_xfer_command_release(info, xfer);
 }
 
@@ -1050,6 +1072,14 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP" : "resp",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
+
+			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+				struct scmi_info *info =
+					handle_to_scmi_info(cinfo->handle);
+
+				scmi_raw_message_report(info->raw, xfer,
+							SCMI_RAW_REPLY_QUEUE);
+			}
 		}
 	} else {
 		/* And we wait for the response. */
@@ -2576,6 +2606,26 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	return dbg;
 }
 
+static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
+{
+	int ret = 0;
+
+	if (!info->dbg)
+		return -EINVAL;
+
+	info->raw = scmi_raw_mode_init(&info->handle, info->dbg->top_dentry,
+				       info->id, info->desc,
+				       info->tx_minfo.max_msg);
+
+	if (IS_ERR(info->raw)) {
+		dev_err(info->dev, "Failed to initialize SCMI RAW Mode !\n");
+		ret = PTR_ERR(info->raw);
+		info->raw = NULL;
+	}
+
+	return ret;
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -2654,6 +2704,14 @@ static int scmi_probe(struct platform_device *pdev)
 		info->dbg = scmi_debugfs_common_setup(info);
 		if (!info->dbg)
 			dev_warn(dev, "Failed to setup SCMI debugfs.\n");
+
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+			ret = scmi_debugfs_raw_mode_setup(info);
+			if (ret)
+				goto clear_dev_req_notifier;
+
+			return 0;
+		}
 	}
 
 	if (scmi_notification_init(handle))
@@ -2713,6 +2771,8 @@ static int scmi_probe(struct platform_device *pdev)
 	return 0;
 
 notification_exit:
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		scmi_raw_mode_cleanup(info->raw);
 	scmi_notification_exit(&info->handle);
 clear_dev_req_notifier:
 	blocking_notifier_chain_unregister(&scmi_requested_devices_nh,
@@ -2732,6 +2792,9 @@ static int scmi_remove(struct platform_device *pdev)
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct device_node *child;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		scmi_raw_mode_cleanup(info->raw);
+
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
 		dev_warn(&pdev->dev,
-- 
2.34.1

