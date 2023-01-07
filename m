Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80A661108
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjAGS13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjAGS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88FB40C12;
        Sat,  7 Jan 2023 10:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A1EB80689;
        Sat,  7 Jan 2023 18:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72536C433AC;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115981;
        bh=CGUKurJK1iYSsqV7DCPY1kNfW8t884NAue0bEi2srQ8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=kSLKP185ei3AEEFXwIPjE6QdJYPCRuPWWZvaRE10jNJrkmZelz1gq3fQ0Du4yaoWP
         Rn6vIKFT5nTUkWwS8HQK7A+D1JjcOyi2Qp+l997hHlO8UYi5KGumFH9Iv97Yoxosnf
         c5qEE5PEkasLF1dsL8AAhXWQUkvg5i4Se7up6Xi8uPsprJClqDFEcsxW25/7tbfsfS
         XuY7rH4o8KbpzSiR/pwIc638TR5aKUgelx94MH9TmTUjqYYTH0SnwhjE6nzRmFHnWE
         H0ZtguvJ6iOZPhsthGsTri3tuv5xSpovkt7K7vUiFzkkDSDs27VQo+1XAYZEl5hkxr
         lAcNIXVoJ11BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E7C46467;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:20 +0100
Subject: [PATCH 06/15] video: fbdev: aty128fb: Introduce backlight_get_brightness()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-6-1bd9bafb351f@ravnborg.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=1162;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=n8Kx2XY+cYFmLkcdV5dyk6zjH/vhpqMDIzovg3Z1GFo=; =?utf-8?q?b=3DqvKdgsM7OlWq?=
 =?utf-8?q?GoR/P13Xavz5UkNGEdv1D6H6ewY0ou7Vszpmyqw86Gyff1CGVv3rHRS/v1qiPegZ?=
 IzxoKSMSBSuVXcEH8FTi9l2NNIUcaugLu4GMLSPyYepKLKiAsSsb
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
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/aty128fb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index dd31b9d7d337..736126cc5049 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -1764,17 +1764,10 @@ static int aty128_bl_update_status(struct backlight_device *bd)
 {
 	struct aty128fb_par *par = bl_get_data(bd);
 	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);
-	int level;
-
-	if (bd->props.power != FB_BLANK_UNBLANK ||
-	    bd->props.fb_blank != FB_BLANK_UNBLANK ||
-	    !par->lcd_on)
-		level = 0;
-	else
-		level = bd->props.brightness;
+	int level = backlight_get_brightness(bd);
 
 	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
-	if (level > 0) {
+	if (level > 0 || par->lcd_on) {
 		reg |= LVDS_DIGION;
 		if (!(reg & LVDS_ON)) {
 			reg &= ~LVDS_BLON;

-- 
2.34.1
