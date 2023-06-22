Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4B739525
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFVCFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjFVCFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:05:15 -0400
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBA1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:05:09 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:04:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399508; x=1687658708;
        bh=FCm+LLmKGdTwYZa44TvNge6VPclbxNgOtwQ/JZjfxVg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vQSOl7LdADyVUI/tt9Oocyp5M0iV2Byv+zwXhGBqN9bFfpBXGcMtu+5z+/9ucUNbF
         WhJwUeEQT0KvlaL6H6j1Pjvig2ZdxktOp2lkJ36BGPkgvVCKCsCVxW1+9ZEQLGCGIq
         4i3dzWJii+CWxO9Rj2F/bkx4tJ57rzboNw7ggJxWzEFQ1vRAxd5vnijySSbFOSMRkp
         jvhsD+L+N+3MUchrZPzeEp8mPkozyjyzPQATql86gGtoShf7bIs5J31wf8R0fSaGJL
         vSV+cVuv+NMDdtBJHbMyE+rcbbiRLOXKOc39JF3uig5wBEFmVMaoYbqk3RGAv1kCYP
         OVjtWvUwvd8vA==
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
Subject: [PATCH 3/8] arm64: dts: qcom: msm8939-samsung-a7: Add touch key
Message-ID: <20230622020448.65791-1-linmengbo0689@protonmail.com>
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

Add the CORERIVER TC360 touch key together with the necessary
fixed regulator for it.

Note that for some reason Samsung decided to connect this to GPIOs
where no hardware I2C bus is available, so we need to fall back
to software bit-banging using i2c-gpio.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index cf2738bc3313..98a2738eb8ea 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -68,6 +68,63 @@ button-home {
 =09=09=09linux,code =3D <KEY_HOMEPAGE>;
 =09=09};
 =09};
+
+=09i2c-tkey {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 16 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 17 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&tkey_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09touchkey@20 {
+=09=09=09/* Note: Actually an ABOV MCU that implements same interface */
+=09=09=09compatible =3D "coreriver,tc360-touchkey";
+=09=09=09reg =3D <0x20>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <20 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09=09vcc-supply =3D <&reg_touch_key>;
+=09=09=09vdd-supply =3D <&reg_keyled>;
+=09=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
+
+=09=09=09pinctrl-0 =3D <&tkey_default>;
+=09=09=09pinctrl-names =3D "default";
+=09=09};
+=09};
+
+=09reg_keyled: regulator-keyled {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "keyled";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09/* NOTE: On some variants e.g. SM-A700FD it's GPIO 91 */
+=09=09gpio =3D <&tlmm 100 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tkey_led_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+
+=09reg_touch_key: regulator-touch-key {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "touch_key";
+=09=09regulator-min-microvolt =3D <2800000>;
+=09=09regulator-max-microvolt =3D <2800000>;
+
+=09=09gpio =3D <&tlmm 56 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tkey_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
 };
=20
 &blsp_i2c1 {
@@ -160,4 +217,32 @@ sdc2_cd_default: sdc2-cd-default-state {
 =09=09drive-strength =3D <2>;
 =09=09bias-pull-up;
 =09};
+
+=09tkey_default: tkey-default-state {
+=09=09pins =3D "gpio20";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_en_default: tkey-en-default-state {
+=09=09pins =3D "gpio56";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_i2c_default: tkey-i2c-default-state {
+=09=09pins =3D "gpio16", "gpio17";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tkey_led_en_default: tkey-led-en-default-state {
+=09=09pins =3D "gpio100";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };
--=20
2.39.2


