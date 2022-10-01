Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8C5F1957
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiJADML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiJADHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:52 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD4CE006F;
        Fri, 30 Sep 2022 20:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593643; x=1696129643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PdRmZ/vGgi027rBd6dqBs8YlVsMKGxgaK61RByW6hUE=;
  b=csf83xMTerdXWTedLZuUywyggQJoi6hsCkh2b+2yGBVgrbwwCF+RAIyl
   DlG5FkSdPlagAfftBLZU0gIO2Dhi0+/oE2CkRMJvWPfya6eOjp8N7xT5a
   GCyBH52iAECqu7dYr/XAv9D/IS4zYAZVreRGg+9AqctfPJBl8SfkugMry
   I=;
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
Subject: [PATCH 18/19] arm64: dts: qcom: qdru1000: Add SPI devices to QUP nodes
Date:   Fri, 30 Sep 2022 20:06:55 -0700
Message-ID: <20221001030656.29365-19-quic_molvera@quicinc.com>
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

Add SPI devices to the QUP nodes for the QDU1000 and QRU1000 SoCs.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdru1000.dtsi | 441 +++++++++++++++++++++++++
 1 file changed, 441 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
index 40d7cc4c1f3d..930bb8c8ba5b 100644
--- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
@@ -428,6 +428,132 @@ i2c6: i2c@998000 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			spi1: spi@984000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x984000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi1_data_clk>, <&qup_spi1_cs>;
+				dmas = <&gpi_dma0 0 1 1 64 0>,
+					<&gpi_dma0 1 1 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi2: spi@988000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x988000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
+				dmas = <&gpi_dma0 0 2 1 64 0>,
+					<&gpi_dma0 1 2 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi3: spi@98c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x98c000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi3_data_clk>, <&qup_spi3_cs>;
+				dmas = <&gpi_dma0 0 3 1 64 0>,
+					<&gpi_dma0 1 3 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi4: spi@990000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x990000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>;
+				dmas = <&gpi_dma0 0 4 1 64 0>,
+					<&gpi_dma0 1 4 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi5: spi@994000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x994000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>;
+				dmas = <&gpi_dma0 0 5 1 64 0>,
+					<&gpi_dma0 1 5 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi6: spi@998000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x998000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>,
+				<&system_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
+				dmas = <&gpi_dma0 0 6 1 64 0>,
+					<&gpi_dma0 1 6 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_1: geniqup@ac0000 {
@@ -589,6 +715,153 @@ i2c15: i2c@a9c000 {
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			spi9: spi@a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa84000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi9_data_clk>, <&qup_spi9_cs>;
+				dmas = <&gpi_dma1 0 1 1 64 0>,
+					<&gpi_dma1 1 1 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi10: spi@a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa88000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi10_data_clk>, <&qup_spi10_cs>;
+				dmas = <&gpi_dma1 0 2 1 64 0>,
+					<&gpi_dma1 1 2 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi11: spi@a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa8c000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi11_data_clk>, <&qup_spi11_cs>;
+				dmas = <&gpi_dma1 0 3 1 64 0>,
+					<&gpi_dma1 1 3 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi12: spi@a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa90000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi12_data_clk>, <&qup_spi12_cs>;
+				dmas = <&gpi_dma1 0 4 1 64 0>,
+					<&gpi_dma1 1 4 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi13: spi@a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa94000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi13_data_clk>, <&qup_spi13_cs>;
+				dmas = <&gpi_dma1 0 5 1 64 0>,
+					<&gpi_dma1 1 5 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi14: spi@a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa98000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi14_data_clk>, <&qup_spi14_cs>;
+				dmas = <&gpi_dma1 0 6 1 64 0>,
+					<&gpi_dma1 1 6 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi15: spi@a9c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0xa9c000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				interconnects =
+				<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_1 0>,
+				<&system_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi15_data_clk>, <&qup_spi15_cs>;
+				dmas = <&gpi_dma1 0 7 1 64 0>,
+					<&gpi_dma1 1 7 1 64 0>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
 		};
 
 
@@ -746,6 +1019,174 @@ qup_i2c15_data_clk: qup-i2c15-data-clk {
 				bias-pulll-up;
 			};
 
+			qup_spi1_data_clk: qup-spi1-data-clk {
+				pins = "gpio10", "gpio11", "gpio12";
+				function = "qup0_se1_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi1_cs: qup-spi1-cs {
+				pins = "gpio13";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_data_clk: qup-spi2-data-clk {
+				pins = "gpio12", "gpio13", "gpio10";
+				function = "qup0_se2_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_cs: qup-spi2-cs {
+				pins = "gpio11";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi3_data_clk: qup-spi3-data-clk {
+				pins = "gpio14", "gpio15", "gpio16";
+				function = "qup0_se3_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi3_cs: qup-spi3-cs {
+				pins = "gpio17";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi4_data_clk: qup-spi4-data-clk {
+				pins = "gpio16", "gpio17", "gpio14";
+				function = "qup0_se4_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi4_cs: qup-spi4-cs {
+				pins = "gpio15";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_data_clk: qup-spi5-data-clk {
+				pins = "gpio130", "gpio131", "gpio132";
+				function = "qup0_se5_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_cs: qup-spi5-cs {
+				pins = "gpio133";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_data_clk: qup-spi6-data-clk {
+				pins = "gpio132", "gpio133", "gpio130";
+				function = "qup0_se6_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_cs: qup-spi6-cs {
+				pins = "gpio131";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi9_data_clk: qup-spi9-data-clk {
+				pins = "gpio22", "gpio23", "gpio24";
+				function = "qup1_se1_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi9_cs: qup-spi9-cs {
+				pins = "gpio25";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi10_data_clk: qup-spi10-data-clk {
+				pins = "gpio24", "gpio25", "gpio22";
+				function = "qup1_se2_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi10_cs: qup-spi10-cs {
+				pins = "gpio23";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi11_data_clk: qup-spi11-data-clk {
+				pins = "gpio26", "gpio27", "gpio28";
+				function = "qup1_se3_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi11_cs: qup-spi11-cs {
+				pins = "gpio29";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi12_data_clk: qup-spi12-data-clk {
+				pins = "gpio28", "gpio29", "gpio26";
+				function = "qup1_se4_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi12_cs: qup-spi12-cs {
+				pins = "gpio27";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi13_data_clk: qup-spi13-data-clk {
+				pins = "gpio30", "gpio31", "gpio32";
+				function = "qup1_se5_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi13_cs: qup-spi13-cs {
+				pins = "gpio33";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi14_data_clk: qup-spi14-data-clk {
+				pins = "gpio34", "gpio35", "gpio36";
+				function = "qup1_se6_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi14_cs: qup-spi14-cs {
+				pins = "gpio37", "gpio38";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi15_data_clk: qup-spi15-data-clk {
+				pins = "gpio40", "gpio41", "gpio30";
+				function = "qup1_se7_l0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi15_cs: qup-spi15-cs {
+				pins = "gpio31";
+				drive-strength = <6>;
+				bias-disable;
+			};
 		};
 
 		pdc: interrupt-controller@b220000 {
-- 
2.37.3

