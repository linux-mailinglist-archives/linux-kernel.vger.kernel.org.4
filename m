Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA567691B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAUUSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjAUUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:17:56 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A523129;
        Sat, 21 Jan 2023 12:17:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vw16so21747940ejc.12;
        Sat, 21 Jan 2023 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLDEq70nEwkTQ0vkNZtwKQ6CeehDrdJVI3EHwcw8z9Q=;
        b=h2ApT45S9xewH1+dPOJpqG/ddAde9Jz4bDD8DEUJA34RthxYJJWQaE1m9kkBu44oP0
         LL/jrAr6YtYrSJZzZkTEsjX28yXJf7QyoI2iKux6mN8gCM8g48XdUubzBmoiM70K0aTL
         T14seyNvsxsmqmwXE0wCy7+Hqg5/8mpyj6Vy5RlHZC3lekbvlfV8VUaK5KxjL/wcA8n6
         cHT+Vq4SELntjUWTlBTixGx0WFScxdH5ogMvPw8gI6+M5IxuCYl16+IyBiFfOyfGT1cQ
         3fkIC9mYu40zvQjYr5jF26093r3jyx+fVRnJceUTnTHJU1fE17sJNeHbe2tXDgjj2RuL
         FPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLDEq70nEwkTQ0vkNZtwKQ6CeehDrdJVI3EHwcw8z9Q=;
        b=sUcIbMafmUOrUxQF2VPmeuk9/igF4fAboha2sVqQvekrE3L4h2OFPqTXH9hZBn1ZLQ
         4752DHzW9qx3K3aoebV+/NH6lYsvZTHf48JTBaBRncvMnXBfK2cB7PDsEkROlNw9qa2y
         FZE15HkxPP5256HQi0burXl0VDjKiUM1/8ctfSdi0B6FwCt9RLXSvpFARBLi4aUDtCCR
         qbUFiW38+SxkGSzWahn0qBS75sGh2WlwbHe8MmMbxtYjRfn93x1kZoN4w1aH6rV1UP3I
         zfg383wqGokFJnS+sxguAQIp2ON8C95pq21//luMjzCbjY6hn2B57zUDaNBqScPYAMGd
         oAGw==
X-Gm-Message-State: AFqh2krODMt2V4StFb1vkKu1H2FEUVieZ1iLQgcB1rYzENDzgA0A/dlq
        Q5KAVsVrZdQ3OllmODc00bVZ96CgNWHYWQ==
X-Google-Smtp-Source: AMrXdXvGM7bJl1XLLcpDhSOhach+6RXeYkuS60tTzjxMcYDJPlLX62oFPnx+zh1mBfsAvcd4vNq0NQ==
X-Received: by 2002:a17:906:6b13:b0:872:cc12:f712 with SMTP id q19-20020a1709066b1300b00872cc12f712mr17539138ejr.43.1674332251495;
        Sat, 21 Jan 2023 12:17:31 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906614400b008512e1379dbsm16599493ejl.171.2023.01.21.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:17:31 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] arm: dts: exynos5422: Add device-tree for Samsung Galaxy S5 (SM-G900H)
Date:   Sat, 21 Jan 2023 22:17:21 +0200
Message-Id: <20230121201722.46636-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201722.46636-1-markuss.broks@gmail.com>
References: <20230121201722.46636-1-markuss.broks@gmail.com>
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

Samsung Galaxy S5 (SM-G900H) was sold alongside Samsung Galaxy S5
with Snapdragon SoC, however the Exynos version features a 3G
capable Intel modem instead of Qualcomm version featuring LTE modem.
This phone is based on Exynos5422. Currently, the touchscreen,
USB, eMMC and the PMIC are enabled in the device-tree.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 676 +++++++++++++++++++
 2 files changed, 677 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-samsung-k3g.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c014f4fc53c0..b3aa4ad73d52 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -246,6 +246,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5422-odroidxu3.dtb \
 	exynos5422-odroidxu3-lite.dtb \
 	exynos5422-odroidxu4.dtb \
+	exynos5422-samsung-k3g.dtb \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-dlink-dir-685.dtb \
diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
new file mode 100644
index 000000000000..ba5f01bdce66
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -0,0 +1,676 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung Galaxy S5 (SM-G900H) device-tree source
+ *
+ * Copyright (c) 2023 Markuss Broks
+ */
+
+/dts-v1/;
+#include <dt-bindings/clock/samsung,s2mps11.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "exynos5800.dtsi"
+#include "exynos5422-cpus.dtsi"
+
+/ {
+	model = "Samsung Galaxy S5 (SM-G900H)";
+	compatible = "samsung,k3g", "samsung,exynos5800", \
+		     "samsung,exynos5";
+
+	chassis-type = "handset";
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x80000000>; /* 2 GiB */
+	};
+
+	fixed-rate-clocks {
+		oscclk {
+			compatible = "samsung,exynos5420-oscclk";
+			clock-frequency = <24000000>;
+		};
+	};
+
+	firmware@2073000 {
+		compatible = "samsung,secure-firmware";
+		reg = <0x02073000 0x1000>;
+	};
+
+	tsp_vdd: regulator-tsp-vdd-en {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_vdd_en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpy3 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+};
+
+&cpu0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&buck6_reg>;
+};
+
+&gpu {
+	status = "okay";
+	mali-supply = <&buck4_reg>;
+};
+
+&hsi2c_7 {
+	status = "okay";
+
+	pmic@66 {
+		compatible = "samsung,s2mps11-pmic";
+		reg = <0x66>;
+
+		interrupt-parent = <&gpx0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&s2mps11_irq>;
+
+		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
+			#clock-cells = <1>;
+			clock-output-names = "s2mps11_ap",
+					     "s2mps11_cp", "s2mps11_bt";
+		};
+
+		regulators {
+			buck1_reg: BUCK1 {
+				regulator-name = "VDD_MIF";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "VDD_ARM";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "VDD_INT";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "VDD_G3D";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "VDD_MEM";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "VDD_KFC";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck7_reg: BUCK7 {
+				regulator-name = "VIN_LLDO";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+			};
+
+			buck8_reg: BUCK8 {
+				regulator-name = "VIN_MLDO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-always-on;
+			};
+
+			buck9_reg: BUCK9 {
+				regulator-name = "VIN_HLDO";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-always-on;
+			};
+
+			buck10_reg: BUCK10 {
+				regulator-name = "VDD_CAM_ISP";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3550000>;
+			};
+
+			ldo1_reg: LDO1 {
+				regulator-name = "VDD_ALIVE";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "VDD_APIO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "VDD_APIO_MMC01";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "VDD_ADC";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-name = "VDD_HRM_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo6_reg: LDO6 {
+				regulator-name = "VDD_MIPI";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo7_reg: LDO7 {
+				regulator-name = "VDD_MIPI_PLL_ABB1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "VDD_VTF";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "VDD_UOTG";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "VDDQ_PRE";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo11_reg: LDO11 {
+				regulator-name = "VDD_HSIC_1V0";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo12_reg: LDO12 {
+				regulator-name = "VDD_HSIC_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo13_reg: LDO13 {
+				regulator-name = "VDD_APIO_MMC2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo14_reg: LDO14 {
+				regulator-name = "VDD_MOTOR";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo15_reg: LDO15 {
+				regulator-name = "VDD_CAM1_2V8";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo16_reg: LDO16 {
+				regulator-name = "VDD_AP";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo17_reg: LDO17 {
+				/* Unused */
+				regulator-name = "VDD_LDO17";
+			};
+
+			ldo18_reg: LDO18 {
+				regulator-name = "VDD_CODEC";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo19_reg: LDO19 {
+				regulator-name = "VDD_VMMC";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo20_reg: LDO20 {
+				regulator-name = "VDD_CAM1_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo21_reg: LDO21 {
+				regulator-name = "VDD_CAM_IO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo22_reg: LDO22 {
+				regulator-name = "VDD_CAM0_S_CORE";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo23_reg: LDO23 {
+				regulator-name = "VDD_MIFS";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo24_reg: LDO24 {
+				regulator-name = "VDD_MHL_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo25_reg: LDO25 {
+				regulator-name = "VDD_LCD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo26_reg: LDO26 {
+				regulator-name = "VDD_CAM0_AF";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo27_reg: LDO27 {
+				regulator-name = "VDD_G3DS";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo28_reg: LDO28 {
+				regulator-name = "VDD_LCD_3V0";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo29_reg: LDO29 {
+				/* Unused */
+				regulator-name = "VDD_LDO29";
+			};
+
+			ldo30_reg: LDO30 {
+				regulator-name = "VDD_TOUCH";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo31_reg: LDO31 {
+				regulator-name = "VDD_COMP";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo32_reg: LDO32 {
+				regulator-name = "VDD_TOUCH_IO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo33_reg: LDO33 {
+				regulator-name = "VDD_MHL_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo34_reg: LDO34 {
+				regulator-name = "VDD_HRM_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo35_reg: LDO35 {
+				regulator-name = "VDD_SIL";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo36_reg: LDO36 {
+				/* Unused */
+				regulator-name = "VDD_LDO36";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo37_reg: LDO37 {
+				/* Unused */
+				regulator-name = "VDD_LDO37";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo38_reg: LDO38 {
+				regulator-name = "VDD_KEY_LED";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c_0 {
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		interrupt-parent = <&gpx1>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		vio-supply = <&ldo32_reg>;
+		vdd-supply = <&tsp_vdd>;
+		syna,startup-delay-ms = <100>;
+
+		pinctrl-0 = <&touch_pin>;
+		pinctrl-names = "default";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
+
+/* eMMC flash */
+&mmc_0 {
+	status = "okay";
+	mmc-hs200-1_8v;
+	cap-mmc-highspeed;
+	non-removable;
+	clock-frequency = <400000000>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+	samsung,read-strobe-delay = <90>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_rclk>;
+	bus-width = <8>;
+};
+
+&pinctrl_0 {
+	s2mps11_irq: s2mps11-irq-pin {
+		samsung,pins = "gpx0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	touch_pin: touch-int-pin {
+		samsung,pins = "gpx1-6";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+};
+
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
+
+&timer {
+	arm,cpu-registers-not-fw-configured;
+};
+
+&tmu_cpu0 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu1 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu2 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu3 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_gpu {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "peripheral";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "peripheral";
+};
+
+&usbdrd3_0 {
+	vdd33-supply = <&ldo9_reg>;
+	vdd10-supply = <&ldo11_reg>;
+};
+
+&usbdrd3_1 {
+	vdd33-supply = <&ldo9_reg>;
+	vdd10-supply = <&ldo11_reg>;
+};
-- 
2.39.0

