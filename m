Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C3739529
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFVCFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjFVCFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:05:30 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A991FC0;
        Wed, 21 Jun 2023 19:05:25 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399524; x=1687658724;
        bh=lk0OOcZZqXjPubb5cVQElXeFQG9G1YLjPnDEfHulQPo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=NBwraWtlAcl8HCfMSnJN779/bad9wq4IRTd3gSC+wQi/T1LFJiRLPV2ZZwE7VDPOa
         5YkeZ1VbFU/zW2Qbm/1GLvODJvl3/c70VDPhhErr5RX5DV5r8TUmLm3O4bCiyRVeye
         +dnlrD9+b5+MMkVrFUKXv24uYDrWvlU8wvjF3ZIasvYZhT9H9xXErA70FaUpX5xlOd
         c2UYgfxoiIgGDd8e3DgvPS7sPxYv8xx0GTNAhCE59XI89ePGrp8nNAlkoWSLbPUlk4
         zcvJ2+H/i0m8183jFkcLEEFYrkHW+TtnbuNKZPWCQVDJLJCTliS9xNDoacK0955MBj
         YDeJB4NeQMf3Q==
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
Subject: [PATCH 4/8] arm64: dts: qcom: msm8939-samsung-a7: Add accelerometer/magnetometer
Message-ID: <20230622020500.65806-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622020344.65745-1-linmengbo0689@protonmail.com>
References: <20230622020344.65745-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A7 uses a Bosch BMC150 accelerometer/magnetometer combo.
The chip provides two separate I2C devices for the accelerometer
and magnetometer that are already supported by the bmc150-accel
and bmc150-magn driver.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index 98a2738eb8ea..6a817038a3b9 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -69,6 +69,43 @@ button-home {
 =09=09};
 =09};
=20
+=09i2c-sensor {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 84 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 85 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&sensor_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09accelerometer: accelerometer@10 {
+=09=09=09compatible =3D "bosch,bmc150_accel";
+=09=09=09reg =3D <0x10>;
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <115 IRQ_TYPE_EDGE_RISING>;
+
+=09=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09=09pinctrl-names =3D "default";
+
+=09=09=09mount-matrix =3D "-1", "0", "0",
+=09=09=09=09=09"0", "-1", "0",
+=09=09=09=09=09"0", "0", "1";
+=09=09};
+
+=09=09magnetometer@12 {
+=09=09=09compatible =3D "bosch,bmc150_magn";
+=09=09=09reg =3D <0x12>;
+
+=09=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09=09vddio-supply =3D <&pm8916_l5>;
+=09=09};
+=09};
+
 =09i2c-tkey {
 =09=09compatible =3D "i2c-gpio";
 =09=09sda-gpios =3D <&tlmm 16 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
@@ -190,6 +227,13 @@ &wcnss_iris {
 };
=20
 &tlmm {
+=09accel_int_default: accel-int-default-state {
+=09=09pins =3D "gpio115";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 =09=09pins =3D "gpio52";
 =09=09function =3D "gpio";
@@ -218,6 +262,13 @@ sdc2_cd_default: sdc2-cd-default-state {
 =09=09bias-pull-up;
 =09};
=20
+=09sensor_i2c_default: sensor-i2c-default-state {
+=09=09pins =3D "gpio84", "gpio85";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09tkey_default: tkey-default-state {
 =09=09pins =3D "gpio20";
 =09=09function =3D "gpio";
--=20
2.39.2


