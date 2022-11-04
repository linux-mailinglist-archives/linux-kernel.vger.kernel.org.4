Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC4619117
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiKDG3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:29:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802329352
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:29:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 78so3582879pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 23:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxFg7HXpZ+LzNmI03TKgAta5PVasE7I6+Po/GSpLci0=;
        b=Ku7F2bl3irc/VRVUlNhaaN8IT1wmr9OCKQsAZv9ztMfUd49lTX1pYwy7jqWuE0TVMo
         X6nEk+VQ6RZQqvhjJmW9hH9yXbSXcARoLOyblr39K9seyoX6gjbpGp4grAIEqCvCPVya
         TLAWyo4oiZ2Zm+UouNqITHeOE+j+N1XpG/LIkkm9WXhEetSBhFDLFSNu9d9DxYHVnS8u
         05gnQjkNN0rhaN8tuu3xOYC+hxr57oHxUQwGt8PBQJWC9AFkrgjzPhifFQgBC0yAXy4O
         MHh2ydSVEa/K0A+b37o0X9rm7P2h+qon1WsNbBSLhK4/xHiXE1MiTQd5qwvO6eGbcOmv
         UXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxFg7HXpZ+LzNmI03TKgAta5PVasE7I6+Po/GSpLci0=;
        b=LMH5D/sQdaWQrGAFjocsLiOJyVHX/npYLKJEbAkOUdyJgMz2JwNMFek260oKUReYvl
         HqGOod44VSWK6+Fy8Akfg3ys6v6WB/wu65PynF0MaW+od9/SP9mwX99MFUvebKkQM69G
         Bos5AEitJqq/txAjJpJDTTZTJOG3XPMwf/+qzjh4v/1ImIT64cEfAGA2ycwJVZMmUE6X
         XYOmnAqsKIcRRvg9MFjwNO2r9g1iRLiCGTAvppb4qPi7oyIz/J4UqMGviPa7oBVcY/JZ
         DY1YkooFY3Dx1j0hJelXOdaq1ers+Pf8eLzvNmOlgFlEtebh4+N2V/FPy72uOwJQZ4XF
         Aq2A==
X-Gm-Message-State: ACrzQf3yNlZJy4bU9hBIeaYMnhWoljq2J5QXNBjXpUakoFV8eI5NrNST
        8S753BNVTYKRk45ozPsX7rfFEjss82voaw==
X-Google-Smtp-Source: AMsMyM5K4ff6vcUwtrZl0lxUOHrxCUXhlw//8AWk8Y9AhXCUkFhFFtS0Zv+P3v/T20SmSpSiCJzJjA==
X-Received: by 2002:a63:455e:0:b0:439:9496:ddd8 with SMTP id u30-20020a63455e000000b004399496ddd8mr28969212pgk.261.1667543371792;
        Thu, 03 Nov 2022 23:29:31 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (2001-b400-e306-842b-9ec5-b6d1-6a82-aa11.emome-ip6.hinet.net. [2001:b400:e306:842b:9ec5:b6d1:6a82:aa11])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79892000000b0056bf24f0837sm1764687pfl.166.2022.11.03.23.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:29:31 -0700 (PDT)
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
Subject: [PATCH v10 4/4] arm64: dts: qcom: sc7280: add sc7280-herobrine-audio-rt5682-3mic3.dtsi for evoker
Date:   Fri,  4 Nov 2022 14:19:41 +0800
Message-Id: <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v10:
- add evoker include specific sc7280-herobrine-audio-rt5682-3mic.dtsi setting

 .../sc7280-herobrine-audio-rt5682-3mic.dtsi   | 194 ++++++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts |   2 +
 2 files changed, 196 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
new file mode 100644
index 0000000000000..01bc8ee93b19a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
@@ -0,0 +1,194 @@
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
+		status = "okay";
+		audio-routing =
+			"VA DMIC0", "vdd-micb",
+			"VA DMIC1", "vdd-micb",
+			"VA DMIC2", "vdd-micb",
+			"VA DMIC3", "vdd-micb",
+
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR";
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
+	status = "okay";
+	clock-frequency = <400000>;
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
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
+			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
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
+	status = "okay";
+	vdd-micb-supply = <&pp1800_l2c>;
+	pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>, <&lpass_dmic23_clk>,
+			<&lpass_dmic23_data>;
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
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
index dcdd4eecfe670..d608682f9742b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
@@ -8,6 +8,8 @@
 /dts-v1/;
 
 #include "sc7280-herobrine-evoker.dtsi"
+#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
+
 
 / {
 	model = "Google Evoker";
-- 
2.34.1

