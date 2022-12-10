Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3F648E74
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLJLfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLJLfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:35:37 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE121FCFF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:35:35 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 3y8gpaJiRNF1W3y8jp0xrl; Sat, 10 Dec 2022 12:35:33 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Dec 2022 12:35:33 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] video: fbdev: uvesafb: Simplify uvesafb_remove()
Date:   Sat, 10 Dec 2022 12:35:23 +0100
Message-Id: <72b61f099e846dbb16c13ffb50c877ed196a308f.1670671944.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0eba6acb70fa1270d8cf798afd11ce342aa7e8e1.1670671944.git.christophe.jaillet@wanadoo.fr>
References: <0eba6acb70fa1270d8cf798afd11ce342aa7e8e1.1670671944.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the remove() function is called, we know that the probe() function has
successfully been executed. So 'info' is known to be not NULL.

Simplify the code accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Change in v2:
  - new patch
---
 drivers/video/fbdev/uvesafb.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 0e3cabbec4b4..2bb95c35ab2a 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1777,25 +1777,23 @@ static int uvesafb_probe(struct platform_device *dev)
 static int uvesafb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
+	struct uvesafb_par *par = info->par;
 
-	if (info) {
-		struct uvesafb_par *par = info->par;
+	sysfs_remove_group(&dev->dev.kobj, &uvesafb_dev_attgrp);
+	unregister_framebuffer(info);
+	release_region(0x3c0, 32);
+	iounmap(info->screen_base);
+	arch_phys_wc_del(par->mtrr_handle);
+	release_mem_region(info->fix.smem_start, info->fix.smem_len);
+	fb_destroy_modedb(info->monspecs.modedb);
+	fb_dealloc_cmap(&info->cmap);
 
-		sysfs_remove_group(&dev->dev.kobj, &uvesafb_dev_attgrp);
-		unregister_framebuffer(info);
-		release_region(0x3c0, 32);
-		iounmap(info->screen_base);
-		arch_phys_wc_del(par->mtrr_handle);
-		release_mem_region(info->fix.smem_start, info->fix.smem_len);
-		fb_destroy_modedb(info->monspecs.modedb);
-		fb_dealloc_cmap(&info->cmap);
+	kfree(par->vbe_modes);
+	kfree(par->vbe_state_orig);
+	kfree(par->vbe_state_saved);
 
-		kfree(par->vbe_modes);
-		kfree(par->vbe_state_orig);
-		kfree(par->vbe_state_saved);
+	framebuffer_release(info);
 
-		framebuffer_release(info);
-	}
 	return 0;
 }
 
-- 
2.34.1

