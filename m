Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2266E2228
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDNL3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDNL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:28:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D986AF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso20611149wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681471728; x=1684063728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ekzNZG9JvvAbi2o/NATEFLfUagWaOQmsowYtuHPMv4=;
        b=XgUlsOFibvrppEZkut/UH1iRxpvQd0EqAwLHSRzD5cqDH6Z54N9mggzGviFW1451kF
         etHJxSE8vXP/GQdaI09cIhNopyArwX1rhbk7ICeOex4BSumQc8oHth44ogUsOtCokZYU
         LahOkJcLV88EAHgofW7Tza9TEVexRaegyA9jLubzC9PNcauuABLW7SmqVsEnm27he1d9
         DFA3s/pW/LgCALmcm8aazi0HQfmwJapnwDV8rxj+94uHLi0n1aaSuP/Q1cs1rBAT2dp5
         t85kRw+xTdOWJOINfSZtY9A1Z8xur8oHkHd+wa+CUEZsUOlc8jmjkt9zbioIm3RFMO8s
         V2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471728; x=1684063728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ekzNZG9JvvAbi2o/NATEFLfUagWaOQmsowYtuHPMv4=;
        b=ScKyX0AX4acsYTiJOY6VjwzFETO/2sbhszC4Br3HXfq4JZE4taYoiHh5OxpeYvfW/s
         APrbgaPK4bEDGupS1c4ZVvuYXLvS8FN970n1xFLlgjom4KP6YEezgtk0ttSW3R9qA8rD
         gQQPEt6+wKDyi5M7iyHVgX555HdJ7ML/TnqBaYeEqYt7NU/BH/nfvYe2fATmejQfz3fz
         4htUmCCj/SauE7tAjvrsWc8pAVnaj9H4A7lABP/tqpjF3D42BRPLKWBXHppeez4USM7T
         L32S4iu2wwhgNmlTBzCXxspozred7CH1XUJF4969QOE5RPJRo/OPRzLjPGFfe7zVdZfs
         909A==
X-Gm-Message-State: AAQBX9eIDIlXl26xUgSD6QNOdHguzSwFt+oVw+scab6I+eKBo38q5ACC
        K4CRLNdAHORjQstFZcDANOYh1Q==
X-Google-Smtp-Source: AKy350ZsTpA3cG2Fp/jQgGHbqiqCUfFDgehK6SoTU3wF4cJNr1/PueJOG8yeXZ5iNR8u6Yt3hRO7GA==
X-Received: by 2002:a1c:e90d:0:b0:3f0:46d4:b391 with SMTP id q13-20020a1ce90d000000b003f046d4b391mr4017221wmc.6.1681471728524;
        Fri, 14 Apr 2023 04:28:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eca6:27f0:42a5:8f07:826a:465d])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003ede06f3178sm4063745wmi.31.2023.04.14.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:28:48 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com,
        aseketeli@baylibre.com
Subject: [PATCH v2 4/5] arm64: dts: ti: k3-j784s4-evm: Add support for TPS6593 PMIC
Date:   Fri, 14 Apr 2023 13:28:42 +0200
Message-Id: <20230414112843.1358067-5-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414112843.1358067-1-eblanc@baylibre.com>
References: <20230414112843.1358067-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Neanne <jneanne@baylibre.com>

This patch adds support for TPS65933A PMIC on wkup I2C0 bus.
This device provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 116 +++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 8cd4a7ecc121..339fc40f6466 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -103,6 +103,122 @@ vdd_sd_dv: regulator-TLV71033 {
 	};
 };
 
+&wkup_pmx0 {
+	status = "okay";
+	wkup_i2c0_pins_default: wkup_i2c0_pins_default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
+			J784S4_WKUP_IOPAD(0x060, PIN_INPUT, 7)
+		>;
+	};
+};
+
+&wkup_gpio0 {
+	status = "okay";
+};
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	tps659413: tps659413@48 {
+		compatible = "ti,tps6594-q1";
+		reg = <0x48>;
+		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		ti,primary-pmic;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck12-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			bucka12: buck12 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3: buck3 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka4: buck4 {
+				regulator-name = "vdd_io_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka5: buck5 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1: ldo1 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2: ldo2 {
+				regulator-name = "vdd_mcuio_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3: ldo3 {
+				regulator-name = "vds_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4: ldo4 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 &main_pmx0 {
 	main_uart8_pins_default: main-uart8-pins-default {
 		pinctrl-single,pins = <
-- 
2.39.2

