Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB573952E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFVCFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFVCFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:05:36 -0400
X-Greylist: delayed 77 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 19:05:32 PDT
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878191BD8;
        Wed, 21 Jun 2023 19:05:32 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399530; x=1687658730;
        bh=uIImkaJUqEIc4EnN1u23yWQQQI9ILKskx9wiXhE1ldM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=C3ClYcTssq1Vu2nWdNc92Khz9hdkZelqa6LM+pU9NukIe8kweBetyyxEedAJ2CUac
         xCmL/nl53Nsx8D4dWdjUK0xnQPsz1i/DFcUEh8gbHYTNczV+rbzmHt8AZCUTFM2UYF
         es0BN+CclC1UFc1qDC1QjBeoFfoqx7Lq5Jx15xIdR/XH1znSYaDDjC/x1F0pv0s7Gf
         e+8GnJu2x8cxDy3SdHCCyjcp4046VrDwVoIuLDu31S9NjEEtBpw3FXTaqEzIQPQBR7
         Apa8imih8wsNzUKeaCGqYS70tjIDfpctEGgBAJcik2IzyLHrGbc6YEJppZhYGdDYFW
         6jMJQx+a24vFw==
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
Subject: [PATCH 5/8] arm64: dts: qcom: msm8939-samsung-a7: Add rt5033 battery
Message-ID: <20230622020515.65823-1-linmengbo0689@protonmail.com>
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

The Samsung Galaxy A7 uses a Richtek RT5033 PMIC as battery
fuel gauge, charger, flash LED and for some regulators. For now,
only add the fuel gauge/battery device to the device tree,
so we can check the remaining battery percentage.

The other RT5033 drivers need some more work first before
they can be used properly.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index 6a817038a3b9..271dcea6da94 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -69,6 +69,29 @@ button-home {
 =09=09};
 =09};
=20
+=09i2c-fg {
+=09=09compatible =3D "i2c-gpio";
+=09=09sda-gpios =3D <&tlmm 106 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+=09=09scl-gpios =3D <&tlmm 105 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+=09=09pinctrl-0 =3D <&fg_i2c_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+
+=09=09battery@35 {
+=09=09=09compatible =3D "richtek,rt5033-battery";
+=09=09=09reg =3D <0x35>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <121 IRQ_TYPE_EDGE_BOTH>;
+
+=09=09=09pinctrl-0 =3D <&fg_alert_default>;
+=09=09=09pinctrl-names =3D "default";
+=09=09};
+=09};
+
 =09i2c-sensor {
 =09=09compatible =3D "i2c-gpio";
 =09=09sda-gpios =3D <&tlmm 84 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
@@ -234,6 +257,20 @@ accel_int_default: accel-int-default-state {
 =09=09bias-disable;
 =09};
=20
+=09fg_alert_default: fg-alert-default-state {
+=09=09pins =3D "gpio121";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09fg_i2c_default: fg-i2c-default-state {
+=09=09pins =3D "gpio105", "gpio106";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 =09=09pins =3D "gpio52";
 =09=09function =3D "gpio";
--=20
2.39.2


