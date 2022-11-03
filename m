Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152A61890B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKCTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKCTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 810E120194
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:53:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865E31FB;
        Thu,  3 Nov 2022 12:53:25 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 447733F534;
        Thu,  3 Nov 2022 12:53:17 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 13/14] firmware: arm_scmi: Call Raw mode hooks from the core stack
Date:   Thu,  3 Nov 2022 19:52:24 +0000
Message-Id: <20221103195225.1028864-14-cristian.marussi@arm.com>
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

Add a few call sites where, if SCMI Raw mode access had been enabled in
Kconfig, the needed SCMI Raw initialization and hooks are called.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- rework to use multiple SCMI instances
v3 --> v4
- add call hooks to support polled transports
v1 --> v2
- fixes need to use multiple cinfo if available
---
 drivers/firmware/arm_scmi/driver.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bbb43b65cbfd..9f8e5d42c7aa 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -37,6 +37,8 @@
 #include "common.h"
 #include "notify.h"
 
+#include "raw_mode.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
@@ -136,6 +138,7 @@ struct scmi_protocol_instance {
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
+ * @raw: An opaque reference handle used by SCMI Raw mode.
  */
 struct scmi_info {
 	struct device *dev;
@@ -155,6 +158,7 @@ struct scmi_info {
 	void *notify_priv;
 	struct list_head node;
 	int users;
+	void *raw;
 };
 
 static struct dentry *scmi_raw_top_dentry;
@@ -772,6 +776,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   MSG_TYPE_NOTIFICATION);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		xfer->hdr.seq = MSG_XTRACT_TOKEN(msg_hdr);
+		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_NOTIF_QUEUE);
+	}
+
 	__scmi_xfer_put(minfo, xfer);
 
 	scmi_clear_channel(info, cinfo);
@@ -785,6 +794,9 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+			scmi_raw_error_report(info->raw, cinfo, msg_hdr, priv);
+
 		if (MSG_XTRACT_TYPE(msg_hdr) == MSG_TYPE_DELAYED_RESP)
 			scmi_clear_channel(info, cinfo);
 		return;
@@ -817,6 +829,16 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
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
 
@@ -927,6 +949,14 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    !xfer->is_raw ? "RESP" : "resp",
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
@@ -2613,6 +2643,18 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		goto clear_txrx_setup;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		info->raw = scmi_raw_mode_init(handle, scmi_raw_top_dentry,
+					       info->desc,
+					       info->tx_minfo.max_msg);
+		if (IS_ERR(info->raw)) {
+			dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
+			return PTR_ERR(info->raw);
+		}
+
+		return 0;
+	}
+
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
@@ -2687,6 +2729,9 @@ static int scmi_remove(struct platform_device *pdev)
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

