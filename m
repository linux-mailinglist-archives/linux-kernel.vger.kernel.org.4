Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1765AF0D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjABJsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjABJrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA4D192
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:47:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so40882953lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGitGqzuYYMN53mCrBG65A07QgCZ4AaVGnP9QT97bjg=;
        b=PvB7rtsbZfkbliBIZuC75oF2rrhGkUXfX2S6lX2VqNmOQovUUJLLdlQDx0iNzkeexc
         zQUck6BMuMeHhfL0Kq3hRDhABnwHxTvE+UDeNEiHVB9vBwyx8I8FOa+z88w4qBOpr/sR
         3A3XkjtRerzxu5wZkQusC95s4DB/tWIIh6XKHBzrJU5KyZo3/NeOjFZRi7hoxYGhvTiJ
         3bRJzfLMyDVnR4Jr0k7+WhJI5bQFoP9XSd+KUhpy3qI5fg23rAMByic69OTjjg+woWzX
         qEku1KTiMdOUOgbgr3jD797Rnk7sdKHgfUeDkZzuRQgAkgSBpHnrlgPumjewN7Utmvwu
         egAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGitGqzuYYMN53mCrBG65A07QgCZ4AaVGnP9QT97bjg=;
        b=dWg0smmJqg0luUbP54WXNDwJm6B+litPb4mk4hVgT8p+cGPAUZyJMIBN2HnzOsaKyT
         +bPZs5UgMVtUkAHTdCwqY7lK+CSa5JUbxggL/ajjwJzOAQMfDhrpl/KSkfANcGPVUrAK
         KMK0Agw2DvEzY9coAk+2nA0L6DEFu5xs/rYBriiKQwE1LuU/rLrrN8i6H9Hu4XSq2gAr
         hBHjXM9reAmy3+5ZqS93Wmht04qbAou/kEm8bsFpqE+AYi4mqQRwtpGYXMYR58qTmQuT
         iYFeik7/XRCAYg/v4t90d48wEgudtSN8qw7WzHNbDtrWoT5MxBmUo2ootAtvkV+X81B+
         64Ig==
X-Gm-Message-State: AFqh2kqKQHT/+DFGf3505GyhzfgSTZ1Jmw0dLn7J2vp0SqKposLptZ+e
        Tf8CoL6nv7sGnbKlEluH6AQHmw==
X-Google-Smtp-Source: AMrXdXvAZSHsweet1srKZ0pkAfr4qp+oWo955TFhuaQlRRiBl1sXjE27ETZYvu5h+UJHsnBcd+MfWw==
X-Received: by 2002:ac2:4ac3:0:b0:4b5:7e4c:dcea with SMTP id m3-20020ac24ac3000000b004b57e4cdceamr14130346lfp.51.1672652824807;
        Mon, 02 Jan 2023 01:47:04 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:47:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] arm64: dts: qcom: sm8450: Pad addresses to 8 hex digits
Date:   Mon,  2 Jan 2023 10:46:40 +0100
Message-Id: <20230102094642.74254-16-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
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
v1 -> v2:
No changes

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

