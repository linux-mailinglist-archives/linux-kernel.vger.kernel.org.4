Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A326A0AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjBWNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjBWNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:35:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEB0497FB;
        Thu, 23 Feb 2023 05:35:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso12666964pjb.3;
        Thu, 23 Feb 2023 05:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3ATVOfxCZA2ZkKdKSzd8AQB6yxO93GcARBKQZVggQA=;
        b=QdrgXbL1UTP9Gd7GXkTcXLPqYdp8s27T0EUDoLTDaUbnFFbJS+XxVXskYrF0bljG+Q
         bj2lEH6N1QC9HDNIoFnhqDKbjClOXGnEBjgZfs06TYm3c4u6FuZFj36JmLFLNrsBrPQ+
         Nn7OLtRD+LMsPl6QAGSGHB7OU+pMV+JMcoGZY5ZwgzbHxew0xeA2qfZE+9LLWzjDYNob
         7lq0wU0XnWhFF8BAh46jjK1PuJf6bTIDNhqC3z438iCHaf66FcRa4y54pOe7oZmEpOwC
         adFYBK3aknTvDGSxHuQW/7pVBejcIoaPH0OIr9kYnq2wOpAG20jS9U/8+KWcDrqqkWsk
         +9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3ATVOfxCZA2ZkKdKSzd8AQB6yxO93GcARBKQZVggQA=;
        b=mm7tpm2k9TGiemt4zcW2S9+fRIznZYA5g1CaEGUgIxr56wG9itd1XoocAKXVeje5xp
         vJsFZQRlzNRQWoANLQScVDVmgQVVzdh91naY0dA3uKjddLrLHXLi+XQEmwqvjFSK+txv
         KfHt54w7ELMN3fxhbwKG3PtBTk3ggno5BJv5V5QvUvqUKwrVvEdOqqV5oxt76/uorAkU
         qrG0iE+h+Ly83X62f6RHK1xWcY537ZOorhakuT3qzKhx8QAEJO0zJWLvMisXNwQ2USLT
         FLkWi3yGhOLP3yv7NOUptR6hQcQTJ98M57j5Q6ZGclCg8a7xQ9VQVnCPjuVy5lS+1GGG
         rxkw==
X-Gm-Message-State: AO0yUKUrLxUOjMxhfrNwSdSn90cBEj8GCpcM/KBIX0eMn7xWqLJhgODr
        XIubNl/jTt1hG1G7MDkaxqwvsr+aNrW56w==
X-Google-Smtp-Source: AK7set8E1aYl6549lZKqTYnOUlU9MFkiNr106y0uI/UZSfPfiK9FJjQPBguRrhk8X0hfTp47tbPwUA==
X-Received: by 2002:a17:902:f546:b0:19a:8304:21eb with SMTP id h6-20020a170902f54600b0019a830421ebmr11036797plf.6.1677159304962;
        Thu, 23 Feb 2023 05:35:04 -0800 (PST)
Received: from localhost.localdomain (M014008005000.v4.enabler.ne.jp. [14.8.5.0])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b0019a96a6543esm6030254plo.184.2023.02.23.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:35:04 -0800 (PST)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2 appliance
Date:   Thu, 23 Feb 2023 22:25:02 +0900
Message-Id: <20230223132502.2045-2-musashino.open@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20230223132502.2045-1-musashino.open@gmail.com>
References: <20230223132502.2045-1-musashino.open@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for Internet Initiative Japan Inc. (IIJ) SA-W2 appliance.

Specification:

- SoC         : Marvell Armada 380 88F6810
- RAM         : DDR3 256 MiB
- Flash       : SPI-NOR 32 MiB
- WLAN        : 2x Mini PCI-E slots
  - 2.4 GHz   : Atheros AR9287
  - 5 GHz     : Qualcomm Atheros QCA9880
- Ethernet    : 5x 10/100/1000 Mbps
  - Switch    : Marvell 88E6172
- LEDs        : 12x
- Buttons     : 1x
- Serial      : "CONSOLE" port (RJ-45, RS-232C level)
  - port      : ttyS0
  - settings  : 115200 8n1
  - assignment: 1:NC , 2:NC , 3:TXD, 4:GND,
                5:GND, 6:RXD, 7:NC , 8:NC
- USB         : 2x USB 2.0 Type-A
  - Hub       : SMCC USB2514B
- Power       : DC Input or PoE Input
  - DC        : 12 VDC, 3 A
  - PoE       : 802.3f
    - module  : Silvertel Ag9712-2BR
- Bootloader  : PMON2000 based
- Stock OS    : NetBSD based

Image header for stock bootloader:

0x00 - 0x07: Identifier      , ascii, "SEIL2015"
0x08 - 0x57: Copyright       , ascii
0x58 - 0x5b: Checksum (CRC32), hex
0x5c - 0x5f: Version Format  , hex  , 0x00000001
0x60 - 0x63: Major Version   , hex
0x64 - 0x67: Minor Version   , hex
0x68 - 0x87: Release Version , ascii
0x88 - 0x8b: Xor Key?        , hex  , 0x00000000 (if not encoded)
0x8c - 0x8f: Data Length     , hex

  example:

  Identifier     : "SEIL2015"
  Copyright      : "ARM OpenWrt Linux-5.15.94"
  Checksum       : 0xd575759f (calculated from kernel data)
  Version Format : 0x00000001
  Major Version  : 0x00000009
  Minor Version  : 0x00000063
  Release Version: "r22151-318ed84c8d"
  Xor Key?       : 0x00000000
  Data Length    : 0x35312d33 (length of kernel data)

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/armada-380-iij-sa-w2.dts | 391 +++++++++++++++++++++
 2 files changed, 392 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-380-iij-sa-w2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..19119a3f4f1e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1523,6 +1523,7 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) += \
+	armada-380-iij-sa-w2.dtb \
 	armada-381-netgear-gs110emx.dtb \
 	armada-382-rd-ac3x-48g4x2xl.dtb \
 	armada-385-atl-x530.dtb\
diff --git a/arch/arm/boot/dts/armada-380-iij-sa-w2.dts b/arch/arm/boot/dts/armada-380-iij-sa-w2.dts
new file mode 100644
index 000000000000..beeecbb0f5f8
--- /dev/null
+++ b/arch/arm/boot/dts/armada-380-iij-sa-w2.dts
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree file for Internet Initiative Japan Inc. SA-W2 Appliance
+ *
+ * Copyright (c) 2023, INAGAKI Hiroshi <musashino.open@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "armada-380.dtsi"
+
+/ {
+	model = "IIJ SA-W2";
+	compatible = "iij,sa-w2", "marvell,armada380";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>; /* 256MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
+			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
+
+		pcie {
+			status = "okay";
+
+			pcie@1,0 {
+				status = "okay";
+
+				/* Atheros AR9287 */
+				wifi@0,0 {
+					compatible = "pci168c,002e";
+					reg = <0000 0 0 0 0>;
+				};
+			};
+
+			pcie@3,0 {
+				status = "okay";
+
+				/* Qualcomm Atheros QCA9880 */
+				wifi@0,0 {
+					compatible = "qcom,ath10k";
+					reg = <0000 0 0 0 0>;
+				};
+			};
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmx_keys_pins>;
+
+		button-init {
+			label = "init";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmx_leds_pins>;
+
+		led-0 {
+			gpios = <&gpio0 19 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			function-enumerator = <1>;
+		};
+
+		led-1 {
+			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WLAN;
+			function-enumerator = <1>;
+		};
+
+		led-2 {
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led-3 {
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led-4 {
+			label = "green:mobile";
+			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led-5 {
+			label = "red:mobile";
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led-6 {
+			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			function-enumerator = <0>;
+		};
+
+		led-7 {
+			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WLAN;
+			function-enumerator = <0>;
+		};
+
+		led-8 {
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_POWER;
+		};
+
+		led-9 {
+			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+		};
+
+		led-10 {
+			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_USB;
+			function-enumerator = <1>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&hub_port2>;
+		};
+
+		led-11 {
+			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_USB;
+			function-enumerator = <0>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&hub_port1>;
+		};
+	};
+
+	regulator-vbus-usb0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus-usb0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-vbus-usb1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus-usb1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&pinctrl {
+	pmx_usb_pins: usb-pins {
+		marvell,pins = "mpp2",		 /* smsc usb2514b reset */
+			       "mpp48", "mpp49", /* port over current */
+			       "mpp52", "mpp53"; /* port vbus */
+		marvell,function = "gpio";
+	};
+
+	pmx_keys_pins: keys-pins {
+		marvell,pins = "mpp18";
+		marvell,function = "gpio";
+	};
+
+	pmx_leds_pins: leds-pins {
+		marvell,pins = "mpp19", "mpp20", "mpp33", "mpp34", "mpp35",
+			       "mpp36", "mpp44", "mpp45", "mpp46", "mpp47",
+			       "mpp54", "mpp55";
+		marvell,function = "gpio";
+	};
+};
+
+&gpio0 {
+	usb-hub-reset {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmx_usb_pins>;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* SMSC USB2514B */
+	hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub_port1: port@1 {
+			reg = <1>;
+			#trigger-source-cells = <0>;
+		};
+
+		hub_port2: port@2 {
+			reg = <2>;
+			#trigger-source-cells = <0>;
+		};
+	};
+};
+
+&bm {
+	status = "okay";
+};
+
+&bm_bppi {
+	status = "okay";
+};
+
+&eth1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ge1_rgmii_pins>;
+	status = "okay";
+
+	phy-connection-type = "rgmii";
+	buffer-manager = <&bm>;
+	bm,pool-long = <2>;
+	bm,pool-short = <3>;
+
+	nvmem-cells = <&macaddr_bdinfo_6>;
+	nvmem-cell-names = "mac-address";
+	mac-address-increment = <1>;
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	status = "okay";
+
+	/* Marvell 88E6172 */
+	switch@0 {
+		compatible = "marvell,mv88e6085";
+		reg = <0x0>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "ge1_0";
+			};
+
+			port@1 {
+				reg = <1>;
+				label = "ge1_1";
+			};
+
+			port@2 {
+				reg = <2>;
+				label = "ge1_2";
+			};
+
+			port@3 {
+				reg = <3>;
+				label = "ge1_3";
+			};
+
+			port@4 {
+				reg = <4>;
+				label = "ge0";
+				nvmem-cells = <&macaddr_bdinfo_6>;
+				nvmem-cell-names = "mac-address";
+			};
+
+			/*
+			 * eth0 is connected to port5 for WAN connection
+			 * on port4 ("GE0")
+			 */
+
+			port@6 {
+				reg = <6>;
+				label = "cpu";
+				ethernet = <&eth1>;
+				phy-connection-type = "rgmii-id";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&rtc {
+	status = "disabled";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x0 0x100000>;
+				label = "bootloader";
+				read-only;
+			};
+
+			partition@100000 {
+				reg = <0x100000 0x10000>;
+				label = "bootloader-env";
+				read-only;
+			};
+
+			partition@110000 {
+				compatible = "nvmem-cells";
+				reg = <0x110000 0xf0000>;
+				label = "board-info";
+				read-only;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				macaddr_bdinfo_6: macaddr@6 {
+					reg = <0x6 0x6>;
+				};
+			};
+
+			partition@200000 {
+				reg = <0x200000 0xf00000>;
+				label = "firmware";
+			};
+
+			partition@1100000 {
+				reg = <0x1100000 0xf00000>;
+				label = "rescue";
+				read-only;
+			};
+		};
+	};
+};
-- 
2.25.1

