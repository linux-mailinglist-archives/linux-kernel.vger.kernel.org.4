Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D196E2229
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDNL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjDNL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:28:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C110F2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso16365312wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681471729; x=1684063729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRzEzVDYA8QwCD288QN5gOIP/Fd6vwp2MgssppqS80U=;
        b=Ia+D/rHyRkNgC0wCGOhokt7FmOl5yiSbeooEkd5+Ijop8sWarxaIMpKx2+palJ9W7y
         Ys3Pfpp4KqGwAxVwSwMWl5jK7m8DhIpK/Kswhf/d5gbCHvKO6OBi9HuUUQseXDldOKvp
         RRGeNQfm48LqCSR0n/oeo9leBCf4yYKqHLTLQ02t5fRullqoU+wr7zrIAKRgpKiDdttI
         Kakvtd5zuzv+zI/JVMCgZtTeToESxIJW36pQ4NZHmUslZfjmiiBPYfvva6Epk+NSy2gy
         8SbtEdAwUcuO4nYhhnU180Ehpaho9xtykGcyVE4Ag+RQx+7byRU0VVm86yNhQcceQY5k
         s6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471729; x=1684063729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRzEzVDYA8QwCD288QN5gOIP/Fd6vwp2MgssppqS80U=;
        b=Wg8+nvd8UsTIRXijOiDzOIMWMCBL7fZgtVhDqlpVMdZmb2vQf0KbMkJUfkPjPJDlMM
         gI+uabwS8+FJda9NZ1Cf0XBkia3UzdcfpUnIMTPkliIoqqTGPoZEsD5cgo/LALZaYz+m
         0lIn4l+TPuBOfYebx9kVx1RI3cAPiVMn3p76zkBTpoHmDCeHjGAHK5fLfAivchLBseZ5
         M6E0C7cLEknZb9y/X0N9VjptoynEYl7ddMYCNEkPAeAp/XswF99jnXNEIooOFiAHdnBM
         yo4IpnqQynlwAiPP5N1ek8gBFF0y7Ir/wD/OhpIcxx6+dGcoDlstA3JPGf3Aw7hqJAf5
         q+Vg==
X-Gm-Message-State: AAQBX9cO5CxGSuvrl0WT9lBZ9UXld15Qq7BZSGjj0ANSjkT4QLTxHSGm
        0UywvoEy1g8yT8k9yYNKVhjg4A==
X-Google-Smtp-Source: AKy350bQQmW7RCQb4ePRyCOrPp88PLet9tgGv/z/o4qVumgykQHTja/p3AFRZKLPAnw+hwSRUfpRXA==
X-Received: by 2002:a05:600c:2118:b0:3f0:9eb5:98e0 with SMTP id u24-20020a05600c211800b003f09eb598e0mr4073577wml.37.1681471729284;
        Fri, 14 Apr 2023 04:28:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eca6:27f0:42a5:8f07:826a:465d])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003ede06f3178sm4063745wmi.31.2023.04.14.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:28:48 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com,
        aseketeli@baylibre.com
Subject: [PATCH v2 5/5] arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC
Date:   Fri, 14 Apr 2023 13:28:43 +0200
Message-Id: <20230414112843.1358067-6-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414112843.1358067-1-eblanc@baylibre.com>
References: <20230414112843.1358067-1-eblanc@baylibre.com>
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

From: Julien Panis <jpanis@baylibre.com>

This patch adds support for TPS6593 PMIC on main I2C0 bus.
This device provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 5c9012141ee2..99574474ca53 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -191,11 +191,106 @@ AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
 	};
 };
 
+&mcu_pmx0 {
+	status = "okay";
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
+		>;
+	};
+};
+
+&mcu_gpio0 {
+	status = "okay";
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+
+	tps659312: tps659312@48 {
+		compatible = "ti,tps6593-q1";
+		reg = <0x48>;
+		ti,primary-pmic;
+		system-power-controller;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+		buck123-supply = <&vcc_3v3_sys>;
+		buck4-supply = <&vcc_3v3_sys>;
+		buck5-supply = <&vcc_3v3_sys>;
+		ldo1-supply = <&vcc_3v3_sys>;
+		ldo2-supply = <&vcc_3v3_sys>;
+		ldo3-supply = <&buck5>;
+		ldo4-supply = <&vcc_3v3_sys>;
+
+		regulators {
+			buck123: buck123 {
+				regulator-name = "vcc_core";
+				regulator-min-microvolt = <715000>;
+				regulator-max-microvolt = <895000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: buck4 {
+				regulator-name = "vcc_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: buck5 {
+				regulator-name = "vcc_1v8_sys";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: ldo1 {
+				regulator-name = "vddshv5_sdio";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: ldo2 {
+				regulator-name = "vpp_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: ldo3 {
+				regulator-name = "vcc_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: ldo4 {
+				regulator-name = "vdda_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &main_i2c1 {
-- 
2.39.2

