Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B40658BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiL2Kct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiL2KcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:32:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17BB85D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so26943139lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV1Dgv8O2EwayZTmXz48p2pGYrprzLa0BjSyB9KzJxM=;
        b=U8Gj7HaYspeN7GJvJ/rH1zkQtc+Q7dh1GWoieX1qHc3hXtgEGid9/a5nGmEleEwbZe
         o3/Za6L1CweNWY/FQ6Xzq4VRJAOsHQz40qYZKg2nCXo9gHfke0RfkHXao8bGMYfFXqNh
         w4CXUJWLw/iJ2SEYSyY/oVL0REmSOzvM6iveP0G7vbfWk6BQfZGUyFUv4mJ35YrzIhSy
         Gt5Q4qz3ZAfVedea/IU0PlO7SsX8tQWSi2NeAVt3xL2lzPjGkMaRlWOPiBY/W7RatjyK
         ZPfSczNElk76C0yPkVPcEVY+nO4E6WHmuqAkuc6HbeOx6FJHRlI9GbxB5+y22DmUku1B
         gwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV1Dgv8O2EwayZTmXz48p2pGYrprzLa0BjSyB9KzJxM=;
        b=Re8FyVG4et8n77/YYx+IIVfvfJW0+KRzdQfl1wFn/MxXoKpAsChQdwIwVkRjTcB01b
         qQ1mqA+OfLWXcSQEOsIkCfu0bJe1MBCp21pBNrECvl9Mbo4QhmpFA6qvHJr4rhMBs14a
         g2LCYM0kmVr+CPOaPUDW971lWfWgtURNZW0VPYxEOYvC30aTXsQZtyvCQJiiCaPJsMn4
         ksKK2RIYiHlr2Rk3dhvXJQmC0v8a+iP1TSkVwCAxnU2hIf1mUfHXZudA18trn4hAN8de
         +YhSPOiuZHEnjP4TxOScNX1XofgE/O75AS4PtB68d/F1JaTngR8Lr8FxMoJu+E8zSFhV
         7Kpg==
X-Gm-Message-State: AFqh2kr9yjjLkEC2NEP55kbUcP79wu5pLZA3F5bDZd4zIPc1SEPjVufA
        Dm6No9faNBMGA5uzd3t62EYIqQ==
X-Google-Smtp-Source: AMrXdXsHLQYunNRIkzr/Gag3QcH+OooPrJ0zdEyYl/GoQgHzZtORusUc3lgCe+T3ybnhgBQcCajVsA==
X-Received: by 2002:a05:6512:2591:b0:4b5:7dd6:4df0 with SMTP id bf17-20020a056512259100b004b57dd64df0mr7992771lfb.32.1672309941792;
        Thu, 29 Dec 2022 02:32:21 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b004a478c2f4desm2993526lfg.163.2022.12.29.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:32:21 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] arm64: dts: qcom: sm8450-nagara: Set up camera regulators
Date:   Thu, 29 Dec 2022 11:32:10 +0100
Message-Id: <20221229103212.984324-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229103212.984324-1-konrad.dybcio@linaro.org>
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
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

Set up gpio-controlled fixed regulators for camera on PDX223 and fix
up the existing ones in common and PDX224 trees.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 38 +++++++++++++++++++
 .../qcom/sm8450-sony-xperia-nagara-pdx224.dts | 15 +++++++-
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 16 +++++++-
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index 561cd4f09ab7..daf2f91f356e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -11,6 +11,26 @@
 / {
 	model = "Sony Xperia 1 IV";
 	compatible = "sony,pdx223", "qcom,sm8450";
+
+	imx316_lvdd_regulator: imx316-lvdd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "imx316_lvdd_regulator";
+		gpio = <&pm8350b_gpios 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_pwr_ld_en>;
+	};
+
+	tcs3490_vdd_regulator: rgbcir-vdd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "tcs3490_vdd_regulator";
+		gpio = <&pm8350c_gpios 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rgbc_ir_pwr_en>;
+	};
 };
 
 &pm8350b_gpios {
@@ -22,6 +42,15 @@ &pm8350b_gpios {
 			  "CAM_PWR_LD_EN",
 			  "NC",
 			  "FOCUS_N";
+
+	cam_pwr_ld_en: cam-pwr-ld-en-state {
+		pins = "gpio6";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <0>;
+		drive-push-pull;
+		output-low;
+	};
 };
 
 &pm8350c_gpios {
@@ -34,6 +63,15 @@ &pm8350c_gpios {
 			  "NC",
 			  "NC",
 			  "WIDEC_PWR_EN";
+
+	rgbc_ir_pwr_en: rgbc-ir-pwr-en-state {
+		pins = "gpio6";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <1>;
+		drive-push-pull;
+		output-low;
+	};
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
index fc9d74d0f227..dc4de2d3fe48 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
@@ -12,11 +12,14 @@ / {
 	model = "Sony Xperia 5 IV";
 	compatible = "sony,pdx224", "qcom,sm8450";
 
-	imx563_vdig_vreg: imx563-vdig-regulator {
+	imx563_vdig_regulator: imx563-vdig-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "imx563_vdig_vreg";
+		regulator-name = "imx563_vdig_regulator";
 		gpio = <&tlmm 22 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&uwidec_pwr_en>;
 	};
 };
 
@@ -254,4 +257,12 @@ &tlmm {
 			  "APPS_I2C_0_SCL",
 			  "CCI_I2C3_SDA",
 			  "CCI_I2C3_SCL";
+
+	uwidec_pwr_en: uwidec-pwr-en-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 0e139921b3e3..a8c4df2696e3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
  */
 
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
@@ -93,11 +94,14 @@ ramoops@ffc00000 {
 	};
 
 	/* Sadly, the voltages for these GPIO regulators are unknown. */
-	imx650_vana_vreg: imx650-vana-regulator {
+	imx650_vana_regulator: imx650-vana-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "imx650_vana_vreg";
+		regulator-name = "imx650_vana_regulator";
 		gpio = <&tlmm 23 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&telec_pwr_en>;
 	};
 
 	vph_pwr: vph-pwr-regulator {
@@ -703,6 +707,14 @@ ts_int_default: ts-int-default-state {
 		input-enable;
 	};
 
+	telec_pwr_en: telec-pwr-en-state {
+		pins = "gpio23";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio92";
 		function = "gpio";
-- 
2.39.0

