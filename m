Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9F722283
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjFEJra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjFEJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:47:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2CF3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 02:47:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fb4ee9ba1so2083948a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685958437; x=1688550437;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BaLgQLWJXAqDyJFnIw/aR31O8tKtcRk2hNDqUiTveXA=;
        b=HdLn7/FLEg4UnScf7Uv8pk975nqna6Nj7iIU43fCCMuHjWPiKrtX0VK5QORDWHRptJ
         JFhRgBYFAvuYcl/0y57HRok/MuaQMWHRLSsRHy/YxbLzGRTnG04aoWa6svKy9lCHfx1N
         tDhgx9AjVcEO3C/VUVxKtYFPNVENrMxd4JKxyUoQ8Ihe1Q6aa8NGPiOa3s6d1b15qmmU
         N0jFLbprK+4JKc5bQ31R3prPHDkps+p6gdb3oQl1kI+Ql7KMf6RJqGeDO8EGwfn+B6pu
         8kdmIleQDgBwaqmgK+6EbBsNpbeLDebDuslhfHZRerJRBFegzbXnfDlOLsrgDKTUBB89
         cMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685958437; x=1688550437;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaLgQLWJXAqDyJFnIw/aR31O8tKtcRk2hNDqUiTveXA=;
        b=TNMxzT8G42btBhMiMB2GNJqe30Ts5SOGYWb5QteBaLxKoVdVNX+z1utLtzpd5/iE+A
         rCIjMJQSIDn3stMQigMIrfGdGqIdsWjfMdFZhxbvUG3TSoAHYrgidkgmHSWUKsYwJsgw
         qAVH3o9UDmawuFz+jvxmtx+E50gtb0e/2G9j+tvTbcjau7RQ5jYTkDSsKm3oBKAGjXIa
         NzLlUeu2fVa5lBD6+QtQVDIc1/MuMyLLh6UEVEv7J1jxLFjQOO1vG0ZNMnPuMWVqznsz
         sZM+2wcaOPR+zDo/6D5Ye5XComUyg3b2g9i+RwXo1PRZbO29CM+mZxSwiiwwM3aOuD7e
         pKwg==
X-Gm-Message-State: AC+VfDw9KsKMfZvW8H7caOBTblS8b6j+Naf8spJQjofbe1FpEKsTt1Qq
        PGqm5W2HjaUkMPxT2xu1C0UElQ==
X-Google-Smtp-Source: ACHHUZ5Av2lfaUR+DnlRvKob3lF/KNXR/QoLyOdQKo/r0qxVGnEzJEsTKpYRQv8SkuZ+k6eUGJru7g==
X-Received: by 2002:a17:903:249:b0:1ab:29bc:bd87 with SMTP id j9-20020a170903024900b001ab29bcbd87mr3147375plh.35.1685958436652;
        Mon, 05 Jun 2023 02:47:16 -0700 (PDT)
Received: from localhost.localdomain ([49.207.50.231])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0295de9acsm6150153plh.179.2023.06.05.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 02:47:15 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: Split sdm845-db845c to add headless support
Date:   Mon,  5 Jun 2023 15:17:10 +0530
Message-Id: <20230605094710.2037879-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up of the upstream discussion,
https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u,
around adding a reserved memory region in sdm845-db845c
for the framebuffer memory (the splash region set up by
the bootloader) but the general opinion was to avoid
adding that reserved memory for the headless DB845c
usecase.

So this patch splits the sdm845-db845c into a common dtsi,
a new sdm845-db845-headless DT, which disables the mdss
display subsystem, and a new sdm845-db845c DT with an
additional reserved-memory region for the framebuffer.

The default sdm845-db845c.dtb remains pretty much the same
(with an exception of additional reserved-memory region),
while others can use sdm845-db845c-headless.dtb for their
headless systems.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Please pick this after the lvs regulator nodes reordering patch
https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/T/#u.
I'll rebase and resend this patch otherwise.

 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sdm845-db845c-common.dtsi   | 1178 +++++++++++++++++
 .../boot/dts/qcom/sdm845-db845c-headless.dts  |    9 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 1172 +---------------
 4 files changed, 1194 insertions(+), 1166 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c-headless.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 4f9e81253e18..22876ea2e409 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -166,6 +166,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-headless.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
new file mode 100644
index 000000000000..ecc4a851e29c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
@@ -0,0 +1,1178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include "sdm845.dtsi"
+#include "sdm845-wcd9340.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+
+/ {
+	model = "Thundercomm Dragonboard 845c";
+	compatible = "thundercomm,db845c", "qcom,sdm845";
+	qcom,msm-id = <341 0x20001>;
+	qcom,board-id = <8 0>;
+
+	aliases {
+		serial0 = &uart9;
+		serial1 = &uart6;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* Fixed crystal oscillator dedicated to MCP2517FD */
+	clk40M: can-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+	};
+
+	dc12v: dc12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "DC12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_pin_a>;
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "green:user4";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pm8998_gpios 13 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "panic-indicator";
+			default-state = "off";
+		};
+
+		led-1 {
+			label = "yellow:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&pm8998_gpios 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		led-2 {
+			label = "blue:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
+	lt9611_1v8: lt9611-vdd18-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "LT9611_1V8";
+
+		vin-supply = <&vdc_5v>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	lt9611_3v3: lt9611-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "LT9611_3V3";
+
+		vin-supply = <&vdc_3v3>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		/*
+		 * TODO: make it possible to drive same GPIO from two clients
+		 * gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
+		 * enable-active-high;
+		 */
+	};
+
+	pcie0_1p05v: pcie-0-1p05v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE0_1.05V";
+
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1050000>;
+
+		/*
+		 * TODO: make it possible to drive same GPIO from two clients
+		 * gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
+		 * enable-active-high;
+		 */
+	};
+
+	cam0_dvdd_1v2: cam0-dvdd-1v2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM0_DVDD_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		enable-active-high;
+		gpio = <&pm8998_gpios 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam0_dvdd_1v2_en_default>;
+		vin-supply = <&vbat>;
+	};
+
+	cam0_avdd_2v8: cam0-avdd-2v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM0_AVDD_2V8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		enable-active-high;
+		gpio = <&pm8998_gpios 10 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam0_avdd_2v8_en_default>;
+		vin-supply = <&vbat>;
+	};
+
+	/* This regulator is enabled when the VREG_LVS1A_1P8 trace is enabled */
+	cam3_avdd_2v8: cam3-avdd-2v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "CAM3_AVDD_2V8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+		vin-supply = <&vbat>;
+	};
+
+	pcie0_3p3v_dual: vldo-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VLDO_3V3";
+
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie0_pwren_state>;
+	};
+
+	v5p0_hdmiout: v5p0-hdmiout-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "V5P0_HDMIOUT";
+
+		vin-supply = <&vdc_5v>;
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <500000>;
+
+		/*
+		 * TODO: make it possible to drive same GPIO from two clients
+		 * gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
+		 * enable-active-high;
+		 */
+	};
+
+	vbat: vbat-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT";
+
+		vin-supply = <&dc12v>;
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		regulator-always-on;
+	};
+
+	vbat_som: vbat-som-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT_SOM";
+
+		vin-supply = <&dc12v>;
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		regulator-always-on;
+	};
+
+	vdc_3v3: vdc-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_3V3";
+		vin-supply = <&dc12v>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vdc_5v: vdc-5v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_5V";
+
+		vin-supply = <&dc12v>;
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <500000>;
+		regulator-always-on;
+	};
+
+	vreg_s4a_1p8: vreg-s4a-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+
+		vin-supply = <&vbat_som>;
+	};
+};
+
+&adsp_pas {
+	status = "okay";
+
+	firmware-name = "qcom/sdm845/adsp.mbn";
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8998-rpmh-regulators";
+		qcom,pmic-id = "a";
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-s11-supply = <&vph_pwr>;
+		vdd-s12-supply = <&vph_pwr>;
+		vdd-s13-supply = <&vph_pwr>;
+		vdd-l1-l27-supply = <&vreg_s7a_1p025>;
+		vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
+		vdd-l3-l11-supply = <&vreg_s7a_1p025>;
+		vdd-l4-l5-supply = <&vreg_s7a_1p025>;
+		vdd-l6-supply = <&vph_pwr>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
+		vdd-l9-supply = <&vreg_bob>;
+		vdd-l10-l23-l25-supply = <&vreg_bob>;
+		vdd-l13-l19-l21-supply = <&vreg_bob>;
+		vdd-l16-l28-supply = <&vreg_bob>;
+		vdd-l18-l22-supply = <&vreg_bob>;
+		vdd-l20-l24-supply = <&vreg_bob>;
+		vdd-l26-supply = <&vreg_s3a_1p35>;
+		vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
+
+		vreg_lvs1a_1p8: lvs1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vreg_s3a_1p35: smps3 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_s5a_2p04: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s7a_1p025: smps7 {
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1028000>;
+		};
+
+		vreg_l1a_0p875: ldo1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p95: ldo13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_1p3: ldo17 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l20a_2p95: ldo20 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2968000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l21a_2p95: ldo21 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2968000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l24a_3p075: ldo24 {
+			regulator-min-microvolt = <3088000>;
+			regulator-max-microvolt = <3088000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l25a_3p3: ldo25 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l26a_1p2: ldo26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pmi8998-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+	};
+};
+
+&cdsp_pas {
+	status = "okay";
+	firmware-name = "qcom/sdm845/cdsp.mbn";
+};
+
+&dsi0 {
+	status = "okay";
+	vdda-supply = <&vreg_l26a_1p2>;
+
+	qcom,dual-dsi-mode;
+	qcom,master-dsi;
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&lt9611_a>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&dsi0_phy {
+	status = "okay";
+	vdds-supply = <&vreg_l1a_0p875>;
+};
+
+&dsi1 {
+	vdda-supply = <&vreg_l26a_1p2>;
+
+	qcom,dual-dsi-mode;
+
+	/* DSI1 is slave, so use DSI0 clocks */
+	assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+
+	status = "okay";
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&lt9611_b>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&dsi1_phy {
+	vdds-supply = <&vreg_l1a_0p875>;
+	status = "okay";
+};
+
+&gcc {
+	protected-clocks = <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_LPASS_Q6_AXI_CLK>,
+			   <GCC_LPASS_SWAY_CLK>;
+};
+
+&gmu {
+	status = "okay";
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sdm845/a630_zap.mbn";
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	lt9611_codec: hdmi-bridge@3b {
+		compatible = "lontium,lt9611";
+		reg = <0x3b>;
+		#sound-dai-cells = <1>;
+
+		interrupts-extended = <&tlmm 84 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&lt9611_1v8>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lt9611_irq_pin>, <&dsi_sw_sel>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				lt9611_b: endpoint {
+					remote-endpoint = <&dsi1_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&i2c11 {
+	/* On Low speed expansion */
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c14 {
+	/* On Low speed expansion */
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mss_pil {
+	status = "okay";
+	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mbn";
+};
+
+&pcie0 {
+	status = "okay";
+	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+
+	vddpe-3v3-supply = <&pcie0_3p3v_dual>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+};
+
+&pcie0_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
+&pcie1 {
+	status = "okay";
+	perst-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+};
+
+&pcie1_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
+&pm8998_gpios {
+	gpio-line-names =
+		"NC",
+		"NC",
+		"WLAN_SW_CTRL",
+		"NC",
+		"PM_GPIO5_BLUE_BT_LED",
+		"VOL_UP_N",
+		"NC",
+		"ADC_IN1",
+		"PM_GPIO9_YEL_WIFI_LED",
+		"CAM0_AVDD_EN",
+		"NC",
+		"CAM0_DVDD_EN",
+		"PM_GPIO13_GREEN_U4_LED",
+		"DIV_CLK2",
+		"NC",
+		"NC",
+		"NC",
+		"SMB_STAT",
+		"NC",
+		"NC",
+		"ADC_IN2",
+		"OPTION1",
+		"WCSS_PWR_REQ",
+		"PM845_GPIO24",
+		"OPTION2",
+		"PM845_SLB";
+
+	cam0_dvdd_1v2_en_default: cam0-dvdd-1v2-en-state {
+		pins = "gpio12";
+		function = "normal";
+
+		bias-pull-up;
+		drive-push-pull;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+
+	cam0_avdd_2v8_en_default: cam0-avdd-2v8-en-state {
+		pins = "gpio10";
+		function = "normal";
+
+		bias-pull-up;
+		drive-push-pull;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+
+	vol_up_pin_a: vol-up-active-state {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pmi8998_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <3>;
+
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+
+	led@4 {
+		reg = <4>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <2>;
+	};
+
+	led@5 {
+		reg = <5>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <1>;
+	};
+};
+
+&pmi8998_rradc {
+	status = "okay";
+};
+
+/* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
+&q6afedai {
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
+		qcom,sd-lines = <0 1 2 3>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+
+	dai@3 {
+		reg = <3>;
+		direction = <2>;
+		is-compress-dai;
+	};
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
+&sdhc_2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
+};
+
+&sound {
+	compatible = "qcom,db845c-sndcard", "qcom,sdm845-sndcard";
+	pinctrl-0 = <&quat_mi2s_active
+			 &quat_mi2s_sd0_active
+			 &quat_mi2s_sd1_active
+			 &quat_mi2s_sd2_active
+			 &quat_mi2s_sd3_active>;
+	pinctrl-names = "default";
+	model = "DB845c";
+	audio-routing =
+		"RX_BIAS", "MCLK",
+		"AMIC1", "MIC BIAS1",
+		"AMIC2", "MIC BIAS2",
+		"DMIC0", "MIC BIAS1",
+		"DMIC1", "MIC BIAS1",
+		"DMIC2", "MIC BIAS3",
+		"DMIC3", "MIC BIAS3",
+		"SpkrLeft IN", "SPK1 OUT",
+		"SpkrRight IN", "SPK2 OUT",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MM_DL2",  "MultiMedia2 Playback",
+		"MM_DL4",  "MultiMedia4 Playback",
+		"MultiMedia3 Capture", "MM_UL3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	mm4-dai-link {
+		link-name = "MultiMedia4";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA4>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&lt9611_codec 0>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 1>;
+		};
+	};
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup_spi0_default>;
+	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
+
+	can@0 {
+		compatible = "microchip,mcp2517fd";
+		reg = <0>;
+		clocks = <&clk40M>;
+		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&vdc_5v>;
+		xceiver-supply = <&vdc_5v>;
+	};
+};
+
+&spi2 {
+	/* On Low speed expansion */
+	status = "okay";
+};
+
+&tlmm {
+	cam0_default: cam0-default-state {
+		rst-pins {
+			pins = "gpio9";
+			function = "gpio";
+
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mclk0-pins {
+			pins = "gpio13";
+			function = "cam_mclk";
+
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	cam3_default: cam3-default-state {
+		rst-pins {
+			function = "gpio";
+			pins = "gpio21";
+
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mclk3-pins {
+			function = "cam_mclk";
+			pins = "gpio16";
+
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	dsi_sw_sel: dsi-sw-sel-state {
+		pins = "gpio120";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio84";
+		function = "gpio";
+		bias-disable;
+	};
+
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio36";
+			function = "pci_e0";
+			bias-pull-up;
+		};
+
+		reset-n-pins {
+			pins = "gpio35";
+			function = "gpio";
+
+			drive-strength = <2>;
+			output-low;
+			bias-pull-down;
+		};
+
+		wake-n-pins {
+			pins = "gpio37";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie0_pwren_state: pcie0-pwren-state {
+		pins = "gpio90";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		perst-n-pins {
+			pins = "gpio102";
+			function = "gpio";
+
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		clkreq-pins {
+			pins = "gpio103";
+			function = "pci_e1";
+			bias-pull-up;
+		};
+
+		wake-n-pins {
+			pins = "gpio11";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		reset-n-pins {
+			pins = "gpio75";
+			function = "gpio";
+
+			drive-strength = <16>;
+			bias-pull-up;
+			output-high;
+		};
+	};
+
+	sdc2_default_state: sdc2-default-state {
+		clk-pins {
+			pins = "sdc2_clk";
+			bias-disable;
+
+			/*
+			 * It seems that mmc_test reports errors if drive
+			 * strength is not 16 on clk, cmd, and data pins.
+			 */
+			drive-strength = <16>;
+		};
+
+		cmd-pins {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		data-pins {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio126";
+		function = "gpio";
+		bias-pull-up;
+	};
+};
+
+&uart3 {
+	label = "LS-UART0";
+	pinctrl-0 = <&qup_uart3_4pin>;
+
+	status = "disabled";
+};
+
+&uart6 {
+	status = "okay";
+
+	pinctrl-0 = <&qup_uart6_4pin>;
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&uart9 {
+	label = "LS-UART1";
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l26a_1p2>;
+	vdda-pll-supply = <&vreg_l1a_0p875>;
+};
+
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_2_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
+};
+
+&usb_2_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l26a_1p2>;
+	vdda-pll-supply = <&vreg_l1a_0p875>;
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <800000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
+&venus {
+	status = "okay";
+};
+
+&wcd9340 {
+	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+
+	swm: swm@c85 {
+		left_spkr: speaker@0,1 {
+			compatible = "sdw10217201000";
+			reg = <0 1>;
+			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
+			#thermal-sensor-cells = <0>;
+			sound-name-prefix = "SpkrLeft";
+			#sound-dai-cells = <0>;
+		};
+
+		right_spkr: speaker@0,2 {
+			compatible = "sdw10217201000";
+			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
+			reg = <0 2>;
+			#thermal-sensor-cells = <0>;
+			sound-name-prefix = "SpkrRight";
+			#sound-dai-cells = <0>;
+		};
+	};
+};
+
+&wifi {
+	status = "okay";
+
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	qcom,snoc-host-cap-8bit-quirk;
+	qcom,ath10k-calibration-variant = "Thundercomm_DB845C";
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+&qup_spi2_default {
+	drive-strength = <16>;
+};
+
+&qup_i2c10_default {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart9_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
+&qup_uart9_tx {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+&qup_spi0_default {
+	drive-strength = <6>;
+	bias-disable;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-headless.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c-headless.dts
new file mode 100644
index 000000000000..22cf637b2fcb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-headless.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-db845c-common.dtsi"
+
+&mdss {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index ecc4a851e29c..2a9fe0119176 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -5,1174 +5,14 @@
 
 /dts-v1/;
 
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/sound/qcom,q6afe.h>
-#include <dt-bindings/sound/qcom,q6asm.h>
-#include "sdm845.dtsi"
-#include "sdm845-wcd9340.dtsi"
-#include "pm8998.dtsi"
-#include "pmi8998.dtsi"
+#include "sdm845-db845c-common.dtsi"
 
 / {
-	model = "Thundercomm Dragonboard 845c";
-	compatible = "thundercomm,db845c", "qcom,sdm845";
-	qcom,msm-id = <341 0x20001>;
-	qcom,board-id = <8 0>;
-
-	aliases {
-		serial0 = &uart9;
-		serial1 = &uart6;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	/* Fixed crystal oscillator dedicated to MCP2517FD */
-	clk40M: can-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <40000000>;
-	};
-
-	dc12v: dc12v-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "DC12V";
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-		regulator-always-on;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&vol_up_pin_a>;
-
-		key-vol-up {
-			label = "Volume Up";
-			linux,code = <KEY_VOLUMEUP>;
-			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "green:user4";
-			function = LED_FUNCTION_INDICATOR;
-			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&pm8998_gpios 13 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "panic-indicator";
-			default-state = "off";
-		};
-
-		led-1 {
-			label = "yellow:wlan";
-			function = LED_FUNCTION_WLAN;
-			color = <LED_COLOR_ID_YELLOW>;
-			gpios = <&pm8998_gpios 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx";
-			default-state = "off";
-		};
-
-		led-2 {
-			label = "blue:bt";
-			function = LED_FUNCTION_BLUETOOTH;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bluetooth-power";
-			default-state = "off";
-		};
-	};
-
-	hdmi-out {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con: endpoint {
-				remote-endpoint = <&lt9611_out>;
-			};
+	reserved-memory {
+		/* Cont splash region set up by the bootloader */
+		cont_splash_mem: framebuffer@9d400000 {
+			reg = <0x0 0x9d400000 0x0 0x2400000>;
+			no-map;
 		};
 	};
-
-	lt9611_1v8: lt9611-vdd18-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "LT9611_1V8";
-
-		vin-supply = <&vdc_5v>;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-
-		gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	lt9611_3v3: lt9611-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "LT9611_3V3";
-
-		vin-supply = <&vdc_3v3>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		/*
-		 * TODO: make it possible to drive same GPIO from two clients
-		 * gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
-		 * enable-active-high;
-		 */
-	};
-
-	pcie0_1p05v: pcie-0-1p05v-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "PCIE0_1.05V";
-
-		vin-supply = <&vbat>;
-		regulator-min-microvolt = <1050000>;
-		regulator-max-microvolt = <1050000>;
-
-		/*
-		 * TODO: make it possible to drive same GPIO from two clients
-		 * gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
-		 * enable-active-high;
-		 */
-	};
-
-	cam0_dvdd_1v2: cam0-dvdd-1v2-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "CAM0_DVDD_1V2";
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-		enable-active-high;
-		gpio = <&pm8998_gpios 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cam0_dvdd_1v2_en_default>;
-		vin-supply = <&vbat>;
-	};
-
-	cam0_avdd_2v8: cam0-avdd-2v8-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "CAM0_AVDD_2V8";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		enable-active-high;
-		gpio = <&pm8998_gpios 10 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cam0_avdd_2v8_en_default>;
-		vin-supply = <&vbat>;
-	};
-
-	/* This regulator is enabled when the VREG_LVS1A_1P8 trace is enabled */
-	cam3_avdd_2v8: cam3-avdd-2v8-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "CAM3_AVDD_2V8";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-		vin-supply = <&vbat>;
-	};
-
-	pcie0_3p3v_dual: vldo-3v3-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "VLDO_3V3";
-
-		vin-supply = <&vbat>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie0_pwren_state>;
-	};
-
-	v5p0_hdmiout: v5p0-hdmiout-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "V5P0_HDMIOUT";
-
-		vin-supply = <&vdc_5v>;
-		regulator-min-microvolt = <500000>;
-		regulator-max-microvolt = <500000>;
-
-		/*
-		 * TODO: make it possible to drive same GPIO from two clients
-		 * gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
-		 * enable-active-high;
-		 */
-	};
-
-	vbat: vbat-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "VBAT";
-
-		vin-supply = <&dc12v>;
-		regulator-min-microvolt = <4200000>;
-		regulator-max-microvolt = <4200000>;
-		regulator-always-on;
-	};
-
-	vbat_som: vbat-som-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "VBAT_SOM";
-
-		vin-supply = <&dc12v>;
-		regulator-min-microvolt = <4200000>;
-		regulator-max-microvolt = <4200000>;
-		regulator-always-on;
-	};
-
-	vdc_3v3: vdc-3v3-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "VDC_3V3";
-		vin-supply = <&dc12v>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	vdc_5v: vdc-5v-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "VDC_5V";
-
-		vin-supply = <&dc12v>;
-		regulator-min-microvolt = <500000>;
-		regulator-max-microvolt = <500000>;
-		regulator-always-on;
-	};
-
-	vreg_s4a_1p8: vreg-s4a-1p8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vreg_s4a_1p8";
-
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
-	vph_pwr: vph-pwr-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vph_pwr";
-
-		vin-supply = <&vbat_som>;
-	};
-};
-
-&adsp_pas {
-	status = "okay";
-
-	firmware-name = "qcom/sdm845/adsp.mbn";
-};
-
-&apps_rsc {
-	regulators-0 {
-		compatible = "qcom,pm8998-rpmh-regulators";
-		qcom,pmic-id = "a";
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-		vdd-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-		vdd-s6-supply = <&vph_pwr>;
-		vdd-s7-supply = <&vph_pwr>;
-		vdd-s8-supply = <&vph_pwr>;
-		vdd-s9-supply = <&vph_pwr>;
-		vdd-s10-supply = <&vph_pwr>;
-		vdd-s11-supply = <&vph_pwr>;
-		vdd-s12-supply = <&vph_pwr>;
-		vdd-s13-supply = <&vph_pwr>;
-		vdd-l1-l27-supply = <&vreg_s7a_1p025>;
-		vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
-		vdd-l3-l11-supply = <&vreg_s7a_1p025>;
-		vdd-l4-l5-supply = <&vreg_s7a_1p025>;
-		vdd-l6-supply = <&vph_pwr>;
-		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
-		vdd-l9-supply = <&vreg_bob>;
-		vdd-l10-l23-l25-supply = <&vreg_bob>;
-		vdd-l13-l19-l21-supply = <&vreg_bob>;
-		vdd-l16-l28-supply = <&vreg_bob>;
-		vdd-l18-l22-supply = <&vreg_bob>;
-		vdd-l20-l24-supply = <&vreg_bob>;
-		vdd-l26-supply = <&vreg_s3a_1p35>;
-		vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
-
-		vreg_lvs1a_1p8: lvs1 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		vreg_lvs2a_1p8: lvs2 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		vreg_s3a_1p35: smps3 {
-			regulator-min-microvolt = <1352000>;
-			regulator-max-microvolt = <1352000>;
-		};
-
-		vreg_s5a_2p04: smps5 {
-			regulator-min-microvolt = <1904000>;
-			regulator-max-microvolt = <2040000>;
-		};
-
-		vreg_s7a_1p025: smps7 {
-			regulator-min-microvolt = <900000>;
-			regulator-max-microvolt = <1028000>;
-		};
-
-		vreg_l1a_0p875: ldo1 {
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l5a_0p8: ldo5 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l12a_1p8: ldo12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l7a_1p8: ldo7 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l13a_2p95: ldo13 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l17a_1p3: ldo17 {
-			regulator-min-microvolt = <1304000>;
-			regulator-max-microvolt = <1304000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l20a_2p95: ldo20 {
-			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <2968000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l21a_2p95: ldo21 {
-			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <2968000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l24a_3p075: ldo24 {
-			regulator-min-microvolt = <3088000>;
-			regulator-max-microvolt = <3088000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l25a_3p3: ldo25 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3312000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l26a_1p2: ldo26 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-	};
-
-	regulators-1 {
-		compatible = "qcom,pmi8998-rpmh-regulators";
-		qcom,pmic-id = "b";
-
-		vdd-bob-supply = <&vph_pwr>;
-
-		vreg_bob: bob {
-			regulator-min-microvolt = <3312000>;
-			regulator-max-microvolt = <3600000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
-			regulator-allow-bypass;
-		};
-	};
-};
-
-&cdsp_pas {
-	status = "okay";
-	firmware-name = "qcom/sdm845/cdsp.mbn";
-};
-
-&dsi0 {
-	status = "okay";
-	vdda-supply = <&vreg_l26a_1p2>;
-
-	qcom,dual-dsi-mode;
-	qcom,master-dsi;
-
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
-};
-
-&dsi0_phy {
-	status = "okay";
-	vdds-supply = <&vreg_l1a_0p875>;
-};
-
-&dsi1 {
-	vdda-supply = <&vreg_l26a_1p2>;
-
-	qcom,dual-dsi-mode;
-
-	/* DSI1 is slave, so use DSI0 clocks */
-	assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
-
-	status = "okay";
-
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_b>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
-};
-
-&dsi1_phy {
-	vdds-supply = <&vreg_l1a_0p875>;
-	status = "okay";
-};
-
-&gcc {
-	protected-clocks = <GCC_QSPI_CORE_CLK>,
-			   <GCC_QSPI_CORE_CLK_SRC>,
-			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
-			   <GCC_LPASS_Q6_AXI_CLK>,
-			   <GCC_LPASS_SWAY_CLK>;
-};
-
-&gmu {
-	status = "okay";
-};
-
-&gpi_dma0 {
-	status = "okay";
-};
-
-&gpi_dma1 {
-	status = "okay";
-};
-
-&gpu {
-	status = "okay";
-	zap-shader {
-		memory-region = <&gpu_mem>;
-		firmware-name = "qcom/sdm845/a630_zap.mbn";
-	};
-};
-
-&i2c10 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	lt9611_codec: hdmi-bridge@3b {
-		compatible = "lontium,lt9611";
-		reg = <0x3b>;
-		#sound-dai-cells = <1>;
-
-		interrupts-extended = <&tlmm 84 IRQ_TYPE_EDGE_FALLING>;
-
-		reset-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
-
-		vdd-supply = <&lt9611_1v8>;
-		vcc-supply = <&lt9611_3v3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&lt9611_irq_pin>, <&dsi_sw_sel>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				lt9611_a: endpoint {
-					remote-endpoint = <&dsi0_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				lt9611_b: endpoint {
-					remote-endpoint = <&dsi1_out>;
-				};
-			};
-
-			port@2 {
-				reg = <2>;
-
-				lt9611_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
-};
-
-&i2c11 {
-	/* On Low speed expansion */
-	clock-frequency = <100000>;
-	status = "okay";
-};
-
-&i2c14 {
-	/* On Low speed expansion */
-	clock-frequency = <100000>;
-	status = "okay";
-};
-
-&mdss {
-	status = "okay";
-};
-
-&mss_pil {
-	status = "okay";
-	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mbn";
-};
-
-&pcie0 {
-	status = "okay";
-	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
-	enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
-
-	vddpe-3v3-supply = <&pcie0_3p3v_dual>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie0_default_state>;
-};
-
-&pcie0_phy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l26a_1p2>;
-};
-
-&pcie1 {
-	status = "okay";
-	perst-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie1_default_state>;
-};
-
-&pcie1_phy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l26a_1p2>;
-};
-
-&pm8998_gpios {
-	gpio-line-names =
-		"NC",
-		"NC",
-		"WLAN_SW_CTRL",
-		"NC",
-		"PM_GPIO5_BLUE_BT_LED",
-		"VOL_UP_N",
-		"NC",
-		"ADC_IN1",
-		"PM_GPIO9_YEL_WIFI_LED",
-		"CAM0_AVDD_EN",
-		"NC",
-		"CAM0_DVDD_EN",
-		"PM_GPIO13_GREEN_U4_LED",
-		"DIV_CLK2",
-		"NC",
-		"NC",
-		"NC",
-		"SMB_STAT",
-		"NC",
-		"NC",
-		"ADC_IN2",
-		"OPTION1",
-		"WCSS_PWR_REQ",
-		"PM845_GPIO24",
-		"OPTION2",
-		"PM845_SLB";
-
-	cam0_dvdd_1v2_en_default: cam0-dvdd-1v2-en-state {
-		pins = "gpio12";
-		function = "normal";
-
-		bias-pull-up;
-		drive-push-pull;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
-	};
-
-	cam0_avdd_2v8_en_default: cam0-avdd-2v8-en-state {
-		pins = "gpio10";
-		function = "normal";
-
-		bias-pull-up;
-		drive-push-pull;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
-	};
-
-	vol_up_pin_a: vol-up-active-state {
-		pins = "gpio6";
-		function = "normal";
-		input-enable;
-		bias-pull-up;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-	};
-};
-
-&pm8998_resin {
-	linux,code = <KEY_VOLUMEDOWN>;
-	status = "okay";
-};
-
-&pmi8998_lpg {
-	status = "okay";
-
-	qcom,power-source = <1>;
-
-	led@3 {
-		reg = <3>;
-		color = <LED_COLOR_ID_GREEN>;
-		function = LED_FUNCTION_HEARTBEAT;
-		function-enumerator = <3>;
-
-		linux,default-trigger = "heartbeat";
-		default-state = "on";
-	};
-
-	led@4 {
-		reg = <4>;
-		color = <LED_COLOR_ID_GREEN>;
-		function = LED_FUNCTION_INDICATOR;
-		function-enumerator = <2>;
-	};
-
-	led@5 {
-		reg = <5>;
-		color = <LED_COLOR_ID_GREEN>;
-		function = LED_FUNCTION_INDICATOR;
-		function-enumerator = <1>;
-	};
-};
-
-&pmi8998_rradc {
-	status = "okay";
-};
-
-/* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
-&q6afedai {
-	dai@22 {
-		reg = <QUATERNARY_MI2S_RX>;
-		qcom,sd-lines = <0 1 2 3>;
-	};
-};
-
-&q6asmdai {
-	dai@0 {
-		reg = <0>;
-	};
-
-	dai@1 {
-		reg = <1>;
-	};
-
-	dai@2 {
-		reg = <2>;
-	};
-
-	dai@3 {
-		reg = <3>;
-		direction = <2>;
-		is-compress-dai;
-	};
-};
-
-&qupv3_id_0 {
-	status = "okay";
-};
-
-&qupv3_id_1 {
-	status = "okay";
-};
-
-&sdhc_2 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
-
-	vmmc-supply = <&vreg_l21a_2p95>;
-	vqmmc-supply = <&vreg_l13a_2p95>;
-
-	bus-width = <4>;
-	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
-};
-
-&sound {
-	compatible = "qcom,db845c-sndcard", "qcom,sdm845-sndcard";
-	pinctrl-0 = <&quat_mi2s_active
-			 &quat_mi2s_sd0_active
-			 &quat_mi2s_sd1_active
-			 &quat_mi2s_sd2_active
-			 &quat_mi2s_sd3_active>;
-	pinctrl-names = "default";
-	model = "DB845c";
-	audio-routing =
-		"RX_BIAS", "MCLK",
-		"AMIC1", "MIC BIAS1",
-		"AMIC2", "MIC BIAS2",
-		"DMIC0", "MIC BIAS1",
-		"DMIC1", "MIC BIAS1",
-		"DMIC2", "MIC BIAS3",
-		"DMIC3", "MIC BIAS3",
-		"SpkrLeft IN", "SPK1 OUT",
-		"SpkrRight IN", "SPK2 OUT",
-		"MM_DL1",  "MultiMedia1 Playback",
-		"MM_DL2",  "MultiMedia2 Playback",
-		"MM_DL4",  "MultiMedia4 Playback",
-		"MultiMedia3 Capture", "MM_UL3";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
-
-	mm4-dai-link {
-		link-name = "MultiMedia4";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA4>;
-		};
-	};
-
-	hdmi-dai-link {
-		link-name = "HDMI Playback";
-		cpu {
-			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&lt9611_codec 0>;
-		};
-	};
-
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 1>;
-		};
-	};
-};
-
-&spi0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qup_spi0_default>;
-	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
-
-	can@0 {
-		compatible = "microchip,mcp2517fd";
-		reg = <0>;
-		clocks = <&clk40M>;
-		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
-		spi-max-frequency = <10000000>;
-		vdd-supply = <&vdc_5v>;
-		xceiver-supply = <&vdc_5v>;
-	};
-};
-
-&spi2 {
-	/* On Low speed expansion */
-	status = "okay";
-};
-
-&tlmm {
-	cam0_default: cam0-default-state {
-		rst-pins {
-			pins = "gpio9";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-
-		mclk0-pins {
-			pins = "gpio13";
-			function = "cam_mclk";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-
-	cam3_default: cam3-default-state {
-		rst-pins {
-			function = "gpio";
-			pins = "gpio21";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-
-		mclk3-pins {
-			function = "cam_mclk";
-			pins = "gpio16";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-
-	dsi_sw_sel: dsi-sw-sel-state {
-		pins = "gpio120";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-		output-high;
-	};
-
-	lt9611_irq_pin: lt9611-irq-state {
-		pins = "gpio84";
-		function = "gpio";
-		bias-disable;
-	};
-
-	pcie0_default_state: pcie0-default-state {
-		clkreq-pins {
-			pins = "gpio36";
-			function = "pci_e0";
-			bias-pull-up;
-		};
-
-		reset-n-pins {
-			pins = "gpio35";
-			function = "gpio";
-
-			drive-strength = <2>;
-			output-low;
-			bias-pull-down;
-		};
-
-		wake-n-pins {
-			pins = "gpio37";
-			function = "gpio";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-	};
-
-	pcie0_pwren_state: pcie0-pwren-state {
-		pins = "gpio90";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	pcie1_default_state: pcie1-default-state {
-		perst-n-pins {
-			pins = "gpio102";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-
-		clkreq-pins {
-			pins = "gpio103";
-			function = "pci_e1";
-			bias-pull-up;
-		};
-
-		wake-n-pins {
-			pins = "gpio11";
-			function = "gpio";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		reset-n-pins {
-			pins = "gpio75";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-pull-up;
-			output-high;
-		};
-	};
-
-	sdc2_default_state: sdc2-default-state {
-		clk-pins {
-			pins = "sdc2_clk";
-			bias-disable;
-
-			/*
-			 * It seems that mmc_test reports errors if drive
-			 * strength is not 16 on clk, cmd, and data pins.
-			 */
-			drive-strength = <16>;
-		};
-
-		cmd-pins {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-
-		data-pins {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-	};
-
-	sdc2_card_det_n: sd-card-det-n-state {
-		pins = "gpio126";
-		function = "gpio";
-		bias-pull-up;
-	};
-};
-
-&uart3 {
-	label = "LS-UART0";
-	pinctrl-0 = <&qup_uart3_4pin>;
-
-	status = "disabled";
-};
-
-&uart6 {
-	status = "okay";
-
-	pinctrl-0 = <&qup_uart6_4pin>;
-
-	bluetooth {
-		compatible = "qcom,wcn3990-bt";
-
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
-		max-speed = <3200000>;
-	};
-};
-
-&uart9 {
-	label = "LS-UART1";
-	status = "okay";
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
-};
-
-&usb_1_hsphy {
-	status = "okay";
-
-	vdd-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
-
-	qcom,imp-res-offset-value = <8>;
-	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
-	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
-	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
-};
-
-&usb_1_qmpphy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l26a_1p2>;
-	vdda-pll-supply = <&vreg_l1a_0p875>;
-};
-
-&usb_2 {
-	status = "okay";
-};
-
-&usb_2_dwc3 {
-	dr_mode = "host";
-};
-
-&usb_2_hsphy {
-	status = "okay";
-
-	vdd-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
-
-	qcom,imp-res-offset-value = <8>;
-	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
-};
-
-&usb_2_qmpphy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l26a_1p2>;
-	vdda-pll-supply = <&vreg_l1a_0p875>;
-};
-
-&ufs_mem_hc {
-	status = "okay";
-
-	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l20a_2p95>;
-	vcc-max-microamp = <800000>;
-};
-
-&ufs_mem_phy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l26a_1p2>;
-};
-
-&venus {
-	status = "okay";
-};
-
-&wcd9340 {
-	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
-	vdd-buck-supply = <&vreg_s4a_1p8>;
-	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-	vdd-tx-supply = <&vreg_s4a_1p8>;
-	vdd-rx-supply = <&vreg_s4a_1p8>;
-	vdd-io-supply = <&vreg_s4a_1p8>;
-
-	swm: swm@c85 {
-		left_spkr: speaker@0,1 {
-			compatible = "sdw10217201000";
-			reg = <0 1>;
-			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
-			#thermal-sensor-cells = <0>;
-			sound-name-prefix = "SpkrLeft";
-			#sound-dai-cells = <0>;
-		};
-
-		right_spkr: speaker@0,2 {
-			compatible = "sdw10217201000";
-			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
-			reg = <0 2>;
-			#thermal-sensor-cells = <0>;
-			sound-name-prefix = "SpkrRight";
-			#sound-dai-cells = <0>;
-		};
-	};
-};
-
-&wifi {
-	status = "okay";
-
-	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-
-	qcom,snoc-host-cap-8bit-quirk;
-	qcom,ath10k-calibration-variant = "Thundercomm_DB845C";
-};
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-&qup_spi2_default {
-	drive-strength = <16>;
-};
-
-&qup_i2c10_default {
-	drive-strength = <2>;
-	bias-disable;
-};
-
-&qup_uart9_rx {
-	drive-strength = <2>;
-	bias-pull-up;
-};
-
-&qup_uart9_tx {
-	drive-strength = <2>;
-	bias-disable;
-};
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-&qup_spi0_default {
-	drive-strength = <6>;
-	bias-disable;
 };
-- 
2.25.1

