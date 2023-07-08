Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CD74BCA5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGHHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGHHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:31:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBF2705;
        Sat,  8 Jul 2023 00:30:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687PCZF027502;
        Sat, 8 Jul 2023 07:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VQ6vGIZBy2Q/ERTkoV4CefPy8cImEpDSqFa7X1e0bvU=;
 b=Qr3YTgcjpLuqr4XYUCX0k6r2E5/X4CXzdSR7kAXcuRyBAiTqRalnLOJQThSPMGwQmXTb
 5RtbEebtYUDZJgxF0mZ3yzH8jP37WV97eXqY1u9/pTMncH8qEqq2HujdPSq5tG0C/3JJ
 t0mxke8O0p0h5uH7iG3wjOGptAcNcWSzjTAPMM78YHopqRzubr6cTzyxno1HfiMmuCXM
 tNAEVEgqz/N/w5y35yaqudbgtcrTZpIv1sj7G02qSdshLlzTMv22IWlMfpCv2LYQUIwZ
 Iloc2GX0h1mktMi7031byPECGeFgvvGIrTUpmzwnKdE/rxpywHtcMuXBqmxN+hEG7KQp Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq13f04my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:29:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687TuoR011771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:29:56 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:29:48 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
Subject: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Date:   Sat, 8 Jul 2023 12:58:30 +0530
Message-ID: <20230708072835.3035398-7-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U7oEr49fHUARJrxt5Y_40EAmv91qglgn
X-Proofpoint-ORIG-GUID: U7oEr49fHUARJrxt5Y_40EAmv91qglgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
going through PBS firmware through a single register interface. This
interface is implemented on an SDAM peripheral on the master PMIC PMK8550
rather than a dedicated ADC peripheral.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 117 ++++++++++++++++--
 .../iio/qcom,spmi-adc5-gen3-pm8550.h          |  48 +++++++
 .../iio/qcom,spmi-adc5-gen3-pm8550b.h         |  97 +++++++++++++++
 .../iio/qcom,spmi-adc5-gen3-pm8550vx.h        |  20 +++
 .../iio/qcom,spmi-adc5-gen3-pmk8550.h         |  54 ++++++++
 include/dt-bindings/iio/qcom,spmi-vadc.h      |  78 ++++++++++++
 6 files changed, 402 insertions(+), 12 deletions(-)
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index eb7d16e385ad..090113e62d52 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -13,8 +13,8 @@ maintainers:
 description: |
   SPMI PMIC voltage ADC (VADC) provides interface to clients to read
   voltage. The VADC is a 15-bit sigma-delta ADC.
-  SPMI PMIC5/PMIC5 Gen2 voltage ADC (ADC) provides interface to clients to read
-  voltage. The VADC is a 16-bit sigma-delta ADC.
+  SPMI PMIC5/PMIC5 Gen2/PMIC5 Gen3 voltage ADC (ADC) provides interface to
+  clients to read voltage. The VADC is a 16-bit sigma-delta ADC.
 
 properties:
   compatible:
@@ -27,10 +27,11 @@ properties:
           - qcom,spmi-adc5
           - qcom,spmi-adc-rev2
           - qcom,spmi-adc5-gen2
+          - qcom,spmi-adc5-gen3
 
   reg:
     description: VADC base address in the SPMI PMIC register map
-    maxItems: 1
+    minItems: 1
 
   '#address-cells':
     const: 1
@@ -38,6 +39,12 @@ properties:
   '#size-cells':
     const: 0
 
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1.
+
   '#io-channel-cells':
     const: 1
 
@@ -71,8 +78,8 @@ patternProperties:
         description: |
           ADC channel number.
           See include/dt-bindings/iio/qcom,spmi-vadc.h
-          For PMIC5 Gen2 ADC, the channel numbers are specified separately per PMIC
-          in the PMIC-specific files in include/dt-bindings/iio/.
+          For PMIC5 Gen2 and PMIC5 Gen3 ADC, the channel numbers are specified separately per
+          PMIC in the PMIC-specific files in include/dt-bindings/iio/.
 
       label:
         $ref: /schemas/types.yaml#/definitions/string
@@ -114,11 +121,12 @@ patternProperties:
               channel calibration. If property is not found, channel will be
               calibrated with 0.625V and 1.25V reference channels, also
               known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2" and
-              "qcom,spmi-adc-rev2", if this property is specified VADC will use
-              the VDD reference (1.875V) and GND for channel calibration. If
-              property is not found, channel will be calibrated with 0V and 1.25V
-              reference channels, also known as absolute calibration.
+            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc5-gen2",
+              "qcom,spmi-adc-rev2" and "qcom,spmi-adc5-gen3", if this property
+              is specified VADC will use the VDD reference (1.875V) and GND for
+              channel calibration. If property is not found, channel will be
+              calibrated with 0V and 1.25V reference channels, also known as
+              absolute calibration.
         type: boolean
 
       qcom,hw-settle-time:
@@ -136,6 +144,12 @@ patternProperties:
             from the ADC that is an average of multiple samples. The value
             selected is 2^(value).
 
+      qcom,adc-tm-type:
+        description: |
+            Indicates if ADC_TM monitoring is done on this channel.
+            Defined for compatible property "qcom,spmi-adc5-gen3".
+        type: boolean
+
     required:
       - reg
 
@@ -213,7 +227,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,spmi-adc5-gen2
+            enum:
+              - qcom,spmi-adc5-gen2
+              - qcom,spmi-adc5-gen3
 
     then:
       patternProperties:
@@ -299,7 +315,7 @@ examples:
                 label = "xo_therm";
             };
 
-            channel@47 {
+            channel@147 {
                 reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
@@ -307,3 +323,80 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h>
+    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      /* VADC node */
+      pmk8550_vadc: vadc@9000 {
+        compatible = "qcom,spmi-adc5-gen3";
+        reg = <0x9000>;
+        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+        #thermal-sensor-cells = <1>;
+
+        /* PMK8550 Channel nodes */
+        channel@3 {
+          reg = <PMK8550_ADC5_GEN3_DIE_TEMP>;
+          label = "pmk8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@44 {
+          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU>;
+          label = "pmk8550_xo_therm";
+          qcom,pre-scaling = <1 1>;
+          qcom,ratiometric;
+          qcom,hw-settle-time = <200>;
+          qcom,adc-tm-type;
+        };
+
+        /* PM8550 Channel nodes */
+        channel@103 {
+          reg = <PM8550_ADC5_GEN3_DIE_TEMP>;
+          label = "pm8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@18e {
+          reg = <PM8550_ADC5_GEN3_VPH_PWR>;
+          label = "pm8550_vph_pwr";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        /* PM8550B Channel nodes */
+        channel@703 {
+          reg = <PM8550B_ADC5_GEN3_DIE_TEMP>;
+          label = "pm8550b_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@78e {
+          reg = <PM8550B_ADC5_GEN3_VPH_PWR>;
+          label = "pm8550b_vph_pwr";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        channel@78f {
+          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG>;
+          label = "pm8550b_vbat_sns_qbg";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        /* PM8550VS_C Channel nodes */
+        channel@203 {
+          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
+          label = "pm8550vs_c_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+      };
+    };
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
new file mode 100644
index 000000000000..74e6e2f6f9ed
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
+
+#ifndef PM8550_SID
+#define PM8550_SID		1
+#endif
+
+/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
+#define PM8550_ADC5_GEN3_OFFSET_REF			(PM8550_SID << 8 | 0x00)
+#define PM8550_ADC5_GEN3_1P25VREF			(PM8550_SID << 8 | 0x01)
+#define PM8550_ADC5_GEN3_VREF_VADC			(PM8550_SID << 8 | 0x02)
+#define PM8550_ADC5_GEN3_DIE_TEMP			(PM8550_SID << 8 | 0x03)
+
+#define PM8550_ADC5_GEN3_AMUX_THM1			(PM8550_SID << 8 | 0x04)
+#define PM8550_ADC5_GEN3_AMUX_THM2			(PM8550_SID << 8 | 0x05)
+#define PM8550_ADC5_GEN3_AMUX_THM3			(PM8550_SID << 8 | 0x06)
+#define PM8550_ADC5_GEN3_AMUX_THM4			(PM8550_SID << 8 | 0x07)
+#define PM8550_ADC5_GEN3_AMUX_THM5			(PM8550_SID << 8 | 0x08)
+#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2		(PM8550_SID << 8 | 0x09)
+#define PM8550_ADC5_GEN3_AMUX1_GPIO3			(PM8550_SID << 8 | 0x0a)
+#define PM8550_ADC5_GEN3_AMUX2_GPIO4			(PM8550_SID << 8 | 0x0b)
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7			(PM8550_SID << 8 | 0x0c)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12			(PM8550_SID << 8 | 0x0d)
+
+/* 100k pull-up */
+#define PM8550_ADC5_GEN3_AMUX_THM1_100K_PU		(PM8550_SID << 8 | 0x44)
+#define PM8550_ADC5_GEN3_AMUX_THM2_100K_PU		(PM8550_SID << 8 | 0x45)
+#define PM8550_ADC5_GEN3_AMUX_THM3_100K_PU		(PM8550_SID << 8 | 0x46)
+#define PM8550_ADC5_GEN3_AMUX_THM4_100K_PU		(PM8550_SID << 8 | 0x47)
+#define PM8550_ADC5_GEN3_AMUX_THM5_100K_PU		(PM8550_SID << 8 | 0x48)
+#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2_100K_PU	(PM8550_SID << 8 | 0x49)
+#define PM8550_ADC5_GEN3_AMUX1_GPIO3_100K_PU		(PM8550_SID << 8 | 0x4a)
+#define PM8550_ADC5_GEN3_AMUX2_GPIO4_100K_PU		(PM8550_SID << 8 | 0x4b)
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7_100K_PU		(PM8550_SID << 8 | 0x4c)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550_SID << 8 | 0x4d)
+
+/* 1/3 Divider */
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7_DIV3		(PM8550_SID << 8 | 0x8c)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12_DIV3		(PM8550_SID << 8 | 0x8d)
+
+#define PM8550_ADC5_GEN3_VPH_PWR			(PM8550_SID << 8 | 0x8e)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
new file mode 100644
index 000000000000..35483dfd970e
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
+
+#ifndef PM8550B_SID
+#define PM8550B_SID		7
+#endif
+
+/* ADC channels for PM8550B_ADC for PMIC5 Gen3 */
+#define PM8550B_ADC5_GEN3_OFFSET_REF			(PM8550B_SID << 8 | 0x00)
+#define PM8550B_ADC5_GEN3_1P25VREF			(PM8550B_SID << 8 | 0x01)
+#define PM8550B_ADC5_GEN3_VREF_VADC			(PM8550B_SID << 8 | 0x02)
+#define PM8550B_ADC5_GEN3_DIE_TEMP			(PM8550B_SID << 8 | 0x03)
+
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM		(PM8550B_SID << 8 | 0x04)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID		(PM8550B_SID << 8 | 0x05)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V		(PM8550B_SID << 8 | 0x06)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM		(PM8550B_SID << 8 | 0x07)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION		(PM8550B_SID << 8 | 0x08)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10		(PM8550B_SID << 8 | 0x09)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1			(PM8550B_SID << 8 | 0x0a)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5			(PM8550B_SID << 8 | 0x0b)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6			(PM8550B_SID << 8 | 0x0c)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12			(PM8550B_SID << 8 | 0x0d)
+
+#define PM8550B_ADC5_GEN3_CHG_TEMP			(PM8550B_SID << 8 | 0x10)
+#define PM8550B_ADC5_GEN3_USB_SNS_V_16			(PM8550B_SID << 8 | 0x11)
+#define PM8550B_ADC5_GEN3_VIN_DIV16_MUX			(PM8550B_SID << 8 | 0x12)
+#define PM8550B_ADC5_GEN3_USBC_MUX			(PM8550B_SID << 8 | 0x13)
+#define PM8550B_ADC5_GEN3_VREF_BAT_THERM		(PM8550B_SID << 8 | 0x15)
+#define PM8550B_ADC5_GEN3_IIN_FB			(PM8550B_SID << 8 | 0x17)
+#define PM8550B_ADC5_GEN3_TEMP_ALARM_LITE		(PM8550B_SID << 8 | 0x18)
+#define PM8550B_ADC5_GEN3_SMB_IIN			(PM8550B_SID << 8 | 0x19)
+#define PM8550B_ADC5_GEN3_VREF_BAT2_THERM		(PM8550B_SID << 8 | 0x1a)
+#define PM8550B_ADC5_GEN3_SMB_ICHG			(PM8550B_SID << 8 | 0x1b)
+#define PM8550B_ADC5_GEN3_SMB_TEMP_I			(PM8550B_SID << 8 | 0x1e)
+#define PM8550B_ADC5_GEN3_CHG_TEMP_I			(PM8550B_SID << 8 | 0x1f)
+#define PM8550B_ADC5_GEN3_ICHG_FB			(PM8550B_SID << 8 | 0xa1)
+
+/* 30k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_30K_PU	(PM8550B_SID << 8 | 0x24)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_30K_PU	(PM8550B_SID << 8 | 0x25)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_30K_PU	(PM8550B_SID << 8 | 0x26)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_30K_PU	(PM8550B_SID << 8 | 0x27)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_30K_PU	(PM8550B_SID << 8 | 0x28)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_30K_PU	(PM8550B_SID << 8 | 0x29)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_30K_PU		(PM8550B_SID << 8 | 0x2a)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_30K_PU		(PM8550B_SID << 8 | 0x2b)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_30K_PU		(PM8550B_SID << 8 | 0x2c)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_30K_PU		(PM8550B_SID << 8 | 0x2d)
+
+#define PM8550B_ADC5_GEN3_USBC_MUX_30K_PU		(PM8550B_SID << 8 | 0x33)
+
+/* 100k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_100K_PU	(PM8550B_SID << 8 | 0x44)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_100K_PU	(PM8550B_SID << 8 | 0x45)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_100K_PU	(PM8550B_SID << 8 | 0x46)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_100K_PU	(PM8550B_SID << 8 | 0x47)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_100K_PU	(PM8550B_SID << 8 | 0x48)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_100K_PU	(PM8550B_SID << 8 | 0x49)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_100K_PU		(PM8550B_SID << 8 | 0x4a)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_100K_PU		(PM8550B_SID << 8 | 0x4b)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_100K_PU		(PM8550B_SID << 8 | 0x4c)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550B_SID << 8 | 0x4d)
+
+#define PM8550B_ADC5_GEN3_USBC_MUX_100K_PU		(PM8550B_SID << 8 | 0x53)
+
+/* 400k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_400K_PU	(PM8550B_SID << 8 | 0x64)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_400K_PU	(PM8550B_SID << 8 | 0x65)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_400K_PU	(PM8550B_SID << 8 | 0x66)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_400K_PU	(PM8550B_SID << 8 | 0x67)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_400K_PU	(PM8550B_SID << 8 | 0x68)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_400K_PU	(PM8550B_SID << 8 | 0x69)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_400K_PU		(PM8550B_SID << 8 | 0x6a)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_400K_PU		(PM8550B_SID << 8 | 0x6b)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_400K_PU		(PM8550B_SID << 8 | 0x6c)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_400K_PU		(PM8550B_SID << 8 | 0x6d)
+
+#define PM8550B_ADC5_GEN3_USBC_MUX_400K_PU		(PM8550B_SID << 8 | 0x73)
+
+/* 1/3 Divider */
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_DIV3		(PM8550B_SID << 8 | 0x8a)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_DIV3		(PM8550B_SID << 8 | 0x8b)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_DIV3		(PM8550B_SID << 8 | 0x8c)
+
+#define PM8550B_ADC5_GEN3_VPH_PWR			(PM8550B_SID << 8 | 0x8e)
+#define PM8550B_ADC5_GEN3_VBAT_SNS_QBG			(PM8550B_SID << 8 | 0x8f)
+#define PM8550B_ADC5_GEN3_VBAT_SNS_CHGR			(PM8550B_SID << 8 | 0x94)
+#define PM8550B_ADC5_GEN3_VBAT_2S_MID_QBG		(PM8550B_SID << 8 | 0x96)
+#define PM8550B_ADC5_GEN3_VBAT_2S_MID_CHGR		(PM8550B_SID << 8 | 0x9d)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
new file mode 100644
index 000000000000..337e13f7f56f
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
+
+/* ADC channels for PM8550VX_ADC for PMIC5 Gen3 */
+#define PM8550VS_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | 0x00)
+#define PM8550VS_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | 0x01)
+#define PM8550VS_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | 0X02)
+#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | 0x03)
+
+#define PM8550VE_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | 0x00)
+#define PM8550VE_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | 0x01)
+#define PM8550VE_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | 0X02)
+#define PM8550VE_ADC5_GEN3_DIE_TEMP(sid)		((sid) << 8 | 0x03)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h
new file mode 100644
index 000000000000..126fc16d5b20
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
+
+#ifndef PMK8550_SID
+#define PMK8550_SID		0
+#endif
+
+/* ADC channels for PMK8550_ADC for PMIC5 Gen3 */
+#define PMK8550_ADC5_GEN3_OFFSET_REF			(PMK8550_SID << 8 | 0x00)
+#define PMK8550_ADC5_GEN3_1P25VREF			(PMK8550_SID << 8 | 0x01)
+#define PMK8550_ADC5_GEN3_VREF_VADC			(PMK8550_SID << 8 | 0x02)
+#define PMK8550_ADC5_GEN3_DIE_TEMP			(PMK8550_SID << 8 | 0x03)
+
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM		(PMK8550_SID << 8 | 0x04)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1		(PMK8550_SID << 8 | 0x05)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2		(PMK8550_SID << 8 | 0x06)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3		(PMK8550_SID << 8 | 0x07)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4		(PMK8550_SID << 8 | 0x08)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5		(PMK8550_SID << 8 | 0x09)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6			(PMK8550_SID << 8 | 0x0a)
+
+/* 30k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_30K_PU	(PMK8550_SID << 8 | 0x24)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_30K_PU	(PMK8550_SID << 8 | 0x25)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_30K_PU	(PMK8550_SID << 8 | 0x26)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_30K_PU	(PMK8550_SID << 8 | 0x27)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_30K_PU	(PMK8550_SID << 8 | 0x28)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_30K_PU	(PMK8550_SID << 8 | 0x29)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_30K_PU		(PMK8550_SID << 8 | 0x2a)
+
+/* 100k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU	(PMK8550_SID << 8 | 0x44)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_100K_PU	(PMK8550_SID << 8 | 0x45)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_100K_PU	(PMK8550_SID << 8 | 0x46)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_100K_PU	(PMK8550_SID << 8 | 0x47)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_100K_PU	(PMK8550_SID << 8 | 0x48)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_100K_PU	(PMK8550_SID << 8 | 0x49)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_100K_PU		(PMK8550_SID << 8 | 0x4a)
+
+/* 400k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_400K_PU	(PMK8550_SID << 8 | 0x64)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_400K_PU	(PMK8550_SID << 8 | 0x65)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_400K_PU	(PMK8550_SID << 8 | 0x66)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_400K_PU	(PMK8550_SID << 8 | 0x67)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_400K_PU	(PMK8550_SID << 8 | 0x68)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_400K_PU	(PMK8550_SID << 8 | 0x69)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_400K_PU		(PMK8550_SID << 8 | 0x6a)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index b1413c62ad27..ca5a0a947b3b 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -298,4 +298,82 @@
 #define ADC5_GEN2_SBUx				0x94
 #define ADC5_GEN2_VBAT_2S_MID			0x96
 
+/* ADC channels for PMIC5 Gen3 */
+
+#define ADC5_GEN3_OFFSET_REF			0x00
+#define ADC5_GEN3_1P25VREF			0x01
+#define ADC5_GEN3_VREF_VADC			0x02
+#define ADC5_GEN3_DIE_TEMP			0x03
+
+#define ADC5_GEN3_AMUX1_THM			0x04
+#define ADC5_GEN3_AMUX2_THM			0x05
+#define ADC5_GEN3_AMUX3_THM			0x06
+#define ADC5_GEN3_AMUX4_THM			0x07
+#define ADC5_GEN3_AMUX5_THM			0x08
+#define ADC5_GEN3_AMUX6_THM			0x09
+#define ADC5_GEN3_AMUX1_GPIO			0x0a
+#define ADC5_GEN3_AMUX2_GPIO			0x0b
+#define ADC5_GEN3_AMUX3_GPIO			0x0c
+#define ADC5_GEN3_AMUX4_GPIO			0x0d
+
+#define ADC5_GEN3_CHG_TEMP			0x10
+#define ADC5_GEN3_USB_SNS_V_16			0x11
+#define ADC5_GEN3_VIN_DIV16_MUX			0x12
+#define ADC5_GEN3_VREF_BAT_THERM		0x15
+#define ADC5_GEN3_IIN_FB			0x17
+#define ADC5_GEN3_TEMP_ALARM_LITE		0x18
+#define ADC5_GEN3_IIN_SMB			0x19
+#define ADC5_GEN3_ICHG_SMB			0x1b
+#define ADC5_GEN3_ICHG_FB			0xa1
+
+/* 30k pull-up1 */
+#define ADC5_GEN3_AMUX1_THM_30K_PU		0x24
+#define ADC5_GEN3_AMUX2_THM_30K_PU		0x25
+#define ADC5_GEN3_AMUX3_THM_30K_PU		0x26
+#define ADC5_GEN3_AMUX4_THM_30K_PU		0x27
+#define ADC5_GEN3_AMUX5_THM_30K_PU		0x28
+#define ADC5_GEN3_AMUX6_THM_30K_PU		0x29
+#define ADC5_GEN3_AMUX1_GPIO_30K_PU		0x2a
+#define ADC5_GEN3_AMUX2_GPIO_30K_PU		0x2b
+#define ADC5_GEN3_AMUX3_GPIO_30K_PU		0x2c
+#define ADC5_GEN3_AMUX4_GPIO_30K_PU		0x2d
+
+/* 100k pull-up2 */
+#define ADC5_GEN3_AMUX1_THM_100K_PU		0x44
+#define ADC5_GEN3_AMUX2_THM_100K_PU		0x45
+#define ADC5_GEN3_AMUX3_THM_100K_PU		0x46
+#define ADC5_GEN3_AMUX4_THM_100K_PU		0x47
+#define ADC5_GEN3_AMUX5_THM_100K_PU		0x48
+#define ADC5_GEN3_AMUX6_THM_100K_PU		0x49
+#define ADC5_GEN3_AMUX1_GPIO_100K_PU		0x4a
+#define ADC5_GEN3_AMUX2_GPIO_100K_PU		0x4b
+#define ADC5_GEN3_AMUX3_GPIO_100K_PU		0x4c
+#define ADC5_GEN3_AMUX4_GPIO_100K_PU		0x4d
+
+/* 400k pull-up3 */
+#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
+#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
+#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
+#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
+#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
+#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
+#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
+#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
+#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
+#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
+
+/* 1/3 Divider */
+#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
+#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
+#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c
+
+#define ADC5_GEN3_VPH_PWR			0x8e
+#define ADC5_GEN3_VBAT_SNS_QBG			0x8f
+
+#define ADC5_GEN3_VBAT_SNS_CHGR			0x94
+#define ADC5_GEN3_VBAT_2S_MID_QBG		0x96
+#define ADC5_GEN3_VBAT_2S_MID_CHGR		0x9d
+
+#define ADC5_GEN3_OFFSET_EXT2			0xf8
+
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
2.25.1

