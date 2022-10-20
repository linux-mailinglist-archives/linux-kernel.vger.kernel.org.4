Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D0C605F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJTL40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJTL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:56:23 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4312E0E7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:56:20 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666266978; x=1666526178;
        bh=8+35NVO0c0UvUjwWAVqxXJYRfNgUQLbju4mSBPabbg8=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=eun3vO++Su1XSxTdmdJs/WC6r519scdeMdkVcc58v2ILdhhqVZbRknNO+hRWBpHPW
         CHleG38sTeJzGTY2EJdGlDIiYHjRjjgr1mjzi9zt+eQ7HloGRS4ZhiErtTJW2e0PhC
         3FO1JcCT5HePfUJArvGI3q3Tl3VKXaYEydJO5msK86lXXsfuLdHLZfyrAPlvaGz56w
         fSYzggmDNAe+To1M+b5x9Bn6uU2vnC0z9ngsNan0Rn0JweRcCtSR5jQeX56FNDpL1I
         H0FYfd1tgHVNnnxzXxVxuU+SedW9D+izfgeP5IACSs1hqqPAbUgBhIMw7CKZfNkG+i
         3pb/BqKhJ3ceg==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: msm8916-samsung-a2015: Add vibrator
Message-ID: <20221020115255.2026-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Travkin <nikita@trvn.ru>

Both a2015 devices use motor drivers controlled with PWM signal.
A5 additionally has a fixed regulator that powers the driver and is
controlled by enable signal. A3 routes that enable signal to the
motor driver itself.
To simplify the description, add the motor to the common dtsi and
assume a regulator is used for both.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
[Rename the nodes to be reusable in msm8916-sansung-e2015]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-a2015-common.dtsi    | 52 +++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  8 +++
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  8 +++
 .../qcom/msm8916-samsung-e2015-common.dtsi    | 26 ++--------
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 3255bd3fcb55..16935de738af 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -23,6 +23,17 @@ tz-apps@85500000 {
 =09=09};
 =09};
=20
+=09clk_pwm: pwm {
+=09=09compatible =3D "clk-pwm";
+=09=09#pwm-cells =3D <2>;
+
+=09=09clocks =3D <&gcc GCC_GP2_CLK>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&motor_pwm_default>;
+=09=09status =3D "disabled";
+=09};
+
 =09gpio-keys {
 =09=09compatible =3D "gpio-keys";
=20
@@ -61,6 +72,24 @@ event-hall-sensor {
 =09=09};
 =09};
=20
+=09/*
+=09 * NOTE: A5 connects GPIO 76 to a reglator powering the motor
+=09 * driver IC but A3 connects the same signal to an ENABLE pin of
+=09 * the driver.
+=09 */
+=09reg_motor_vdd: regulator-motor-vdd {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "motor_vdd";
+=09=09regulator-min-microvolt =3D <3000000>;
+=09=09regulator-max-microvolt =3D <3000000>;
+
+=09=09gpio =3D <&msmgpio 76 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&motor_en_default>;
+=09};
+
 =09reg_vdd_tsp_a: regulator-vdd-tsp-a {
 =09=09compatible =3D "regulator-fixed";
 =09=09regulator-name =3D "vdd_tsp_a";
@@ -153,6 +182,16 @@ nfc@27 {
 =09=09=09pinctrl-0 =3D <&nfc_default &nfc_clk_req>;
 =09=09};
 =09};
+
+=09vibrator: vibrator {
+=09=09compatible =3D "pwm-vibrator";
+
+=09=09pwms =3D <&clk_pwm 0 100000>;
+=09=09pwm-names =3D "enable";
+
+=09=09vcc-supply =3D <&reg_motor_vdd>;
+=09=09status =3D "disabled";
+=09};
 };
=20
 &blsp_i2c2 {
@@ -397,6 +436,19 @@ mdss_sleep: mdss-sleep {
 =09=09};
 =09};
=20
+=09motor_en_default: motor-en-default {
+=09=09pins =3D "gpio76";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09motor_pwm_default: motor-pwm-default {
+=09=09pins =3D "gpio50";
+=09=09function =3D "gcc_gp2_clk_a";
+=09};
+
 =09muic_i2c_default: muic-i2c-default {
 =09=09pins =3D "gpio105", "gpio106";
 =09=09function =3D "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 6db5f78ca286..d495d5ae5cc3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -81,6 +81,10 @@ touchscreen@20 {
 =09};
 };
=20
+&clk_pwm {
+=09status =3D "okay";
+};
+
 &dsi0 {
 =09panel@0 {
 =09=09reg =3D <0>;
@@ -104,6 +108,10 @@ &dsi0_out {
 =09remote-endpoint =3D <&panel_in>;
 };
=20
+&vibrator {
+=09status =3D "okay";
+};
+
 &msmgpio {
 =09panel_vdd3_default: panel-vdd3-default {
 =09=09pins =3D "gpio9";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index 5fb8ecd0c9ca..c03504ab27b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -50,6 +50,10 @@ touchscreen@48 {
 =09};
 };
=20
+&clk_pwm {
+=09status =3D "okay";
+};
+
 &pronto {
 =09iris {
 =09=09compatible =3D "qcom,wcn3660b";
@@ -61,6 +65,10 @@ &touchkey {
 =09vdd-supply =3D <&reg_touch_key>;
 };
=20
+&vibrator {
+=09status =3D "okay";
+};
+
 &msmgpio {
 =09tkey_en_default: tkey-en-default {
 =09=09pins =3D "gpio97";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 542010fdfb8a..edd24b597a15 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -26,19 +26,6 @@ muic: extcon@14 {
 =09=09};
 =09};
=20
-=09reg_motor_vdd: regulator-motor-vdd {
-=09=09compatible =3D "regulator-fixed";
-=09=09regulator-name =3D "motor_vdd";
-=09=09regulator-min-microvolt =3D <3300000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-
-=09=09gpio =3D <&msmgpio 76 GPIO_ACTIVE_HIGH>;
-=09=09enable-active-high;
-
-=09=09pinctrl-names =3D "default";
-=09=09pinctrl-0 =3D <&motor_en_default>;
-=09};
-
 =09reg_touch_key: regulator-touch-key {
 =09=09compatible =3D "regulator-fixed";
 =09=09regulator-name =3D "touch_key";
@@ -61,20 +48,17 @@ &blsp_i2c2 {
 =09/delete-node/ magnetometer@12;
 };
=20
+&reg_motor_vdd {
+=09regulator-min-microvolt =3D <3300000>;
+=09regulator-max-microvolt =3D <3300000>;
+};
+
 &touchkey {
 =09vcc-supply =3D <&reg_touch_key>;
 =09vdd-supply =3D <&reg_touch_key>;
 };
=20
 &msmgpio {
-=09motor_en_default: motor-en-default {
-=09=09pins =3D "gpio76";
-=09=09function =3D "gpio";
-
-=09=09drive-strength =3D <2>;
-=09=09bias-disable;
-=09};
-
 =09tkey_en_default: tkey-en-default {
 =09=09pins =3D "gpio97";
 =09=09function =3D "gpio";
--=20
2.30.2


