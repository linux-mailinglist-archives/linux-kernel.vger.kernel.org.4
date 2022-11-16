Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795862BCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiKPMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiKPMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:01:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110653ED3;
        Wed, 16 Nov 2022 03:54:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t1so11724477wmi.4;
        Wed, 16 Nov 2022 03:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/TfDkn8E1wKATyX/gU0RGSZ6sAmInYSFUBAN2pVLwE=;
        b=YD7wB7w/GkdzSuZ6qei1xiZ6SCDp0GrCM7QiCDDnECjuXQ0TndJIfsywTN7mftv5mq
         9s9O8u8jdMpaY+wPKwQVKlHjfmtuXkjjN7AwXBqRYpCkU1xSk3g1vIaQ+VGFJqH80aWI
         KUDXvwKhVj+rBBS8ByVNjk69v/vBlxSFpxKcH+Jf4qR9wcEl0orO3KVpG5/7bpezn1sA
         5JyR9CLORrmr85lxrmniEdCJJczzf8uFIAIHwfcbWRxypVUlk9vReXNu8vLHnmX6FpII
         3rp/CV3z9SwUXCPiEl55or5OqC1aAcbXETdE9qpnYjyC4BBsF7GPKNCGwcE4KIdqOjVk
         6i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/TfDkn8E1wKATyX/gU0RGSZ6sAmInYSFUBAN2pVLwE=;
        b=37+Z1isRAQA5H67Q1ONPUk9RB3t+kjV4IX3swL5r+7Vkq/12oJs9dNz5deYtpAURD0
         s1JXTl2m4RUOcL65BVsISi4WhM/DB3c7kOsph0fKFR1/JjyO4lZL9RUQOJzfZFGeeGc7
         gUxTzf7zB2TPTwHwGLSnA8G5vvrWNqDZwLjDVbWFNWhYHUYdyH+trecrJ0QKJwK8498n
         q/vFmHCz5cWj+Ist5tpSeLE9847GS0WLtuI8knduUSRKzd8XASOSIf5TrIRmDDyU2qIf
         DA3Oy3dT9g3yXHUfKS8Bxey8JncQz4BHFSk0M7ri3Oo2B1gSzsoRF1u8kKs1X8+AR+FB
         OrVQ==
X-Gm-Message-State: ANoB5pkDGgMWxexEfR5SX7edE6Ye8J6nEOBbeWHo6eWINYr2f1r4mxAn
        xmhWJXPTKRf31QxHcK0wIEM=
X-Google-Smtp-Source: AA0mqf4QWGFvPDsSzVAEknD3ZjQTMIx9AxZBaUsIpmWT0xh/vr0/hLw4QUYAgiF3kgrZztF9ZBQzSQ==
X-Received: by 2002:a05:600c:34c6:b0:3cf:6f25:a713 with SMTP id d6-20020a05600c34c600b003cf6f25a713mr1860277wmq.184.1668599663991;
        Wed, 16 Nov 2022 03:54:23 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b002417e7f0685sm14576047wrb.9.2022.11.16.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:54:23 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Powers-Holmes <aholmes@omnom.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: rockchip: rk3566: Add SOQuartz Model A baseboard
Date:   Wed, 16 Nov 2022 12:53:37 +0100
Message-Id: <20221116115337.541601-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
References: <20221116115337.541601-1-frattaroli.nicolas@gmail.com>
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

This patch adds the device tree for the "Model A" baseboard for
the SOQuartz CM4 SoM, which is not to be confused with the
Quartz64 Model A, which is the same form factor and SoC, but is
not a CM4 carrier board.

The board features a PCIe 2 x1 slot, USB 2 host ports, CSI/DSI
connectors, an eDP FFC connector, gigabit ethernet, HDMI, and a
12V DC barrel jack. Also present is a microSD card slot, 40-pin
GPIO, and a power and reset button.

Signed-off-by: Andrew Powers-Holmes <aholmes@omnom.net>
[rebase, misc fixes, reword]
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3566-soquartz-model-a.dts  | 232 ++++++++++++++++++
 2 files changed, 233 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 528a02b11552..f78c0a935bce 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-blade.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-model-a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
new file mode 100644
index 000000000000..2208dbfb7f0a
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3566-soquartz.dtsi"
+
+/ {
+	model = "PINE64 RK3566 SOQuartz on Model A carrier board";
+	compatible = "pine64,soquartz-model-a", "pine64,soquartz", "rockchip,rk3566";
+
+	/* labeled DCIN_12V in schematic */
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	/*
+	 * Labelled VCC3V0_SD in schematic to not conflict with PMIC
+	 * regulator, it's 3.3v in actuality
+	 */
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
+	vcc3v3_pcie: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc12v_pcie: vcc12v-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_pcie";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+};
+
+/* phy for pcie */
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
+	/*
+	 * the rtc interrupt is tied to PMIC_PWRON,
+	 * it will force reset the board if triggered.
+	 */
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063";
+		reg = <0x51>;
+	};
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
+	status = "okay";
+};
+
+&led_work {
+	status = "okay";
+};
+
+&pcie2x1 {
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&rgmii_phy1 {
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
+/*
+ * vmmc-supply is vcc3v3_sd on v1.0 and vcc3v0_sd on v1.1+
+ * the soquartz SoM has SDMMC_PWR (CM1 pin 75) hardwired to vcc3v3_sys,
+ * so we use vcc3v3_sd here to ensure the regulator is enabled on older boards.
+ */
+&sdmmc0 {
+	vmmc-supply = <&vcc3v3_sd>;
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
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	status = "okay";
+};
+
+&vbus {
+	vin-supply = <&vcc5v0_usb>;
+};
+
+&vcc3v3_sd {
+	regulator-always-on;
+	regulator-boot-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	status = "okay";
+};
-- 
2.38.1

