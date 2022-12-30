Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03FF659905
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiL3NvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiL3Nuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:50:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C5FCE5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:50:50 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j17so22314351lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2/2jOnIdgfpiRmuRufEzJYHjtQ3vKnVr2N275LNLNE=;
        b=aFVspPxaSscubi+efbD4srElPxlFOvXfo9Q31ohxiKqaGpnkmQ/SCPE6uf6BXFdKvf
         9LZ7X+34lZcssBcRQYy05HJI+r3xoTKWy3mht13TZDQk3EYKZtixOeEuQGIi9lYBsfWz
         BnIWxqD9mIJCYubRyUPSi4/+GlcG+qSQqkRow3n/2+nQmYqIQ9rifN5mjf33yIXQnyYc
         bvbta1L7A5jc8DREFhGhXf3yIbHWMHgpVzAxEIMIVi8ej34FmE3jak3PvQQGTDjh/lbP
         GLw8JA+6lm0vlu0kAIoGRwaxJ0eNmHGB4jyWx48Nf7TGBfwmO3U4s+CY8JVLD8LGv3+B
         a8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2/2jOnIdgfpiRmuRufEzJYHjtQ3vKnVr2N275LNLNE=;
        b=Z/P7f7ukf3LT6NgcldatxbyhPHwzHW3VSc3Tc6EMlZNliCKp5xqR79l4KIaVUGa4ji
         j5LM/AGEz84yTbF8rnYigochAJw98N4i0Ll2mmGWWRMhCSY6IiRDGuhlaeIj2A6O4+Yu
         tJ63zT2g9cGuW6n/8Zge63MvRR1CJdQS90me4nXgEuxEd8TZ3EfhR5G+MtdDAOwtVVNs
         aMDySaRb1EOfAVXmQi17j3eseTQx3pwNQ9DSqU9MjvUGK2081mRr9BjvqOpL+LjagAU7
         WhtqouCxN8nvdnD2Sb6vz1uZj0jXfDz0T1cbJVrsCTEeYz4h0sW33WEtdNi8N0jRtpao
         vtyA==
X-Gm-Message-State: AFqh2krVH5FCHffX/MSl1Iar4BYpvDcmRequESgBhAyUbNs6arAtvNG3
        BUCqCbAcVa0f1UMIXK3EpgJ6lA==
X-Google-Smtp-Source: AMrXdXsM0ntelvMMPfJ6olR92/r6D2fnYvZnCfy/NuqCQhaSJ03fPDkbD8kayIZkEB50CgDbRLNN+g==
X-Received: by 2002:a05:6512:2619:b0:4cb:c48:9d44 with SMTP id bt25-20020a056512261900b004cb0c489d44mr4753673lfb.28.1672408249057;
        Fri, 30 Dec 2022 05:50:49 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id e16-20020ac24e10000000b004b4ea0f4e25sm3447970lfr.301.2022.12.30.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:50:48 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm8250: Touch up audio hw nodes
Date:   Fri, 30 Dec 2022 14:50:43 +0100
Message-Id: <20221230135044.287874-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230135044.287874-1-konrad.dybcio@linaro.org>
References: <20221230135044.287874-1-konrad.dybcio@linaro.org>
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

- Expand long clock-names into vertical lists
- Shuffle properties around:
  - Make sure compatible goes first and status goes last
  - Make property order consistent between similar nodes
- Fix up indentation
- Remove stray newlines
- Remove a redundant comment about swr2 being associated with TX macro
  (it's obvious by looking at the label property 10 lines below)
- Change unnecessary interrupts-extended to interrupts
- Disable SWR0 and WSA macro by default and enable them on SM8250 MTP and
  RB5, which were the only users
- Remove stray #address/size-cells from txmacro, as it's not even
  supposed to have children

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts |  6 ++
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts  |  6 ++
 arch/arm64/boot/dts/qcom/sm8250.dtsi     | 82 +++++++++++++-----------
 3 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8c64cb060e21..6802d36fb20c 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1007,6 +1007,8 @@ can@0 {
 };
 
 &swr0 {
+	status = "okay";
+
 	left_spkr: speaker@0,3 {
 		compatible = "sdw10217211000";
 		reg = <0 3>;
@@ -1322,6 +1324,10 @@ &venus {
 	status = "okay";
 };
 
+&wsamacro {
+	status = "okay";
+};
+
 /* PINCTRL - additions to nodes defined in sm8250.dtsi */
 &qup_spi0_cs_gpio {
 	drive-strength = <6>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 3ed8c84e25b8..436e280ed3fc 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -757,6 +757,8 @@ codec {
 };
 
 &swr0 {
+	status = "okay";
+
 	left_spkr: speaker@0,3 {
 		compatible = "sdw10217211000";
 		reg = <0 3>;
@@ -890,3 +892,7 @@ &usb_2_qmpphy {
 &venus {
 	status = "okay";
 };
+
+&wsamacro {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 3b3ea380c6e6..dffce681d417 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2223,21 +2223,26 @@ wsamacro: codec@3240000 {
 				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&aoncc LPASS_CDC_VA_MCLK>,
 				 <&vamacro>;
+			clock-names = "mclk",
+				      "npl",
+				      "macro",
+				      "dcodec",
+				      "va",
+				      "fsgen";
 
-			clock-names = "mclk", "npl", "macro", "dcodec", "va", "fsgen";
+			pinctrl-names = "default";
+			pinctrl-0 = <&wsa_swr_active>;
 
 			#clock-cells = <0>;
 			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa_swr_active>;
+			status = "disabled";
 		};
 
 		swr0: soundwire-controller@3250000 {
-			reg = <0 0x03250000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
+			reg = <0 0x03250000 0 0x2000>;
 			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&wsamacro>;
 			clock-names = "iface";
@@ -2253,6 +2258,7 @@ swr0: soundwire-controller@3250000 {
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		audiocc: clock-controller@3300000 {
@@ -2260,8 +2266,8 @@ audiocc: clock-controller@3300000 {
 			reg = <0 0x03300000 0 0x30000>;
 			#clock-cells = <1>;
 			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "core", "audio", "bus";
 		};
 
@@ -2269,9 +2275,8 @@ vamacro: codec@3370000 {
 			compatible = "qcom,sm8250-lpass-va-macro";
 			reg = <0 0x03370000 0 0x1000>;
 			clocks = <&aoncc LPASS_CDC_VA_MCLK>,
-				<&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-
+				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "mclk", "macro", "dcodec";
 
 			#clock-cells = <0>;
@@ -2281,34 +2286,37 @@ vamacro: codec@3370000 {
 		};
 
 		rxmacro: rxmacro@3200000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&rx_swr_active>;
 			compatible = "qcom,sm8250-lpass-rx-macro";
 			reg = <0 0x03200000 0 0x1000>;
-			status = "disabled";
-
 			clocks = <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&vamacro>;
+				 <&q6afecc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk",
+				      "npl",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
 
-			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			pinctrl-names = "default";
+			pinctrl-0 = <&rx_swr_active>;
 
 			#clock-cells = <0>;
 			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		swr1: soundwire-controller@3210000 {
-			reg = <0 0x03210000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
-			status = "disabled";
+			reg = <0 0x03210000 0 0x2000>;
 			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rxmacro>;
 			clock-names = "iface";
 			label = "RX";
+
 			qcom,din-ports = <0>;
 			qcom,dout-ports = <5>;
 
@@ -2325,45 +2333,45 @@ swr1: soundwire-controller@3210000 {
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		txmacro: txmacro@3220000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&tx_swr_active>;
 			compatible = "qcom,sm8250-lpass-tx-macro";
 			reg = <0 0x03220000 0 0x1000>;
-			status = "disabled";
-
 			clocks = <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6afecc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&vamacro>;
+			clock-names = "mclk",
+				      "npl",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
 
-			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tx_swr_active>;
 
 			#clock-cells = <0>;
 			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
-			#address-cells = <2>;
-			#size-cells = <2>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
-		/* tx macro */
 		swr2: soundwire-controller@3230000 {
-			reg = <0 0x03230000 0 0x2000>;
 			compatible = "qcom,soundwire-v1.5.1";
-			interrupts-extended = <&intc GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0 0x03230000 0 0x2000>;
+			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "core";
-			status = "disabled";
-
 			clocks = <&txmacro>;
 			clock-names = "iface";
 			label = "TX";
 
 			qcom,din-ports = <5>;
 			qcom,dout-ports = <0>;
+
 			qcom,ports-sinterval-low =	/bits/ 8 <0xff 0x01 0x01 0x03 0x03>;
 			qcom,ports-offset1 =		/bits/ 8 <0xff 0x01 0x00 0x02 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x00 0x00 0x00>;
@@ -2373,9 +2381,11 @@ swr2: soundwire-controller@3230000 {
 			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-lane-control =	/bits/ 8 <0xff 0x00 0x01 0x00 0x01>;
+
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		aoncc: clock-controller@3380000 {
@@ -2383,8 +2393,8 @@ aoncc: clock-controller@3380000 {
 			reg = <0 0x03380000 0 0x40000>;
 			#clock-cells = <1>;
 			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "core", "audio", "bus";
 		};
 
@@ -2397,7 +2407,7 @@ lpass_tlmm: pinctrl@33c0000{
 			gpio-ranges = <&lpass_tlmm 0 0 14>;
 
 			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "core", "audio";
 
 			wsa_swr_active: wsa-swr-active-state {
-- 
2.39.0

