Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF1738F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFUTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFUTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:01:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044C1BC1;
        Wed, 21 Jun 2023 12:01:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LIhN49016783;
        Wed, 21 Jun 2023 19:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4R2bJlHYDEGr4/mjxRpMwCImvTQm2+G87251Ne6eFSo=;
 b=GSaSH/F1BOW5jLut88bxvDtuw3Ko+T4kRq1ePI2p+n6M75H2rDimHUNdR4GQ1ftyFt8z
 GcKtLPcf9wsDgzd1G9Wzz5Z6BTEm4gnUkt5lc0nrU3zIFPQYQ9CwQCKYJEGBRoIlnHN5
 lxzt6bjBRYpoganZgSGdBpcOYY4icGS+GOB+I/1dAkriFdosnm/CJw2OzPQEEzVpb/5a
 NzI0f9marJ64JC9Hkp6ZEBWcyR2jWQsTUK8YfE1HmuwBEroGZneQFgNqNgQyv83eBJB4
 S5oOIx2NbBKujW/otdbpc32bEuPNfXrbcUOukRy6tBv4WVZODxDP3VGAJz1jB/KC/DlN 5g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqkh25s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:01:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LJ11nh026648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:01:01 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 12:01:00 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LUT through NVMEM devices
Date:   Wed, 21 Jun 2023 11:59:46 -0700
Message-ID: <20230621185949.2068-3-quic_amelende@quicinc.com>
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
X-Proofpoint-ORIG-GUID: n3BcHyTMgfqA6mNZSHifdpjiySY_VBFg
X-Proofpoint-GUID: n3BcHyTMgfqA6mNZSHifdpjiySY_VBFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=860
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210159
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update leds-qcom-lpg bindings to support LUT patterns through NVMEM
devices.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../bindings/leds/leds-qcom-lpg.yaml          | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index e6f1999cb22f..c9d53820bf83 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -63,6 +63,31 @@ properties:
         - description: dtest line to attach
         - description: flags for the attachment
 
+  nvmem:
+    description: >
+      Phandle(s) of the nvmem device(s) to access the LUT stored in the SDAM module(s).
+      This property is required only when LUT mode is supported and the LUT pattern is
+      stored in SDAM modules instead of a LUT module.
+    minItems: 1
+    maxItems: 2
+
+  nvmem-names:
+    description: >
+      The nvmem device name(s) for the SDAM module(s) where the LUT pattern data is stored.
+      This property is required only when LUT mode is supported with SDAM module instead of
+      LUT module.
+    minItems: 1
+    items:
+      - const: lpg_chan_sdam
+      - const: lut_sdam
+
+  qcom,pbs-client:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      Phandle of the PBS client used for sending the PBS trigger. This property is
+      required when LUT mode is supported and the LUT pattern is stored in a single
+      SDAM module instead of a LUT module.
+
   multi-led:
     type: object
     $ref: leds-class-multicolor.yaml#
@@ -191,4 +216,64 @@ examples:
       compatible = "qcom,pm8916-pwm";
       #pwm-cells = <2>;
     };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pm8350c-pwm";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #pwm-cells = <2>;
+      nvmem-names = "lpg_chan_sdam" , "lut_sdam";
+      nvmem = <&pmk8550_sdam_21 &pmk8550_sdam_22>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_RED>;
+        label = "red";
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        label = "green";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_BLUE>;
+        label = "blue";
+      };
+    };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi632-lpg";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #pwm-cells = <2>;
+      nvmem-names = "lpg_chan_sdam";
+      nvmem = <&pmi632_sdam7>;
+      qcom,pbs-client = <&pmi632_pbs_client3>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_RED>;
+        label = "red";
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        label = "green";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_BLUE>;
+        label = "blue";
+      };
+    };
+
 ...
-- 
2.40.0

