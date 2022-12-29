Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0E659051
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiL2SYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiL2SYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9279813F87
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBFA41684;
        Thu, 29 Dec 2022 10:24:48 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 611983F71A;
        Thu, 29 Dec 2022 10:24:05 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 08/17] include: trace: Add platform and channel instance references
Date:   Thu, 29 Dec 2022 18:22:44 +0000
Message-Id: <20221229182253.948175-9-cristian.marussi@arm.com>
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

Add channel and platform instance indentifier to SCMI message dump traces
in order to easily associate message flows to specific transport channels.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 20 ++++++++++++--------
 include/trace/events/scmi.h        | 18 ++++++++++++------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index af34324e923b..c765d0c51dc5 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -860,9 +860,9 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 
-	trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id, "NOTI",
-			    xfer->hdr.seq, xfer->hdr.status,
-			    xfer->rx.buf, xfer->rx.len);
+	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
+			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
+			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
 
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
@@ -898,7 +898,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		smp_store_mb(xfer->priv, priv);
 	info->desc->ops->fetch_response(cinfo, xfer);
 
-	trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id,
+	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
+			    xfer->hdr.id,
 			    xfer->hdr.type == MSG_TYPE_DELAYED_RESP ?
 			    "DLYD" : "RESP",
 			    xfer->hdr.seq, xfer->hdr.status,
@@ -1008,6 +1009,8 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 
 		if (!ret) {
 			unsigned long flags;
+			struct scmi_info *info =
+				handle_to_scmi_info(cinfo->handle);
 
 			/*
 			 * Do not fetch_response if an out-of-order delayed
@@ -1021,7 +1024,8 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			spin_unlock_irqrestore(&xfer->lock, flags);
 
 			/* Trace polled replies. */
-			trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id,
+			trace_scmi_msg_dump(info->id, cinfo->id,
+					    xfer->hdr.protocol_id, xfer->hdr.id,
 					    "RESP",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
@@ -1157,9 +1161,9 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return ret;
 	}
 
-	trace_scmi_msg_dump(xfer->hdr.protocol_id, xfer->hdr.id, "CMND",
-			    xfer->hdr.seq, xfer->hdr.status,
-			    xfer->tx.buf, xfer->tx.len);
+	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
+			    xfer->hdr.id, "CMND", xfer->hdr.seq,
+			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status)
diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index f160d68f961d..422c1ad9484d 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -139,11 +139,15 @@ TRACE_EVENT(scmi_rx_done,
 );
 
 TRACE_EVENT(scmi_msg_dump,
-	TP_PROTO(u8 protocol_id, u8 msg_id, unsigned char *tag, u16 seq,
-		 int status, void *buf, size_t len),
-	TP_ARGS(protocol_id, msg_id, tag, seq, status, buf, len),
+	TP_PROTO(int id, u8 channel_id, u8 protocol_id, u8 msg_id,
+		 unsigned char *tag, u16 seq, int status,
+		 void *buf, size_t len),
+	TP_ARGS(id, channel_id, protocol_id, msg_id, tag, seq, status,
+		buf, len),
 
 	TP_STRUCT__entry(
+		__field(int, id)
+		__field(u8, channel_id)
 		__field(u8, protocol_id)
 		__field(u8, msg_id)
 		__array(char, tag, 5)
@@ -154,6 +158,8 @@ TRACE_EVENT(scmi_msg_dump,
 	),
 
 	TP_fast_assign(
+		__entry->id = id;
+		__entry->channel_id = channel_id;
 		__entry->protocol_id = protocol_id;
 		__entry->msg_id = msg_id;
 		strscpy(__entry->tag, tag, 5);
@@ -163,9 +169,9 @@ TRACE_EVENT(scmi_msg_dump,
 		memcpy(__get_dynamic_array(cmd), buf, __entry->len);
 	),
 
-	TP_printk("pt=%02X t=%s msg_id=%02X seq=%04X s=%d pyld=%s",
-		  __entry->protocol_id, __entry->tag, __entry->msg_id,
-		  __entry->seq, __entry->status,
+	TP_printk("id=%d ch=%02X pt=%02X t=%s msg_id=%02X seq=%04X s=%d pyld=%s",
+		  __entry->id, __entry->channel_id, __entry->protocol_id,
+		  __entry->tag, __entry->msg_id, __entry->seq, __entry->status,
 		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
 );
 #endif /* _TRACE_SCMI_H */
-- 
2.34.1

