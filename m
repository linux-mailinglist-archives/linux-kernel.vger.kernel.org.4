Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82956B0E08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjCHQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjCHP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2AB788D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:59:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso1471391wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlkJ43vk7P2I8VJnYV/tDeORllmV6CsNFLr6sCgkF18=;
        b=e/CmqSlBFJ05W9lE6TrYjE12XayQTdxPNYj1Qg6Upj8VFuLAC73A6kN3eC2cWSb3oc
         vaKj9clisPRwPYWpF5HkN3c5u6Y9mRFzQgwPOAa8HYl7cWMJDkhjgkAdOC78Lmre2gqz
         zuok1NMCS36fuEONm+hA0KzFIu6wYT27ncNqKLWtZBIVqkeexq3bFSV6Ox3/emzRaxiz
         X0mAs6TCOt1fiUXEd4jq4wNMprBauLmBAlRoybINk4TKvqqYaZm2nvJ5EHc5GxkZTcXR
         OGkZQoULlHsw5TTHXMbVHfmJt7n3oVSomi28z6c0zN/LOMc7jSAS1X4YTs9opjy8dOQ5
         BbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlkJ43vk7P2I8VJnYV/tDeORllmV6CsNFLr6sCgkF18=;
        b=pzUkFXvchI9EOtUkD6xx/0wcG8e4BGsck57+PbUR3dDzx14g0+GRBnJWrcfEt/9lbu
         2gPuy+QBNIac+wOvGWwuwZ8WTiB/LP9KsEGpjLuiopQvMyARQ4A+tBBznCG6agabL3q+
         XmOKVKOgEWb269qheJD/w4y/Dsj0UP0Svwwh9DmlMckS7+Ybplgppfz5Q8bO/IrO4iV/
         QtilsMlxGuKQDvFPsRZjwT1ewmXf/1sWIfLyFNOnT6/hvNWjkQbZsLobe3hY9q+TgLrc
         thDoxwk6vcJMHDjfhF1d8JuGpy7mK4lHrE1QMHvfOpyKH/2tFuLE+kDXNMbj+zsVDpBK
         9r8w==
X-Gm-Message-State: AO0yUKXKGco3ZfMPo7rRR4YbdbAEGFWDfxbZzpBzlDqM5NPW+ARCk+OZ
        00w/65CF/BDXMje8QUzXT2t7tQ==
X-Google-Smtp-Source: AK7set/Fk81BRAvEaEZ4n/aVjxSPcXXt7wsoigiUp9lQW/Ia06McQ6AyO/YEhz89liErYygZ+JjlJw==
X-Received: by 2002:a05:600c:3d8b:b0:3eb:578d:ded3 with SMTP id bi11-20020a05600c3d8b00b003eb578dded3mr17442801wmb.35.1678291160552;
        Wed, 08 Mar 2023 07:59:20 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:19 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto Engine nodes
Date:   Wed,  8 Mar 2023 17:58:38 +0200
Message-Id: <20230308155838.1094920-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop all properties related to ICE from every UFS and SDCC node,
for all platforms, and add dedicated ICE nodes for each platform.
On most platforms, there is only one ICE instance, used by either
UFS or SDCC, but there are some platforms that have two separate
instances and, therefore, two separate nodes are added.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * Made changes for all platforms that use ICE, as a single patch since
   most changes look really similar.

 arch/arm64/boot/dts/qcom/sdm630.dtsi | 18 +++++++++-----
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 15 +++++++----
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++-------
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 +++++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 ++++++++++++++---------
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 +++++++++-------
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++-------
 7 files changed, 102 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 5827cda270a0..2aed49104d9d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1330,9 +1330,8 @@ opp-200000000 {
 		sdhc_1: mmc@c0c4000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c0c4000 0x1000>,
-			      <0x0c0c5000 0x1000>,
-			      <0x0c0c8000 0x8000>;
-			reg-names = "hc", "cqhci", "ice";
+			      <0x0c0c5000 0x1000>;
+			reg-names = "hc", "cqhci";
 
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
@@ -1340,9 +1339,8 @@ sdhc_1: mmc@c0c4000 {
 
 			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&xo_board>,
-				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
-			clock-names = "iface", "core", "xo", "ice";
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
 
 			interconnects = <&a2noc 2 &a2noc 10>,
 					<&gnoc 0 &cnoc 27>;
@@ -1353,6 +1351,8 @@ sdhc_1: mmc@c0c4000 {
 			pinctrl-1 = <&sdc1_state_off>;
 			power-domains = <&rpmpd SDM660_VDDCX>;
 
+			qcom,ice = <&ice>;
+
 			bus-width = <8>;
 			non-removable;
 
@@ -1382,6 +1382,12 @@ opp-384000000 {
 			};
 		};
 
+		ice: inline-crypto-engine@c0c8000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0x0c0c8000 0x8000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		usb2: usb@c2f8800 {
 			compatible = "qcom,sdm660-dwc3", "qcom,dwc3";
 			reg = <0x0c2f8800 0x400>;
diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 02f14692dd9d..7c1c01a8fdae 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -416,9 +416,8 @@ qusb2_hstx_trim: hstx-trim@1eb {
 		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sdm670-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x007c4000 0 0x1000>,
-			      <0 0x007c5000 0 0x1000>,
-			      <0 0x007c8000 0 0x8000>;
-			reg-names = "hc", "cqhci", "ice";
+			      <0 0x007c5000 0 0x1000>;
+			reg-names = "hc", "cqhci";
 
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
@@ -427,9 +426,8 @@ sdhc_1: mmc@7c4000 {
 			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_SDCC1_ICE_CORE_CLK>,
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
-			clock-names = "iface", "core", "xo", "ice", "bus";
+			clock-names = "iface", "core", "xo", "bus";
 
 			iommus = <&apps_smmu 0x140 0xf>;
 
@@ -440,10 +438,17 @@ sdhc_1: mmc@7c4000 {
 
 			bus-width = <8>;
 			non-removable;
+			qcom,ice = <&ice>;
 
 			status = "disabled";
 		};
 
+		ice: inline-crypto-engine@7c8000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x007c8000 0 0x8000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		gpi_dma0: dma-controller@800000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..80cf76dc612c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2543,9 +2543,8 @@ mmss_noc: interconnect@1740000 {
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0 0x01d84000 0 0x2500>,
-			      <0 0x01d90000 0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0 0x01d84000 0 0x2500>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -2565,8 +2564,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				"ref_clk",
 				"tx_lane0_sync_clk",
 				"rx_lane0_sync_clk",
-				"rx_lane1_sync_clk",
-				"ice_core_clk";
+				"rx_lane1_sync_clk";
 			clocks =
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
@@ -2575,8 +2573,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
-				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
 				<50000000 200000000>,
 				<0 0>,
@@ -2585,12 +2582,18 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 0>,
-				<0 300000000>;
+				<0 0>;
+			qcom,ice = <&ice>;
 
 			status = "disabled";
 		};
 
+		ice: inline-crypto-engine@1d90000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x01d90000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sdm845-qmp-ufs-phy";
 			reg = <0 0x01d87000 0 0x18c>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 4d6ec815b78b..0ac12c839bc1 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -717,9 +717,8 @@ sram@4690000 {
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0 0x04744000 0x0 0x1000>,
-			      <0x0 0x04745000 0x0 0x1000>,
-			      <0x0 0x04748000 0x0 0x8000>;
-			reg-names = "hc", "cqhci", "ice";
+			      <0x0 0x04745000 0x0 0x1000>;
+			reg-names = "hc", "cqhci";
 
 			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,18 +726,24 @@ sdhc_1: mmc@4744000 {
 
 			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
-				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
-			clock-names = "iface", "core", "xo", "ice";
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
 
 			pinctrl-0 = <&sdc1_state_on>;
 			pinctrl-1 = <&sdc1_state_off>;
 			pinctrl-names = "default", "sleep";
 
 			bus-width = <8>;
+			qcom,ice = <&sdhc_ice>;
 			status = "disabled";
 		};
 
+		sdhc_ice: inline-crypto-engine@4748000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x04748000 0 0x8000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0 0x04784000 0x0 0x1000>;
@@ -784,8 +789,8 @@ opp-202000000 {
 
 		ufs_mem_hc: ufs@4804000 {
 			compatible = "qcom,sm6115-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
-			reg = <0x0 0x04804000 0x0 0x3000>, <0x0 0x04810000 0x0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0x0 0x04804000 0x0 0x3000>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -803,16 +808,14 @@ ufs_mem_hc: ufs@4804000 {
 				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
-				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
 			clock-names = "core_clk",
 				      "bus_aggr_clk",
 				      "iface_clk",
 				      "core_clk_unipro",
 				      "ref_clk",
 				      "tx_lane0_sync_clk",
-				      "rx_lane0_sync_clk",
-				      "ice_core_clk";
+				      "rx_lane0_sync_clk";
 
 			freq-table-hz = <50000000 200000000>,
 					<0 0>,
@@ -820,12 +823,18 @@ ufs_mem_hc: ufs@4804000 {
 					<37500000 150000000>,
 					<0 0>,
 					<0 0>,
-					<0 0>,
-					<75000000 300000000>;
+					<0 0>;
+			qcom,ice = <&ufs_ice>;
 
 			status = "disabled";
 		};
 
+		ufs_ice: inline-crypto-engine@4810000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x04810000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		ufs_mem_phy: phy@4807000 {
 			compatible = "qcom,sm6115-qmp-ufs-phy";
 			reg = <0x0 0x04807000 0x0 0x1c4>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 1e1d366c92c1..ed28f8e3626b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -638,9 +638,8 @@ rng: rng@793000 {
 		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sm6350-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x007c4000 0 0x1000>,
-				<0 0x007c5000 0 0x1000>,
-				<0 0x007c8000 0 0x8000>;
-			reg-names = "hc", "cqhci", "ice";
+				<0 0x007c5000 0 0x1000>;
+			reg-names = "hc", "cqhci";
 
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
@@ -659,6 +658,7 @@ sdhc_1: mmc@7c4000 {
 			bus-width = <8>;
 			non-removable;
 			supports-cqe;
+			qcom,ice = <&sdhc_ice>;
 
 			status = "disabled";
 
@@ -682,6 +682,12 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: inline-crypto-engine@c0c8000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x007c8000 0 0x8000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		gpi_dma0: dma-controller@800000 {
 			compatible = "qcom,sm6350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
@@ -933,9 +939,8 @@ mmss_noc: interconnect@1740000 {
 		ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0 0x01d84000 0 0x3000>,
-			      <0 0x01d90000 0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0 0x01d84000 0 0x3000>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -955,8 +960,7 @@ ufs_mem_hc: ufs@1d84000 {
 				      "ref_clk",
 				      "tx_lane0_sync_clk",
 				      "rx_lane0_sync_clk",
-				      "rx_lane1_sync_clk",
-				      "ice_core_clk";
+				      "rx_lane1_sync_clk";
 			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -964,8 +968,7 @@ ufs_mem_hc: ufs@1d84000 {
 				 <&rpmhcc RPMH_QLINK_CLK>,
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
-				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
 				<50000000 200000000>,
 				<0 0>,
@@ -974,8 +977,8 @@ ufs_mem_hc: ufs@1d84000 {
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-				<0 0>,
 				<0 0>;
+			qcom,ice = <&ufs_ice>;
 
 			status = "disabled";
 		};
@@ -1007,6 +1010,12 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		ufs_ice: inline-crypto-engine@1d90000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x01d90000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sm6350-ipa";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index fd20096cfc6e..844c7b80d205 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1983,9 +1983,8 @@ pcie1_lane: phy@1c0e200 {
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0 0x01d84000 0 0x2500>,
-			      <0 0x01d90000 0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0 0x01d84000 0 0x2500>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -2004,8 +2003,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				"ref_clk",
 				"tx_lane0_sync_clk",
 				"rx_lane0_sync_clk",
-				"rx_lane1_sync_clk",
-				"ice_core_clk";
+				"rx_lane1_sync_clk";
 			clocks =
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
@@ -2014,8 +2012,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
-				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
 				<37500000 300000000>,
 				<0 0>,
@@ -2024,8 +2021,8 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 0>,
-				<0 300000000>;
+				<0 0>;
+			qcom,ice = <&ice>;
 
 			status = "disabled";
 		};
@@ -2057,6 +2054,12 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		ice: inline-crypto-engine@1d90000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x01d90000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1a744a33bcf4..8ebe6184a9c3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3989,9 +3989,8 @@ system-cache-controller@19200000 {
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-			reg = <0 0x01d84000 0 0x3000>,
-			      <0 0x01d88000 0 0x8000>;
-			reg-names = "std", "ice";
+			reg = <0 0x01d84000 0 0x3000>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
@@ -4015,8 +4014,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				"ref_clk",
 				"tx_lane0_sync_clk",
 				"rx_lane0_sync_clk",
-				"rx_lane1_sync_clk",
-				"ice_core_clk";
+				"rx_lane1_sync_clk";
 			clocks =
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
@@ -4025,8 +4023,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
-				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
 				<75000000 300000000>,
 				<0 0>,
@@ -4035,8 +4032,9 @@ ufs_mem_hc: ufshc@1d84000 {
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+				<0 0>;
+			qcom,ice = <&ice>;
+
 			status = "disabled";
 		};
 
@@ -4066,6 +4064,12 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		ice: inline-crypto-engine@1d88000 {
+			compatible = "qcom,inline-crypto-engine";
+			reg = <0 0x01d88000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.34.1

