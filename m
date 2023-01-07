Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC06610F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjAGS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjAGS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479440C0C;
        Sat,  7 Jan 2023 10:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27AF6B8069A;
        Sat,  7 Jan 2023 18:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C138C433A1;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115981;
        bh=UgErG0ahXvin5KqprcP4yTzkDgUMgisxrCT5F6v9v3s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=CQ5EFq+2BPJRiq3zf5snT1YX3p1YtwrJOo0UElQbxKCbR2zY/q0mm4QOeEwFbp0ob
         wUKiM7ao8aI3qoMlKhkOZyBDK30hY9q6LvDt3jfbG4Ze4T+I4UWSQYU+/vwLW9Qydd
         ZCx0Cp/78jutBDA25G5AXNmT4rc3GObY0qBV0Bxvv6OQGC4u19HXcqMGJXqNUiVHY1
         +T7FM2SaxNG7uxi0OfBE+WHStPObR8Mbj2CGH4o3xT4I7bChwIDdc2m26PTFcSomG/
         NeqTXSUoIeLn+P2wyPY0OZKk2JaTqOGlKH6Jzqsx70Yilgo+unfuPggd3lgcyKUjZo
         YePqEkpjt0sHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 475E3C64981;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:19 +0100
Subject: [PATCH 05/15] video: fbdev: riva: Introduce backlight_get_brightness()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-5-1bd9bafb351f@ravnborg.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=1045;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=j+HG2wSYqKNwTOfMiYjFHzSzlk0PGcAa2iiQeKtebpY=; =?utf-8?q?b=3DevW/7HEX3Tem?=
 =?utf-8?q?ZDTb3xs/18D5j66JRDk706eBMxDT6tdbE2dYtO9k/ExWbYOdsP9oRSxX+glDRK5M?=
 rxyrw8CID7AkL98sYMTbditO+j8pldVv8MCsELvig9PWwKcqU/Rv
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
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/riva/fbdev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 644278146d3b..41edc6e79460 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -293,13 +293,7 @@ static int riva_bl_update_status(struct backlight_device *bd)
 {
 	struct riva_par *par = bl_get_data(bd);
 	U032 tmp_pcrt, tmp_pmc;
-	int level;
-
-	if (bd->props.power != FB_BLANK_UNBLANK ||
-	    bd->props.fb_blank != FB_BLANK_UNBLANK)
-		level = 0;
-	else
-		level = bd->props.brightness;
+	int level = backlight_get_brightness(bd);
 
 	tmp_pmc = NV_RD32(par->riva.PMC, 0x10F0) & 0x0000FFFF;
 	tmp_pcrt = NV_RD32(par->riva.PCRTC0, 0x081C) & 0xFFFFFFFC;

-- 
2.34.1
