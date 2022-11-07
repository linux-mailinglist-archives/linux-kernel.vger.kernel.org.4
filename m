Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC161EF73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiKGJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiKGJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:45:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51217A88
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:45:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so10613225pli.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49aUWgohg7elYN6AoCe1Cce7ryH+ByqM4waHSXDXpfM=;
        b=lylI29n0B1HjCiFjLpUc2mG6M3ulW1IeVI0WuYFSQBYaIxSSTIYGqLqNJZIlonG7ZU
         L430D/+9nmgeSI/BDOYoMDpIZClVklgG1JlronVwp5mn1xUTECWdVvZq5mi9HCni32u0
         Eit36ZKgu1t3M5db8N9lkah0sdViZGlUSniMLMZyd7jDWqxLbyAEQjgIE6kbr29wMYA1
         x4idOZ0X7CjypKm7kY7lHzsmI8fjusbhKq0xbR0QZZhpYhka+Diprcy33u9IZdPZF2fA
         w67Ua1BHYB129r0AW0/j+rIUNJXWwPGdKIVLAY3BYvWK2doPC8wL7FmJSaulUHrKZamw
         piRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49aUWgohg7elYN6AoCe1Cce7ryH+ByqM4waHSXDXpfM=;
        b=qX2Jv/SwIF6/dAFxb4dtP4tYXEXZYXlbBKKGcEOjgCMDk0frqlH5EjUoVs/1MaOKZl
         pVR4BbuzN8JAHGBfxxaoMuI34gPFrVVKkY82AJboNVsS3drmbkkvbhpoypDfti1KHsS5
         lfq/PMLOlRoZUWLaQhZDVdz1A3WP9ESqlxUA8qdKFzGENDqcHnIfWPQV83p7rO5ML5vU
         biAR5FpTSEBU++UOze0jxXSgHCzotd36gttO1IAaY0oqd200LDUIhOdvToPvBvdikjg3
         mDaB4NZHMhELnfjtNqOFUAxHe7bDmp7bw1DvokGOsGMtFDQ6PRaPruo0wL8/yRte9b85
         Rifw==
X-Gm-Message-State: ACrzQf0JyevQ88nMGkzwsorQZsPgAKU6XEniD65h0UYHdShcaYrHz0KS
        NrGZsvg5sbaJ8lmHouWDu8gZVWEMjH1TMY/9
X-Google-Smtp-Source: AMsMyM4J4i/WOC1a9+YRm9o8z5D+8EewAZa3pnC7BgO/cwvGzzVPIDVK3c2z96/KAWWdNSB5hJZPJg==
X-Received: by 2002:a17:90a:4b05:b0:213:ead5:92ee with SMTP id g5-20020a17090a4b0500b00213ead592eemr39488812pjh.117.1667814349661;
        Mon, 07 Nov 2022 01:45:49 -0800 (PST)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b00186dcc37e17sm4564936pla.210.2022.11.07.01.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:45:49 -0800 (PST)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 4/5] arm64: dts: qcom: sc7280: add sc7280-herobrine-audio-rt5682-3mic3.dtsi for evoker
Date:   Mon,  7 Nov 2022 17:43:44 +0800
Message-Id: <20221107173954.v11.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add specific 3mic setting as sc7280-herobrine-audio-rt5682-3mic.dtsi,
so we can include sc7280-herobrine-audio-rt5682-3mic.dtsi for evoker
as it uses rt5682 with 3 mics.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

Changes in v11:
- sort out the "Status" property with sc7280-herobrine-audio-rt5682-3mic.dtsi

Changes in v10:
- add evoker include specific sc7280-herobrine-audio-rt5682-3mic.dtsi setting

 .../sc7280-herobrine-audio-rt5682-3mic.dtsi   | 195 ++++++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts |   1 +
 2 files changed, 196 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
new file mode 100644
index 0000000000000..cf34334451d6b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ *
+ * This file defines the common audio settings for the child boards
+ * using rt5682 codec and having 3 dmics connected to sc7280.
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/ {
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-rt5682-max98360a-3mic";
+
+		audio-routing =	"VA DMIC0", "vdd-micb",
+				"VA DMIC1", "vdd-micb",
+				"VA DMIC2", "vdd-micb",
+				"VA DMIC3", "vdd-micb",
+
+				"Headphone Jack", "HPOL",
+				"Headphone Jack", "HPOR";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dai-link@0 {
+			link-name = "MAX98360";
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+			};
+
+			codec {
+				sound-dai = <&max98360a>;
+			};
+		};
+
+		dai-link@1 {
+			link-name = "DisplayPort";
+			reg = <1>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_DP_RX>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
+
+		dai-link@2 {
+			link-name = "ALC5682";
+			reg = <2>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_PRIMARY>;
+			};
+
+			codec {
+				sound-dai = <&alc5682 0 /* aif1 */>;
+			};
+		};
+
+		dai-link@4 {
+			link-name = "DMIC";
+			reg = <4>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_va_macro 0>;
+			};
+		};
+	};
+};
+
+hp_i2c: &i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	alc5682: codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_irq>;
+
+		#sound-dai-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <101 IRQ_TYPE_EDGE_BOTH>;
+
+		AVDD-supply = <&pp1800_alc5682>;
+		MICVDD-supply = <&pp3300_codec>;
+
+		realtek,dmic1-data-pin = <1>;
+		realtek,dmic1-clk-pin = <2>;
+		realtek,jd-src = <1>;
+		realtek,dmic-clk-rate-hz = <2048000>;
+	};
+};
+
+&lpass_cpu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
+			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	dai-link@0 {
+		reg = <MI2S_PRIMARY>;
+		qcom,playback-sd-lines = <1>;
+		qcom,capture-sd-lines = <0>;
+	};
+
+	dai-link@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+
+	dai-link@5 {
+		reg = <LPASS_DP_RX>;
+	};
+
+	dai-link@25 {
+		reg = <LPASS_CDC_DMA_VA_TX0>;
+	};
+};
+
+&lpass_va_macro {
+	vdd-micb-supply = <&pp1800_l2c>;
+	pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>, <&lpass_dmic23_clk>,
+			<&lpass_dmic23_data>;
+
+	status = "okay";
+};
+
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&lpass_dmic01_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic01_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic01_data {
+	bias-pull-down;
+};
+
+&lpass_dmic23_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic23_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic23_data {
+	bias-pull-down;
+};
+
+&mi2s0_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_data1 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_mclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
index dcdd4eecfe670..51f0401b11ed7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine-evoker.dtsi"
+#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
 
 / {
 	model = "Google Evoker";
-- 
2.34.1

