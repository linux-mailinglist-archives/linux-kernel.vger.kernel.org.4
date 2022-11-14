Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB586283C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiKNPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiKNPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:21:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D91E3D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:21:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so19833561lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiE8moA1kU9HoHlH2XBHk25x9rvLkc0oG023wW55d+8=;
        b=ZOPs2XgyHc550H7zZAscymWrataIEeKH//Z1Emqsy0KJ7hokiWopjiT7vLiLWDwg4k
         O8g9+8VHAhRxzg0jzHEfTxio3nsLcMDDQ1CPFuSh0SMnIPGmcikxQjtZIrJHTVFbXXNy
         2HcEfPpelxKWtHI0J1ZivvDfIBFRntxeE/2TpDRzp3HGt1TbUlXYns44o4epQLeToJwb
         WI2uM3Ew6MHAm9IQNN/stgsFG5EtAYPRGHzBhf/F+mePaNc1xMCjIRKc1M+G24lqaK2P
         Ou/f66JBwf1Mud9OIRTNEVJ4t4IC3oBfEUGf7HcM4lFP5sEcPDMyk8lHNhKYQneNJztH
         tGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiE8moA1kU9HoHlH2XBHk25x9rvLkc0oG023wW55d+8=;
        b=Hk2Pyy6P8MPf0cDm5C4s3rB7nCx491g3Ta3KFFtxHel2dBnRJ/PVdr/ufsa2szN5QO
         0TG6Bs+PPC0hknWYNsoWrI90n/cJ9/THyck2Cogl5vfROBc33FHV/gSne4c4hDPO8/hX
         QTWKg6GVEYR3GveoDORnZwnVLOvh7S1FZIEprOzjSp1mSJ++W8UXKhQhU5mexqMA6lhT
         XQIPkUxDWf7XwzmiXAeWA/cdQRfTjTTuoXXwU/Z0OLX64XbI3RU8uhvAnERiybY/wDx5
         sgXjkrqNI5w5Tsswad9KSSWIfqn+cqdFfay23ZvWciICrAjdCzSvulJWEr4IrXIZ84xl
         PrGQ==
X-Gm-Message-State: ANoB5plQMbhb2Qy1KJVFTPAUZkQwAcTkUfKewqZzuZfGXSSmo7OIQBSZ
        dFAPTDYRprx0K+gIyDwxgRHu5A==
X-Google-Smtp-Source: AA0mqf7oaE0z4pvX7i67jq+IJRzOXR1iLQA2R2s1GE3frAV2MO0sdHGbM4xCxpN2KAHo+DICyVH3IA==
X-Received: by 2002:a05:6512:3f28:b0:4a2:2aab:5460 with SMTP id y40-20020a0565123f2800b004a22aab5460mr4013419lfa.62.1668439297301;
        Mon, 14 Nov 2022 07:21:37 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512388500b00492ea54beeasm1854268lft.306.2022.11.14.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 07:21:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
Date:   Mon, 14 Nov 2022 16:21:29 +0100
Message-Id: <20221114152130.385871-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
References: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add Soundwire controllers, Low Power Audio SubSystem (LPASS) devices and
LPASS pin controller.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 4b0a1eee8bd9..c99740591467 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -2097,6 +2098,212 @@ compute-cb@3 {
 			};
 		};
 
+		wsa2macro: codec@31e0000 {
+			compatible = "qcom,sm8450-lpass-wsa-macro";
+			reg = <0 0x031e0000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "wsa2-mclk";
+			#sound-dai-cells = <1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wsa2_swr_active>;
+		};
+
+		/* WSA2 */
+		swr4: soundwire-controller@31f0000 {
+			reg = <0 0x031f0000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.7.0";
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&wsa2macro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <2>;
+			qcom,dout-ports = <6>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
+			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0x01 0xFF 0xFF 0x01 0xFF 0xFF>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-lane-control =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		rxmacro: codec@3200000 {
+			compatible = "qcom,sm8450-lpass-rx-macro";
+			reg = <0 0x3200000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&rx_swr_active>;
+		};
+
+		swr1: soundwire-controller@3210000 {
+			reg = <0 0x3210000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.7.0";
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rxmacro>;
+			clock-names = "iface";
+			label = "RX";
+			qcom,din-ports = <0>;
+			qcom,dout-ports = <5>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1F 0x1F 0x07 0x00>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
+			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		txmacro: codec@3220000 {
+			compatible = "qcom,sm8450-lpass-tx-macro";
+			reg = <0 0x3220000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					   <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&tx_swr_active>;
+		};
+
+		wsamacro: codec@3240000 {
+			compatible = "qcom,sm8450-lpass-wsa-macro";
+			reg = <0 0x03240000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wsa_swr_active>;
+		};
+
+		/* WSA */
+		swr0: soundwire-controller@3250000 {
+			reg = <0 0x03250000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.7.0";
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&wsamacro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <2>;
+			qcom,dout-ports = <6>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
+			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0x01 0xFF 0xFF 0x01 0xFF 0xFF>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-lane-control =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
+			qcom,port-offset = <1>;
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		swr2: soundwire-controller@33b0000 {
+			reg = <0 0x33b0000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.7.0";
+			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "core", "wake";
+
+			clocks = <&vamacro>;
+			clock-names = "iface";
+			label = "TX";
+
+			qcom,din-ports = <4>;
+			qcom,dout-ports = <0>;
+			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x01 0x01>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x02 0x00 0x00>;
+			qcom,port-offset = <1>;
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		vamacro: codec@33f0000 {
+			compatible = "qcom,sm8450-lpass-va-macro";
+			reg = <0 0x033f0000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "mclk", "macro", "dcodec", "npl";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "fsgen";
+			#sound-dai-cells = <1>;
+		};
+
 		remoteproc_adsp: remoteproc@30000000 {
 			compatible = "qcom,sm8450-adsp-pas";
 			reg = <0 0x030000000 0 0x100>;
@@ -3030,6 +3237,91 @@ qup_uart20_default: qup-uart20-default-state {
 
 		};
 
+		lpass_tlmm: pinctrl@3440000{
+			compatible = "qcom,sm8450-lpass-lpi-pinctrl";
+			reg = <0 0x3440000 0x0 0x20000>,
+			      <0 0x34d0000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 23>;
+
+			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			wsa_swr_active: wsa-swr-active-state {
+				clk-pins {
+					pins = "gpio10";
+					function = "wsa_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio11";
+					function = "wsa_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			tx_swr_active: tx-swr-active-state {
+				clk-pins {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio1", "gpio2", "gpio14";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			rx_swr_active: rx-swr-active-state {
+				clk-pins {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			wsa2_swr_active: wsa2-swr-active-state {
+				clk-pins {
+					pins = "gpio15";
+					function = "wsa2_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio16";
+					function = "wsa2_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
@@ -3507,6 +3799,9 @@ lpass_ag_noc: interconnect@3c40000 {
 		};
 	};
 
+	sound: sound {
+	};
+
 	thermal-zones {
 		aoss0-thermal {
 			polling-delay-passive = <0>;
-- 
2.34.1

