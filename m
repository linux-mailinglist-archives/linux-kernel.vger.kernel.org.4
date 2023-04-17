Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D326E4DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjDQPtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjDQPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:49:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59727C167
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so2468131wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681746516; x=1684338516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9JAvbnfuiwfgZ4itMTXGM4FzED/1nEwr6iYU2w9yyc=;
        b=M8LB9THBtS4L1zAuxTv4Z9VGbNMSrbT2of717SB64kMPyBych3XNYe4P87LCGxpYFj
         wsQefjuqGadHmpphe9EM1Cp0Wbv0WVOywzvUVt5av2Y7KU4J3BpYohuGt+z+WR/HXMpi
         ycS3rINfASPEwWuW0d9Z3codeE4OEP2vpf0aZLAQYoLWdOA9bV0uo83FXbcH34MbNg9n
         2iJyeI60dEFGyZLk7eDJPesd6qO9wfmKSMHs5YBeH9ZbUtAtDbWB4WXXZT1sQV83K/FS
         EnPUPltyCXvf9EIWM2sKvnhxPCSFsCckEEtuZfDuPPpQxHHBhqwWbPjfsUOiKNaxJWhd
         dWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746516; x=1684338516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9JAvbnfuiwfgZ4itMTXGM4FzED/1nEwr6iYU2w9yyc=;
        b=bTzjp+XOWlD14fIYRCDEF56CYnK9GpaRUerZjU0itQ4e66DtnbhHwgn6M3lkBv1nMZ
         L4/btbUhZsmZRCrBpbU18P0v82W8ZAiE5YKtIztYj8n0c0fVYGdsnxgjXMf0eJ8MGx8a
         yhi5aWBQI4NR8+TRl44AqdFM90mYJ8K1HUpOODv3GHkZLsRNX1emuZhj0zLwj9+YMDSL
         A844jsS/QUB8SflGCFsn8zzz4hgSvACVnpt8CBRlyjLEiQr5ssfxBLAqYVX0Ur9/dw+R
         6T3Tc6P/LYtOj6mJbs7gWmZp9y3OTRCGs+FiUN788nD3kKzVREo43vfK0Td7e8Eyk9RT
         oTww==
X-Gm-Message-State: AAQBX9ei1Vi9mbKVZoJma22Zq9451TPrgBSV5E82U3ve/nFmV/2Nd+vb
        GqNc1T0iDRh8fNBEX3ScwMSTow==
X-Google-Smtp-Source: AKy350Z1YR/y9brcnKOwCTwrty/oUX1WTTAc45xUD+Be8sz2ubXaf1PE8+bPy6vDJ9b8zHqcWtT8Sg==
X-Received: by 2002:a05:600c:34d0:b0:3f1:73d3:5362 with SMTP id d16-20020a05600c34d000b003f173d35362mr2108448wmq.13.1681746515836;
        Mon, 17 Apr 2023 08:48:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5888:afdf:3f10:3b2b])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c444500b003f09cda253esm16189932wmn.34.2023.04.17.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:35 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com,
        aseketeli@baylibre.com
Subject: [PATCH v3 1/6] arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
Date:   Mon, 17 Apr 2023 17:48:27 +0200
Message-Id: <20230417154832.216774-2-eblanc@baylibre.com>
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

This patch adds support for TPS6594 PMIC family on wakup I2C0 bus.
Theses devices provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 175 ++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index fa44ed4c17d5..d2587c24180f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -118,6 +118,25 @@ J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
 	};
 };
 
+&wkup_pmx2 {
+	/* wkup_pmx2 starts at 0x68 */
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
+			J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
+		>;
+	};
+};
+
+&wkup_pmx3 {
+	/* wkup_pmx3 starts at 0x174 */
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 7) /* (E18) WKUP_GPIO0_84 */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
@@ -231,3 +250,159 @@ flash@0 {
 		cdns,read-delay = <4>;
 	};
 };
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	tps659414: pmic@48 {
+		compatible = "ti,tps6594-q1";
+		reg = <0x48>;
+		ti,primary-pmic;
+		system-power-controller;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck1-supply = <&vsys_3v3>;
+		buck2-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			bucka1: buck1 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka2: buck2 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3: buck3 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka4: buck4 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka5: buck5 {
+				regulator-name = "vdd_phyio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1: ldo1 {
+				regulator-name = "vdd1_lpddr4_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2: ldo2 {
+				regulator-name = "vda_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3: ldo3 {
+				regulator-name = "vdd_wk_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4: ldo4 {
+				regulator-name = "vda_pll_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	lp876441: pmic@4c {
+		compatible = "ti,lp8764-q1";
+		reg = <0x4c>;
+		system-power-controller;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck1-supply = <&vsys_3v3>;
+		buck2-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+
+		regulators: regulators {
+			buckb1: buck1 {
+				regulator-name = "vdd_cpu_avs";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <900000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buckb2: buck2 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb3: buck3 {
+				regulator-name = "vdd_core_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb4: buck4 {
+				regulator-name = "vdd_io_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.39.2

