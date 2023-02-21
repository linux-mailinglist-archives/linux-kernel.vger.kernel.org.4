Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746F69E796
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBUScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjBUScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF3301B7;
        Tue, 21 Feb 2023 10:32:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq23so20730692edb.1;
        Tue, 21 Feb 2023 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6kk1KEQ/IVeQbAn9G08dCn7f0VBqM2RVSZE4nU8tG8=;
        b=ZLcktQw2yWXCWMLb+r8k3efgMJdd79CTAIDnmVywqDznjLEw7xRrl+1MN5bg3O9APj
         rxgt1EBGlzVHpz2UKl91tl9NqLvKa8ZN8onCQC0xPgxACvaPaRT2dG0OisdIPFfDegwe
         HPlqUrtQXwINZYZXwaWsVr64ce43UOrB/JyyrJ7isp/56MEvMArY/wOmTfbYiGGxvwll
         QcAwvI9570rgvn8J76VKSf3V9m1ttMHrCwH69JeLOdrePrwvoZYHsJNMl/fyKmV89mpn
         RLwy5dmrX5ezd85Uey7M786lydd2/IFPLkNgI3HbIyNm5dIStee4ktUKPnj2XKqoqH+W
         XE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6kk1KEQ/IVeQbAn9G08dCn7f0VBqM2RVSZE4nU8tG8=;
        b=QYBhpZ16737WdglylLm9DsZpQAm89ry8iGuEXOKslJRJldSAYfeMnrCKhJ/duN1Smh
         3/MFpkofj6kwbsxM6Wc/1EaPfwaailH1xtOMrvTm4AOtSI8dyCmtd0CWEDIg1bCYob6S
         EwX7kGb3WEZu1wlLIaKjVJqpjjLt4E8krM2tfAHxE1JdfavD29JP8Oc5QtyMfCcZ9FRY
         sw5/jMHdbJCSftToKI7ekKpnFNZx+V7pzMNTQdlbsDNiUW9w34e/qIEhpvM3mKgalOvE
         N3LDegaQwnQbfIcA/au4Wxdox+XNrlkRQ7qmlupABbAXG58S+ozMNjeq56kVQCMCyc2u
         yzSA==
X-Gm-Message-State: AO0yUKVCDSmri56FkIQDOIsjHpbuGc/7FL0KwiBNQWseGZN5VR95uUyY
        vcJXJS3U5FmTegIE2I6eBVs=
X-Google-Smtp-Source: AK7set/E+SxHoaq2fIGnYaXslbfvlnMH0WhFAMr8EmmsfbBnfuTToK9OvYA29COaSsoBwpvFXPsCfA==
X-Received: by 2002:aa7:c908:0:b0:4af:502b:4437 with SMTP id b8-20020aa7c908000000b004af502b4437mr4090015edt.34.1677004351477;
        Tue, 21 Feb 2023 10:32:31 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:31 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v1 07/10] ARM: tegra: transformers: update bindings of sound graph
Date:   Tue, 21 Feb 2023 20:32:08 +0200
Message-Id: <20230221183211.21964-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221183211.21964-1-clamor95@gmail.com>
References: <20230221183211.21964-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- fix headset detection in common device tree;
- diverge control and detect elements for mic;
- use GPIO mic detection on wm8903 devices;

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts        |  8 +++++---
 arch/arm/boot/dts/tegra30-asus-tf201.dts        | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts       |  5 ++---
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts      | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts       | 17 +++++++++++++++++
 .../dts/tegra30-asus-transformer-common.dtsi    |  9 +++++----
 arch/arm/boot/dts/tegra30-pegatron-chagall.dts  |  2 +-
 7 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index c39ddb462ad0..8d0613567e82 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -1179,15 +1179,17 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"Mic Jack", "MICBIAS",
-			"IN1L", "Mic Jack";
+			"IN1L", "Headset Mic",
+			"IN2L", "Headset Mic",
+			"DMICDAT", "Int Mic";
 
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
 		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
-		nvidia,headset;
+		nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
+		nvidia,coupled-mic-hp-det;
 
 		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
 			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
diff --git a/arch/arm/boot/dts/tegra30-asus-tf201.dts b/arch/arm/boot/dts/tegra30-asus-tf201.dts
index 315c6dc068c5..47865deeb88a 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf201.dts
@@ -605,6 +605,23 @@ haptic-feedback {
 		enable-gpios = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&vdd_3v3_sys>;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf201",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Prime TF201 RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Headset Mic",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
 
 &emc_icc_dvfs_opp_table {
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300t.dts b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
index f47434871a5c..78f78cca337a 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
@@ -1011,13 +1011,12 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"IN1L", "Mic Jack",
-			"IN2L", "Mic Jack",
+			"IN1L", "Headset Mic",
+			"IN2L", "Headset Mic",
 			"DMICDAT", "Int Mic";
 
 		nvidia,audio-codec = <&wm8903>;
 		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
-		nvidia,headset;
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
index 96345f821c3d..82c51e177a70 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
@@ -1072,6 +1072,23 @@ timing-667000000 {
 	display-panel {
 		compatible = "innolux,g101ice-l01";
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf300tg",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Pad TF300TG RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Headset Mic",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
 
 &emc_icc_dvfs_opp_table {
diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
index 1a331dec3cfe..766225ebdeab 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
@@ -812,6 +812,23 @@ vdd_1v2_mipi: regulator-mipi {
 		enable-active-high;
 		vin-supply = <&vdd_3v3_sys>;
 	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5631-tf700t",
+			     "nvidia,tegra-audio-rt5631";
+		nvidia,model = "Asus Transformer Infinity TF700T RT5631";
+
+		nvidia,audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR",
+			"Int Spk", "SPOL",
+			"Int Spk", "SPOR",
+			"MIC1", "MIC Bias1",
+			"MIC Bias1", "Headset Mic",
+			"DMIC", "Int Mic";
+
+		nvidia,audio-codec = <&rt5631>;
+	};
 };
 
 &emc_icc_dvfs_opp_table {
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 08ea9cb32d0e..42dae0f4759e 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -550,7 +550,7 @@ spi1_mosi_px4 {
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
-			spi2_cs1_n_pw2 {
+			hp_detect {
 				nvidia,pins = "spi2_cs1_n_pw2";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -558,10 +558,10 @@ spi2_cs1_n_pw2 {
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
-			spi2_sck_px2 {
+			mic_detect {
 				nvidia,pins = "spi2_sck_px2";
 				nvidia,function = "spi2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
@@ -1674,7 +1674,8 @@ sound {
 		nvidia,i2s-controller = <&tegra_i2s1>;
 
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
-		nvidia,hp-mute-gpios = <&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		nvidia,coupled-mic-hp-det;
 
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
diff --git a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
index d9408a90653a..6e24b095713b 100644
--- a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
@@ -2731,7 +2731,7 @@ sound {
 			"Int Spk", "RON",
 			"Int Spk", "LOP",
 			"Int Spk", "LON",
-			"IN1R", "Mic Jack",
+			"IN1R", "Headset Mic",
 			"DMICDAT", "Int Mic";
 
 		nvidia,i2s-controller = <&tegra_i2s1>;
-- 
2.37.2

