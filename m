Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C357393AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjFVAQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFVAQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:16:38 -0400
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D291FED
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:16:05 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:05:33 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TYl9sBM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687392349; x=1687651549;
        bh=4SJtCK0x5F//Ag420gz6tCmHCCiBdGr2OH4BylyuTHc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=TYl9sBM/w6FRIJndST1C0wRCDk4EYlMAdB8YxoBzIVFSXuVr0u+3ooYLZuU64sTUy
         u5ZstxgXTukjqkbEuC9mkfXU7r0hZf5tSrRlmtLr2VaTc/yo6rJNj4Pre9QqCZLFwR
         jf8QMkePu/6Co2y+IXSrIGd8FGUBmAFBgT0KCGPTCD2IWlqB5OJcZ/iD4IrNRTNHBx
         lRu5xVmd6naYQ6BkaFEmWauIFP2eyTDR0PMO16QhIyQK+DtQypj+rM4STpqy+ANWt3
         y9SD9HRwY0cqq8/FtNskLqmBG/n0biIConVB2l20mxwsXW/vEtaZ2Uv9G2hsyKYMYO
         LOTBtvbXN/rmw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Joe Mason <buddyjojo06@outlook.com>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 7/7] arm64: dts: qcom: msm8916-samsung-fortuna: Add NFC
Message-ID: <20230622000437.48367-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622000007.48219-1-linmengbo0689@protonmail.com>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Mason <buddyjojo06@outlook.com>

The Samsung Galaxy Ace 4, Core Prime and some Grand Prime have a
Samsung S3FWRN5 NFC chip that works quite well with the s3fwrn5 driver
in the Linux NFC subsystem.

The clock setup for the NFC chip is a bit special (although this
seems to be a common approach used for Qualcomm devices with NFC):

The NFC chip has an output GPIO that is asserted whenever the clock
is needed to function properly. On the A3/A5 this is wired up to
PM8916 GPIO2, which is then configured with a special function
(NFC_CLK_REQ or BB_CLK2_REQ).

Enabling the rpmcc RPM_SMD_BB_CLK2_PIN clock will then instruct
PM8916 to automatically enable the clock whenever the NFC chip
requests it. The advantage is that the clock is only enabled when
needed and we don't need to manage it ourselves from the NFC driver.

Grand Prime SM-G530Y (fortunaltezt) has a NXP PN547, which is supported
by the nxp-nci-i2c driver in mainline.

It seems to detect NFC tags using "nfctool" just fine, although more
testing is difficult given there seem to be very few useful applications
making use of the Linux NFC subsystem.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
[Put i2c-nfc and NFC pinctrl into fortuna.dtsi to share it with other varia=
nts]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Add pn547_nfc]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../dts/qcom/msm8216-samsung-fortuna3g.dts    |  5 ++
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 81 +++++++++++++++++++
 .../dts/qcom/msm8916-samsung-fortunaltezt.dts |  4 +
 .../dts/qcom/msm8916-samsung-gprimeltecan.dts | 25 ++++++
 .../qcom/msm8916-samsung-grandprimelte.dts    |  4 +
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  4 +
 6 files changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts b/arch/=
arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
index e7f6df229f9a..694a9962ee22 100644
--- a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
+++ b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
@@ -10,6 +10,11 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&i2c_nfc {
+=09/* 3G variant doesn't have NFC */
+=09status =3D "disabled";
+};
+
 &st_accel {
 =09status =3D "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index 0436b8ccc3e8..e58cce5d1879 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
=20
 / {
 =09aliases {
@@ -52,6 +53,53 @@ haptic {
 =09=09max-microvolt =3D <3300000>;
 =09};
=20
+=09i2c_nfc: i2c-nfc {
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
+=09=09/* Available NFC chip varies depending on model variant */
+=09=09pn547_nfc: nfc@2b {
+=09=09=09compatible =3D "nxp,pn547", "nxp,nxp-nci-i2c";
+=09=09=09reg =3D <0x2b>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <21 IRQ_TYPE_EDGE_RISING>;
+
+=09=09=09enable-gpios =3D <&tlmm 20 GPIO_ACTIVE_HIGH>;
+=09=09=09firmware-gpios =3D <&tlmm 49 GPIO_ACTIVE_HIGH>;
+
+=09=09=09pinctrl-0 =3D <&nfc_default>;
+=09=09=09pinctrl-names =3D "default";
+
+=09=09=09status =3D "disabled";
+=09=09};
+
+=09=09s3fwrn5_nfc: nfc@27 {
+=09=09=09compatible =3D "samsung,s3fwrn5-i2c";
+=09=09=09reg =3D <0x27>;
+
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <21 IRQ_TYPE_EDGE_RISING>;
+
+=09=09=09en-gpios =3D <&tlmm 20 GPIO_ACTIVE_HIGH>;
+=09=09=09wake-gpios =3D <&tlmm 49 GPIO_ACTIVE_HIGH>;
+
+=09=09=09clocks =3D <&rpmcc RPM_SMD_BB_CLK2_PIN>;
+
+=09=09=09pinctrl-0 =3D <&nfc_default>, <&nfc_clk_req>;
+=09=09=09pinctrl-names =3D "default";
+
+=09=09=09status =3D "disabled";
+=09=09};
+=09};
+
 =09reg_motor_vdd: regulator-motor-vdd {
 =09=09compatible =3D "regulator-fixed";
 =09=09regulator-name =3D "motor_vdd";
@@ -286,6 +334,29 @@ muic_int_default: muic-int-default-state {
 =09=09bias-disable;
 =09};
=20
+=09nfc_default: nfc-default-state {
+=09=09nfc-pins {
+=09=09=09pins =3D "gpio20", "gpio49";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+
+=09=09irq-pins {
+=09=09=09pins =3D "gpio21";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-pull-down;
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
@@ -307,3 +378,13 @@ tsp_int_default: tsp-int-default-state {
 =09=09bias-disable;
 =09};
 };
+
+&pm8916_gpios {
+=09nfc_clk_req: nfc-clk-req-state {
+=09=09pins =3D "gpio2";
+=09=09function =3D "func1";
+=09=09power-source =3D <PM8916_GPIO_L2>;
+=09=09bias-disable;
+=09=09input-enable;
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts
index 0716ef577df1..eb033f555184 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortunaltezt.dts
@@ -22,6 +22,10 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&pn547_nfc {
+=09status =3D "okay";
+};
+
 &st_accel {
 =09compatible =3D "st,lis2hh12";
 =09mount-matrix =3D "1",  "0", "0",
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
index b0d8ac3d6ce9..1a24e00e2024 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
@@ -21,6 +21,26 @@ tz-apps@85500000 {
 =09};
 };
=20
+&blsp_i2c6 {
+=09status =3D "okay";
+
+=09nfc@27 {
+=09=09compatible =3D "samsung,s3fwrn5-i2c";
+=09=09reg =3D <0x27>;
+
+=09=09interrupt-parent =3D <&tlmm>;
+=09=09interrupts =3D <21 IRQ_TYPE_EDGE_RISING>;
+
+=09=09en-gpios =3D <&tlmm 20 GPIO_ACTIVE_HIGH>;
+=09=09wake-gpios =3D <&tlmm 49 GPIO_ACTIVE_HIGH>;
+
+=09=09clocks =3D <&rpmcc RPM_SMD_BB_CLK2_PIN>;
+
+=09=09pinctrl-0 =3D <&nfc_default>, <&nfc_clk_req>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &bosch_accel {
 =09status =3D "okay";
 };
@@ -28,3 +48,8 @@ &bosch_accel {
 &bosch_magn {
 =09status =3D "okay";
 };
+
+&i2c_nfc {
+=09/* Used for MFD instead. NFC is on i2c6 */
+=09status =3D "disabled";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
index f7fc538fda04..090b8fb6b444 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
@@ -17,3 +17,7 @@ &bosch_accel {
 &bosch_magn {
 =09status =3D "okay";
 };
+
+&s3fwrn5_nfc {
+=09status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
index 39f99b5030e5..dbc4ee8719a6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -23,6 +23,10 @@ &blsp_i2c5 {
 =09/delete-node/ touchscreen@20;
 };
=20
+&s3fwrn5_nfc {
+=09status =3D "okay";
+};
+
 &st_accel {
 =09compatible =3D "st,lis2hh12";
 =09mount-matrix =3D "1",  "0", "0",
--=20
2.39.2


