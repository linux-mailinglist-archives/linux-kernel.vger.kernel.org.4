Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC2663429
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbjAIWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjAIWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:40:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4B13DD2;
        Mon,  9 Jan 2023 14:40:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309KFLl0024402;
        Mon, 9 Jan 2023 22:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Y9T5mXuEeB6ZHBIcoZEDpgHVBZE6CIMC1qry4NKe/sE=;
 b=klCLtulNiMbtEZoGh3oTk1DIzuDqahHdcllN+RxnK/kYqnU88JOkPdrOEnZtC64wyOLI
 +iJ7tQwhdGVc3WlDmTG/s+j8ZdkrQU5LyZNvbaHpPIBCVCqlfEPmnZIQrk9yuiu4b9Zi
 7L7EEyCZhiKPlYg8YJ1pHbo2cePFBuZyMP4FrGpIAp/O2EdUHoUbd0s+D8Em4vKsBQj+
 aZvzSa06vna0DS42S6TccU3f9uktqf3+gL+8k9te2A+qyojG1Q4KGZqieQei7HWSpG+l
 iWAPd7r2F3IXL+yTbYoaupybilk9obG5VnOsrOfGJSxOcNXPav2YXYw45eC5tQgA/yqv eQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0ssh87rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:40:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309Me7Ql027265
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:40:07 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:40:07 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] rpmsg: glink: Extract tx kick operation
Date:   Mon, 9 Jan 2023 14:39:56 -0800
Message-ID: <20230109224001.1706516-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IPNUsT6Ll7ntQkrbwh-_c6G9OLHea3P5
X-Proofpoint-ORIG-GUID: IPNUsT6Ll7ntQkrbwh-_c6G9OLHea3P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090157
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor out the tx kick operations to its own function, in preparation
for pushing the details to the individual transports.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 115c0a1eddb1..5fd8b70271b7 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -303,6 +303,12 @@ static void qcom_glink_tx_write(struct qcom_glink *glink,
 	glink->tx_pipe->write(glink->tx_pipe, hdr, hlen, data, dlen);
 }
 
+static void qcom_glink_tx_kick(struct qcom_glink *glink)
+{
+	mbox_send_message(glink->mbox_chan, NULL);
+	mbox_client_txdone(glink->mbox_chan, 0);
+}
+
 static void qcom_glink_send_read_notify(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
@@ -313,8 +319,7 @@ static void qcom_glink_send_read_notify(struct qcom_glink *glink)
 
 	qcom_glink_tx_write(glink, &msg, sizeof(msg), NULL, 0);
 
-	mbox_send_message(glink->mbox_chan, NULL);
-	mbox_client_txdone(glink->mbox_chan, 0);
+	qcom_glink_tx_kick(glink);
 }
 
 static int qcom_glink_tx(struct qcom_glink *glink,
@@ -355,9 +360,7 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 	}
 
 	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
-
-	mbox_send_message(glink->mbox_chan, NULL);
-	mbox_client_txdone(glink->mbox_chan, 0);
+	qcom_glink_tx_kick(glink);
 
 out:
 	spin_unlock_irqrestore(&glink->tx_lock, flags);
@@ -1046,9 +1049,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 			break;
 		case RPM_CMD_READ_NOTIF:
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
-
-			mbox_send_message(glink->mbox_chan, NULL);
-			mbox_client_txdone(glink->mbox_chan, 0);
+			qcom_glink_tx_kick(glink);
 			break;
 		case RPM_CMD_INTENT:
 			qcom_glink_handle_intent(glink, param1, param2, avail);
-- 
2.37.3

