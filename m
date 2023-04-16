Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7A6E3760
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDPKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDPKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:19:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9568F40EC;
        Sun, 16 Apr 2023 03:18:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so3996028a12.0;
        Sun, 16 Apr 2023 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640313; x=1684232313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa4w7G/5niGhmqPqAzOIRPLycj7L1VMGQ6/V6mVzQ8s=;
        b=ZEM4Q/20lb/C50al/CoJurOuXc4/KjdmXAa1/ThrLqHR574stHq74+fdX8ulsFY+1S
         /pplYtVQ4YkjXiN2NytIfHr8dl+HgJwJBTMX+dkvldUvcU/01eCksYlZAHb0LsaC0ITh
         fK7tlXtEkhvet8iWNjgZRLVkmZ+sQ2O9qVyptiYpGS99EjNuBLwZ6/1mMcOj9QSJddCu
         E6fiLyCjjZSEn/CsINt1RezQTDxUpNYYHJTcHCNreKWHRvrIWz7IFxW4B2Nj3PaBsGAX
         ir0XVdko6It4fsmVIuAE9gHZ3fiOLuaoCIUYbyQYODtfUInXwk1x5q/e0vm6hxu57cR3
         MyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640313; x=1684232313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa4w7G/5niGhmqPqAzOIRPLycj7L1VMGQ6/V6mVzQ8s=;
        b=Ica5puW9h87CVXrYg4gOggUIZIRp+lYjxSxYdNZbiPpd34+zaJVntIICu8PCFx8Vjq
         AEcmqpnxoGZnq0AJrhG+xZqS8lyfhWum8jPLkebDHkLqNPpjfKGPjRVhPsWItNze8E60
         Ux6ehLbper/jAETmeZuNB153Yf41IIECLOLlbDrdyyfOXZxewtvhPJFbup5pL8nHvwSc
         1CgAc/evwMqV8+0NeQLCRZnnFLu8m9VJsqg4ptrp64g999JoEz2r/Ayw/s3z+bU2+nXC
         c2zn/6DNuMdsiFJ19o5wIbR5t721X7lCHczV8dMjUgcmRJWv6eosqXaizWilnpmsukyr
         9LWw==
X-Gm-Message-State: AAQBX9cDpKtXxmGufdJpjw/mblzBx5oDYzpm8NiVmBNe4yEjX4+IfSDn
        8uCpas+9htExzwpmxd5XhyI=
X-Google-Smtp-Source: AKy350ao0FGPvuSnaoubK3k9JXuOdxQZhm8NMQ7EIVrndA32eQZ5omGRdkM+VGUaVQUR/seN9NNCjQ==
X-Received: by 2002:a05:6402:7c1:b0:505:661:fdf2 with SMTP id u1-20020a05640207c100b005050661fdf2mr11393248edy.23.1681640313006;
        Sun, 16 Apr 2023 03:18:33 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:32 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 12/12] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards
Date:   Sun, 16 Apr 2023 12:16:24 +0200
Message-Id: <20230416101624.15866-13-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for the Galaxy Tab 3 8.0 series of boards:

 - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
 - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
 - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)

What works:

 - Display and backlight
 - Touchscreen (without touchkeys)
 - GPIO buttons, hall sensor
 - WiFi and Bluetooth
 - USB, fuel gauge, charging (partial)
 - Accelerometer and magnetometer
 - WiFi model only: light sensor

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/Makefile                  |    3 +
 arch/arm/boot/dts/exynos4212-tab3-3g8.dts   |   30 +
 arch/arm/boot/dts/exynos4212-tab3-lte8.dts  |   43 +
 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts |   25 +
 arch/arm/boot/dts/exynos4212-tab3.dtsi      | 1175 +++++++++++++++++++
 5 files changed, 1276 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..e5f63b636637 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -217,6 +217,9 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
 	exynos4210-universal_c210.dtb \
+	exynos4212-tab3-3g8.dtb \
+	exynos4212-tab3-lte8.dtb \
+	exynos4212-tab3-wifi8.dtb \
 	exynos4412-i9300.dtb \
 	exynos4412-i9305.dtb \
 	exynos4412-itop-elite.dtb \
diff --git a/arch/arm/boot/dts/exynos4212-tab3-3g8.dts b/arch/arm/boot/dts/exynos4212-tab3-3g8.dts
new file mode 100644
index 000000000000..c503a2d351dd
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4212-tab3-3g8.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos4212 based Galaxy Tab 3 8.0 WiFi board device tree
+ * source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ */
+
+/dts-v1/;
+#include "exynos4212-tab3.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 3 8.0 3G (SM-T311) based on Exynos4212";
+	compatible = "samsung,t311", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
+	chassis-type = "tablet";
+};
+
+/* Pin control sleep state overrides */
+
+&sleep0 {
+		PIN_SLP(gpb-5, INPUT, UP);
+};
+
+&sleep1 {
+		PIN_SLP(gpl0-0, OUT0, NONE);
+		PIN_SLP(gpl1-0, OUT0, NONE);
+		PIN_SLP(gpl2-4, OUT0, NONE);
+		PIN_SLP(gpm3-3, OUT1, NONE);
+};
diff --git a/arch/arm/boot/dts/exynos4212-tab3-lte8.dts b/arch/arm/boot/dts/exynos4212-tab3-lte8.dts
new file mode 100644
index 000000000000..158c6a2e24bf
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4212-tab3-lte8.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos4212 based Galaxy Tab 3 8.0 WiFi board device tree
+ * source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ */
+
+/dts-v1/;
+#include "exynos4212-tab3.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 3 8.0 LTE (SM-T315) based on Exynos4212";
+	compatible = "samsung,t315", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
+	chassis-type = "tablet";
+};
+
+&sleep0 {
+		PIN_SLP(gpa0-4, INPUT, UP);
+		PIN_SLP(gpa0-5, INPUT, UP);
+
+		PIN_SLP(gpb-5, INPUT, UP);
+
+		PIN_SLP(gpc0-0, PREV, NONE);
+		PIN_SLP(gpc1-3, INPUT, NONE);
+
+		PIN_SLP(gpf1-6, INPUT, NONE);
+		PIN_SLP(gpf2-2, PREV, NONE);
+};
+
+&sleep1 {
+		PIN_SLP(gpl0-0, PREV, NONE);
+
+		PIN_SLP(gpl1-0, PREV, NONE);
+
+		PIN_SLP(gpl2-1, INPUT, DOWN);
+		PIN_SLP(gpl2-2, INPUT, DOWN);
+		PIN_SLP(gpl2-4, OUT0, NONE);
+		PIN_SLP(gpl2-5, PREV, NONE);
+
+		PIN_SLP(gpm3-3, OUT1, NONE);
+};
diff --git a/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts b/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
new file mode 100644
index 000000000000..0527a75710d8
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos4212 based Galaxy Tab 3 8.0 WiFi board device tree
+ * source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ */
+
+/dts-v1/;
+#include "exynos4212-tab3.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 3 8.0 WiFi (SM-T310) based on Exynos4212";
+	compatible = "samsung,t310", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
+	chassis-type = "tablet";
+};
+
+&i2c_lightsensor {
+	/* Capella Micro CM3323 color light sensor */
+	colorsensor@10 {
+		compatible = "capella,cm3323";
+		reg = <0x10>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4212-tab3.dtsi b/arch/arm/boot/dts/exynos4212-tab3.dtsi
new file mode 100644
index 000000000000..b8ad5497506c
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4212-tab3.dtsi
@@ -0,0 +1,1175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos4212 based Galaxy Tab 3 board common source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ */
+
+/dts-v1/;
+#include "exynos4212.dtsi"
+#include "exynos4412-ppmu-common.dtsi"
+#include "exynos-mfc-reserved-memory.dtsi"
+#include <dt-bindings/clock/samsung,s2mps11.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "exynos-pinctrl.h"
+
+/ {
+	compatible = "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
+
+	memory@40000000 {
+		device_type = "memory";
+
+		/* Technically 2GB, but last 1GB is flaky, so we ignore it for now */
+		reg = <0x40000000 0x3FC00000>;
+	};
+
+	chosen {
+		stdout-path = &serial_2;
+
+		/* Default S-BOOT bootloader loads initramfs here */
+		linux,initrd-start = <0x42000000>;
+		linux,initrd-end = <0x42800000>;
+	};
+
+	firmware@204f000 {
+		compatible = "samsung,secure-firmware";
+		reg = <0x0204F000 0x1000>;
+	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys>;
+
+		key-power {
+			gpios = <&gpx2 7 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			label = "power";
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+
+		key-up {
+			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			label = "volume down";
+			debounce-interval = <10>;
+		};
+
+		key-down {
+			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			label = "volume up";
+			debounce-interval = <10>;
+		};
+
+		key-home {
+			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			label = "home";
+			debounce-interval = <10>;
+		};
+
+		switch-hall-sensor {
+			gpios = <&gpx2 4 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+			label = "hall effect sensor";
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
+	vbatt_reg: voltage-regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VBATT";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	backlight_reset_supply: voltage-regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "BACKLIGHT_ENVDDIO";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_reset>;
+		gpio = <&gpm0 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	lcd_enable_supply: voltage-regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD_VDD_2.2V";
+		regulator-min-microvolt = <2200000>;
+		regulator-max-microvolt = <2200000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_en>;
+		gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>; /* LCD_EN */
+		enable-active-high;
+	};
+
+	i2c_max77693: i2c-gpio-1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpm2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpm2 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		pmic@66 {
+			compatible = "maxim,max77693";
+			interrupt-parent = <&gpx1>;
+			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_irq>;
+			reg = <0x66>;
+
+			regulators {
+				esafeout1_reg: ESAFEOUT1 {
+					regulator-name = "ESAFEOUT1";
+					regulator-boot-on;
+				};
+
+				esafeout2_reg: ESAFEOUT2 {
+					regulator-name = "ESAFEOUT2";
+				};
+
+				charger_reg: CHARGER {
+					regulator-name = "CHARGER";
+					regulator-min-microamp = <60000>;
+					regulator-max-microamp = <2580000>;
+					regulator-boot-on;
+				};
+			};
+
+			charger {
+				compatible = "maxim,max77693-charger";
+
+				maxim,constant-microvolt = <4350000>;
+				maxim,min-system-microvolt = <3600000>;
+				maxim,thermal-regulation-celsius = <100>;
+				maxim,battery-overcurrent-microamp = <3500000>;
+				maxim,charge-input-threshold-microvolt = <4300000>;
+			};
+		};
+	};
+
+	i2c_max77693_fuel: i2c-gpio-2 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpy0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpy0 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		fuel-gauge@36 {
+			compatible = "maxim,max17050";
+			interrupt-parent = <&gpx2>;
+			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_fuel_irq>;
+			reg = <0x36>;
+
+			maxim,over-heat-temp = <500>;
+			maxim,over-volt = <4500>;
+		};
+	};
+
+	i2c_yas532_magnetometer: i2c-gpio-3 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpy2 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpy2 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		/* Magnetometer: Yamaha YAS532 */
+		magnetometer@2e {
+			compatible = "yamaha,yas532";
+			reg = <0x2e>;
+			iovdd-supply = <&ldo3_reg>; /* VCC_1.8V_AP */
+			mount-matrix = "-1", "0", "0",
+					  "0", "1", "0",
+					  "0", "0", "-1";
+		};
+	};
+
+	i2c_lightsensor: i2c-gpio-4 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpl0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpl0 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		/* WiFi model uses CM3323, 3G/LTE use CM36653 */
+	};
+
+	i2c_bl: i2c-gpio-24 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpm4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpm4 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		backlight: backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+			status = "okay";
+
+			bl-name = "lcd-bl";
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x78>; /* 120 */
+
+			power-supply = <&vbatt_reg>;
+			enable-supply = <&backlight_reset_supply>;
+
+			pwms = <&pwm 1 78770 0>;
+			pwm-names = "lp8556";
+			pwm-period = <78770>;
+
+			rom_a3h {
+				rom-addr = /bits/ 8 <0xa3>;
+				rom-val = /bits/ 8 <0x5e>;
+			};
+
+			rom_a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x34>;
+			};
+
+			rom_a7h {
+				rom-addr = /bits/ 8 <0xa7>;
+				rom-val = /bits/ 8 <0xfa>;
+			};
+		};
+	};
+
+	wlan_pwrseq: sdhci3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpm3 5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
+&bus_acp {
+	devfreq = <&bus_dmc>;
+	status = "okay";
+};
+
+&bus_c2c {
+	devfreq = <&bus_dmc>;
+	status = "okay";
+};
+
+&bus_leftbus {
+	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	vdd-supply = <&buck3_reg>;
+	status = "okay";
+};
+
+&bus_rightbus {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_display {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_fsys {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_peri {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_mfc {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
+&dsi_0 {
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+	samsung,burst-clock-frequency = <500000000>;
+	samsung,esc-clock-frequency = <20000000>;
+	samsung,pll-clock-frequency = <24000000>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "samsung,s6d7aa0-lsl080al02";
+		reg = <0>;
+		enable-supply = <&lcd_enable_supply>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_nrst>;
+		reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+	};
+};
+
+&exynos_usbphy {
+	vbus-supply = <&esafeout1_reg>;
+	status = "okay";
+};
+
+&fimd {
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&buck4_reg>;
+	status = "okay";
+};
+
+&hsotg {
+	vusb_d-supply = <&ldo15_reg>;
+	vusb_a-supply = <&ldo12_reg>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+/* Accelerometer: K2DH/K3DH */
+&i2c_1 {
+	pinctrl-0 = <&i2c1_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	lis3dh: accelerometer@19 {
+		/* K2DH seems to be the same as lis2dh12 in terms of registers */
+		compatible = "st,lis2dh12-accel";
+		reg = <0x19>;
+
+		interrupt-parent = <&gpx0>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+		vdd-supply = <&ldo17_reg>; /* VCC_2.8V_AP */
+		vddio-supply = <&ldo3_reg>; /* VCC_1.8V_AP */
+
+		mount-matrix = "-1", "0", "0",
+				  "0", "1", "0",
+				  "0", "0", "-1";
+	};
+};
+
+/* Touchscreen: MMS252 */
+&i2c_3 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <400000>;
+	pinctrl-0 = <&i2c3_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	touchscreen@48 {
+		/* Using mms114 compatible for now */
+		compatible = "melfas,mms114";
+		reg = <0x48>;
+		interrupt-parent = <&gpb>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <1280>;
+		avdd-supply = <&ldo21_reg>;
+		vdd-supply = <&ldo25_reg>;
+	};
+};
+
+/* PMIC: s5m8767 */
+&i2c_7 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <100000>;
+	pinctrl-0 = <&i2c7_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	s5m8767: pmic@66 {
+		compatible = "samsung,s5m8767-pmic";
+		reg = <0x66>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&s5m8767_irq &s5m8767_dvs &s5m8767_ds>;
+		wakeup-source;
+
+		s5m8767,pmic-buck2-ramp-enable;
+		s5m8767,pmic-buck3-ramp-enable;
+		s5m8767,pmic-buck4-ramp-enable;
+
+		s5m8767,pmic-buck-ramp-delay = <25>;
+		s5m8767,pmic-buck-default-dvs-idx = <1>;
+
+		s5m8767,pmic-buck-dvs-gpios = <&gpm3 0 GPIO_ACTIVE_HIGH>,
+						 <&gpm3 1 GPIO_ACTIVE_HIGH>,
+						 <&gpm3 2 GPIO_ACTIVE_HIGH>;
+
+		s5m8767,pmic-buck-ds-gpios = <&gpf3 1 GPIO_ACTIVE_HIGH>,
+						 <&gpf3 2 GPIO_ACTIVE_HIGH>,
+						 <&gpf3 3 GPIO_ACTIVE_HIGH>;
+
+		s5m8767,pmic-buck2-dvs-voltage = <1100000>, <1100000>,
+						<1100000>, <1100000>,
+						<1100000>, <1100000>,
+						<1100000>, <1100000>;
+
+		s5m8767,pmic-buck3-dvs-voltage = <1100000>, <1100000>,
+						<1100000>, <1100000>,
+						<1100000>, <1100000>,
+						<1100000>, <1100000>;
+
+		s5m8767,pmic-buck4-dvs-voltage = <1100000>, <1100000>,
+						<1100000>, <1100000>,
+						<1100000>, <1100000>,
+						<1100000>, <1100000>;
+
+		regulators {
+			ldo1_reg: LDO1 {
+				regulator-name = "VALIVE_1.0V_AP";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "VM1M2_1.2V_AP";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>;
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "VCC_1.8V_AP";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>;
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-name = "VCC_3.3V_MHL";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				op_mode = <1>;
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "VMIPI_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				op_mode = <3>;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "VSIL_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				op_mode = <1>;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "VMIPI_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				op_mode = <3>;
+			};
+
+			ldo12_reg: LDO12 {
+				regulator-name = "VUOTG_3.0V";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				op_mode = <1>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo13_reg: LDO13 {
+				regulator-name = "VCC_1.8V_MHL";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				op_mode = <1>;
+			};
+
+			ldo15_reg: LDO15 {
+				regulator-name = "VHSIC_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				op_mode = <1>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo17_reg: LDO17 {
+				regulator-name = "VCC_2.8V_AP";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				op_mode = <1>;
+				regulator-always-on;
+			};
+
+			ldo19_reg: LDO19 {
+				regulator-name = "VLED_IC_1.9V";
+				regulator-min-microvolt = <1900000>;
+				regulator-max-microvolt = <1900000>;
+				op_mode = <1>;
+				regulator-always-on;
+			};
+
+			ldo20_reg: LDO20 {
+				regulator-name = "VTOUCH_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				op_mode = <1>;
+			};
+
+			ldo21_reg: LDO21 {
+				regulator-name = "TSP_VDD_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				op_mode = <1>;
+			};
+
+			ldo22_reg: LDO22 {
+				regulator-name = "5M_AF_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				op_mode = <1>;
+			};
+
+			ldo23_reg: LDO23 {
+				regulator-name = "VTF_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				op_mode = <3>;
+			};
+
+			ldo24_reg: LDO24 {
+				regulator-name = "LEDA_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				op_mode = <1>;
+			};
+
+			ldo25_reg: LDO25 {
+				regulator-name = "TSP_VDD_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				op_mode = <1>;
+			};
+
+			ldo26_reg: LDO26 {
+				regulator-name = "CAM_IO_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				op_mode = <1>;
+			};
+
+			ldo27_reg: LDO27 {
+				regulator-name = "VTCAM_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				op_mode = <1>;
+			};
+
+			buck1_reg: BUCK1 {
+				regulator-name = "VDD_MIF";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <3>;
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "VDD_ARM";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <3>;
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "VDD_INT";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <3>;
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "VDD_G3D";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				op_mode = <3>;
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "VMEM_1.2V_AP";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt	= <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>;
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "CAM_ISP_CORE_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				op_mode = <1>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+
+		s5m8767_osc: clocks {
+			compatible = "samsung,s5m8767-clk";
+			#clock-cells = <1>;
+			clock-output-names = "en32khz_ap",
+						 "en32khz_cp",
+						 "en32khz_bt";
+		};
+	};
+};
+
+&mshc_0 {
+	broken-cd;
+	non-removable;
+	card-detect-delay = <200>;
+	vmmc-supply = <&ldo22_reg>;
+	clock-frequency = <400000000>;
+	samsung,dw-mshc-ciu-div = <0>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
+	status = "okay";
+	bus-width = <8>;
+	cap-mmc-highspeed;
+};
+
+&pinctrl_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep0>;
+
+	s5m8767_ds: s5m8767-ds {
+		samsung,pins = "gpf3-1", "gpf3-2", "gpf3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	lcd_en: lcd-en {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	lcd_nrst: lcd-nrst {
+		samsung,pins = "gpf0-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	sleep0: sleep-state {
+		PIN_SLP(gpa0-0, INPUT, NONE);
+		PIN_SLP(gpa0-1, OUT0, NONE);
+		PIN_SLP(gpa0-2, INPUT, NONE);
+		PIN_SLP(gpa0-3, INPUT, UP);
+		PIN_SLP(gpa0-4, INPUT, DOWN); /* UP on LTE model */
+		PIN_SLP(gpa0-5, INPUT, DOWN); /* UP on LTE model */
+		PIN_SLP(gpa0-6, INPUT, DOWN);
+		PIN_SLP(gpa0-7, INPUT, DOWN);
+
+		PIN_SLP(gpa1-0, INPUT, DOWN);
+		PIN_SLP(gpa1-1, INPUT, DOWN);
+		PIN_SLP(gpa1-2, INPUT, DOWN);
+		PIN_SLP(gpa1-3, INPUT, DOWN);
+		PIN_SLP(gpa1-4, INPUT, DOWN);
+		PIN_SLP(gpa1-5, INPUT, DOWN);
+
+		PIN_SLP(gpb-0, INPUT, NONE);
+		PIN_SLP(gpb-1, INPUT, NONE);
+		PIN_SLP(gpb-2, INPUT, NONE);
+		PIN_SLP(gpb-3, INPUT, NONE);
+		PIN_SLP(gpb-4, INPUT, DOWN);
+		PIN_SLP(gpb-5, INPUT, DOWN); /* UP on all models with modem */
+		PIN_SLP(gpb-6, INPUT, DOWN);
+		PIN_SLP(gpb-7, INPUT, DOWN);
+
+		PIN_SLP(gpc0-0, INPUT, DOWN); /* PREV, NONE on LTE model */
+		PIN_SLP(gpc0-1, INPUT, DOWN);
+		PIN_SLP(gpc0-2, INPUT, DOWN);
+		PIN_SLP(gpc0-3, INPUT, DOWN);
+		PIN_SLP(gpc0-4, INPUT, DOWN);
+
+		PIN_SLP(gpc1-0, INPUT, DOWN);
+		PIN_SLP(gpc1-1, INPUT, DOWN);
+		PIN_SLP(gpc1-2, INPUT, DOWN);
+		PIN_SLP(gpc1-3, INPUT, DOWN); /* NONE on LTE model */
+		PIN_SLP(gpc1-4, INPUT, DOWN);
+
+		PIN_SLP(gpd0-0, INPUT, DOWN);
+		PIN_SLP(gpd0-1, OUT0, NONE);
+		PIN_SLP(gpd0-2, INPUT, NONE);
+		PIN_SLP(gpd0-3, INPUT, NONE);
+
+		PIN_SLP(gpd1-0, INPUT, DOWN);
+		PIN_SLP(gpd1-1, INPUT, DOWN);
+		PIN_SLP(gpd1-2, INPUT, NONE);
+		PIN_SLP(gpd1-3, INPUT, NONE);
+
+		PIN_SLP(gpf0-0, INPUT, DOWN);
+		PIN_SLP(gpf0-1, INPUT, DOWN);
+		PIN_SLP(gpf0-2, INPUT, DOWN);
+		PIN_SLP(gpf0-3, INPUT, DOWN);
+		PIN_SLP(gpf0-4, OUT0, NONE);
+		PIN_SLP(gpf0-5, OUT0, NONE);
+		PIN_SLP(gpf0-6, INPUT, DOWN);
+		PIN_SLP(gpf0-7, INPUT, DOWN);
+
+		PIN_SLP(gpf1-0, INPUT, DOWN);
+		PIN_SLP(gpf1-1, INPUT, DOWN);
+		PIN_SLP(gpf1-2, INPUT, DOWN);
+		PIN_SLP(gpf1-3, INPUT, DOWN);
+		PIN_SLP(gpf1-4, INPUT, DOWN);
+		PIN_SLP(gpf1-5, INPUT, DOWN);
+		PIN_SLP(gpf1-6, INPUT, DOWN); /* NONE on LTE model */
+		PIN_SLP(gpf1-7, INPUT, DOWN);
+
+		PIN_SLP(gpf2-0, INPUT, DOWN);
+		PIN_SLP(gpf2-1, INPUT, DOWN);
+		PIN_SLP(gpf2-2, INPUT, DOWN); /* PREV, NONE on LTE model */
+		PIN_SLP(gpf2-3, INPUT, DOWN);
+		PIN_SLP(gpf2-4, INPUT, DOWN);
+		PIN_SLP(gpf2-5, INPUT, DOWN);
+		PIN_SLP(gpf2-6, INPUT, DOWN);
+		PIN_SLP(gpf2-7, INPUT, DOWN);
+
+		PIN_SLP(gpf3-0, INPUT, DOWN);
+		PIN_SLP(gpf3-1, INPUT, DOWN);
+		PIN_SLP(gpf3-2, INPUT, DOWN);
+		PIN_SLP(gpf3-3, INPUT, DOWN);
+		PIN_SLP(gpf3-4, PREV, NONE);
+		PIN_SLP(gpf3-5, OUT0, DOWN);
+
+		PIN_SLP(gpj0-0, INPUT, DOWN);
+		PIN_SLP(gpj0-1, INPUT, DOWN);
+		PIN_SLP(gpj0-2, INPUT, DOWN);
+		PIN_SLP(gpj0-3, OUT0, NONE);
+		PIN_SLP(gpj0-4, INPUT, DOWN);
+		PIN_SLP(gpj0-5, INPUT, DOWN);
+		PIN_SLP(gpj0-6, OUT0, NONE);
+		PIN_SLP(gpj0-7, OUT0, NONE);
+
+		PIN_SLP(gpj1-0, OUT0, NONE);
+		PIN_SLP(gpj1-1, INPUT, DOWN);
+		PIN_SLP(gpj1-2, PREV, NONE);
+		PIN_SLP(gpj1-3, INPUT, DOWN);
+		PIN_SLP(gpj1-4, INPUT, DOWN);
+	};
+};
+
+&pinctrl_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep1>;
+
+	max77693_irq: max77693-irq {
+		samsung,pins = "gpx1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	max77693_fuel_irq: max77693-fuel-irq {
+		samsung,pins = "gpx2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	s5m8767_dvs: s5m8767-dvs {
+		samsung,pins = "gpm3-0", "gpm3-1", "gpm3-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	s5m8767_irq: s5m8767-irq {
+		samsung,pins = "gpx0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	sdhci2_cd: sdhci2-cd-irq {
+		samsung,pins = "gpx3-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	bt_shutdown: bt-shutdown-pins {
+		samsung,pins = "gpl0-6";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	bt_host_wakeup: bt-host-wakeup-pins {
+		samsung,pins = "gpx2-6";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	bt_device_wakeup: bt-device-wakeup-pins {
+		samsung,pins = "gpx3-1";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	backlight_reset: backlight-reset {
+		samsung,pins = "gpm0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	gpio_keys: gpio-keys-pins {
+		samsung,pins = "gpx1-2", "gpx2-2", "gpx2-4", "gpx2-7", "gpx3-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	sleep1: sleep-state {
+		PIN_SLP(gpk0-0, PREV, NONE);
+		PIN_SLP(gpk0-1, PREV, NONE);
+		PIN_SLP(gpk0-2, PREV, NONE);
+		PIN_SLP(gpk0-3, PREV, NONE);
+		PIN_SLP(gpk0-4, PREV, NONE);
+		PIN_SLP(gpk0-5, PREV, NONE);
+		PIN_SLP(gpk0-6, PREV, NONE);
+
+		PIN_SLP(gpk1-0, INPUT, DOWN);
+		PIN_SLP(gpk1-1, INPUT, DOWN);
+		PIN_SLP(gpk1-2, INPUT, DOWN);
+		PIN_SLP(gpk1-3, PREV, NONE);
+		PIN_SLP(gpk1-4, PREV, NONE);
+		PIN_SLP(gpk1-5, PREV, NONE);
+		PIN_SLP(gpk1-6, PREV, NONE);
+
+		PIN_SLP(gpk2-0, INPUT, DOWN);
+		PIN_SLP(gpk2-1, INPUT, DOWN);
+		PIN_SLP(gpk2-2, INPUT, DOWN);
+		PIN_SLP(gpk2-3, INPUT, DOWN);
+		PIN_SLP(gpk2-4, INPUT, DOWN);
+		PIN_SLP(gpk2-5, INPUT, DOWN);
+		PIN_SLP(gpk2-6, INPUT, DOWN);
+
+		PIN_SLP(gpk3-0, OUT0, NONE);
+		PIN_SLP(gpk3-1, INPUT, NONE);
+		PIN_SLP(gpk3-2, INPUT, DOWN);
+		PIN_SLP(gpk3-3, INPUT, NONE);
+		PIN_SLP(gpk3-4, INPUT, NONE);
+		PIN_SLP(gpk3-5, INPUT, NONE);
+		PIN_SLP(gpk3-6, INPUT, NONE);
+
+		PIN_SLP(gpl0-0, INPUT, DOWN); /* OUT0 on 3G, PREV on LTE; NONE on both */
+		PIN_SLP(gpl0-1, INPUT, NONE);
+		PIN_SLP(gpl0-2, INPUT, NONE);
+		PIN_SLP(gpl0-3, INPUT, DOWN);
+		PIN_SLP(gpl0-4, INPUT, DOWN);
+		PIN_SLP(gpl0-6, PREV, NONE);
+
+		PIN_SLP(gpl1-0, INPUT, DOWN); /* OUT0 on 3G, PREV on LTE; NONE on both */
+		PIN_SLP(gpl1-1, OUT0, NONE);
+		PIN_SLP(gpl2-0, INPUT, DOWN);
+		PIN_SLP(gpl2-1, PREV, NONE); /* INPUT, DOWN on LTE */
+		PIN_SLP(gpl2-2, PREV, NONE); /* INPUT, DOWN on LTE */
+		PIN_SLP(gpl2-3, INPUT, DOWN);
+		PIN_SLP(gpl2-4, INPUT, DOWN); /* OUT0, NONE on models with modem */
+		PIN_SLP(gpl2-5, INPUT, DOWN); /* PREV, NONE on LTE */
+		PIN_SLP(gpl2-6, INPUT, DOWN);
+		PIN_SLP(gpl2-7, INPUT, DOWN);
+
+		PIN_SLP(gpm0-0, PREV, NONE);
+		PIN_SLP(gpm0-1, OUT0, NONE);
+		PIN_SLP(gpm0-2, INPUT, DOWN);
+		PIN_SLP(gpm0-3, INPUT, DOWN);
+		PIN_SLP(gpm0-4, INPUT, DOWN);
+		PIN_SLP(gpm0-5, INPUT, DOWN);
+		PIN_SLP(gpm0-6, INPUT, DOWN);
+		PIN_SLP(gpm0-7, INPUT, DOWN);
+
+		PIN_SLP(gpm1-0, INPUT, DOWN);
+		PIN_SLP(gpm1-1, INPUT, DOWN);
+		PIN_SLP(gpm1-2, INPUT, NONE);
+		PIN_SLP(gpm1-3, INPUT, NONE);
+		PIN_SLP(gpm1-4, INPUT, NONE);
+		PIN_SLP(gpm1-5, INPUT, NONE);
+		PIN_SLP(gpm1-6, OUT0, NONE);
+
+		PIN_SLP(gpm2-0, INPUT, NONE);
+		PIN_SLP(gpm2-1, INPUT, NONE);
+		PIN_SLP(gpm2-2, OUT0, NONE);
+		PIN_SLP(gpm2-3, INPUT, DOWN);
+		PIN_SLP(gpm2-4, INPUT, DOWN);
+
+		PIN_SLP(gpm3-0, PREV, NONE);
+		PIN_SLP(gpm3-1, PREV, NONE);
+		PIN_SLP(gpm3-2, PREV, NONE);
+		PIN_SLP(gpm3-3, INPUT, DOWN); /* OUT1, NONE for 3G */
+		PIN_SLP(gpm3-4, INPUT, DOWN);
+		PIN_SLP(gpm3-5, PREV, NONE);
+		PIN_SLP(gpm3-6, INPUT, DOWN);
+		PIN_SLP(gpm3-7, OUT0, NONE);
+
+		PIN_SLP(gpm4-0, INPUT, DOWN);
+		PIN_SLP(gpm4-1, INPUT, DOWN);
+		PIN_SLP(gpm4-2, INPUT, DOWN);
+		PIN_SLP(gpm4-3, INPUT, DOWN);
+		PIN_SLP(gpm4-4, PREV, NONE);
+		PIN_SLP(gpm4-5, INPUT, NONE);
+		PIN_SLP(gpm4-6, INPUT, DOWN);
+		PIN_SLP(gpm4-7, INPUT, DOWN);
+
+		PIN_SLP(gpy0-0, INPUT, DOWN);
+		PIN_SLP(gpy0-1, INPUT, DOWN);
+		PIN_SLP(gpy0-2, INPUT, NONE);
+		PIN_SLP(gpy0-3, INPUT, NONE);
+		PIN_SLP(gpy0-4, INPUT, DOWN);
+		PIN_SLP(gpy0-5, INPUT, DOWN);
+
+		PIN_SLP(gpy1-0, INPUT, DOWN);
+		PIN_SLP(gpy1-1, INPUT, DOWN);
+		PIN_SLP(gpy1-2, INPUT, DOWN);
+		PIN_SLP(gpy1-3, INPUT, DOWN);
+
+		PIN_SLP(gpy2-0, PREV, NONE);
+		PIN_SLP(gpy2-1, INPUT, DOWN);
+		PIN_SLP(gpy2-2, INPUT, NONE);
+		PIN_SLP(gpy2-3, INPUT, NONE);
+		PIN_SLP(gpy2-4, INPUT, NONE);
+		PIN_SLP(gpy2-5, INPUT, NONE);
+
+		PIN_SLP(gpy3-0, INPUT, DOWN);
+		PIN_SLP(gpy3-1, INPUT, DOWN);
+		PIN_SLP(gpy3-2, INPUT, DOWN);
+		PIN_SLP(gpy3-3, INPUT, DOWN);
+		PIN_SLP(gpy3-4, INPUT, DOWN);
+		PIN_SLP(gpy3-5, INPUT, DOWN);
+		PIN_SLP(gpy3-6, INPUT, DOWN);
+		PIN_SLP(gpy3-7, INPUT, DOWN);
+
+		PIN_SLP(gpy4-0, INPUT, DOWN);
+		PIN_SLP(gpy4-1, INPUT, DOWN);
+		PIN_SLP(gpy4-2, INPUT, DOWN);
+		PIN_SLP(gpy4-3, INPUT, DOWN);
+		PIN_SLP(gpy4-4, INPUT, DOWN);
+		PIN_SLP(gpy4-5, INPUT, DOWN);
+		PIN_SLP(gpy4-6, INPUT, DOWN);
+		PIN_SLP(gpy4-7, INPUT, DOWN);
+
+		PIN_SLP(gpy5-0, INPUT, DOWN);
+		PIN_SLP(gpy5-1, INPUT, DOWN);
+		PIN_SLP(gpy5-2, INPUT, DOWN);
+		PIN_SLP(gpy5-3, INPUT, DOWN);
+		PIN_SLP(gpy5-4, INPUT, DOWN);
+		PIN_SLP(gpy5-5, INPUT, DOWN);
+		PIN_SLP(gpy5-6, INPUT, DOWN);
+		PIN_SLP(gpy5-7, INPUT, DOWN);
+
+		PIN_SLP(gpy6-0, INPUT, DOWN);
+		PIN_SLP(gpy6-1, INPUT, DOWN);
+		PIN_SLP(gpy6-2, INPUT, DOWN);
+		PIN_SLP(gpy6-3, INPUT, DOWN);
+		PIN_SLP(gpy6-4, INPUT, DOWN);
+		PIN_SLP(gpy6-5, INPUT, DOWN);
+		PIN_SLP(gpy6-6, INPUT, DOWN);
+		PIN_SLP(gpy6-7, INPUT, DOWN);
+	};
+};
+
+&pinctrl_2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep2>;
+
+	sleep2: sleep-state {
+		PIN_SLP(gpz-0, INPUT, DOWN);
+		PIN_SLP(gpz-1, INPUT, DOWN);
+		PIN_SLP(gpz-2, INPUT, DOWN);
+		PIN_SLP(gpz-3, INPUT, DOWN);
+		PIN_SLP(gpz-4, INPUT, DOWN);
+		PIN_SLP(gpz-5, INPUT, DOWN);
+		PIN_SLP(gpz-6, INPUT, DOWN);
+	};
+};
+
+&pinctrl_3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep3>;
+
+	sleep3: sleep-state {
+		PIN_SLP(gpv0-0, INPUT, DOWN);
+		PIN_SLP(gpv0-1, INPUT, DOWN);
+		PIN_SLP(gpv0-2, INPUT, DOWN);
+		PIN_SLP(gpv0-3, INPUT, DOWN);
+		PIN_SLP(gpv0-4, INPUT, DOWN);
+		PIN_SLP(gpv0-5, INPUT, DOWN);
+		PIN_SLP(gpv0-6, INPUT, DOWN);
+		PIN_SLP(gpv0-7, INPUT, DOWN);
+
+		PIN_SLP(gpv1-0, INPUT, DOWN);
+		PIN_SLP(gpv1-1, INPUT, DOWN);
+		PIN_SLP(gpv1-2, INPUT, DOWN);
+		PIN_SLP(gpv1-3, INPUT, DOWN);
+		PIN_SLP(gpv1-4, INPUT, DOWN);
+		PIN_SLP(gpv1-5, INPUT, DOWN);
+		PIN_SLP(gpv1-6, INPUT, DOWN);
+		PIN_SLP(gpv1-7, INPUT, DOWN);
+
+		PIN_SLP(gpv2-0, INPUT, DOWN);
+		PIN_SLP(gpv2-1, INPUT, DOWN);
+		PIN_SLP(gpv2-2, INPUT, DOWN);
+		PIN_SLP(gpv2-3, INPUT, DOWN);
+		PIN_SLP(gpv2-4, INPUT, DOWN);
+		PIN_SLP(gpv2-5, INPUT, DOWN);
+		PIN_SLP(gpv2-6, INPUT, DOWN);
+		PIN_SLP(gpv2-7, INPUT, DOWN);
+
+		PIN_SLP(gpv3-0, INPUT, DOWN);
+		PIN_SLP(gpv3-1, INPUT, DOWN);
+		PIN_SLP(gpv3-2, INPUT, DOWN);
+		PIN_SLP(gpv3-3, INPUT, DOWN);
+		PIN_SLP(gpv3-4, INPUT, DOWN);
+		PIN_SLP(gpv3-5, INPUT, DOWN);
+		PIN_SLP(gpv3-6, INPUT, DOWN);
+		PIN_SLP(gpv3-7, INPUT, DOWN);
+
+		PIN_SLP(gpv4-0, INPUT, DOWN);
+		PIN_SLP(gpv4-1, INPUT, DOWN);
+	};
+};
+
+&pmu_system_controller {
+	assigned-clocks = <&pmu_system_controller 0>;
+	assigned-clock-parents = <&clock CLK_XUSBXTI>;
+};
+
+&pwm {
+	pinctrl-0 = <&pwm1_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <1>;
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&s5m8767_osc S2MPS11_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
+
+&sdhci_2 {
+	bus-width = <4>;
+	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
+	pinctrl-names = "default";
+	vmmc-supply = <&ldo23_reg>;
+	status = "okay";
+};
+
+&sdhci_3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	non-removable;
+	bus-width = <4>;
+
+	mmc-pwrseq = <&wlan_pwrseq>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
+	status = "okay";
+
+	/* BCM4334 Wi-Fi */
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4334-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		interrupt-parent = <&gpx2>;
+		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&serial_0 {
+	pinctrl-0 = <&uart0_data &uart0_fctl>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* BCM4334B0 Bluetooth */
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		pinctrl-0 = <&bt_shutdown &bt_device_wakeup &bt_host_wakeup>;
+		pinctrl-names = "default";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gpl0 6 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpx3 1 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpx2 6 GPIO_ACTIVE_HIGH>;
+		clocks = <&s5m8767_osc S2MPS11_CLK_BT>;
+	};
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&serial_2 {
+	status = "okay";
+};
+
+&serial_3 {
+	status = "okay";
+};
+
+&tmu {
+	vtmu-supply = <&ldo10_reg>;
+	status = "okay";
+};
-- 
2.40.0

