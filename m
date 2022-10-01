Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426735F1959
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiJADMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiJADHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:52 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAA34734;
        Fri, 30 Sep 2022 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593642; x=1696129642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOScalpbL+4y0Lpsx+kZowKCfEy9BlxhV7SRAQvzu2c=;
  b=KUiY+is3l1kKslJAbwbct9QW47dwlz/sr84tllp+eGh/f91QXPnDJj/9
   W2IGLeXHvF4jNVmZiy3GFlnyl4yc5WcfmZmS5aLJUrAfzLCGBnDPuPZQl
   B0WVRaG0hDU6NPnO0xoOyB6fjZ5c74HMIKoeoeLdIaVzTXwT3y8gl+AOb
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Sep 2022 20:07:18 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:07:18 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:17 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 17/19] arm64: dts: qcom: qdru1000: Add I2C nodes for QUP
Date:   Fri, 30 Sep 2022 20:06:54 -0700
Message-ID: <20221001030656.29365-18-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C nodes to the QUP along with pinconf for these nodes.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdru1000.dtsi | 365 +++++++++++++++++++++++++
 1 file changed, 365 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
index c105bc15995b..40d7cc4c1f3d 100644
--- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
@@ -302,6 +302,132 @@ uart7: serial@99c000 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			i2c1: i2c@984000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x984000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c1_data_clk>;
+				dmas = <&gpi_dma0 0 1 3 64 0>,
+					<&gpi_dma0 1 1 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@988000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x988000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c2_data_clk>;
+				dmas = <&gpi_dma0 0 2 3 64 0>,
+					<&gpi_dma0 1 2 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@98c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x98c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c3_data_clk>;
+				dmas = <&gpi_dma0 0 3 3 64 0>,
+					<&gpi_dma0 1 3 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@990000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x990000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c4_data_clk>;
+				dmas = <&gpi_dma0 0 4 3 64 0>,
+					<&gpi_dma0 1 4 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c5: i2c@994000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x994000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c5_data_clk>;
+				dmas = <&gpi_dma0 0 5 3 64 0>,
+					<&gpi_dma0 1 5 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c6: i2c@998000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x998000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c6_data_clk>;
+				dmas = <&gpi_dma0 0 6 3 64 0>,
+					<&gpi_dma0 1 6 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_1: geniqup@ac0000 {
@@ -316,6 +442,153 @@ qupv3_id_1: geniqup@ac0000 {
 
 			ranges;
 			status = "disabled";
+
+			i2c9: i2c@a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0xa84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0  &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c9_data_clk>;
+				dmas = <&gpi_dma1 0 1 3 64 0>,
+					<&gpi_dma1 1 1 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0xa88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c10_data_clk>;
+				dmas = <&gpi_dma1 0 2 3 64 0>,
+					<&gpi_dma1 1 2 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c11: i2c@a8c000 {
+				compatible = "qcom,i2c-geni";
+				reg = <0x0 0xa8c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c11_data_clk>;
+				dmas = <&gpi_dma1 0 3 3 64 0>,
+					<&gpi_dma1 1 3 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c12: i2c@a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0xa90000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c12_data_clk>;
+				dmas = <&gpi_dma1 0 4 3 64 0>,
+					<&gpi_dma1 1 4 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c13: i2c@a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0xa94000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c13_data_clk>;
+				dmas = <&gpi_dma1 0 5 3 64 0>,
+					<&gpi_dma1 1 5 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c14: i2c@a98000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0xa98000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c14_data_clk>;
+				dmas = <&gpi_dma1 0 6 3 64 0>,
+					<&gpi_dma1 1 6 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c15: i2c@a9c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0xa9c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c15_data_clk>;
+				dmas = <&gpi_dma1 0 7 3 64 0>,
+					<&gpi_dma1 1 7 3 64 0>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 
@@ -381,6 +654,98 @@ rx {
 					bias-disable;
 				};
 			};
+
+			qup_i2c1_data_clk: qup-i2c1-data-clk {
+				pins = "gpio10", "gpio11";
+				function = "qup0_se1_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_data_clk: qup-i2c2-data-clk {
+				pins = "gpio12", "gpio13";
+				function = "qup0_se2_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_data_clk: qup-i2c3-data-clk {
+				pins = "gpio14", "gpio15";
+				function = "qup0_se3_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c4_data_clk: qup-i2c4-data-clk {
+				pins = "gpio16", "gpio17";
+				function = "qup0_se4_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_data_clk: qup-i2c5-data-clk {
+				pins = "gpio130", "gpio131";
+				function = "qup0_se5_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c6_data_clk: qup-i2c6-data-clk {
+				pins = "gpio132", "gpio133";
+				function = "qup0_se6_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c9_data_clk: qup-i2c9-data-clk {
+				pins = "gpio22", "gpio23";
+				function = "qup1_se1_l0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c10_data_clk: qup-i2c10-data-clk {
+				pins = "gpio24", "gpio25";
+				function = "qup1_se2_l0";
+				drive-strength = <2>;
+				bias-pulll-up;
+			};
+
+			qup_i2c11_data_clk: qup-i2c11-data-clk {
+				pins = "gpio26", "gpio27";
+				function = "qup1_se3_l0";
+				drive-strength = <2>;
+				bias-pulll-up;
+			};
+
+			qup_i2c12_data_clk: qup-i2c12-data-clk {
+				pins = "gpio28", "gpio29";
+				function = "qup1_se4_l0";
+				drive-strength = <2>;
+				bias-pulll-up;
+			};
+
+			qup_i2c13_data_clk: qup-i2c13-data-clk {
+				pins = "gpio30", "gpio31";
+				function = "qup1_se5_l0";
+				drive-strength = <2>;
+				bias-pulll-up;
+			};
+
+			qup_i2c14_data_clk: qup-i2c14-data-clk {
+				pins = "gpio34", "gpio35";
+				function = "qup1_se6_l0";
+				drive-strength = <2>;
+				bias-pulll-up;
+			};
+
+			qup_i2c15_data_clk: qup-i2c15-data-clk {
+				pins = "gpio40", "gpio41";
+				function = "qup1_se7_l0";
+				drive-strength = <2>;
+				bias-pulll-up;
+			};
+
 		};
 
 		pdc: interrupt-controller@b220000 {
-- 
2.37.3

