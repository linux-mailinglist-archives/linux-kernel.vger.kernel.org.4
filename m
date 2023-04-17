Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E9B6E4DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDQPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjDQPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:49:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2178CC1F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v3so1012825wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681746520; x=1684338520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcRrrafnmj1BNzqa/iUYoMZWw4jkCZAjXTqTzVy8ucQ=;
        b=GtzE3lsLPbucGlEV8jBhZ1WPNPi/LTuRIsY31YDkOpnfj4NT8knu0ZPqYxAl3g5av9
         G+1Uvrd6fgRidCXtFz0rY7Rq6NfCRsLWx84KFRpgjnk2N39PEAJtsdhL1nOmrdRHzAXw
         Ye3DQRaRHCJTgAyCD1jIjWkraN63QEDACXlKGRGiAm8kjguXkiGKjqV4mxusFxmXbKUa
         Fm38F9xpptksZjeeQ01R/BIIG0CmZBKMX0bl3k4gFSZq9o1sZKGFsgyCeLvCj7CXhE3s
         EHUgdJtY9Vtk+70svvPfaaFXEZfr0U/U//1087sSmAFT2D8dP7JATOXqaFW5IAbPbQs/
         Cxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746520; x=1684338520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcRrrafnmj1BNzqa/iUYoMZWw4jkCZAjXTqTzVy8ucQ=;
        b=NYvUaDCGDMldsVisA+ocDxsJaMRpBdZ08uKBbL5eFTwWFOYEFz4paP2W4wkGGdjs22
         EJNPd4epXr+bcAq8zQlWzbGpaOdtKvdRFep7uwi88jE5M8snQAfVU/CIFl/WL61vocbs
         YNHTk1VVj1447uaMsGvZ8siN1JlTvPFhO11PlQCsHPfpG31GV6Ir2bTOfmJYeFigMHcc
         e72XWxlPyu/W2z22Kf2tidCE2Dz8+rwJCKITQioidMYVvs029euw0sFfbBipdXHp+LbZ
         U/BO6Q7zTBzaCufFWJdh5w42KBVqHm9yFDFMqPGaiYmBiyNVXoIKTA1WNeEtlCNrILsk
         8ttw==
X-Gm-Message-State: AAQBX9cmyiOgCXw9F00ZN6ZPz74sDAVpc7hHdhusI5SWoncj5C+FNSnm
        raFR3P5dyUIeD1FR4z3nmM1r3w==
X-Google-Smtp-Source: AKy350ZzX1Qi9hj8K7Mg0GJiW1AVnK93w4bItP/Hc3CHuhOdj7Z8nLAKww+sO2+BWPdYo61dEVsYOg==
X-Received: by 2002:a1c:f206:0:b0:3ee:19b4:a2e6 with SMTP id s6-20020a1cf206000000b003ee19b4a2e6mr11716537wmc.19.1681746520253;
        Mon, 17 Apr 2023 08:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5888:afdf:3f10:3b2b])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c444500b003f09cda253esm16189932wmn.34.2023.04.17.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:39 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com,
        aseketeli@baylibre.com
Subject: [PATCH v3 5/6] arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC
Date:   Mon, 17 Apr 2023 17:48:31 +0200
Message-Id: <20230417154832.216774-6-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417154832.216774-1-eblanc@baylibre.com>
References: <20230417154832.216774-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 8cd4a7ecc121..f2b95345fb9c 100644
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
+	tps659413: pmic@48 {
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

