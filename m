Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE85F3092
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJCM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJCM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:57:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16121248DF;
        Mon,  3 Oct 2022 05:57:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293BvE4w009921;
        Mon, 3 Oct 2022 12:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6E2y53fcYi0sCS961cZEEOkEBxqA1NATY5s3m/oCxFw=;
 b=mjR3CH9pN+sYH8xf1WuAvmu6E3YQpI72Vr9YETZGf1lJIJ4oyqpQLg/HWyltleD5MGY3
 kY2HLLT7oJJc1vW2lMsZEnptiLA6VEJk+ulq+8y7WD5zsnf7iXAHUkW6NcHUcvTCAigt
 /9+EGmnhibe47vmAtSOx9ThrubNgqN/14Cjw7kXdhhVzXe7QzdcUJ0R7Cxfr9nPIpDbo
 QSMTNMCaCr6Oc9cv17P8itdYLeGX6d0ln9hifdT/f+xCgTNHoJqIwbKrvqiCAySYu85g
 yf/nrxrArphP1R7AgmoMlgRsn35DuiYjO6LWphTk5dLyik8djvZW2CA+eEc0tM2URkqK Wg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxeugkwhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:57:05 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 293Cv4TC011984;
        Mon, 3 Oct 2022 12:57:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jxemkfmcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:57:04 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 293Cv4T0011978;
        Mon, 3 Oct 2022 12:57:04 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 293Cv4sU011976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:57:04 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 3 Oct 2022 05:57:00 -0700
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
        Brian Masney <bmasney@redhat.com>,
        "Johan Hovold" <johan@kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v5 2/3] arm64: dts: qcom: sa8295p: move common nodes to dtsi
Date:   Mon, 3 Oct 2022 18:24:43 +0530
Message-ID: <20221003125444.12975-4-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221003125444.12975-1-quic_ppareek@quicinc.com>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JHyjRpMJ9zMgzPrCE6c_ND6dnR5MDxld
X-Proofpoint-ORIG-GUID: JHyjRpMJ9zMgzPrCE6c_ND6dnR5MDxld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210030079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many ADP boards with lot of common features. Move common
nodes, like remoteproc, regulators etc. to sa8540p-adp.dtsi file.
This will be base for many ADP boards to be introduced in near future.
Common nodes are like clocks, remoteproc, regulators etc.

The differences between the sa8295 ADP board, and sa8540p ADP board
(Qdrive-3), with respect to device/connector-interface, are as following:

PCIE: pcie nodes are not supported as of now, and will be supported
in subsequent patches.

UFS: Devices ufs_mem_hc and ufs_card_hc, both are mounted on ADP air
board. Whereas, only ufs_mem_hc is only mounted on Qdrive-3.

USB: Devices usb0 and usb2 are present on Qdrive-3 board. Whereas on sa8295
ADP board, usb0, usb1, and usb2 are present. On Qdrive-3, usb2 has only one
port supported(of the external embedded hub). Whereas on sa8295, all four
ports of usb2 are supported.

There are different connectors for ethernet and camera, but connected
to same interface towards soc. So, there is no need of any difference
regarding device tree.

Artificial intelligence chip SA9000P is present only on Qdrive-3 board
as PCIE endpoint.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 528 +++++-------------
 .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     | 133 -----
 2 files changed, 146 insertions(+), 515 deletions(-)
 rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (70%)
 copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (72%)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
dissimilarity index 70%
index b608b82dff03..bf26fe5085bf 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -1,382 +1,146 @@
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
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450a_gpios 0 0 10>;
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
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450c_gpios 0 0 10>;
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
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450e_gpios 0 0 10>;
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
-			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			gpio-ranges = <&pm8450g_gpios 0 0 10>;
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
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l6c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&ufs_card_hc {
+	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l3c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_card_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7a>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "host";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l1c>;
+	vdda18-supply = <&vreg_l7c>;
+	vdda33-supply = <&vreg_l2c>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l4c>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy0 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy1 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy2 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy3 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+/* PINCTRL */
diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi
similarity index 72%
copy from arch/arm64/boot/dts/qcom/sa8295p-adp.dts
copy to arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi
index b608b82dff03..4c36bca2d72d 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi
@@ -13,9 +13,6 @@
 #include "sa8540p.dtsi"
 
 / {
-	model = "Qualcomm SA8295P ADP";
-	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
-
 	aliases {
 		serial0 = &qup2_uart17;
 	};
@@ -245,136 +242,6 @@
 	};
 };
 
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
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
-- 
2.17.1

