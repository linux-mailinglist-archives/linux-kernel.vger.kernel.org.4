Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4872E107
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbjFMLMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbjFMLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:10:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03805E52;
        Tue, 13 Jun 2023 04:10:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6D5E1FDA4;
        Tue, 13 Jun 2023 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686654604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guIJoWJMSuzJv25ve1TkcJf7H3PXNPA3ImIuH3/xvww=;
        b=hj50Iq3V4x/70hCviEOq3FpS7Jn1QAZQteUUa/48pT+K0XTZ4o4EqEAKktP2N1fI1m+1K1
        VATTZL0fsHpyLcBWcUS0D4oZWH2jeCd1p/uM9NxQb68qa5Ev7eXRS4qFZXausvDFuNCkMe
        YAEnG3zUFPOr1OTPr5EAal+LLbxJ1Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686654604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guIJoWJMSuzJv25ve1TkcJf7H3PXNPA3ImIuH3/xvww=;
        b=MyE+KQK5t7ZSZOGL+3gXBppHNkc1W7hY/84eUuj+bAevq47DAIDRK2DvgQP1lBqBAfZlwh
        JwQcvO/pIWYXKfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A28213483;
        Tue, 13 Jun 2023 11:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CLYAGYxOiGR8CQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 13 Jun 2023 11:10:04 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 26/38] fbdev/sh7760fb: Output messages with fb_dbg()
Date:   Tue, 13 Jun 2023 13:07:01 +0200
Message-ID: <20230613110953.24176-27-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230613110953.24176-1-tzimmermann@suse.de>
References: <20230613110953.24176-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cases were output helpers are called with struct fb_info.dev.
Use fb_dbg() instead. Prepares fbdev for making struct fb_info.dev
optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/sh7760fb.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index a2946f06d579e..65e2c71cf5b51 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -207,7 +207,7 @@ static int sh7760fb_set_par(struct fb_info *info)
 
 	/* rotate only works with xres <= 320 */
 	if (par->rot && (vm->xres > 320)) {
-		dev_dbg(info->dev, "rotation disabled due to display size\n");
+		fb_dbg(info, "rotation disabled due to display size\n");
 		par->rot = 0;
 	}
 
@@ -226,7 +226,7 @@ static int sh7760fb_set_par(struct fb_info *info)
 	if (ret)
 		return ret;
 
-	dev_dbg(info->dev, "%dx%d %dbpp %s (orientation %s)\n", hdcn,
+	fb_dbg(info, "%dx%d %dbpp %s (orientation %s)\n", hdcn,
 		vdln, bpp, gray ? "grayscale" : "color",
 		par->rot ? "rotated" : "normal");
 
@@ -306,7 +306,7 @@ static int sh7760fb_set_par(struct fb_info *info)
 	if (((ldmtr & 0x003f) >= LDMTR_DSTN_MONO_8) &&
 	    ((ldmtr & 0x003f) <= LDMTR_DSTN_COLOR_16)) {
 
-		dev_dbg(info->dev, " ***** DSTN untested! *****\n");
+		fb_dbg(info, " ***** DSTN untested! *****\n");
 
 		dstn_off = stride;
 		if (par->rot)
@@ -326,17 +326,17 @@ static int sh7760fb_set_par(struct fb_info *info)
 
 	sh7760fb_blank(FB_BLANK_UNBLANK, info);	/* panel on! */
 
-	dev_dbg(info->dev, "hdcn  : %6d htcn  : %6d\n", hdcn, htcn);
-	dev_dbg(info->dev, "hsynw : %6d hsynp : %6d\n", hsynw, hsynp);
-	dev_dbg(info->dev, "vdln  : %6d vtln  : %6d\n", vdln, vtln);
-	dev_dbg(info->dev, "vsynw : %6d vsynp : %6d\n", vsynw, vsynp);
-	dev_dbg(info->dev, "clksrc: %6d clkdiv: %6d\n",
+	fb_dbg(info, "hdcn  : %6d htcn  : %6d\n", hdcn, htcn);
+	fb_dbg(info, "hsynw : %6d hsynp : %6d\n", hsynw, hsynp);
+	fb_dbg(info, "vdln  : %6d vtln  : %6d\n", vdln, vtln);
+	fb_dbg(info, "vsynw : %6d vsynp : %6d\n", vsynw, vsynp);
+	fb_dbg(info, "clksrc: %6d clkdiv: %6d\n",
 		(par->pd->ldickr >> 12) & 3, par->pd->ldickr & 0x1f);
-	dev_dbg(info->dev, "ldpmmr: 0x%04x ldpspr: 0x%04x\n", par->pd->ldpmmr,
+	fb_dbg(info, "ldpmmr: 0x%04x ldpspr: 0x%04x\n", par->pd->ldpmmr,
 		par->pd->ldpspr);
-	dev_dbg(info->dev, "ldmtr : 0x%04x lddfr : 0x%04x\n", ldmtr, lddfr);
-	dev_dbg(info->dev, "ldlaor: %ld\n", stride);
-	dev_dbg(info->dev, "ldsaru: 0x%08lx ldsarl: 0x%08lx\n", sbase, ldsarl);
+	fb_dbg(info, "ldmtr : 0x%04x lddfr : 0x%04x\n", ldmtr, lddfr);
+	fb_dbg(info, "ldlaor: %ld\n", stride);
+	fb_dbg(info, "ldsaru: 0x%08lx ldsarl: 0x%08lx\n", sbase, ldsarl);
 
 	return 0;
 }
@@ -401,7 +401,7 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 	} else if (bpp > 8)
 		vram *= 2;
 	if ((vram < 1) || (vram > 1024 * 2048)) {
-		dev_dbg(info->dev, "too much VRAM required. Check settings\n");
+		fb_dbg(info, "too much VRAM required. Check settings\n");
 		return -ENODEV;
 	}
 
-- 
2.41.0

