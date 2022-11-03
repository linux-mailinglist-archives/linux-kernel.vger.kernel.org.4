Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20358618903
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKCTx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D850B20BD1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:53:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D6A11FB;
        Thu,  3 Nov 2022 12:53:11 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8113F534;
        Thu,  3 Nov 2022 12:53:03 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 07/14] firmware: arm_scmi: Add xfer Raw helpers
Date:   Thu,  3 Nov 2022 19:52:18 +0000
Message-Id: <20221103195225.1028864-8-cristian.marussi@arm.com>
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

Add a few SCMI helpers useful to implement SCMI Raw access support.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- add handling of xfer->is_raw flag
v3 --> v4
- add scmi_xfer_raw_wait_for_response helper
- fixed typos in comments
v2 --> v3
- allow for DT-unknown protocols to get a channel
v1 --> v2
- added scmi_xfer_raw_channel_get
---
 drivers/firmware/arm_scmi/common.h |  12 +++
 drivers/firmware/arm_scmi/driver.c | 147 +++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b8ab2397d807..2a08c2c50bf8 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -233,6 +233,18 @@ static inline bool is_polling_enabled(struct scmi_chan_info *cinfo,
 		is_transport_polling_capable(desc);
 }
 
+void scmi_xfer_raw_put(const struct scmi_handle *handle,
+		       struct scmi_xfer *xfer);
+struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle);
+struct scmi_chan_info *
+scmi_xfer_raw_channel_get(const struct scmi_handle *handle, u8 protocol_id);
+
+int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
+				    struct scmi_xfer *xfer);
+
+int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
+					    struct scmi_xfer *xfer,
+					    unsigned int timeout_ms);
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 33b123da3053..c4fd29f81b1e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -350,6 +350,53 @@ scmi_xfer_inflight_register_unlocked(struct scmi_xfer *xfer,
 	xfer->pending = true;
 }
 
+/**
+ * scmi_xfer_inflight_register  - Try to register an xfer as in-flight
+ *
+ * @xfer: The xfer to register
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
+ *
+ * Note that this helper does NOT assume anything about the sequence number
+ * that was baked into the provided xfer, so it checks at first if it can
+ * be mapped to a free slot and fails with an error if another xfer with the
+ * same sequence number is currently still registered as in-flight.
+ *
+ * Return: 0 on Success or -EBUSY if sequence number embedded in the xfer
+ *	   could not rbe mapped to a free slot in the xfer_alloc_table.
+ */
+static int scmi_xfer_inflight_register(struct scmi_xfer *xfer,
+				       struct scmi_xfers_info *minfo)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	if (!test_bit(xfer->hdr.seq, minfo->xfer_alloc_table))
+		scmi_xfer_inflight_register_unlocked(xfer, minfo);
+	else
+		ret = -EBUSY;
+	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+	return ret;
+}
+
+/**
+ * scmi_xfer_raw_inflight_register  - An helper to register the given xfer as in
+ * flight on the TX channel, if possible.
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: The xfer to register
+ *
+ * Return: 0 on Success, error otherwise
+ */
+int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
+				    struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return scmi_xfer_inflight_register(xfer, &info->tx_minfo);
+}
+
 /**
  * scmi_xfer_pending_set  - Pick a proper sequence number and mark the xfer
  * as pending in-flight
@@ -425,6 +472,63 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	return xfer;
 }
 
+/**
+ * scmi_xfer_raw_get  - Helper to get a bare free xfer from the TX channel
+ *
+ * @handle: Pointer to SCMI entity handle
+ *
+ * Note that xfer is taken from the TX channel structures.
+ *
+ * Return: A valid xfer on Success, or an error-pointer otherwise
+ */
+struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle)
+{
+	struct scmi_xfer *xfer;
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	xfer = scmi_xfer_get(handle, &info->tx_minfo);
+	if (!IS_ERR(xfer))
+		xfer->is_raw = true;
+
+	return xfer;
+}
+
+/**
+ * scmi_xfer_raw_channel_get  - Helper to get a reference to the proper channel
+ * to use for a specific protocol_id Raw transaction.
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @protocol_id: Identifier of the protocol
+ *
+ * Note that in a regular SCMI stack, usually, a protocol has to be defined in
+ * the DT to have an associated channel and be usable; but in Raw mode any
+ * protocol in range is allowed, re-using the Base channel, so as to enable
+ * fuzzing on any protocol without the need of a fully compiled DT.
+ *
+ * Return: A reference to the channel to use, or an ERR_PTR
+ */
+struct scmi_chan_info *
+scmi_xfer_raw_channel_get(const struct scmi_handle *handle, u8 protocol_id)
+{
+	struct scmi_chan_info *cinfo;
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	cinfo = idr_find(&info->tx_idr, protocol_id);
+	if (!cinfo) {
+		if (protocol_id == SCMI_PROTOCOL_BASE)
+			return ERR_PTR(-EINVAL);
+		/* Use Base channel for protocols not defined for DT */
+		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		if (!cinfo)
+			return ERR_PTR(-EINVAL);
+		dev_warn_once(handle->dev,
+			      "Using Base channel for protocol 0x%X\n",
+			      protocol_id);
+	}
+
+	return cinfo;
+}
+
 /**
  * __scmi_xfer_put() - Release a message
  *
@@ -453,6 +557,23 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
+/**
+ * scmi_xfer_raw_put  - Release an xfer that was taken by @scmi_xfer_raw_get
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: A reference to the xfer to put
+ *
+ * Note that as with other xfer_put() handlers the xfer is really effectively
+ * released only if there are no more users on the system.
+ */
+void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	xfer->is_raw = false;
+	return __scmi_xfer_put(&info->tx_minfo, xfer);
+}
+
 /**
  * scmi_xfer_lookup_unlocked  -  Helper to lookup an xfer_id
  *
@@ -879,6 +1000,32 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				   info->desc->max_rx_timeout_ms);
 }
 
+/**
+ * scmi_xfer_raw_wait_for_message_response  - An helper to wait for a message
+ * reply to an xfer raw request on a specific channel for the required timeout.
+ *
+ * @cinfo: SCMI channel info
+ * @xfer: Reference to the transfer being waited for.
+ * @timeout_ms: The maximum timeout in milliseconds
+ *
+ * Return: 0 on Success, error otherwise.
+ */
+int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
+					    struct scmi_xfer *xfer,
+					    unsigned int timeout_ms)
+{
+	int ret;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct device *dev = info->dev;
+
+	ret = scmi_wait_for_reply(dev, info->desc, cinfo, xfer, timeout_ms);
+	if (ret)
+		dev_dbg(dev, "timed out in RAW response - HDR:%08X\n",
+			pack_scmi_header(&xfer->hdr));
+
+	return ret;
+}
+
 /**
  * do_xfer() - Do one transfer
  *
-- 
2.34.1

