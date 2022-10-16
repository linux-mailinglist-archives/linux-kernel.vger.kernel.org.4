Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCD5FFFCC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJPOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJPOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:34:06 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F031FB9;
        Sun, 16 Oct 2022 07:34:05 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665930843; x=1666190043;
        bh=JEVAZQ0D4waNBxYHVoLfbrQUbmflsCHE5YKCwexm9CU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=qaesTPgTHMxLXLJopiRzyYDQzhpja8TNn3HxjSHr4Fxxaq4Ym54RdH4r+YFNKh0I+
         9ofIy6atx4rezeMQulJxrgx3+ga+WKfpRJYIkewVWsYWcXVB1b5FEMjxJGIOlkG01r
         qI91+L27bGkzD3nf/shGJ+h+ztIzDyi7/lBMqBd8=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/7] arm64: dts: qcom: sdm845-cheza: commonize uart6 pinconf
Message-ID: <20221016143300.1738550-3-caleb@connolly.tech>
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
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 39 ++--------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/d=
ts/qcom/sdm845-cheza.dtsi
index b5eb8f7eca1d..a8ae6de51af4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -16,7 +16,7 @@
 / {
 =09aliases {
 =09=09bluetooth0 =3D &bluetooth;
-=09=09hsuart0 =3D &uart6;
+=09=09serial1 =3D &uart6;
 =09=09serial0 =3D &uart9;
 =09=09wifi0 =3D &wifi;
 =09};
@@ -860,6 +860,8 @@ i2c_tunnel: i2c-tunnel {
 &uart6 {
 =09status =3D "okay";

+=09pinctrl-0 =3D <&qup_uart6_4pin>;
+
 =09bluetooth: wcn3990-bt {
 =09=09compatible =3D "qcom,wcn3990-bt";
 =09=09vddio-supply =3D <&src_pp1800_s4a>;
@@ -1079,41 +1081,6 @@ pinconf {
 =09};
 };

-&qup_uart6_default {
-=09/* Change pinmux to all 4 pins since CTS and RTS are connected */
-=09pinmux {
-=09=09pins =3D "gpio45", "gpio46",
-=09=09       "gpio47", "gpio48";
-=09};
-
-=09pinconf-cts {
-=09=09/*
-=09=09 * Configure a pull-down on 45 (CTS) to match the pull of
-=09=09 * the Bluetooth module.
-=09=09 */
-=09=09pins =3D "gpio45";
-=09=09bias-pull-down;
-=09};
-
-=09pinconf-rts-tx {
-=09=09/* We'll drive 46 (RTS) and 47 (TX), so no pull */
-=09=09pins =3D "gpio46", "gpio47";
-=09=09drive-strength =3D <2>;
-=09=09bias-disable;
-=09};
-
-=09pinconf-rx {
-=09=09/*
-=09=09 * Configure a pull-up on 48 (RX). This is needed to avoid
-=09=09 * garbage data when the TX pin of the Bluetooth module is
-=09=09 * in tri-state (module powered off or not driving the
-=09=09 * signal yet).
-=09=09 */
-=09=09pins =3D "gpio48";
-=09=09bias-pull-up;
-=09};
-};
-
 &qup_uart9_default {
 =09pinconf-tx {
 =09=09pins =3D "gpio4";
--
2.38.0


