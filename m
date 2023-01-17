Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740F2670C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAQW7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjAQW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:58:54 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FD222C3;
        Tue, 17 Jan 2023 14:38:56 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p12so3224530ilq.10;
        Tue, 17 Jan 2023 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9WR0qcUJykaKkMp4ogmMSIRbKD9iOrsnDTqQfIuBWQ=;
        b=LJv4EK0VhHngNGhmMRt2C3iuyIbWSmRtFGtonVby4sWrcMiEqsopB+OO3KQS4UdYNp
         WN5ekJJTLIs9qgfcvjxdm5nqhkUN8inEM6KMYjLlSdLTM79r6ZoGDr2lo+rPFIMZ9GjH
         +dcP88KQm5eSy1Hg7ZiFGjIFuaOnmzQyHz7D++gIG4VrA18NLemt5Tsw4Vc+ngGar28D
         Xr8VGWXegGykzW78TgNnwZZZePvXC51k86A7SiIGjJNNQM8Oj+9XU/D6Ld+hMZfTwEVU
         a78IBsgVO95vBjUr3XGz0N07+LZ/BGEujrlMPP54yjbwk8CxSwpTvZcuc9LvR+GP9IZ+
         2D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9WR0qcUJykaKkMp4ogmMSIRbKD9iOrsnDTqQfIuBWQ=;
        b=CyDvQ31iLiuqxpzQ3KLcT/SkqRkEQnT8pL83wugKx7wwSa/itEu+9UlpRvol9XKE8O
         5sy4OdT7MxjuV4KeGBu9OrV7gCt7BV9hA5Ix4YCA7hTWmHvIG/evubyN1/SKc2hJ9Cg7
         9K5PNjl2mmR6dUhlaqOVu8aMDVxRDeAJqji6w6ClYrKII5lD3Li1Qsx2N02Fy3jGd2qT
         w2veyS65QAO/PopCopLJ3agRCJGefTzcldYR44r29E9IiKaCXX6uE67KPrh65YJZMbdO
         cgcoQd/6ln1MQzUpK+FH4I2oyvFSq2mWDKD2VewksE+GsJa0Y17ZaMJsqokSFYq1GqKs
         fa/g==
X-Gm-Message-State: AFqh2krl1F97KACN+xfOEa+dG5tCNEZNJsmmVjzK6Zak04rqejTRXtA3
        rgkj9v0a1VOfSEDtBWhPGVOEdJeya64=
X-Google-Smtp-Source: AMrXdXty+hHSbEV1PH4j7F43rw3n6bI+hwiXqewlJbJ5AUCT54zBKeNg/Rhx2SXa7cuvCqrbEMMN3A==
X-Received: by 2002:a05:6e02:1d02:b0:30d:b3c3:f94c with SMTP id i2-20020a056e021d0200b0030db3c3f94cmr4857132ila.2.1673995135202;
        Tue, 17 Jan 2023 14:38:55 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0038a5370658bsm9827122jac.6.2023.01.17.14.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:38:54 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/2] arm64: dts: imx: Introduce imx8mp-beacon-kit
Date:   Tue, 17 Jan 2023 16:38:45 -0600
Message-Id: <20230117223846.465016-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117223846.465016-1-aford173@gmail.com>
References: <20230117223846.465016-1-aford173@gmail.com>
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

Beacon Embedded has an i.MX8M Plus development kit which consists
of a SOM + baseboard.  The SOM includes Bluetooth, WiFi, QSPI, eMMC,
and one Ethernet PHY. The baseboard includes audio, HDMI, USB-C Dual
Role port, USB Hub with five ports, a PCIe slot, and a second Ethernet
PHY.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V5:  Rebase, Fix whitespace, migrate away from deprecated bindings,
     remove redundant PCIe clock settings, re-order TPM, add ethernet
     PHY ID.

V4:  Change names of hd3ss3220 and ptn5100 to usb-typec,
     change gpio-i2c2 to gpio, and connector-1 to connector

V3:  Fix missing Makefile change, fix led names

V2:  Fix whitespace, remove dead nodes, and fix some node and
parameter names to address errors in 'make dt_binding_check'

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index e0f6a7970f58..d44c3c1d8c33 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -86,6 +86,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
new file mode 100644
index 000000000000..cdae45a48c2c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Logic PD, Inc dba Beacon EmbeddedWorks
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "imx8mp.dtsi"
+#include "imx8mp-beacon-som.dtsi"
+
+/ {
+	model = "Beacon EmbeddedWorks i.MX8MPlus Development kit";
+	compatible = "beacon,imx8mp-beacon-kit", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hs_ep: endpoint {
+					remote-endpoint = <&usb3_hs_ep>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+
+				ss_ep: endpoint {
+					remote-endpoint = <&hd3ss3220_in_ep>;
+				};
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		button-0 {
+			label = "btn0";
+			linux,code = <BTN_0>;
+			gpios = <&pca6416_1 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+			wakeup-source;
+		};
+
+		button-1 {
+			label = "btn1";
+			linux,code = <BTN_1>;
+			gpios = <&pca6416_1 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+			wakeup-source;
+		};
+
+		button-2 {
+			label = "btn2";
+			linux,code = <BTN_2>;
+			gpios = <&pca6416_1 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+			wakeup-source;
+		};
+
+		button-3 {
+			label = "btn3";
+			linux,code = <BTN_3>;
+			gpios = <&pca6416_1 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led3>;
+
+		led-0 {
+			label = "gen_led0";
+			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-1 {
+			label = "gen_led1";
+			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-2 {
+			label = "gen_led2";
+			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-3 {
+			label = "heartbeat";
+			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	pcie0_refclk: clock-pcie {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100>;
+		off-on-delay-us = <20000>;
+	};
+
+	reg_usb1_host_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_host_vbus";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	tpm: tpm@0 {
+		compatible = "infineon,slb9670";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpm>;
+		reset-gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-id0022.1640",
+				     "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <150000>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&gpio2 {
+	usb-mux-hog {
+		gpio-hog;
+		gpios = <20 0>;
+		output-low;
+		line-name = "USB-C Mux En";
+	};
+};
+
+&i2c2 {
+	clock-frequency = <384000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pca6416_3: gpio@20 {
+		compatible = "nxp,pcal6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&i2c3 {
+	/* Connected to USB Hub */
+	usb-typec@52 {
+		compatible = "nxp,ptn5110";
+		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "host";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+		};
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	clock-frequency = <384000>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "nxp,pcal6416";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6414>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	pca6416_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		usb-hub-hog {
+			gpio-hog;
+			gpios = <7 0>;
+			output-low;
+			line-name = "USB Hub Enable";
+		};
+	};
+
+	usb-typec@47 {
+		compatible = "ti,hd3ss3220";
+		reg = <0x47>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hd3ss3220>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hd3ss3220_in_ep: endpoint {
+					remote-endpoint = <&ss_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hd3ss3220_out_ep: endpoint {
+					remote-endpoint = <&usb3_role_switch>;
+				};
+			};
+		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			usb3_hs_ep: endpoint {
+				remote-endpoint = <&hs_ep>;
+			};
+		};
+		port@1 {
+			reg = <1>;
+			usb3_role_switch: endpoint {
+				remote-endpoint = <&hd3ss3220_out_ep>;
+			};
+		};
+	};
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_usb1_host_vbus>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x82
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI	0x82
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO	0x82
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13	0x40000
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC	0x2
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO	0x2
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0	0x90
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1	0x90
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2	0x90
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3	0x90
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC	0x90
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0	0x16
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1	0x16
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2	0x16
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3	0x16
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC	0x16
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x140
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x10
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX	0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX	0x154
+		>;
+	};
+
+	pinctrl_hd3ss3220: hd3ss3220grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x140
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL	0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL	0x400001c2
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_led3: led3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x41
+		>;
+	};
+
+	pinctrl_pcal6414: pcal6414-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27	0x10
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05	0x10 /* PCIe_nDIS */
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21 0x10	/* PCIe_nRST */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
+		>;
+	};
+
+	pinctrl_tpm: tpmgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19 /* Reset */
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x1d6 /* IRQ */
+		>;
+	};
+
+	pinctrl_typec: typec1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01	0xc4
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
+			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS		0x140
+			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x140
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
new file mode 100644
index 000000000000..e5da90804780
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 LogicPD, Inc. dba Beacon EmbeddedWorks
+ */
+
+/ {
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0xc0000000>;
+	};
+
+	reg_wl_bt: regulator-wifi-bt {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_wl_bt>;
+		regulator-name = "wl-bt-pow-dwn";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 6 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <70000>;
+		regulator-always-on;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	snps,force_thresh_dma_mode;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@3 {
+			compatible = "ethernet-phy-id0022.1640",
+				     "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			reset-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <384000>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <384000>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+		read-only;	/* Manufacturing EEPROM programmed at factory */
+	};
+
+	rtc: rtc@51 {
+		compatible = "nxp,pcf85263";
+		reg = <0x51>;
+	};
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_wl_bt>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	keep-power-in-suspend;
+	wakeup-source;
+	non-removable;
+	cap-power-off-card;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	mwifiex: wifi@1 {
+		compatible = "marvell,sd8997";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlan>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x2
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x2
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x90
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x90
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x90
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x90
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x90
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x16
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x16
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x16
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x16
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x16
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x10
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x10
+		>;
+	};
+
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x1c0
+		>;
+	};
+
+	pinctrl_reg_wl_bt: reg-wl-btgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
+		>;
+	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x140
+		>;
+	};
+};
-- 
2.34.1

