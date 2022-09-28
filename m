Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520435EDB61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiI1LJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiI1LIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:16 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832191E73D;
        Wed, 28 Sep 2022 04:06:29 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664363185; x=1664622385;
        bh=0sGAL85wiOF088EQhozFuwahWrTQJ3ncDtUu4+bT6Vo=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=UXVgrqztn1LGmOfvnks6SI7ZTI9ymZ6QXkBAfYXAyywSqfDR1wU9afIpNIt7YwWXu
         /iY2nz6Xg1uDaGYC8yZWiir15Z1VmgZJJo/lT8pTOQJVYvsets/qzE3vy93oy1GuY1
         nJwplG0IFJWbPizwHE6sSZ14hoVHdbK4NQtUlofKhAEgXMi9YNdE1sBQcKWJ47T/HU
         vqAvz7oDAeTA3P3llxqYoSm1yPGLtVl6WnNHZYR4iVnIoBR15Pja2TeTUUt9J+kVf9
         5olyNk7BcE+GEuaYbAsifEAWqw3UFJoeSexVtjTuJr8bXjfsKhm0OWOku+GKwo0xh1
         yz7wHnxoajw5A==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 2/3] arm64: dts: qcom: msm8916-samsung-j5: Use common init device tree
Message-ID: <20220928110516.96318-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928110049.96047-1-linmengbo0689@protonmail.com>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smartphones below are using the MSM8916 SoC,
which are released in 2015-2016:

Samsung Galaxy J5 2015 (SM-J500*)
Samsung Galaxy J5 2016 (SM-J510*)
Samsung Galaxy J3 2016
- SM-J3109/SM-J320Y/SM-J320YZ
- SM-J320N0/SM-J320ZN
- SM-J320P/SM-J320R4/SM-J320V/SM-S320VL

Add a common device tree for with initial support for:

- GPIO keys
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5703 MUIC)
- WCNSS (WiFi/BT)
- Regulators

The three devices (some varints of J3, all other variants of J5 released
in 2015 and J5X released in 2016) are very similar, with some differences
in display and GPIO pins. The common parts are shared in
msm8916-samsung-j5-common.dtsi to reduce duplication.

[Add j5x device tree]
Co-developed-by: Josef W Menad <JosefWMenad@protonmail.ch>
Signed-off-by: Josef W Menad <JosefWMenad@protonmail.ch>
[Use &pm8916_usbin as USB extcon and add chassis-type for j5x]
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Use common init device tree and add j3 device tree]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8916-samsung-j3.dts      |  21 ++
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 203 ++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-j5.dts      | 196 +----------------
 .../boot/dts/qcom/msm8916-samsung-j5x.dts     |  11 +
 5 files changed, 238 insertions(+), 195 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index 1d86a33de528..357a2529fe74 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -15,7 +15,9 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-longcheer-l8910.dt=
b
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a5u-eur.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j3.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5x.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8992-lg-bullhead-rev-10.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j3.dts
new file mode 100644
index 000000000000..24e77c61ca9b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j3.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-j5-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy J3 (2016)";
+=09compatible =3D "samsung,j3", "qcom,msm8916";
+=09chassis-type =3D "handset";
+
+=09reserved-memory {
+=09=09/delete-node/ tz-apps@85500000;
+
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85a00000 {
+=09=09=09reg =3D <0x0 0x85800000 0x0 0x800000>;
+=09=09=09no-map;
+=09=09};
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch=
/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
new file mode 100644
index 000000000000..ea2e165c2aa4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-pm8916.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+=09aliases {
+=09=09serial0 =3D &blsp1_uart2;
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial0";
+=09};
+
+=09reserved-memory {
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85500000 {
+=09=09=09reg =3D <0x0 0x85500000 0x0 0xb00000>;
+=09=09=09no-map;
+=09=09};
+=09};
+
+=09gpio-keys {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&gpio_keys_default>;
+
+=09=09label =3D "GPIO Buttons";
+
+=09=09button-volume-up {
+=09=09=09label =3D "Volume Up";
+=09=09=09gpios =3D <&msmgpio 107 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_VOLUMEUP>;
+=09=09};
+
+=09=09button-home {
+=09=09=09label =3D "Home Key";
+=09=09=09gpios =3D <&msmgpio 109 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_HOMEPAGE>;
+=09=09};
+=09};
+};
+
+&blsp1_uart2 {
+=09status =3D "okay";
+};
+
+&pm8916_resin {
+=09status =3D "okay";
+=09linux,code =3D <KEY_VOLUMEDOWN>;
+};
+
+/* FIXME: Replace with SM5703 MUIC when driver is available */
+&pm8916_usbin {
+=09status =3D "okay";
+};
+
+&pronto {
+=09status =3D "okay";
+};
+
+&sdhc_1 {
+=09status =3D "okay";
+
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
+=09pinctrl-1 =3D <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+};
+
+&sdhc_2 {
+=09status =3D "okay";
+
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+=09pinctrl-1 =3D <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>=
;
+
+=09cd-gpios =3D <&msmgpio 38 GPIO_ACTIVE_LOW>;
+};
+
+&usb {
+=09status =3D "okay";
+=09dr_mode =3D "peripheral";
+=09extcon =3D <&pm8916_usbin>;
+};
+
+&usb_hs_phy {
+=09extcon =3D <&pm8916_usbin>;
+};
+
+&smd_rpm_regulators {
+=09vdd_l1_l2_l3-supply =3D <&pm8916_s3>;
+=09vdd_l4_l5_l6-supply =3D <&pm8916_s4>;
+=09vdd_l7-supply =3D <&pm8916_s4>;
+
+=09s3 {
+=09=09regulator-min-microvolt =3D <1200000>;
+=09=09regulator-max-microvolt =3D <1300000>;
+=09};
+
+=09s4 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <2100000>;
+=09};
+
+=09l1 {
+=09=09regulator-min-microvolt =3D <1225000>;
+=09=09regulator-max-microvolt =3D <1225000>;
+=09};
+
+=09l2 {
+=09=09regulator-min-microvolt =3D <1200000>;
+=09=09regulator-max-microvolt =3D <1200000>;
+=09};
+
+=09l4 {
+=09=09regulator-min-microvolt =3D <2050000>;
+=09=09regulator-max-microvolt =3D <2050000>;
+=09};
+
+=09l5 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09};
+
+=09l6 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09};
+
+=09l7 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+=09};
+
+=09l8 {
+=09=09regulator-min-microvolt =3D <2850000>;
+=09=09regulator-max-microvolt =3D <2900000>;
+=09};
+
+=09l9 {
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l10 {
+=09=09regulator-min-microvolt =3D <2700000>;
+=09=09regulator-max-microvolt =3D <2800000>;
+=09};
+
+=09l11 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <2950000>;
+=09=09regulator-allow-set-load;
+=09=09regulator-system-load =3D <200000>;
+=09};
+
+=09l12 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <2950000>;
+=09};
+
+=09l13 {
+=09=09regulator-min-microvolt =3D <3075000>;
+=09=09regulator-max-microvolt =3D <3075000>;
+=09};
+
+=09l14 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l15 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l16 {
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09};
+
+=09l17 {
+=09=09regulator-min-microvolt =3D <3000000>;
+=09=09regulator-max-microvolt =3D <3000000>;
+=09};
+
+=09l18 {
+=09=09regulator-min-microvolt =3D <2700000>;
+=09=09regulator-max-microvolt =3D <2700000>;
+=09};
+};
+
+&msmgpio {
+=09gpio_keys_default: gpio-keys-default {
+=09=09pins =3D "gpio107", "gpio109";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-j5.dts
index eabeed18cfaa..0a32d33e9778 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -2,208 +2,14 @@
=20
 /dts-v1/;
=20
-#include "msm8916-pm8916.dtsi"
-#include <dt-bindings/gpio/gpio.h>
+#include "msm8916-samsung-j5-common.dtsi"
=20
 / {
 =09model =3D "Samsung Galaxy J5 (2015)";
 =09compatible =3D "samsung,j5", "qcom,msm8916";
 =09chassis-type =3D "handset";
-
-=09aliases {
-=09=09serial0 =3D &blsp1_uart2;
-=09};
-
-=09chosen {
-=09=09stdout-path =3D "serial0";
-=09};
-
-=09reserved-memory {
-=09=09/* Additional memory used by Samsung firmware modifications */
-=09=09tz-apps@85500000 {
-=09=09=09reg =3D <0x0 0x85500000 0x0 0xb00000>;
-=09=09=09no-map;
-=09=09};
-=09};
-
-=09gpio-keys {
-=09=09compatible =3D "gpio-keys";
-
-=09=09pinctrl-names =3D "default";
-=09=09pinctrl-0 =3D <&gpio_keys_default>;
-
-=09=09label =3D "GPIO Buttons";
-
-=09=09button-volume-up {
-=09=09=09label =3D "Volume Up";
-=09=09=09gpios =3D <&msmgpio 107 GPIO_ACTIVE_LOW>;
-=09=09=09linux,code =3D <KEY_VOLUMEUP>;
-=09=09};
-
-=09=09button-home {
-=09=09=09label =3D "Home Key";
-=09=09=09gpios =3D <&msmgpio 109 GPIO_ACTIVE_LOW>;
-=09=09=09linux,code =3D <KEY_HOMEPAGE>;
-=09=09};
-=09};
-};
-
-&blsp1_uart2 {
-=09status =3D "okay";
-};
-
-&pm8916_resin {
-=09status =3D "okay";
-=09linux,code =3D <KEY_VOLUMEDOWN>;
-};
-
-/* FIXME: Replace with SM5703 MUIC when driver is available */
-&pm8916_usbin {
-=09status =3D "okay";
-};
-
-&pronto {
-=09status =3D "okay";
-};
-
-&sdhc_1 {
-=09status =3D "okay";
-
-=09pinctrl-names =3D "default", "sleep";
-=09pinctrl-0 =3D <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-=09pinctrl-1 =3D <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
-};
-
-&sdhc_2 {
-=09status =3D "okay";
-
-=09pinctrl-names =3D "default", "sleep";
-=09pinctrl-0 =3D <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-=09pinctrl-1 =3D <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>=
;
-
-=09cd-gpios =3D <&msmgpio 38 GPIO_ACTIVE_LOW>;
-};
-
-&usb {
-=09status =3D "okay";
-=09dr_mode =3D "peripheral";
-=09extcon =3D <&pm8916_usbin>;
 };
=20
 &usb_hs_phy {
-=09extcon =3D <&pm8916_usbin>;
 =09qcom,init-seq =3D /bits/ 8 <0x1 0x19 0x2 0x0b>;
 };
-
-&smd_rpm_regulators {
-=09vdd_l1_l2_l3-supply =3D <&pm8916_s3>;
-=09vdd_l4_l5_l6-supply =3D <&pm8916_s4>;
-=09vdd_l7-supply =3D <&pm8916_s4>;
-
-=09s3 {
-=09=09regulator-min-microvolt =3D <1200000>;
-=09=09regulator-max-microvolt =3D <1300000>;
-=09};
-
-=09s4 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <2100000>;
-=09};
-
-=09l1 {
-=09=09regulator-min-microvolt =3D <1225000>;
-=09=09regulator-max-microvolt =3D <1225000>;
-=09};
-
-=09l2 {
-=09=09regulator-min-microvolt =3D <1200000>;
-=09=09regulator-max-microvolt =3D <1200000>;
-=09};
-
-=09l4 {
-=09=09regulator-min-microvolt =3D <2050000>;
-=09=09regulator-max-microvolt =3D <2050000>;
-=09};
-
-=09l5 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <1800000>;
-=09};
-
-=09l6 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <1800000>;
-=09};
-
-=09l7 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <1800000>;
-=09};
-
-=09l8 {
-=09=09regulator-min-microvolt =3D <2850000>;
-=09=09regulator-max-microvolt =3D <2900000>;
-=09};
-
-=09l9 {
-=09=09regulator-min-microvolt =3D <3300000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-=09};
-
-=09l10 {
-=09=09regulator-min-microvolt =3D <2700000>;
-=09=09regulator-max-microvolt =3D <2800000>;
-=09};
-
-=09l11 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <2950000>;
-=09=09regulator-allow-set-load;
-=09=09regulator-system-load =3D <200000>;
-=09};
-
-=09l12 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <2950000>;
-=09};
-
-=09l13 {
-=09=09regulator-min-microvolt =3D <3075000>;
-=09=09regulator-max-microvolt =3D <3075000>;
-=09};
-
-=09l14 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-=09};
-
-=09l15 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-=09};
-
-=09l16 {
-=09=09regulator-min-microvolt =3D <1800000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-=09};
-
-=09l17 {
-=09=09regulator-min-microvolt =3D <3000000>;
-=09=09regulator-max-microvolt =3D <3000000>;
-=09};
-
-=09l18 {
-=09=09regulator-min-microvolt =3D <2700000>;
-=09=09regulator-max-microvolt =3D <2700000>;
-=09};
-};
-
-&msmgpio {
-=09gpio_keys_default: gpio-keys-default {
-=09=09pins =3D "gpio107", "gpio109";
-=09=09function =3D "gpio";
-
-=09=09drive-strength =3D <2>;
-=09=09bias-pull-up;
-=09};
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts b/arch/arm64/=
boot/dts/qcom/msm8916-samsung-j5x.dts
new file mode 100644
index 000000000000..7656ac4508cf
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-j5-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy J5 (2016)";
+=09compatible =3D "samsung,j5x", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
--=20
2.30.2


