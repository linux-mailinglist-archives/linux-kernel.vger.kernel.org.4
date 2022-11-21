Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B995632315
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKUNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKUNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:04:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D8D4733C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:04:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so19720047wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=168g2rDZa1+78R7vllDnGeqldLSUhAux4/DT8oY9BVg=;
        b=DvGoJTyNkvPFmRKq6zOxxVNDVt3wN20lppwEv1XA+3Vysis3PEqiw3R1PTjBLVRWDP
         kobvElwfQlQU7eHDjqY+DNppdJzTLHjrdvLrnz8PUGSStTZLvzNvUfyqAhFdLjUBuWvT
         4cYnjKxBdXxWGuNUxw/IpZlt2nuqpQfZNxKAYsBer4SoZgi5AdsONN/DZGOsHb8PL0/e
         nKGE4QyMHILswhz36/rxfEIBEqGVs64HTrgu095HQf0yfZ3Kyq7f3smDpk1rPOAFAdSN
         2moNjOI5n6mjb6WW+YWXLXK3Cae9H0oOeLQ3r7qhomzDuH6/IoeuOnB8eHWRHKe3jg6c
         sMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=168g2rDZa1+78R7vllDnGeqldLSUhAux4/DT8oY9BVg=;
        b=ZYc2+tUD4P/4xLlwqKVnEVvfDgBXxpFDruu3loYIqTbo/CwKN05K8upwhbxEBcX0+J
         deRUiZ1qDxQuam3eAysnhlAWAj+BN5jI1OyXCWJjd1uC8cNliCttB1dOMfXNZNM7J1M5
         8XWKPB2kq/DdKdOycKiOqNRYAlOehF4NKBHuBT3tpsP4Kab250zax62cHfIBEdad6LUb
         ew2HCG8GxRDrIYQKZrD+EykkTrmpnIYrI2ej4PxwI//gUSxwj61IMQkd4h7A4/GeHgRb
         9E++IqZZVEUS9pyYFPSHzO2wnvxT16ruOe9OpNnhISZp0y/uaxO2i/JKBGeGhhN2QJkP
         2D9A==
X-Gm-Message-State: ANoB5pnL9b7YQf/gVI/ZIvZEjwsuO2wFp0g1SLW7a4T6BYT659Zd2r0+
        MuIYsfais+ihF+sPf3iz1nRRcA==
X-Google-Smtp-Source: AA0mqf4bLq55b/N8mmgxVPdBbtPgBNZXsV9tLP5F+XT62i5dtUXeR0e/r1MT5l4x7s09vRrzxJewHA==
X-Received: by 2002:adf:e784:0:b0:241:784b:666b with SMTP id n4-20020adfe784000000b00241784b666bmr11024762wrm.483.1669035858667;
        Mon, 21 Nov 2022 05:04:18 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm11133898wrw.59.2022.11.21.05.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:04:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and LPASS
Date:   Mon, 21 Nov 2022 13:04:02 +0000
Message-Id: <20221121130403.161817-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
References: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 320 +++++++++++++++++++++++++
 1 file changed, 320 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 65b657f73ebb..19b79c601417 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/soc/qcom,gpr.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1668,6 +1669,322 @@ q6prmcc: clock-controller {
 			};
 		};
 
+		rxmacro: rxmacro@3200000 {
+			compatible = "qcom,sc8280xp-lpass-rx-macro";
+			reg = <0 0x03200000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					  <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			clock-output-names = "mclk";
+			#clock-cells = <0>;
+			#sound-dai-cells = <1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&rx_swr_default>;
+		};
+
+		/* RX */
+		swr1: soundwire-controller@3210000 {
+			compatible = "qcom,soundwire-v1.6.0";
+			reg = <0 0x03210000 0 0x2000>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rxmacro>;
+			clock-names = "iface";
+			label = "RX";
+
+			qcom,din-ports = <0>;
+			qcom,dout-ports = <5>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1f 0x1f 0x07 0x00>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		txmacro: txmacro@3220000 {
+			compatible = "qcom,sc8280xp-lpass-tx-macro";
+			reg = <0 0x03220000 0 0x1000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&tx_swr_default>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					  <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+			clock-output-names = "mclk";
+
+			#clock-cells = <0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#sound-dai-cells = <1>;
+		};
+
+		wsamacro: codec@3240000 {
+			compatible = "qcom,sc8280xp-lpass-wsa-macro";
+			reg = <0 0x03240000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&vamacro>;
+			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					  <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>, <19200000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wsa_swr_default>;
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
+			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0x01 0xff 0xff 0x01 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		/* TX */
+		swr2: soundwire-controller@3330000 {
+			compatible = "qcom,soundwire-v1.6.0";
+			reg = <0 0x03330000 0 0x2000>;
+			interrupts-extended = <&intc GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "core", "wake";
+
+			clocks = <&vamacro>;
+			clock-names = "iface";
+			label = "TX";
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			qcom,din-ports = <4>;
+			qcom,dout-ports = <0>;
+			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02 0x01>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
+		};
+
+		vamacro: codec@3370000 {
+			compatible = "qcom,sc8280xp-lpass-va-macro";
+			reg = <0 0x03370000 0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "mclk", "macro", "dcodec", "npl";
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clock-rates = <19200000>;
+
+			#clock-cells = <0>;
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
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			tx_swr_default: tx-swr-default-state {
+				clk-pins {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio1", "gpio2";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			rx_swr_default: rx-swr-default-state {
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
+			dmic01_default: dmic01-default-state {
+				clk-pins {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			dmic01_sleep: dmic01-sleep-state {
+				clk-pins {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <2>;
+					bias-disable;
+					output-low;
+				};
+
+				data-pins {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			dmic02_default: dmic02-default-state {
+				clk-pins {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			dmic02_sleep: dmic02-sleep-state {
+				clk-pins {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <2>;
+					bias-disable;
+					output-low;
+				};
+
+				data-pins {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			wsa_swr_default: wsa-swr-default-state {
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
+
+				};
+			};
+
+			wsa2_swr_default: wsa2-swr-default-state {
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
 		usb_0_qmpphy: phy-wrapper@88ec000 {
 			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
 			reg = <0 0x088ec000 0 0x1e4>,
@@ -2507,6 +2824,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 		};
 	};
 
+	sound: sound {
+	};
+
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-- 
2.25.1

