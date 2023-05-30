Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4A716967
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjE3Q0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjE3Q0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2211BE;
        Tue, 30 May 2023 09:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8438062CC2;
        Tue, 30 May 2023 16:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F75C43323;
        Tue, 30 May 2023 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463940;
        bh=UrnI2ovCkLMUGir6nEl9xb5A7zdP0flUTLe0/qoyl/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnY4CQwROOsmn7jqV9BYqCj6JFekyt/y4U20/bPKhPk1wQQeM4xPj8ZCbVuJEqf5B
         qrRZMmUCL6iIhAVye2DQs4myXN3dljihx9O8GaT7cWrKv1ZpCNl0QvHFIqCm/ZSrjJ
         bAHJn/fo7/+HfOKBskRp35GEx+DzlE16/z3aDFBWx9knCKplJdLdjW09Zay2mW7Zev
         f+y3gobmGtWSx7DdSbKG5LEc3fkOCkp1O6dABtQ7YKq+0fgv1aQu7A3nGjQWe784cg
         iJGtFZzy+RCEPHcwN5YhdtH8IDIGs8V1O6NmLWB6rf7BhLe7h86W2DYrY3yZ2aKaSB
         0N1oFE7y1JLRg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 11/15] arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes
Date:   Tue, 30 May 2023 21:54:50 +0530
Message-Id: <20230530162454.51708-12-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds remoteprocs, wifi and usb and usb phy nodes
for this SoC

Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 355 ++++++++++++++++++++++++++
 1 file changed, 355 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 2639f5fb6e39..c73fb25f5af0 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2227,6 +2227,198 @@ tlmm: pinctrl@3100000 {
 			wakeup-parent = <&pdc>;
 		};
 
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sc8180x-mpss-pas";
+			reg = <0x0 0x04080000 0x0 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SC8180X_CX>,
+					<&rpmhpd SC8180X_MSS>;
+			power-domain-names = "cx", "mss";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			glink-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apss_shared 12>;
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@8300000 {
+			compatible = "qcom,sc8180x-cdsp-pas";
+			reg = <0x0 0x08300000 0x0 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SC8180X_CX>;
+			power-domain-names = "cx";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>;
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+				mboxes = <&apss_shared 4>;
+			};
+		};
+
+		usb_prim_hsphy: phy@88e2000 {
+			compatible = "qcom,sc8180x-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
+			reg = <0 0x088e2000 0 0x400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb_sec_hsphy: phy@88e3000 {
+			compatible = "qcom,sc8180x-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
+			reg = <0 0x088e3000 0 0x400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb_prim_qmpphy: phy@88e9000 {
+			compatible = "qcom,sc8180x-qmp-usb3-dp-phy";
+			reg = <0 0x088e9000 0 0x18c>,
+			      <0 0x088e8000 0 0x38>,
+			      <0 0x088ea000 0 0x40>;
+			reg-names = "reg-base", "dp_com";
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux",
+				      "ref_clk_src",
+				      "ref",
+				      "com_aux";
+			resets = <&gcc GCC_USB3_DP_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_prim_ssphy: usb3-phy@88e9200 {
+				reg = <0 0x088e9200 0 0x200>,
+				      <0 0x088e9400 0 0x200>,
+				      <0 0x088e9c00 0 0x218>,
+				      <0 0x088e9600 0 0x200>,
+				      <0 0x088e9800 0 0x200>,
+				      <0 0x088e9a00 0 0x100>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_prim_phy_pipe_clk_src";
+			};
+
+			usb_prim_dpphy: dp-phy@88ea200 {
+				reg = <0 0x088ea200 0 0x200>,
+				      <0 0x088ea400 0 0x200>,
+				      <0 0x088eaa00 0 0x200>,
+				      <0 0x088ea600 0 0x200>,
+				      <0 0x088ea800 0 0x200>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		usb_sec_qmpphy: phy@88ee000 {
+			compatible = "qcom,sc8180x-qmp-usb3-dp-phy";
+			reg = <0 0x088ee000 0 0x18c>,
+			      <0 0x088ed000 0 0x10>,
+			      <0 0x088ef000 0 0x40>;
+			reg-names = "reg-base", "dp_com";
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+			clock-names = "aux",
+				      "ref_clk_src",
+				      "ref",
+				      "com_aux";
+			resets = <&gcc GCC_USB3_DP_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3_PHY_SEC_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_sec_ssphy: usb3-phy@88e9200 {
+				reg = <0 0x088ee200 0 0x200>,
+				      <0 0x088ee400 0 0x200>,
+				      <0 0x088eec00 0 0x218>,
+				      <0 0x088ee600 0 0x200>,
+				      <0 0x088ee800 0 0x200>,
+				      <0 0x088eea00 0 0x100>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_sec_phy_pipe_clk_src";
+			};
+
+			usb_sec_dpphy: dp-phy@88ef200 {
+				reg = <0 0x088ef200 0 0x200>,
+				      <0 0x088ef400 0 0x200>,
+				      <0 0x088efa00 0 0x200>,
+				      <0 0x088ef600 0 0x200>,
+				      <0 0x088ef800 0 0x200>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+				clock-output-names = "qmp_dptx1_phy_pll_link_clk",
+						     "qmp_dptx1_phy_pll_vco_div_clk";
+			};
+		};
+
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8180x-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
@@ -2241,6 +2433,112 @@ gem_noc: interconnect@9680000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		usb_prim: usb@a6f8800 {
+			compatible = "qcom,sc8180x-dwc3", "qcom,dwc3";
+			reg = <0 0x0a6f8800 0 0x400>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "mock_utmi",
+				      "sleep",
+				      "xo";
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			interconnects = <&aggre1_noc MASTER_USB3 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-ranges;
+
+			status = "disabled";
+
+			usb_prim_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a600000 0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x140 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_prim_hsphy>, <&usb_prim_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		usb_sec: usb@a8f8800 {
+			compatible = "qcom,sc8180x-dwc3", "qcom,dwc3";
+			reg = <0 0x0a8f8800 0 0x400>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "mock_utmi",
+				      "sleep",
+				      "xo";
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+			power-domains = <&gcc USB30_SEC_GDSC>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3_1 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-ranges;
+
+			status = "disabled";
+
+			usb_sec_dwc3: usb@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a800000 0 0xcd00>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x160 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_sec_hsphy>, <&usb_sec_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sc8180x-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>;
@@ -2416,6 +2714,39 @@ apps_smmu: iommu@15000000 {
 
 		};
 
+		remoteproc_adsp: remoteproc@17300000 {
+			compatible = "qcom,sc8180x-adsp-pas";
+			reg = <0x0 0x17300000 0x0 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SC8180X_CX>;
+			power-domain-names = "cx";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			remoteproc_adsp_glink: glink-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apss_shared 8>;
+			};
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			interrupt-controller;
@@ -2615,6 +2946,30 @@ cpufreq_hw: cpufreq@18323000 {
 			#clock-cells = <1>;
 		};
 
+		wifi: wifi@18800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0 0x18800000 0 0x800000>;
+			reg-names = "membase";
+			clock-names = "cxo_ref_clk_pin";
+			clocks = <&rpmhcc RPMH_RF_CLK2>;
+			interrupts = <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x0640 0x1>;
+			qcom,msa-fixed-perm;
+			status = "disabled";
+		};
+	};
+
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-- 
2.40.1

