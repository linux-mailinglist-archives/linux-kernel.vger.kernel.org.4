Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966B60518C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiJSUrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiJSUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:47:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0963F1BE1FA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:47:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42DD41424;
        Wed, 19 Oct 2022 13:47:12 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C933F792;
        Wed, 19 Oct 2022 13:47:03 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 11/11] firmware: arm_scmi: Call Raw mode hooks from the core stack
Date:   Wed, 19 Oct 2022 21:46:26 +0100
Message-Id: <20221019204626.3813043-12-cristian.marussi@arm.com>
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

Add a few call sites where, if SCMI Raw mode access had been enabled in
Kconfig, the needed SCMI Raw initialization and hooks are called.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- add call hooks to support polled transports
v1 --> v2
- fixes need to use multiple cinfo if available
---
 drivers/firmware/arm_scmi/driver.c | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3e5539987443..e28104e1b961 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -34,6 +34,8 @@
 #include "common.h"
 #include "notify.h"
 
+#include "raw_mode.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
@@ -133,6 +135,7 @@ struct scmi_protocol_instance {
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
+ * @raw: An opaque reference handle used by SCMI Raw mode.
  */
 struct scmi_info {
 	struct device *dev;
@@ -152,6 +155,7 @@ struct scmi_info {
 	void *notify_priv;
 	struct list_head node;
 	int users;
+	void *raw;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -761,6 +765,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   MSG_TYPE_NOTIFICATION);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		xfer->hdr.seq = MSG_XTRACT_TOKEN(msg_hdr);
+		scmi_raw_message_report(info->raw, xfer, SCMI_RAW_NOTIF_QUEUE);
+	}
+
 	__scmi_xfer_put(minfo, xfer);
 
 	scmi_clear_channel(info, cinfo);
@@ -774,6 +783,9 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+			scmi_raw_error_report(info->raw, cinfo, msg_hdr, priv);
+
 		if (MSG_XTRACT_TYPE(msg_hdr) == MSG_TYPE_DELAYED_RESP)
 			scmi_clear_channel(info, cinfo);
 		return;
@@ -805,6 +817,16 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
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
 
@@ -915,6 +937,14 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP",
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
@@ -2587,6 +2617,18 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		goto clear_txrx_setup;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		info->raw = scmi_raw_mode_init(handle, info->desc,
+					       info->tx_minfo.max_msg);
+		if (!IS_ERR(info->raw)) {
+			dev_info(dev, "SCMI RAW Mode initialized.\n");
+			return 0;
+		}
+
+		dev_err(dev, "Failed to initialize SCMI RAW Mode !\n");
+		info->raw = NULL;
+	}
+
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
@@ -2661,6 +2703,9 @@ static int scmi_remove(struct platform_device *pdev)
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct device_node *child;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
+		scmi_raw_mode_cleanup(info->raw);
+
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
 		ret = -EBUSY;
-- 
2.34.1

