Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83FB6E698F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjDRQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjDRQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:30:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606C72A8;
        Tue, 18 Apr 2023 09:30:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEmZlt002565;
        Tue, 18 Apr 2023 16:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ax9Qp5WIkTCqs0jQ/m2UVDmnzSC5x5toDbw05//u7zI=;
 b=B+LPDNnRBNvqNO6+6C/ZXLpOvLwmC0BMIup0lWHb0ZO49ljwAaHoP2FMb2+V0CtOnLtE
 6xF5tG8esJ4SSJMTeAQrZQGkWek27Ocsrfox2rBrM7if5Nof3t/HkjoTu83GRLorScRa
 EpuJQcK4BO+SkQapuJgQY7LgIyMtldYyBqP7aRbNkiWZwK+VLAuA0W1xk6bFvVR8lyfh
 O4nlof+JjqiRjPNvJLMUQ7UVqh1aIpIjH8mYHyWaAq+ff8PNre+TgUHWEhYGlCa1FE9c
 QyeXiKPLq7sIIEg2stHisMVwHrZWyyV5y09ZSWiHM1vwsrrCJGziz9RrEMPmoTN/wd3S 7Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nr5hf2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 16:30:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IGUO6L013560
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 16:30:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 09:30:23 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] rpmsg: glink: Propagate TX failures in intentless mode as well
Date:   Tue, 18 Apr 2023 09:30:17 -0700
Message-ID: <20230418163018.785524-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418163018.785524-1-quic_bjorande@quicinc.com>
References: <20230418163018.785524-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RUFQwkd6oDNnoaR1kNHCdmULZO3vbUo_
X-Proofpoint-ORIG-GUID: RUFQwkd6oDNnoaR1kNHCdmULZO3vbUo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180137
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As support for splitting transmission over several messages using
TX_DATA_CONT was introduced it does not immediately return the return
value of qcom_glink_tx().

The result is that in the intentless case (i.e. intent == NULL), the
code will continue to send all additional chunks. This is wasteful, and
it's possible that the send operation could incorrectly indicate
success, if the last chunk fits in the TX fifo.

Fix the condition.

Fixes: 8956927faed3 ("rpmsg: glink: Add TX_DATA_CONT command while sending")
Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Picked up Chris
- Added another 's' in transmission

 drivers/rpmsg/qcom_glink_native.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 01d2805fe30f..62634d020d13 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1356,8 +1356,9 @@ static int __qcom_glink_send(struct glink_channel *channel,
 	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
 
 	/* Mark intent available if we failed */
-	if (ret && intent) {
-		intent->in_use = false;
+	if (ret) {
+		if (intent)
+			intent->in_use = false;
 		return ret;
 	}
 
@@ -1378,8 +1379,9 @@ static int __qcom_glink_send(struct glink_channel *channel,
 				    chunk_size, wait);
 
 		/* Mark intent available if we failed */
-		if (ret && intent) {
-			intent->in_use = false;
+		if (ret) {
+			if (intent)
+				intent->in_use = false;
 			break;
 		}
 	}
-- 
2.25.1

