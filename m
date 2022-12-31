Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2A65A45F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiLaM7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiLaM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE0DF2F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so35148872lfv.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/9bby3DWd3dWz/InPeenJUVaq5sEhXAemeGeo/+3GU=;
        b=mIN0+aN99pKsa50fwnt9vB5WKVZiROfWwL3FA55cyQdmpwJ4pt5Wk5S0HMSWsiKyFd
         mtJyUzPurWgMvRcj7iBZC7z6c6CoEryVzQOElRmK7VSZUW4KF+GwWRLVN4f1rrU0QFrC
         3AJUnuOYbUdBOhhUWS4G1RDtGtn84sgSGo/bpPhIf/UsI+zmYyWnMVH3mW5RfcLzwhO1
         nVIUYvedbj0uajH1pICvzjg0nc0caI3CZHGFUbuUB6wn+asbWZjLEVdtJKywMlVh2vBH
         RnLhrVxDtcdn8F/D6FvSWfNGw1nL+JPg98FXDN0JSiR6jzTIcuAW0niuE107DIshZtmD
         1dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/9bby3DWd3dWz/InPeenJUVaq5sEhXAemeGeo/+3GU=;
        b=PkV2pl4uAoGvvFLfL7c/G9b3v6LB4+RpQAkdaf6BwFs6PYm5apQjJQdh1sJvC5IXF4
         LLRgG+htBhlL0AOpaN/MdldjMX2SSK0Sz3mNCOEsL/npPGzZf9Sxny0ijT+Z9ISigXBb
         OJuq3RT8LgF/gB4og7dASxNj/+alYSVXY4CS5OJl2T/WgFvFQuMozoFzkYCoLDsorPmF
         TQsW7tcq5z+mgm2upF+0zZt7bLa6KTSi1cpTwLogMOjGSMJecXc2uqaqNBbzoFV/MIu3
         rhrKqdlZ4Tkk5V636z2F8svkzvEaP5B6L6u2g+9BAw0RBVlE73y4XFobElEb9up9PMat
         J3+g==
X-Gm-Message-State: AFqh2kqUDigsY8JSNcXHPpFd0tLqJQj+jr4sdb4hGv7m+ANsjy6Df+X9
        Qrde+AaOQcDvGEa+nblgoMXtzg==
X-Google-Smtp-Source: AMrXdXsjfDJYd+NMRGU2ohVgHg4Vd2911GOwCOPB/e9ubWJY/uokYdhekdo31kewBSlHETd7lp8d6w==
X-Received: by 2002:a05:6512:169e:b0:4ca:fa2d:2686 with SMTP id bu30-20020a056512169e00b004cafa2d2686mr9357045lfb.35.1672491561674;
        Sat, 31 Dec 2022 04:59:21 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:21 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] arm64: dts: qcom: ipq6018: Fix up some indentation
Date:   Sat, 31 Dec 2022 13:58:57 +0100
Message-Id: <20221231125911.437599-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some properties were not indented consistently. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 40 +++++++++++++--------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2026000f3dc7..5452bb85f8e1 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -249,7 +249,7 @@ qusb_phy_0: qusb@79000 {
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
-				<&xo>;
+				 <&xo>;
 			clock-names = "cfg_ahb", "ref";
 
 			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
@@ -265,11 +265,11 @@ pcie_phy: phy@84000 {
 			ranges;
 
 			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
-				<&gcc GCC_PCIE0_AHB_CLK>;
+				 <&gcc GCC_PCIE0_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
 
 			resets = <&gcc GCC_PCIE0_PHY_BCR>,
-				<&gcc GCC_PCIE0PHY_PHY_BCR>;
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
 			reset-names = "phy",
 				      "common";
 
@@ -319,8 +319,8 @@ crypto: crypto@73a000 {
 			compatible = "qcom,crypto-v5.1";
 			reg = <0x0 0x0073a000 0x0 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
-				<&gcc GCC_CRYPTO_AXI_CLK>,
-				<&gcc GCC_CRYPTO_CLK>;
+				 <&gcc GCC_CRYPTO_AXI_CLK>,
+				 <&gcc GCC_CRYPTO_CLK>;
 			clock-names = "iface", "bus", "core";
 			dmas = <&cryptobam 2>, <&cryptobam 3>;
 			dma-names = "rx", "tx";
@@ -425,7 +425,7 @@ blsp1_uart3: serial@78b1000 {
 			reg = <0x0 0x078b1000 0x0 0x200>;
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
+				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
 		};
@@ -438,7 +438,7 @@ blsp1_spi1: spi@78b5000 {
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
+				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
@@ -453,7 +453,7 @@ blsp1_spi2: spi@78b6000 {
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
+				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
@@ -511,8 +511,8 @@ qpic_nand: nand-controller@79b0000 {
 			clock-names = "core", "aon";
 
 			dmas = <&qpic_bam 0>,
-				<&qpic_bam 1>,
-				<&qpic_bam 2>;
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
 			dma-names = "tx", "rx", "cmd";
 			pinctrl-0 = <&qpic_pins>;
 			pinctrl-names = "default";
@@ -527,13 +527,13 @@ usb3: usb@8af8800 {
 			ranges;
 
 			clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
-				<&gcc GCC_USB0_MASTER_CLK>,
-				<&gcc GCC_USB0_SLEEP_CLK>,
-				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
+				 <&gcc GCC_USB0_MASTER_CLK>,
+				 <&gcc GCC_USB0_SLEEP_CLK>,
+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
 			clock-names = "cfg_noc",
-				"core",
-				"sleep",
-				"mock_utmi";
+				      "core",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
 					  <&gcc GCC_USB0_MASTER_CLK>,
@@ -568,10 +568,10 @@ intc: interrupt-controller@b000000 {
 			#size-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <0x3>;
-			reg =   <0x0 0x0b000000 0x0 0x1000>,  /*GICD*/
-				<0x0 0x0b002000 0x0 0x1000>,  /*GICC*/
-				<0x0 0x0b001000 0x0 0x1000>,  /*GICH*/
-				<0x0 0x0b004000 0x0 0x1000>;  /*GICV*/
+			reg = <0x0 0x0b000000 0x0 0x1000>,  /*GICD*/
+			      <0x0 0x0b002000 0x0 0x1000>,  /*GICC*/
+			      <0x0 0x0b001000 0x0 0x1000>,  /*GICH*/
+			      <0x0 0x0b004000 0x0 0x1000>;  /*GICV*/
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			ranges = <0 0 0 0xb00a000 0 0xffd>;
 
-- 
2.39.0

