Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF599659059
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiL2SZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiL2SYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B545413E9A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07931655;
        Thu, 29 Dec 2022 10:25:04 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823023F71A;
        Thu, 29 Dec 2022 10:24:21 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 15/17] firmware: arm_scmi: Call Raw mode hooks from the core stack
Date:   Thu, 29 Dec 2022 18:22:51 +0000
Message-Id: <20221229182253.948175-16-cristian.marussi@arm.com>
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

Add a few call sites where, if SCMI Raw mode access had been enabled in
Kconfig, the needed SCMI Raw initialization and hooks are called.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
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
 drivers/firmware/arm_scmi/driver.c | 53 +++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8c0db8639b80..2a4f6024e090 100644
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
@@ -2666,9 +2696,25 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		goto clear_dev_req_notifier;
 
-	if (scmi_top_dentry)
+	if (scmi_top_dentry) {
 		info->dbg = scmi_debugfs_common_setup(info);
 
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) && info->dbg) {
+			info->raw = scmi_raw_mode_init(handle,
+						       info->dbg->top_dentry,
+						       info->id, info->desc,
+						       info->tx_minfo.max_msg);
+			if (IS_ERR(info->raw)) {
+				dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
+
+				ret = PTR_ERR(info->raw);
+				goto clear_dev_req_notifier;
+			}
+
+			return 0;
+		}
+	}
+
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
@@ -2726,6 +2772,8 @@ static int scmi_probe(struct platform_device *pdev)
 	return 0;
 
 notification_exit:
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		scmi_raw_mode_cleanup(info->raw);
 	scmi_notification_exit(&info->handle);
 clear_dev_req_notifier:
 	blocking_notifier_chain_unregister(&scmi_requested_devices_nh,
@@ -2745,6 +2793,9 @@ static int scmi_remove(struct platform_device *pdev)
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

