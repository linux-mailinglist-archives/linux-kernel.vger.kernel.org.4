Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269215BAD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiIPMNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiIPMMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE0B0B0A;
        Fri, 16 Sep 2022 05:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 345B2B825ED;
        Fri, 16 Sep 2022 12:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B160C4347C;
        Fri, 16 Sep 2022 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330354;
        bh=LjtcPgXxF0+VZrtcJilydBrS6HItzd3uRTnnuRzWDgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIsbqmkvBaYfAl6VZnoh8h8b6TtwHIjn6MWI7l10ZMbS386DSD/wiwnCUTAMuAn16
         cdM+EEEw2DmqTQcdOm6IUev/HOKAm/ltKQqsu3Vc0i3VuGR1XtP7/IZHmZ24S2hyJM
         96MpJU0pKwwmxvETW8YFI4bOUKq3J6BTx1gv6v60juHiEA6Ui8HM8pH6S9Yy5eaEr6
         CoJ4hnuJbPKNoRvXGafjaZ/7bBu4S4F4vQSwlDODmFMqeeH1uvoLlOffLL84h1ksKe
         44CnjFxmsXWXaQ7chTrj4sxSCoMusqWhzsv1ix/X8sbiNDLKAj2CVSg+NBZni6UHnn
         3vg6FhKeXWxgQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5/6] arm64: dts: qcom: sc8180x: Introduce Primus
Date:   Fri, 16 Sep 2022 17:42:03 +0530
Message-Id: <20220916121204.3880182-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916121204.3880182-1-vkoul@kernel.org>
References: <20220916121204.3880182-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Introduce support for the SC8180X reference device, aka Primus, with
debug UART, regulators, UFS and USB support.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile           |   1 +
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi | 326 +++++++++
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 706 ++++++++++++++++++++
 3 files changed, 1033 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-primus.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d7669a7cee9f..f1c620bb078e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
new file mode 100644
index 000000000000..49c146b6f37f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+/ {
+	thermal-zones {
+		pmc8180-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmc8180_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		pmc8180c-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmc8180c_temp>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pmc8180_0: pmic@0 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pon: power-on@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+
+				status = "disabled";
+			};
+		};
+
+		pmc8180_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pmc8180_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmc8180_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+		};
+
+		pmc8180_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
+
+		pmc8180_gpios: gpio@c000 {
+			compatible = "qcom,pmc8180-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pmc8180", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pmic@2 {
+		compatible = "qcom,smb2351", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			vcoin@85 {
+				reg = <0x85>;
+				qcom,pre-scaling = <1 1>;
+				label = "vcoin2";
+			};
+		};
+	};
+
+	pmic@6 {
+		compatible = "qcom,pm8150c", "qcom,spmi-pmic";
+		reg = <0x6 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pmic@8 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x8 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pmic@a {
+		compatible = "qcom,smb2351", "qcom,spmi-pmic";
+		reg = <0xa SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0xa 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			vcoin@85 {
+				reg = <0x85>;
+				qcom,pre-scaling = <1 1>;
+				label = "vcoin";
+			};
+		};
+	};
+
+	pmic@4 {
+		compatible = "qcom,pm8150c", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power-on@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+
+			status = "disabled";
+		};
+
+		pmc8180c_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x4 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pmc8180c_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmc8180c_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+		};
+
+		pmc8180c_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x4 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		pmc8180c_gpios: gpio@c000 {
+			compatible = "qcom,pmc8180c-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@5 {
+		compatible = "qcom,pmc8180c", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+
+		pmc8180c_lpg: lpg {
+			compatible = "qcom,pmc8180c-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
new file mode 100644
index 000000000000..14582dbe7155
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -0,0 +1,706 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020-2021, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sc8180x.dtsi"
+#include "sc8180x-pmics.dtsi"
+
+/ {
+	model = "Qualcomm SC8180x Primus";
+	compatible = "qcom,sc8180x-primus", "qcom,sc8180x";
+
+	aliases {
+		serial0 = &uart12;
+		serial1 = &uart13;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pmc8180c_lpg 4 1000000>;
+		enable-gpios = <&pmc8180c_gpios 8 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_pwm_default_state>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hall_int_active_state>;
+
+		lid-switch {
+			gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			wakeup-source;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
+		};
+	};
+
+	reserved-memory {
+		rmtfs_mem: rmtfs-region@85500000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x85500000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		wlan_mem: wlan-region@8bc00000 {
+			reg = <0x0 0x8bc00000 0x0 0x180000>;
+			no-map;
+		};
+
+		adsp_mem: adsp-region@96e00000 {
+			reg = <0x0 0x96e00000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		mpss_mem: mpss-region@8d800000 {
+			reg = <0x0 0x8d800000 0x0 0x9600000>;
+			no-map;
+		};
+
+		gpu_mem: gpu-region@98a00000 {
+			reg = <0x0 0x98a00000 0x0 0x2000>;
+			no-map;
+		};
+
+		reserved-region@9a500000 {
+			reg = <0x0 0x9a500000 0x0 0x600000>;
+			no-map;
+		};
+	};
+
+	vreg_nvme_0p9: nvme-0p9-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_nvme_0p9";
+
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		regulator-always-on;
+	};
+
+	vreg_nvme_3p3: nvme-3p3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_nvme_3p3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8180c_gpios 11 0>;
+		enable-active-high;
+
+		regulator-always-on;
+	};
+
+	vdd_kb_tp_3v3: vdd-kb-tp-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_kb_tp_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		regulator-always-on;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&kb_tp_3v3_en_active_state>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	vreg_s4a_1p8: pm8150-s4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	pmc8180-a-rpmh-regulators {
+		compatible = "qcom,pmc8180-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p0>;
+
+		vreg_s5a_2p0: smps5 {
+			regulator-min-microvolt = <2040000>;
+			regulator-max-microvolt = <2100000>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a_1p3: ldo9 {
+			regulator-min-microvolt = <1296000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmc8180c-rpmh-regulators {
+		compatible = "qcom,pmc8180c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-l2-l3-supply = <&vreg_s6c_1p35>;
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_s6c_1p35: smps6 {
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1372000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s8c_1p8: smps8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_3p3: ldo4 {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3350000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pmc8180-e-rpmh-regulators {
+		compatible = "qcom,pmc8180-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s4e_0p98>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5e_2p05>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s4e_0p98: smps4 {
+			regulator-min-microvolt = <992000>;
+			regulator-max-microvolt = <992000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5e_2p05: smps5 {
+			regulator-min-microvolt = <2040000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1e_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5e_0p88: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7e_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10e_2p9: ldo10 {
+			regulator-min-microvolt = <2904000>;
+			regulator-max-microvolt = <2904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12e: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16e_3p0: ldo16 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&dispcc {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ts_i2c_active_state>;
+
+	status = "okay";
+
+	touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		hid-descr-addr = <0x1>;
+
+		vdd-supply = <&vreg_l4c_3p3>;
+		vddl-supply = <&vreg_l12e>;
+
+		post-power-on-delay-ms = <20>;
+
+		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_active_state>;
+	};
+};
+
+&i2c7 {
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&aux_i2c_active_state>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		hid-descr-addr = <0x1>;
+
+		interrupts-extended = <&tlmm 24 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_active_state>;
+
+		vdd-supply = <&vdd_kb_tp_3v3>;
+	};
+
+	keyboard@3a {
+		compatible = "hid-over-i2c";
+		reg = <0x3a>;
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&kb_int_active_state>;
+
+		vdd-supply = <&vdd_kb_tp_3v3>;
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_edp {
+	data-lanes = <0 1 2 3>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_hpd_active>;
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+
+			backlight = <&backlight>;
+
+			ports {
+				port {
+					auo_b133han05_in: endpoint {
+						remote-endpoint = <&mdss_edp_out>;
+					};
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss_edp_out: endpoint {
+				remote-endpoint = <&auo_b133han05_in>;
+			};
+		};
+	};
+};
+
+&pcie1 {
+	perst-gpio = <&tlmm 175 GPIO_ACTIVE_LOW>;
+	wake-gpio = <&tlmm 177 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_default_state>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5e_0p88>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+
+	status = "okay";
+};
+
+&pmc8180c_lpg {
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	memory-region = <&adsp_mem>;
+	firmware-name = "qcom/sc8180x/qcadsp8180.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	memory-region = <&mpss_mem>;
+	firmware-name = "qcom/sc8180x/qcmpss8180.mbn";
+
+	status = "okay";
+};
+
+&uart12 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&uart13 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart13_state>;
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3998-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l9a_1p3>;
+		vddch0-supply = <&vreg_l11c_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 190 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10e_2p9>;
+	vcc-max-microamp = <155000>;
+
+	vccq2-supply = <&vreg_l7e_1p8>;
+	vccq2-max-microamp = <425000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l5e_0p88>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+
+	status = "okay";
+};
+
+&usb_prim_hsphy {
+	vdda-pll-supply = <&vreg_l5e_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l16e_3p0>;
+
+	status = "okay";
+};
+
+&usb_prim_qmpphy {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l5e_0p88>;
+
+	status = "okay";
+};
+
+&usb_prim {
+	status = "okay";
+};
+
+&usb_prim_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_sec_hsphy {
+	vdda-pll-supply = <&vreg_l5e_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l16e_3p0>;
+
+	status = "okay";
+};
+
+&usb_sec_qmpphy {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l5e_0p88>;
+
+	status = "okay";
+};
+
+&usb_sec {
+	status = "okay";
+};
+
+&usb_sec_dwc3 {
+	dr_mode = "host";
+};
+
+&wifi {
+	memory-region = <&wlan_mem>;
+
+	vdd-0.8-cx-mx-supply = <&vreg_l1e_0p75>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l9a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l10c_3p3>;
+
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};
+
+/* PINCTRL */
+
+&pmc8180c_gpios {
+	bl_pwm_default_state: bl-pwm-default-state {
+		en {
+			pins = "gpio8";
+			function = "normal";
+		};
+
+		pwm {
+			pins = "gpio10";
+			function = "func1";
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <47 4>, <126 4>;
+
+	aux_i2c_active_state: aux-i2c-active-state {
+		pins = "gpio98", "gpio99";
+		function = "qup7";
+
+		bias-disable;
+		drive-strength = <16>;
+	};
+
+	edp_hpd_active: epd-hpd-active-state {
+		pins = "gpio10";
+		function = "edp_hot";
+	};
+
+	hall_int_active_state: hall-int-active-state {
+		pins = "gpio121";
+		function = "gpio";
+
+		input-enable;
+		bias-disable;
+	};
+
+	kb_int_active_state: kb-int-active-state {
+		int-n {
+			pins = "gpio37";
+			function = "gpio";
+
+			bias-pull-up;
+			intput-enable;
+		};
+
+		kp-disable {
+			pins = "gpio135";
+			function = "gpio";
+
+			output-high;
+		};
+	};
+
+	kb_tp_3v3_en_active_state: kb-tp-3v3-en-active-state {
+		pins = "gpio4";
+		function = "gpio";
+
+		bias-disable;
+	};
+
+	pcie2_default_state: pcie2-default-state {
+		clkreq {
+			pins = "gpio176";
+			function = "pci_e2";
+			bias-pull-up;
+		};
+
+		reset-n {
+			pins = "gpio175";
+			function = "gpio";
+
+			drive-strength = <2>;
+			output-low;
+			bias-pull-down;
+		};
+
+		wake-n {
+			pins = "gpio177";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	tp_int_active_state: tp-int-active-state {
+		tp-int {
+			pins = "gpio24";
+			function = "gpio";
+
+			bias-disable;
+			input-enable;
+		};
+
+		tp-close-n {
+			pins = "gpio116";
+			function = "gpio";
+
+			bias-disable;
+			input-enable;
+		};
+	};
+
+	ts_active_state: ts-active-state {
+		int-n {
+			pins = "gpio122";
+			function = "gpio";
+
+			input-enable;
+			bias-disable;
+		};
+
+		reset-n {
+			pins = "gpio54";
+			function = "gpio";
+
+			output-high;
+		};
+	};
+
+	ts_i2c_active_state: ts-i2c-active-state {
+		pins = "gpio114", "gpio115";
+		function = "qup1";
+
+		/* External pull up */
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	uart13_state: uart13-state {
+		cts {
+			pins = "gpio43";
+			function = "qup13";
+			bias-pull-down;
+		};
+
+		rts-tx {
+			pins = "gpio44", "gpio45";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx {
+			pins = "gpio46";
+			function = "qup13";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.37.3

