Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278985FFFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJPOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJPOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:35:14 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAE518B22;
        Sun, 16 Oct 2022 07:35:11 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665930909; x=1666190109;
        bh=SqCIFBMkKHUsYImTU6oEqN9NKkHFufrsS60FGxQHQ7I=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=VAy1RVcc8WKGNzoCSFD2gE1r05kzQaBJq2dW1GVTsM8hnBTob1GjTlFIp5Glv2e9+
         XrY6meyuVIx2Cxj8AXnZHfwhmv/jGSyPQyeYW4jBssYlaN1lf/jmW6O+Ds9UnEFWjY
         kQnrFpbohz7ckv38KhL/qA+pSKUgle7iaPVRmRyc=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 7/7] arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading
Message-ID: <20221016143300.1738550-8-caleb@connolly.tech>
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

From: Dylan Van Assche <me@dylanvanassche.be>

Add serial1 alias, firmware name and use 4 pin UART pinmux.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Tested-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64=
/boot/dts/qcom/sdm845-shift-axolotl.dts
index 83261c9bb4f2..3e038156af4f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -22,6 +22,7 @@ / {

 =09aliases {
 =09=09display0 =3D &framebuffer0;
+=09=09serial1 =3D &uart6;
 =09=09serial0 =3D &uart9;
 =09};

@@ -693,9 +694,17 @@ config {
 &uart6 {
 =09status =3D "okay";

+=09pinctrl-0 =3D <&qup_uart6_4pin>;
+
 =09bluetooth {
 =09=09compatible =3D "qcom,wcn3990-bt";

+=09=09/*
+=09=09 * This path is relative to the qca/
+=09=09 * subdir under lib/firmware.
+=09=09 */
+=09=09firmware-name =3D "axolotl/crnv21.bin";
+
 =09=09vddio-supply =3D <&vreg_s4a_1p8>;
 =09=09vddxo-supply =3D <&vreg_l7a_1p8>;
 =09=09vddrf-supply =3D <&vreg_l17a_1p3>;
--
2.38.0


