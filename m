Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2F5FFFC7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJPOds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJPOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:33:46 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1725D31FB9;
        Sun, 16 Oct 2022 07:33:46 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665930824; x=1666190024;
        bh=WnxtVrYBr40QFa/agfVuW7lN496SFcxiF7zdspp9/LY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=PflAHFt2bdd3iQms26MO3YsiI0fVkHv3f9Ius6HbxbVvIPtGHiidwGfP7tplXnnYN
         7Z7DYt85V5zPhYaxSkTZXHfawQpu/oieWf+GgX+FQgwLJF6uTQpicbyizaenWz5+ET
         tTaUpquiICQNVOvUy0S7b6MElxobj0OX9Y4wIZis=
To:     caleb@connolly.tech
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/7] arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
Message-ID: <20221016143300.1738550-2-caleb@connolly.tech>
In-Reply-To: <20221016143300.1738550-1-caleb@connolly.tech>
References: <20221016143300.1738550-1-caleb@connolly.tech>
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

The 4-pin configuration for UART6 is used for all or almost all SDM845
devices with built in Bluetooth. Move the pinmux configuration to
sdm845.dtsi in preparation to be removed from individual devices in
future patches.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qco=
m/sdm845.dtsi
index f0e286715d1b..8c69942b969b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2971,6 +2971,29 @@ pinmux {
 =09=09=09=09};
 =09=09=09};

+=09=09=09qup_uart6_4pin: qup-uart6-4pin {
+=09=09=09=09pinmux {
+=09=09=09=09=09pins =3D "gpio45", "gpio46", "gpio47", "gpio48";
+=09=09=09=09=09function =3D "qup6";
+=09=09=09=09};
+
+=09=09=09=09cts {
+=09=09=09=09=09pins =3D "gpio45";
+=09=09=09=09=09bias-pull-down;
+=09=09=09=09};
+
+=09=09=09=09rts-tx {
+=09=09=09=09=09pins =3D "gpio46", "gpio47";
+=09=09=09=09=09drive-strength =3D <2>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09};
+
+=09=09=09=09rx {
+=09=09=09=09=09pins =3D "gpio48";
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09};
+=09=09=09};
+
 =09=09=09qup_uart7_default: qup-uart7-default {
 =09=09=09=09pinmux {
 =09=09=09=09=09pins =3D "gpio95", "gpio96";
--
2.38.0


