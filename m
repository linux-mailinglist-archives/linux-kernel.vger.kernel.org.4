Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5140F63E8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLAENb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLAENZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:13:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4742A706;
        Wed, 30 Nov 2022 20:13:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4065503pjt.0;
        Wed, 30 Nov 2022 20:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dfb898sY4gyhcL10bxfAtqPqdu5zQtIyH/cIxz3sqc=;
        b=SmbpgQ7m7bBorYQvcIaplpN16itCumTcTjEqMlU7mZPGmBtbP0/Oianainn/jCQBs1
         E5hS2ZJ0i/BCAeIvHNvB37SfOkUjAH8Kqg2nZlwLdHSlyrQkErk8gro/PhC2aZajdP/+
         FjFSI+4Ti7QBtoSjUWkYtWY1oMfklthNLUNVVIZ2gUEFhdNbhRCAUlmhy9+57/OZMCR3
         3Jd7kqz2SxvCuhT79PgUrs8OmlieGrj268N5sBEK/8FqJzkOLtWJXti4sgbS88nTsvZJ
         WfjvCdXhzdQ2LDebN8sANGqZBvv2fiPS6yIpJ4o7TkrHMKMfPaitBg0phlM1KmbRKcb4
         RQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dfb898sY4gyhcL10bxfAtqPqdu5zQtIyH/cIxz3sqc=;
        b=DSVblqxDWpvH2t6pS5Y/942mfKl4O2kl/BvOj2JbkdIBYtbJIVpXPQ2DGy9DSq23I6
         TIBbLJdLfCGZXPgOBTbiROuU7YBQJwJJDlEtMYQWK11yqF29MR/vTmGPR+Q5Kztpz3sg
         LmVoBnLLqFBECjtJPjs4ovUDQTSjk3vY8VFeV/ORG8iH2Ubi8+wvEjtFYw6AhB/40Ell
         vm0JVBu7dN8FtCBTiRKbunXYYcT/gJ4Xg4FGo7pJiy8URJUkPeaJIEuTUhNljgyEDJFC
         G0aBpH5TispG4is9HLJUg8GD1Og1o3KO8vYSQEr2VWwcan228rQyE3I356eqKLSoFGLq
         NmrA==
X-Gm-Message-State: ANoB5pne5fuXrdY5+V5HWorxXaltj+bkDnXXCeK2WzMpF244aPKOOK5f
        TO7PAu50whIGV1KPNyHB+RnYjthOPhE=
X-Google-Smtp-Source: AA0mqf53wFZRZrJIvshgAzDGoL/znY0HLCTNOWByJgCTos1FsJZ3U/v+Tkjc5pC4M66kmdzexvkzog==
X-Received: by 2002:a17:90a:d681:b0:213:d08f:a455 with SMTP id x1-20020a17090ad68100b00213d08fa455mr75430215pju.130.1669868001146;
        Wed, 30 Nov 2022 20:13:21 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-a80b-9fee-51f7-4bb8.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:a80b:9fee:51f7:4bb8])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001782a6fbcacsm2321894plb.101.2022.11.30.20.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 20:13:20 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>, Harvey <hunge@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v12 2/2] arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie
Date:   Thu,  1 Dec 2022 12:13:04 +0800
Message-Id: <20221201121235.v12.2.I80aa32497bfd67bc8a372c1418ccc443ccf193e4@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221201121235.v12.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
References: <20221201121235.v12.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT for sc7280-herobrine-zombie

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v12:
- Add "Reviewed-by" tag from Douglas.

Changes in v11:
- Add comment "/* Set the PWM period to 200 microseconds (5kHz duty cycle) */" before "pwms = <&pm8350c_pwm 3 200000>;" in "sc7280-herobrine-zombie.dtsi", as requested by Douglas.

Changes in v10:
- Remove wrong "Tested-by" tag in this patch, I misunderstood the "tested-by" tag usage, as requested by Krzysztof.
- Remove patch 1 changes log in v8 log since it doesn't belongs to here, as requested by Krzysztof.
- Fixed history log list.

Changes in v9:
- Fixed version number (v7 and v8 were erroneously posted as v6).

Changes in v8:
- None.

Changes in v7:
- Add "Tested-by" in commit log.

Changes in v6:
- Set the PWM period to 200 microseconds (5kHz duty cycle) to our display panel spec, and move to right place, as requested by Douglas and Matthias.
- Drop post-power-on-delay-ms = <100>, as requested by Douglas.
- Remove one of the lines after the line with "MOS_BLE_UART_RX" for matching amount of GPIO (174), as requested by Douglas.

Changes in v5:
- Overwrite pm8350c_pwm_backlight setting in sc7280-herobrine-zombie.dtsi for chrome zombie.

Changes in v4:
- Dropping the redundant 'DT binding for' as requested by Krzysztof.
- Adding an empty line here before "/dts-v1/;" in "sc7280-herobrine-zombie-lte.dts", "sc7280-herobrine-zombie.dts" as requested by Matthias.
- Deleteing "/dts-v1/;" in "sc7280-herobrine-zombie.dtsi" as requested by Matthias.

Changes in v3:
- Droping changing file path in description. v3. as requested by Matthias.

Changes in v2:
- Changing Patch order, binding patch first and dt file second, as requested by Douglas.
- Adding "arm64: dts: qcom: sc7280:" in dt patch ${SUBJECT}, as requested by Douglas.
- Adding "dt-bindings: arm: qcom:" in bind patch ${SUBJECT}, as requested by Douglas.
- Adding '#include "sc7280-herobrine-wifi-sku.dtsi"' in sc7280-herobrine-zombie.dts, as requested by Douglas.
- Adding "(newest rev)" for zombie entry description in qcom.yaml, as requested by Douglas.
- Adding "post-power-on-delay-ms = <100>;" for trackpad in "sc7280-herobrine-zombie.dtsi".
- Changing "vcc-supply" to "vdd-supply" for trackpad in "sc7280-herobrine-zombie.dtsi", as requested by Douglas.

 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/sc7280-herobrine-zombie-lte.dts  |  16 +
 .../boot/dts/qcom/sc7280-herobrine-zombie.dts |  16 +
 .../dts/qcom/sc7280-herobrine-zombie.dtsi     | 311 ++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index afe496a93f94..7b0644a39062 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -114,6 +114,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
new file mode 100644
index 000000000000..c9fe64529555
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Zombie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine-zombie.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Zombie with LTE";
+	compatible = "google,zombie-sku512", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
new file mode 100644
index 000000000000..0246c12b2f40
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Zombie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine-zombie.dtsi"
+#include "sc7280-herobrine-wifi-sku.dtsi"
+
+/ {
+	model = "Google Zombie";
+	compatible = "google,zombie", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
new file mode 100644
index 000000000000..21ac55fd63aa
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Zombie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-audio-rt5682.dtsi"
+
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_codec {
+	status = "okay";
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
+ap_tp_i2c: &i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	trackpad: trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+
+		hid-descr-addr = <0x01>;
+		vdd-supply = <&pp3300_z1>;
+
+		wakeup-source;
+	};
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
+&ap_sar_sensor0 {
+	status = "okay";
+};
+
+&ap_sar_sensor1 {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
+/* For nvme */
+&pcie1 {
+	status = "okay";
+};
+
+/* For nvme */
+&pcie1_phy {
+	status = "okay";
+};
+
+&pm8350c_pwm_backlight{
+	pwms = <&pm8350c_pwm 3 200000>;
+};
+
+&pwmleds {
+	status = "okay";
+};
+
+/* For eMMC */
+&sdhc_1 {
+	status = "okay";
+};
+
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&ts_rst_conn {
+	bias-disable;
+};
+
+/* PINCTRL - BOARD-SPECIFIC */
+
+/*
+ * Methodology for gpio-line-names:
+ * - If a pin goes to herobrine board and is named it gets that name.
+ * - If a pin goes to herobrine board and is not named, it gets no name.
+ * - If a pin is totally internal to Qcard then it gets Qcard name.
+ * - If a pin is not hooked up on Qcard, it gets no name.
+ */
+
+&pm8350c_gpios {
+	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
+			  "AP_SUSPEND",
+			  "PM8008_1_RST_N",
+			  "",
+			  "",
+			  "",
+			  "PMIC_EDP_BL_EN",
+			  "PMIC_EDP_BL_PWM",
+			  "";
+};
+
+&tlmm {
+	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
+			  "AP_TP_I2C_SCL",
+			  "SSD_RST_L",
+			  "PE_WAKE_ODL",
+			  "AP_SAR_SDA",
+			  "AP_SAR_SCL",
+			  "PRB_SC_GPIO_6",
+			  "TP_INT_ODL",
+			  "HP_I2C_SDA",
+			  "HP_I2C_SCL",
+
+			  "GNSS_L1_EN",			/* 10 */
+			  "GNSS_L5_EN",
+			  "SPI_AP_MOSI",
+			  "SPI_AP_MISO",
+			  "SPI_AP_CLK",
+			  "SPI_AP_CS0_L",
+			  /*
+			   * AP_FLASH_WP is crossystem ABI. Schematics
+			   * call it BIOS_FLASH_WP_OD.
+			   */
+			  "AP_FLASH_WP",
+			  "",
+			  "AP_EC_INT_L",
+			  "",
+
+			  "UF_CAM_RST_L",		/* 20 */
+			  "WF_CAM_RST_L",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "",
+			  "PM8008_IRQ_1",
+			  "HOST2WLAN_SOL",
+			  "WLAN2HOST_SOL",
+			  "MOS_BT_UART_CTS",
+			  "MOS_BT_UART_RFR",
+
+			  "MOS_BT_UART_TX",		/* 30 */
+			  "MOS_BT_UART_RX",
+			  "PRB_SC_GPIO_32",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "AP_SPI_FP_MISO",
+			  "AP_SPI_FP_MOSI",
+			  "AP_SPI_FP_CLK",
+			  "AP_SPI_FP_CS_L",
+
+			  "AP_EC_SPI_MISO",		/* 40 */
+			  "AP_EC_SPI_MOSI",
+			  "AP_EC_SPI_CLK",
+			  "AP_EC_SPI_CS_L",
+			  "LCM_RST_L",
+			  "EARLY_EUD_N",
+			  "",
+			  "DP_HOT_PLUG_DET",
+			  "IO_BRD_MLB_ID0",
+			  "IO_BRD_MLB_ID1",
+
+			  "IO_BRD_MLB_ID2",		/* 50 */
+			  "SSD_EN",
+			  "TS_I2C_SDA_CONN",
+			  "TS_I2C_CLK_CONN",
+			  "TS_RST_CONN",
+			  "TS_INT_CONN",
+			  "AP_I2C_TPM_SDA",
+			  "AP_I2C_TPM_SCL",
+			  "PRB_SC_GPIO_58",
+			  "PRB_SC_GPIO_59",
+
+			  "EDP_HOT_PLUG_DET_N",		/* 60 */
+			  "FP_TO_AP_IRQ_L",
+			  "",
+			  "AMP_EN",
+			  "CAM0_MCLK_GPIO_64",
+			  "CAM1_MCLK_GPIO_65",
+			  "WF_CAM_MCLK",
+			  "PRB_SC_GPIO_67",
+			  "FPMCU_BOOT0",
+			  "UF_CAM_SDA",
+
+			  "UF_CAM_SCL",			/* 70 */
+			  "",
+			  "",
+			  "WF_CAM_SDA",
+			  "WF_CAM_SCL",
+			  "",
+			  "",
+			  "EN_FP_RAILS",
+			  "FP_RST_L",
+			  "PCIE1_CLKREQ_ODL",
+
+			  "EN_PP3300_DX_EDP",		/* 80 */
+			  "US_EURO_HS_SEL",
+			  "FORCED_USB_BOOT",
+			  "WCD_RESET_N",
+			  "MOS_WLAN_EN",
+			  "MOS_BT_EN",
+			  "MOS_SW_CTRL",
+			  "MOS_PCIE0_RST",
+			  "MOS_PCIE0_CLKREQ_N",
+			  "MOS_PCIE0_WAKE_N",
+
+			  "MOS_LAA_AS_EN",		/* 90 */
+			  "SD_CD_ODL",
+			  "",
+			  "",
+			  "MOS_BT_WLAN_SLIMBUS_CLK",
+			  "MOS_BT_WLAN_SLIMBUS_DAT0",
+			  "HP_MCLK",
+			  "HP_BCLK",
+			  "HP_DOUT",
+			  "HP_DIN",
+
+			  "HP_LRCLK",			/* 100 */
+			  "HP_IRQ",
+			  "",
+			  "",
+			  "GSC_AP_INT_ODL",
+			  "EN_PP3300_CODEC",
+			  "AMP_BCLK",
+			  "AMP_DIN",
+			  "AMP_LRCLK",
+			  "UIM1_DATA_GPIO_109",
+
+			  "UIM1_CLK_GPIO_110",		/* 110 */
+			  "UIM1_RESET_GPIO_111",
+			  "PRB_SC_GPIO_112",
+			  "UIM0_DATA",
+			  "UIM0_CLK",
+			  "UIM0_RST",
+			  "UIM0_PRESENT_ODL",
+			  "SDM_RFFE0_CLK",
+			  "SDM_RFFE0_DATA",
+			  "WF_CAM_EN",
+
+			  "FASTBOOT_SEL_0",		/* 120 */
+			  "SC_GPIO_121",
+			  "FASTBOOT_SEL_1",
+			  "SC_GPIO_123",
+			  "FASTBOOT_SEL_2",
+			  "SM_RFFE4_CLK_GRFC_8",
+			  "SM_RFFE4_DATA_GRFC_9",
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "PRB_SC_GPIO_129",
+
+			  "LCM_ID0",			/* 130 */
+			  "LCM_ID1",
+			  "",
+			  "SDR_QLINK_REQ",
+			  "SDR_QLINK_EN",
+			  "QLINK0_WMSS_RESET_N",
+			  "SMR526_QLINK1_REQ",
+			  "SMR526_QLINK1_EN",
+			  "SMR526_QLINK1_WMSS_RESET_N",
+			  "PRB_SC_GPIO_139",
+
+			  "SAR1_IRQ_ODL",		/* 140 */
+			  "SAR0_IRQ_ODL",
+			  "PRB_SC_GPIO_142",
+			  "",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1",
+
+			  "DMIC01_CLK",			/* 150 */
+			  "DMIC01_DATA",
+			  "DMIC23_CLK",
+			  "DMIC23_DATA",
+			  "",
+			  "",
+			  "EC_IN_RW_ODL",
+			  "HUB_EN",
+			  "WCD_SWR_TX_DATA2",
+			  "",
+
+			  "",				/* 160 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "",				/* 170 */
+			  "MOS_BLE_UART_TX",
+			  "MOS_BLE_UART_RX",
+			  "",
+			  "";
+};
-- 
2.17.1

