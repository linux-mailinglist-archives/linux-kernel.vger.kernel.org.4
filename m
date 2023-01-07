Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F686610DD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjAGS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjAGS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262FD3F12A;
        Sat,  7 Jan 2023 10:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7050E60BA8;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A382C433AE;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115981;
        bh=5ij+2zt071FaFgXPs/8g9HMxpQ5Rvn4NOrg8o4aDjAA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=R0Vqm0kwLCUMC/FFA+SwZYvkyVvRCwUaU1sKttT/VJJBVNEHRFOf7VvRZzlHTJkZG
         jjwOFSnMDXFvNYr2SN2VsLrgU4CSuQ9MOmH7eo0WWSnwItqdjAYu/ZYW9aU81kUGBX
         R39CPgkrOZwFdoE7pNj4N9tPVvQEikdGY5kaJNMaW7A+TZIGW21KtIjU6OqRUwklQl
         S5JBCOzlHxApv1YqY1liRhR+fB9VwhN/rYiWd6Z2LUKDvnkbI+KBxZBmnEsLtO0Jfa
         l3RLZMdBIrygDW6z0hb8uQ5n1gN1WEahYBr1Nnd6gvEn+QRWEUAge3ELmYT1mbJaLT
         X6i2PWrdQxt1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC0C54EBC;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:21 +0100
Subject: [PATCH 07/15] video: fbdev: mx3fb: Introduce backlight_get_brightness()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-7-1bd9bafb351f@ravnborg.org>
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
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=1512;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=drvkdW0PBheGrMYY3qAlAUiLqN5UfH4VOwcA/aXugg0=; =?utf-8?q?b=3D8iTbagfWb1Lj?=
 =?utf-8?q?07cocG5qMfP8Ayj4BAQY4d64KWfzkOktfkyCN7IXzBwcj/9U/iJWYWB0GCaKShTH?=
 0OiuscjyAkCEJdcJGgJQX9THB3GVRSWeiPGBowlxgEHvu9p/2eio
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

Introduce backlight_get_brightness() to simplify logic
and avoid direct access to backlight properties.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/mx3fb.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index b945b68984b9..bc35f664cbff 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -283,12 +283,7 @@ static int mx3fb_bl_get_brightness(struct backlight_device *bl)
 static int mx3fb_bl_update_status(struct backlight_device *bl)
 {
 	struct mx3fb_data *fbd = bl_get_data(bl);
-	int brightness = bl->props.brightness;
-
-	if (bl->props.power != FB_BLANK_UNBLANK)
-		brightness = 0;
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
-		brightness = 0;
+	int brightness = backlight_get_brightness(bl);
 
 	fbd->backlight_level = (fbd->backlight_level & ~0xFF) | brightness;
 
@@ -325,7 +320,6 @@ static void mx3fb_init_backlight(struct mx3fb_data *fbd)
 
 	fbd->bl = bl;
 	bl->props.power = FB_BLANK_UNBLANK;
-	bl->props.fb_blank = FB_BLANK_UNBLANK;
 	bl->props.brightness = mx3fb_bl_get_brightness(bl);
 }
 

-- 
2.34.1
