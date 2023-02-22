Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF5A69F402
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBVMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjBVMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:05:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3538B6A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:04:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3-20020a05600c358300b003e206711347so5216130wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/NKAfflQl/jyYjx4Ez6hYiZ6cPOKxCvhtzlfKNfvOQ=;
        b=uYM69N337V4FU35NL8AtsHRt0LJbCjz5DCbzXcswDNDxEVNcMLvs+KMOWxWAUXP9j9
         RWxQ08RBPtULvV0o/SB92LGCO2xZQ70BPOiLsN812QVuULah9SG5iGp6DS0w0Afn4AIV
         VOaRK6Gr/DISHeXw9YeYScWRtTZLvPzfnLhZt77GEORu7W/Ziflo3aCwsLkAMn7hu7Bp
         +Mzq3WNJFxj3aODF8guACejgB6K5T2BeKqs0FoZFaQ3FZievgoy6rFm8NNM2B3MQnrgK
         9i2e4ENpMJ1U6hRf9tp2zgdTadAitL3nuyRONBjbC2cYdTRlsN0B0HFnZeJr/HXJwSbS
         ncTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/NKAfflQl/jyYjx4Ez6hYiZ6cPOKxCvhtzlfKNfvOQ=;
        b=gUcvzAVCKFE0pKC4lSQhX28mG8PQIGOgbdjoB1Eokl8TB8u/tiF4vjlipYoPRYuEIC
         GF86Zsgo+3WxvzzNKjJf25+xaTB/yAOoevCZIEzkGVoCwDMeWp8OEbR4VcVWUygCzXJu
         XRy6Ji3JMYmHMr8pB26znPuw1+LVbL5VTFMVGWY6WqebHEq0cUq0wwcsbg+7euvRzKPC
         bjE/iBWRQ8hqgOM/vg2f4PkT2MMOBwRnxWgdABMtx6tLM8HA9IWaQE8aueQuD1gov2ZX
         RtJ/emQx7LZUR8PiZUb8efeaDVW45K+6pZYaUIRNeDSq2YFHS86iQV6z0Ygk9t1RXtpc
         Ce/A==
X-Gm-Message-State: AO0yUKVamYAk3RYOevtidG/Mw/rcrsakJUFQJd5CKV5KcnDsIZRlQvbH
        DNtXroJxZNRqVuI+b3wFGvtLng==
X-Google-Smtp-Source: AK7set+e/f+BD5zyqqo/TpDlJ6TE7zUgLxetqcXzcGXx0T7oaLJ/3i4UPG4pM5iITpxNiDrZkvLI9A==
X-Received: by 2002:a05:600c:3316:b0:3dc:42e7:f626 with SMTP id q22-20020a05600c331600b003dc42e7f626mr5380025wmp.26.1677067461168;
        Wed, 22 Feb 2023 04:04:21 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003e21dcccf9fsm8447722wms.16.2023.02.22.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:04:20 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
Subject: [PATCH v6 4/5] arm64: dts: qcom: Add Square apq8039-t2 board
Date:   Wed, 22 Feb 2023 12:04:10 +0000
Message-Id: <20230222120411.55197-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
chipset.

Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Co-developed-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
Co-developed-by: Benjamin Li <benl@squareup.com>
Signed-off-by: Benjamin Li <benl@squareup.com>
Co-developed-by: James Willcox <jwillcox@squareup.com>
Signed-off-by: James Willcox <jwillcox@squareup.com>
Co-developed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Co-developed-by: Joseph Gates <jgates@squareup.com>
Signed-off-by: Joseph Gates <jgates@squareup.com>
Co-developed-by: Max Chen <mchen@squareup.com>
Signed-off-by: Max Chen <mchen@squareup.com>
Co-developed-by: Zac Crosby <zac@squareup.com>
Signed-off-by: Zac Crosby <zac@squareup.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |   1 +
 arch/arm64/boot/dts/qcom/apq8039-t2.dts | 550 ++++++++++++++++++++++++
 2 files changed, 551 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 31aa54f0428c3..2983e83a19061 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
new file mode 100644
index 0000000000000..6ff044bfe2ebc
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020-2023, Linaro Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "msm8939.dtsi"
+#include "msm8939-pm8916.dtsi"
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
+
+/ {
+	model = "Square, Inc. T2 Devkit";
+	compatible = "square,apq8039-t2", "qcom,msm8939";
+
+	qcom,board-id = <0x53 0x54>;
+	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>, <QCOM_ID_APQ8039 0x30000>;
+
+	aliases {
+		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
+		serial0 = &blsp1_uart1;
+		serial1 = &blsp1_uart2;
+	};
+
+	bl: backlight {
+		compatible = "gpio-backlight";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pinctrl-names = "default";
+		gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	vreg_lcd_avdd_reg: lcd-avdd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_avdd";
+		regulator-min-microvolt = <5600000>;
+		regulator-max-microvolt = <5600000>;
+		pinctrl-0 = <&pinctrl_lcd_avdd_reg>;
+		pinctrl-names = "default";
+		gpio = <&tlmm 86 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <300>;
+		enable-active-high;
+	};
+
+	vreg_lcd_avee_reg: lcd-avee-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_avee";
+		regulator-min-microvolt = <5600000>;
+		regulator-max-microvolt = <5600000>;
+		pinctrl-0 = <&pinctrl_lcd_avee_reg>;
+		pinctrl-names = "default";
+		gpio = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <300>;
+		enable-active-high;
+	};
+
+	vreg_lcd_iovcc_reg: lcd-iovcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_iovcc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&pinctrl_lcd_iovcc_reg>;
+		pinctrl-names = "default";
+		gpio = <&tlmm 9 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <300>;
+		enable-active-high;
+	};
+
+	vreg_pp_crq_3v3_reg: pp-crq-3v3-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&tlmm_crq_reg>;
+		pinctrl-names = "default";
+		regulator-name = "pp_crq_3v3";
+		gpio = <&tlmm 12 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <0>;
+		enable-active-high;
+	};
+
+	vreg_pp_spe_3v3_reg: pp-spe-3v3-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&tlmm_spe_reg>;
+		pinctrl-names = "default";
+		regulator-name = "pp_spe_3v3";
+		gpio = <&tlmm 108 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <0>;
+		enable-active-high;
+	};
+};
+
+&blsp_i2c1 {
+	status = "okay";
+};
+
+&blsp_i2c2 {
+	status = "okay";
+};
+
+&blsp_i2c3 {
+	status = "okay";
+
+	typec_pd: usb-pd@38 {
+		compatible = "ti,tps6598x";
+		reg = <0x38>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <107 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec_irq>;
+
+		typec_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+
+			port {
+				typec_ep: endpoint {
+					remote-endpoint = <&otg_ep>;
+				};
+			};
+		};
+	};
+};
+
+&blsp_i2c5 {
+	status = "okay";
+};
+
+&blsp1_uart1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp1_uart1_default>;
+	pinctrl-1 = <&blsp1_uart1_sleep>;
+	status = "okay";
+};
+
+&blsp1_uart2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp1_uart2_default>;
+	pinctrl-1 = <&blsp1_uart2_sleep>;
+	status = "okay";
+};
+
+&lpass {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&pm8916_gpios {
+	gpio-line-names =
+		"PM_GPIO1",     /* WIFI_GPIO1_PRE */
+		"PM_GPIO2",     /* WIFI_GPIO2_PRE */
+		"PM_GPIO3",
+		"PM_GPIO4";
+};
+
+&pronto {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wcnss_pin_a>;
+	status = "okay";
+
+	iris {
+		compatible = "qcom,wcn3680";
+	};
+};
+
+&smd_rpm_regulators {
+	vdd_l1_l2_l3-supply = <&pm8916_s3>;
+	vdd_l4_l5_l6-supply = <&pm8916_s4>;
+	vdd_l7-supply = <&pm8916_s4>;
+
+	pm8916_s3: s3 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1300000>;
+	};
+
+	pm8916_s4: s4 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2100000>;
+	};
+
+	/* l1 is fixed to 1225000, but not connected in schematic */
+
+	pm8916_l2: l2 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	pm8916_l4: l4 {
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
+	};
+
+	pm8916_l5: l5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l6: l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l7: l7 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l8: l8 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	pm8916_l9: l9 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l10: l10 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l11: l11 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	pm8916_l12: l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	pm8916_l13: l13 {
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
+	};
+
+	pm8916_l14: l14 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l15: l15 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+
+	pm8916_l18: l18 {
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+	};
+};
+
+&sdhc_1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_default_state>;
+	pinctrl-1 = <&sdc1_sleep_state>;
+	status = "okay";
+};
+
+&sound {
+	model = "apq8039-square-sndcard";
+	audio-routing = "AMIC2", "MIC BIAS Internal2";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cdc_pdm_lines_default>;
+	pinctrl-1 = <&cdc_pdm_lines_sleep>;
+
+	internal-codec-playback-dai-link {
+		link-name = "WCD";
+		cpu {
+			sound-dai = <&lpass MI2S_PRIMARY>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+		};
+	};
+
+	internal-codec-capture-dai-link {
+		link-name = "WCD-Capture";
+		cpu {
+			sound-dai = <&lpass MI2S_TERTIARY>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+		};
+	};
+};
+
+/*
+ * Line names are taken from the schematic of T2, Ver X03.
+ * July 14, 2018. Page 4 in particular.
+ */
+&tlmm {
+	gpio-line-names =
+		"APQ_UART1_TX",		/* GPIO_0 */
+		"APQ_UART1_RX",
+		"APQ_I2C1_SDA",
+		"APQ_I2C1_SCL",
+		"APQ_UART2_TX_1V8",
+		"APQ_UART2_RX_1V8",
+		"APQ_I2C2_SDA",
+		"APQ_I2C2_SCL",
+		"NC",
+		"APQ_LCD_IOVCC_EN",
+		"APQ_I2C3_SDA",		/* GPIO_10 */
+		"APQ_I2C3_SCL",
+		"TOUCH_RST_1V8_L",
+		"NC",
+		"APQ_I2C4_SDA",
+		"APQ_I2C4_SCL",
+		"APQ_ID5",
+		"USB_DISCONNECT",
+		"APQ_I2C5_SDA",
+		"APQ_I2C5_SCL",
+		"APQ_USBC_SPI_MOSI",	/* GPIO_20 */
+		"APQ_USBC_SPI_MISO",
+		"APQ_USBC_SPI_SS_L",
+		"APQ_USBC_SPI_CLK",
+		"APQ_LCD_TE0",
+		"APQ_LCD_RST_L",
+		"NC",
+		"NC",
+		"ACCELEROMETER_INT1",
+		"APQ_CAM_I2C0_SDA",
+		"APQ_CAM_I2C0_SCL",	/* GPIO_30 */
+		"ACCELEROMETER_INT2",
+		"NC",
+		"NC",
+		"NC",
+		"APQ_K21_RST_1V8_L",
+		"NC",
+		"APQ_EDL_1V8",
+		"TP145",
+		"BT_SSBI",
+		"NC",			/* GPIO_40 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"BT_CTRL",
+		"BT_DAT",
+		"PWR_GPIO_IN",
+		"PWR_GPIO_OUT",		/* GPIO_50 */
+		"CARD_DET_MLB_L",
+		"HALL_SENSOR",
+		"TP63",
+		"TP64",
+		"TP65",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",			/* GPIO_60 */
+		"NC",
+		"APQ_K21_GPIO0_1V8",
+		"CDC_PDM_CLK",
+		"CDC_PDM_SYNC",
+		"CDC_PDM_TX",
+		"CDC_PDM_RX0",
+		"CDC_PDM_RX1",
+		"CDC_PDM_RX2",
+		"APQ_K21_GPIO1_1V8",
+		"NC",			/* GPIO_70 */
+		"APQ_HUB_SEL_1V8",
+		"APQ_K21_GPIO2_1V8",
+		"APQ_K21_GPIO3_1V8",
+		"APQ_ID0",
+		"APQ_ID1",
+		"APQ_ID2",
+		"APQ_ID3",
+		"APQ_ID4",
+		"APQ_HUB_SUSP_IND",
+		"BOOT_CONFIG_0",	/* GPIO_80 */
+		"BOOT_CONFIG_1",
+		"BOOT_CONFIG_2",
+		"BOOT_CONFIG_3",
+		"NC",
+		"NC",
+		"APQ_LCD_AVDD_EN",
+		"APQ_LCD_AVEE_EN",
+		"TP70",
+		"NC",
+		"APQ_DEBUG0",		/* GPIO_90 */
+		"APQ_DEBUG1",
+		"APQ_DEBUG2",
+		"APQ_DEBUG3",
+		"TP165",
+		"NC",
+		"APQ_LNA_PWR_EN",
+		"NC",
+		"APQ_LCD_BL_EN",
+		"NC",
+		"APQ_LCD_ID0",		/* GPIO_100 */
+		"APQ_LCD_ID1",
+		"USBC_GPIO5_1V8",
+		"NC",
+		"NC",
+		"NC",
+		"APQ_HUB_RST_1V8_L",
+		"USBC_I2C_IRQ_1V8_L",
+		"SPE_PWR_EN",
+		"NC",
+		"APQ_USB_ID",		/* GPIO_110 */
+		"APQ_EXT_BUCK_VSEL",
+		"APQ_USB_ID_OUT",
+		"NC",
+		"PRNT_RST_L",
+		"APQ_CRQ_I2C_RDY_1V8",
+		"TYPEC_RST_1V8_H",
+		"CHG_BACKPWR_EN",
+		"CHG_PROCHOT_L",
+		"NC",
+		"USBC_GPIO7_1V8",	/* GPIO_120 */
+		"NC";
+
+	blsp1_uart1_default: blsp1-uart1-default-state {
+		pins = "gpio0", "gpio1";
+		function = "blsp_uart1";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
+		pins = "gpio0", "gpio1";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ext_buck_vsel_reg: ext-buck-vsel-reg-state {
+		function = "gpio";
+		pins = "gpio111";
+		drive-strength = <2>;
+	};
+
+	pinctrl_backlight: backlight-state {
+		pins = "gpio98";
+		function = "gpio";
+	};
+
+	pinctrl_lcd_avdd_reg: lcd-avdd-reg-state {
+		pins = "gpio86";
+		function = "gpio";
+	};
+
+	pinctrl_lcd_avee_reg: lcd-avee-reg-state {
+		pins = "gpio87";
+		function = "gpio";
+	};
+
+	pinctrl_lcd_iovcc_reg: lcd-iovcc-reg-state {
+		pins = "gpio9";
+		function = "gpio";
+	};
+
+	pinctrl_lcd_rst: lcd-rst-state {
+		pins = "gpio25";
+		function = "gpio";
+	};
+
+	pinctrl_otg_default: otg-default-state {
+		function = "gpio";
+		pins = "gpio17";
+		output-high;
+	};
+
+	pinctrl_otg_device: otg-device-state {
+		function = "gpio";
+		pins = "gpio17";
+		output-low;
+	};
+
+	pinctrl_otg_host: otg-host-state {
+		function = "gpio";
+		pins = "gpio17";
+		output-low;
+	};
+
+	sq_spe_enable: sq-spe-enable-state {
+		pins = "gpio35";
+		function = "gpio";
+		output-low;
+	};
+
+	tlmm_crq_reg: tlmm-crq-reg-state {
+		function = "gpio";
+		pins = "gpio12";
+		output-high;
+	};
+
+	tlmm_spe_reg: tlmm-spe-reg-state {
+		pins = "gpio108";
+		function = "gpio";
+		output-high;
+	};
+
+	typec_irq: typec-irq-state {
+		function = "gpio";
+		pins = "gpio107";
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&usb {
+	pinctrl-names = "default", "host", "device";
+	pinctrl-0 = <&pinctrl_otg_default>;
+	pinctrl-1 = <&pinctrl_otg_host>;
+	pinctrl-2 = <&pinctrl_otg_device>;
+	pin-switch-delay-us = <100000>;
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		otg_ep: endpoint {
+			remote-endpoint = <&typec_ep>;
+		};
+	};
+};
+
+&wcd_codec {
+	qcom,hphl-jack-type-normally-open;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	status = "okay";
+};
-- 
2.39.1

