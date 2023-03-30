Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A246D09BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjC3PdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjC3PdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:33:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046ECA0C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so19505374wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680190352; x=1682782352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgkwvI+ngAxCa2UpoyFF6NGQVftW1q6IJSx2lMhiCsk=;
        b=yfCCt89XqyFjaRZsbjKW2JOzZ//Q2DGFWmsVjMs4V1USy/6Mfor6tUC8iFcx6OE1Xk
         btbo/ViNkuUb88jKguorYWZa2gl5OVQUToHHblLheXjMQJSPhPQJUtcyo5MF0l52bLLH
         PVTk1Dr+G9oIBJYWwbvAemET/GnIuhJe05XNXAejvC07sJhBpBjnmh6DQVz9yIRj12VO
         x0d/nYDnbTPQ4V0rqrTksI2EC8eyRq0J4QeB0w+X57WLt4xz8tn1UsqS/mftceKksoxg
         73xee1Dtxo2kL68F703HpkUT7qj0XSMXqg8wXiIz6Hs2Tri3l/mqAWhvaOuiNotrCu0U
         sDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190352; x=1682782352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgkwvI+ngAxCa2UpoyFF6NGQVftW1q6IJSx2lMhiCsk=;
        b=CMlt9E/p6Q5YRwiDtHpUEJ5khYEcpnW+Vo2E71jcEINKDD+S58MAij608Q4J7gUN31
         N5VIq8LiP5RxdT5ZiktOUjatdaRSlsuymKEIeOev01QPhknHIYQu2AYeNxBxtPMqQxV4
         s3obNzJsvy6LblYZMPof7WhRl+/1U85AytZn+DJt8XtOK+xFw9WxZmLCKO3tdGbikeUw
         gbfVK6C9YiDWoWhIPAtjHHz2VURUZn+HcnUNZ7t6rw9ZXjit2BJ+xC8wWXL9F3Z6Hs7r
         giVdT7i3LdOlPsbSdy8EuDeWTk/jHcC0VSKchNU3C3006fazQ6nNx4aMMi8d48YQzFwQ
         esMw==
X-Gm-Message-State: AAQBX9cZo/iD9jGkfowMWbr0ms7sWQlUDIuFH4h9Z6d10OIqBrltkXsQ
        R/fR2wU5Gyh/Lsqg21GLM6Xp+g==
X-Google-Smtp-Source: AKy350Ya5SLiQDI4Qp0/jys5485JlBkQ3++NqZeDxTHgXS7zyxtj4zgltdhFVAF5tV+EcB9Ik5+/GA==
X-Received: by 2002:a05:6000:1192:b0:2c7:17a4:4ece with SMTP id g18-20020a056000119200b002c717a44ecemr18370452wrx.26.1680190352041;
        Thu, 30 Mar 2023 08:32:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm33151794wrt.20.2023.03.30.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:32:31 -0700 (PDT)
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
Subject: [PATCH v8 4/5] arm64: dts: qcom: Add Square apq8039-t2 board
Date:   Thu, 30 Mar 2023 16:32:21 +0100
Message-Id: <20230330153222.2875121-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
References: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/apq8039-t2.dts | 492 ++++++++++++++++++++++++
 2 files changed, 493 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1a29403400b70..31e0ac97fc088 100644
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
index 0000000000000..5f68925434c81
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -0,0 +1,492 @@
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
+	qcom,msm-id = <QCOM_ID_APQ8039 0x30000>;
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
+	status = "okay";
+};
+
+&blsp1_uart1_default {
+	pins = "gpio0", "gpio1";
+};
+
+&blsp1_uart1_sleep {
+	pins = "gpio0", "gpio1";
+};
+
+&blsp1_uart2 {
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
2.39.2

