Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56E6B9B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCNQ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjCNQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB039EF43;
        Tue, 14 Mar 2023 09:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1B4F6181B;
        Tue, 14 Mar 2023 16:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6338FC433D2;
        Tue, 14 Mar 2023 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678811246;
        bh=0BszSclPkYdHyPcXZhoiYKeed+oHxWdTrNdyBbP781U=;
        h=From:To:Cc:Subject:Date:From;
        b=jv09Olof29476Ze1LNP0JHkAenz7t5P4LXFqp9DIzK4pctMbjFjdXB9aijuL0rrNH
         FOmtxnJMPnag6Y/JPO5AojOKd1HfUYV0RnR2oPIIUQUkZmf5FMeKyWc18G/I2uOtZ+
         F96gvwk8KMmgA0y2SctEWEXeOiFG+KiUT+Fk7Ff0iJ0AHvih4GZpIYo1WzDoHk8Zkv
         8Xf+OQ5l5K9PftoN+sUlCO69HJvbFtnlqyEXPsW9HvCz5e0l5/LFVGmm2K6TorIlwQ
         nGGZi9xJnrHPNq5MmOqG4Gf6pgLowWuDLp4kMrnfFMa5NyvdRPTlIxHBKSJHfkAiEl
         JO8QiE8oci8OA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: omapfb: remove omap1 osk driver
Date:   Tue, 14 Mar 2023 17:27:10 +0100
Message-Id: <20230314162720.759220-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Commit 21a3e6eed423 ("ARM: omap1: remove osk-mistral add-on board
support") removed the platform_device definition for the "lcd_osk"
device, so this driver is now unused and can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap/Makefile  |  1 -
 drivers/video/fbdev/omap/lcd_osk.c | 86 ------------------------------
 2 files changed, 87 deletions(-)
 delete mode 100644 drivers/video/fbdev/omap/lcd_osk.c

diff --git a/drivers/video/fbdev/omap/Makefile b/drivers/video/fbdev/omap/Makefile
index 504edb9c09dd..6d5082c76919 100644
--- a/drivers/video/fbdev/omap/Makefile
+++ b/drivers/video/fbdev/omap/Makefile
@@ -18,7 +18,6 @@ objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 
 lcds-y$(CONFIG_MACH_AMS_DELTA) += lcd_ams_delta.o
 lcds-y$(CONFIG_MACH_OMAP_PALMTE) += lcd_palmte.o
-lcds-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 
 lcds-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
deleted file mode 100644
index 8168ba0d47fd..000000000000
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * LCD panel support for the TI OMAP OSK board
- *
- * Copyright (C) 2004 Nokia Corporation
- * Author: Imre Deak <imre.deak@nokia.com>
- * Adapted for OSK by <dirk.behme@de.bosch.com>
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-
-#include <linux/soc/ti/omap1-io.h>
-#include <linux/soc/ti/omap1-mux.h>
-
-#include "omapfb.h"
-
-static int osk_panel_enable(struct lcd_panel *panel)
-{
-	/* configure PWL pin */
-	omap_cfg_reg(PWL);
-
-	/* Enable PWL unit */
-	omap_writeb(0x01, OMAP_PWL_CLK_ENABLE);
-
-	/* Set PWL level */
-	omap_writeb(0xFF, OMAP_PWL_ENABLE);
-
-	/* set GPIO2 high (lcd power enabled) */
-	gpio_set_value(2, 1);
-
-	return 0;
-}
-
-static void osk_panel_disable(struct lcd_panel *panel)
-{
-	/* Set PWL level to zero */
-	omap_writeb(0x00, OMAP_PWL_ENABLE);
-
-	/* Disable PWL unit */
-	omap_writeb(0x00, OMAP_PWL_CLK_ENABLE);
-
-	/* set GPIO2 low */
-	gpio_set_value(2, 0);
-}
-
-static struct lcd_panel osk_panel = {
-	.name		= "osk",
-	.config		= OMAP_LCDC_PANEL_TFT,
-
-	.bpp		= 16,
-	.data_lines	= 16,
-	.x_res		= 240,
-	.y_res		= 320,
-	.pixel_clock	= 12500,
-	.hsw		= 40,
-	.hfp		= 40,
-	.hbp		= 72,
-	.vsw		= 1,
-	.vfp		= 1,
-	.vbp		= 0,
-	.pcd		= 12,
-
-	.enable		= osk_panel_enable,
-	.disable	= osk_panel_disable,
-};
-
-static int osk_panel_probe(struct platform_device *pdev)
-{
-	omapfb_register_panel(&osk_panel);
-	return 0;
-}
-
-static struct platform_driver osk_panel_driver = {
-	.probe		= osk_panel_probe,
-	.driver		= {
-		.name	= "lcd_osk",
-	},
-};
-
-module_platform_driver(osk_panel_driver);
-
-MODULE_AUTHOR("Imre Deak");
-MODULE_DESCRIPTION("LCD panel support for the TI OMAP OSK board");
-MODULE_LICENSE("GPL");
-- 
2.39.2

