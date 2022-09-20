Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D36C5BE547
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiITMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiITMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:09:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE16593;
        Tue, 20 Sep 2022 05:09:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBxCQc017423;
        Tue, 20 Sep 2022 12:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=e/ykjhITbC0sm9OGBoU6bdFk8Lu9OILOEC4OtGTqG8I=;
 b=pcuN1YV4t+jbTYWhkphYGnZXzyPD4U/Z5fu67MTcmE3SkkHe1rfyOgU5GVFvg6Udb2lS
 HTUCR3qZ1NyLI8Q/DlJNSigbphkjmbmJke4clj1ag5P/JItva+BKRz1tStDwlzwrlzjG
 A6+CcTkTudliZLKYh0gIHvUQk5yf0w8dBc4NkQ2g+9xilYhYvRQsKi6hrErRyWeg5LkE
 OD02uFHgfsTfvHPdBQiitxxv0AY6/XDds/PW+77BDKlG6ArYpzS05twdF/Q2bygFPgn7
 v/NXslL18rxK4y/RoznRqpwp5JP9bJsC+rqO3+6Mn9UluzahXl60qAxcpedZYlC/M8JZ qA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jqa1k8mn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:29 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KC9SVf017372;
        Tue, 20 Sep 2022 12:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jnqpvh2a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:28 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KC6rDL015012;
        Tue, 20 Sep 2022 12:09:27 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 28KC9RNr017360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:27 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 05:09:24 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Shazad Hussain" <quic_shazhuss@quicinc.com>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v4 2/3] arm64: dts: qcom: sa8295p: move common nodes to dtsi
Date:   Tue, 20 Sep 2022 17:38:01 +0530
Message-ID: <20220920120802.14321-3-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920120802.14321-1-quic_ppareek@quicinc.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MqpBOouXqiVBotnlrIq5GqJAJQCe61Jn
X-Proofpoint-ORIG-GUID: MqpBOouXqiVBotnlrIq5GqJAJQCe61Jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=912
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many ADP boards with lot of common features. Move common
nodes to sa8540p-adp.dtsi file. This will be base for many ADP boards
to be introduced in near future.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 392 +-----------------
 .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     |   0
 2 files changed, 14 insertions(+), 378 deletions(-)
 rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (96%)
 copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (100%)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
dissimilarity index 96%
index ca5f5ad32ce5..c6d5b7644c20 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -1,378 +1,14 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, Linaro Limited
- */
-
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/spmi/spmi.h>
-
-#include "sa8540p.dtsi"
-
-/ {
-	model = "Qualcomm SA8295P ADP";
-	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
-
-	aliases {
-		serial0 = &qup2_uart17;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&apps_rsc {
-	pmm8540-a-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "a";
-
-		vreg_l3a: ldo3 {
-			regulator-name = "vreg_l3a";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1208000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l5a: ldo5 {
-			regulator-name = "vreg_l5a";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l7a: ldo7 {
-			regulator-name = "vreg_l7a";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l13a: ldo13 {
-			regulator-name = "vreg_l13a";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-	};
-
-	pmm8540-c-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "c";
-
-		vreg_l1c: ldo1 {
-			regulator-name = "vreg_l1c";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l2c: ldo2 {
-			regulator-name = "vreg_l2c";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l3c: ldo3 {
-			regulator-name = "vreg_l3c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l4c: ldo4 {
-			regulator-name = "vreg_l4c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1208000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l6c: ldo6 {
-			regulator-name = "vreg_l6c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7c: ldo7 {
-			regulator-name = "vreg_l7c";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l10c: ldo10 {
-			regulator-name = "vreg_l10c";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l17c: ldo17 {
-			regulator-name = "vreg_l17c";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-
-	pmm8540-g-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "g";
-
-		vreg_l3g: ldo3 {
-			regulator-name = "vreg_l3g";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l7g: ldo7 {
-			regulator-name = "vreg_l7g";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l8g: ldo8 {
-			regulator-name = "vreg_l8g";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-	};
-};
-
-&qup2 {
-	status = "okay";
-};
-
-&qup2_uart17 {
-	compatible = "qcom,geni-debug-uart";
-	status = "okay";
-};
-
-&remoteproc_adsp {
-	firmware-name = "qcom/sa8540p/adsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_nsp0 {
-	firmware-name = "qcom/sa8540p/cdsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_nsp1 {
-	firmware-name = "qcom/sa8540p/cdsp1.mbn";
-	status = "okay";
-};
-
-&spmi_bus {
-	pm8450a: pmic@0 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450a_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450c: pmic@4 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x4 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450c_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450e: pmic@8 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x8 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450e_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450g: pmic@c {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0xc SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450g_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-};
-
-&ufs_mem_hc {
-	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l17c>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l6c>;
-	vccq-max-microamp = <900000>;
-
-	status = "okay";
-};
-
-&ufs_mem_phy {
-	vdda-phy-supply = <&vreg_l8g>;
-	vdda-pll-supply = <&vreg_l3g>;
-
-	status = "okay";
-};
-
-&ufs_card_hc {
-	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l10c>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l3c>;
-	vccq-max-microamp = <900000>;
-
-	status = "okay";
-};
-
-&ufs_card_phy {
-	vdda-phy-supply = <&vreg_l8g>;
-	vdda-pll-supply = <&vreg_l3g>;
-
-	status = "okay";
-};
-
-&usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
-	/* TODO: Define USB-C connector properly */
-	dr_mode = "peripheral";
-};
-
-&usb_0_hsphy {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7a>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_0_qmpphy {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	/* TODO: Define USB-C connector properly */
-	dr_mode = "host";
-};
-
-&usb_1_hsphy {
-	vdda-pll-supply = <&vreg_l1c>;
-	vdda18-supply = <&vreg_l7c>;
-	vdda33-supply = <&vreg_l2c>;
-
-	status = "okay";
-};
-
-&usb_1_qmpphy {
-	vdda-phy-supply = <&vreg_l4c>;
-	vdda-pll-supply = <&vreg_l1c>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy0 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy1 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy2 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy3 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_qmpphy0 {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&usb_2_qmpphy1 {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
-/* PINCTRL */
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sa8540p-adp.dtsi"
+
+/ {
+	model = "Qualcomm SA8295P ADP";
+	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
+};
diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi
similarity index 100%
copy from arch/arm64/boot/dts/qcom/sa8295p-adp.dts
copy to arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi
-- 
2.17.1

