Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18D6CDC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjC2OfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjC2Oev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:34:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B0B46B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:30:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l27so15967625wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680100192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUkRftc1arMasTaD91LeIsdGy3wyosmCK6xDxEVsBSM=;
        b=cL/OkXlvlNIu70DIajIwEIFcy85ubqK2KpxsyByJw0ZjljxoKsehPsItqX1BBNI15L
         uOhQHbzFkw4jdJCeZFHryip53d7OSvqubdc0PM/AgxXUUgt09KUL9W8qiZRL7HTnfVSA
         6vDrptq5zUv0dJgHGcXBiExhYdEvvVkilUOYpJG+tQu+obhLr0Jwao6uJ3BA7SUK4kxZ
         IIUySv+TxBLU24DsePS3SClbtcxpyohJzOxLFfB3mPRacv+r1ZPNOxikdsCN2TrgWNSJ
         ui6DenUraIFWla5pMPK/ximGy3XpEpgb/H12uHsjSX8vQKixanN1V/8ehrDeisp+XhI3
         CVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUkRftc1arMasTaD91LeIsdGy3wyosmCK6xDxEVsBSM=;
        b=t1plHivbaQU2wHANj/RcWEYHQMBZ9M+4fbQkpLyYBwRkUrBxNDPv47FFVhqW81WQ2b
         OO6vI8u3k82DdzBKqjGNj7MD28sv3x40jDbiHDSsL/5UyoXRoL62gH6+UrvE5zhHiCqQ
         qlvfj/LAJyjBZ1O3wPowiQlXXqS0caZuJcI1FF77HNZsOUWdrBLPMI4JmkemSDXXHB5T
         tdmbVsyL6Nu/RGaBHQuPTt+rqAzYeyno35mBmAc3EVHdfyhWll4iqJQByRuS+QlwjmWW
         Dhgj/UHy0Ls0/ztyY6fnb1/eqrj7tm1tINcGws6yg1Q/ChMSVG4THGpyhHTKJBypAFsf
         GKBQ==
X-Gm-Message-State: AAQBX9eMcUkc+uVOOFVg61jfIflMZAskpJ6JqFdoq2LglYtwXuKOOnj8
        Z0KPC4kFtVubRtkk8EGxq2K+sg==
X-Google-Smtp-Source: AKy350b3H2PhUiyUm5TAif9X2q2cFLxhvU6Cj/E1dzv6O5Qgf4mAnECyTa/wawi4MdlUYQNXv47gtA==
X-Received: by 2002:adf:f78b:0:b0:2ce:aed4:7f22 with SMTP id q11-20020adff78b000000b002ceaed47f22mr16701671wrp.50.1680100191750;
        Wed, 29 Mar 2023 07:29:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:7049:3791:78c8:6c3])
        by smtp.gmail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm17270792wrm.33.2023.03.29.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:29:51 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com
Subject: [PATCH v1 1/4] arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
Date:   Wed, 29 Mar 2023 16:29:45 +0200
Message-Id: <20230329142948.833800-2-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329142948.833800-1-eblanc@baylibre.com>
References: <20230329142948.833800-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 170 ++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index fa44ed4c17d5..a6c085256a50 100644
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
@@ -231,3 +250,154 @@ flash@0 {
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
+	tps659414: tps659414@48 {
+		compatible = "ti,tps6594";
+		reg = <0x48>;
+		ti,primary-pmic;
+		system-power-controller;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
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
+			bucka1_reg: buck1 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka2_reg: buck2 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3_reg: buck3 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka4_reg: buck4 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka5_reg: buck5 {
+				regulator-name = "vdd_phyio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1_reg: ldo1 {
+				regulator-name = "vdd1_lpddr4_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2_reg: ldo2 {
+				regulator-name = "vda_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3_reg: ldo3 {
+				regulator-name = "vdd_wk_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4_reg: ldo4 {
+				regulator-name = "vda_pll_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	lp876441: lp876441@4c {
+		compatible = "ti,lp8764";
+		reg = <0x4c>;
+		system-power-controller;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
+
+		buck1-supply = <&vsys_3v3>;
+		buck2-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+
+		regulators: regulators {
+			buckb1_reg: buck1 {
+				/*VDD_CPU_AVS_REG*/
+				regulator-name = "vdd_cpu_avs";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buckb2_reg: buck2 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb3_reg: buck3 {
+				regulator-name = "vdd_core_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb4_reg: buck4 {
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

