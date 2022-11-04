Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE09D619B64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiKDPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKDPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:23:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DA64C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:23:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so5631707wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KO8u1fWmXYW44Q8qiKKePwojSwXcaSpsCB3zeR19r8=;
        b=ohrefsBkU6klvoxzRkPZiyQU9mLGiyCkrpJmF8FtG6Uexm46zEpISW/HDTOs+GJQoT
         24VdzSc5ubJG0tfFtmY1z5w4lJZpyLJGoEFNHG7YJ3rll5XiAGQctPA2ZDIvtXxu2Pzh
         gzEifVP9XVFG8QQfyr1NOfu7Ph8+7zoj1QvhaK6/99k/MKPTi7sJ0JmpxmQMlWVIRuZq
         R+B/FnW6haN4fzBHCeMposC+a4vpnBOfHEWaoxGWP3Y+AYUPF3ZD20uovLaMCTzNiRtV
         XcENAAn3NcJih+K2A3X9Ej3E8oKRJ5MhSw9E3lnZS5mIFXxHGTtU4ykYc1+oCY97sq+p
         FlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KO8u1fWmXYW44Q8qiKKePwojSwXcaSpsCB3zeR19r8=;
        b=b7jva6dmIARZjBkQ/05cHSodABRyUpcOcngi9oHJPWhyQYQ5nnO9THMgwkk3IKzi9Z
         pryYe2YBm2yX2+SGoNbp0e6IvcVk2/vzdJ9+s436SCt7hQ58IsFfzOAOh8pvOwAh0oCN
         ANX2ODgdmkDtfUFtXusGPSA2+zzs+dM5eiLo8eJf/ByRC6+toJdBJffoa2FOyOHvu+Zd
         HyNNXirlqObQwnwDsDtMi//eV32oiEGReyllhC7QByAcwNc3Lpu0J6jEMi9jrbTipiRC
         +XpQOx5WAE0xybxaKSWOTJ8QBEL3g7l/8IoQAB3Nm0vi8HHmID7pQOiokIU2m+TBNmhX
         1bqA==
X-Gm-Message-State: ACrzQf1nolgMegpVlneoHORemS7SJtCHCnpvrbQHod5mleznHSGLZY2w
        XNqVVcylVNjZZolSqfimfaiE4A==
X-Google-Smtp-Source: AMsMyM6918870VrI32hASYUr0LagDS4kTdvUAYgMbVRf7yeLiD2Gq8EH9YMwPl/INZ8fFXiPuUJkQQ==
X-Received: by 2002:a05:600c:1e19:b0:3cf:6bbf:9edd with SMTP id ay25-20020a05600c1e1900b003cf6bbf9eddmr21523302wmb.9.1667575402720;
        Fri, 04 Nov 2022 08:23:22 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c08a900b003b4935f04a4sm3689764wmp.5.2022.11.04.08.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:23:21 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC support for AM642 SK board.
Date:   Fri,  4 Nov 2022 16:23:06 +0100
Message-Id: <20221104152311.1098603-2-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104152311.1098603-1-jneanne@baylibre.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome NEANNE <jneanne@baylibre.com>

Add support fot the TI Power Management IC TPS65219
on the AM642 SKEVM board.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 104 +++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 738d0cf6c40a..d0121976491a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -219,6 +219,20 @@ led-7 {
 			gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	vsel_sd_nddr: gpio-regulator {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel_sd_nddr_pins_default>;
+		regulator-name = "tps65219-LDO1-SEL-SD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&ldo1_reg>;
+		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
 };
 
 &main_pmx0 {
@@ -250,6 +264,13 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-pins-default {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
@@ -336,6 +357,12 @@ main_wlan_pins_default: main-wlan-pins-default {
 			AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
 		>;
 	};
+
+	vsel_sd_nddr_pins_default: vsel-sd-nddr-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 7) /* (Y7) PRG1_PRU0_GPO0.GPIO0_45 */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -384,6 +411,83 @@ &mcu_i2c1 {
 	status = "disabled";
 };
 
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		system-power-controller;
+
+		buck1-supply = <&vcc_3v3_sys>;
+		buck2-supply = <&vcc_3v3_sys>;
+		buck3-supply = <&vcc_3v3_sys>;
+		ldo1-supply = <&vcc_3v3_sys>;
+		ldo2-supply = <&buck2_reg>;
+		ldo3-supply = <&vcc_3v3_sys>;
+		ldo4-supply = <&vcc_3v3_sys>;
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VCC1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_LPDDR4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-name = "VDDSHV_SD_IO_PMIC";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "VDDAR_CORE";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-name = "VDD_PHY_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-- 
2.25.1

