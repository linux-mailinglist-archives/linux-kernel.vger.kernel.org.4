Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0999A6ECA25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDXKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDXKUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:43 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C2D8;
        Mon, 24 Apr 2023 03:20:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 2A0555EE2D;
        Mon, 24 Apr 2023 12:36:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-qvWT04Pz;
        Mon, 24 Apr 2023 12:36:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328966;
        bh=3iuf6Lu4e4rU6W7xqwd01nAFp6flexA2feuwpF6CHwI=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=D0cHGQmGLD1meQvV1cZnshNgsjk0GeBqIuVmUaYpiDazZt3eoih7cevkvmh+KlcBJ
         CS6McGhLwFUyTPHA0XbVl1y9xLSdfnQHb31VMeOi8frDz9L4cubjJRx5wGfPEgXTjG
         tFccZMiiDu4FgUm4aG7GwMQ4He4sFVdwYV1UIL4I=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/43] ARM: dts: add device tree for ep93xx Soc
Date:   Mon, 24 Apr 2023 15:34:50 +0300
Message-Id: <20230424123522.18302-35-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a divice for Cirrus ep93xx SoC amd ts7250 board that has been
my testing target for ep93xx device support.

Also inluded device tree for Liebherr BK3.1 board through it's not a
complete support.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/ep93xx-bk3.dts    |  96 ++++++
 arch/arm/boot/dts/ep93xx-ts7250.dts | 113 ++++++++
 arch/arm/boot/dts/ep93xx.dtsi       | 433 ++++++++++++++++++++++++++++
 4 files changed, 643 insertions(+)
 create mode 100644 arch/arm/boot/dts/ep93xx-bk3.dts
 create mode 100644 arch/arm/boot/dts/ep93xx-ts7250.dts
 create mode 100644 arch/arm/boot/dts/ep93xx.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..e6f48deeabed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1653,3 +1653,4 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
 	aspeed-bmc-vegman-sx20.dtb
+dtb-$(CONFIG_ARCH_EP93XX) += ep93xx-ts7250.dtb
diff --git a/arch/arm/boot/dts/ep93xx-bk3.dts b/arch/arm/boot/dts/ep93xx-bk3.dts
new file mode 100644
index 000000000000..c477af54ab56
--- /dev/null
+++ b/arch/arm/boot/dts/ep93xx-bk3.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Liebherr controller BK3.1 based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	model = "Liebherr controller BK3.1";
+	compatible = "liebherr,bk3", "cirrus,ep93xx";
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc {
+		nand-parts@0 {
+			compatible = "technologic,ts7200-nand", "gen_nand";
+			reg = <0x60000000 0x8000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "System";
+				reg = <0x00000000 0x01e00000>;
+				read-only;
+			};
+
+			partition@20000 {
+				label = "Data";
+				reg = <0x01e00000 0x05f20000>;
+			};
+
+			partition@7d20000 {
+				label = "RedBoot";
+				reg = <0x07d20000 0x002e0000>;
+				read-only;
+			};
+		};
+
+		syscon: syscon@80930000 {
+			pinctrl: pinctrl {
+				compatible = "cirrus,ep9301-pinctrl";
+			};
+		};
+
+		gpio1: gpio@80840004 {
+			/* PWM */
+			gpio-ranges = <&pinctrl 6 163 1>;
+		};
+	};
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&pinctrl 6 163 1>;
+};
+
+&gpio4 {
+	gpio-ranges = <&pinctrl 0 97 2>;
+	status = "okay";
+};
+
+&gpio6 {
+	gpio-ranges = <&pinctrl 0 87 2>;
+	status = "okay";
+};
+
+&gpio7 {
+	gpio-ranges = <&pinctrl 2 199 4>;
+	status = "okay";
+};
+
+&i2c {
+	status = "okay";
+};
+
+&spi0: spi@808a0000 {
+	cs-gpios = <&gpio5 3 0>;
+	use_dma;
+	status = "okay";
+};
+
+&eth0 {
+	copy_addr;
+	phy_id = < 1 >;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/ep93xx-ts7250.dts b/arch/arm/boot/dts/ep93xx-ts7250.dts
new file mode 100644
index 000000000000..6562780333a3
--- /dev/null
+++ b/arch/arm/boot/dts/ep93xx-ts7250.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Technologic Systems ts7250 board based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	compatible = "technologic,ts7250", "cirrus,ep9301";
+	model = "TS-7250 SBC";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+			  <0x000530c0 0x01fdd000>;
+	};
+
+	soc {
+		nand-parts@0 {
+			compatible = "technologic,ts7200-nand", "gen_nand";
+			reg = <0x60000000 0x8000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "TS-BOOTROM";
+				reg = <0x00000000 0x00020000>;
+				read-only;
+			};
+
+			partition@20000 {
+				label = "Linux";
+				reg = <0x00020000 0x07d00000>;
+			};
+
+			partition@7d20000 {
+				label = "RedBoot";
+				reg = <0x07d20000 0x002e0000>;
+				read-only;
+			};
+		};
+
+		syscon: syscon@80930000 {
+			pinctrl: pinctrl {
+				compatible = "cirrus,ep9301-pinctrl";
+			};
+		};
+
+		rtc1: rtc@10800000 {
+			compatible = "dallas,rtc-m48t86";
+			reg = <0x10800000 0x1>,
+			<0x11700000 0x1>;
+		};
+
+		watchdog1: watchdog@23800000 {
+			compatible = "technologic,ts7200-wdt";
+			reg = <0x23800000 0x01>,
+			      <0x23c00000 0x01>;
+			timeout-sec = <30>;
+		};
+	};
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&pinctrl 6 163 1>;
+};
+
+&gpio4 {
+	gpio-ranges = <&pinctrl 0 97 2>;
+	status = "okay";
+};
+
+&gpio6 {
+	gpio-ranges = <&pinctrl 0 87 2>;
+	status = "okay";
+};
+
+&gpio7 {
+	gpio-ranges = <&pinctrl 2 199 4>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&spi0 {
+	cs-gpios = <&gpio5 2 0>;
+	status = "okay";
+
+	tmp122_spi: tmp122@0 {
+		compatible = "ti,tmp122";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+	};
+};
+
+&eth0 {
+	copy_addr;
+	phy_id = < 1 >;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/ep93xx.dtsi b/arch/arm/boot/dts/ep93xx.dtsi
new file mode 100644
index 000000000000..67ecfde539af
--- /dev/null
+++ b/arch/arm/boot/dts/ep93xx.dtsi
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Cirrus Logic systems EP93XX SoC
+ */
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+/ {
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
+
+		syscon: syscon@80930000 {
+			compatible = "cirrus,ep9301-syscon",
+						"syscon", "simple-mfd";
+			reg = <0x80930000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			ep9301-reboot {
+				compatible = "cirrus,ep9301-reboot";
+			};
+
+			pinctrl: pinctrl {
+				regmap = <&syscon>;
+
+				spi_default_pins: pinctrl-spi {
+					function = "spi";
+					groups = "ssp";
+				};
+
+				ac97_default_pins: pinctrl-ac97 {
+					function = "ac97";
+					groups = "ac97";
+				};
+
+				i2s_on_ssp_pins: pinctrl-i2sonssp {
+					function = "i2s";
+					groups = "i2s_on_ssp";
+				};
+
+				i2s_on_ac97_pins: pinctrl-i2sonac97 {
+					function = "i2s";
+					groups = "i2s_on_ac97";
+				};
+
+				gpio1_default_pins: pinctrl-gpio1 {
+					function = "gpio1";
+					groups = "gpio1agrp";
+				};
+
+				pwm1_default_pins: pinctrl-pwm1 {
+					function = "pwm";
+					groups = "pwm1";
+				};
+
+				gpio2_default_pins: pinctrl-gpio2 {
+					function = "gpio2";
+					groups = "gpio2agrp";
+				};
+
+				gpio3_default_pins: pinctrl-gpio3 {
+					function = "gpio3";
+					groups = "gpio3agrp";
+				};
+
+				keypad_default_pins: pinctrl-keypad {
+					function = "keypad";
+					groups = "keypadgrp";
+				};
+
+				gpio4_default_pins: pinctrl-gpio4 {
+					function = "gpio4";
+					groups = "gpio4agrp";
+				};
+
+				gpio6_default_pins: pinctrl-gpio6 {
+					function = "gpio6";
+					groups = "gpio6agrp";
+				};
+
+				gpio7_default_pins: pinctrl-gpio7 {
+					function = "gpio7";
+					groups = "gpio7agrp";
+				};
+
+				ide_default_pins: pinctrl-ide {
+					function = "pata";
+					groups = "idegrp";
+				};
+
+				lcd_on_dram0_pins: pinctrl-rasteronsdram0 {
+					function = "lcd";
+					groups = "rasteronsdram0grp";
+				};
+
+				lcd_on_dram3_pins: pinctrl-rasteronsdram3 {
+					function = "lcd";
+					groups = "rasteronsdram3grp";
+				};
+			};
+		};
+
+		vic0: interrupt-controller@800b0000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x800b0000 0x1000>;
+			#interrupt-cells = <1>;
+			valid-mask = <0x7ffffffc>;
+			valid-wakeup-mask = <0x0>;
+		};
+
+		vic1: interrupt-controller@800c0000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x800c0000 0x1000>;
+			#interrupt-cells = <1>;
+			valid-mask = <0x1fffffff>;
+			valid-wakeup-mask = <0x0>;
+		};
+
+		timer: timer@80810000 {
+			compatible = "cirrus,ep9301-timer";
+			reg = <0x80810000 0x100>;
+			interrupt-parent = <&vic1>;
+			interrupts = <19>;
+		};
+
+		dma0: dma-controller@80000000 {
+			compatible = "cirrus,ep9301-dma-m2p";
+			reg = <0x80000000 0x0040>,
+				<0x80000040 0x0040>,
+				<0x80000080 0x0040>,
+				<0x800000c0 0x0040>,
+				<0x80000240 0x0040>,
+				<0x80000200 0x0040>,
+				<0x800002c0 0x0040>,
+				<0x80000280 0x0040>,
+				<0x80000340 0x0040>,
+				<0x80000300 0x0040>;
+			clocks = <&syscon EP93XX_CLK_M2P0>,
+				<&syscon EP93XX_CLK_M2P1>,
+				<&syscon EP93XX_CLK_M2P2>,
+				<&syscon EP93XX_CLK_M2P3>,
+				<&syscon EP93XX_CLK_M2P4>,
+				<&syscon EP93XX_CLK_M2P5>,
+				<&syscon EP93XX_CLK_M2P6>,
+				<&syscon EP93XX_CLK_M2P7>,
+				<&syscon EP93XX_CLK_M2P8>,
+				<&syscon EP93XX_CLK_M2P9>;
+			clock-names = "m2p0", "m2p1",
+				"m2p2", "m2p3",
+				"m2p4", "m2p5",
+				"m2p6", "m2p7",
+				"m2p8", "m2p9";
+			dma-channels = <10>;
+			interrupt-parent = <&vic0>;
+			interrupts = <7>, <8>, <9>, <10>, <11>,
+				<12>, <13>, <14>, <15>, <16>;
+		};
+
+		dma1: dma-controller@80000100 {
+			compatible = "cirrus,ep9301-dma-m2m";
+			reg = <0x80000100 0x0040>,
+				<0x80000140 0x0040>;
+			clocks = <&syscon EP93XX_CLK_M2M0>,
+				<&syscon EP93XX_CLK_M2M1>;
+			clock-names = "m2m0", "m2m1";
+			dma-channels = <2>;
+			interrupt-parent = <&vic0>;
+			interrupts = <17>, <18>;
+		};
+
+		gpio0: gpio@80840000 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "A";
+			reg = <0x80840000 0x04>,
+			<0x80840010 0x04>,
+			<0x80840090 0x1c>;
+			reg-names = "data", "dir", "intr";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&vic1>;
+			interrupts = <27>;
+		};
+
+		gpio1: gpio@80840004 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "B";
+			reg = <0x80840004 0x04>,
+			<0x80840014 0x04>,
+			<0x808400ac 0x1c>;
+			reg-names = "data", "dir", "intr";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&vic1>;
+			interrupts = <27>;
+		};
+
+		gpio2: gpio@80840008 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "C";
+			reg = <0x80840008 0x04>,
+			<0x80840018 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio2_default_pins>;
+		};
+
+		gpio3: gpio@8084000c {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "D";
+			reg = <0x8084000c 0x04>,
+			<0x8084001c 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio3_default_pins>;
+		};
+
+		gpio4: gpio@80840020 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "E";
+			reg = <0x80840020 0x04>,
+			<0x80840024 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio4_default_pins>;
+		};
+
+		gpio5: gpio@80840030 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "F";
+			reg = <0x80840030 0x04>,
+			<0x80840034 0x04>,
+			<0x8084004c 0x1c>;
+			reg-names = "data", "dir", "intr";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts-extended = <&vic0 19>, <&vic0 20>,
+				<&vic0 21>, <&vic0 22>,
+				<&vic1 15>, <&vic1 16>,
+				<&vic1 17>, <&vic1 18>;
+		};
+
+		gpio6: gpio@80840038 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "G";
+			reg = <0x80840038 0x04>,
+			<0x8084003c 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio6_default_pins>;
+		};
+
+		gpio7: gpio@80840040 {
+			compatible = "cirrus,ep9301-gpio";
+			chip-label = "H";
+			reg = <0x80840040 0x04>,
+			<0x80840044 0x04>;
+			reg-names = "data", "dir";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio7_default_pins>;
+		};
+
+		ide: ide@800a0000 {
+			compatible = "cirrus,ep9312-pata";
+			reg = <0x800a0000 0x38>;
+			interrupt-parent = <&vic1>;
+			interrupts = <8>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&ide_default_pins>;
+		};
+
+		uart0: uart@808c0000 {
+			compatible = "arm,primecell";
+			reg = <0x808c0000 0x1000>;
+			arm,primecell-periphid = <0x00041010>;
+			clocks = <&syscon EP93XX_CLK_UART1>, <&syscon EP93XX_CLK_UART>;
+			clock-names = "apb:uart1", "apb_pclk";
+			interrupt-parent = <&vic1>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+
+		uart1: uart@808d0000 {
+			compatible = "arm,primecell";
+			reg = <0x808d0000 0x1000>;
+			arm,primecell-periphid = <0x00041010>;
+			clocks = <&syscon EP93XX_CLK_UART2>, <&syscon EP93XX_CLK_UART>;
+			clock-names = "apb:uart2", "apb_pclk";
+			interrupt-parent = <&vic1>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+
+		uart2: uart@808b0000 {
+			compatible = "arm,primecell";
+			reg = <0x808b0000 0x1000>;
+			arm,primecell-periphid = <0x00041010>;
+			clocks = <&syscon EP93XX_CLK_UART3>, <&syscon EP93XX_CLK_UART>;
+			clock-names = "apb:uart3", "apb_pclk";
+			interrupt-parent = <&vic1>;
+			interrupts = <23>;
+			status = "disabled";
+		};
+
+		eth0: eth@80010000 {
+			compatible = "cirrus,ep9301-eth";
+			reg = <0x80010000 0x10000>;
+			interrupt-parent = <&vic1>;
+			interrupts = <7>;
+		};
+
+		rtc0: rtc@80920000 {
+			compatible = "cirrus,ep9301-rtc";
+			reg = <0x80920000 0x100>;
+		};
+
+		spi0: spi@808a0000 {
+			compatible = "cirrus,ep9301-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x808a0000 0x18>;
+			interrupt-parent = <&vic1>;
+			interrupts = <21>;
+			clocks = <&syscon EP93XX_CLK_SPI>;
+			clock-names = "ep93xx-spi.0";
+			cs-gpios = <&gpio5 2 0>;
+			use_dma;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi_default_pins>;
+			status = "disabled";
+		};
+
+		watchdog0: watchdog@80940000 {
+			compatible = "cirrus,ep9301-wdt";
+			reg = <0x80940000 0x08>;
+		};
+
+		pwm0: pwm@80910000 {
+			compatible = "cirrus,ep9301-pwm";
+			reg = <0x80910000 0x10>;
+			clocks = <&syscon EP93XX_CLK_PWM>;
+			clock-names = "pwm_clk";
+			status = "disabled";
+		};
+
+		pwm1: pwm@80910020 {
+			compatible = "cirrus,ep9301-pwm";
+			reg = <0x80910020 0x10>;
+			clocks = <&syscon EP93XX_CLK_PWM>;
+			clock-names = "pwm_clk";
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1_default_pins>;
+		};
+
+		keypad: keypad@800f0000 {
+			compatible = "cirrus,ep9301-keypad";
+			reg = <0x800f0000 0x0c>;
+			interrupt-parent = <&vic0>;
+			interrupts = <29>;
+			clocks = <&syscon EP93XX_CLK_KEYPAD>;
+			clock-names = "ep93xx-keypad";
+			pinctrl-names = "default";
+			pinctrl-0 = <&keypad_default_pins>;
+			linux,keymap =
+						<KEY_UP>,
+						<KEY_DOWN>,
+						<KEY_VOLUMEDOWN>,
+						<KEY_HOME>,
+						<KEY_RIGHT>,
+						<KEY_LEFT>,
+						<KEY_ENTER>,
+						<KEY_VOLUMEUP>,
+						<KEY_F6>,
+						<KEY_F8>,
+						<KEY_F9>,
+						<KEY_F10>,
+						<KEY_F1>,
+						<KEY_F2>,
+						<KEY_F3>,
+						<KEY_POWER>;
+		};
+	};
+
+	i2c0: i2c0 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpio6 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio6 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
-- 
2.39.2

