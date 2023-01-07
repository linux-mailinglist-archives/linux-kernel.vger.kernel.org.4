Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428AE6610F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjAGS1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjAGS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78137260;
        Sat,  7 Jan 2023 10:26:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F55860BB5;
        Sat,  7 Jan 2023 18:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6118C43396;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115981;
        bh=NopO6/WDONQttpL/maFut1E5RlkJB2uOICrSmRTuvrs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=a+TGg0zalLu1IZUe0Dusx60kOUTAgJB6i2V0ntZSdpG5hA7ZzF9GFzb2Jzh5cLqTV
         udilmzFV/9GY2Q3+sJ1scx5kxvtRS4G/9uxntABwo7uUwhgf6vFzlxK7WJqaNC5zMo
         2N3akNeLX30I+ZVwfVcQoVc25k6ocdIxpIS3uirQJC6Ehp1L01MwXb9Exhe/1cLaPD
         6BQnOgaCjj1iWPKfalhHAuMKx/39xYumSGulqURz1zsjcovak9tmiWrsqRY/YJaXxL
         xZsAIM0ke+gx7atPRAuPhTvpBKHxO1nLnBlU+RrLEzUE+Ak8SXCQIo7SBDQpfYHPnz
         UFvQ6BGEyrU1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C4E09C54EBC;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:25 +0100
Subject: [PATCH 11/15] powerpc: via-pmu-backlight: Introduce
 backlight_get_brightness()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-11-1bd9bafb351f@ravnborg.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=1090;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=lPqymbzfNTifpXa2QzoPI3zSglttX8N9s2/xbxu8aQ4=; =?utf-8?q?b=3DoM0VPahuDXBa?=
 =?utf-8?q?8NICHQ0XEZfUD/cH3Cz8tGxqgZI94evf9mznv/gWoWJFlh9dpNlj1GiU49BWm0cl?=
 g1Zmn+5lAV0k2VgXGHyPJ7cqtCg0PIxR/iXKZWAR3vZGmqh+vYaD
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/via-pmu-backlight.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index 2194016122d2..c2d87e7fa85b 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -71,12 +71,7 @@ static int pmu_backlight_get_level_brightness(int level)
 static int __pmu_backlight_update_status(struct backlight_device *bd)
 {
 	struct adb_request req;
-	int level = bd->props.brightness;
-
-
-	if (bd->props.power != FB_BLANK_UNBLANK ||
-	    bd->props.fb_blank != FB_BLANK_UNBLANK)
-		level = 0;
+	int level = backlight_get_brightness(bd);
 
 	if (level > 0) {
 		int pmulevel = pmu_backlight_get_level_brightness(level);

-- 
2.34.1
