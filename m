Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7427669E794
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBUSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjBUSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF94303D0;
        Tue, 21 Feb 2023 10:32:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ck15so22233637edb.0;
        Tue, 21 Feb 2023 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQSmh32OKE33I5420mu9+Fe2dybwDMzPyqZp98Es5A0=;
        b=NWW0loock5oBID3QFLzVq8K9EpVNYl+ZYmsU652aRgHtxBKeNfj8DPn7GmSYs/ttfZ
         sewS3t7yAWMaLsrLFpM20K9bzEbiga0bMCN6Q1YEmbwN0DCnD4VYXFRhq0Bf22glKT3j
         9ehzd27SMlkUawFEBbW1dlxeCo9EH52YqwvgwEjhMURX18dliuMncwqZStFByf6z9OA7
         6aUSJy1Kfwi2nwHPIG21i5UQo4g2uyHqY012/k1DuJVB57C2RAMteAafi9GTxvY8YmgD
         cMuLN9PWNsYrvyaNfhFkaE/89jEpoSXltkVWUB0ugYGreMFxCMpS62PuwvebAs3GujFe
         +8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQSmh32OKE33I5420mu9+Fe2dybwDMzPyqZp98Es5A0=;
        b=aJmSe1d2OlSDkbPq+f5hQwHC/yoBPktAcQ/6fHZ/DI5C1VrkAdiLq71KoXm1l29qQ6
         +QcXi/zzfGaLoJRXk1tLNPrgGVc0fst59nXnPH2cTgsXEgsSZzLl1c8OAuZWWYxo/fhV
         9lNc785E2P9L680jSsUSkIAjMq8INChahj/YshI84DlBHcRzhisfKQkHjqqYHLoyOoZf
         T2GceXGLeXHPI92WDS5KP9w4QQUPd/kcZQSEieOSIFqJdmiKTavK23CWyeaAXhFqgqXq
         AhGg7M6Oh1nYXN7e7wjeZ4s7mUZJZYnVld40Ey2eSpM0Z6MyPhgziEOO1TW4e+TAFPZq
         Z9Mg==
X-Gm-Message-State: AO0yUKUh4G72iS9wQHzHyX5Ms1QzFJ0Vdu9XRAJb4npvVDLmMd+XiCPt
        p4s8xFdYN8hOXWXcvBuOLQc=
X-Google-Smtp-Source: AK7set+fSmOPE7HCxYwmGeNARvkMtewnxLHluxAnobePLwdWIIZgbTWFuCdB66FrKtK6B5zRmhBjXg==
X-Received: by 2002:a05:6402:516e:b0:474:a583:2e1a with SMTP id d14-20020a056402516e00b00474a5832e1amr5711519ede.12.1677004355491;
        Tue, 21 Feb 2023 10:32:35 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:35 -0800 (PST)
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
Subject: [PATCH v1 10/10] ARM: tegra: transformers: bind FM34NE DSP on supported devices
Date:   Tue, 21 Feb 2023 20:32:11 +0200
Message-Id: <20230221183211.21964-11-clamor95@gmail.com>
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

FM34NE is mandatory for correct sound work on ASUS Transformers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts      | 14 +++++++++
 arch/arm/boot/dts/tegra30-asus-tf201.dts      | 29 +++++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts     | 29 +++++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts    | 19 ++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts     | 19 ++++++++++++
 .../arm/boot/dts/tegra30-pegatron-chagall.dts | 27 +++++++++++++++++
 6 files changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 8d0613567e82..8a51a4c53014 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -493,6 +493,20 @@ i2c@7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
+		/* Fortemedia FM34NE voice processor */
+		dsp@60 {
+			compatible = "asus,tf101-dsp", "fortemedia,fm34";
+			reg = <0x60>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+
+			vdd-supply = <&vdd_1v8_sys>;
+
+			clocks = <&tegra_car TEGRA20_CLK_CDEV1>;
+			clock-names = "mclk";
+		};
+
 		/* Aichi AMI306 digital compass */
 		magnetometer@e {
 			compatible = "asahi-kasei,ak8974";
diff --git a/arch/arm/boot/dts/tegra30-asus-tf201.dts b/arch/arm/boot/dts/tegra30-asus-tf201.dts
index 47865deeb88a..e214fc23609e 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf201.dts
@@ -60,6 +60,25 @@ bluetooth {
 		};
 	};
 
+	i2c@7000c000 {
+		/* Fortemedia FM34NE voice processor */
+		dsp@60 {
+			compatible = "asus,tf201-dsp", "fortemedia,fm34";
+			reg = <0x60>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(BB, 6) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+
+			vdd-supply = <&vdd_1v8_dsp>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
+
+			assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+	};
+
 	i2c@7000c400 {
 		/* Atmel MXT768E touchscreen */
 		touchscreen@4d {
@@ -606,6 +625,16 @@ haptic-feedback {
 		vcc-supply = <&vdd_3v3_sys>;
 	};
 
+	vdd_1v8_dsp: regulator-dsp {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v8_dsp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(U, 5) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_1v8_vio>;
+	};
+
 	sound {
 		compatible = "asus,tegra-audio-rt5631-tf201",
 			     "nvidia,tegra-audio-rt5631";
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300t.dts b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
index 78f78cca337a..2dcf0e1f6ca2 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300t.dts
@@ -68,6 +68,25 @@ bluetooth {
 		};
 	};
 
+	i2c@7000c000 {
+		/* Fortemedia FM34NE voice processor */
+		dsp@60 {
+			compatible = "asus,tf300t-dsp", "fortemedia,fm34";
+			reg = <0x60>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(BB, 6) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+
+			vdd-supply = <&vdd_1v8_dsp>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
+
+			assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+	};
+
 	i2c@7000c400 {
 		/* Elantech EKTH1036 touchscreen */
 		touchscreen@10 {
@@ -999,6 +1018,16 @@ display-panel {
 		compatible = "innolux,g101ice-l01";
 	};
 
+	vdd_1v8_dsp: regulator-dsp {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v8_dsp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_1v8_vio>;
+	};
+
 	sound {
 		compatible = "asus,tegra-audio-wm8903-tf300t",
 			     "nvidia,tegra-audio-wm8903";
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
index 82c51e177a70..7f23021611a4 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
@@ -164,6 +164,25 @@ bluetooth {
 		};
 	};
 
+	i2c@7000c000 {
+		/* Fortemedia FM34NE voice processor */
+		dsp@60 {
+			compatible = "asus,tf300t-dsp", "fortemedia,fm34";
+			reg = <0x60>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(BB, 6) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+
+			vdd-supply = <&vdd_1v8_vio>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
+
+			assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+	};
+
 	i2c@7000c400 {
 		/* Elantech EKTH1036 touchscreen */
 		touchscreen@10 {
diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
index 766225ebdeab..bbb33119780e 100644
--- a/arch/arm/boot/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
@@ -85,6 +85,25 @@ bluetooth {
 		};
 	};
 
+	i2c@7000c000 {
+		/* Fortemedia FM34NE voice processor */
+		dsp@60 {
+			compatible = "asus,tf700t-dsp", "fortemedia,fm34";
+			reg = <0x60>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(BB, 6) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+
+			vdd-supply = <&vdd_1v8_vio>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
+
+			assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+	};
+
 	i2c@7000c400 {
 		/* Elantech ELAN-3024-7053 or 5184N FPC-1 REV: 2/3 touchscreen */
 		touchscreen@10 {
diff --git a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
index 6e24b095713b..007ba3f3e95e 100644
--- a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
@@ -1145,6 +1145,23 @@ lcd_ddc: i2c@7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
+		/* Fortemedia FM34NE voice processor */
+		dsp@60 {
+			compatible = "pegatron,chagall-dsp", "fortemedia,fm34";
+			reg = <0x60>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(N, 3) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(N, 0) GPIO_ACTIVE_LOW>;
+
+			vdd-supply = <&vdd_1v8_dsp>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
+
+			assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+		};
+
 		/* Wolfson Microelectronics WM8903 audio codec */
 		wm8903: audio-codec@1a {
 			compatible = "wlf,wm8903";
@@ -1500,6 +1517,16 @@ vdd_vbus_usb3: regulator-usb3 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
+	vdd_1v8_dsp: regulator-dsp {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v8_dsp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(N, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_1v8_vio>;
+	};
+
 	pmc@7000e400 {
 		status = "okay";
 		nvidia,invert-interrupt;
-- 
2.37.2

