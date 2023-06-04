Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C785F72180E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjFDO6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjFDO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:58:30 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB594CA;
        Sun,  4 Jun 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685890619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2jQ731Zfcr8a7AriSnn5w2+57JydZlg6MzkdjZ40CI=;
        b=Jwl6/7myr8aKTNwezlStlFEL8GK3I+qfNOu1sSjs6aGROjoJYuhMQxDqHY0Ly7XDOHL7MU
        Cw+5mMygNzVK62UL9OifymYfro4F3nkgEpuT74S2dpVU+uZpCwlSUVzP57EsMcCH5nJfXL
        socd+iReEqn4vKXO5/dJuMk42Xv/OaU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 7/9] MIPS: DTS: CI20: Enable support for WiFi / Bluetooth
Date:   Sun,  4 Jun 2023 16:56:40 +0200
Message-Id: <20230604145642.200577-8-paul@crapouillou.net>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire the WiFi/Bluetooth chip properly in the Device Tree.

- Provide it with the correct regulators and clocks;
- Change the MMC I/O bus to 1.8V which seems to be enough;
- Change the MMC I/O bus frequency to 25 MHz as 50 MHz causes errors;
- Fix the Bluetooth powerdown GPIO being inverted and add reset GPIO;
- Convert host-wakeup-gpios to IRQ.

With these changes, the WiFi works properly with the latest firmware
provided by linux-firmware. The Bluetooth does not work very well here,
as I cannot get my wireless keyboard to pair; but it does detect it, and
it does see the key presses when I type the pairing code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 88 ++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index bdbd064c90e1..cec0caa2350c 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -97,10 +97,15 @@ ir: ir {
 		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
 	};
 
-	wlan0_power: fixedregulator-1 {
+	bt_power: fixedregulator-1 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "wlan0_power";
+		regulator-name = "bt_power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-settling-time-us = <1400>;
+
+		vin-supply = <&vcc_50>;
 
 		gpio = <&gpb 19 0>;
 		enable-active-high;
@@ -116,6 +121,40 @@ otg_power: fixedregulator-2 {
 		gpio = <&gpf 15 0>;
 		enable-active-high;
 	};
+
+	wifi_power: fixedregulator-4 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wifi_power";
+
+		/*
+		 * Technically it's 5V, the WiFi chip has its own internal
+		 * regulators; but the MMC/SD subsystem won't accept such a
+		 * value.
+		 */
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-settling-time-us = <150000>;
+
+		vin-supply = <&bt_power>;
+	};
+
+	vcc_33v: fixedregulator-5 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vcc_33v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpf 7 GPIO_ACTIVE_LOW>;
+
+		clocks = <&rtc_dev>;
+		clock-names = "ext_clock";
+	};
 };
 
 &ext {
@@ -161,24 +200,33 @@ &mmc0 {
 	pinctrl-0 = <&pins_mmc0>;
 
 	cd-gpios = <&gpf 20 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vcc_33v>;
+	vqmmc-supply = <&vcc_33v>;
 };
 
 &mmc1 {
 	status = "okay";
 
 	bus-width = <4>;
-	max-frequency = <50000000>;
+	max-frequency = <25000000>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	vmmc-supply = <&wifi_power>;
+	vqmmc-supply = <&wifi_io>;
 	non-removable;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pins_mmc1>;
 
-	brcmf: wifi@1 {
-/*		reg = <4>;*/
-		compatible = "brcm,bcm4330-fmac";
-		vcc-supply = <&wlan0_power>;
-		device-wakeup-gpios = <&gpd 9 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpf 7 GPIO_ACTIVE_LOW>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		interrupt-parent = <&gpd>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
 	};
 };
 
@@ -205,11 +253,20 @@ &uart2 {
 
 	bluetooth {
 		compatible = "brcm,bcm4330-bt";
-		reset-gpios = <&gpf 8 GPIO_ACTIVE_HIGH>;
-		vcc-supply = <&wlan0_power>;
+
+		vbat-supply = <&bt_power>;
+		vddio-supply = <&wifi_io>;
+
+		interrupt-parent = <&gpf>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "host-wakeup";
+
+		clocks = <&rtc_dev>;
+		clock-names = "lpo";
+
+		reset-gpios = <&gpf 8 GPIO_ACTIVE_LOW>;
 		device-wakeup-gpios = <&gpf 5 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpf 6 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpf 4 GPIO_ACTIVE_LOW>;
+		shutdown-gpios = <&gpf 4 GPIO_ACTIVE_HIGH>;
 	};
 };
 
@@ -270,8 +327,9 @@ vcc_25: LDO5 {
 				regulator-always-on;
 			};
 			wifi_io: LDO6 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-settling-time-us = <150000>;
 				inl-supply = <&vcc_33v>;
 			};
 			cim_io_28: LDO7 {
-- 
2.39.2

