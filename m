Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9F62401D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKJKiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKJKiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:38:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DA29D;
        Thu, 10 Nov 2022 02:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39E1EB8216D;
        Thu, 10 Nov 2022 10:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00303C433D7;
        Thu, 10 Nov 2022 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668076698;
        bh=c+ZtY5kOZR6lF5AkKnagE/BaeMES7RThURN3FMOvs6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5MTpzFUGQzhQ/QtpP+6W9xbxNk0W/Sn22ZZ3kmjoFOVjwfupgVbNEPb6EC3O1Lkh
         +nJsoiaVHWZUvLeihJPI0DxCMawAmye/LZVzIoVWMKlfHShepdnmPpxfkZlWKumf77
         HKEo5YeayIWSyHD9YZMQanM2hw5nsV9kTUxYk3oqBcYsIAbv2camta/3LRrbfg2I+v
         S5YWVv9tDcAo3su9cTSOqsPQzG+xJMZq6BCVK1f0R9HUOrfN6P/ycRpomv6FV8bGWO
         f52Tz58PhKcS9ynTSj6El7w4N1o1PfLPlaU3h2JzSz0iXVx35Gtoyw3ewShSNYpT0l
         32/EiIkfJ4dDQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ot4wQ-0003LP-PA; Thu, 10 Nov 2022 11:37:50 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/9] arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes
Date:   Thu, 10 Nov 2022 11:35:50 +0100
Message-Id: <20221110103558.12690-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221110103558.12690-1-johan+linaro@kernel.org>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280XP platform has seven PCIe controllers:

	PCIe0	USB4
	PCIe1	USB4
	PCIe2A	4-lane
	PCIe2B	2-lane
	PCIe3A	4-lane
	PCIe3B	2-lane
	PCIe4	1-lane

while SA8540P only has five (PCIe2-4).

Add devicetree nodes for the PCIe2-4 controllers and their PHYs.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi  |  59 +++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 493 ++++++++++++++++++++++++-
 2 files changed, 547 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 8ea2886fbab2..01a24b6a5e6d 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -128,6 +128,65 @@ opp-2592000000 {
 	};
 };
 
+&pcie2a {
+	compatible = "qcom,pcie-sa8540p";
+
+	linux,pci-domain = <0>;
+
+	interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+};
+
+&pcie2b {
+	compatible = "qcom,pcie-sa8540p";
+
+	linux,pci-domain = <1>;
+
+	interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+};
+
+&pcie3a {
+	compatible = "qcom,pcie-sa8540p";
+	reg = <0x0 0x01c10000 0x0 0x3000>,
+	      <0x0 0x40000000 0x0 0xf1d>,
+	      <0x0 0x40000f20 0x0 0xa8>,
+	      <0x0 0x40001000 0x0 0x1000>,
+	      <0x0 0x40100000 0x0 0x100000>;
+	reg-names = "parf", "dbi", "elbi", "atu", "config";
+
+	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+		 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1d00000>;
+
+	linux,pci-domain = <2>;
+
+	interrupts =  <GIC_SPI 567 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+
+	interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 541 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 2 &intc 0 0 GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 3 &intc 0 0 GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH>,
+			<0 0 0 4 &intc 0 0 GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&pcie3b {
+	compatible = "qcom,pcie-sa8540p";
+
+	linux,pci-domain = <3>;
+
+	interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+};
+
+&pcie4 {
+	compatible = "qcom,pcie-sa8540p";
+
+	linux,pci-domain = <4>;
+
+	interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+};
+
 &rpmhpd {
 	compatible = "qcom,sa8540p-rpmhpd";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 6bc12e507d21..27f5c2f82338 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -729,11 +729,11 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie2a_phy>,
+				 <&pcie2b_phy>,
+				 <&pcie3a_phy>,
+				 <&pcie3b_phy>,
+				 <&pcie4_phy>,
 				 <0>,
 				 <0>;
 			power-domains = <&rpmhpd SC8280XP_CX>;
@@ -839,6 +839,489 @@ qup1: geniqup@ac0000 {
 			status = "disabled";
 		};
 
+		pcie4: pcie@1c00000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sc8280xp";
+			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x30000000 0x0 0xf1d>,
+			      <0x0 0x30000f20 0x0 0xa8>,
+			      <0x0 0x30001000 0x0 0x1000>,
+			      <0x0 0x30100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x30200000 0x0 0x30200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
+
+			linux,pci-domain = <6>;
+			num-lanes = <1>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
+				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_4_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_4_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_4_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE4_QX_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr_4",
+				      "noc_aggr_south_sf",
+				      "cnoc_qx";
+
+			assigned-clocks = <&gcc GCC_PCIE_4_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre2_noc MASTER_PCIE_4 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_4 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_4_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_4_GDSC>;
+
+			phys = <&pcie4_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie4_phy: phy@1c06000 {
+			compatible = "qcom,sc8280xp-qmp-gen3x1-pcie-phy";
+			reg = <0x0 0x01c06000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
+				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_4_CLKREF_CLK>,
+				 <&gcc GCC_PCIE4_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_4_PIPE_CLK>,
+				 <&gcc GCC_PCIE_4_PIPEDIV2_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe", "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE4_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_4_GDSC>;
+
+			resets = <&gcc GCC_PCIE_4_PHY_BCR>;
+			reset-names = "phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_4_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie3b: pcie@1c08000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sc8280xp";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x32000000 0x0 0xf1d>,
+			      <0x0 0x32000f20 0x0 0xa8>,
+			      <0x0 0x32001000 0x0 0x1000>,
+			      <0x0 0x32100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
+
+			linux,pci-domain = <5>;
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 526 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_3B_AUX_CLK>,
+				 <&gcc GCC_PCIE_3B_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_3B_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_3B_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_3B_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr_4",
+				      "noc_aggr_south_sf";
+
+			assigned-clocks = <&gcc GCC_PCIE_3B_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre2_noc MASTER_PCIE_3B 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_3B 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_3B_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_3B_GDSC>;
+
+			phys = <&pcie3b_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie3b_phy: phy@1c0e000 {
+			compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy";
+			reg = <0x0 0x01c0e000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_3B_AUX_CLK>,
+				 <&gcc GCC_PCIE_3B_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_3A3B_CLKREF_CLK>,
+				 <&gcc GCC_PCIE3B_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_3B_PIPE_CLK>,
+				 <&gcc GCC_PCIE_3B_PIPEDIV2_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe", "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE3B_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_3B_GDSC>;
+
+			resets = <&gcc GCC_PCIE_3B_PHY_BCR>;
+			reset-names = "phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_3b_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie3a: pcie@1c10000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sc8280xp";
+			reg = <0x0 0x01c10000 0x0 0x3000>,
+			      <0x0 0x34000000 0x0 0xf1d>,
+			      <0x0 0x34000f20 0x0 0xa8>,
+			      <0x0 0x34001000 0x0 0x1000>,
+			      <0x0 0x34100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x34200000 0x0 0x34200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
+
+			linux,pci-domain = <4>;
+			num-lanes = <4>;
+
+			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_3A_AUX_CLK>,
+				 <&gcc GCC_PCIE_3A_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_3A_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_3A_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_3A_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr_4",
+				      "noc_aggr_south_sf";
+
+			assigned-clocks = <&gcc GCC_PCIE_3A_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre2_noc MASTER_PCIE_3A 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_3A 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_3A_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_3A_GDSC>;
+
+			phys = <&pcie3a_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie3a_phy: phy@1c14000 {
+			compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy";
+			reg = <0x0 0x01c14000 0x0 0x2000>,
+			      <0x0 0x01c16000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_3A_AUX_CLK>,
+				 <&gcc GCC_PCIE_3A_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_3A3B_CLKREF_CLK>,
+				 <&gcc GCC_PCIE3A_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_3A_PIPE_CLK>,
+				 <&gcc GCC_PCIE_3A_PIPEDIV2_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe", "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE3A_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_3A_GDSC>;
+
+			resets = <&gcc GCC_PCIE_3A_PHY_BCR>;
+			reset-names = "phy";
+
+			qcom,4ln-config-sel = <&tcsr 0xa044 1>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_3a_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie2b: pcie@1c18000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sc8280xp";
+			reg = <0x0 0x01c18000 0x0 0x3000>,
+			      <0x0 0x38000000 0x0 0xf1d>,
+			      <0x0 0x38000f20 0x0 0xa8>,
+			      <0x0 0x38001000 0x0 0x1000>,
+			      <0x0 0x38100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x38200000 0x0 0x38200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
+
+			linux,pci-domain = <3>;
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_2B_AUX_CLK>,
+				 <&gcc GCC_PCIE_2B_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_2B_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_2B_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_2B_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr_4",
+				      "noc_aggr_south_sf";
+
+			assigned-clocks = <&gcc GCC_PCIE_2B_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre2_noc MASTER_PCIE_2B 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2B 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_2B_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_2B_GDSC>;
+
+			phys = <&pcie2b_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie2b_phy: phy@1c1e000 {
+			compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy";
+			reg = <0x0 0x01c1e000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_2B_AUX_CLK>,
+				 <&gcc GCC_PCIE_2B_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_2A2B_CLKREF_CLK>,
+				 <&gcc GCC_PCIE2B_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_2B_PIPE_CLK>,
+				 <&gcc GCC_PCIE_2B_PIPEDIV2_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe", "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE2B_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_2B_GDSC>;
+
+			resets = <&gcc GCC_PCIE_2B_PHY_BCR>;
+			reset-names = "phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_2b_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie2a: pcie@1c20000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sc8280xp";
+			reg = <0x0 0x01c20000 0x0 0x3000>,
+			      <0x0 0x3c000000 0x0 0xf1d>,
+			      <0x0 0x3c000f20 0x0 0xa8>,
+			      <0x0 0x3c001000 0x0 0x1000>,
+			      <0x0 0x3c100000 0x0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
+			bus-range = <0x00 0xff>;
+
+			linux,pci-domain = <2>;
+			num-lanes = <4>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
+				 <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_2A_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_2A_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_2A_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr_4",
+				      "noc_aggr_south_sf";
+
+			assigned-clocks = <&gcc GCC_PCIE_2A_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre2_noc MASTER_PCIE_2A 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2A 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_2A_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_2A_GDSC>;
+
+			phys = <&pcie2a_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie2a_phy: phy@1c24000 {
+			compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy";
+			reg = <0x0 0x01c24000 0x0 0x2000>,
+			      <0x0 0x01c26000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
+				 <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_2A2B_CLKREF_CLK>,
+				 <&gcc GCC_PCIE2A_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_2A_PIPE_CLK>,
+				 <&gcc GCC_PCIE_2A_PIPEDIV2_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "rchng",
+				      "pipe", "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE2A_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc PCIE_2A_GDSC>;
+
+			resets = <&gcc GCC_PCIE_2A_PHY_BCR>;
+			reset-names = "phy";
+
+			qcom,4ln-config-sel = <&tcsr 0xa044 0>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_2a_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-- 
2.37.4

