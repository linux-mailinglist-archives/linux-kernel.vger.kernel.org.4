Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447D86610FF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjAGS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjAGS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737EA3F10C;
        Sat,  7 Jan 2023 10:26:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C378160BB9;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21BAEC43329;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115982;
        bh=Mj/ShVgaaD92/Ge3l6JJSNYGpwa5ONVGtJTi9DaheiM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=W6qTiEub76a/pK7uR8XodmptNf4n268IEjWRX5tHRsNecbig79nemOGW1S5jR199O
         Q3WQsmeSNIaJJfu7vOG98wRK0Kga66L9A3OXc6bXqPicoNPdzvy9HpiAWYxV8NlFpJ
         u1PniEBpdTf47ZPtMK3G9cQoeX9ZwptPnR/NKLwOZNW13+iPurd73lc6cWwhNXLYIk
         29QzBUFZwiJQZ/3h7gkj4BbMKXV6KiNS34GTw5iOtrkK1aF39CD3Thb1co6OY3d7eC
         vEfh6XyWJT9ChjxCYx8Ykl4dL7dhcFJgon4aTum6ZpcxJHI0dj7Pn6CeToWPbbm607
         y4SN6r7mL7qjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 10B31C63797;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:29 +0100
Subject: [PATCH 15/15] backlight: backlight: Drop the deprecated fb_blank property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-15-1bd9bafb351f@ravnborg.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=3041;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=1rlDGBQ8dUJZwm2QXjSfjVEGh6r7tPSOztASIhko1ZA=; =?utf-8?q?b=3DOWmPqlL1i8PO?=
 =?utf-8?q?CFlGwpKfdK0lpD04cBqvUemyqQ5rJT5jQQmDliYaJeqEzjRTaDdplBAFwN0P5fJy?=
 jwHOPNUKCeY0gAj2nPyPtvnKkGoHtq262p4+KBibi0oW4Iuegikn
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

With all users gone remove the deprecated fb_blank member in
backlight_properties.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c |  2 --
 include/linux/backlight.h           | 22 ----------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index b788ff3d0f45..9b0557d094c5 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -118,14 +118,12 @@ static int fb_notifier_callback(struct notifier_block *self,
 		bd->fb_bl_on[node] = true;
 		if (!bd->use_count++) {
 			bd->props.state &= ~BL_CORE_FBBLANK;
-			bd->props.fb_blank = FB_BLANK_UNBLANK;
 			backlight_update_status(bd);
 		}
 	} else if (fb_blank != FB_BLANK_UNBLANK && bd->fb_bl_on[node]) {
 		bd->fb_bl_on[node] = false;
 		if (!(--bd->use_count)) {
 			bd->props.state |= BL_CORE_FBBLANK;
-			bd->props.fb_blank = fb_blank;
 			backlight_update_status(bd);
 		}
 	}
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 614653e07e3a..c8622d6cc8c5 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -218,25 +218,6 @@ struct backlight_properties {
 	 */
 	int power;
 
-	/**
-	 * @fb_blank: The power state from the FBIOBLANK ioctl.
-	 *
-	 * When the FBIOBLANK ioctl is called @fb_blank is set to the
-	 * blank parameter and the update_status() operation is called.
-	 *
-	 * When the backlight device is enabled @fb_blank is set
-	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
-	 * @fb_blank is set to FB_BLANK_POWERDOWN.
-	 *
-	 * Backlight drivers should avoid using this property. It has been
-	 * replaced by state & BL_CORE_FBLANK (although most drivers should
-	 * use backlight_is_blank() as the preferred means to get the blank
-	 * state).
-	 *
-	 * fb_blank is deprecated and will be removed.
-	 */
-	int fb_blank;
-
 	/**
 	 * @type: The type of backlight supported.
 	 *
@@ -366,7 +347,6 @@ static inline int backlight_enable(struct backlight_device *bd)
 		return 0;
 
 	bd->props.power = FB_BLANK_UNBLANK;
-	bd->props.fb_blank = FB_BLANK_UNBLANK;
 	bd->props.state &= ~BL_CORE_FBBLANK;
 
 	return backlight_update_status(bd);
@@ -382,7 +362,6 @@ static inline int backlight_disable(struct backlight_device *bd)
 		return 0;
 
 	bd->props.power = FB_BLANK_POWERDOWN;
-	bd->props.fb_blank = FB_BLANK_POWERDOWN;
 	bd->props.state |= BL_CORE_FBBLANK;
 
 	return backlight_update_status(bd);
@@ -403,7 +382,6 @@ static inline int backlight_disable(struct backlight_device *bd)
 static inline bool backlight_is_blank(const struct backlight_device *bd)
 {
 	return bd->props.power != FB_BLANK_UNBLANK ||
-	       bd->props.fb_blank != FB_BLANK_UNBLANK ||
 	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
 }
 

-- 
2.34.1
