Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6E723612
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjFFEGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjFFEGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:06:23 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17FE44;
        Mon,  5 Jun 2023 21:06:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f85598697dso28723391cf.1;
        Mon, 05 Jun 2023 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686024364; x=1688616364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKpXbq/o8UuRrRzfkzrH5gxvv1kbuqM5H9JQKpqvD7I=;
        b=CQSgu976fwxZmTFg70KFH24vtUT6z8y6KO86BG789U/2++wBNeat78HxAbat+GaylQ
         RoHwUe7WDJJ2j640gkg79qDE0JR7nbmzWRJhlNvjtw1g8IPqlrpTo+PSwXgeeatE/4lU
         1Fju6gVdgEcBjPXY87QGcV48KGjRrXU4DCftm3nC3025OU3h8TDWmtagKLxHrLJzCEbo
         xFJrRkhotHQ+zrTV5/XRVtnNAlKAvywb2TBP42Kz6D/yvdiHOgynPr/CiLleUAxBab3A
         yZ35roDVILntQcXTUUWLlzO+hKhVkWCZDyfriDGJMLZTh8Sa7oCP4XbaVOD0Vlk1pDks
         Wo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686024364; x=1688616364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKpXbq/o8UuRrRzfkzrH5gxvv1kbuqM5H9JQKpqvD7I=;
        b=Ud/tgavSFLiQNKAD8jLzWa79x3unhX9QE1PQ7QMQvkZ4vnqGgSYXUhlIbl4pg5s18b
         HpAF0MJnvubTx0K+VImnn73mb74xa24S9KBwo1lXrvV29b3NBdL5d5jflgiv3jruFyhl
         sb628tVY9R1E0AK5K3DTv2UxbYZOA4vw/o0IzcHUj6YNcKxPFGhY3EoLxtMudGAICobW
         HnJQkYJBrxwkyBkoeuYeAi9vpG1YjBxLZuD8oj3VBmeOJ/2Zw6+OcrlYVBkfoALoNpXi
         vh70PG2PNL6PBq06EOvrMpMYEeg97M3DbRnGMzR/xzGgIvI8k6p/TF1Zdr7ZWPVx3zre
         TpsQ==
X-Gm-Message-State: AC+VfDxCRv5EuZJplmEL5rlF2+IK5RWk1/o8J6Pe4v6Nqn74hWpKEI27
        1DLtKwbWTH0NpfZcFqiuHh8=
X-Google-Smtp-Source: ACHHUZ53+3rS7Q8EZjpbm/cE4UIrdk3qDP3dfGBtgDEI2do97jNqH/gtytubyQf8gjrfPHUY3txhuw==
X-Received: by 2002:a05:622a:1986:b0:3f5:2177:eca0 with SMTP id u6-20020a05622a198600b003f52177eca0mr1340073qtc.5.1686024364554;
        Mon, 05 Jun 2023 21:06:04 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:aac8:d62:35cc:958c])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84b42000000b003e388264753sm382980qts.65.2023.06.05.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 21:06:04 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] ARM: dts: qcom: Add Samsung Galaxy Express support
Date:   Tue,  6 Jun 2023 00:05:27 -0400
Message-Id: <20230606040529.122433-5-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606040529.122433-1-guptarud@gmail.com>
References: <20230606040529.122433-1-guptarud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a very basic device tree file for the Samsung Galaxy Express SGH-I437.
Currently, the following things work: UART, eMMC, SD Card, and USB.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-msm8960-samsung-expressatt.dts   | 331 ++++++++++++++++++
 2 files changed, 332 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..12c90f263142 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1081,6 +1081,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8916-samsung-grandmax.dtb \
 	qcom-msm8916-samsung-serranove.dtb \
 	qcom-msm8960-cdp.dtb \
+	qcom-msm8960-samsung-expressatt.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
 	qcom-msm8974-sony-xperia-rhine-amami.dtb \
 	qcom-msm8974-sony-xperia-rhine-honami.dtb \
diff --git a/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
new file mode 100644
index 000000000000..13e85c287498
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/input/input.h>
+
+#include "qcom-msm8960.dtsi"
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
+
+/ {
+	model = "Samsung Galaxy Express SGH-I437";
+	compatible = "samsung,expressatt", "qcom,msm8960";
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &gsbi5_serial;
+		mmc0 = &sdcc1; /* SDCC1 eMMC slot */
+		mmc1 = &sdcc3; /* SDCC3 SD card slot */
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&gsbi5 {
+	qcom,mode = <GSBI_PROT_I2C_UART>;
+	status = "okay";
+};
+
+&gsbi5_serial {
+	status = "okay";
+};
+
+&sdcc1 {
+	vmmc-supply = <&pm8921_l5>;
+	status = "okay";
+};
+
+&sdcc3 {
+	vmmc-supply = <&pm8921_l6>;
+	vqmmc-supply = <&pm8921_l7>;
+	status = "okay";
+};
+
+&gsbi1 {
+	qcom,mode = <GSBI_PROT_SPI>;
+	pinctrl-0 = <&spi1_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gsbi1_spi {
+	status = "okay";
+};
+
+&msmgpio {
+	spi1_default: spi1-default-state {
+		mosi-pins {
+			pins = "gpio6";
+			function = "gsbi1";
+			drive-strength = <12>;
+			bias-disable;
+		};
+
+		miso-pins {
+			pins = "gpio7";
+			function = "gsbi1";
+			drive-strength = <12>;
+			bias-disable;
+		};
+
+		cs-pins {
+			pins = "gpio8";
+			function = "gsbi1";
+			drive-strength = <12>;
+			bias-disable;
+			output-low;
+		};
+
+		clk-pins {
+			pins = "gpio9";
+			function = "gsbi1";
+			drive-strength = <12>;
+			bias-disable;
+		};
+	};
+};
+
+&rpm {
+	regulators {
+		compatible = "qcom,rpm-pm8921-regulators";
+		vin_lvs1_3_6-supply = <&pm8921_s4>;
+		vin_lvs2-supply = <&pm8921_s4>;
+		vin_lvs4_5_7-supply = <&pm8921_s4>;
+		vdd_ncp-supply = <&pm8921_l6>;
+		vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+		vdd_l21_l23_l29-supply = <&pm8921_s8>;
+		vdd_l24-supply = <&pm8921_s1>;
+		vdd_l25-supply = <&pm8921_s1>;
+		vdd_l27-supply = <&pm8921_s7>;
+		vdd_l28-supply = <&pm8921_s7>;
+
+		/* Buck SMPS */
+		pm8921_s1: s1 {
+			regulator-always-on;
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+			qcom,switch-mode-frequency = <3200000>;
+			bias-pull-down;
+		};
+
+		pm8921_s2: s2 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			qcom,switch-mode-frequency = <1600000>;
+			bias-pull-down;
+		};
+
+		pm8921_s3: s3 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1150000>;
+			qcom,switch-mode-frequency = <4800000>;
+			bias-pull-down;
+		};
+
+		pm8921_s4: s4 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			qcom,switch-mode-frequency = <1600000>;
+			bias-pull-down;
+			qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+		};
+
+		pm8921_s7: s7 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+			qcom,switch-mode-frequency = <3200000>;
+			bias-pull-down;
+		};
+
+		pm8921_s8: s8 {
+			regulator-always-on;
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+			qcom,switch-mode-frequency = <1600000>;
+			bias-pull-down;
+		};
+
+		/* PMOS LDO */
+		pm8921_l1: l1 {
+			regulator-always-on;
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			bias-pull-down;
+		};
+
+		pm8921_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			bias-pull-down;
+		};
+
+		pm8921_l3: l3 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3300000>;
+			bias-pull-down;
+		};
+
+		pm8921_l4: l4 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l5: l5 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l6: l6 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l7: l7 {
+			regulator-always-on;
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l8: l8 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3100000>;
+			bias-pull-down;
+		};
+
+		pm8921_l9: l9 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+			bias-pull-down;
+		};
+
+		pm8921_l10: l10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			bias-pull-down;
+		};
+
+		pm8921_l11: l11 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3300000>;
+			bias-pull-down;
+		};
+
+		pm8921_l12: l12 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			bias-pull-down;
+		};
+
+		pm8921_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l16: l16 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+			bias-pull-down;
+		};
+
+		pm8921_l17: l17 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			bias-pull-down;
+		};
+
+		pm8921_l18: l18 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1500000>;
+			bias-pull-down;
+		};
+
+		pm8921_l21: l21 {
+			regulator-min-microvolt = <1900000>;
+			regulator-max-microvolt = <1900000>;
+			bias-pull-down;
+		};
+
+		pm8921_l22: l22 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+			bias-pull-down;
+		};
+
+		pm8921_l23: l23 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l24: l24 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1150000>;
+			bias-pull-down;
+		};
+
+		pm8921_l25: l25 {
+			regulator-always-on;
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+			bias-pull-down;
+		};
+
+		/* Low Voltage Switch */
+		pm8921_lvs1: lvs1 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs2: lvs2 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs3: lvs3 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs4: lvs4 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs5: lvs5 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs6: lvs6 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs7: lvs7 {
+			bias-pull-down;
+		};
+
+		pm8921_ncp: ncp {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			qcom,switch-mode-frequency = <1600000>;
+		};
+	};
+};
+
+&usb_hs1_phy {
+	v3p3-supply = <&pm8921_l3>;
+	v1p8-supply = <&pm8921_l4>;
+};
+
+&usb1 {
+	dr_mode = "otg";
+	status = "okay";
+};
-- 
2.34.1

