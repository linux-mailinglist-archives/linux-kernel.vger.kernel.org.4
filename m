Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD6738F84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFUTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFUTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:01:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08411BD6;
        Wed, 21 Jun 2023 12:01:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LIqlOm014652;
        Wed, 21 Jun 2023 19:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=f0GzBG0VXk0mATNhItx/xDbe9tbE8kumnYhPNayn65s=;
 b=gLTzhayL01P5p9kMY8vkyKkWcRX0lU633IoClvT/4vXbluZC1FHKVb4C1Hyy/3Kxp9vt
 HP8G+Srg8pHQd0MPRUhIOnm7T6WpF8G63WhxTC5xYB2sLLVPI6xtFHd7dY84FNuiesV/
 +NBRv8G0lBa8P55/uqjMTVJvT0oWVZvqCXTbsF7I6k2j7tlQpYlKrUm3Xv3QmHdCcpLd
 6uf0xSBuIiAoHtBnDfs37ZfsKX7WJ8OEssALweGWNbQxgT2vGM9D3SW+RQe9Em1D8qjP
 Dw5K5ECBL6U5+Gms0MhZcvp+NDQ4uc53jqj5q1DK2B+eueviho6bXGXZQk1ITXogT+2e /w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbwvm9es2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:01:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LJ15Lb031498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:01:05 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 12:01:04 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
Date:   Wed, 21 Jun 2023 11:59:49 -0700
Message-ID: <20230621185949.2068-6-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621185949.2068-1-quic_amelende@quicinc.com>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R5d7VO1bbrF4Djl3Hf6Gqxy4lL-PSibR
X-Proofpoint-GUID: R5d7VO1bbrF4Djl3Hf6Gqxy4lL-PSibR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=961 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pmi632 lpg_data struct so that pmi632 devices use PPG
for LUT pattern.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index b60d920c67c4..ac814a509781 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1679,11 +1679,15 @@ static const struct lpg_data pm8994_lpg_data = {
 static const struct lpg_data pmi632_lpg_data = {
 	.triled_base = 0xd000,
 
+	.lut_size = 64,
+	.lut_sdam_base = 0x80,
+	.nvmem_count = 1,
+
 	.num_channels = 5,
 	.channels = (const struct lpg_channel_data[]) {
-		{ .base = 0xb300, .triled_mask = BIT(7) },
-		{ .base = 0xb400, .triled_mask = BIT(6) },
-		{ .base = 0xb500, .triled_mask = BIT(5) },
+		{ .base = 0xb300, .triled_mask = BIT(7), .sdam_offset = 0x48 },
+		{ .base = 0xb400, .triled_mask = BIT(6), .sdam_offset = 0x56 },
+		{ .base = 0xb500, .triled_mask = BIT(5), .sdam_offset = 0x64 },
 		{ .base = 0xb600 },
 		{ .base = 0xb700 },
 	},
-- 
2.40.0

