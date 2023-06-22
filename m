Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EFC739531
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjFVCGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFVCFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:05:55 -0400
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58191992;
        Wed, 21 Jun 2023 19:05:49 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399548; x=1687658748;
        bh=wbmH1oH6ly/6UPYctPqfteW/k7noLOx6DZi3okRB1Ok=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=c5b3GWg8+t1vwqKJS6ttd6IEIUcJlacQMYofXtzNyXc2L72VvVC9gUOZLxsYS6fAY
         x84JqmCOFCFtgKvzAu+KrfpnQs0HP6SBCGKSjPfnaIS2mWCEidMhGCvNrDH2zCtgK3
         AW0mYGAr5PYmiWw68Ex1/C4xZm/R/I//xKRPbKrpt0ghdwEvSLQeiL3XUH7JcLXtsc
         FPizCTmyf117BGG7pnK6fpItRlWp0XTV7DSjp8At6zz7UbOcX/3PDY04DuSJpHJmT2
         gD04EVdkrYfEjpVTwSsjpmY9VN3zvxTWFHGE9uuE1H/kOLufIOMONS11OzTL53XCKo
         ADyIsgP0E86Zw==
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
Subject: [PATCH 6/8] arm64: dts: qcom: msm8939-samsung-a7: Add NFC
Message-ID: <20230622020530.65845-1-linmengbo0689@protonmail.com>
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

The Galaxy A7 has a NXP PN547, which is supported
by the nxp-nci-i2c driver in mainline. It seems to detect NFC tags
using "nfctool" just fine, although more testing is difficult given
there seem to be very few useful applications making use of the
Linux NFC subsystem.

Note that for some reason Samsung decided to connect the I2C pins
to GPIOs where no hardware I2C bus is available, so we need to
fall back to software bit-banging with i2c-gpio.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index 271dcea6da94..dcbc8a97ce63 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -92,6 +92,32 @@ battery@35 {
 =09=09};
 =09};
=20
+=09i2c-nfc {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&nfc_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09nfc@2b {
+=09=09=09compatible =3D "nxp,pn547", "nxp,nxp-nci-i2c";
+=09=09=09reg =3D <0x2b>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <21 IRQ_TYPE_EDGE_RISING>;
+
+=09=09=09enable-gpios =3D <&tlmm 116 GPIO_ACTIVE_HIGH>;
+=09=09=09firmware-gpios =3D <&tlmm 49 GPIO_ACTIVE_HIGH>;
+
+=09=09=09pinctrl-0 =3D <&nfc_default>;
+=09=09=09pinctrl-names =3D "default";
+=09=09};
+=09};
+
 =09i2c-sensor {
 =09=09compatible =3D "i2c-gpio";
 =09=09sda-gpios =3D <&tlmm 84 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
@@ -292,6 +318,29 @@ muic_int_default: muic-int-default-state {
 =09=09bias-disable;
 =09};
=20
+=09nfc_default: nfc-default-state {
+=09=09irq-pins {
+=09=09=09pins =3D "gpio21";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-pull-down;
+=09=09};
+
+=09=09nfc-pins {
+=09=09=09pins =3D "gpio49", "gpio116";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+=09};
+
+=09nfc_i2c_default: nfc-i2c-default-state {
+=09=09pins =3D "gpio0", "gpio1";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09sdc2_cd_default: sdc2-cd-default-state {
 =09=09pins =3D "gpio38";
 =09=09function =3D "gpio";
--=20
2.39.2


