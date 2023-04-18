Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E36E6992
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjDRQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjDRQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:30:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51BDBB8A;
        Tue, 18 Apr 2023 09:30:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFWfCS000444;
        Tue, 18 Apr 2023 16:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wZ0rGPFPTFGz8DAl++2R27HZq3ugJ227uzKZXB7lr2s=;
 b=oAgEKkam8iIy0SBLTCCqi/g4cGCx/5Pd7zkOJS0lEdT1N8gLg8OWJKMtEM+y2oNjJcsg
 kJyIL1v1e/uwxYPT828KImPfJq/cfsNLU8VkA+LZDNXpHj6FWckQt5oVwaaDas/HaHGa
 v0Nwbc8O4to/lgPJNfyqAuQaDYU1p1i2829F8pi8VofQEoSuGgG9OT1B9/cYJPWS0HT8
 SQMY4tRJeo8OyAf9mdHaeY0cZal0eR1OIV89J3fRVyWqwKxC3Y9Zo1oQyCIgRmnG8qk5
 n8gN81qZ3ZKKYJmpAbxorxdeEAxqszJTC7UdShnLkN4nWMsiHgFKMtIkTokkmZZ3ueJm iA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1wxk053d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 16:30:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IGUOSa029617
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
Subject: [PATCH v2 2/2] rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT
Date:   Tue, 18 Apr 2023 09:30:18 -0700
Message-ID: <20230418163018.785524-3-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: o7YpuMgtmsAqu8SSaZrygnUkZGomf_7T
X-Proofpoint-ORIG-GUID: o7YpuMgtmsAqu8SSaZrygnUkZGomf_7T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than duplicating most of the code for constructing the initial
TX_DATA and subsequent TX_DATA_CONT packets, roll them into a single
loop.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Reduced unnecessary complexity in the chunking condition

 drivers/rpmsg/qcom_glink_native.c | 46 +++++++++----------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 62634d020d13..7e6fad4e02f8 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1309,7 +1309,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
 	int ret;
 	unsigned long flags;
 	int chunk_size = len;
-	int left_size = 0;
+	size_t offset = 0;
 
 	if (!glink->intentless) {
 		while (!intent) {
@@ -1343,49 +1343,29 @@ static int __qcom_glink_send(struct glink_channel *channel,
 		iid = intent->id;
 	}
 
-	if (wait && chunk_size > SZ_8K) {
-		chunk_size = SZ_8K;
-		left_size = len - chunk_size;
-	}
-	req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
-	req.msg.param1 = cpu_to_le16(channel->lcid);
-	req.msg.param2 = cpu_to_le32(iid);
-	req.chunk_size = cpu_to_le32(chunk_size);
-	req.left_size = cpu_to_le32(left_size);
-
-	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
-
-	/* Mark intent available if we failed */
-	if (ret) {
-		if (intent)
-			intent->in_use = false;
-		return ret;
-	}
-
-	while (left_size > 0) {
-		data = (void *)((char *)data + chunk_size);
-		chunk_size = left_size;
-		if (chunk_size > SZ_8K)
+	while (offset < len) {
+		chunk_size = len - offset;
+		if (chunk_size > SZ_8K && wait)
 			chunk_size = SZ_8K;
-		left_size -= chunk_size;
 
-		req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA_CONT);
+		req.msg.cmd = cpu_to_le16(offset == 0 ? GLINK_CMD_TX_DATA : GLINK_CMD_TX_DATA_CONT);
 		req.msg.param1 = cpu_to_le16(channel->lcid);
 		req.msg.param2 = cpu_to_le32(iid);
 		req.chunk_size = cpu_to_le32(chunk_size);
-		req.left_size = cpu_to_le32(left_size);
+		req.left_size = cpu_to_le32(len - offset - chunk_size);
 
-		ret = qcom_glink_tx(glink, &req, sizeof(req), data,
-				    chunk_size, wait);
-
-		/* Mark intent available if we failed */
+		ret = qcom_glink_tx(glink, &req, sizeof(req), data + offset, chunk_size, wait);
 		if (ret) {
+			/* Mark intent available if we failed */
 			if (intent)
 				intent->in_use = false;
-			break;
+			return ret;
 		}
+
+		offset += chunk_size;
 	}
-	return ret;
+
+	return 0;
 }
 
 static int qcom_glink_send(struct rpmsg_endpoint *ept, void *data, int len)
-- 
2.25.1

