Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9D61F3FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiKGNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiKGNHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:07:32 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A919C1A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:07:29 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound22-4.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 07 Nov 2022 13:07:25 +0000
Received: by mail-pl1-f199.google.com with SMTP id i8-20020a170902c94800b0018712ccd6bbso8995323pla.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3fekhuJzqQjnOV7EOjdSfwujFb3JS6F18skKmkiRfg=;
        b=S88OjYHxaC+/Z9m7nJNQsgQFP+xzwK1W3pNYLBqlUn3gokLj/tMaSjHyxxAvWt7w7s
         vYm2NyLlyFqbniYmAb3sQ88UhHJiGNK37+agfK/LjQJDWPxRMW2CjA6RDtT1UVyS/f8h
         /HyeTb7ZZnxPAwptzMwJ8d+PolvDGez+vO7pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3fekhuJzqQjnOV7EOjdSfwujFb3JS6F18skKmkiRfg=;
        b=Da+hrebgxu1XYipwXga7wOCNaU4Z/cF2Ym7qO2MAS4LqvKb0/OEeDOn+BZOsx5iNf6
         VFq5vlqSHTCM0h5PICCbIYrWXjY/U4QZOclMttI52FOqTup08fzOI755Oabc18NYsnE/
         EBN+zJOtpI7luZY4bUMBhFYzPNqWSClKn6tKUkPAghHzaCeZZWgnYkEXP6nYMIRAhVzM
         wjB+jt/x6Dlmg4Vyu5jL01+QNR5MZulMXEIE79i0d7jhvBe3O6LsVih+bxwkUg3cLbFR
         vnyeHXofiI9UvFXYBsRxiBq/8bS2fUIrWge2iDS5LgJlnIxZzpwXHWGaPiX2QXSl5zXB
         xzGg==
X-Gm-Message-State: ACrzQf189TWND3yf9sYUThEHixo9RJIAR5hiQepFKD8hlpOBb1UNB0kn
        CXPWATHQHnVtj19wHypanTd8SqB6SMTMy0QhnB2inpV+Xm109fpt7FrNEQk8Wn1vFLZOsEExKeP
        6A9OH7m+im0bM+1oGMFKLr5DZUtdnUuO0kbNyuZUwN7jhdO7HNSMDKbJBKEUX
X-Received: by 2002:a17:902:ced2:b0:187:1dda:6897 with SMTP id d18-20020a170902ced200b001871dda6897mr42411216plg.83.1667824758028;
        Mon, 07 Nov 2022 04:39:18 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6zMq4EUJFyhK1yy6QTtys5rpDqjx+vwL8/IB/QQkllZcAoUE4k4PN6hf9cI6iaKIL6rRs0ng==
X-Received: by 2002:a17:902:ced2:b0:187:1dda:6897 with SMTP id d18-20020a170902ced200b001871dda6897mr42411188plg.83.1667824757680;
        Mon, 07 Nov 2022 04:39:17 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b0056bbba4302dsm4400423pfq.119.2022.11.07.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:39:17 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 3/3] arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board
Date:   Mon,  7 Nov 2022 18:08:52 +0530
Message-Id: <20221107123852.8063-4-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221107123852.8063-1-sinthu.raja@ti.com>
References: <20221107123852.8063-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1667826444-305636-5390-13617-1
X-BESS-VER: 2019.1_20221024.2147
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Outbound-Spam-Score: 0.90
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.243991 [from 
        cloudscan15-22.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.90 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_RULE7568M, BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The SK architecture comprises of baseboard and a SOM board. The
AM68 Starter Kit's baseboard contains most of the actual connectors,
power supply etc. The System on Module (SoM) is plugged on to the base
board. Therefore, add support for peripherals brought out in the base
board.

Schematics: https://www.ti.com/lit/zip/SPRR463

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V2:
*Addressed the review comments:
 - Updated the commit description.
 - Updated the regulator nodes: fixedregulator to "regulator-"
 - Updated the commit $subject to align with rest of the commits.
 - Dropped the blank lines
 - Changed the node names that are added with underscore("_") with "-"

V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-3-sinthu.raja@ti.com/
 
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 447 ++++++++++++++++++
 2 files changed, 449 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 4555a5be2257..eeeebda30e3d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -12,6 +12,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
 
+dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
+
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
new file mode 100644
index 000000000000..ad727495e99b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Base Board: https://www.ti.com/lit/zip/SPRR463
+ */
+
+/dts-v1/;
+
+#include "k3-am68-sk-som.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/mux/ti-serdes.h>
+
+/ {
+	compatible = "ti,am68-sk", "ti,j721s2";
+	model = "Texas Instruments AM68 SK";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	aliases {
+		serial2 = &main_uart8;
+		mmc1 = &main_sdhci1;
+		can0 = &mcu_mcan0;
+		can1 = &mcu_mcan1;
+		can2 = &main_mcan6;
+		can3 = &main_mcan7;
+	};
+
+	vusb_main: regulator-vusb-main5v0 {
+		/* USB MAIN INPUT 5V DC */
+		compatible = "regulator-fixed";
+		regulator-name = "vusb-main5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: regulator-vsys3v3 {
+		/* Output of LM5141 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vusb_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-sd {
+		/* Output of TPS22918 */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vsys_3v3>;
+		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: gpio-regulator-tlv71033 {
+		/* Output of TLV71033 */
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_3v3>;
+		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	vsys_io_1v8: regulator-vsys-io-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_io_1v2: regulator-vsys-io-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver3: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver4: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+};
+
+&main_pmx0 {
+	main_uart8_pins_default: main-uart8-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
+			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0e0, PIN_INPUT, 0) /* (AH25) I2C0_SCL */
+			J721S2_IOPAD(0x0e4, PIN_INPUT, 0) /* (AE24) I2C0_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
+			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
+			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
+			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
+			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
+			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
+			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0c4, PIN_INPUT, 7) /* (AB26) ECAP0_IN_APWM_OUT.GPIO0_49 */
+		>;
+	};
+
+	main_usbss0_pins_default: main-usbss0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
+		>;
+	};
+
+	main_mcan6_pins_default: main-mcan6-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x098, PIN_INPUT, 0) /* (V25) MCASP0_AXR10.MCAN6_RX */
+			J721S2_IOPAD(0x094, PIN_INPUT, 0) /* (AA25) MCASP0_AXR9.MCAN6_TX */
+		>;
+	};
+
+	main_mcan7_pins_default: main-mcan7-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
+			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
+		>;
+	};
+};
+
+&wkup_pmx0 {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
+			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
+			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
+			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
+			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
+			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
+			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
+			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
+			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
+			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
+			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
+			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
+			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+		>;
+	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
+			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
+		>;
+	};
+
+	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
+			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
+		>;
+	};
+};
+
+&main_gpio2 {
+	status = "disabled";
+};
+
+&main_gpio4 {
+	status = "disabled";
+};
+
+&main_gpio6 {
+	status = "disabled";
+};
+
+&wkup_gpio1 {
+	status = "disabled";
+};
+
+&wkup_uart0 {
+	status = "reserved";
+};
+
+&main_uart0 {
+	status = "disabled";
+};
+
+&main_uart1 {
+	status = "disabled";
+};
+
+&main_uart2 {
+	status = "disabled";
+};
+
+&main_uart3 {
+	status = "disabled";
+};
+
+&main_uart4 {
+	status = "disabled";
+};
+
+&main_uart5 {
+	status = "disabled";
+};
+
+&main_uart6 {
+	status = "disabled";
+};
+
+&main_uart7 {
+	status = "disabled";
+};
+
+&main_uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart8_pins_default>;
+	/* Shared with TFA on this platform */
+	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+};
+
+&main_uart9 {
+	status = "disabled";
+};
+
+&main_i2c0 {
+	clock-frequency = <400000>;
+
+	exp1: gpio@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CSI_VIO_SEL", "CSI_SEL_FPC_EXPn", "HDMI_PDn",
+					"HDMI_LS_OE", "DP0_3V3 _EN", "BOARDID_EEPROM_WP",
+					"CAN_STB", " ", "GPIO_uSD_PWR_EN", "eDP_ENABLE",
+					"IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_MCU_RGMII_RST#",
+					"IO_EXP_CSI2_EXP_RSTz", " ", "CSI0_B_GPIO1",
+					"CSI1_B_GPIO1";
+	};
+};
+
+&main_i2c1 {
+	status = "disabled";
+};
+
+&main_i2c2 {
+	status = "disabled";
+};
+
+&main_i2c3 {
+	status = "disabled";
+};
+
+&main_i2c4 {
+	status = "disabled";
+};
+
+&main_i2c5 {
+	status = "disabled";
+};
+
+&main_i2c6 {
+	status = "disabled";
+};
+
+&main_sdhci0 {
+	status = "disabled";
+};
+
+&main_sdhci1 {
+	/* SD card */
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-names = "default";
+	disable-wp;
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+};
+
+&mcu_cpsw {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+};
+
+&davinci_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy0>;
+};
+
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan0 {
+	status = "disabled";
+};
+
+&main_mcan1 {
+	status = "disabled";
+};
+
+&main_mcan2 {
+	status = "disabled";
+};
+
+&main_mcan3 {
+	status = "disabled";
+};
+
+&main_mcan4 {
+	status = "disabled";
+};
+
+&main_mcan5 {
+	status = "disabled";
+};
+
+&main_mcan6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan6_pins_default>;
+	phys = <&transceiver3>;
+};
+
+&main_mcan7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan7_pins_default>;
+	phys = <&transceiver4>;
+};
+
+&main_mcan8 {
+	status = "disabled";
+};
+
+&main_mcan9 {
+	status = "disabled";
+};
+
+&main_mcan10 {
+	status = "disabled";
+};
+
+&main_mcan11 {
+	status = "disabled";
+};
+
+&main_mcan12 {
+	status = "disabled";
+};
+
+&main_mcan13 {
+	status = "disabled";
+};
+
+&main_mcan14 {
+	status = "disabled";
+};
+
+&main_mcan15 {
+	status = "disabled";
+};
+
+&main_mcan16 {
+	status = "disabled";
+};
+
+&main_mcan17 {
+	status = "disabled";
+};
-- 
2.36.1

