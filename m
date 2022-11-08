Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78CF620490
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiKHAQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKHAQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:16:03 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D124959;
        Mon,  7 Nov 2022 16:16:01 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 12B2DB76;
        Mon,  7 Nov 2022 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667866561;
        bh=3VhOcEvxFccvRIos7On0Hck2TyHvd6rH+W1YQcByc3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tp7F6FChc19LJVnti4xee0My7n/ntUElyCrEZiGdUs4Q8g9aouJkNtfDWwcHsMaa3
         4QaD+QWF9dR0lHHzpWVVEXcKm+PZ2h4K8bLcZj8mtC52cw446WUvlqVdxzyODhEseQ
         K0I8tD1AYTE//ergGoK/7EjHhWmQyYNz4wxJUYXo=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, soc@kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
Date:   Mon,  7 Nov 2022 16:15:51 -0800
Message-Id: <20221108001551.18175-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108001551.18175-1-zev@bewilderbeest.net>
References: <20221108001551.18175-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 1U Open19 power shelf with six PSUs and 50 12VDC outputs via
LM25066 efuses.  It's managed by a pair of AST1250 BMCs in a redundant
active/active configuration using a PCA9541 on each I2C bus to
arbitrate access between the two.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 418 ++++++++++++++++++
 2 files changed, 419 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6aa7dc4db2fc..8961fbb2c0bc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1588,6 +1588,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
+	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
 	aspeed-bmc-facebook-cloudripper.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
new file mode 100644
index 000000000000..6600f7e9bf5e
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+#define EFUSE_OUTPUT(n)					\
+	efuse##n {					\
+		compatible = "regulator-output";	\
+		vout-supply = <&efuse##n>;		\
+	}
+
+#define __stringify(x) #x
+
+#define EFUSE(hexaddr, num)							\
+	efuse@##hexaddr {							\
+		compatible = "lm25066";						\
+		reg = <0x##hexaddr>;						\
+		shunt-resistor-micro-ohms = <675>;				\
+		regulators {							\
+			efuse##num: vout0 {					\
+				regulator-name = __stringify(efuse##num##-reg);	\
+			};							\
+		};								\
+	}
+
+/{
+	model = "Delta Power AHE-50DC";
+	compatible = "delta,ahe50dc-bmc", "aspeed,ast2400";
+
+	aliases {
+		serial4 = &uart5;
+
+		/*
+		 * pca9541-arbitrated logical i2c buses are numbered as the
+		 * corresponding physical bus plus 20
+		 */
+		i2c20 = &i2carb0;
+		i2c21 = &i2carb1;
+		i2c22 = &i2carb2;
+		i2c23 = &i2carb3;
+		i2c24 = &i2carb4;
+		i2c26 = &i2carb6;
+		i2c27 = &i2carb7;
+		i2c28 = &i2carb8;
+		i2c32 = &i2carb12;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+		bootargs = "console=ttyS2,115200n8 earlycon";
+	};
+
+	memory@40000000 {
+		reg = <0x40000000 0x10000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		panic {
+			gpios = <&gpio ASPEED_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "panic";
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>;
+	};
+
+	EFUSE_OUTPUT(01);
+	EFUSE_OUTPUT(02);
+	EFUSE_OUTPUT(03);
+	EFUSE_OUTPUT(04);
+	EFUSE_OUTPUT(05);
+	EFUSE_OUTPUT(06);
+	EFUSE_OUTPUT(07);
+	EFUSE_OUTPUT(08);
+	EFUSE_OUTPUT(09);
+	EFUSE_OUTPUT(10);
+	EFUSE_OUTPUT(11);
+	EFUSE_OUTPUT(12);
+	EFUSE_OUTPUT(13);
+	EFUSE_OUTPUT(14);
+	EFUSE_OUTPUT(15);
+	EFUSE_OUTPUT(16);
+	EFUSE_OUTPUT(17);
+	EFUSE_OUTPUT(18);
+	EFUSE_OUTPUT(19);
+	EFUSE_OUTPUT(20);
+	EFUSE_OUTPUT(21);
+	EFUSE_OUTPUT(22);
+	EFUSE_OUTPUT(23);
+	EFUSE_OUTPUT(24);
+	EFUSE_OUTPUT(25);
+	EFUSE_OUTPUT(26);
+	EFUSE_OUTPUT(27);
+	EFUSE_OUTPUT(28);
+	EFUSE_OUTPUT(29);
+	EFUSE_OUTPUT(30);
+	EFUSE_OUTPUT(31);
+	EFUSE_OUTPUT(32);
+	EFUSE_OUTPUT(33);
+	EFUSE_OUTPUT(34);
+	EFUSE_OUTPUT(35);
+	EFUSE_OUTPUT(36);
+	EFUSE_OUTPUT(37);
+	EFUSE_OUTPUT(38);
+	EFUSE_OUTPUT(39);
+	EFUSE_OUTPUT(40);
+	EFUSE_OUTPUT(41);
+	EFUSE_OUTPUT(42);
+	EFUSE_OUTPUT(43);
+	EFUSE_OUTPUT(44);
+	EFUSE_OUTPUT(45);
+	EFUSE_OUTPUT(46);
+	EFUSE_OUTPUT(47);
+	EFUSE_OUTPUT(48);
+	EFUSE_OUTPUT(49);
+	EFUSE_OUTPUT(50);
+
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "flash0";
+		spi-max-frequency = <50000000>; // 50 MHz
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@79 {
+		compatible = "nxp,pca9541";
+		reg = <0x79>;
+
+		i2carb0: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* lm25066 efuses @ 10-17, 40-47, 50-57 */
+			EFUSE(10, 03);
+			EFUSE(11, 04);
+			EFUSE(12, 01);
+			EFUSE(13, 02);
+			EFUSE(14, 13);
+			EFUSE(15, 14);
+			EFUSE(16, 15);
+			EFUSE(17, 16);
+			EFUSE(40, 12);
+			EFUSE(41, 11);
+			EFUSE(42, 10);
+			EFUSE(43, 09);
+			EFUSE(44, 08);
+			EFUSE(45, 07);
+			EFUSE(46, 05);
+			EFUSE(47, 06);
+			EFUSE(50, 17);
+			EFUSE(51, 18);
+			EFUSE(52, 20);
+			EFUSE(53, 19);
+			EFUSE(54, 22);
+			EFUSE(55, 21);
+			EFUSE(56, 24);
+			EFUSE(57, 23);
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@72 {
+		compatible = "nxp,pca9541";
+		reg = <0x72>;
+
+		i2carb1: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@73 {
+		compatible = "nxp,pca9541";
+		reg = <0x73>;
+
+		i2carb2: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@74 {
+		compatible = "nxp,pca9541";
+		reg = <0x74>;
+
+		i2carb3: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@7a {
+		compatible = "nxp,pca9541";
+		reg = <0x7a>;
+
+		i2carb4: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9534";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			/* lm25066 efuses @ 10-17, 40-47, 50-57, 59, 5a */
+			EFUSE(10, 27);
+			EFUSE(11, 28);
+			EFUSE(12, 25);
+			EFUSE(13, 26);
+			EFUSE(14, 37);
+			EFUSE(15, 38);
+			EFUSE(16, 39);
+			EFUSE(17, 40);
+			EFUSE(40, 36);
+			EFUSE(41, 35);
+			EFUSE(42, 34);
+			EFUSE(43, 33);
+			EFUSE(44, 32);
+			EFUSE(45, 31);
+			EFUSE(46, 29);
+			EFUSE(47, 30);
+			EFUSE(50, 41);
+			EFUSE(51, 42);
+			EFUSE(52, 44);
+			EFUSE(53, 43);
+			EFUSE(54, 46);
+			EFUSE(55, 45);
+			EFUSE(56, 48);
+			EFUSE(57, 47);
+			EFUSE(59, 49);
+			EFUSE(5a, 50);
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@75 {
+		compatible = "nxp,pca9541";
+		reg = <0x75>;
+
+		i2carb6: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@76 {
+		compatible = "nxp,pca9541";
+		reg = <0x76>;
+
+		i2carb7: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@7c {
+		compatible = "nxp,pca9541";
+		reg = <0x7c>;
+
+		i2carb8: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			fancontrol@30 {
+				compatible = "delta,ahe50dc-fan";
+				reg = <0x30>;
+			};
+
+			/* Baseboard FRU eeprom */
+			eeprom@50 {
+				compatible = "atmel,24c02";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	bus-frequency = <200000>;
+
+	pca9541@71 {
+		compatible = "nxp,pca9541";
+		reg = <0x71>;
+
+		i2carb12: i2c-arb {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+		/*  A */ "", "", "", "", "", "", "", "",
+		/*  B */ "", "", "", "", "", "", "", "",
+		/*  C */ "RESET_PEER_N", "HEARTBEAT_OUT", "", "", "", "", "", "",
+		/*  D */ "", "", "", "", "", "", "", "",
+		/*  E */ "DOOM_N", "", "", "", "", "LED_PWR_BLUE", "", "",
+		/*  F */ "", "", "", "", "", "", "", "",
+		/*  G */ "", "", "", "", "", "", "", "",
+		/*  H */ "", "", "", "", "", "", "", "",
+		/*  I */ "", "", "", "", "", "", "", "",
+		/*  J */ "", "", "BMC_ID", "", "", "", "", "",
+		/*  K */ "", "", "", "", "", "", "", "",
+		/*  L */ "", "", "", "", "", "", "", "",
+		/*  M */ "", "", "", "", "", "", "", "",
+		/*  N */ "", "", "", "", "", "", "", "",
+		/*  O */ "", "", "", "", "", "", "", "",
+		/*  P */ "LED_GREEN", "", "LED_RED", "", "", "", "", "",
+		/*  Q */ "", "", "", "", "", "", "", "",
+		/*  R */ "", "", "", "", "", "", "", "",
+		/*  S */ "", "", "", "", "", "", "", "",
+		/*  T */ "", "", "", "", "", "", "", "",
+		/*  U */ "", "", "", "", "", "", "", "",
+		/*  V */ "", "", "", "", "", "", "", "",
+		/*  W */ "", "", "", "", "", "", "", "",
+		/*  X */ "", "", "", "", "", "", "", "",
+		/*  Y */ "HEARTBEAT_IN", "BOARDREV0", "BOARDREV1", "",
+		/*  Z */ "", "", "", "", "", "", "", "",
+		/* AA */ "", "", "", "", "", "", "", "",
+		/* AB */ "", "", "", "";
+
+	/*
+	 * I don't rightly know what this GPIO really *is*, but setting it to
+	 * zero causes the fans to run at full speed, after which setting it
+	 * back to one causes a power output glitch, so install a hog to keep
+	 * it at one as a failsafe to ensure nothing accidentally touches it.
+	 */
+	doom-guardrail {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_LOW>;
+		output-low;
+	};
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default
+		&pinctrl_adc8_default
+		&pinctrl_adc9_default>;
+};
-- 
2.38.1

