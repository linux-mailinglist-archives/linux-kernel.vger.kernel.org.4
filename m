Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98573A7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFVSAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFVR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:59:49 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3F1FED;
        Thu, 22 Jun 2023 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1687456783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HLKXuJfbAEP8qRinCCvkhNT+gci8j8wovxWQareellw=;
        b=AgkIIfOj7POy7M/J2zuvkMyuTGmKlwfx1tnjSA4+ze/u1PPQccQj6c9W5SNzNvc/3XX4rP
        X3JR38KwiCehBD1ViNC2lH6V1ToZPtnlLRJlgCOj9PgilJIY5RhDZpJ4Tl528txLTbXgwb
        AHdZKlKGPwyJvBuwV0x8BOzaW9ylYVo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
Date:   Thu, 22 Jun 2023 19:59:34 +0200
Message-Id: <20230622175934.71601-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node
names") caused the VDDCORE power supply (regulated by the ACT8600's
DCDC1 output) to drop from a voltage of 1.2V configured by the
bootloader, to the 1.1V set in the Device Tree.

According to the documentation, the VDDCORE supply should be between
0.99V and 1.21V; both values are therefore within the supported range.

However, VDDCORE being 1.1V results in the CI20 being very unstable,
with corrupted memory, failures to boot, or reboots at random. The
reason might be succint drops of the voltage below the minimum required.

Raising the minimum voltage to 1.125 volts seems to be enough to address
this issue, while still keeping a relatively low core voltage which
helps for power consumption and thermals.

Fixes: 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node names")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
Cc: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index cec0caa2350c..a141a699b790 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -298,8 +298,8 @@ act8600: act8600@5a {
 
 		regulators {
 			vddcore: DCDC1 {
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1125000>;
+				regulator-max-microvolt = <1125000>;
 				vp1-supply = <&vcc_33v>;
 				regulator-always-on;
 			};
-- 
2.40.1

