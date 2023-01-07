Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738D661107
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjAGS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjAGS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8040C0C;
        Sat,  7 Jan 2023 10:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C73B0B8069F;
        Sat,  7 Jan 2023 18:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0630FC43323;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115982;
        bh=xpo8jUeerzmavUSQe9zKlH8WJyJePz17BLWzlSJ9W5w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=leSuGdHpQ5DishtvWWyEHD84Rm+3zDpxcCk6Y/o5NTJYim1zGPo/nCCGi4ApYAmy5
         EGPK6F9qRo9FA79zd96UlO8+oj7N9uIqJpTRy4x/wHdIBbOGYh0cXV0rSfMsiQaTRA
         v0UEBf9kIh57tMQLQAE8TwDjdE1kJ3OK7oxPEqMFT/Ub/bv63O5PS8Npo+Ycim1/os
         B60WufGI+Ceet6SmbiOonk0wvsqabqYtY7L8a867H0+wzmf4WjjRAnoiidtyztMs67
         i93IRKMOI7IDyPWcz0VgvqKkn2Gfh23SlDjV/RJ9KWzU5152Y6/OhuNViPzi5nf7F/
         5U+P5w5KEdTQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E6565C46467;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:27 +0100
Subject: [PATCH 13/15] backlight: omap1: Use backlight helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>,
        Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=3774;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=srCckeZD3FDZipiWT3z6Jx0O9ZavywUIgE9g9CQnkT4=; =?utf-8?q?b=3DZnBn79WC7Jd0?=
 =?utf-8?q?7w2kvEoUqNXOLxMXiRR81z3KD4hu/AuT4FkBWuhIb8mnv9JkUKSSwMaj8t3RWh8T?=
 8DR2+MBwD0MvdIdeiVcdPN0SSEF+zFiSKPHpLxPwqkw+xml8oExD
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Submission Endpoint for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

Rework backlight handling to avoid access to the deprecated
backlight_properties.fb_blank member.

The rework includes removal of get_brightness() operation,
because there was no read back from HW so no use for it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/omap1_bl.c | 67 +++++---------------------------------
 1 file changed, 9 insertions(+), 58 deletions(-)

diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index 69a49384b3de..49f37da857e7 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -20,9 +20,6 @@
 #define OMAPBL_MAX_INTENSITY		0xff
 
 struct omap_backlight {
-	int powermode;
-	int current_intensity;
-
 	struct device *dev;
 	struct omap_backlight_config *pdata;
 };
@@ -37,82 +34,40 @@ static inline void omapbl_send_enable(int enable)
 	omap_writeb(enable, OMAP_PWL_CLK_ENABLE);
 }
 
-static void omapbl_blank(struct omap_backlight *bl, int mode)
-{
-	if (bl->pdata->set_power)
-		bl->pdata->set_power(bl->dev, mode);
-
-	switch (mode) {
-	case FB_BLANK_NORMAL:
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-	case FB_BLANK_POWERDOWN:
-		omapbl_send_intensity(0);
-		omapbl_send_enable(0);
-		break;
-
-	case FB_BLANK_UNBLANK:
-		omapbl_send_intensity(bl->current_intensity);
-		omapbl_send_enable(1);
-		break;
-	}
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int omapbl_suspend(struct device *dev)
 {
 	struct backlight_device *bl_dev = dev_get_drvdata(dev);
-	struct omap_backlight *bl = bl_get_data(bl_dev);
 
-	omapbl_blank(bl, FB_BLANK_POWERDOWN);
+	backlight_disable(bl_dev);
 	return 0;
 }
 
 static int omapbl_resume(struct device *dev)
 {
 	struct backlight_device *bl_dev = dev_get_drvdata(dev);
-	struct omap_backlight *bl = bl_get_data(bl_dev);
 
-	omapbl_blank(bl, bl->powermode);
+	backlight_enable(bl_dev);
 	return 0;
 }
 #endif
 
-static int omapbl_set_power(struct backlight_device *dev, int state)
-{
-	struct omap_backlight *bl = bl_get_data(dev);
-
-	omapbl_blank(bl, state);
-	bl->powermode = state;
-
-	return 0;
-}
-
 static int omapbl_update_status(struct backlight_device *dev)
 {
-	struct omap_backlight *bl = bl_get_data(dev);
+	int brightness = backlight_get_brightness(dev);
 
-	if (bl->current_intensity != dev->props.brightness) {
-		if (bl->powermode == FB_BLANK_UNBLANK)
-			omapbl_send_intensity(dev->props.brightness);
-		bl->current_intensity = dev->props.brightness;
+	if (brightness > 0) {
+		omapbl_send_intensity(dev->props.brightness);
+		omapbl_send_enable(1);
+	} else {
+		omapbl_send_intensity(0);
+		omapbl_send_enable(0);
 	}
 
-	if (dev->props.fb_blank != bl->powermode)
-		omapbl_set_power(dev, dev->props.fb_blank);
-
 	return 0;
 }
 
-static int omapbl_get_intensity(struct backlight_device *dev)
-{
-	struct omap_backlight *bl = bl_get_data(dev);
-
-	return bl->current_intensity;
-}
-
 static const struct backlight_ops omapbl_ops = {
-	.get_brightness = omapbl_get_intensity,
 	.update_status  = omapbl_update_status,
 };
 
@@ -139,9 +94,6 @@ static int omapbl_probe(struct platform_device *pdev)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	bl->powermode = FB_BLANK_POWERDOWN;
-	bl->current_intensity = 0;
-
 	bl->pdata = pdata;
 	bl->dev = &pdev->dev;
 
@@ -149,7 +101,6 @@ static int omapbl_probe(struct platform_device *pdev)
 
 	omap_cfg_reg(PWL);	/* Conflicts with UART3 */
 
-	dev->props.fb_blank = FB_BLANK_UNBLANK;
 	dev->props.brightness = pdata->default_intensity;
 	omapbl_update_status(dev);
 

-- 
2.34.1
