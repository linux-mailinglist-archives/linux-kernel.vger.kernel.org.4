Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A840694BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBMPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:52:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A51A665;
        Mon, 13 Feb 2023 07:52:25 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DE3R6R017636;
        Mon, 13 Feb 2023 15:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zJ+9aePAzG2OB/TDji5cRHGTMJtKEtO6/Bwc5MijWvg=;
 b=gNGTqdQASymCqvgxM1X/qzCJUSfUuD4LCFRrxtY/faHpzgtnMTjRrk7eNUyripnf0xZt
 ZroER7IBvA+KssjK78FVeSfshKygdCstrQMuWPzHo/xH92tfpyJUFDr79+Ca6wtobact
 mbRTFNr3ZOMmSc2isKYRJHGWFZvoZJL4nNJREp/pcn39vNBS+dK/XZZnz+ikyNb5vTzH
 YOhOQ1GZm56AwCdKYlO2zO80LaRqEyrXiZK4fzMt+m+ON84uVlZSsG35qBKEzKc2WQgd
 BhBUdfr+f2vlWaTSKY3IpgV0dSdDmvlqA2lJbfa0s4jeYOxRaHkatZn2O5RyVcQaJmf7 hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmg709-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DFqL2N001582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 07:52:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] rpmsg: glink: Extract tx kick operation
Date:   Mon, 13 Feb 2023 07:52:10 -0800
Message-ID: <20230213155215.1237059-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
References: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g4Da9XEikKjCiwbWUl5531pt8Q-n78FM
X-Proofpoint-GUID: g4Da9XEikKjCiwbWUl5531pt8Q-n78FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor out the tx kick operations to its own function, in preparation
for pushing the details to the individual transports.

Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- None

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
2.25.1

