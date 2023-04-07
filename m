Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83126DB68B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDGWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDGWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:39:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E50BB8E;
        Fri,  7 Apr 2023 15:39:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337MLQn6012196;
        Fri, 7 Apr 2023 22:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=22zcGHEN9yVoDkpZ+oZ5YzXYhsotUOtbjRPKgFsuwgg=;
 b=i4eAQi5upeFQsiuB/xJIjuLutcgJrqbyWiz2WCxRL8wvQwdHqbv8Kmm/139SywBdi7fA
 8yo/xMXYfs4YOvucVWVu36Z00TiMKowjM6YHZJCxc6prMD7w4KSRazkrCLO9nFdUUYKN
 zuT0vQy5cAx3ag2wY2nfv4czqu7T0jhwVbSUw8ebVi1/Pd3gwHV5H1oVrDMqnjQHWj15
 aWszqAU7+RfhXjNrkDcLZMN5ahFWB4c4yhhHHr/eVM9tcH8HAAseUZ5Yri3rPs22/6OW
 zui42l1UFTAYMzXRZbujM9ioX9I28QNmwzfRKm95WwtOQ/NkoeA1wOWG7J7pGdw2DPLA EQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptd5ct0rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 22:39:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337MdFQk003455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 22:39:15 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 15:39:14 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 3/3] leds: rgb: leds-qcom-lpg: Add support for PMK8550 PWM
Date:   Fri, 7 Apr 2023 15:38:49 -0700
Message-ID: <20230407223849.17623-4-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230407223849.17623-1-quic_amelende@quicinc.com>
References: <20230407223849.17623-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QE3nRtHRTnbtm0a45k4ydKUWkQirBYh5
X-Proofpoint-ORIG-GUID: QE3nRtHRTnbtm0a45k4ydKUWkQirBYh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=885 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070204
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pmk8550 compatible and lpg_data.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 373bcf8ebb52..55a037234df1 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1490,6 +1490,14 @@ static const struct lpg_data pm8350c_pwm_data = {
 	},
 };
 
+static const struct lpg_data pmk8550_pwm_data = {
+	.num_channels = 2,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xe800 },
+		{ .base = 0xe900 },
+	},
+};
+
 static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
 	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
@@ -1500,6 +1508,7 @@ static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
 	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
 	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },
+	{ .compatible = "qcom,pmk8550-pwm", .data = &pmk8550_pwm_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, lpg_of_table);
-- 
2.40.0

