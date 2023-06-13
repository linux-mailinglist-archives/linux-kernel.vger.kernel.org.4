Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587372E081
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbjFMLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbjFMLKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:10:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D510D8;
        Tue, 13 Jun 2023 04:10:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D3254223F6;
        Tue, 13 Jun 2023 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686654598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Hne6zfetbnsseXQc/de0eJDmmigZxWOHUk4CZKAIDY=;
        b=KL3N5e5ivtUmwkAJemE63I+AtdC5MiHTK4dzeTOEeAKJfbjDZggCYd1n1knqsnsUGAOndJ
        A/7c86AcjfM3MVygCAn07cFPtEXjTfN+E6CjKMg6zXPLATQ4pyKPA0FX5ggtvfFIbobYxn
        G6Dp5t9Shvz7Asuokh1ps4REO/36AMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686654598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Hne6zfetbnsseXQc/de0eJDmmigZxWOHUk4CZKAIDY=;
        b=APplPEVT6MZ9PeXzJ8dv98VwUZ2pPhx1D0WWnZxRl+iwXoGHgfISZUbi9PsTM1tC17vGlu
        4n+4eow1R5DAzyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8174E13A47;
        Tue, 13 Jun 2023 11:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YD+hHoZOiGR8CQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 13 Jun 2023 11:09:58 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 07/38] fbdev/atyfb: Reorder backlight and framebuffer init/cleanup
Date:   Tue, 13 Jun 2023 13:06:42 +0200
Message-ID: <20230613110953.24176-8-tzimmermann@suse.de>
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

The driver's backlight code requires the framebuffer to be
registered. Therefore reorder the init and cleanup calls for
both data structures.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index cba2b113b28b0..51504fe39054c 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2654,11 +2654,6 @@ static int aty_init(struct fb_info *info)
 			   USE_F32KHZ | TRISTATE_MEM_EN, par);
 	} else
 #endif
-	if (M64_HAS(MOBIL_BUS) && backlight) {
-#ifdef CONFIG_FB_ATY_BACKLIGHT
-		aty_bl_init(par);
-#endif
-	}
 
 	memset(&var, 0, sizeof(var));
 #ifdef CONFIG_PPC
@@ -2751,6 +2746,12 @@ static int aty_init(struct fb_info *info)
 		goto aty_init_exit;
 	}
 
+	if (M64_HAS(MOBIL_BUS) && backlight) {
+#ifdef CONFIG_FB_ATY_BACKLIGHT
+		aty_bl_init(par);
+#endif
+	}
+
 	fb_list = info;
 
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
@@ -3716,12 +3717,13 @@ static void atyfb_remove(struct fb_info *info)
 	aty_set_crtc(par, &par->saved_crtc);
 	par->pll_ops->set_pll(info, &par->saved_pll);
 
-	unregister_framebuffer(info);
-
 #ifdef CONFIG_FB_ATY_BACKLIGHT
 	if (M64_HAS(MOBIL_BUS))
 		aty_bl_exit(info->bl_dev);
 #endif
+
+	unregister_framebuffer(info);
+
 	arch_phys_wc_del(par->wc_cookie);
 
 #ifndef __sparc__
-- 
2.41.0

