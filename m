Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340A5E8DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiIXPbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiIXPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:30:44 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35867C93;
        Sat, 24 Sep 2022 08:30:32 -0700 (PDT)
Received: from g550jk.fritz.box (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D8CF5C7003;
        Sat, 24 Sep 2022 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664033430; bh=OZG7z5hLqaeBf8O4EfK4fVgLHVI2f8KChiL0yN6oMOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L2lsAbZYEVrRR7Xbm/ACWJASiY0prNtCyYvCyqzpfT7XNBEizQLTz51lAasnvjnFk
         yKb8WMuf7zxZrK55FfyttiZQ7TOFyjU2WDJ/YFWFqIlA+3/VYZqN5AaAhiKPWqpAZl
         umnswlYxbDDFjWFJpCrSyYMcgb9npoQ+K5AtMGYo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: qcom: Add support for Huawei Watch
Date:   Sat, 24 Sep 2022 17:29:37 +0200
Message-Id: <20220924152937.4076-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924152937.4076-1-luca@z3ntu.xyz>
References: <20220924152937.4076-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for this smartwatch, based on Snapdragon 400 SoC.

Currently supported functionality:
* Internal storage
* USB
* Charger
* Power button
* Bluetooth
* Wifi

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* Address review comments from v1:
  * newlines between reserved-memory and regulator nodes (Konrad)
  * status as last property in nodes (Konrad)
  * pm8226-regulators node name change (Krzysztof)
  * Add -pins suffix to state nodes (Krzysztof)

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/qcom-apq8026-huawei-sturgeon.dts | 376 ++++++++++++++++++
 2 files changed, 377 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3bc6bd5c8238..55087f16d718 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1026,6 +1026,7 @@ dtb-$(CONFIG_ARCH_OXNAS) += \
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8016-sbc.dtb \
 	qcom-apq8026-asus-sparrow.dtb \
+	qcom-apq8026-huawei-sturgeon.dtb \
 	qcom-apq8026-lg-lenok.dtb \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-cm-qs600.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
new file mode 100644
index 000000000000..d64096028ab1
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Luca Weiss <luca@z3ntu.xyz>
+ */
+
+/dts-v1/;
+
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/delete-node/ &adsp_region;
+
+/ {
+	model = "Huawei Watch";
+	compatible = "huawei,sturgeon", "qcom,apq8026";
+	chassis-type = "watch";
+	qcom,msm-id = <199 0x20000>;
+	qcom,board-id = <8 4>;
+
+	reserved-memory {
+		sbl_region: sbl@2f00000 {
+			reg = <0x02f00000 0x100000>;
+			no-map;
+		};
+
+		external_image_region: external-image@3100000 {
+			reg = <0x3100000 0x200000>;
+			no-map;
+		};
+
+		peripheral_region: peripheral@3300000 {
+			reg = <0x3300000 0x600000>;
+			no-map;
+		};
+
+		adsp_region: adsp@3900000 {
+			reg = <0x3900000 0x1400000>;
+			no-map;
+		};
+
+		modem_region: modem@4d00000 {
+			reg = <0x4d00000 0x1b00000>;
+			no-map;
+		};
+
+		modem_efs_region: modem-efs@7f00000 {
+			reg = <0x7f00000 0x100000>;
+			no-map;
+		};
+	};
+
+	vreg_wlan: wlan-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_regulator_default_state>;
+	};
+};
+
+&adsp {
+	status = "okay";
+};
+
+&blsp1_i2c5 {
+	clock-frequency = <384000>;
+
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+
+		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8226_l19>;
+		vio-supply = <&pm8226_lvs1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_default_state>;
+
+		syna,startup-delay-ms = <160>;
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
+&blsp1_uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart4_default_state>;
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43430a0-bt";
+		max-speed = <3000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bluetooth_default_state>;
+
+		host-wakeup-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2200000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_3 {
+	max-frequency = <100000000>;
+	non-removable;
+
+	vmmc-supply = <&vreg_wlan>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	wifi@1 {
+		compatible = "brcm,bcm43430a0-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		interrupts-extended = <&tlmm 66 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_hostwake_default_state>;
+	};
+};
+
+&smbb {
+	qcom,fast-charge-safe-voltage = <4370000>;
+	qcom,fast-charge-high-threshold-voltage = <4350000>;
+	qcom,minimum-input-voltage = <4350000>;
+	qcom,fast-charge-current-limit = <300000>;
+	qcom,fast-charge-safe-current = <600000>;
+	qcom,auto-recharge-threshold-voltage = <4240000>;
+};
+
+&tlmm {
+	blsp1_uart4_default_state: blsp1-uart4-default-state {
+		pins = "gpio12", "gpio13", "gpio14", "gpio15";
+		function = "blsp_uart4";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	bluetooth_default_state: bluetooth-default-state {
+		pins = "gpio63", "gpio64";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	touch_default_state: touch-default-state {
+		irq-pins {
+			pins = "gpio17";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		reset-pins {
+			pins = "gpio16";
+			function = "gpio";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
+	wlan_hostwake_default_state: wlan-hostwake-default-state {
+		pins = "gpio66";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
+	wlan_regulator_default_state: wlan-regulator-default-state {
+		pins = "gpio110";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&usb {
+	extcon = <&smbb>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&smbb>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.37.3

