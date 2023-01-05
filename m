Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4E65EB14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAEMvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjAEMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:24 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920214C71E;
        Thu,  5 Jan 2023 04:51:22 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 3B5D9420D7;
        Thu,  5 Jan 2023 17:33:59 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922039; bh=XDs2gflTOLUlUTnTexb8dZ34bV0BRZklNYRXJ5foqD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiWwwwdEBMnAvotjd62WdrCZOa1HbPZOAuoDax58cUnfKW9q7K1o/7ePPS3n3LJtW
         vUe1FNimJJw8co3p2LVgkuuBvFRnvnkr1G4tVjQCU8HJROrDMal41rAo0bbkZjs0sS
         cnLPvC1LDWKD+DlktV2Busi7cApRn2deL0BwllpliKWdiGk6JxfcN9DEMaAiyTqfWJ
         uwQSWB+STdHX7Mtmh4g41iIO35R9hYznHzjgOe+7m3p2+ukYr1OEgXvSLqFLLTp6zB
         D6zdp12w8zDFGW3tv6ZFDKw4MYs1lvt7qcnsWHiZbRRb2U7h5DIacNBYhiA9o43U5v
         hn+HyDl2WP3xg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 5/8] arm64: dts: qcom: msm8916-samsung-gt510: Add touchscreen
Date:   Thu,  5 Jan 2023 17:32:37 +0500
Message-Id: <20230105123240.1089375-6-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Korten <jja2000@gmail.com>

gt510 uses maXTouch mXT1664T3 touch controller. Add it and regulators
that supply it.

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index 44d527b3f1f6..6331166d9067 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -32,6 +32,29 @@ reg_motor_vdd: regulator-motor-vdd {
 		pinctrl-names = "default";
 	};
 
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	vibrator {
 		compatible = "pwm-vibrator";
 
@@ -42,6 +65,25 @@ vibrator {
 	};
 };
 
+&blsp_i2c5 {
+	status = "okay";
+
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+
+		vdd-supply = <&reg_tsp_1p8v>;
+		vdda-supply = <&reg_tsp_3p3v>;
+
+		reset-gpios = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&tsp_int_rst_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &msmgpio {
 	motor_en_default: motor-en-default-state {
 		pins = "gpio76";
@@ -55,4 +97,20 @@ motor_pwm_default: motor-pwm-default-state {
 		pins = "gpio50";
 		function = "gcc_gp2_clk_a";
 	};
+
+	tsp_en_default: tsp-en-default-state {
+		pins = "gpio73";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default: tsp-int-rst-default-state {
+		pins = "gpio13", "gpio114";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
-- 
2.38.1

