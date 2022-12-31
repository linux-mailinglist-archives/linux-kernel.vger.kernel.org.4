Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539CD65A452
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiLaNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiLaM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155BE0C9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so35151879lfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN/hLZnkm6i7NDpSeMqcE2pY0msD2ScAGrfZFu9zT8U=;
        b=WhHYXQrz5UnwXEzZxaXTD5c6uCWmsB/gV8Kpi0wuduSzPnrUoNq7grlLJpKBbPf0WR
         hUbrui+EoF7hSWbUt0TKTof7khAYRCPAYpnGZRf38PuR1pDMO7cSw8WCGRBaUYxVTlOH
         v1XgR6lKkwKC9oXiam4id/8J6xOSsDAAddkIJQdBClEm4ynfk5P+n2a3xZ4Tpll6HsRB
         VrQiZ1cl9oxyEhSShlkwjFeXxd13DhbSHHwTPI4Vh5GwlEvpZwO59C5JPKta7/O+WIP2
         yhMTxoo+i8Z9+xvnD9+/cK1yGbKs8DmQFM+t+r9z3M+oE8yygCSIErsgBFHBxoxGl3Db
         km9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CN/hLZnkm6i7NDpSeMqcE2pY0msD2ScAGrfZFu9zT8U=;
        b=W09kFY/h0ZBQ/Nl8MzDNKVpap0VY5z33SEIQuO0/UIJOTCOM+rJHcIXtzSEuG20Qmo
         qRgDcFKmOdgEjISuB6uW+z4dy87kNnaWrd550da1gUL1kM1nD/H1dmteZL1Hp1kGOiwa
         Cat9ZkkXZhhAx40UeRP9QM6UllRG0t/Ey0GSEwHB2eWADaQudZSa5WQaq1Q98c7uovEf
         OhBQ27FJbc5zO+xnQ2a1CslYDluUo1/zif9djagztHzJEj5byiEXWcH0E/9ghl+LWMya
         Xn55dZI6FIlYekB4Dyvgsqy8qj7co5SsK73Qm+2BNBTrZQL0zuChcNnAvVXXWSaJ93b2
         eRNw==
X-Gm-Message-State: AFqh2koOK7rEadzYnnJfYPD45Slz+fUQ9CB1jcs12BYCnmdIWHEBCBuP
        8YsANhKfD+rDuI/wi+BIfSzF9A==
X-Google-Smtp-Source: AMrXdXtgLabwFkaMX/MMiA42JP6Rt0BapwjHbMwTiW6BK6W+nr8z2mOa0NKRGpu3rG04HoBFSeEZYQ==
X-Received: by 2002:a05:6512:251f:b0:4a4:68b7:dec0 with SMTP id be31-20020a056512251f00b004a468b7dec0mr11408386lfb.28.1672491580642;
        Sat, 31 Dec 2022 04:59:40 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:40 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] arm64: dts: qcom: sm8450: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:09 +0100
Message-Id: <20221231125911.437599-17-konrad.dybcio@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2194bbac8ee0..bca859cde31c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -743,7 +743,7 @@ gcc: clock-controller@100000 {
 		gpi_dma2: dma-controller@800000 {
 			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
 			#dma-cells = <3>;
-			reg = <0 0x800000 0 0x60000>;
+			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
@@ -1064,7 +1064,7 @@ spi21: spi@898000 {
 		gpi_dma0: dma-controller@900000 {
 			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
 			#dma-cells = <3>;
-			reg = <0 0x900000 0 0x60000>;
+			reg = <0 0x00900000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
@@ -1345,7 +1345,7 @@ spi5: spi@994000 {
 
 			i2c6: i2c@998000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0x0 0x998000 0x0 0x4000>;
+				reg = <0x0 0x00998000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				pinctrl-names = "default";
@@ -1365,7 +1365,7 @@ i2c6: i2c@998000 {
 
 			spi6: spi@998000 {
 				compatible = "qcom,geni-spi";
-				reg = <0x0 0x998000 0x0 0x4000>;
+				reg = <0x0 0x00998000 0x0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
@@ -1400,7 +1400,7 @@ uart7: serial@99c000 {
 		gpi_dma1: dma-controller@a00000 {
 			compatible = "qcom,sm8450-gpi-dma", "qcom,sm6350-gpi-dma";
 			#dma-cells = <3>;
-			reg = <0 0xa00000 0 0x60000>;
+			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
@@ -1810,10 +1810,10 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 
 			pcie0_lane: phy@1c06200 {
-				reg = <0 0x1c06e00 0 0x200>, /* tx */
-				      <0 0x1c07000 0 0x200>, /* rx */
-				      <0 0x1c06200 0 0x200>, /* pcs */
-				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
+				reg = <0 0x01c06e00 0 0x200>, /* tx */
+				      <0 0x01c07000 0 0x200>, /* rx */
+				      <0 0x01c06200 0 0x200>, /* pcs */
+				      <0 0x01c06600 0 0x200>; /* pcs_pcie */
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -1917,12 +1917,12 @@ pcie1_phy: phy@1c0f000 {
 			status = "disabled";
 
 			pcie1_lane: phy@1c0e000 {
-				reg = <0 0x1c0e000 0 0x200>, /* tx */
-				      <0 0x1c0e200 0 0x300>, /* rx */
-				      <0 0x1c0f200 0 0x200>, /* pcs */
-				      <0 0x1c0e800 0 0x200>, /* tx */
-				      <0 0x1c0ea00 0 0x300>, /* rx */
-				      <0 0x1c0f400 0 0xc00>; /* pcs_pcie */
+				reg = <0 0x01c0e000 0 0x200>, /* tx */
+				      <0 0x01c0e200 0 0x300>, /* rx */
+				      <0 0x01c0f200 0 0x200>, /* pcs */
+				      <0 0x01c0e800 0 0x200>, /* tx */
+				      <0 0x01c0ea00 0 0x300>, /* rx */
+				      <0 0x01c0f400 0 0xc00>; /* pcs_pcie */
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -2147,7 +2147,7 @@ swr4: soundwire-controller@31f0000 {
 
 		rxmacro: codec@3200000 {
 			compatible = "qcom,sm8450-lpass-rx-macro";
-			reg = <0 0x3200000 0 0x1000>;
+			reg = <0 0x03200000 0 0x1000>;
 			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
@@ -2168,7 +2168,7 @@ rxmacro: codec@3200000 {
 
 		swr1: soundwire-controller@3210000 {
 			compatible = "qcom,soundwire-v1.7.0";
-			reg = <0 0x3210000 0 0x2000>;
+			reg = <0 0x03210000 0 0x2000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rxmacro>;
 			clock-names = "iface";
@@ -2193,7 +2193,7 @@ swr1: soundwire-controller@3210000 {
 
 		txmacro: codec@3220000 {
 			compatible = "qcom,sm8450-lpass-tx-macro";
-			reg = <0 0x3220000 0 0x1000>;
+			reg = <0 0x03220000 0 0x1000>;
 			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
@@ -2260,7 +2260,7 @@ swr0: soundwire-controller@3250000 {
 
 		swr2: soundwire-controller@33b0000 {
 			compatible = "qcom,soundwire-v1.7.0";
-			reg = <0 0x33b0000 0 0x2000>;
+			reg = <0 0x033b0000 0 0x2000>;
 			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core", "wake";
@@ -2555,7 +2555,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 		cci0: cci@ac15000 {
 			compatible = "qcom,sm8450-cci", "qcom,msm8996-cci";
-			reg = <0 0xac15000 0 0x1000>;
+			reg = <0 0x0ac15000 0 0x1000>;
 			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
 			power-domains = <&camcc TITAN_TOP_GDSC>;
 
@@ -2594,7 +2594,7 @@ cci0_i2c1: i2c-bus@1 {
 
 		cci1: cci@ac16000 {
 			compatible = "qcom,sm8450-cci", "qcom,msm8996-cci";
-			reg = <0 0xac16000 0 0x1000>;
+			reg = <0 0x0ac16000 0 0x1000>;
 			interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
 			power-domains = <&camcc TITAN_TOP_GDSC>;
 
@@ -3259,8 +3259,8 @@ qup_uart20_default: qup-uart20-default-state {
 
 		lpass_tlmm: pinctrl@3440000{
 			compatible = "qcom,sm8450-lpass-lpi-pinctrl";
-			reg = <0 0x3440000 0x0 0x20000>,
-			      <0 0x34d0000 0x0 0x10000>;
+			reg = <0 0x03440000 0x0 0x20000>,
+			      <0 0x034d0000 0x0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 23>;
@@ -3847,7 +3847,7 @@ nsp_noc: interconnect@320c0000 {
 
 		lpass_ag_noc: interconnect@3c40000 {
 			compatible = "qcom,sm8450-lpass-ag-noc";
-			reg = <0 0x3c40000 0 0x17200>;
+			reg = <0 0x03c40000 0 0x17200>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
-- 
2.39.0

