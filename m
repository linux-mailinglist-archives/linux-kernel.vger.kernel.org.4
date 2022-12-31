Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41965A446
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiLaM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiLaM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:19 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF1A95B5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:18 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so35166360lfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNv+AayRgEP2hIxnzst42s6qKfcZMM4RXSAyHy1K9G4=;
        b=iiOrpMY3w/TTbypkaSZHyRFyhzS5ObSH/eR4zV4HAkNCnI9zY+xVtU/3LS6fknbrH3
         piIXpyKIXMTWjG2G0HnDdHFozuY5+ftZ0MXoesnv0Q7oEhVn9mUOql2sjj/nQd1SABgE
         +DnTu54G5rxwyfGD8/qKs17b4ufqhApFyT7Un/PTw3v23DDi4fBpvLRz6UsrHGeoBvk+
         XlOgnJHlTQM/ui//CCF7vc9lAvAt2T5ZTWOShtwXKy8R/LoX7gZhdFoil7H+UmL9tUeM
         gEio07V6A9BY63LuGs5sEI2eVwPEzE4BOYyoQolmnLC1bSyIpXfgL8fpVIloM2Bsl5St
         hQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNv+AayRgEP2hIxnzst42s6qKfcZMM4RXSAyHy1K9G4=;
        b=xDdhQ6uatIU3ACTn5cDnjG26pojctj4R7K3olccpJhrKbWo8Je+2Sg5rWILh3RY96I
         1W52+sgJC1bvg3w+RJUoQ/Rq5/5mWP3vkRxYO3Xj/jIy/XEXtDscZea482bZhw08Sw6l
         zTSfYrUJLSksmgH9BNPlP0C646kd6tbjhni2/Bg0SXNDYgVUsT8KfXIz49cBq+vz/wz7
         osiP93pl+VNSJpwzvWYEFdyP77LQMVlf6LrvUq5epOQtVmXze+zhD06i0oCJXb5izmzk
         9SuRXXRNgRltcuPOmbYL45p3C6ROCZQWAvf/8z7jeO0pzZyrKYgLPetLynPb5vB8i4YD
         iglg==
X-Gm-Message-State: AFqh2kpPFn5VHrzVp1jgMaxvZ7bSG3OzFcauEp8Sse4girqqCgbYWntx
        efgWFy+Asw+EgzNZigwhl/0W/w==
X-Google-Smtp-Source: AMrXdXvBXBFn0BdIQmVWY9ZjxUjycuef0AXYuWEwfXq/BVNQwH7N1rqZ8Lf4kRvdHoR76cuuimycnw==
X-Received: by 2002:a05:6512:695:b0:4b5:8502:efb4 with SMTP id t21-20020a056512069500b004b58502efb4mr12175038lfe.69.1672491556888;
        Sat, 31 Dec 2022 04:59:16 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:16 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] arm64: dts: qcom: ipq6018: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:58:54 +0100
Message-Id: <20221231125911.437599-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 67 ++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2ceae73a6069..17e15a06254f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -146,7 +146,7 @@ reserved-memory {
 		ranges;
 
 		rpm_msg_ram: memory@60000 {
-			reg = <0x0 0x60000 0x0 0x6000>;
+			reg = <0x0 0x00060000 0x0 0x6000>;
 			no-map;
 		};
 
@@ -181,7 +181,7 @@ soc: soc {
 
 		prng: qrng@e1000 {
 			compatible = "qcom,prng-ee";
-			reg = <0x0 0xe3000 0x0 0x1000>;
+			reg = <0x0 0x000e3000 0x0 0x1000>;
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "core";
 		};
@@ -366,6 +366,49 @@ qpic_nand: nand-controller@79b0000 {
 			status = "disabled";
 		};
 
+		usb3: usb@8af8800 {
+			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
+			reg = <0x0 0x08af8800 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+				 <&gcc GCC_USB0_MASTER_CLK>,
+				 <&gcc GCC_USB0_SLEEP_CLK>,
+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+					  <&gcc GCC_USB0_MASTER_CLK>,
+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <133330000>,
+					       <133330000>,
+					       <20000000>;
+
+			resets = <&gcc GCC_USB0_BCR>;
+			status = "disabled";
+
+			dwc_0: usb@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x08a00000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_0>, <&usb0_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				clocks = <&xo>;
+				clock-names = "ref";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				dr_mode = "host";
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			#address-cells = <2>;
@@ -388,7 +431,7 @@ v2m@0 {
 
 		pcie_phy: phy@84000 {
 			compatible = "qcom,ipq6018-qmp-pcie-phy";
-			reg = <0x0 0x84000 0x0 0x1bc>; /* Serdes PLL */
+			reg = <0x0 0x00084000 0x0 0x1bc>; /* Serdes PLL */
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -404,10 +447,10 @@ pcie_phy: phy@84000 {
 				      "common";
 
 			pcie_phy0: phy@84200 {
-				reg = <0x0 0x84200 0x0 0x16c>, /* Serdes Tx */
-				      <0x0 0x84400 0x0 0x200>, /* Serdes Rx */
-				      <0x0 0x84800 0x0 0x1f0>, /* PCS: Lane0, COM, PCIE */
-				      <0x0 0x84c00 0x0 0xf4>; /* pcs_misc */
+				reg = <0x0 0x00084200 0x0 0x16c>, /* Serdes Tx */
+				      <0x0 0x00084400 0x0 0x200>, /* Serdes Rx */
+				      <0x0 0x00084800 0x0 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x0 0x00084c00 0x0 0xf4>; /* pcs_misc */
 				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
@@ -623,7 +666,7 @@ mdio: mdio@90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "qcom,ipq6018-mdio", "qcom,ipq4019-mdio";
-			reg = <0x0 0x90000 0x0 0x64>;
+			reg = <0x0 0x00090000 0x0 0x64>;
 			clocks = <&gcc GCC_MDIO_AHB_CLK>;
 			clock-names = "gcc_mdio_ahb_clk";
 			status = "disabled";
@@ -631,7 +674,7 @@ mdio: mdio@90000 {
 
 		qusb_phy_1: qusb@59000 {
 			compatible = "qcom,ipq6018-qusb2-phy";
-			reg = <0x0 0x059000 0x0 0x180>;
+			reg = <0x0 0x00059000 0x0 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
@@ -664,7 +707,7 @@ usb2: usb@70f8800 {
 
 			dwc_1: usb@7000000 {
 			       compatible = "snps,dwc3";
-			       reg = <0x0 0x7000000 0x0 0xcd00>;
+			       reg = <0x0 0x07000000 0x0 0xcd00>;
 			       interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			       phys = <&qusb_phy_1>;
 			       phy-names = "usb2-phy";
@@ -679,7 +722,7 @@ dwc_1: usb@7000000 {
 
 		ssphy_0: ssphy@78000 {
 			compatible = "qcom,ipq6018-qmp-usb3-phy";
-			reg = <0x0 0x78000 0x0 0x1c4>;
+			reg = <0x0 0x00078000 0x0 0x1c4>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -708,7 +751,7 @@ usb0_ssphy: phy@78200 {
 
 		qusb_phy_0: qusb@79000 {
 			compatible = "qcom,ipq6018-qusb2-phy";
-			reg = <0x0 0x079000 0x0 0x180>;
+			reg = <0x0 0x00079000 0x0 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
-- 
2.39.0

