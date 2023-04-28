Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8176F1010
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjD1Bhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbjD1Bho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:37:44 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1401989;
        Thu, 27 Apr 2023 18:37:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-763c34315c1so459979939f.3;
        Thu, 27 Apr 2023 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682645862; x=1685237862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pSJMOaIAUyKNyu4qZGc5QDZdI8qZ0s1Xz4ppnBPugc=;
        b=HU4Lz3cvKiS0ZGaWAxjJjcs8j208lwTOz6EEPL/MJHduroDr4fNHAOwjAyLQm8I1ny
         TDkiZXulBWwOHD8nADHYWks3KvpN3sI+dAJAxdW8oNeVesfGWbb8zReoUcgl/1Lf1E/z
         wo8ZhR/6+Gd0JWEK9j0l34e3VHjPILPSEyZDCEpZtqLgzNqsdtM5V3YHhshrdhsTTZMh
         +BWR2+cfU20rXpBjU807hY7bPDnsZBZPb16+YlHDkKUqXzFc6pK1c2cSVIOn1ROD3MOp
         RG4f3CinyYoF5ZArH+ZWvfSyYD+XTY3OeCQ1EaxeiH5qXPOr6z6GLcyg92vr2SrtNRQY
         5ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682645862; x=1685237862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pSJMOaIAUyKNyu4qZGc5QDZdI8qZ0s1Xz4ppnBPugc=;
        b=R6cK6JFZtLSpajGVymBG9hsCTRZfjYQdZ13vTXIoc5l4gxvOC0iQOzjcc4fDj1Wq5Y
         Ncg/vPwbs719QMjWLQT4tmRHduIQkvBF/EdxcRlz1GUuV8lcY/jSZopef6S0YOTyc6nn
         VNdHn+TQQXJ9Qrc5otreAgbH74zrMQFP7WtmUrw9fomt2qsIkKOwAIzEzmnrk3kcuwTF
         JlIdjiJ15Qrpq3eOu7TICeFaJeFNq3bey1vujhSWykfDwxA2Ea15An3XDaPnyC0nM3t3
         HEMY//6zvyFXkaInKrYuKo2fueM7ipIjhUnJgIbfEzrMOilw+F/wSMn1TTkWbyITgevz
         wXrQ==
X-Gm-Message-State: AC+VfDxazXtuRtWF+SW7t4JX1lejANDaOF6QJcvI41Nxw0LNB0/aKMpw
        iuTxXlk0JAU26UKf8Hs0Kq4=
X-Google-Smtp-Source: ACHHUZ5b5uDJhGjU2z+W8pzTv6ym4rE40SdaL+5WQkeWxKFsW+x6DTRziJvmJYn5sweB4XdY0wO9Wg==
X-Received: by 2002:a92:dd05:0:b0:316:f99d:9ea2 with SMTP id n5-20020a92dd05000000b00316f99d9ea2mr2628496ilm.17.1682645862033;
        Thu, 27 Apr 2023 18:37:42 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm4985431jau.155.2023.04.27.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:37:41 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: Add Lunzn Fastrhino R66S
Date:   Fri, 28 Apr 2023 09:37:37 +0800
Message-Id: <20230428013738.30735-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428013738.30735-1-cnsztl@gmail.com>
References: <20230428013738.30735-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lunzn Fastrhino R66S is a high-performance mini router.

Specification:
- Rockchip RK3568
- 1/2GB LPDDR4 RAM
- SD card slot
- M.2 Connector
- 2x USB 3.0 Port
- 2x 2500 Base-T (PCIe, r8125b)
- 12v DC Jack

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  27 +
 .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 507 ++++++++++++++++++
 3 files changed, 535 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 2d585bbb8f3a..15089a78555a 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -85,6 +85,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
new file mode 100644
index 000000000000..fc9e1bdab128
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "rk3568-fastrhino-r66s.dtsi"
+
+/ {
+	model = "Lunzn FastRhino R66S";
+	compatible = "lunzn,fastrhino-r66s", "rockchip,rk3568";
+
+	aliases {
+		mmc0 = &sdmmc0;
+	};
+};
+
+&sdmmc0 {
+	max-frequency = <150000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
new file mode 100644
index 000000000000..a58592b2f13b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3568.dtsi"
+
+/ {
+	aliases {
+		led-boot = &status_led;
+		led-failsafe = &status_led;
+		led-running = &status_led;
+		led-upgrade = &status_led;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reset_button_pin>;
+
+		button-reset {
+			debounce-interval = <50>;
+			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&status_led_pin>;
+
+		status_led: led-status {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			linux,default-trigger = "heartbeat";
+			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc3v3_pcie: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb_host";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-init-microvolt = <900000>;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <950000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-init-microvolt = <950000>;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+
+	};
+};
+
+&pcie30phy {
+	data-lanes = <1 2>;
+	status = "okay";
+};
+
+&pcie3x1 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&pinctrl {
+	gpio-leds {
+		status_led_pin: status-led-pin {
+			rockchip,pins = <0 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	rockchip-key {
+		reset_button_pin: reset-button-pin {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		vcc5v0_usb_otg_en: vcc5v0-usb-otg-en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	max-frequency = <150000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
-- 
2.40.1

