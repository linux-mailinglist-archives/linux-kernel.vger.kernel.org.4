Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058105FFFD2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJPOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJPOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:34:30 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE62BD5;
        Sun, 16 Oct 2022 07:34:27 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665930865; x=1666190065;
        bh=fOCEUqTzrXFvKLyulfGNIl6TWBAPrPGAVzA0GPmNZp4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=jvg2Afnb7lNXtSHQRAvsjLjjFCSTWNbEuyL9FsM/iSEvhQgRG31i23j1NcHavuRXx
         tewtThbEftr3ReSjgGcjyge9WgswjI7hGMjIXESXZ3Dft2gNr1/MEHA5aolAEl2EOY
         V/y9uofWx5+XqQVsGojPP3ryaF9elOSPxN7jB/Vw=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 4/7] arm64: dts: qcom: sdm845-oneplus-common: commonize uart6 pinconf
Message-ID: <20221016143300.1738550-5-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new qup_uart6_4pin configuration in sd845.dtsi and fix alias
name.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm=
64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 392461c29e76..5d99908d4628 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -19,7 +19,7 @@
 / {
 =09aliases {
 =09=09serial0 =3D &uart9;
-=09=09hsuart0 =3D &uart6;
+=09=09serial1 =3D &uart6;
 =09};

 =09chosen {
@@ -500,35 +500,11 @@ pinconf-rx {
 =09};
 };

-/*
- * Prevent garbage data on bluetooth UART lines
- */
-&qup_uart6_default {
-=09pinmux {
-=09=09pins =3D "gpio45", "gpio46", "gpio47", "gpio48";
-=09=09function =3D "qup6";
-=09};
-
-=09cts {
-=09=09pins =3D "gpio45";
-=09=09bias-pull-down;
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
-
 &uart6 {
 =09status =3D "okay";

+=09pinctrl-0 =3D <&qup_uart6_4pin>;
+
 =09bluetooth {
 =09=09compatible =3D "qcom,wcn3990-bt";

--
2.38.0


