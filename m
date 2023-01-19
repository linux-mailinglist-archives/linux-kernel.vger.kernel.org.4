Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A15B67354E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjASKRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjASKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:16:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D6474CC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:16:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 18so2234750edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X2YQnd7nw33mzmLmyZj3iTWuN5/bdhMpGh0SXkrRyU=;
        b=uRGSpGteVNEHRSUB4LsOFNHkfzTNWY7ssve3IJ7pH9D/yqZRAu0tjZ+mnOSFVQTe+d
         qmbypI9Pmddk96jN6orInJkwceyD/5H1Fcc57U9G8YpI/5WERhcke6NwwxvvR8m01NRt
         hqgKvEioB0L9m4wOC14dTZYGnCrGNeL7p111S41mCFHo77tFsrreFj7glJuPL9sBtIGj
         DmOjI8kqOS7LRq+p6HQPjNeoJSZFUTVRHuqQ3pbAwkpmk+Uk+wtBgUqwqCgqtA2y/b9Y
         dW64PLTxQeX7IkZugNXm6YiIDr5241yCISrbEALfVMvsovRnthcBp8cIq0BVwHv55cqT
         /+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X2YQnd7nw33mzmLmyZj3iTWuN5/bdhMpGh0SXkrRyU=;
        b=X9YUnPGh+JVf2ExYAXgB9jwfl15miG6jblYPTzMTXSkUTPOWPu6vLqtBDPi6vfVqRK
         NEuULQLa9NArm9wmSsfiPj2UersI0cao1J1wPIfRz+Aeckj37v0/2TpkxGWoCYZxX2CB
         9do50kSpaCWjLOdLrqmnRY5Li9b58fbRTFWZSJE53Y5fA2QSw8Ht6kEd9GTnVmUP186k
         aXhJ0OrpYL/MaOjWjM/h8/VttbcuV+zU86BGn2fRtVDTmQiNHkhmeq4QWJOT7OWGdLek
         2RsIr6AOVzyfDTYDOt4AjJpj+7hgfx8n1L06V/x101Kzb97Y/h8ykyO39BGU9s5k8W4p
         k+SQ==
X-Gm-Message-State: AFqh2kpuZz8H0gGnJPl3EksUlUttDV9YMBFQ7zhJGrWUzmXjhavOQTKS
        66TCe2bXC5obX55kOoX94exbBw==
X-Google-Smtp-Source: AMrXdXvCzd4/2UXBRepLxr80L5D/qtKtCfxWeZ88fy0fehcaIc1wUFVwpXrgDTYnOXQPC0wF0ndzZQ==
X-Received: by 2002:aa7:d1d3:0:b0:461:8be6:1ac4 with SMTP id g19-20020aa7d1d3000000b004618be61ac4mr10872038edp.20.1674123412215;
        Thu, 19 Jan 2023 02:16:52 -0800 (PST)
Received: from localhost.localdomain (abxh150.neoplus.adsl.tpnet.pl. [83.9.1.150])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b0084c62b7b7d8sm16083276ejy.187.2023.01.19.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:16:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bhupesh.sharma@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm6115: Use 64 bit addressing
Date:   Thu, 19 Jan 2023 11:16:44 +0100
Message-Id: <20230119101644.10711-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119101644.10711-1-konrad.dybcio@linaro.org>
References: <20230119101644.10711-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115's SMMU uses 36bit VAs, which is a good indicator that we
should increase (dma-)ranges - and by extension #address- and
 #size-cells to prevent things from getting lost in translation
(both literally and figuratively). Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 219 ++++++++++++++-------------
 1 file changed, 113 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index c0f9bdc25508..fa834eedf488 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -347,19 +347,22 @@ rpmpd_opp_turbo_plus: opp8 {
 
 	soc: soc@0 {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
 
 		tcsr_mutex: hwlock@340000 {
 			compatible = "qcom,tcsr-mutex";
-			reg = <0x00340000 0x20000>;
+			reg = <0x0 0x00340000 0x0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 
 		tlmm: pinctrl@500000 {
 			compatible = "qcom,sm6115-tlmm";
-			reg = <0x00500000 0x400000>, <0x00900000 0x400000>, <0x00d00000 0x400000>;
+			reg = <0x0 0x00500000 0x0 0x400000>,
+			      <0x0 0x00900000 0x0 0x400000>,
+			      <0x0 0x00d00000 0x0 0x400000>;
 			reg-names = "west", "south", "east";
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -559,7 +562,7 @@ sd-cd-pins {
 
 		gcc: clock-controller@1400000 {
 			compatible = "qcom,gcc-sm6115";
-			reg = <0x01400000 0x1f0000>;
+			reg = <0x0 0x01400000 0x0 0x1f0000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
 			clock-names = "bi_tcxo", "sleep_clk";
 			#clock-cells = <1>;
@@ -569,7 +572,7 @@ gcc: clock-controller@1400000 {
 
 		usb_1_hsphy: phy@1613000 {
 			compatible = "qcom,sm6115-qusb2-phy";
-			reg = <0x01613000 0x180>;
+			reg = <0x0 0x01613000 0x0 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_AHB2PHY_USB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
@@ -583,7 +586,7 @@ usb_1_hsphy: phy@1613000 {
 
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
-			reg = <0x01b40000 0x7000>;
+			reg = <0x0 0x01b40000 0x0 0x7000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -595,18 +598,18 @@ qusb2_hstx_trim: hstx-trim@25b {
 
 		rng: rng@1b53000 {
 			compatible = "qcom,prng-ee";
-			reg = <0x01b53000 0x1000>;
+			reg = <0x0 0x01b53000 0x0 0x1000>;
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "core";
 		};
 
 		spmi_bus: spmi@1c40000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x01c40000 0x1100>,
-			      <0x01e00000 0x2000000>,
-			      <0x03e00000 0x100000>,
-			      <0x03f00000 0xa0000>,
-			      <0x01c0a000 0x26000>;
+			reg = <0x0 0x01c40000 0x0 0x1100>,
+			      <0x0 0x01e00000 0x0 0x2000000>,
+			      <0x0 0x03e00000 0x0 0x100000>,
+			      <0x0 0x03f00000 0x0 0xa0000>,
+			      <0x0 0x01c0a000 0x0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
@@ -620,8 +623,8 @@ spmi_bus: spmi@1c40000 {
 
 		tsens0: thermal-sensor@4410000 {
 			compatible = "qcom,sm6115-tsens", "qcom,tsens-v2";
-			reg = <0x04411000 0x1ff>, /* TM */
-			      <0x04410000 0x8>; /* SROT */
+			reg = <0x0 0x04411000 0x0 0x1ff>, /* TM */
+			      <0x0 0x04410000 0x0 0x8>; /* SROT */
 			#qcom,sensors = <16>;
 			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
@@ -631,17 +634,19 @@ tsens0: thermal-sensor@4410000 {
 
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram";
-			reg = <0x045f0000 0x7000>;
+			reg = <0x0 0x045f0000 0x0 0x7000>;
 		};
 
 		sram@4690000 {
 			compatible = "qcom,rpm-stats";
-			reg = <0x04690000 0x10000>;
+			reg = <0x0 0x04690000 0x0 0x10000>;
 		};
 
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
-			reg = <0x04744000 0x1000>, <0x04745000 0x1000>, <0x04748000 0x8000>;
+			reg = <0x0 0x04744000 0x0 0x1000>,
+			      <0x0 0x04745000 0x0 0x1000>,
+			      <0x0 0x04748000 0x0 0x8000>;
 			reg-names = "hc", "cqhci", "ice";
 
 			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
@@ -664,7 +669,7 @@ sdhc_1: mmc@4744000 {
 
 		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
-			reg = <0x04784000 0x1000>;
+			reg = <0x0 0x04784000 0x0 0x1000>;
 			reg-names = "hc";
 
 			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
@@ -707,7 +712,7 @@ opp-202000000 {
 
 		ufs_mem_hc: ufs@4804000 {
 			compatible = "qcom,sm6115-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
-			reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
+			reg = <0x0 0x04804000 0x0 0x3000>, <0x0 0x04810000 0x0 0x8000>;
 			reg-names = "std", "ice";
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
@@ -751,9 +756,9 @@ ufs_mem_hc: ufs@4804000 {
 
 		ufs_mem_phy: phy@4807000 {
 			compatible = "qcom,sm6115-qmp-ufs-phy";
-			reg = <0x04807000 0x1c4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			reg = <0x0 0x04807000 0x0 0x1c4>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_UFS_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
@@ -764,16 +769,16 @@ ufs_mem_phy: phy@4807000 {
 			status = "disabled";
 
 			ufs_mem_phy_lanes: phy@4807400 {
-				reg = <0x4807400 0x098>,
-				      <0x4807600 0x130>,
-				      <0x4807c00 0x16c>;
+				reg = <0x0 0x4807400 0x0 0x098>,
+				      <0x0 0x4807600 0x0 0x130>,
+				      <0x0 0x4807c00 0x0 0x16c>;
 				#phy-cells = <0>;
 			};
 		};
 
 		gpi_dma0: dma-controller@4a00000 {
 			compatible = "qcom,sm6115-gpi-dma", "qcom,sm6350-gpi-dma";
-			reg = <0x04a00000 0x60000>;
+			reg = <0x0 0x04a00000 0x0 0x60000>;
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
@@ -793,19 +798,19 @@ gpi_dma0: dma-controller@4a00000 {
 
 		qupv3_id_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x04ac0000 0x2000>;
+			reg = <0x0 0x04ac0000 0x0 0x2000>;
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			iommus = <&apps_smmu 0xe3 0x0>;
 			ranges;
 			status = "disabled";
 
 			i2c0: i2c@4a80000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x04a80000 0x4000>;
+				reg = <0x0 0x04a80000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -821,7 +826,7 @@ i2c0: i2c@4a80000 {
 
 			spi0: spi@4a80000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x04a80000 0x4000>;
+				reg = <0x0 0x04a80000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				pinctrl-names = "default";
@@ -837,7 +842,7 @@ spi0: spi@4a80000 {
 
 			i2c1: i2c@4a84000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x04a84000 0x4000>;
+				reg = <0x0 0x04a84000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -853,7 +858,7 @@ i2c1: i2c@4a84000 {
 
 			spi1: spi@4a84000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x04a84000 0x4000>;
+				reg = <0x0 0x04a84000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				pinctrl-names = "default";
@@ -869,7 +874,7 @@ spi1: spi@4a84000 {
 
 			i2c2: i2c@4a88000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x04a88000 0x4000>;
+				reg = <0x0 0x04a88000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -885,7 +890,7 @@ i2c2: i2c@4a88000 {
 
 			spi2: spi@4a88000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x04a88000 0x4000>;
+				reg = <0x0 0x04a88000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				pinctrl-names = "default";
@@ -901,7 +906,7 @@ spi2: spi@4a88000 {
 
 			i2c3: i2c@4a8c000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x04a8c000 0x4000>;
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -917,7 +922,7 @@ i2c3: i2c@4a8c000 {
 
 			spi3: spi@4a8c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x04a8c000 0x4000>;
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				pinctrl-names = "default";
@@ -933,7 +938,7 @@ spi3: spi@4a8c000 {
 
 			i2c4: i2c@4a90000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x04a90000 0x4000>;
+				reg = <0x0 0x04a90000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -949,7 +954,7 @@ i2c4: i2c@4a90000 {
 
 			spi4: spi@4a90000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x04a90000 0x4000>;
+				reg = <0x0 0x04a90000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				pinctrl-names = "default";
@@ -965,7 +970,7 @@ spi4: spi@4a90000 {
 
 			i2c5: i2c@4a94000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x04a94000 0x4000>;
+				reg = <0x0 0x04a94000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -981,7 +986,7 @@ i2c5: i2c@4a94000 {
 
 			spi5: spi@4a94000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x04a94000 0x4000>;
+				reg = <0x0 0x04a94000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				pinctrl-names = "default";
@@ -998,9 +1003,9 @@ spi5: spi@4a94000 {
 
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
-			reg = <0x04ef8800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			reg = <0x0 0x04ef8800 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
@@ -1026,7 +1031,7 @@ usb_1: usb@4ef8800 {
 
 			usb_1_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
-				reg = <0x04e00000 0xcd00>;
+				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb_1_hsphy>;
 				phy-names = "usb2-phy";
@@ -1043,7 +1048,7 @@ usb_1_dwc3: usb@4e00000 {
 
 		mdss: display-subsystem@5e00000 {
 			compatible = "qcom,sm6115-mdss";
-			reg = <0x05e00000 0x1000>;
+			reg = <0x0 0x05e00000 0x0 0x1000>;
 			reg-names = "mdss";
 
 			power-domains = <&dispcc MDSS_GDSC>;
@@ -1059,16 +1064,16 @@ mdss: display-subsystem@5e00000 {
 			iommus = <&apps_smmu 0x420 0x2>,
 				 <&apps_smmu 0x421 0x0>;
 
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 
 			status = "disabled";
 
 			mdp: display-controller@5e01000 {
 				compatible = "qcom,sm6115-dpu";
-				reg = <0x05e01000 0x8f000>,
-				      <0x05eb0000 0x2008>;
+				reg = <0x0 0x05e01000 0x0 0x8f000>,
+				      <0x0 0x05eb0000 0x0 0x2008>;
 				reg-names = "mdp", "vbif";
 
 				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
@@ -1134,7 +1139,7 @@ opp-384000000 {
 
 			mdss_dsi0: dsi@5e94000 {
 				compatible = "qcom,dsi-ctrl-6g-qcm2290";
-				reg = <0x05e94000 0x400>;
+				reg = <0x0 0x05e94000 0x0 0x400>;
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
@@ -1206,9 +1211,9 @@ opp-187500000 {
 
 			mdss_dsi0_phy: phy@5e94400 {
 				compatible = "qcom,dsi-phy-14nm-2290";
-				reg = <0x05e94400 0x100>,
-				      <0x05e94500 0x300>,
-				      <0x05e94800 0x188>;
+				reg = <0x0 0x05e94400 0x0 0x100>,
+				      <0x0 0x05e94500 0x0 0x300>,
+				      <0x0 0x05e94800 0x0 0x188>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
@@ -1226,7 +1231,7 @@ mdss_dsi0_phy: phy@5e94400 {
 
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,sm6115-dispcc";
-			reg = <0x05f00000 0x20000>;
+			reg = <0x0 0x05f00000 0 0x20000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&sleep_clk>,
 				 <&mdss_dsi0_phy 0>,
@@ -1239,8 +1244,8 @@ dispcc: clock-controller@5f00000 {
 
 		stm@8002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
-			reg = <0x08002000 0x1000>,
-			      <0x0e280000 0x180000>;
+			reg = <0x0 0x08002000 0x0 0x1000>,
+			      <0x0 0x0e280000 0x0 0x180000>;
 			reg-names = "stm-base", "stm-stimulus-base";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
@@ -1259,7 +1264,7 @@ stm_out: endpoint {
 
 		cti0: cti@8010000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08010000 0x1000>;
+			reg = <0x0 0x08010000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1269,7 +1274,7 @@ cti0: cti@8010000 {
 
 		cti1: cti@8011000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08011000 0x1000>;
+			reg = <0x0 0x08011000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1279,7 +1284,7 @@ cti1: cti@8011000 {
 
 		cti2: cti@8012000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08012000 0x1000>;
+			reg = <0x0 0x08012000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1289,7 +1294,7 @@ cti2: cti@8012000 {
 
 		cti3: cti@8013000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08013000 0x1000>;
+			reg = <0x0 0x08013000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1299,7 +1304,7 @@ cti3: cti@8013000 {
 
 		cti4: cti@8014000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08014000 0x1000>;
+			reg = <0x0 0x08014000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1309,7 +1314,7 @@ cti4: cti@8014000 {
 
 		cti5: cti@8015000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08015000 0x1000>;
+			reg = <0x0 0x08015000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1319,7 +1324,7 @@ cti5: cti@8015000 {
 
 		cti6: cti@8016000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08016000 0x1000>;
+			reg = <0x0 0x08016000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1329,7 +1334,7 @@ cti6: cti@8016000 {
 
 		cti7: cti@8017000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08017000 0x1000>;
+			reg = <0x0 0x08017000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1339,7 +1344,7 @@ cti7: cti@8017000 {
 
 		cti8: cti@8018000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08018000 0x1000>;
+			reg = <0x0 0x08018000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1349,7 +1354,7 @@ cti8: cti@8018000 {
 
 		cti9: cti@8019000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x08019000 0x1000>;
+			reg = <0x0 0x08019000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1359,7 +1364,7 @@ cti9: cti@8019000 {
 
 		cti10: cti@801a000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x0801a000 0x1000>;
+			reg = <0x0 0x0801a000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1369,7 +1374,7 @@ cti10: cti@801a000 {
 
 		cti11: cti@801b000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x0801b000 0x1000>;
+			reg = <0x0 0x0801b000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1379,7 +1384,7 @@ cti11: cti@801b000 {
 
 		cti12: cti@801c000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x0801c000 0x1000>;
+			reg = <0x0 0x0801c000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1389,7 +1394,7 @@ cti12: cti@801c000 {
 
 		cti13: cti@801d000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x0801d000 0x1000>;
+			reg = <0x0 0x0801d000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1399,7 +1404,7 @@ cti13: cti@801d000 {
 
 		cti14: cti@801e000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x0801e000 0x1000>;
+			reg = <0x0 0x0801e000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1409,7 +1414,7 @@ cti14: cti@801e000 {
 
 		cti15: cti@801f000 {
 			compatible = "arm,coresight-cti", "arm,primecell";
-			reg = <0x0801f000 0x1000>;
+			reg = <0x0 0x0801f000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1419,7 +1424,7 @@ cti15: cti@801f000 {
 
 		replicator@8046000 {
 			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
-			reg = <0x08046000 0x1000>;
+			reg = <0x0 0x08046000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1445,7 +1450,7 @@ replicator_in: endpoint {
 
 		etf@8047000 {
 			compatible = "arm,coresight-tmc", "arm,primecell";
-			reg = <0x08047000 0x1000>;
+			reg = <0x0 0x08047000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1471,7 +1476,7 @@ etf_out: endpoint {
 
 		etr@8048000 {
 			compatible = "arm,coresight-tmc", "arm,primecell";
-			reg = <0x08048000 0x1000>;
+			reg = <0x0 0x08048000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1489,7 +1494,7 @@ etr_in: endpoint {
 
 		funnel@8041000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x08041000 0x1000>;
+			reg = <0x0 0x08041000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1515,7 +1520,7 @@ funnel_in0_in: endpoint {
 
 		funnel@8042000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x08042000 0x1000>;
+			reg = <0x0 0x08042000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1541,7 +1546,7 @@ funnel_in1_in: endpoint {
 
 		funnel@8045000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x08045000 0x1000>;
+			reg = <0x0 0x08045000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1578,7 +1583,7 @@ merge_funnel_in1: endpoint {
 
 		etm@9040000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09040000 0x1000>;
+			reg = <0x0 0x09040000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1599,7 +1604,7 @@ etm0_out: endpoint {
 
 		etm@9140000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09140000 0x1000>;
+			reg = <0x0 0x09140000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1620,7 +1625,7 @@ etm1_out: endpoint {
 
 		etm@9240000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09240000 0x1000>;
+			reg = <0x0 0x09240000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1641,7 +1646,7 @@ etm2_out: endpoint {
 
 		etm@9340000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09340000 0x1000>;
+			reg = <0x0 0x09340000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1662,7 +1667,7 @@ etm3_out: endpoint {
 
 		etm@9440000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09440000 0x1000>;
+			reg = <0x0 0x09440000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1683,7 +1688,7 @@ etm4_out: endpoint {
 
 		etm@9540000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09540000 0x1000>;
+			reg = <0x0 0x09540000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1704,7 +1709,7 @@ etm5_out: endpoint {
 
 		etm@9640000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09640000 0x1000>;
+			reg = <0x0 0x09640000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1725,7 +1730,7 @@ etm6_out: endpoint {
 
 		etm@9740000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
-			reg = <0x09740000 0x1000>;
+			reg = <0x0 0x09740000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1746,7 +1751,7 @@ etm7_out: endpoint {
 
 		funnel@9800000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x09800000 0x1000>;
+			reg = <0x0 0x09800000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1825,7 +1830,7 @@ funnel_apss0_in7: endpoint {
 
 		funnel@9810000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x09810000 0x1000>;
+			reg = <0x0 0x09810000 0x0 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1851,7 +1856,7 @@ funnel_apss1_in: endpoint {
 
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
-			reg = <0x0c600000 0x80000>;
+			reg = <0x0 0x0c600000 0x0 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
 
@@ -1924,7 +1929,7 @@ apps_smmu: iommu@c600000 {
 
 		wifi: wifi@c800000 {
 			compatible = "qcom,wcn3990-wifi";
-			reg = <0x0c800000 0x800000>;
+			reg = <0x0 0x0c800000 0x0 0x800000>;
 			reg-names = "membase";
 			memory-region = <&wlan_msa_mem>;
 			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
@@ -1946,63 +1951,63 @@ wifi: wifi@c800000 {
 
 		apcs_glb: mailbox@f111000 {
 			compatible = "qcom,sm6115-apcs-hmss-global";
-			reg = <0x0f111000 0x1000>;
+			reg = <0x0 0x0f111000 0x0 0x1000>;
 
 			#mbox-cells = <1>;
 		};
 
 		timer@f120000 {
 			compatible = "arm,armv7-timer-mem";
-			reg = <0x0f120000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			reg = <0x0 0x0f120000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			ranges;
 			clock-frequency = <19200000>;
 
 			frame@f121000 {
-				reg = <0x0f121000 0x1000>, <0x0f122000 0x1000>;
+				reg = <0x0 0x0f121000 0x0 0x1000>, <0x0 0x0f122000 0x0 0x1000>;
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			frame@f123000 {
-				reg = <0x0f123000 0x1000>;
+				reg = <0x0 0x0f123000 0x0 0x1000>;
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f124000 {
-				reg = <0x0f124000 0x1000>;
+				reg = <0x0 0x0f124000 0x0 0x1000>;
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f125000 {
-				reg = <0x0f125000 0x1000>;
+				reg = <0x0 0x0f125000 0x0 0x1000>;
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f126000 {
-				reg = <0x0f126000 0x1000>;
+				reg = <0x0 0x0f126000 0x0 0x1000>;
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f127000 {
-				reg = <0x0f127000 0x1000>;
+				reg = <0x0 0x0f127000 0x0 0x1000>;
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f128000 {
-				reg = <0x0f128000 0x1000>;
+				reg = <0x0 0x0f128000 0x0 0x1000>;
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
@@ -2011,7 +2016,8 @@ frame@f128000 {
 
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
-			reg = <0x0f200000 0x10000>, <0x0f300000 0x100000>;
+			reg = <0x0 0x0f200000 0x0 0x10000>,
+			      <0x0 0x0f300000 0x0 0x100000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupt-parent = <&intc>;
@@ -2022,7 +2028,8 @@ intc: interrupt-controller@f200000 {
 
 		cpufreq_hw: cpufreq@f521000 {
 			compatible = "qcom,cpufreq-hw";
-			reg = <0x0f521000 0x1000>, <0x0f523000 0x1000>;
+			reg = <0x0 0x0f521000 0x0 0x1000>,
+			      <0x0 0x0f523000 0x0 0x1000>;
 
 			reg-names = "freq-domain0", "freq-domain1";
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
-- 
2.39.1

