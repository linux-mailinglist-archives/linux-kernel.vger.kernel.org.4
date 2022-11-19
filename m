Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A546310FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiKSUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiKSUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:46:44 -0500
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC313D21;
        Sat, 19 Nov 2022 12:46:42 -0800 (PST)
Date:   Sat, 19 Nov 2022 20:46:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668890800; x=1669150000;
        bh=RZgjb9/5OQctpPzuTFDZDZE4FEfMwb4kqi0lsraby84=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ARKQ8VA9knhvcAfXpsxDnxrvqNwZOf1eeKlNoLCZILlbyINeCmEyiGBmm3yOIzHND
         rs+0f/vrgcVtTdKQO58lwfH8N9hSjeU1oQtKAyW8vh8oRfAMWuNblgHmBzZjXXrBqD
         4eJfFC7RntzQedsBVPZ0CyDPLu4WJr8/6u2uirxeIgod1EuBxKRHq0Qxa152g8GTSd
         uXLX11E1cMFF9Ddg2BkpB1fRMUi94M2rDMYQek29QPDr1Vlp8Qm4W2OZDLLFP0uVKH
         Eahkap9GnP3C4uVFZ0L50KQ7qI0sywNMnanQGVuz3a1PdiVdw8i0VdVhJAzLIIKR1O
         IUMUaw3Fd4GWg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8916-acer-a1-724: Add accelerometer/magnetometer
Message-ID: <20221119204424.94341-1-linmengbo0689@protonmail.com>
In-Reply-To: <20221119204209.94125-1-linmengbo0689@protonmail.com>
References: <20221119204209.94125-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iconia Talk S uses a Bosch BMC150 accelerometer/magnetometer combo.
The chip provides two separate I2C devices for the accelerometer
and magnetometer that are already supported by the bmc150-accel
and bmc150-magn driver.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/=
boot/dts/qcom/msm8916-acer-a1-724.dts
index acd909551a75..3461a39ee866 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -6,6 +6,7 @@
=20
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
=20
 /*
  * NOTE: The original firmware from Acer can only boot 32-bit kernels.
@@ -51,6 +52,35 @@ usb_id: usb-id {
 =09};
 };
=20
+&blsp_i2c2 {
+=09status =3D "okay";
+
+=09accelerometer@10 {
+=09=09compatible =3D "bosch,bmc150_accel";
+=09=09reg =3D <0x10>;
+=09=09interrupt-parent =3D <&msmgpio>;
+=09=09interrupts =3D <115 IRQ_TYPE_EDGE_RISING>;
+
+=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&accel_int_default>;
+
+=09=09mount-matrix =3D "0", "-1", "0",
+=09=09=09       "-1", "0", "0",
+=09=09=09       "0", "0", "1";
+=09};
+
+=09magnetometer@12 {
+=09=09compatible =3D "bosch,bmc150_magn";
+=09=09reg =3D <0x12>;
+
+=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09vddio-supply =3D <&pm8916_l6>;
+=09};
+};
+
 &blsp1_uart2 {
 =09status =3D "okay";
 };
@@ -199,6 +229,14 @@ l18 {
 };
=20
 &msmgpio {
+=09accel_int_default: accel-int-default-state {
+=09=09pins =3D "gpio115";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107";
 =09=09function =3D "gpio";
--=20
2.30.2


