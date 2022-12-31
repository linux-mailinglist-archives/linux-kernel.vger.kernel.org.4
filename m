Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE865A46E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiLaM74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiLaM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDFADF37
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so35166777lfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78M1VxkQEgQNebOsb03CLOsZ6h3IoIME+2i3SA10AUc=;
        b=JsbqEg2xBIlO+eNhcLxSDSjYImIEBJseBQyGVnC8ET7O5CxtWmmNRlUOmYcfhCpMDw
         Sgok/K995BLBqyiPk1DvUPPjvJRyVvZfA1ne8MBwuAuKDOXBaPRgViI1gt1lXSep5wWD
         W5XWQYX8uYFId0c4OLmq42gqLxfieq7wI12XgVZpcbPvoEn9MWs1cS2U7t4PXz8NdBsw
         4zSIInsiRekgzEJMpMC5/QJ9DNSysvEd4iCwnuwB2tCcgaeJtGPDcR4dmHIq8DteBzJY
         jNU6sKMwX+Hb2EEQLWCz4yKqIESpUTCdVu7xi6oE8J1k7DIVgIZmE3ptsKHldfKF+nWP
         lx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78M1VxkQEgQNebOsb03CLOsZ6h3IoIME+2i3SA10AUc=;
        b=Occ4ldJpuPTehj0lnm5WYQASFWgqxdEeHwiKCGMYjAfc35vasjc1KkixUTRIqJTYML
         ghD724Ga4nqyQKBcFr0GnsP94IHymeqsjryIXKVTkoGJujI/FT/aEultssnLJeGJ6LlQ
         lSQU4bS5I5ZloLqrnEJAaSflpPCP/h07jbehwXUKE5U74S4k9XlPhDSoryAPPusejalf
         hHe3YSiE2PppkIqrd3rFXjagPZism6SC/on4SuaurvWpqErpgtYH3lMMjzQOLF7OTQdS
         4ESIgVnAqkC+xfFzcpk4+PjrifXmpNwJ0WgOfYWm9rxT7mmgNVB7tP60Azsaam0bg6LD
         VnNA==
X-Gm-Message-State: AFqh2kpvm5np08OE4YNEJ/+o/HLql6VhXh0mO6xNKnFLoVJ3qkOUKnv8
        /7/Ps8Gy0TSopPOtrZLiW/DVMw==
X-Google-Smtp-Source: AMrXdXv3NGucrRM96rJoO+BMTJsZId34ZybUdp3HjJo7DWDPntc7Bnr8NluLohCsPEej/eBsAJd1QQ==
X-Received: by 2002:a05:6512:38cc:b0:4a4:68b9:19f0 with SMTP id p12-20020a05651238cc00b004a468b919f0mr8228687lft.24.1672491567652;
        Sat, 31 Dec 2022 04:59:27 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] arm64: dts: qcom: sm8150: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:01 +0100
Message-Id: <20221231125911.437599-9-konrad.dybcio@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 68 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 73f39bbeab13..f6b16c31e8b0 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -890,7 +890,7 @@ gcc: clock-controller@100000 {
 
 		gpi_dma0: dma-controller@800000 {
 			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
-			reg = <0 0x800000 0 0x60000>;
+			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
@@ -979,7 +979,7 @@ i2c0: i2c@880000 {
 
 			spi0: spi@880000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x880000 0 0x4000>;
+				reg = <0 0x00880000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
@@ -1013,7 +1013,7 @@ i2c1: i2c@884000 {
 
 			spi1: spi@884000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x884000 0 0x4000>;
+				reg = <0 0x00884000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
@@ -1047,7 +1047,7 @@ i2c2: i2c@888000 {
 
 			spi2: spi@888000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x888000 0 0x4000>;
+				reg = <0 0x00888000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
@@ -1081,7 +1081,7 @@ i2c3: i2c@88c000 {
 
 			spi3: spi@88c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x88c000 0 0x4000>;
+				reg = <0 0x0088c000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
@@ -1115,7 +1115,7 @@ i2c4: i2c@890000 {
 
 			spi4: spi@890000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x890000 0 0x4000>;
+				reg = <0 0x00890000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
@@ -1149,7 +1149,7 @@ i2c5: i2c@894000 {
 
 			spi5: spi@894000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x894000 0 0x4000>;
+				reg = <0 0x00894000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
@@ -1183,7 +1183,7 @@ i2c6: i2c@898000 {
 
 			spi6: spi@898000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x898000 0 0x4000>;
+				reg = <0 0x00898000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
@@ -1217,7 +1217,7 @@ i2c7: i2c@89c000 {
 
 			spi7: spi@89c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0x89c000 0 0x4000>;
+				reg = <0 0x0089c000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
@@ -1236,7 +1236,7 @@ spi7: spi@89c000 {
 
 		gpi_dma1: dma-controller@a00000 {
 			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
-			reg = <0 0xa00000 0 0x60000>;
+			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
@@ -1287,7 +1287,7 @@ i2c8: i2c@a80000 {
 
 			spi8: spi@a80000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xa80000 0 0x4000>;
+				reg = <0 0x00a80000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
@@ -1321,7 +1321,7 @@ i2c9: i2c@a84000 {
 
 			spi9: spi@a84000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xa84000 0 0x4000>;
+				reg = <0 0x00a84000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
@@ -1355,7 +1355,7 @@ i2c10: i2c@a88000 {
 
 			spi10: spi@a88000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xa88000 0 0x4000>;
+				reg = <0 0x00a88000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
@@ -1389,7 +1389,7 @@ i2c11: i2c@a8c000 {
 
 			spi11: spi@a8c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xa8c000 0 0x4000>;
+				reg = <0 0x00a8c000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
@@ -1432,7 +1432,7 @@ i2c12: i2c@a90000 {
 
 			spi12: spi@a90000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xa90000 0 0x4000>;
+				reg = <0 0x00a90000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
@@ -1450,7 +1450,7 @@ spi12: spi@a90000 {
 
 			i2c16: i2c@94000 {
 				compatible = "qcom,geni-i2c";
-				reg = <0 0x0094000 0 0x4000>;
+				reg = <0 0x00094000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_I2C>,
@@ -1466,7 +1466,7 @@ i2c16: i2c@94000 {
 
 			spi16: spi@a94000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xa94000 0 0x4000>;
+				reg = <0 0x00a94000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
@@ -1485,7 +1485,7 @@ spi16: spi@a94000 {
 
 		gpi_dma2: dma-controller@c00000 {
 			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
-			reg = <0 0xc00000 0 0x60000>;
+			reg = <0 0x00c00000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
@@ -1537,7 +1537,7 @@ i2c17: i2c@c80000 {
 
 			spi17: spi@c80000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xc80000 0 0x4000>;
+				reg = <0 0x00c80000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
@@ -1571,7 +1571,7 @@ i2c18: i2c@c84000 {
 
 			spi18: spi@c84000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xc84000 0 0x4000>;
+				reg = <0 0x00c84000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
@@ -1605,7 +1605,7 @@ i2c19: i2c@c88000 {
 
 			spi19: spi@c88000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xc88000 0 0x4000>;
+				reg = <0 0x00c88000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
@@ -1639,7 +1639,7 @@ i2c13: i2c@c8c000 {
 
 			spi13: spi@c8c000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xc8c000 0 0x4000>;
+				reg = <0 0x00c8c000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
@@ -1673,7 +1673,7 @@ i2c14: i2c@c90000 {
 
 			spi14: spi@c90000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xc90000 0 0x4000>;
+				reg = <0 0x00c90000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
@@ -1707,7 +1707,7 @@ i2c15: i2c@c94000 {
 
 			spi15: spi@c94000 {
 				compatible = "qcom,geni-spi";
-				reg = <0 0xc94000 0 0x4000>;
+				reg = <0 0x00c94000 0 0x4000>;
 				reg-names = "se";
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
@@ -1864,10 +1864,10 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 
 			pcie0_lane: phy@1c06200 {
-				reg = <0 0x1c06200 0 0x170>, /* tx */
-				      <0 0x1c06400 0 0x200>, /* rx */
-				      <0 0x1c06800 0 0x1f0>, /* pcs */
-				      <0 0x1c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
+				reg = <0 0x01c06200 0 0x170>, /* tx */
+				      <0 0x01c06400 0 0x200>, /* rx */
+				      <0 0x01c06800 0 0x1f0>, /* pcs */
+				      <0 0x01c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -1963,12 +1963,12 @@ pcie1_phy: phy@1c0e000 {
 			status = "disabled";
 
 			pcie1_lane: phy@1c0e200 {
-				reg = <0 0x1c0e200 0 0x170>, /* tx0 */
-				      <0 0x1c0e400 0 0x200>, /* rx0 */
-				      <0 0x1c0ea00 0 0x1f0>, /* pcs */
-				      <0 0x1c0e600 0 0x170>, /* tx1 */
-				      <0 0x1c0e800 0 0x200>, /* rx1 */
-				      <0 0x1c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
+				reg = <0 0x01c0e200 0 0x170>, /* tx0 */
+				      <0 0x01c0e400 0 0x200>, /* rx0 */
+				      <0 0x01c0ea00 0 0x1f0>, /* pcs */
+				      <0 0x01c0e600 0 0x170>, /* tx1 */
+				      <0 0x01c0e800 0 0x200>, /* rx1 */
+				      <0 0x01c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe0";
 
-- 
2.39.0

