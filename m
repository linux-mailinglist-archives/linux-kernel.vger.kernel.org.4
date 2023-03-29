Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C56CDCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjC2OfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC2Oew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:34:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13C65BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:30:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so15942264wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680100194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOXpOBI+ENek/PmTwExH+Nm7XRnHrqQv5ocHT5aDFe8=;
        b=iH/TFN3pTSAw0GnSpRVdb6WfvrGN2INAws2ZMmB2Gi9wRNYtOZz+3DUmHukFOoCHAT
         sdI7IDUOp2MlzRHdkBuv+1lOOQcHlzk5do9rIaM/m7qdHx9uGVW8pi7KwEwdUojEp89j
         tEgL0MlY9ONi6EMhXIib3mZuF3uOAGMSsftp6BIKld6RrvCrXcx7vlfHqydyB1SPml6d
         s7ctXrQ/lHXpHQIF/V9Bv8JzGRJbH9eTDDIqs+kqWdxl+tKlhgwNFIOe1Lv4gpbZma0H
         ir5Lt+Vye0TWvx1xliFWu+JiE94vHPXQvxI2E94Zg1kjh3TpW0olveeiQmTF19L3JdQv
         ShuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOXpOBI+ENek/PmTwExH+Nm7XRnHrqQv5ocHT5aDFe8=;
        b=LxdFC90TKw7vmDtMM2ynsw+aDvGDLXdH+r4vfPVbyQPLMHFUIEQGU2L2+ZPRzlxZLj
         Pwd/ftDvAzJ3aqpbe+fXouzOTkgFmzX2L+OqHIpicdLdW2dEgPlQkhXl4C6yHdNI8zgf
         lZBydDRAxFufsObRRM4tTG/EZ7R6SNgbZrLLSGsP/t2IJ9c9WyEYvkGkUrHrsPBwybqV
         PGtLeZT6TRJQ5AAG2tXymEgLjZ3DR5FYm5IJK8fjRsqCmvKQ3x1oQT2aYiVOSG5U6EJf
         VbQq04KD6l/PrUp0sqZwAebt0ekMp9usNgZVirwjPf91M0uncTaYMFQLD3uGx+hzRwxH
         +YKA==
X-Gm-Message-State: AAQBX9fLckII90nWH2c/So/tVX5XjcE7Le/gn0jluot9viX2qCY1sda1
        cZHiq7dRF5k/x2pcNZvuG7ikzQ==
X-Google-Smtp-Source: AKy350aIYleeYxgs9NrkeXQvCxu793WCfnyCgQm5q3R09O6Yl+m2zHmSvYICpG9/vSE4UjgMacNN0g==
X-Received: by 2002:a5d:550c:0:b0:2c9:e34e:7d1 with SMTP id b12-20020a5d550c000000b002c9e34e07d1mr15348298wrv.6.1680100194482;
        Wed, 29 Mar 2023 07:29:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:7049:3791:78c8:6c3])
        by smtp.gmail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm17270792wrm.33.2023.03.29.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:29:54 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com
Subject: [PATCH v1 4/4] arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
Date:   Wed, 29 Mar 2023 16:29:48 +0200
Message-Id: <20230329142948.833800-5-eblanc@baylibre.com>
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

From: Jerome Neanne <jneanne@baylibre.com>

This patch adds support for TPS6594 PMIC family on wakup I2C0 bus.
Theses devices provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 169 ++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e289d5b44356..df2d93bf2bbb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -150,6 +150,12 @@ J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
 	};
 
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xd4, PIN_INPUT, 7) /* (G26) WKUP_GPIO0_9 */
+		>;
+	};
+
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
@@ -308,3 +314,166 @@ &c71_0 {
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
+
+&wkup_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tps659413: tps659413@48 {
+		compatible = "ti,tps6594";
+		reg = <0x48>;
+		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+
+		ti,primary-pmic;
+		ti,multi-phase-id = <12>;
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
+			bucka12_reg: buck12 {
+				regulator-name = "vdd_cpu_avs";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1050000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3_reg: buck3 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
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
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3_reg: ldo3 {
+				regulator-name = "vdda_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4_reg: ldo4 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	tps659411: tps659411@4c {
+		compatible = "ti,tps6594";
+		reg = <0x4c>;
+		system-power-controller;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+
+		ti,multi-phase-id = <1234>;
+
+		buck1234-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			buckb1234_reg: buck1234 {
+				regulator-name = "vdd_core_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb5_reg: buck5 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob1_reg: ldo1 {
+				regulator-name = "vdd_sd_dv";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob2_reg: ldo2 {
+				regulator-name = "vdd_usb_3v3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob3_reg: ldo3 {
+				regulator-name = "vdd_io_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob4_reg: ldo4 {
+				regulator-name = "vda_pll_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+};
-- 
2.39.2

