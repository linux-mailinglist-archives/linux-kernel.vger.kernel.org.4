Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856DC695E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjBNJJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjBNJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:08:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE3EC42;
        Tue, 14 Feb 2023 01:07:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FFDA6090C;
        Tue, 14 Feb 2023 09:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3059C433EF;
        Tue, 14 Feb 2023 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676365653;
        bh=OlRf+PZkFPcU3LhJ+mP2uxlveALxvDZpPtRYIg9JveY=;
        h=From:To:Cc:Subject:Date:From;
        b=IXzoVRY6ObRuAg2XVtKBEwZoU9lEzBnX31Bn1ILATOVyFyWd6Rh1Cudi9iIgYm2NN
         JVpw9X9fA4IDhh9UcidvFdMbumw2RPTFOxuF4Av/tO9iBGrDS1xQWMeRQZNTMxaRpk
         zYi/SYI1dXN25QJhnJR9HZD4Eg8SIQKhFNfXu623ngpUzyYelyb7fQq6vZQz3G3Sw1
         PAIC9jex2oreb02gd8VXACi4BfyRXrOowCXowaeBAtn66w9GBYCYo03rUkIMfW7qze
         fczOBo4Js4YAZHZVPeIXVli2WagEL7othzzEduM0ism7BkZWXm2ZnF5KlZ4q+zZ+DP
         lqJicNrgGqfxw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: mainstone: fix pxa2xx_ac97 dependency
Date:   Tue, 14 Feb 2023 10:07:16 +0100
Message-Id: <20230214090728.1737140-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The exported PXA AC97 symbols are provided by the snd-pxa2xx-lib module
if SND_PXA2XX_SOC_AC97 is set, so both symbols have to be enabled for
the mainstone driver to actually work, and if snd-pxa2xx-lib is a loadable
module, the touchscreen driver cannot be built-in:

arm-linux-gnueabi-ld: drivers/input/touchscreen/mainstone-wm97xx.o: in function `wm97xx_acc_pen_up':
mainstone-wm97xx.c:(.text+0x8c): undefined reference to `pxa2xx_ac97_read_modr'
arm-linux-gnueabi-ld: drivers/input/touchscreen/mainstone-wm97xx.o: in function `wm97xx_acc_pen_down':
mainstone-wm97xx.c:(.text+0x2e0): undefined reference to `pxa2xx_ac97_read_modr'

The misconfiguration has always been possible but I never hit this after
my previous incomplete fix in 2019: since there were many options that
each 'select SND_PXA2XX_SOC_AC97', randconfig builds for PXA would almost
always have this built-in, not in a loadable module.

Fixes: e217b085a1ac ("Input: touchscreen: use wrapper for pxa2xx ac97 registers")
Fixes: b401d1fd8053 ("ASoC: pxa: remove unused board support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 61bb8e632413..1601f5bae005 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -903,7 +903,7 @@ config TOUCHSCREEN_WM9713
 config TOUCHSCREEN_WM97XX_MAINSTONE
 	tristate "WM97xx Mainstone/Palm accelerated touch"
 	depends on TOUCHSCREEN_WM97XX && ARCH_PXA
-	depends on SND_PXA2XX_LIB_AC97
+	depends on SND_PXA2XX_LIB && SND_PXA2XX_LIB_AC97
 	help
 	  Say Y here for support for streaming mode with WM97xx touchscreens
 	  on Mainstone, Palm Tungsten T5, TX and LifeDrive systems.
-- 
2.39.1

