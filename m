Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E326970E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBNWsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjBNWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:48:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4BA5F0;
        Tue, 14 Feb 2023 14:47:59 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E5d3ru014886;
        Tue, 14 Feb 2023 22:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=9ZHCBVrXO1ZRAdjBuAwrcRgfWtvlRDb+3mwkch+MVAE=;
 b=eFwjnQTCWPPjmDj/RWo6E7ruqBjwF7bHnPUKv4srnZhlpJZIAGTaVWIZ68FnpHRLUwAu
 LLntM14G38tquuOyFeLQ3O98G+iJGo5n2WQkSiu05tCV3vUKgtbmgpkKcmsAa89PReEb
 I6VtuL3KZbRuy3ZMyjTdTCRh3XRYZApSc2cms8HbTcM8Tv3cN+6sNed1gxgHyWdu9aH3
 G1ud3l6mv/u+cwzEmrU/w1HjSFz3O8PIYMy3bxaSKSSQibonmYwPUaivropAQ5G289oS
 QSgysNdb4ELytYEfr2gzY45nQk95qehN2PFcnDIuGVxxAR7C61+c5y6d+tBeVZSREa1p AA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0bk0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 22:47:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EMlrPF020411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 22:47:53 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 14:47:53 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rpmsg: glink: Fix spelling of peek
Date:   Tue, 14 Feb 2023 14:47:46 -0800
Message-ID: <20230214224746.1996130-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: POGxJ5j2cQgRTqKjTaSkVChtIC8Gksxx
X-Proofpoint-ORIG-GUID: POGxJ5j2cQgRTqKjTaSkVChtIC8Gksxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is peeking into the buffers, not peaking. Fix this throughout
the glink drivers.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 14 +++++++-------
 drivers/rpmsg/qcom_glink_native.h |  2 +-
 drivers/rpmsg/qcom_glink_rpm.c    |  4 ++--
 drivers/rpmsg/qcom_glink_smem.c   |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 324c75d59a6f..7a3cac62ecfa 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -274,10 +274,10 @@ static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
 	return glink->rx_pipe->avail(glink->rx_pipe);
 }
 
-static void qcom_glink_rx_peak(struct qcom_glink *glink,
+static void qcom_glink_rx_peek(struct qcom_glink *glink,
 			       void *data, unsigned int offset, size_t count)
 {
-	glink->rx_pipe->peak(glink->rx_pipe, data, offset, count);
+	glink->rx_pipe->peek(glink->rx_pipe, data, offset, count);
 }
 
 static void qcom_glink_rx_advance(struct qcom_glink *glink, size_t count)
@@ -808,7 +808,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 
 	INIT_LIST_HEAD(&dcmd->node);
 
-	qcom_glink_rx_peak(glink, &dcmd->msg, 0, sizeof(dcmd->msg) + extra);
+	qcom_glink_rx_peek(glink, &dcmd->msg, 0, sizeof(dcmd->msg) + extra);
 
 	spin_lock(&glink->rx_lock);
 	list_add_tail(&dcmd->node, &glink->rx_queue);
@@ -841,7 +841,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		return -EAGAIN;
 	}
 
-	qcom_glink_rx_peak(glink, &hdr, 0, sizeof(hdr));
+	qcom_glink_rx_peek(glink, &hdr, 0, sizeof(hdr));
 	chunk_size = le32_to_cpu(hdr.chunk_size);
 	left_size = le32_to_cpu(hdr.left_size);
 
@@ -906,7 +906,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		goto advance_rx;
 	}
 
-	qcom_glink_rx_peak(glink, intent->data + intent->offset,
+	qcom_glink_rx_peek(glink, intent->data + intent->offset,
 			   sizeof(hdr), chunk_size);
 	intent->offset += chunk_size;
 
@@ -973,7 +973,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
 	if (!msg)
 		return;
 
-	qcom_glink_rx_peak(glink, msg, 0, msglen);
+	qcom_glink_rx_peek(glink, msg, 0, msglen);
 
 	for (i = 0; i < count; ++i) {
 		intent = kzalloc(sizeof(*intent), GFP_ATOMIC);
@@ -1030,7 +1030,7 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
 		if (avail < sizeof(msg))
 			break;
 
-		qcom_glink_rx_peak(glink, &msg, 0, sizeof(msg));
+		qcom_glink_rx_peek(glink, &msg, 0, sizeof(msg));
 
 		cmd = le16_to_cpu(msg.cmd);
 		param1 = le16_to_cpu(msg.param1);
diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
index 9462b37eccee..8dbec24de23e 100644
--- a/drivers/rpmsg/qcom_glink_native.h
+++ b/drivers/rpmsg/qcom_glink_native.h
@@ -17,7 +17,7 @@ struct qcom_glink_pipe {
 
 	size_t (*avail)(struct qcom_glink_pipe *glink_pipe);
 
-	void (*peak)(struct qcom_glink_pipe *glink_pipe, void *data,
+	void (*peek)(struct qcom_glink_pipe *glink_pipe, void *data,
 		     unsigned int offset, size_t count);
 	void (*advance)(struct qcom_glink_pipe *glink_pipe, size_t count);
 
diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 5179f834a10f..f94bb7d4f1ec 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -81,7 +81,7 @@ static size_t glink_rpm_rx_avail(struct qcom_glink_pipe *glink_pipe)
 		return head - tail;
 }
 
-static void glink_rpm_rx_peak(struct qcom_glink_pipe *glink_pipe,
+static void glink_rpm_rx_peek(struct qcom_glink_pipe *glink_pipe,
 			      void *data, unsigned int offset, size_t count)
 {
 	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
@@ -333,7 +333,7 @@ static int glink_rpm_probe(struct platform_device *pdev)
 
 	/* Pipe specific accessors */
 	rpm->rx_pipe.native.avail = glink_rpm_rx_avail;
-	rpm->rx_pipe.native.peak = glink_rpm_rx_peak;
+	rpm->rx_pipe.native.peek = glink_rpm_rx_peek;
 	rpm->rx_pipe.native.advance = glink_rpm_rx_advance;
 	rpm->tx_pipe.native.avail = glink_rpm_tx_avail;
 	rpm->tx_pipe.native.write = glink_rpm_tx_write;
diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 05b4fe0a7387..7a982c60a8dd 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -91,7 +91,7 @@ static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
 		return head - tail;
 }
 
-static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
+static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
 			       void *data, unsigned int offset, size_t count)
 {
 	struct glink_smem_pipe *pipe = to_smem_pipe(np);
@@ -324,7 +324,7 @@ struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
 
 	rx_pipe->smem = smem;
 	rx_pipe->native.avail = glink_smem_rx_avail;
-	rx_pipe->native.peak = glink_smem_rx_peak;
+	rx_pipe->native.peek = glink_smem_rx_peek;
 	rx_pipe->native.advance = glink_smem_rx_advance;
 
 	tx_pipe->smem = smem;
-- 
2.25.1

