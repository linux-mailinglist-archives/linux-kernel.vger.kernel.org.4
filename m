Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586A6228D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiKIKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiKIKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:44:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309FC5FD6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:44:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so25095966lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW8/uqDIgA/LREWfdoj0JpStCKveaFOu6u4SWFTf+Sk=;
        b=sKnhB1PTEUuEvIwW02qI9e4PvydDvWxE8gYvDSuukl+s2GwUmUKsWG2O2TV+R5Ba6m
         ojpRzwpuncUEQn8+6A3voBG87y2ctbrhvv5x/zv/J/UK/Jdh/CykuiWZDHer8GDsf2Sy
         d03/qDjFg2zrBNolrzQw3boM4nxdB8djB9TQm4Vt+2jl6mJdLmaaO7qN2ajUhXV6YnFa
         NXp9sl74qYQToMTJKGuKzIIEdCuMWmEqgeww7ZuNwbz6yyoWjVz+WSXZyFMrw/BlgV5a
         9r8uB3VLnIfmACY/YZKFh3Zt2bNSA4xAEBQxP0XiNwdzRx6AsviZRL4Vx3+rZfBh83rT
         uu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW8/uqDIgA/LREWfdoj0JpStCKveaFOu6u4SWFTf+Sk=;
        b=YsKmzBo8y7Yct2Vi1iVol6nAbxo0eLrPJCTjsSxus0+LludBwJ9B/KlZeq8b9GuDL4
         5DMk5YFOApkHhBW1gPVdXfPJAqACd8AAqbPu8TDBLb9P0eY7EPi1fc07UoTWdRDFbQb5
         IRoDsxrhkxmumTyIftpYLEEefzAwzOHeSwNeTJzr/W0ahZ42VnckL+gKLKwt8R/7RpfB
         yLHFNG1p834fmqDJ2JrrcHlzNESQXlSWnvGJJlvU3VL1BkZsroXhISg8JFXMTam2GyIt
         oohS/OlOpzdv/6yEcEpwdQ/AKSCfUW8CToP4lEkGHYUOv34qFtWlgtD1ob6719OCvdGm
         V/Cg==
X-Gm-Message-State: ACrzQf1JkJKgKNDLcZQktcNkb/K1EZ08AMBpPQJzx+mo5qZmfWRytsK9
        kM2cKn/3gNnSE0a8q8coLGE4MA==
X-Google-Smtp-Source: AMsMyM5+nvwPQgnyNYszuyRR4qyozalz7xyiNKqfBuU8ET+VxYws+YMcfGJppnlQsfjOnaS3Hbtyuw==
X-Received: by 2002:a05:6512:e97:b0:4a2:68df:fd50 with SMTP id bi23-20020a0565120e9700b004a268dffd50mr20227892lfb.171.1667990646344;
        Wed, 09 Nov 2022 02:44:06 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512344a00b004afd23cf7eesm2148568lfr.168.2022.11.09.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:44:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: msm8916: align TLMM pin configuration with DT schema
Date:   Wed,  9 Nov 2022 11:44:02 +0100
Message-Id: <20221109104402.45592-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
References: <20221109104402.45592-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      |  14 +-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts |  14 +-
 .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts |  24 +-
 .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts |  20 +-
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts |  16 +-
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts |   8 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi    | 268 +++++++++---------
 .../qcom/msm8916-samsung-a2015-common.dtsi    |  61 ++--
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |   6 +-
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |   2 +-
 .../qcom/msm8916-samsung-e2015-common.dtsi    |   4 +-
 .../dts/qcom/msm8916-samsung-grandmax.dts     |   2 +-
 .../boot/dts/qcom/msm8916-samsung-j5.dts      |   2 +-
 .../dts/qcom/msm8916-samsung-serranove.dts    |  40 +--
 .../dts/qcom/msm8916-wingtech-wt88047.dts     |  20 +-
 15 files changed, 259 insertions(+), 242 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 1b613098fb4a..9ebc506810f6 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -718,14 +718,14 @@ &msmgpio {
 		"USR_LED_2_CTRL", /* GPIO 120 */
 		"SB_HS_ID";
 
-	msmgpio_leds: msmgpio-leds {
+	msmgpio_leds: msmgpio-leds-state {
 		pins = "gpio21", "gpio120";
 		function = "gpio";
 
 		output-low;
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio121";
 		function = "gpio";
 
@@ -734,7 +734,7 @@ usb_id_default: usb-id-default {
 		bias-pull-up;
 	};
 
-	adv7533_int_active: adv533-int-active {
+	adv7533_int_active: adv533-int-active-state {
 		pins = "gpio31";
 		function = "gpio";
 
@@ -742,7 +742,7 @@ adv7533_int_active: adv533-int-active {
 		bias-disable;
 	};
 
-	adv7533_int_suspend: adv7533-int-suspend {
+	adv7533_int_suspend: adv7533-int-suspend-state {
 		pins = "gpio31";
 		function = "gpio";
 
@@ -750,7 +750,7 @@ adv7533_int_suspend: adv7533-int-suspend {
 		bias-disable;
 	};
 
-	adv7533_switch_active: adv7533-switch-active {
+	adv7533_switch_active: adv7533-switch-active-state {
 		pins = "gpio32";
 		function = "gpio";
 
@@ -758,7 +758,7 @@ adv7533_switch_active: adv7533-switch-active {
 		bias-disable;
 	};
 
-	adv7533_switch_suspend: adv7533-switch-suspend {
+	adv7533_switch_suspend: adv7533-switch-suspend-state {
 		pins = "gpio32";
 		function = "gpio";
 
@@ -766,7 +766,7 @@ adv7533_switch_suspend: adv7533-switch-suspend {
 		bias-disable;
 	};
 
-	msm_key_volp_n_default: msm-key-volp-n-default {
+	msm_key_volp_n_default: msm-key-volp-n-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 3dc9619fde6e..668f8ff53229 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -260,7 +260,7 @@ l18 {
 };
 
 &msmgpio {
-	accel_int_default: accel-int-default {
+	accel_int_default: accel-int-default-state {
 		pins = "gpio31";
 		function = "gpio";
 
@@ -268,7 +268,7 @@ accel_int_default: accel-int-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
@@ -276,7 +276,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	gyro_int_default: gyro-int-default {
+	gyro_int_default: gyro-int-default-state {
 		pins = "gpio97", "gpio98";
 		function = "gpio";
 
@@ -284,7 +284,7 @@ gyro_int_default: gyro-int-default {
 		bias-disable;
 	};
 
-	mag_reset_default: mag-reset-default {
+	mag_reset_default: mag-reset-default-state {
 		pins = "gpio8";
 		function = "gpio";
 
@@ -292,7 +292,7 @@ mag_reset_default: mag-reset-default {
 		bias-disable;
 	};
 
-	proximity_int_default: proximity-int-default {
+	proximity_int_default: proximity-int-default-state {
 		pins = "gpio12";
 		function = "gpio";
 
@@ -300,7 +300,7 @@ proximity_int_default: proximity-int-default {
 		bias-pull-up;
 	};
 
-	ts_int_reset_default: ts-int-reset-default {
+	ts_int_reset_default: ts-int-reset-default-state {
 		pins = "gpio13", "gpio100";
 		function = "gpio";
 
@@ -308,7 +308,7 @@ ts_int_reset_default: ts-int-reset-default {
 		bias-disable;
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio69";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index dd92070a1211..3618704a5330 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -263,7 +263,7 @@ l18 {
 };
 
 &msmgpio {
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio117";
 		function = "gpio";
 
@@ -271,7 +271,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	imu_default: imu-default {
+	imu_default: imu-default-state {
 		pins = "gpio36";
 		function = "gpio";
 
@@ -279,7 +279,7 @@ imu_default: imu-default {
 		bias-disable;
 	};
 
-	mag_reset_default: mag-reset-default {
+	mag_reset_default: mag-reset-default-state {
 		pins = "gpio112";
 		function = "gpio";
 
@@ -287,7 +287,7 @@ mag_reset_default: mag-reset-default {
 		bias-disable;
 	};
 
-	sd_vmmc_en_default: sd-vmmc-en-default {
+	sd_vmmc_en_default: sd-vmmc-en-default-state {
 		pins = "gpio87";
 		function = "gpio";
 
@@ -295,14 +295,16 @@ sd_vmmc_en_default: sd-vmmc-en-default {
 		bias-disable;
 	};
 
-	touchscreen_default: touchscreen-default {
-		pins = "gpio13";
-		function = "gpio";
+	touchscreen_default: touchscreen-default-state {
+		touch-pins {
+			pins = "gpio13";
+			function = "gpio";
 
-		drive-strength = <2>;
-		bias-pull-up;
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-		reset {
+		reset-pins {
 			pins = "gpio12";
 			function = "gpio";
 
@@ -311,7 +313,7 @@ reset {
 		};
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio110";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 9e470c67274e..a6a7d870f586 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -414,7 +414,7 @@ l18 {
 };
 
 &msmgpio {
-	accel_irq_default: accel-irq-default {
+	accel_irq_default: accel-irq-default-state {
 		pins = "gpio115";
 		function = "gpio";
 
@@ -422,7 +422,7 @@ accel_irq_default: accel-irq-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
@@ -430,7 +430,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	gpio_leds_default: gpio-leds-default {
+	gpio_leds_default: gpio-leds-default-state {
 		pins = "gpio8", "gpio9", "gpio10";
 		function = "gpio";
 
@@ -438,7 +438,7 @@ gpio_leds_default: gpio-leds-default {
 		bias-disable;
 	};
 
-	nfc_default: nfc-default {
+	nfc_default: nfc-default-state {
 		pins = "gpio2", "gpio20", "gpio21";
 		function = "gpio";
 
@@ -446,7 +446,7 @@ nfc_default: nfc-default {
 		bias-disable;
 	};
 
-	mag_reset_default: mag-reset-default {
+	mag_reset_default: mag-reset-default-state {
 		pins = "gpio36";
 		function = "gpio";
 
@@ -454,7 +454,7 @@ mag_reset_default: mag-reset-default {
 		bias-disable;
 	};
 
-	prox_irq_default: prox-irq-default {
+	prox_irq_default: prox-irq-default-state {
 		pins = "gpio113";
 		function = "gpio";
 
@@ -462,7 +462,7 @@ prox_irq_default: prox-irq-default {
 		bias-disable;
 	};
 
-	reg_lcd_en_default: reg-lcd-en-default {
+	reg_lcd_en_default: reg-lcd-en-default-state {
 		pins = "gpio32", "gpio97";
 		function = "gpio";
 
@@ -470,7 +470,7 @@ reg_lcd_en_default: reg-lcd-en-default {
 		bias-disable;
 	};
 
-	sdhc2_cd_default: sdhc2-cd-default {
+	sdhc2_cd_default: sdhc2-cd-default-state {
 		pins = "gpio56";
 		function = "gpio";
 
@@ -478,7 +478,7 @@ sdhc2_cd_default: sdhc2-cd-default {
 		bias-disable;
 	};
 
-	ts_irq_default: ts-irq-default {
+	ts_irq_default: ts-irq-default-state {
 		pins = "gpio13";
 		function = "gpio";
 
@@ -486,7 +486,7 @@ ts_irq_default: ts-irq-default {
 		bias-disable;
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio117";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index d85e7f7c0835..31214570be4b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -367,7 +367,7 @@ l18 {
 };
 
 &msmgpio {
-	accel_int_default: accel-int-default {
+	accel_int_default: accel-int-default-state {
 		pins = "gpio116";
 		function = "gpio";
 
@@ -375,7 +375,7 @@ accel_int_default: accel-int-default {
 		bias-disable;
 	};
 
-	camera_flash_default: camera-flash-default {
+	camera_flash_default: camera-flash-default-state {
 		pins = "gpio31", "gpio32";
 		function = "gpio";
 
@@ -383,7 +383,7 @@ camera_flash_default: camera-flash-default {
 		bias-disable;
 	};
 
-	ctp_pwr_en_default: ctp-pwr-en-default {
+	ctp_pwr_en_default: ctp-pwr-en-default-state {
 		pins = "gpio17";
 		function = "gpio";
 
@@ -391,7 +391,7 @@ ctp_pwr_en_default: ctp-pwr-en-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
@@ -399,7 +399,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	gyro_int_default: gyro-int-default {
+	gyro_int_default: gyro-int-default-state {
 		pins = "gpio22", "gpio23";
 		function = "gpio";
 
@@ -407,7 +407,7 @@ gyro_int_default: gyro-int-default {
 		bias-disable;
 	};
 
-	light_int_default: light-int-default {
+	light_int_default: light-int-default-state {
 		pins = "gpio115";
 		function = "gpio";
 
@@ -415,7 +415,7 @@ light_int_default: light-int-default {
 		bias-disable;
 	};
 
-	magn_int_default: magn-int-default {
+	magn_int_default: magn-int-default-state {
 		pins = "gpio113";
 		function = "gpio";
 
@@ -423,7 +423,7 @@ magn_int_default: magn-int-default {
 		bias-disable;
 	};
 
-	tp_int_default: tp-int-default {
+	tp_int_default: tp-int-default-state {
 		pins = "gpio13";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index b4812f093b17..3899e11b9843 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -234,7 +234,7 @@ l18 {
 };
 
 &msmgpio {
-	button_backlight_default: button-backlight-default {
+	button_backlight_default: button-backlight-default-state {
 		pins = "gpio17";
 		function = "gpio";
 
@@ -242,7 +242,7 @@ button_backlight_default: button-backlight-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
@@ -250,7 +250,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	mag_reset_default: mag-reset-default {
+	mag_reset_default: mag-reset-default-state {
 		pins = "gpio111";
 		function = "gpio";
 
@@ -258,7 +258,7 @@ mag_reset_default: mag-reset-default {
 		bias-disable;
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio110";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 7dedb91b9930..8dc245e59a6e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -5,7 +5,7 @@
 
 &msmgpio {
 
-	blsp1_uart1_default: blsp1-uart1-default {
+	blsp1_uart1_default: blsp1-uart1-default-state {
 		//	TX, RX, CTS_N, RTS_N
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "blsp_uart1";
@@ -14,7 +14,7 @@ blsp1_uart1_default: blsp1-uart1-default {
 		bias-disable;
 	};
 
-	blsp1_uart1_sleep: blsp1-uart1-sleep {
+	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "gpio";
 
@@ -22,7 +22,7 @@ blsp1_uart1_sleep: blsp1-uart1-sleep {
 		bias-pull-down;
 	};
 
-	blsp1_uart2_default: blsp1-uart2-default {
+	blsp1_uart2_default: blsp1-uart2-default-state {
 		pins = "gpio4", "gpio5";
 		function = "blsp_uart2";
 
@@ -30,7 +30,7 @@ blsp1_uart2_default: blsp1-uart2-default {
 		bias-disable;
 	};
 
-	blsp1_uart2_sleep: blsp1-uart2-sleep {
+	blsp1_uart2_sleep: blsp1-uart2-sleep-state {
 		pins = "gpio4", "gpio5";
 		function = "gpio";
 
@@ -38,14 +38,16 @@ blsp1_uart2_sleep: blsp1-uart2-sleep {
 		bias-pull-down;
 	};
 
-	spi1_default: spi1-default {
-		pins = "gpio0", "gpio1", "gpio3";
-		function = "blsp_spi1";
+	spi1_default: spi1-default-state {
+		spi-pins {
+			pins = "gpio0", "gpio1", "gpio3";
+			function = "blsp_spi1";
 
-		drive-strength = <12>;
-		bias-disable;
+			drive-strength = <12>;
+			bias-disable;
+		};
 
-		cs {
+		cs-pins {
 			pins = "gpio2";
 			function = "gpio";
 
@@ -55,7 +57,7 @@ cs {
 		};
 	};
 
-	spi1_sleep: spi1-sleep {
+	spi1_sleep: spi1-sleep-state {
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "gpio";
 
@@ -63,14 +65,16 @@ spi1_sleep: spi1-sleep {
 		bias-pull-down;
 	};
 
-	spi2_default: spi2-default {
-		pins = "gpio4", "gpio5", "gpio7";
-		function = "blsp_spi2";
+	spi2_default: spi2-default-state {
+		spi-pins {
+			pins = "gpio4", "gpio5", "gpio7";
+			function = "blsp_spi2";
 
-		drive-strength = <12>;
-		bias-disable;
+			drive-strength = <12>;
+			bias-disable;
+		};
 
-		cs {
+		cs-pins {
 			pins = "gpio6";
 			function = "gpio";
 
@@ -80,7 +84,7 @@ cs {
 		};
 	};
 
-	spi2_sleep: spi2-sleep {
+	spi2_sleep: spi2-sleep-state {
 		pins = "gpio4", "gpio5", "gpio6", "gpio7";
 		function = "gpio";
 
@@ -88,14 +92,16 @@ spi2_sleep: spi2-sleep {
 		bias-pull-down;
 	};
 
-	spi3_default: spi3-default {
-		pins = "gpio8", "gpio9", "gpio11";
-		function = "blsp_spi3";
+	spi3_default: spi3-default-state {
+		spi-pins {
+			pins = "gpio8", "gpio9", "gpio11";
+			function = "blsp_spi3";
 
-		drive-strength = <12>;
-		bias-disable;
+			drive-strength = <12>;
+			bias-disable;
+		};
 
-		cs {
+		cs-pins {
 			pins = "gpio10";
 			function = "gpio";
 
@@ -105,7 +111,7 @@ cs {
 		};
 	};
 
-	spi3_sleep: spi3-sleep {
+	spi3_sleep: spi3-sleep-state {
 		pins = "gpio8", "gpio9", "gpio10", "gpio11";
 		function = "gpio";
 
@@ -113,14 +119,16 @@ spi3_sleep: spi3-sleep {
 		bias-pull-down;
 	};
 
-	spi4_default: spi4-default {
-		pins = "gpio12", "gpio13", "gpio15";
-		function = "blsp_spi4";
+	spi4_default: spi4-default-state {
+		spi-pins {
+			pins = "gpio12", "gpio13", "gpio15";
+			function = "blsp_spi4";
 
-		drive-strength = <12>;
-		bias-disable;
+			drive-strength = <12>;
+			bias-disable;
+		};
 
-		cs {
+		cs-pins {
 			pins = "gpio14";
 			function = "gpio";
 
@@ -130,7 +138,7 @@ cs {
 		};
 	};
 
-	spi4_sleep: spi4-sleep {
+	spi4_sleep: spi4-sleep-state {
 		pins = "gpio12", "gpio13", "gpio14", "gpio15";
 		function = "gpio";
 
@@ -138,14 +146,16 @@ spi4_sleep: spi4-sleep {
 		bias-pull-down;
 	};
 
-	spi5_default: spi5-default {
-		pins = "gpio16", "gpio17", "gpio19";
-		function = "blsp_spi5";
+	spi5_default: spi5-default-state {
+		spi-pins {
+			pins = "gpio16", "gpio17", "gpio19";
+			function = "blsp_spi5";
 
-		drive-strength = <12>;
-		bias-disable;
+			drive-strength = <12>;
+			bias-disable;
+		};
 
-		cs {
+		cs-pins {
 			pins = "gpio18";
 			function = "gpio";
 
@@ -155,7 +165,7 @@ cs {
 		};
 	};
 
-	spi5_sleep: spi5-sleep {
+	spi5_sleep: spi5-sleep-state {
 		pins = "gpio16", "gpio17", "gpio18", "gpio19";
 		function = "gpio";
 
@@ -163,14 +173,16 @@ spi5_sleep: spi5-sleep {
 		bias-pull-down;
 	};
 
-	spi6_default: spi6-default {
-		pins = "gpio20", "gpio21", "gpio23";
-		function = "blsp_spi6";
+	spi6_default: spi6-default-state {
+		spi-pins {
+			pins = "gpio20", "gpio21", "gpio23";
+			function = "blsp_spi6";
 
-		drive-strength = <12>;
-		bias-disable;
+			drive-strength = <12>;
+			bias-disable;
+		};
 
-		cs {
+		cs-pins {
 			pins = "gpio22";
 			function = "gpio";
 
@@ -180,7 +192,7 @@ cs {
 		};
 	};
 
-	spi6_sleep: spi6-sleep {
+	spi6_sleep: spi6-sleep-state {
 		pins = "gpio20", "gpio21", "gpio22", "gpio23";
 		function = "gpio";
 
@@ -188,7 +200,7 @@ spi6_sleep: spi6-sleep {
 		bias-pull-down;
 	};
 
-	i2c1_default: i2c1-default {
+	i2c1_default: i2c1-default-state {
 		pins = "gpio2", "gpio3";
 		function = "blsp_i2c1";
 
@@ -196,7 +208,7 @@ i2c1_default: i2c1-default {
 		bias-disable;
 	};
 
-	i2c1_sleep: i2c1-sleep {
+	i2c1_sleep: i2c1-sleep-state {
 		pins = "gpio2", "gpio3";
 		function = "gpio";
 
@@ -204,7 +216,7 @@ i2c1_sleep: i2c1-sleep {
 		bias-disable;
 	};
 
-	i2c2_default: i2c2-default {
+	i2c2_default: i2c2-default-state {
 		pins = "gpio6", "gpio7";
 		function = "blsp_i2c2";
 
@@ -212,7 +224,7 @@ i2c2_default: i2c2-default {
 		bias-disable;
 	};
 
-	i2c2_sleep: i2c2-sleep {
+	i2c2_sleep: i2c2-sleep-state {
 		pins = "gpio6", "gpio7";
 		function = "gpio";
 
@@ -220,7 +232,7 @@ i2c2_sleep: i2c2-sleep {
 		bias-disable;
 	};
 
-	i2c3_default: i2c3-default {
+	i2c3_default: i2c3-default-state {
 		pins = "gpio10", "gpio11";
 		function = "blsp_i2c3";
 
@@ -228,7 +240,7 @@ i2c3_default: i2c3-default {
 		bias-disable;
 	};
 
-	i2c3_sleep: i2c3-sleep {
+	i2c3_sleep: i2c3-sleep-state {
 		pins = "gpio10", "gpio11";
 		function = "gpio";
 
@@ -236,7 +248,7 @@ i2c3_sleep: i2c3-sleep {
 		bias-disable;
 	};
 
-	i2c4_default: i2c4-default {
+	i2c4_default: i2c4-default-state {
 		pins = "gpio14", "gpio15";
 		function = "blsp_i2c4";
 
@@ -244,7 +256,7 @@ i2c4_default: i2c4-default {
 		bias-disable;
 	};
 
-	i2c4_sleep: i2c4-sleep {
+	i2c4_sleep: i2c4-sleep-state {
 		pins = "gpio14", "gpio15";
 		function = "gpio";
 
@@ -252,7 +264,7 @@ i2c4_sleep: i2c4-sleep {
 		bias-disable;
 	};
 
-	i2c5_default: i2c5-default {
+	i2c5_default: i2c5-default-state {
 		pins = "gpio18", "gpio19";
 		function = "blsp_i2c5";
 
@@ -260,7 +272,7 @@ i2c5_default: i2c5-default {
 		bias-disable;
 	};
 
-	i2c5_sleep: i2c5-sleep {
+	i2c5_sleep: i2c5-sleep-state {
 		pins = "gpio18", "gpio19";
 		function = "gpio";
 
@@ -268,7 +280,7 @@ i2c5_sleep: i2c5-sleep {
 		bias-disable;
 	};
 
-	i2c6_default: i2c6-default {
+	i2c6_default: i2c6-default-state {
 		pins = "gpio22", "gpio23";
 		function = "blsp_i2c6";
 
@@ -276,7 +288,7 @@ i2c6_default: i2c6-default {
 		bias-disable;
 	};
 
-	i2c6_sleep: i2c6-sleep {
+	i2c6_sleep: i2c6-sleep-state {
 		pins = "gpio22", "gpio23";
 		function = "gpio";
 
@@ -284,14 +296,14 @@ i2c6_sleep: i2c6-sleep {
 		bias-disable;
 	};
 
-	pmx-sdc1-clk {
-		sdc1_clk_on: clk-on {
+	pmx-sdc1-clk-state {
+		sdc1_clk_on: clk-on-pins {
 			pins = "sdc1_clk";
 
 			bias-disable;
 			drive-strength = <16>;
 		};
-		sdc1_clk_off: clk-off {
+		sdc1_clk_off: clk-off-pins {
 			pins = "sdc1_clk";
 
 			bias-disable;
@@ -299,14 +311,14 @@ sdc1_clk_off: clk-off {
 		};
 	};
 
-	pmx-sdc1-cmd {
-		sdc1_cmd_on: cmd-on {
+	pmx-sdc1-cmd-state {
+		sdc1_cmd_on: cmd-on-pins {
 			pins = "sdc1_cmd";
 
 			bias-pull-up;
 			drive-strength = <10>;
 		};
-		sdc1_cmd_off: cmd-off {
+		sdc1_cmd_off: cmd-off-pins {
 			pins = "sdc1_cmd";
 
 			bias-pull-up;
@@ -314,14 +326,14 @@ sdc1_cmd_off: cmd-off {
 		};
 	};
 
-	pmx-sdc1-data {
-		sdc1_data_on: data-on {
+	pmx-sdc1-data-state {
+		sdc1_data_on: data-on-pins {
 			pins = "sdc1_data";
 
 			bias-pull-up;
 			drive-strength = <10>;
 		};
-		sdc1_data_off: data-off {
+		sdc1_data_off: data-off-pins {
 			pins = "sdc1_data";
 
 			bias-pull-up;
@@ -329,14 +341,14 @@ sdc1_data_off: data-off {
 		};
 	};
 
-	pmx-sdc2-clk {
-		sdc2_clk_on: clk-on {
+	pmx-sdc2-clk-state {
+		sdc2_clk_on: clk-on-pins {
 			pins = "sdc2_clk";
 
 			bias-disable;
 			drive-strength = <16>;
 		};
-		sdc2_clk_off: clk-off {
+		sdc2_clk_off: clk-off-pins {
 			pins = "sdc2_clk";
 
 			bias-disable;
@@ -344,14 +356,14 @@ sdc2_clk_off: clk-off {
 		};
 	};
 
-	pmx-sdc2-cmd {
-		sdc2_cmd_on: cmd-on {
+	pmx-sdc2-cmd-state {
+		sdc2_cmd_on: cmd-on-pins {
 			pins = "sdc2_cmd";
 
 			bias-pull-up;
 			drive-strength = <10>;
 		};
-		sdc2_cmd_off: cmd-off {
+		sdc2_cmd_off: cmd-off-pins {
 			pins = "sdc2_cmd";
 
 			bias-pull-up;
@@ -359,14 +371,14 @@ sdc2_cmd_off: cmd-off {
 		};
 	};
 
-	pmx-sdc2-data {
-		sdc2_data_on: data-on {
+	pmx-sdc2-data-state {
+		sdc2_data_on: data-on-pins {
 			pins = "sdc2_data";
 
 			bias-pull-up;
 			drive-strength = <10>;
 		};
-		sdc2_data_off: data-off {
+		sdc2_data_off: data-off-pins {
 			pins = "sdc2_data";
 
 			bias-pull-up;
@@ -374,15 +386,15 @@ sdc2_data_off: data-off {
 		};
 	};
 
-	pmx-sdc2-cd-pin {
-		sdc2_cd_on: cd-on {
+	pmx-sdc2-cd-pin-state {
+		sdc2_cd_on: cd-on-pins {
 			pins = "gpio38";
 			function = "gpio";
 
 			drive-strength = <2>;
 			bias-pull-up;
 		};
-		sdc2_cd_off: cd-off {
+		sdc2_cd_off: cd-off-pins {
 			pins = "gpio38";
 			function = "gpio";
 
@@ -391,8 +403,8 @@ sdc2_cd_off: cd-off {
 		};
 	};
 
-	cdc-pdm-lines {
-		cdc_pdm_lines_act: pdm-lines-on {
+	cdc-pdm-lines-state {
+		cdc_pdm_lines_act: pdm-lines-on-pins {
 			pins = "gpio63", "gpio64", "gpio65", "gpio66",
 			       "gpio67", "gpio68";
 			function = "cdc_pdm0";
@@ -400,7 +412,7 @@ cdc_pdm_lines_act: pdm-lines-on {
 			drive-strength = <8>;
 			bias-disable;
 		};
-		cdc_pdm_lines_sus: pdm-lines-off {
+		cdc_pdm_lines_sus: pdm-lines-off-pins {
 			pins = "gpio63", "gpio64", "gpio65", "gpio66",
 			       "gpio67", "gpio68";
 			function = "cdc_pdm0";
@@ -410,15 +422,15 @@ cdc_pdm_lines_sus: pdm-lines-off {
 		};
 	};
 
-	ext-pri-tlmm-lines {
-		ext_pri_tlmm_lines_act: ext-pa-on {
+	ext-pri-tlmm-lines-state {
+		ext_pri_tlmm_lines_act: ext-pa-on-pins {
 			pins = "gpio113", "gpio114", "gpio115", "gpio116";
 			function = "pri_mi2s";
 
 			drive-strength = <8>;
 			bias-disable;
 		};
-		ext_pri_tlmm_lines_sus: ext-pa-off {
+		ext_pri_tlmm_lines_sus: ext-pa-off-pins {
 			pins = "gpio113", "gpio114", "gpio115", "gpio116";
 			function = "pri_mi2s";
 
@@ -427,15 +439,15 @@ ext_pri_tlmm_lines_sus: ext-pa-off {
 		};
 	};
 
-	ext-pri-ws-line {
-		ext_pri_ws_act: ext-pa-on {
+	ext-pri-ws-line-state {
+		ext_pri_ws_act: ext-pa-on-pins {
 			pins = "gpio110";
 			function = "pri_mi2s_ws";
 
 			drive-strength = <8>;
 			bias-disable;
 		};
-		ext_pri_ws_sus: ext-pa-off {
+		ext_pri_ws_sus: ext-pa-off-pins {
 			pins = "gpio110";
 			function = "pri_mi2s_ws";
 
@@ -444,15 +456,15 @@ ext_pri_ws_sus: ext-pa-off {
 		};
 	};
 
-	ext-mclk-tlmm-lines {
-		ext_mclk_tlmm_lines_act: mclk-lines-on {
+	ext-mclk-tlmm-lines-state {
+		ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
 			pins = "gpio116";
 			function = "pri_mi2s";
 
 			drive-strength = <8>;
 			bias-disable;
 		};
-		ext_mclk_tlmm_lines_sus: mclk-lines-off {
+		ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
 			pins = "gpio116";
 			function = "pri_mi2s";
 
@@ -462,15 +474,15 @@ ext_mclk_tlmm_lines_sus: mclk-lines-off {
 	};
 
 	/* secondary Mi2S */
-	ext-sec-tlmm-lines {
-		ext_sec_tlmm_lines_act: tlmm-lines-on {
+	ext-sec-tlmm-lines-state {
+		ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
 			pins = "gpio112", "gpio117", "gpio118", "gpio119";
 			function = "sec_mi2s";
 
 			drive-strength = <8>;
 			bias-disable;
 		};
-		ext_sec_tlmm_lines_sus: tlmm-lines-off {
+		ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
 			pins = "gpio112", "gpio117", "gpio118", "gpio119";
 			function = "sec_mi2s";
 
@@ -479,40 +491,38 @@ ext_sec_tlmm_lines_sus: tlmm-lines-off {
 		};
 	};
 
-	cdc-dmic-lines {
-		cdc_dmic_lines_act: dmic-lines-on {
-			clk {
-				pins = "gpio0";
-				function = "dmic0_clk";
+	cdc_dmic_lines_act: dmic-lines-on-state {
+		clk-pins {
+			pins = "gpio0";
+			function = "dmic0_clk";
 
-				drive-strength = <8>;
-			};
-			data {
-				pins = "gpio1";
-				function = "dmic0_data";
+			drive-strength = <8>;
+		};
+		data-pins {
+			pins = "gpio1";
+			function = "dmic0_data";
 
-				drive-strength = <8>;
-			};
+			drive-strength = <8>;
 		};
-		cdc_dmic_lines_sus: dmic-lines-off {
-			clk {
-				pins = "gpio0";
-				function = "dmic0_clk";
+	};
+	cdc_dmic_lines_sus: dmic-lines-off-state {
+		clk-pins {
+			pins = "gpio0";
+			function = "dmic0_clk";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
-			data {
-				pins = "gpio1";
-				function = "dmic0_data";
+			drive-strength = <2>;
+			bias-disable;
+		};
+		data-pins {
+			pins = "gpio1";
+			function = "dmic0_data";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
-	wcnss_pin_a: wcnss-active {
+	wcnss_pin_a: wcnss-active-state {
 		pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
 		function = "wcss_wlan";
 
@@ -520,7 +530,7 @@ wcnss_pin_a: wcnss-active {
 		bias-pull-up;
 	};
 
-	cci0_default: cci0-default {
+	cci0_default: cci0-default-state {
 		pins = "gpio29", "gpio30";
 		function = "cci_i2c";
 
@@ -528,22 +538,22 @@ cci0_default: cci0-default {
 		bias-disable;
 	};
 
-	camera_front_default: camera-front-default {
-		pwdn {
+	camera_front_default: camera-front-default-state {
+		pwdn-pins {
 			pins = "gpio33";
 			function = "gpio";
 
 			drive-strength = <16>;
 			bias-disable;
 		};
-		rst {
+		rst-pins {
 			pins = "gpio28";
 			function = "gpio";
 
 			drive-strength = <16>;
 			bias-disable;
 		};
-		mclk1 {
+		mclk1-pins {
 			pins = "gpio27";
 			function = "cam_mclk1";
 
@@ -552,22 +562,22 @@ mclk1 {
 		};
 	};
 
-	camera_rear_default: camera-rear-default {
-		pwdn {
+	camera_rear_default: camera-rear-default-state {
+		pwdn-pins {
 			pins = "gpio34";
 			function = "gpio";
 
 			drive-strength = <16>;
 			bias-disable;
 		};
-		rst {
+		rst-pins {
 			pins = "gpio35";
 			function = "gpio";
 
 			drive-strength = <16>;
 			bias-disable;
 		};
-		mclk0 {
+		mclk0-pins {
 			pins = "gpio26";
 			function = "cam_mclk0";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 5f7cec347a4f..d701260c78b0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -348,7 +348,7 @@ l18 {
 };
 
 &msmgpio {
-	accel_int_default: accel-int-default {
+	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
 		function = "gpio";
 
@@ -356,7 +356,7 @@ accel_int_default: accel-int-default {
 		bias-disable;
 	};
 
-	fg_alert_default: fg-alert-default {
+	fg_alert_default: fg-alert-default-state {
 		pins = "gpio121";
 		function = "gpio";
 
@@ -364,7 +364,7 @@ fg_alert_default: fg-alert-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio109";
 		function = "gpio";
 
@@ -372,7 +372,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	gpio_hall_sensor_default: gpio-hall-sensor-default {
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 		pins = "gpio52";
 		function = "gpio";
 
@@ -380,24 +380,23 @@ gpio_hall_sensor_default: gpio-hall-sensor-default {
 		bias-disable;
 	};
 
-	mdss {
-		mdss_default: mdss-default {
-			pins = "gpio25";
-			function = "gpio";
+	mdss_default: mdss-default-state {
+		pins = "gpio25";
+		function = "gpio";
 
-			drive-strength = <8>;
-			bias-disable;
-		};
-		mdss_sleep: mdss-sleep {
-			pins = "gpio25";
-			function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
 
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	mdss_sleep: mdss-sleep-state {
+		pins = "gpio25";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	muic_i2c_default: muic-i2c-default {
+	muic_i2c_default: muic-i2c-default-state {
 		pins = "gpio105", "gpio106";
 		function = "gpio";
 
@@ -405,7 +404,7 @@ muic_i2c_default: muic-i2c-default {
 		bias-disable;
 	};
 
-	muic_int_default: muic-int-default {
+	muic_int_default: muic-int-default-state {
 		pins = "gpio12";
 		function = "gpio";
 
@@ -413,14 +412,16 @@ muic_int_default: muic-int-default {
 		bias-disable;
 	};
 
-	nfc_default: nfc-default {
-		pins = "gpio20", "gpio49";
-		function = "gpio";
+	nfc_default: nfc-default-state {
+		nfc-pins {
+			pins = "gpio20", "gpio49";
+			function = "gpio";
 
-		drive-strength = <2>;
-		bias-disable;
+			drive-strength = <2>;
+			bias-disable;
+		};
 
-		irq {
+		irq-pins {
 			pins = "gpio21";
 			function = "gpio";
 
@@ -429,7 +430,7 @@ irq {
 		};
 	};
 
-	nfc_i2c_default: nfc-i2c-default {
+	nfc_i2c_default: nfc-i2c-default-state {
 		pins = "gpio0", "gpio1";
 		function = "gpio";
 
@@ -437,7 +438,7 @@ nfc_i2c_default: nfc-i2c-default {
 		bias-disable;
 	};
 
-	tkey_default: tkey-default {
+	tkey_default: tkey-default-state {
 		pins = "gpio98";
 		function = "gpio";
 
@@ -445,7 +446,7 @@ tkey_default: tkey-default {
 		bias-disable;
 	};
 
-	tkey_i2c_default: tkey-i2c-default {
+	tkey_i2c_default: tkey-i2c-default-state {
 		pins = "gpio16", "gpio17";
 		function = "gpio";
 
@@ -453,7 +454,7 @@ tkey_i2c_default: tkey-i2c-default {
 		bias-disable;
 	};
 
-	tsp_en_default: tsp-en-default {
+	tsp_en_default: tsp-en-default-state {
 		pins = "gpio73";
 		function = "gpio";
 
@@ -461,7 +462,7 @@ tsp_en_default: tsp-en-default {
 		bias-disable;
 	};
 
-	ts_int_default: ts-int-default {
+	ts_int_default: ts-int-default-state {
 		pins = "gpio13";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 6db5f78ca286..0733b73b6dd1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -105,7 +105,7 @@ &dsi0_out {
 };
 
 &msmgpio {
-	panel_vdd3_default: panel-vdd3-default {
+	panel_vdd3_default: panel-vdd3-default-state {
 		pins = "gpio9";
 		function = "gpio";
 
@@ -113,7 +113,7 @@ panel_vdd3_default: panel-vdd3-default {
 		bias-disable;
 	};
 
-	tkey_en_default: tkey-en-default {
+	tkey_en_default: tkey-en-default-state {
 		pins = "gpio86";
 		function = "gpio";
 
@@ -121,7 +121,7 @@ tkey_en_default: tkey-en-default {
 		bias-disable;
 	};
 
-	tkey_led_en_default: tkey-led-en-default {
+	tkey_led_en_default: tkey-led-en-default-state {
 		pins = "gpio60";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index 5fb8ecd0c9ca..5131bb1f6ba3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -62,7 +62,7 @@ &touchkey {
 };
 
 &msmgpio {
-	tkey_en_default: tkey-en-default {
+	tkey_en_default: tkey-en-default-state {
 		pins = "gpio97";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 542010fdfb8a..450986e09c33 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -67,7 +67,7 @@ &touchkey {
 };
 
 &msmgpio {
-	motor_en_default: motor-en-default {
+	motor_en_default: motor-en-default-state {
 		pins = "gpio76";
 		function = "gpio";
 
@@ -75,7 +75,7 @@ motor_en_default: motor-en-default {
 		bias-disable;
 	};
 
-	tkey_en_default: tkey-en-default {
+	tkey_en_default: tkey-en-default-state {
 		pins = "gpio97";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index bc7134698978..a3d572d851ef 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -46,7 +46,7 @@ &reg_touch_key {
 };
 
 &msmgpio {
-	gpio_leds_default: gpio-led-default {
+	gpio_leds_default: gpio-led-default-state {
 		pins = "gpio60";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index eabeed18cfaa..7ac49a021563 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -199,7 +199,7 @@ l18 {
 };
 
 &msmgpio {
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio109";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index bbd6bb3f4fd7..82fbcd5795dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -422,7 +422,7 @@ l18 {
 };
 
 &msmgpio {
-	fg_alert_default: fg-alert-default {
+	fg_alert_default: fg-alert-default-state {
 		pins = "gpio121";
 		function = "gpio";
 
@@ -430,7 +430,7 @@ fg_alert_default: fg-alert-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio109";
 		function = "gpio";
 
@@ -438,7 +438,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	gpio_hall_sensor_default: gpio-hall-sensor-default {
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 		pins = "gpio52";
 		function = "gpio";
 
@@ -446,7 +446,7 @@ gpio_hall_sensor_default: gpio-hall-sensor-default {
 		bias-disable;
 	};
 
-	imu_irq_default: imu-irq-default {
+	imu_irq_default: imu-irq-default-state {
 		pins = "gpio115";
 		function = "gpio";
 
@@ -454,7 +454,7 @@ imu_irq_default: imu-irq-default {
 		bias-disable;
 	};
 
-	muic_i2c_default: muic-i2c-default {
+	muic_i2c_default: muic-i2c-default-state {
 		pins = "gpio105", "gpio106";
 		function = "gpio";
 
@@ -462,7 +462,7 @@ muic_i2c_default: muic-i2c-default {
 		bias-disable;
 	};
 
-	muic_irq_default: muic-irq-default {
+	muic_irq_default: muic-irq-default-state {
 		pins = "gpio12";
 		function = "gpio";
 
@@ -470,14 +470,16 @@ muic_irq_default: muic-irq-default {
 		bias-disable;
 	};
 
-	nfc_default: nfc-default {
-		pins = "gpio20", "gpio49";
-		function = "gpio";
+	nfc_default: nfc-default-state {
+		nfc-pins {
+			pins = "gpio20", "gpio49";
+			function = "gpio";
 
-		drive-strength = <2>;
-		bias-disable;
+			drive-strength = <2>;
+			bias-disable;
+		};
 
-		irq {
+		irq-pins {
 			pins = "gpio21";
 			function = "gpio";
 
@@ -486,7 +488,7 @@ irq {
 		};
 	};
 
-	nfc_i2c_default: nfc-i2c-default {
+	nfc_i2c_default: nfc-i2c-default-state {
 		pins = "gpio0", "gpio1";
 		function = "gpio";
 
@@ -494,7 +496,7 @@ nfc_i2c_default: nfc-i2c-default {
 		bias-disable;
 	};
 
-	tkey_default: tkey-default {
+	tkey_default: tkey-default-state {
 		pins = "gpio98";
 		function = "gpio";
 
@@ -502,7 +504,7 @@ tkey_default: tkey-default {
 		bias-disable;
 	};
 
-	tkey_en_default: tkey-en-default {
+	tkey_en_default: tkey-en-default-state {
 		pins = "gpio86";
 		function = "gpio";
 
@@ -510,7 +512,7 @@ tkey_en_default: tkey-en-default {
 		bias-disable;
 	};
 
-	tkey_i2c_default: tkey-i2c-default {
+	tkey_i2c_default: tkey-i2c-default-state {
 		pins = "gpio16", "gpio17";
 		function = "gpio";
 
@@ -518,7 +520,7 @@ tkey_i2c_default: tkey-i2c-default {
 		bias-disable;
 	};
 
-	tkey_led_en_default: tkey-led-en-default {
+	tkey_led_en_default: tkey-led-en-default-state {
 		pins = "gpio60";
 		function = "gpio";
 
@@ -526,7 +528,7 @@ tkey_led_en_default: tkey-led-en-default {
 		bias-disable;
 	};
 
-	tsp_en_default: tsp-en-default {
+	tsp_en_default: tsp-en-default-state {
 		pins = "gpio73";
 		function = "gpio";
 
@@ -534,7 +536,7 @@ tsp_en_default: tsp-en-default {
 		bias-disable;
 	};
 
-	tsp_irq_default: tsp-irq-default {
+	tsp_irq_default: tsp-irq-default-state {
 		pins = "gpio13";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 84a352dcf9a2..9dd4312c9933 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -272,7 +272,7 @@ l18 {
 };
 
 &msmgpio {
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
@@ -280,7 +280,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	imu_default: imu-default {
+	imu_default: imu-default-state {
 		pins = "gpio115";
 		function = "gpio";
 
@@ -288,14 +288,16 @@ imu_default: imu-default {
 		bias-disable;
 	};
 
-	touchscreen_default: touchscreen-default {
-		pins = "gpio13";
-		function = "gpio";
+	touchscreen_default: touchscreen-default-state {
+		touch-pins {
+			pins = "gpio13";
+			function = "gpio";
 
-		drive-strength = <2>;
-		bias-pull-up;
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-		reset {
+		reset-pins {
 			pins = "gpio12";
 			function = "gpio";
 
@@ -304,7 +306,7 @@ reset {
 		};
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio110";
 		function = "gpio";
 
-- 
2.34.1

