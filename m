Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1172C7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbjFLOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjFLOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EA1718;
        Mon, 12 Jun 2023 07:14:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7652048D;
        Mon, 12 Jun 2023 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DApq01bMcWPqgYhwuryEu5qdYBZjYFccLYihwSFiAXk=;
        b=Zora8HfwuVeNq+hm5G6DUqPUKgOtH8m30gUW2OZP6oVeOC0SvWGqgTfYBjKPMAc4pI9aQI
        6Ew5qXJjBTM44urrB1/6yhlbyymEG/osTY/bs4iFSYk4d5bxC6F57x56AInpWgVPVsVN+X
        4ceLrGintZ/Mib46vhkSzUt+OkIljto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579243;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DApq01bMcWPqgYhwuryEu5qdYBZjYFccLYihwSFiAXk=;
        b=H/zAlbOtFqKuNb3tKoyQFw3FYtGoeSWfqKSzX2hZ0Cmx54Oz0an5bSEQ+PUQanuJpxb/Pf
        WQfNEU/GNlTsfLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30A641357F;
        Mon, 12 Jun 2023 14:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFDoCisoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:14:03 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 25/38] fbdev/sh7760fb: Use fb_dbg() in sh7760fb_get_color_info()
Date:   Mon, 12 Jun 2023 16:08:03 +0200
Message-ID: <20230612141352.29939-26-tzimmermann@suse.de>
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

Give struct fb_info to sh7760fb_get_color_info() and use it in
call to fb_dbg(). Prepares fbdev for making struct fb_info.dev
optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/sh7760fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index 4c092c7935027..a2946f06d579e 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -118,7 +118,7 @@ static int sh7760_setcolreg (u_int regno,
 	return 0;
 }
 
-static int sh7760fb_get_color_info(struct device *dev,
+static int sh7760fb_get_color_info(struct fb_info *info,
 				   u16 lddfr, int *bpp, int *gray)
 {
 	int lbpp, lgray;
@@ -150,7 +150,7 @@ static int sh7760fb_get_color_info(struct device *dev,
 		lgray = 0;
 		break;
 	default:
-		dev_dbg(dev, "unsupported LDDFR bit depth.\n");
+		fb_dbg(info, "unsupported LDDFR bit depth.\n");
 		return -EINVAL;
 	}
 
@@ -170,7 +170,7 @@ static int sh7760fb_check_var(struct fb_var_screeninfo *var,
 	int ret, bpp;
 
 	/* get color info from register value */
-	ret = sh7760fb_get_color_info(info->dev, par->pd->lddfr, &bpp, NULL);
+	ret = sh7760fb_get_color_info(info, par->pd->lddfr, &bpp, NULL);
 	if (ret)
 		return ret;
 
@@ -222,7 +222,7 @@ static int sh7760fb_set_par(struct fb_info *info)
 	vdln = vm->yres;
 
 	/* get color info from register value */
-	ret = sh7760fb_get_color_info(info->dev, par->pd->lddfr, &bpp, &gray);
+	ret = sh7760fb_get_color_info(info, par->pd->lddfr, &bpp, &gray);
 	if (ret)
 		return ret;
 
@@ -381,7 +381,7 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 		return 0;
 
 	/* get color info from register value */
-	ret = sh7760fb_get_color_info(info->dev, par->pd->lddfr, &bpp, NULL);
+	ret = sh7760fb_get_color_info(info, par->pd->lddfr, &bpp, NULL);
 	if (ret) {
 		printk(KERN_ERR "colinfo\n");
 		return ret;
-- 
2.41.0

