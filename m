Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0A6B1582
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCHWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:47:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A43D3322
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:47:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so119990wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678315627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFSUC14oqsmNlN+YIHQ3Lf0QikUQ/wjNjy9O8VYjGBg=;
        b=Nc4gE5bYmtLo4bxhZ5VJxnAJkeMlP5NlB7FSxJjDhrjoddyIQeAPgTpQmVCr2hlIs6
         RN0PvJqlTYBdVYDS/+Bg7WF03lNIAWa6tinLU6YZEorqHzUILY+R4vFScJv9Cv2mRI6r
         Ru65aOLn0K4oEzhTV3/m/19CeNpzbMivmogwuCt/Nl7kig18S2i+JedqiTnT4o6tVaHU
         U2sQtTPIbzpq+Ub8+OQp4Qx9mSeueyozNI1+vDWm0+qVAnGMuO0P6pBNUd7nHL2/PxLY
         qULXjs/2Jtb2IVbECitxTFACxon++Tj+2Zr26JlI1OhKCVCs19Fd7tvtvjTFZJyfYMW8
         VAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFSUC14oqsmNlN+YIHQ3Lf0QikUQ/wjNjy9O8VYjGBg=;
        b=ZdrXoLXrlbV5Cs6Y7Zes4hWtg5tAjez5B3I/Qb/yazcd2+JwfBOXOZqw3ohaUv6CHF
         1PkDFsJvtPM/M/Rp4rmjcehwY9f4eQtAsD6P2ABbvmi/qy5pJ0UEqe1GqmZBvN+dXlT1
         SsTXM9KL/RnB1P15LGutVmz77olvCYAj/Ieel5zjyAus++HLTdYdV3UjY2751veiNxap
         2jLP/LbANT+BbE3fOM+z7JIxfoYp4Lq+PULGRCc7uZ2Jqeb3f2FqlnFP89tq7OfyCjcx
         21bOteyyvD4xx5c35+Y4aGvkHF95ITXVaS7aPUtrh50cVuq5b0DtTi88GTT5bdByXqE/
         wOsA==
X-Gm-Message-State: AO0yUKWOTMZzmVEgUejUNHvE7LOx4p+UhDlvHX5+oPa/S+Vkpupm2OGq
        xaZ3mS+23yJ0s2pYnmkViqNAkQ==
X-Google-Smtp-Source: AK7set+EjH5Er33hmQRt2og8WL8QaPL6kOqPTM8EuoH+l7tfjNtyNqWgIEi+NXTHbkPEhrQAtwiqyg==
X-Received: by 2002:a05:600c:3553:b0:3e2:1e31:36bc with SMTP id i19-20020a05600c355300b003e21e3136bcmr17586983wmq.12.1678315627625;
        Wed, 08 Mar 2023 14:47:07 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003dc49e0132asm753033wmb.1.2023.03.08.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:47:07 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v10] arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes
Date:   Thu,  9 Mar 2023 00:46:42 +0200
Message-Id: <20230308224642.2640030-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, move the pinctrl related propeties out from SoC dtsi and into the
board dts and add blank lines before status properties in the PHY nodes
to be consistent with the rest of the nodes. Then drop the pipe clock
from the controller nodes. Rename the aggre0 and aggre1 clocks to more
generic noc_aggr, and then the cnoc_pcie_sf_axi to cnoc_sf_axi. Add the
cpu-pcie interconnects to both controller nodes. Rename the pcie1 second
reset to link_down and drop the unnecessary enable-gpios. Switch the aux
clock to GCC_PCIE_1_PHY_AUX_CLK for the pcie1 PHY and drop the aux_phy
from clock-names. Also rename the nocsr reset to phy_nocsr. With this
changes we are now in line with the SC8280XP bindings.

Fixes: 98a4dc3a78fa ("arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

The v9 of this patch was here:
https://lore.kernel.org/all/20230208180020.2761766-12-abel.vesa@linaro.org/

Changes since v9:
 * moved the pinctrl-names below the pinctrl-0 for pcie HC nodes in MTP
   dts board file
 * all other patches from v9 patchset have been dropped from v10 as they
   are already merged

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 10 +++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 52 +++++++++----------------
 2 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 5db6e789e6b8..8d5e8ab679b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -414,18 +414,27 @@ &pcie_1_phy_aux_clk {
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1e_0p88>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
+
 	status = "okay";
 };
 
 &pcie1 {
 	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
@@ -433,6 +442,7 @@ &pcie1_phy {
 	vdda-phy-supply = <&vreg_l3c_0p91>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
 	vdda-qref-supply = <&vreg_l1e_0p88>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 25f51245fe9b..2e42e8c210bd 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1672,25 +1672,24 @@ pcie0: pci@1c00000 {
 					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
-				 <&gcc GCC_PCIE_0_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
 				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
 				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
-			clock-names = "pipe",
-				      "aux",
+			clock-names = "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
 				      "ddrss_sf_tbu",
-				      "aggre0";
+				      "noc_aggr";
 
-			interconnect-names = "pcie-mem";
-			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
+			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
 
 			iommus = <&apps_smmu 0x1400 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
@@ -1704,12 +1703,6 @@ pcie0: pci@1c00000 {
 			phys = <&pcie0_phy>;
 			phy-names = "pciephy";
 
-			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
-			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&pcie0_default_state>;
-
 			status = "disabled";
 		};
 
@@ -1771,8 +1764,7 @@ pcie1: pci@1c08000 {
 					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
-				 <&gcc GCC_PCIE_1_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
@@ -1780,21 +1772,21 @@ pcie1: pci@1c08000 {
 				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
 				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
 				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
-			clock-names = "pipe",
-				      "aux",
+			clock-names = "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
 				      "ddrss_sf_tbu",
-				      "aggre1",
-				      "cnoc_pcie_sf_axi";
+				      "noc_aggr",
+				      "cnoc_sf_axi";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			interconnect-names = "pcie-mem";
-			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
+			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_1 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
 
 			iommus = <&apps_smmu 0x1480 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
@@ -1802,20 +1794,13 @@ pcie1: pci@1c08000 {
 
 			resets = <&gcc GCC_PCIE_1_BCR>,
 				<&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
-			reset-names = "pci",
-				"pcie_1_link_down_reset";
+			reset-names = "pci", "link_down";
 
 			power-domains = <&gcc PCIE_1_GDSC>;
 
 			phys = <&pcie1_phy>;
 			phy-names = "pciephy";
 
-			perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
-			enable-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&pcie1_default_state>;
-
 			status = "disabled";
 		};
 
@@ -1823,18 +1808,17 @@ pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
 			reg = <0x0 0x01c0e000 0x0 0x2000>;
 
-			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
 				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
-				 <&gcc GCC_PCIE_1_PIPE_CLK>,
-				 <&gcc GCC_PCIE_1_PHY_AUX_CLK>;
+				 <&gcc GCC_PCIE_1_PIPE_CLK>;
 			clock-names = "aux", "cfg_ahb", "ref", "rchng",
-				      "pipe", "aux_phy";
+				      "pipe";
 
 			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
 				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
-			reset-names = "phy", "nocsr";
+			reset-names = "phy", "phy_nocsr";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
 			assigned-clock-rates = <100000000>;
-- 
2.34.1

