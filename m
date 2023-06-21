Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F273897E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjFUPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjFUPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:35:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D2BBC;
        Wed, 21 Jun 2023 08:34:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L9DQUq003230;
        Wed, 21 Jun 2023 15:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=l8IXCYQiN1DAAczqyeHLbKyxo4X10EwpiOW0x86mFDg=;
 b=UwRmYAOszktY+JkxXerzGLXRod25NHjk0r32dAB692YJcjREoX78wXcYV2350h2b6RD+
 3V0FQMr0rG652mNuafrqr2RX9U9CL5fZ9FxSclQN146IkR9KHvVk0AtFvzQLINW9ZhSn
 IJLXVPPlf/UI5O0ZIYJK8rcp0Yl2RwNJhxOD21+6XhT89Xj9++ZsBPZ9qQojJzGQCZMG
 ss9fNGB+sQuOARBY7oTh4aIk1UMvo8R1tVU6Af0LEcpQD6LRYjG+RhsmmLzPeU89+gtJ
 pF0pJr/nfLymufnXi5Y80jcVWBjpCYYrr5hW181xm8iRU55gZq2Dr8vMJ4UDkPEom3uS Zg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbxc7rx0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 15:34:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LFYkla022334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 15:34:46 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 08:34:42 -0700
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Sarannya S <quic_sarannya@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH V8 2/3] rpmsg: glink: Add support to handle signals command
Date:   Wed, 21 Jun 2023 21:04:07 +0530
Message-ID: <1687361648-27688-3-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687361648-27688-1-git-send-email-quic_sarannya@quicinc.com>
References: <1687361648-27688-1-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c88zgRSMoHjYO7OHmDsuMhVZ2jEWvnjm
X-Proofpoint-ORIG-GUID: c88zgRSMoHjYO7OHmDsuMhVZ2jEWvnjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <quic_clew@quicinc.com>

Remote peripherals send signal notifications over glink with commandID 15.

Add support to send and receive the signal command and based signals
enable or disable flow control with remote host.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 1beb40a..bc87e6d 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -200,9 +200,15 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops;
 #define GLINK_CMD_TX_DATA_CONT		12
 #define GLINK_CMD_READ_NOTIF		13
 #define GLINK_CMD_RX_DONE_W_REUSE	14
+#define GLINK_CMD_SIGNALS		15
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
+#define NATIVE_DTR_SIG			NATIVE_DSR_SIG
+#define NATIVE_DSR_SIG			BIT(31)
+#define NATIVE_RTS_SIG			NATIVE_CTS_SIG
+#define NATIVE_CTS_SIG			BIT(30)
+
 static void qcom_glink_rx_done_work(struct work_struct *work);
 
 static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
@@ -1025,6 +1031,51 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
 	return 0;
 }
 
+/**
+ * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
+ * 				   transmit
+ * @ept:	Rpmsg endpoint for channel.
+ * @pause:	Pause transmission
+ * @dst:	destination address of the endpoint
+ *
+ * Return: 0 on success or standard Linux error code.
+ */
+static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool pause, u32 dst)
+{
+	struct glink_channel *channel = to_glink_channel(ept);
+	struct qcom_glink *glink = channel->glink;
+	struct glink_msg msg;
+	u32 sigs = 0;
+
+	if (pause)
+		sigs |= NATIVE_DTR_SIG | NATIVE_RTS_SIG;
+
+	msg.cmd = cpu_to_le16(GLINK_CMD_SIGNALS);
+	msg.param1 = cpu_to_le16(channel->lcid);
+	msg.param2 = cpu_to_le32(sigs);
+
+	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+}
+
+static void qcom_glink_handle_signals(struct qcom_glink *glink,
+				     unsigned int rcid, unsigned int sigs)
+{
+	struct glink_channel *channel;
+	unsigned long flags;
+	bool enable;
+
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	channel = idr_find(&glink->rcids, rcid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+	if (!channel)
+		dev_err(glink->dev, "signal for non-existing channel\n");
+
+	enable = sigs & NATIVE_DSR_SIG || sigs & NATIVE_CTS_SIG;
+
+	if (channel->ept.flow_cb)
+		channel->ept.flow_cb(channel->ept.rpdev, channel->ept.priv, enable);
+}
+
 void qcom_glink_native_rx(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
@@ -1086,6 +1137,10 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
 			qcom_glink_handle_intent_req_ack(glink, param1, param2);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
+		case GLINK_CMD_SIGNALS:
+			qcom_glink_handle_signals(glink, param1, param2);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			break;
 		default:
 			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
 			ret = -EINVAL;
@@ -1446,6 +1501,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
 	.sendto = qcom_glink_sendto,
 	.trysend = qcom_glink_trysend,
 	.trysendto = qcom_glink_trysendto,
+	.set_flow_control = qcom_glink_set_flow_control,
 };
 
 static void qcom_glink_rpdev_release(struct device *dev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

