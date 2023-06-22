Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913237393A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFVAQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFVAQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:16:38 -0400
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DAE1FEE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:16:05 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:04:19 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Pua/4TE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687392268; x=1687651468;
        bh=QApTeqmmt2Nt3CTduRIU2TRUUTK8LTmbK6PcMDg3L28=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Pua/4TE4VN5I8Ezbf+dzMRhmuI9ft4Vhmi1I9q/bvNlFDqDHKRR3E+wg6FGN/XnvQ
         52Rqp9crgI4X/2ZjADQnvrGRVT/ZKFUmsoNYh+8Wm5y3ID8YzjHz0Cvql+BLwdpp0F
         7zps+1MhZ/V74iLGeUpg/o6+rSPxoeDDh0ebPL5AuvqHT7djhMYevALjpMl3SiUral
         rOz8XfpXG7XsUp/OpONOXeIIQa4vos7JrPxjZLwX+3d2lbgu3+gbqfwkQHSDDbJcQ0
         qWwmTT5felMlgULZgpv+85v4OnRrPrlxUJMjavQ5/ZM0Rc1vZAHfrpXQF2vA1IfPc4
         LmEpDrLvyNtqQ==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 3/7] ARM: dts: qcom-msm8916-samsung-fortuna: Include dts from arm64
Message-ID: <20230622000322.48298-1-linmengbo0689@protonmail.com>
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

After adding all necessary support for MSM8916 SMP/cpuidle without PSCI
on ARM32, build fortunaltezt and heatqlte device trees from the arm64
tree together with the ARM32 include to allow booting this device on ARM32.

The approach to include device tree files from other architectures is
inspired from e.g. the Raspberry Pi (bcm2711-rpi-4-b.dts) where this is
used to build the device tree for both ARM32 and ARM64.

[Add workaround to TSENS problem]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Add heatqlte]
Signed-off-by: Gareth Peoples <mail@gpeopl.es>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm/boot/dts/Makefile                              | 2 ++
 arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts | 8 ++++++++
 arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts     | 8 ++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2503d1c5eee3..9305c5f3bc3f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1099,7 +1099,9 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
 =09qcom-msm8660-surf.dtb \
 =09qcom-msm8916-samsung-e5.dtb \
 =09qcom-msm8916-samsung-e7.dtb \
+=09qcom-msm8916-samsung-fortunaltezt.dtb \
 =09qcom-msm8916-samsung-grandmax.dtb \
+=09qcom-msm8916-samsung-heatqlte.dtb \
 =09qcom-msm8916-samsung-serranove.dtb \
 =09qcom-msm8960-cdp.dtb \
 =09qcom-msm8960-samsung-expressatt.dtb \
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts b/arch=
/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
new file mode 100644
index 000000000000..b9704fea7029
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-fortunaltezt.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-fortunaltezt.dts"
+#include "qcom-msm8916-smp.dtsi"
+
+&tsens {
+=09/* FIXME: The device crashes when accessing the SROT region for some re=
ason */
+=09status =3D "disabled";
+};
diff --git a/arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts b/arch/arm=
/boot/dts/qcom-msm8916-samsung-heatqlte.dts
new file mode 100644
index 000000000000..ec3edd4f31c3
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8916-samsung-heatqlte.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "arm64/qcom/msm8916-samsung-heatqlte.dts"
+#include "qcom-msm8916-smp.dtsi"
+
+&tsens {
+=09/* FIXME: The device crashes when accessing the SROT region for some re=
ason */
+=09status =3D "disabled";
+};
--=20
2.39.2


