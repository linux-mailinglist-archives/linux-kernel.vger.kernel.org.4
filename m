Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD48629FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKORDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiKORDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:03:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D82CCAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:03:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t4so10085812wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjo1DjnUkFFsgK5UipBBJf3Yoi/Km0K0ypahb5ZKpzw=;
        b=uQ1HRRokvTDu40XmWgA9W2/HeE50eur3E1qIVvfiOXpITRMbEUDpGrMmdqeysv4ki3
         C5m4unTah40SGr1zz5yRL9it+JyIUNLztCzE84Aj6Oyeg3a/r6kj57PZshAqHpgaykzO
         hrSIO1Dfffas6W52p3PIXMIX4Cy7s8m60oO89ZTZ8nWJgJ2cfnXRQ+icj40gXCJ9KBtw
         fviX5eAA3XxJAtih42yQXFhd1/XMxUBPkwmpgN3B2BIx+HHEIk/RnYtKDRt4Q0gf1KOq
         iQpytn1aKp1QNp/tRplN3AcKe2OD3AUwL7aa+V98VXphidlc45h/MD/FaYV67XnQoc93
         G/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjo1DjnUkFFsgK5UipBBJf3Yoi/Km0K0ypahb5ZKpzw=;
        b=NTzqZuXath2FcinwxRvj7cQ8ua8tAuQ4yldHTlc3UXTbQKpg+4w3xayIpqFex2hEea
         6/ttEKvB2BabryWGtGO0VSz6QNVWtAsj50t8uSJpy0LuyitFzv9GFd6bzk4M1i8k7oXL
         SfmGYApplkV+lHytYQBQlnK0NEtJpB1vmwf1o8e13lSd1XeOC8tivxTuO4OUDspaRNx0
         OIBSrsOgZf/2m3+V7ooJRr9ulUYsGLrXx4+6deuO/rCUfPStfthrlwKmrC+VmI2PPBim
         Hzqcu3TWkhMPvNKzSXiZlDt3BNjQyeaUzhvd+GguOASdGFlxBlhP6CaJpFCxKh4+x8KK
         78+A==
X-Gm-Message-State: ANoB5plQBruN6+lpXWSzvawTRF8m5Ww3ZVxdCC/Wh1c8EkVUe8YK+RoI
        AweGcPR5PRPDQQFFunQS0yj/ULbQzSFehQ==
X-Google-Smtp-Source: AA0mqf4ttPzrRD2DZ9B0YPcePRnhvD3AvlWLI7lGMysUHwZhNpYp6UjKbc5/++9eIDox5eMTFC9xwQ==
X-Received: by 2002:a1c:a3c4:0:b0:3cf:b7bf:352d with SMTP id m187-20020a1ca3c4000000b003cfb7bf352dmr2234834wme.106.1668531779549;
        Tue, 15 Nov 2022 09:02:59 -0800 (PST)
Received: from localhost.localdomain ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003c6c3fb3cf6sm15747090wml.18.2022.11.15.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:02:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and LPASS
Date:   Tue, 15 Nov 2022 17:02:41 +0000
Message-Id: <20221115170242.150246-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
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

Add LPASS Codecs along with SoundWire controller for TX, RX, WSA and VA macros
along with LPASS LPI pinctrl node.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 324 +++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index e3cdd8bccb0c..a87d58bee1e0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 
@@ -1115,6 +1116,9 @@ usb_2_ssphy1: phy@88f1e00 {
 			};
 		};
 
+		sound: sound {
+		};
+
 		remoteproc_adsp: remoteproc@3000000 {
 			compatible = "qcom,sc8280xp-adsp-pas";
 			reg = <0 0x03000000 0 0x100>;
@@ -1195,6 +1199,326 @@ q6prmcc: cc {
 			};
 		};
 
+		rxmacro: rxmacro@3200000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&rx_swr_active>;
+			compatible = "qcom,sc8280xp-lpass-rx-macro";
+			reg = <0 0x3200000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&vamacro>;
+
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+		};
+
+		/* RX */
+		swr1: soundwire-controller@3210000 {
+			reg = <0 0x3210000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.6.0";
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
+		txmacro: txmacro@3220000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&tx_swr_active>;
+			compatible = "qcom,sc8280xp-lpass-tx-macro";
+			reg = <0 0x3220000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "mclk";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#sound-dai-cells = <1>;
+		};
+
+		/* TX */
+		swr2: soundwire-controller@3330000 {
+			reg = <0 0x3330000 0 0x2000>;
+			compatible = "qcom,soundwire-v1.6.0";
+			interrupts-extended = <&intc GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
+						<&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "core", "wake";
+
+			clocks = <&vamacro>;
+			clock-names = "iface";
+			label = "TX";
+
+			qcom,din-ports = <4>;
+			qcom,dout-ports = <0>;
+			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02 0x01>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-word-length =	/bits/ 8 <0xFF 0x00 0xFF 0xFF>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
+			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
+			qcom,port-offset = <1>;
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		wsamacro: codec@3240000 {
+			compatible = "qcom,sc8280xp-lpass-wsa-macro";
+			reg = <0 0x03240000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					 <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
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
+			compatible = "qcom,soundwire-v1.6.0";
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&wsamacro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <2>;
+			qcom,dout-ports = <6>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
+			qcom,ports-offset2 =		/bits/ 8 <0xFF 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
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
+		vamacro: codec@3370000 {
+			compatible = "qcom,sc8280xp-lpass-va-macro";
+			reg = <0 0x03370000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+
+			clock-names = "mclk", "npl", "macro", "dcodec";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>;
+
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "fsgen";
+			#sound-dai-cells = <1>;
+		};
+
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sc8280xp-lpass-lpi-pinctrl";
+			reg = <0 0x33c0000 0x0 0x20000>,
+			      <0 0x3550000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 18>;
+
+			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			wsa_swr_active: wsa-swr-active-pins {
+				clk {
+					pins = "gpio10";
+					function = "wsa_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data {
+					pins = "gpio11";
+					function = "wsa_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+
+				};
+			};
+
+			tx_swr_active: tx_swr-active-pins {
+				clk {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data {
+					pins = "gpio1", "gpio2";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			rx_swr_active: rx_swr-active-pins {
+				clk {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			wsa2_swr_active: wsa2-swr-active-pins {
+				clk {
+					pins = "gpio15";
+					function = "wsa2_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data {
+					pins = "gpio16";
+					function = "wsa2_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			dmic01_active: dmic01-active-pins {
+				clk {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+				data {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			dmic01_sleep: dmic01-sleep-pins {
+				clk {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <2>;
+					bias-disable;
+					output-low;
+				};
+
+				data {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <2>;
+					pull-down;
+					input-enable;
+				};
+			};
+
+			dmic02_active: dmic02-active-pins {
+				clk {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+				data {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			dmic02_sleep: dmic02-sleep-pins {
+				clk {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <2>;
+					bias-disable;
+					output-low;
+				};
+
+				data {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <2>;
+					pull-down;
+					input-enable;
+				};
+			};
+		};
+
 		usb_0_qmpphy: phy-wrapper@88ec000 {
 			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
 			reg = <0 0x088ec000 0 0x1e4>,
-- 
2.25.1

