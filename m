Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A196610FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjAGS06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjAGS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF73FA25;
        Sat,  7 Jan 2023 10:26:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71F18B8047E;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15737C433F0;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115981;
        bh=2NgRSukIsXpmr4ezznzNGR723w5oZTyOcLNPLclIT8w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=rlMftI1JL5hJ/vKUK6hgp9gjqtc3W7HcF+9QURm5qT53z5i/VXxG69OkwpfgZGbTR
         ZVpNJGFKTfRa8zjCHKjYYcs7m7TmL7OEfI7xyG9CsORNNiOvUsNUjEI7IXpd05JSHG
         YTt3BDLf1OGm6npZG9f0n1bFdbh0u/PprR0zcYL/enO+X84iEaGLlAktqThawoxhkj
         /R/4nBSt0qLZJ/AU5ssdZjnZKdozQqiZtjlXmta12H7oTa7Oqfbenh8YDkr2AnwMfK
         AzuPmmFgkbijCVt5UPeuA+6c0oh4f6aexZ0PqPZi2LyYYJVIfTWVwsKXqjoFJWGH7e
         v5dB2Z0T0y+iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F6C54EBC;
        Sat,  7 Jan 2023 18:26:20 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:15 +0100
Subject: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
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
        Sam Ravnborg <sam@ravnborg.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=2641;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=00kGRCWi8cuXpKBxkvC737vLzE0DLWF6H/syUZozYj0=; =?utf-8?q?b=3Dn0gLcHxryjYg?=
 =?utf-8?q?M/3rj8DxmkGGgj+kqUIxzuWt9FYoauHAwjD31UB8ShIRk/2wtjXq9fNHAF2YAhlJ?=
 YGxA/gk7AfjT/Ak1jBRmIYhfO1fh+3b+KaplQZMvBeYtU5vrsyPE
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

The atmel_lcdfb had code to save/restore power state.
This is not needed so drop it.

Introduce backlight_is_brightness() to make logic simpler.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/video/fbdev/atmel_lcdfb.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 1fc8de4ecbeb..d297b3892637 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -49,7 +49,6 @@ struct atmel_lcdfb_info {
 	struct clk		*lcdc_clk;
 
 	struct backlight_device	*backlight;
-	u8			bl_power;
 	u8			saved_lcdcon;
 
 	u32			pseudo_palette[16];
@@ -109,32 +108,18 @@ static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
 static int atmel_bl_update_status(struct backlight_device *bl)
 {
 	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
-	int			power = sinfo->bl_power;
-	int			brightness = bl->props.brightness;
+	int brightness;
 
-	/* REVISIT there may be a meaningful difference between
-	 * fb_blank and power ... there seem to be some cases
-	 * this doesn't handle correctly.
-	 */
-	if (bl->props.fb_blank != sinfo->bl_power)
-		power = bl->props.fb_blank;
-	else if (bl->props.power != sinfo->bl_power)
-		power = bl->props.power;
-
-	if (brightness < 0 && power == FB_BLANK_UNBLANK)
-		brightness = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
-	else if (power != FB_BLANK_UNBLANK)
-		brightness = 0;
+	brightness = backlight_get_brightness(bl);
 
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
+
 	if (contrast_ctr & ATMEL_LCDC_POL_POSITIVE)
 		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR,
 			brightness ? contrast_ctr : 0);
 	else
 		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
 
-	bl->props.fb_blank = bl->props.power = sinfo->bl_power = power;
-
 	return 0;
 }
 
@@ -155,8 +140,6 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
 	struct backlight_properties props;
 	struct backlight_device	*bl;
 
-	sinfo->bl_power = FB_BLANK_UNBLANK;
-
 	if (sinfo->backlight)
 		return;
 
@@ -173,7 +156,6 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
 	sinfo->backlight = bl;
 
 	bl->props.power = FB_BLANK_UNBLANK;
-	bl->props.fb_blank = FB_BLANK_UNBLANK;
 	bl->props.brightness = atmel_bl_get_brightness(bl);
 }
 

-- 
2.34.1
