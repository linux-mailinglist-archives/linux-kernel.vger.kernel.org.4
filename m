Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE474D67C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjGJNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGJNBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0011A;
        Mon, 10 Jul 2023 06:01:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 267C9221BB;
        Mon, 10 Jul 2023 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688994076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMXmZ1NNzOJDSERg6Ij7CzUCJhbAE0qzmKXhUXS3z9c=;
        b=056eevBXKVE6K7e8Udic7TMKctkMoQzDJWfsflNubinHMzhKPUCPTUljOXhhD1XjcaluGs
        0/lWU6tE1SW5hLc/L5zAM88mNdqtfgqbkYmwUEpMOvUXUoWSxqU72MZyGJQGibL0iB7qjN
        numBIfJc40XefF+xCNM6rAGI2Crsdd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688994076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMXmZ1NNzOJDSERg6Ij7CzUCJhbAE0qzmKXhUXS3z9c=;
        b=Wrch4FmeVdIs8b/l/PnTvvOuMUowrZjyBP1+a4S8cOFS+Dd2TWrMlMx6uZihpKEpo45fkd
        9vYlweJRCs+oDDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5FE813A6B;
        Mon, 10 Jul 2023 13:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIN2LxsBrGTTFAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 10 Jul 2023 13:01:15 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, javierm@redhat.com
Cc:     linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-nvidia@lists.surfsouth.com,
        linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 03/17] fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
Date:   Mon, 10 Jul 2023 14:50:07 +0200
Message-ID: <20230710130113.14563-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710130113.14563-1-tzimmermann@suse.de>
References: <20230710130113.14563-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag FBINFO_DEFAULT is 0 and has no effect, as struct fbinfo.flags
has been allocated to zero by kzalloc(). So do not set it.

Flags should signal differences from the default values. After cleaning
up all occurences of FBINFO_DEFAULT, the token can be removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/video/fbdev/controlfb.c           | 2 +-
 drivers/video/fbdev/cyber2000fb.c         | 2 +-
 drivers/video/fbdev/valkyriefb.c          | 1 -
 drivers/video/fbdev/vermilion/vermilion.c | 2 +-
 drivers/video/fbdev/vt8500lcdfb.c         | 3 +--
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 82eeb139c4eb..717134c141ff 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -775,7 +775,7 @@ static void __init control_init_info(struct fb_info *info, struct fb_info_contro
 	info->par = &p->par;
 	info->fbops = &controlfb_ops;
 	info->pseudo_palette = p->pseudo_palette;
-        info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->flags = FBINFO_HWACCEL_YPAN;
 	info->screen_base = p->frame_buffer + CTRLFB_OFF;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 38c0a6866d76..98ea56a9abf1 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1459,7 +1459,7 @@ static struct cfb_info *cyberpro_alloc_fb_info(unsigned int id, char *name)
 	cfb->fb.var.accel_flags	= FB_ACCELF_TEXT;
 
 	cfb->fb.fbops		= &cyber2000fb_ops;
-	cfb->fb.flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	cfb->fb.flags		= FBINFO_HWACCEL_YPAN;
 	cfb->fb.pseudo_palette	= cfb->pseudo_palette;
 
 	spin_lock_init(&cfb->reg_b0_lock);
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index b166b7cfe0e5..fd4488777032 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -535,7 +535,6 @@ static int __init valkyrie_init_info(struct fb_info *info,
 {
 	info->fbops = &valkyriefb_ops;
 	info->screen_base = p->frame_buffer + 0x1000;
-	info->flags = FBINFO_DEFAULT;
 	info->pseudo_palette = p->pseudo_palette;
 	info->par = &p->par;
 	return fb_alloc_cmap(&info->cmap, 256, 0);
diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 32e74e02a02f..71584c775efd 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -477,7 +477,7 @@ static int vml_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	info = &vinfo->info;
-	info->flags = FBINFO_DEFAULT | FBINFO_PARTIAL_PAN_OK;
+	info->flags = FBINFO_PARTIAL_PAN_OK;
 
 	err = vmlfb_enable_mmio(par);
 	if (err)
diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index 31d4e85b220c..42d39a9d5130 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -300,8 +300,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
 
 	fbi->fb.fbops		= &vt8500lcd_ops;
-	fbi->fb.flags		= FBINFO_DEFAULT
-				| FBINFO_HWACCEL_COPYAREA
+	fbi->fb.flags		= FBINFO_HWACCEL_COPYAREA
 				| FBINFO_HWACCEL_FILLRECT
 				| FBINFO_HWACCEL_YPAN
 				| FBINFO_VIRTFB
-- 
2.41.0

