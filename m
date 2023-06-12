Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939D72C7D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjFLOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbjFLOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6210E9;
        Mon, 12 Jun 2023 07:14:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 459BC2048A;
        Mon, 12 Jun 2023 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHaIM1mXVDYd6HDF2qJug1/atoNFlj4bYCqrjFZko5Y=;
        b=Hfg9XyMWEfJlY7hQ0XQ/MkPgs/keqC+BODstU1pFrBJ20k3oCU2vXIiqhaONvM99eOxkN9
        ZTQrDR8dR1nA062/VTXlI1bqE6aExK3nh76QNDGxlBXyuRNKt6mhsQYRjCcz3SquMYySji
        mAWUnW6DgtT3YnEpA0DiLZfyuhRR3hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHaIM1mXVDYd6HDF2qJug1/atoNFlj4bYCqrjFZko5Y=;
        b=2gstM1tXyQwjgJkTl8TkAoq1ZTddQJBL/3EAyI1iDJduEm0+2MSFbRe4hZUTNVigjw3ixi
        sVl93A3u8ve2X3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E85621357F;
        Mon, 12 Jun 2023 14:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eEPaNycoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:13:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 16/38] fbdev/mb862xxfb: Output messages with fb_dbg()
Date:   Mon, 12 Jun 2023 16:07:54 +0200
Message-ID: <20230612141352.29939-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612141352.29939-1-tzimmermann@suse.de>
References: <20230612141352.29939-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cases were output helpers are called with struct fb_info.dev.
Use fb_dbg() instead. Prepares fbdev for making struct fb_info.dev
optional.

v2:
	* fix another reference to struct fb_info.dev (kernel test reobot)
	* remove fb_err() from commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index b5c8fcab9940d..119c2a582ecbd 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -112,8 +112,7 @@ static int mb862xxfb_check_var(struct fb_var_screeninfo *var,
 {
 	unsigned long tmp;
 
-	if (fbi->dev)
-		dev_dbg(fbi->dev, "%s\n", __func__);
+	fb_dbg(fbi, "%s\n", __func__);
 
 	/* check if these values fit into the registers */
 	if (var->hsync_len > 255 || var->vsync_len > 255)
@@ -290,7 +289,7 @@ static int mb862xxfb_blank(int mode, struct fb_info *fbi)
 	struct mb862xxfb_par  *par = fbi->par;
 	unsigned long reg;
 
-	dev_dbg(fbi->dev, "blank mode=%d\n", mode);
+	fb_dbg(fbi, "blank mode=%d\n", mode);
 
 	switch (mode) {
 	case FB_BLANK_POWERDOWN:
@@ -791,7 +790,7 @@ static void of_platform_mb862xx_remove(struct platform_device *ofdev)
 	resource_size_t res_size = resource_size(par->res);
 	unsigned long reg;
 
-	dev_dbg(fbi->dev, "%s release\n", fbi->fix.id);
+	fb_dbg(fbi, "%s release\n", fbi->fix.id);
 
 	/* display off */
 	reg = inreg(disp, GC_DCM1);
@@ -1138,7 +1137,7 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 	struct mb862xxfb_par *par = fbi->par;
 	unsigned long reg;
 
-	dev_dbg(fbi->dev, "%s release\n", fbi->fix.id);
+	fb_dbg(fbi, "%s release\n", fbi->fix.id);
 
 	/* display off */
 	reg = inreg(disp, GC_DCM1);
-- 
2.41.0

