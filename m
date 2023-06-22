Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4D739537
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFVCGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjFVCGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:06:37 -0400
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64222198B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:06:17 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:06:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399570; x=1687658770;
        bh=7SfUXgxDKFs8VyBnB08DD7BLN92E+2qCeSvNcbRx2Aw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=fv0DP/u8s/kP/JRVUax0RBzP3gLl7iEwVlP98yiAxlxhM/Y5i7rR5EUzWNjbz6CWO
         s6w6HCEhbEMiYRBwhYk0lJ4pga+LmWLxPVsAr+Pj4WGN9URrD+pfJS3lxwTnc4IbwD
         JQK2Zwm7lcX+RRJfh7mmRw3iJ77zUo0VfrvGZvCH4qJpZfItrQqb9H5OUSI32hV79o
         ZdDUY2tVFmNmdQYvTZhglu1fFS+Y0262Pj/F6Allrs2gBL1BtxYvU9WU+rlj+4D7jX
         7wSkjsi692IvaVG+R5EjCY6QARRxKLQTBc6RNzMazA4NDo372eLGE0EYtVJ77akiWl
         1K2WRio8FELIw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 8/8] arm64: dts: qcom: msm8939-samsung-a7: Add touchscreen
Message-ID: <20230622020553.65878-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622020344.65745-1-linmengbo0689@protonmail.com>
References: <20230622020344.65745-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A7 uses a Cypress TrueTouch Generation 5 that is connected to blsp_i2c5.
Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index ea74b61782de..66e56ac59998 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -222,6 +222,33 @@ reg_touch_key: regulator-touch-key {
 =09=09pinctrl-names =3D "default";
 =09};
=20
+=09reg_tsp_vdd: regulator-tsp-vdd {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "tsp_vdd";
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09=09vin-supply =3D <&pm8916_s4>;
+
+=09=09gpio =3D <&tlmm 8 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&reg_tsp_io_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_vdd_tsp: regulator-vdd-tsp {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vdd_tsp";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09gpio =3D <&tlmm 73 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&reg_tsp_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
 =09reg_vibrator: regulator-vibrator {
 =09=09compatible =3D "regulator-fixed";
 =09=09regulator-name =3D "motor_en";
@@ -260,6 +287,24 @@ muic: extcon@25 {
 =09};
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@24 {
+=09=09compatible =3D "cypress,tt21000";
+
+=09=09reg =3D <0x24>;
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09vdd-supply =3D <&reg_vdd_tsp>;
+=09=09vddio-supply =3D <&reg_tsp_vdd>;
+
+=09=09pinctrl-0 =3D <&tsp_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -385,6 +430,20 @@ nfc_i2c_default: nfc-i2c-default-state {
 =09=09bias-disable;
 =09};
=20
+=09reg_tsp_en_default: reg-tsp-en-default-state {
+=09=09pins =3D "gpio73";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09reg_tsp_io_en_default: reg-tsp-io-en-default-state {
+=09=09pins =3D "gpio8";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09sdc2_cd_default: sdc2-cd-default-state {
 =09=09pins =3D "gpio38";
 =09=09function =3D "gpio";
@@ -426,4 +485,11 @@ tkey_led_en_default: tkey-led-en-default-state {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
+
+=09tsp_int_default: tsp-int-default-state {
+=09=09pins =3D "gpio13";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };
--=20
2.39.2


