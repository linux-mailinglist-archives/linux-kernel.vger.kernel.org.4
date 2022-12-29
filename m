Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F565904E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiL2SYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiL2SX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:23:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A63513EB0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:23:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AA481655;
        Thu, 29 Dec 2022 10:24:37 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A873F71A;
        Thu, 29 Dec 2022 10:23:54 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 03/17] firmware: arm_scmi: Refactor scmi_wait_for_message_response
Date:   Thu, 29 Dec 2022 18:22:39 +0000
Message-Id: <20221229182253.948175-4-cristian.marussi@arm.com>
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

Refactor scmi_wait_for_message_response() to use a internal helper to
carry out its main duties; while doing that  make it accept directly an
scmi_desc parameter to interact with the configured transport.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 57 +++++++++++++++++-------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d7f21e81bd11..ce204a77c7f3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -891,36 +891,18 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 	       ktime_after(ktime_get(), stop);
 }
 
-/**
- * scmi_wait_for_message_response  - An helper to group all the possible ways of
- * waiting for a synchronous message response.
- *
- * @cinfo: SCMI channel info
- * @xfer: Reference to the transfer being waited for.
- *
- * Chooses waiting strategy (sleep-waiting vs busy-waiting) depending on
- * configuration flags like xfer->hdr.poll_completion.
- *
- * Return: 0 on Success, error otherwise.
- */
-static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
-					  struct scmi_xfer *xfer)
+static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
+			       struct scmi_chan_info *cinfo,
+			       struct scmi_xfer *xfer, unsigned int timeout_ms)
 {
-	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
-	struct device *dev = info->dev;
-	int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
-
-	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
-				      xfer->hdr.protocol_id, xfer->hdr.seq,
-				      timeout_ms,
-				      xfer->hdr.poll_completion);
+	int ret = 0;
 
 	if (xfer->hdr.poll_completion) {
 		/*
 		 * Real polling is needed only if transport has NOT declared
 		 * itself to support synchronous commands replies.
 		 */
-		if (!info->desc->sync_cmds_completed_on_ret) {
+		if (!desc->sync_cmds_completed_on_ret) {
 			/*
 			 * Poll on xfer using transport provided .poll_done();
 			 * assumes no completion interrupt was available.
@@ -946,7 +928,7 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 			 */
 			spin_lock_irqsave(&xfer->lock, flags);
 			if (xfer->state == SCMI_XFER_SENT_OK) {
-				info->desc->ops->fetch_response(cinfo, xfer);
+				desc->ops->fetch_response(cinfo, xfer);
 				xfer->state = SCMI_XFER_RESP_OK;
 			}
 			spin_unlock_irqrestore(&xfer->lock, flags);
@@ -970,6 +952,33 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 	return ret;
 }
 
+/**
+ * scmi_wait_for_message_response  - An helper to group all the possible ways of
+ * waiting for a synchronous message response.
+ *
+ * @cinfo: SCMI channel info
+ * @xfer: Reference to the transfer being waited for.
+ *
+ * Chooses waiting strategy (sleep-waiting vs busy-waiting) depending on
+ * configuration flags like xfer->hdr.poll_completion.
+ *
+ * Return: 0 on Success, error otherwise.
+ */
+static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
+					  struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct device *dev = info->dev;
+
+	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
+				      xfer->hdr.protocol_id, xfer->hdr.seq,
+				      info->desc->max_rx_timeout_ms,
+				      xfer->hdr.poll_completion);
+
+	return scmi_wait_for_reply(dev, info->desc, cinfo, xfer,
+				   info->desc->max_rx_timeout_ms);
+}
+
 /**
  * do_xfer() - Do one transfer
  *
-- 
2.34.1

