Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0EF69E42C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjBUQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjBUQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:04:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B196A4A;
        Tue, 21 Feb 2023 08:04:39 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LB4B0q010401;
        Tue, 21 Feb 2023 16:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xSRVNI3nIa9YjmwhyZe5C7E2R5ny1Ha1JXCBMgx0eMw=;
 b=IGdHcxCMh+xINOE4sRq54NijneYtC3/1vI/TgKNpQaUXk0GBkgu0kiAoNEC64rGyqNfP
 6hWf/OCjjYJQo/eRPDKt7hRqZnDXXBwfGfdNPMJyzQrAvFs55sFwGSDa5H71xTSRNURX
 t18shsR65kmrInZBgmRsh/JVgQR8CelxBLNR4o1tWuuvNbSILA7UKvytZKNLjcf/vgoq
 XvS/Y7uzOmZtR1YdOS68EVkc1YHPeW4SiaXPeWRTK1k7Y/YULwIEMa2qM0o6gYdjKpHY
 zDE/YlSashkKUMCWH7pLFVnmZQJ4/bkxyAji858Ierex1dDxTZgHfvPZ7tnUpZ0DuwOm 3w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvvrrgn01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 16:04:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LG4VmG032642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 16:04:31 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 08:04:27 -0800
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH V5 2/3] rpmsg: glink: Add support to handle signals command
Date:   Tue, 21 Feb 2023 21:33:36 +0530
Message-ID: <1676995418-19358-3-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676995418-19358-1-git-send-email-quic_sarannya@quicinc.com>
References: <1676995418-19358-1-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oobXT5NefHJwfvmqDicWa5QaSrdRZmwI
X-Proofpoint-ORIG-GUID: oobXT5NefHJwfvmqDicWa5QaSrdRZmwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote peripherals send signal notifications over glink with commandID 15.

Add support to send and receive the signal command and based signals
enable or disable flow control with remote host.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h             | 15 ++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 115c0a1..01d0a49 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -17,6 +17,7 @@
 #include <linux/rpmsg.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/workqueue.h>
 #include <linux/mailbox_client.h>
 
@@ -203,9 +204,15 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops;
 #define RPM_CMD_TX_DATA_CONT		12
 #define RPM_CMD_READ_NOTIF		13
 #define RPM_CMD_RX_DONE_W_REUSE		14
+#define RPM_CMD_SIGNALS			15
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
+#define NATIVE_DTR_SIG			NATIVE_DSR_SIG
+#define NATIVE_DSR_SIG			BIT(31)
+#define NATIVE_RTS_SIG			NATIVE_CTS_SIG
+#define NATIVE_CTS_SIG			BIT(30)
+
 static void qcom_glink_rx_done_work(struct work_struct *work);
 
 static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
@@ -1001,6 +1008,57 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
 	return 0;
 }
 
+/**
+ * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
+ * 				   transmit
+ * @ept:	Rpmsg endpoint for channel.
+ * @enable:	True/False - enable or disable flow control
+ *
+ * Return: 0 on success or standard Linux error code.
+ */
+static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+{
+	struct glink_channel *channel = to_glink_channel(ept);
+	struct qcom_glink *glink = channel->glink;
+	struct glink_msg msg;
+	u32 sigs = 0;
+
+	if (enable)
+		sigs |= NATIVE_DTR_SIG | NATIVE_RTS_SIG;
+
+	msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
+	msg.param1 = cpu_to_le16(channel->lcid);
+	msg.param2 = cpu_to_le32(sigs);
+
+	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+}
+
+static int qcom_glink_handle_signals(struct qcom_glink *glink,
+				     unsigned int rcid, unsigned int sigs)
+{
+	struct glink_channel *channel;
+	unsigned long flags;
+	bool enable = false;
+
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	channel = idr_find(&glink->rcids, rcid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+	if (!channel) {
+		dev_err(glink->dev, "signal for non-existing channel\n");
+		return -EINVAL;
+	}
+
+	if (!channel->ept.flow_cb)
+		return 0;
+
+	if (sigs & (NATIVE_DSR_SIG | NATIVE_CTS_SIG))
+		enable = true;
+
+	channel->ept.flow_cb(channel->ept.rpdev, channel->ept.priv, enable);
+
+	return 0;
+}
+
 static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 {
 	struct qcom_glink *glink = data;
@@ -1065,6 +1123,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 			qcom_glink_handle_intent_req_ack(glink, param1, param2);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
+		case RPM_CMD_SIGNALS:
+			qcom_glink_handle_signals(glink, param1, param2);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			break;
 		default:
 			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
 			ret = -EINVAL;
@@ -1440,6 +1502,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
 	.sendto = qcom_glink_sendto,
 	.trysend = qcom_glink_trysend,
 	.trysendto = qcom_glink_trysendto,
+	.set_flow_control = qcom_glink_set_flow_control,
 };
 
 static void qcom_glink_rpdev_release(struct device *dev)
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 523c98b..cc7a917 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -64,12 +64,14 @@ struct rpmsg_device {
 };
 
 typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
 
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
  * @rpdev: rpmsg channel device
  * @refcount: when this drops to zero, the ept is deallocated
  * @cb: rx callback handler
+ * @flow_cb: remote flow control callback handler
  * @cb_lock: must be taken before accessing/changing @cb
  * @addr: local rpmsg address
  * @priv: private data for the driver's use
@@ -92,6 +94,7 @@ struct rpmsg_endpoint {
 	struct rpmsg_device *rpdev;
 	struct kref refcount;
 	rpmsg_rx_cb_t cb;
+	rpmsg_flowcontrol_cb_t flow_cb;
 	struct mutex cb_lock;
 	u32 addr;
 	void *priv;
@@ -106,6 +109,7 @@ struct rpmsg_endpoint {
  * @probe: invoked when a matching rpmsg channel (i.e. device) is found
  * @remove: invoked when the rpmsg channel is removed
  * @callback: invoked when an inbound message is received on the channel
+ * @flowcontrol: invoked when remote side flow control status is received
  */
 struct rpmsg_driver {
 	struct device_driver drv;
@@ -113,6 +117,7 @@ struct rpmsg_driver {
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
 	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*flowcontrol)(struct rpmsg_device *, void *, bool);
 };
 
 static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
@@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
 ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
 
+int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
+
 #else
 
 static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
@@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	return -ENXIO;
 }
 
+static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
 #endif /* IS_ENABLED(CONFIG_RPMSG) */
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

