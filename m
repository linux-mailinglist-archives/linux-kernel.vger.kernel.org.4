Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50186626A70
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiKLQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiKLQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366119C25;
        Sat, 12 Nov 2022 08:04:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4946457wmo.1;
        Sat, 12 Nov 2022 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FPqSrntXIQJ+cahpoCu9kmTaZguFXQ3wH0XIA4kS/o=;
        b=mheZ7yHlypaukxwCu2bImvYh8XQskT9PvWpzYzRRjAixOUXWLXHfp8lDZXLW6GXha3
         iU7XJ6zltMdpL3n+BzR4M9640o5YdhX1nVlqpR2muA7W4EC5Mip9Qsh/wbCywtDEbDeI
         zqS2fBFZ8Dvob5fh7mtUOHnU23BvEOcbPx0a78CG5A0YE+ZbzVEEQh9WRwqC/XxHtzSc
         Qwy30QMtqgfESqMg9+BaWSIgMnRsccsPBguSHO7QGIa+myIzYwdTymefb7uYRZMRhOB5
         GG/L0jBMQ6Jp3Hf2jrMprRtoMADORKafov/DvedutXyXXeXR9BmTdJGKu/avPxmOnrN0
         5tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FPqSrntXIQJ+cahpoCu9kmTaZguFXQ3wH0XIA4kS/o=;
        b=fVXF+mZGk0g0yKJAoUNMJivzSDb8ULudjBZ/aprzz/SVIGW7Bmr53Xg2L3edtmJrru
         zrv90voqBGTx0Tf8M0MZUowqnDeW1RqN8P1uYe5f51prf/ylsoS33UDxtfhjfBsgSfnP
         MrBS3JynmN2uQ758jWmOJRXq1cSqFpvg6wteZvr2b1/lerp6maKM6OvtWfF2o/U9svKj
         q28jFmwKydhK2gMx4Q+ifKRnCZvIRw0qMZQvlkefhijs8ZBO2wgEswL17bT8WD36w7HJ
         Jj2hYk/OKXyxImmphNalHHPikmLViW/h2hcqGF+JuKcg2X2/BHqPL28JVPHBlYTFcMcq
         aSig==
X-Gm-Message-State: ANoB5pnsvk3DvmpZXi05bUpm0suOt4n+2u1UNwOnREfdHeTL4W/y0mjE
        muUSM1L3dy/igqrvHa3QqaE=
X-Google-Smtp-Source: AA0mqf57g76RoRF5m02yDFXD3u+BYjAgTRAZxyQWAQQRdUIH0rePDegYsPRl4GnduGxh+7dPTYH+mg==
X-Received: by 2002:a05:600c:54c1:b0:3c6:e471:7400 with SMTP id iw1-20020a05600c54c100b003c6e4717400mr4201425wmb.98.1668269076198;
        Sat, 12 Nov 2022 08:04:36 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:35 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Powers-Holmes <aholmes@omnom.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: rockchip: Add SOQuartz blade board
Date:   Sat, 12 Nov 2022 17:04:03 +0100
Message-Id: <20221112160404.70868-7-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
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

From: Andrew Powers-Holmes <aholmes@omnom.net>

This adds a device tree for the PINE64 SOQuartz blade baseboard,
a 1U rack mountable baseboard for the CM4 form factor with PoE
support designed for the SOQuartz CM4 System-on-Module.

The board takes power from either PoE or a 5V DC input, and allows
for mounting an M.2 SSD.

The board also features one USB 2.0 host port, one HDMI output,
a 3.5mm jack for UART, and the aforementioned gigabit networking
port.

Signed-off-by: Andrew Powers-Holmes <aholmes@omnom.net>
[rebase, squash, reword, misc fixes]
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3566-soquartz-blade.dts    | 194 ++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 50942086490d..2157f086c59e 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -71,6 +71,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-blade.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
new file mode 100644
index 000000000000..4e49bebf548b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+#include "rk3566-soquartz.dtsi"
+
+/ {
+	model = "PINE64 RK3566 SOQuartz on Blade carrier board";
+	compatible = "pine64,soquartz-blade", "pine64,soquartz", "rockchip,rk3566";
+
+	/* labeled VCC3V0_SD in schematic to not conflict with PMIC regulator */
+	vcc3v0_sd: vcc3v0-sd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v0_sd";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	/* labeled VCC_SSD in schematic */
+	vcc3v3_pcie_p: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie_p";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vbus>;
+	};
+
+	vcc5v_dcin: vcc5v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&combphy2 {
+	phy-supply = <&vcc3v3_sys>;
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+};
+
+/*
+ * i2c1 is exposed on CM1 / Module1A
+ * pin 80 - SCL0 - i2c1_scl_m0, pullup to vcc3v3_pmu
+ * pin 82 - SDA0 - i2c1_sda_m0, pullup to vcc3v3_pmu
+ */
+&i2c1 {
+	status = "okay";
+
+};
+
+/*
+ * i2c2 is exposed on CM1 / Module1A - to PI40
+ * pin 56 - GPIO3 - i2c2_scl_m1, pullup to vcc_3v3, shared with i2s1_8ch
+ * pin 58 - GPIO2 - i2c2_sda_m1, pullup to vcc_3v3
+ */
+&i2c2 {
+	status = "disabled";
+};
+
+/*
+ * i2c3 is exposed on CM1 / Module1A - to PI40
+ * pin 35 - ID_SC(GPIO28) - i2c3_scl_m0, pullup to vcc_3v3
+ * pin 36 - ID_SD(GPIO27) - i2c3_sda_m0, pullup to vcc_3v3
+ */
+&i2c3 {
+	status = "disabled";
+};
+
+/*
+ * i2c4 is exposed on CM2 / Module1B - to PI40
+ * pin 45 - GPIO24 - i2c4_scl_m1
+ * pin 47 - GPIO23 - i2c4_sda_m1
+ */
+&i2c4 {
+	status = "disabled";
+};
+
+/*
+ * i2s1_8ch is exposed on CM1 / Module1A - to PI40
+ * pin 24 - GPIO26 - i2s1_sdi1_m1
+ * pin 25 - GPIO21 - i2s1_sdo0_m1
+ * pin 26 - GPIO19 - i2s1_lrck_tx_m1
+ * pin 27 - GPIO20 - i2s1_sdi0_m1
+ * pin 29 - GPIO16 - i2s1_sdi3_m1
+ * pin 30 - GPIO6  - i2s1_sdi2_m1
+ * pin 40 - GPIO9  - i2s1_sdo1_m1, shared with spi3
+ * pin 41 - GPIO25 - i2s1_sdo2_m1
+ * pin 49 - GPIO18 - i2s1_sclk_tx_m1
+ * pin 50 - GPIO17 - i2s1_mclk_m1
+ * pin 56 - GPIO3  - i2s1_sdo3_m1, shared with i2c2
+ */
+&i2s1_8ch {
+	status = "disabled";
+};
+
+&led_diy {
+	color = <LED_COLOR_ID_RED>;
+	function = LED_FUNCTION_DISK_ACTIVITY;
+	linux,default-trigger = "disk-activity";
+	status = "okay";
+};
+
+&led_work {
+	color = <LED_COLOR_ID_GREEN>;
+	function = LED_FUNCTION_STATUS;
+	linux,default-trigger = "heartbeat";
+	status = "okay";
+};
+
+&pcie2x1 {
+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
+	status = "okay";
+};
+
+&rgmii_phy1 {
+	status = "okay";
+};
+
+/*
+ * saradc is exposed on CM1 / Module1A - to J2
+ * pin 94 - AIN1 - saradc_vin3
+ * pin 96 - AIN0 - saradc_vin2
+ */
+&saradc {
+	status = "disabled";
+};
+
+&sdmmc0 {
+	vmmc-supply = <&vcc3v0_sd>;
+	status = "okay";
+};
+
+/*
+ * spi3 is exposed on CM1 / Module1A - to PI40
+ * pin 37 - GPIO7  - spi3_cs1_m0
+ * pin 38 - GPIO11 - spi3_clk_m0
+ * pin 39 - GPIO8  - spi3_cs0_m0
+ * pin 40 - GPIO9  - spi3_miso_m0, shared with i2s1_8ch
+ * pin 44 - GPIO10 - spi3_mosi_m0
+ */
+&spi3 {
+	status = "disabled";
+};
+
+/*
+ * uart2 is exposed on CM1 / Module1A - to PI40
+ * pin 51 - GPIO15 - uart2_rx_m0
+ * pin 55 - GPIO14 - uart2_tx_m0
+ */
+&uart2 {
+	status = "okay";
+};
+
+/*
+ * uart7 is exposed on CM1 / Module1A - to PI40
+ * pin 46 - GPIO22 - uart7_tx_m2
+ * pin 47 - GPIO23 - uart7_rx_m2
+ */
+&uart7 {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vbus>;
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	status = "okay";
+};
+
+&vbus {
+	vin-supply = <&vcc5v_dcin>;
+};
-- 
2.38.1

