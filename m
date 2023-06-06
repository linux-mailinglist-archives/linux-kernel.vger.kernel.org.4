Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3A724997
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjFFQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjFFQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:56:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB610F0;
        Tue,  6 Jun 2023 09:56:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356Arf6s025511;
        Tue, 6 Jun 2023 16:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=seP5KvSteYNKsZd6TSSGt+lcTlRlXQMHEzpjqzHhvfQ=;
 b=h4m9FfTQCgsWeW3D89WjLBoPMKFzjmzXvhRZIM1tXCj1Y1QJjN/vTCTlTYEZRxBu55oM
 OIjJcSgmdpbsNbJlRI/Lkb3db9swMBQWtGSDfQXY2qMIih/IJIIsI/am+jIIo+sfmyo3
 Du1Kfr3o1Yw05ejrtYG8WYi6Rqw2f4IaDxGVPUNwfDR6OTMgj4YxBE66xvsZrYSxrQvW
 JGwwJp52xfBbZQWCnoCUMPsNSK/2n6FbcmcC7e8OavWX/Rlb1d/gvN5m3Nu5NDs4zJ8X
 kuPGnq1LGGo41vgmwo4hj4aoNT89FJXM+AeNiLVFC3BwVxeFFxQzkPe6Q4KdnWN95758 GQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1uvv1r3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:56:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356Gu6Te024721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 16:56:06 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 09:56:01 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1] misc: fastrpc: Collect driver-remote processor transaction logs
Date:   Tue, 6 Jun 2023 22:25:55 +0530
Message-ID: <1686070555-11154-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vm4RVySWaBisWMzXTof339pgMq0xK9oC
X-Proofpoint-GUID: Vm4RVySWaBisWMzXTof339pgMq0xK9oC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to collect driver-remote processor rpmsg transaction
logs. These logs will carry payload information for the rpmsg message
instance. These logs are channel specific and are collected in
channel context structure.

These rpmsg transaction logs can help in improving debugability as
all requests from processes are getting captured in channel context
structure.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30d4d04..6447cee 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -104,6 +104,9 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+/* Length of glink transaction history to store */
+#define GLINK_MSG_HISTORY_LEN	(128)
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -181,6 +184,28 @@ struct fastrpc_invoke_rsp {
 	int retval;		/* invoke return value */
 };
 
+struct fastrpc_tx_msg {
+	struct fastrpc_msg msg;	/* Msg sent to remote subsystem */
+	int rpmsg_send_err;	/* rpmsg error */
+	s64 ns;			/* Timestamp (in ns) of msg */
+};
+
+struct fastrpc_rx_msg {
+	struct fastrpc_invoke_rsp rsp;	/* Response from remote subsystem */
+	s64 ns;		/* Timestamp (in ns) of response */
+};
+
+struct fastrpc_rpmsg_log {
+	u32 tx_index;	/* Current index of 'tx_msgs' array */
+	u32 rx_index;	/* Current index of 'rx_msgs' array */
+	/* Rolling history of messages sent to remote subsystem */
+	struct fastrpc_tx_msg tx_msgs[GLINK_MSG_HISTORY_LEN];
+	/* Rolling history of responses from remote subsystem */
+	struct fastrpc_rx_msg rx_msgs[GLINK_MSG_HISTORY_LEN];
+	spinlock_t tx_lock;
+	spinlock_t rx_lock;
+};
+
 struct fastrpc_buf_overlap {
 	u64 start;
 	u64 end;
@@ -277,6 +302,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
 	struct list_head invoke_interrupted_mmaps;
+	struct fastrpc_rpmsg_log gmsg_log[FASTRPC_DEV_MAX];
 	bool secure;
 	bool unsigned_support;
 	u64 dma_mask;
@@ -1097,6 +1123,64 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	return 0;
 }
 
+static s64 get_timestamp_in_ns(void)
+{
+	s64 ns = 0;
+	struct timespec64 ts;
+
+	ktime_get_real_ts64(&ts);
+	ns = timespec64_to_ns(&ts);
+	return ns;
+}
+
+static void fastrpc_update_txmsg_buf(struct fastrpc_channel_ctx *chan,
+				struct fastrpc_msg *msg, int rpmsg_send_err, s64 ns)
+{
+	unsigned long flags = 0;
+	u32 tx_index = 0;
+	struct fastrpc_tx_msg *tx_msg = NULL;
+
+	spin_lock_irqsave(&(chan->gmsg_log[chan->domain_id].tx_lock), flags);
+
+	tx_index = chan->gmsg_log[chan->domain_id].tx_index;
+	tx_msg = &(chan->gmsg_log[chan->domain_id].tx_msgs[tx_index]);
+
+	memcpy(&tx_msg->msg, msg, sizeof(struct fastrpc_msg));
+	tx_msg->rpmsg_send_err = rpmsg_send_err;
+	tx_msg->ns = ns;
+
+	tx_index++;
+	chan->gmsg_log[chan->domain_id].tx_index =
+		(tx_index > (GLINK_MSG_HISTORY_LEN - 1)) ? 0 : tx_index;
+
+	spin_unlock_irqrestore(&(chan->gmsg_log[chan->domain_id].tx_lock), flags);
+}
+
+static void fastrpc_update_rxmsg_buf(struct fastrpc_channel_ctx *chan,
+							u64 ctx, int retval, s64 ns)
+{
+	unsigned long flags = 0;
+	u32 rx_index = 0;
+	struct fastrpc_rx_msg *rx_msg = NULL;
+	struct fastrpc_invoke_rsp *rsp = NULL;
+
+	spin_lock_irqsave(&(chan->gmsg_log[chan->domain_id].rx_lock), flags);
+
+	rx_index = chan->gmsg_log[chan->domain_id].rx_index;
+	rx_msg = &(chan->gmsg_log[chan->domain_id].rx_msgs[rx_index]);
+	rsp = &rx_msg->rsp;
+
+	rsp->ctx = ctx;
+	rsp->retval = retval;
+	rx_msg->ns = ns;
+
+	rx_index++;
+	chan->gmsg_log[chan->domain_id].rx_index =
+		(rx_index > (GLINK_MSG_HISTORY_LEN - 1)) ? 0 : rx_index;
+
+	spin_unlock_irqrestore(&(chan->gmsg_log[chan->domain_id].rx_lock), flags);
+}
+
 static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 			       struct fastrpc_invoke_ctx *ctx,
 			       u32 kernel, uint32_t handle)
@@ -1124,6 +1208,7 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 	if (ret)
 		fastrpc_context_put(ctx);
+	fastrpc_update_txmsg_buf(cctx, msg, ret, get_timestamp_in_ns());
 
 	return ret;
 
@@ -2323,6 +2408,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	INIT_LIST_HEAD(&data->users);
 	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
+	spin_lock_init(&(data->gmsg_log[data->domain_id].tx_lock));
+	spin_lock_init(&(data->gmsg_log[data->domain_id].rx_lock));
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
@@ -2398,6 +2485,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
+	fastrpc_update_rxmsg_buf(cctx, rsp->ctx, rsp->retval, get_timestamp_in_ns());
 
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
-- 
2.7.4

