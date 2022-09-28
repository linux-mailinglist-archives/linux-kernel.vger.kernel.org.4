Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3332A5EDB63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiI1LJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiI1LIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:21 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47BBE9CC3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:06:42 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664363199; x=1664622399;
        bh=/92kCfS+GRH3XqMQ3bWJNxBIL7UNiMfLCQcS7CPJ5ng=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ug4dh8P+fEjbf1yUvdjS9tWhjxFKVKrS76WgGRIokdqHsA4kiDrsjOwP4DpuiLqUq
         EBb9Kfb9ysKvOj1vOxj7bIvhhbdqzW46kqZBfgVIL2Ap27AZAg8QC+MCumSOvWQy0q
         Us3+filJfEDHXn0yCayQsZfCH/sAODM4ZZEx7+qT5KdhR+NKyEsySpvx3eB9T9C5pn
         tRdzD0HobwsegevS1f3KNNLfGHWJ6ns2LhArNphNwCaK/A4yFzESG7y6toHEbAtKNt
         nDWYIuwfsLcVpNoVaiDEtapcdGSVUGDxY17Y2D5/E7JxsPQAEtH03jpV4Lj6knOCJO
         g9VERuMpr9rrQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-samsung-j5-common: Add Hall sensor
Message-ID: <20220928110529.96373-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928110049.96047-1-linmengbo0689@protonmail.com>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Galaxy J5 2015 and 2016 have a Hall sensor on GPIO pin 52.
Add GPIO Hall sensor for them.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-samsung-j3.dts      |  4 +++
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j3.dts
index 24e77c61ca9b..6d4e53295c30 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
@@ -19,3 +19,7 @@ tz-apps@85a00000 {
 =09=09};
 =09};
 };
+
+&gpio_hall_sensor {
+=09status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index ea2e165c2aa4..2c498d3b2c83 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -3,6 +3,7 @@
 #include "msm8916-pm8916.dtsi"
=20
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
=20
 / {
 =09aliases {
@@ -21,6 +22,23 @@ tz-apps@85500000 {
 =09=09};
 =09};
=20
+=09gpio_hall_sensor: gpio-hall-sensor {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&gpio_hall_sensor_default>;
+
+=09=09label =3D "GPIO Hall Effect Sensor";
+
+=09=09event-hall-sensor {
+=09=09=09label =3D "Hall Effect Sensor";
+=09=09=09gpios =3D <&msmgpio 52 GPIO_ACTIVE_LOW>;
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_LID>;
+=09=09=09linux,can-disable;
+=09=09};
+=09};
+
 =09gpio-keys {
 =09=09compatible =3D "gpio-keys";
=20
@@ -193,6 +211,14 @@ l18 {
 };
=20
 &msmgpio {
+=09gpio_hall_sensor_default: gpio-hall-sensor-default {
+=09=09pins =3D "gpio52";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default {
 =09=09pins =3D "gpio107", "gpio109";
 =09=09function =3D "gpio";
--=20
2.30.2


