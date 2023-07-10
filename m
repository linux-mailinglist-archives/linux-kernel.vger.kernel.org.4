Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0674D3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjGJKiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjGJKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:38:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1CCC;
        Mon, 10 Jul 2023 03:38:07 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AABES2030520;
        Mon, 10 Jul 2023 10:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VcEOrIXnrgQ7Syrp9H4WKh6EvvZP7BoE9m1n0+Q/CbE=;
 b=fgMwhCh1Gs0l0L+SfMMzJ/8X87exBi/CTjlJsRCW39XToRKna3MqTI6A4aruCqJn2q5o
 HvuqhnLR8EradClfzFjf2yq7F/ZL+xTPSH6NRK5DErwI8uivzH9MeGrNBKyzbwMU3uw/
 d/RLDrIYKNSoKP68XWRPrnTZBnqWW3p1I2UQh5JpZEcq1C+sGBCJ/DeLdZPcyZG/r6Ln
 j1IxezEQLBzmJuUWHYiCvUow7Jf+rXzJFzuq1+9zoDPMQbwFZSpyi+UQeadATsWcdGAx
 K/j3by3YF5go55P43eOjdSaJ5EAUraQNQVtxmT5q/OU4sD8z1A2jPOM5ui8IDaMRMVhh 1g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyw1ua24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AAc1eq012815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:01 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:37:56 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 1/6] dt-bindings: thermal: tsens: Add nvmem cells for calibration data
Date:   Mon, 10 Jul 2023 16:07:30 +0530
Message-ID: <20230710103735.1375847-2-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: scTWEqQJ8M4Gs3QxE_13-qnneS268xR7
X-Proofpoint-ORIG-GUID: scTWEqQJ8M4Gs3QxE_13-qnneS268xR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TSENS V2 calibration nvmem cells for IPQ5332

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 .../bindings/thermal/qcom-tsens.yaml          | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 27e9e16e6455..8b7863c3989e 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -91,7 +91,7 @@ properties:
     maxItems: 2
 
   nvmem-cells:
-    oneOf:
+    anyOf:
       - minItems: 1
         maxItems: 2
         description:
@@ -106,9 +106,13 @@ properties:
         description: |
           Reference to nvmem cells for the calibration mode, two calibration
           bases and two cells per each sensor, main and backup copies, plus use_backup cell
+      - maxItems: 17
+        description: |
+          V2 of TSENS, reference to nvmem cells for the calibration mode, two calibration
+          bases and one cell per each sensor
 
   nvmem-cell-names:
-    oneOf:
+    anyOf:
       - minItems: 1
         items:
           - const: calib
@@ -205,6 +209,24 @@ properties:
           - const: s9_p2_backup
           - const: s10_p1_backup
           - const: s10_p2_backup
+      - items:
+          - const: mode
+          - const: base0
+          - const: base1
+          - const: s0_offset
+          - const: s3_offset
+          - const: s4_offset
+          - const: s5_offset
+          - const: s6_offset
+          - const: s7_offset
+          - const: s8_offset
+          - const: s9_offset
+          - const: s10_offset
+          - const: s11_offset
+          - const: s12_offset
+          - const: s13_offset
+          - const: s14_offset
+          - const: s15_offset
 
   "#qcom,sensors":
     description:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

