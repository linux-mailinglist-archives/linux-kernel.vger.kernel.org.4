Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4F5FFFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJPOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJPOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:34:43 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D87FD0C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 07:34:35 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665930873; x=1666190073;
        bh=ZseDGcoe4OIAaVlHQjhD3IczOM2W29Cg0YZOAMrNt2U=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=W9mEDBfEZuZtawNU2vQRfl78qSxztHlrNuh73JhAiAGuVgkO32Gzo75mZaYa7eFl4
         sfFff9PGi20DvfchCUgmR09LGOj4Y3kfWAq6J+lkx5ffwByANq2KW+mhRoC7bA2MO8
         OOSHpa3P0hbPHtE3k3uBtZh5C+MDC3zbSeifSvjQ=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/7] arm64: dts: qcom: sdm845-xiaomi-beryllium: commonize uart6 pinconf
Message-ID: <20221016143300.1738550-6-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new qup_uart6_4pin configuration in sd845.dtsi and fix alias
name.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 29 ++-----------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/ar=
m64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 82c27f90d300..1646db2328d4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -35,7 +35,7 @@ / {
 =09qcom,msm-id =3D <321 0x20001>;

 =09aliases {
-=09=09hsuart0 =3D &uart6;
+=09=09serial1 =3D &uart6;
 =09};

 =09gpio-keys {
@@ -481,6 +481,8 @@ wcd_intr_default: wcd_intr_default {
 &uart6 {
 =09status =3D "okay";

+=09pinctrl-0 =3D <&qup_uart6_4pin>;
+
 =09bluetooth {
 =09=09compatible =3D "qcom,wcn3990-bt";

@@ -567,28 +569,3 @@ &wifi {
 =09vdd-3.3-ch0-supply =3D <&vreg_l25a_3p3>;
 =09vdd-3.3-ch1-supply =3D <&vreg_l23a_3p3>;
 };
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-
-&qup_uart6_default {
-=09pinmux {
-=09=09pins =3D "gpio45", "gpio46", "gpio47", "gpio48";
-=09=09function =3D "qup6";
-=09};
-
-=09cts {
-=09=09pins =3D "gpio45";
-=09=09bias-disable;
-=09};
-
-=09rts-tx {
-=09=09pins =3D "gpio46", "gpio47";
-=09=09drive-strength =3D <2>;
-=09=09bias-disable;
-=09};
-
-=09rx {
-=09=09pins =3D "gpio48";
-=09=09bias-pull-up;
-=09};
-};
--
2.38.0


