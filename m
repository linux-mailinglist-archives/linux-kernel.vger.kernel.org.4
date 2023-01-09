Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9D66340F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbjAIWiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjAIWiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:38:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF913CD5;
        Mon,  9 Jan 2023 14:38:11 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309MAFWq007787;
        Mon, 9 Jan 2023 22:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xNmq2amEAaDSoGgyKipzBeMrrepKqdha60mmZHAS8mM=;
 b=ZKodMA9Q+E6aQIUMy5KI+605afwjN1sOgFwDqvcRdxWLuG9XYu+LZcH1uSJyoFlm6sF1
 X5SGswFpNdW1GyPhCmcU3JZkK/ycYl4f104cEYpcQCJZjn5VbnJAGQdr4b/3V9EorsaX
 RjJ4SfFdyKYnumxtrITBPZFPFqgkDagyWPhZf3yfhP6g4MwIhkWZFBzyCiffyA+suqZk
 zLhAveVKJjDg5XpL6XiM1kZ+n5oPkHdJ8IhxY7V7e/T3B0p6S57p36izp1XGl7PsmYK/
 J+Ag/zbnk/mjsskZISp/kImCPW6TBLTZ6BJqL9Qq5wmZnqUx4SR1e64EQrfmdv8Rqmle Ig== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0u147d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:38:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309Mc76P001427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:38:07 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:38:06 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Arun Kumar Neelakantam <quic_aneelaka@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rpmsg: glink: Avoid infinite loop on intent for missing channel
Date:   Mon, 9 Jan 2023 14:38:01 -0800
Message-ID: <20230109223801.1706213-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YZ0Yza90uwMSDQFPdzaaRZU9dnscC1jH
X-Proofpoint-ORIG-GUID: YZ0Yza90uwMSDQFPdzaaRZU9dnscC1jH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that an intent advertisement arrives on an unknown channel
the fifo is not advanced, resulting in the same message being handled
over and over.

Fixes: dacbb35e930f ("rpmsg: glink: Receive and store the remote intent buffers")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f36740cb6866..7b1320b1579e 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -946,12 +946,12 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
 	spin_unlock_irqrestore(&glink->idr_lock, flags);
 	if (!channel) {
 		dev_err(glink->dev, "intents for non-existing channel\n");
-		return;
+		goto advance_rx;
 	}
 
 	msg = kmalloc(msglen, GFP_ATOMIC);
 	if (!msg)
-		return;
+		goto advance_rx;
 
 	qcom_glink_rx_peak(glink, msg, 0, msglen);
 
@@ -973,6 +973,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
 	}
 
 	kfree(msg);
+advance_rx:
 	qcom_glink_rx_advance(glink, ALIGN(msglen, 8));
 }
 
-- 
2.37.3

