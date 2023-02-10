Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DCC6922D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjBJP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjBJP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:59:05 -0500
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E11CF6F;
        Fri, 10 Feb 2023 07:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676044184;
        bh=2+TpaXpBy+/CX50PszxE+icAKfHjpZWw52REtekM1I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2/E6BDdp3dWqjaN6GB+i2Eeas2Y266wpVng263/xGs0aTJoZQMwLVWDyJTQ6dNb9
         HyRNC49huTu5CsE0Kwe2KwHJqWtW1t7GIP4MbgmaGLvw/JGrcedk6zu5sXILOoELAb
         Wokw5p5Ys0eajadQKt6o9ZB6FFqJM9oom+ovjYbI=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 52548A05F4;
        Fri, 10 Feb 2023 16:49:44 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 3/6] ARM: dts: imx6dl-yapp4: Use reset-gpios property name
Date:   Fri, 10 Feb 2023 16:48:52 +0100
Message-Id: <20230210154855.3086900-4-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210154855.3086900-1-michal.vokac@ysoft.com>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpios instead of gpio suffix that is mandated by the binding.
This dtbs_check warning is fixed now:

  touchscreen@5c: Unevaluated properties are not allowed ('reset-gpio' was unexpected)

The reset signal worked correctly as both the "gpio" and "gpios" suffixes
are actually allowed by the gpiolib.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index aacbf317feea..c6afc51bb22b 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -313,7 +313,7 @@ touchscreen: touchscreen@5c {
 		interrupt-parent = <&gpio4>;
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		attb-gpio = <&gpio4 5 GPIO_ACTIVE_HIGH>;
-		reset-gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		touchscreen-size-x = <800>;
 		touchscreen-size-y = <480>;
 		status = "disabled";
-- 
2.25.1

