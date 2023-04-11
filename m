Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33626DE3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDKSPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDKSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:14:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8CDE59
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:14:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so54539639lfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681236889; x=1683828889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8YA0Knj+iRSv6lIV53CgVChHg21pEgDWQtJQQbMyVQ=;
        b=cSHSoWKfd4X9dGuPyJGR0qg9Ewo4ZC5AFVzw3aZw7kJonr4H1Ei6NGZ1xbXrugQr5A
         loieAKeXMuS0JwoIVwSsaW5k0fNQ8xsj5yD7yJy6RpYEkC/pOY2MK36FR+9gGYMO4DAZ
         LRBZzI2u4/c5NphaztRdttbiAlxC5QwYkI3Ci3lnH6h+f8lFv6Je0HSd0RRnlGn8cNN3
         cfJ1LaC+ODpdm/SS3un+FjMtDuSx7IlqSsaf6BeMUYjgwiQr0yD82muMXVhwvJ+HaOeH
         +TzF6E42oeGEzRsUG6xa006QqS3X7xpr5MEKaCTqPjTRjYSH1YcQq8HfJB2ixHZTtkkS
         8joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236889; x=1683828889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8YA0Knj+iRSv6lIV53CgVChHg21pEgDWQtJQQbMyVQ=;
        b=6KZU4yNppSp89gE7tkNL5aGXKWMk+/FHabAqD2dIsFevXLsV1wbxcEX7LRepxfFHVX
         /aLcGuvV5zONy2ggFyaGrHDrQFIU9EgiAYBkZxw3tHZUf0SH/pLk1h0J7u532JLEqcdJ
         ajZeRxb77c5pkg6eOiY+Dg3OzyGmfBKGPQxyCZliywwik92Yn2P6rFvZmiqu9mENm6bx
         W6OpdxfDuTkl1QpUubCpMaWk281vcNZpI2/bgp2qJ+16prDX1Ys+PVHSArUJhD9WWhXQ
         cwcp8cEyEpRZarDDUVK7FsoGVbvTRiwzWpPaPdOULjhQYa+z0QacDdKnL/SXgilbkKxQ
         ET0w==
X-Gm-Message-State: AAQBX9chR5SSwugZjiRlnlWybP7/dShekOXPtQsRrVKLEljd44uO1IE1
        lwTLmTaKm4glwWwnANsFVZuOyh/JU0srIHXa06o=
X-Google-Smtp-Source: AKy350aHFx0/pHpfaLs2eH5ZeCra+C/PLB20iGNx37oAWwAnq/nRbMW0s4YhIEI7MjkTPnA/YJw8Gw==
X-Received: by 2002:a19:ad01:0:b0:4de:3f1e:cdc4 with SMTP id t1-20020a19ad01000000b004de3f1ecdc4mr916349lfc.13.1681236889354;
        Tue, 11 Apr 2023 11:14:49 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id u25-20020ac243d9000000b004da8168eba2sm2593868lfl.237.2023.04.11.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 11:14:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Apr 2023 20:14:43 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8150-kumano: Set up camera
 fixed regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-kumano_dts0-v2-3-0ca7fa521b86@linaro.org>
References: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
In-Reply-To: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681236884; l=3979;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4Qcy6oAyM8zPF8mK5eHRI95hbEBvPmEJg9jGJaCAKqc=;
 b=nQoemCIsDwBjMjcWSS4hIbHig03q/Kwg6GLttifVvrJgVmM7T5hCT9H2gxdaxVxFqqbdU2JZ3iIk
 TSgIXwMQDQ2nQdvy0oUKB6VctPq5rvcRSqT1TfLZcbkdwHsogE5d
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony - as per usual - used a whole bunch of GPIO-gated fixed
voltage regulators for camera sensors on Kumano. Describe them
and the corresponding pins.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index d1a3ab836019..ad402f3a90c3 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8150.dtsi"
 #include "pm8150.dtsi"
@@ -81,6 +82,66 @@ key-vol-down {
 		};
 	};
 
+	cam0_vdig_vreg: cam0-vdig-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "camera0_vdig_vreg";
+		gpio = <&tlmm 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&main_cam_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	cam1_vdig_vreg: cam1-vdig-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "camera1_vdig_vreg";
+		gpio = <&tlmm 79 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&sub_cam_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	cam2_vdig_vreg: cam2-vdig-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "camera2_vdig_vreg";
+		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&chat_cam_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	cam3_vdig_vreg: cam3-vdig-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "camera3_vdig_vreg";
+		gpio = <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&supwc_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	cam_vmdr_vreg: cam-vmdr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vmdr_vreg";
+		gpio = <&pm8150l_gpios 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&main_cam_pwr_vmdr_en>;
+		pinctrl-names = "default";
+	};
+
+	rgbcir_vreg: rgbcir-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "rgbcir_vreg";
+		gpio = <&tlmm 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&rgbc_ir_pwr_en>;
+		pinctrl-names = "default";
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -474,6 +535,15 @@ vol_down_n: vol-down-n-state {
 		bias-pull-up;
 		input-enable;
 	};
+
+	supwc_pwr_en: supwc-pwr-en-state {
+		pins = "gpio7";
+		function = "normal";
+		qcom,drive-strength = <1>;
+		power-source = <1>;
+		drive-push-pull;
+		output-low;
+	};
 };
 
 &pm8150b_gpios {
@@ -520,6 +590,15 @@ &pm8150l_gpios {
 			  "NC", /* GPIO_10 */
 			  "NC",
 			  "NC";
+
+	main_cam_pwr_vmdr_en: main-cam-pwr-vmdr-en-state {
+		pins = "gpio3";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <0>;
+		drive-push-pull;
+		output-low;
+	};
 };
 
 &pon_pwrkey {
@@ -716,6 +795,37 @@ &tlmm {
 			  "WL_CMD_DATA_CHAIN1",
 			  "WL_BT_COEX_CLK",
 			  "WL_BT_COEX_DATA";
+
+	main_cam_pwr_en: main-cam-pwr-en-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	chat_cam_pwr_en: chat-cam-pwr-en-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	rgbc_ir_pwr_en: rgbc-ir-pwr-en-state {
+		pins = "gpio29";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	sub_cam_pwr_en: sub-cam-pwr-en-state {
+		pins = "gpio79";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &uart2 {

-- 
2.40.0

