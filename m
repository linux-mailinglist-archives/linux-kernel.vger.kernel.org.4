Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB072E0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbjFMLLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbjFMLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:10:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A94E52;
        Tue, 13 Jun 2023 04:10:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B6681FD9A;
        Tue, 13 Jun 2023 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686654600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgea4CAx5RQUmrYwJYNcyiyGnDDQ3dqg16YEIp4VW1k=;
        b=KpOGwMTRGofNmhOvJtJWHYoxw7MmbRGeo6FzxVMzqS8Cl/HkPaqlqAIbbj5QVOxQDh/1ef
        HmTOZZdLLfzm9zdlL6u/vxhlgRbWB0WsEox8pd5anT+ZsyfUUVWGtiHUZ7ZUy3ZgGKZhKE
        8wfoh2o8hDRXm8FwGh53HXFXlR5ZspA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686654600;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgea4CAx5RQUmrYwJYNcyiyGnDDQ3dqg16YEIp4VW1k=;
        b=BH3aTWJc5uDayXV3wpXjuSh1Sh5kbMo7UKgjKKzOa4KrYc6ekCR5qDLHKStl5r3NnssLBl
        0ZAPAlm7SNuT1iDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 064B813483;
        Tue, 13 Jun 2023 11:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KPbCAIhOiGR8CQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 13 Jun 2023 11:10:00 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 12/38] fbdev/ep93xx-fb: Alloc DMA memory from hardware device
Date:   Tue, 13 Jun 2023 13:06:47 +0200
Message-ID: <20230613110953.24176-13-tzimmermann@suse.de>
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

Pass the hardware device to the DMA helpers dma_alloc_wc(), dma_mmap_wc()
and dma_free_coherent(). The fbdev device that is currently being used is
a software device and does not provide DMA memory.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/ep93xx-fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 94fe52928be25..376ee59e925c2 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -312,7 +312,7 @@ static int ep93xxfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned int offset = vma->vm_pgoff << PAGE_SHIFT;
 
 	if (offset < info->fix.smem_len) {
-		return dma_mmap_wc(info->dev, vma, info->screen_base,
+		return dma_mmap_wc(info->device, vma, info->screen_base,
 				   info->fix.smem_start, info->fix.smem_len);
 	}
 
@@ -423,7 +423,7 @@ static int ep93xxfb_alloc_videomem(struct fb_info *info)
 	/* Maximum 16bpp -> used memory is maximum x*y*2 bytes */
 	fb_size = EP93XXFB_MAX_XRES * EP93XXFB_MAX_YRES * 2;
 
-	virt_addr = dma_alloc_wc(info->dev, fb_size, &phys_addr, GFP_KERNEL);
+	virt_addr = dma_alloc_wc(info->device, fb_size, &phys_addr, GFP_KERNEL);
 	if (!virt_addr)
 		return -ENOMEM;
 
@@ -440,7 +440,7 @@ static int ep93xxfb_alloc_videomem(struct fb_info *info)
 			"has bit 27 set: cannot init framebuffer\n",
 			phys_addr);
 
-		dma_free_coherent(info->dev, fb_size, virt_addr, phys_addr);
+		dma_free_coherent(info->device, fb_size, virt_addr, phys_addr);
 		return -ENOMEM;
 	}
 
@@ -454,7 +454,7 @@ static int ep93xxfb_alloc_videomem(struct fb_info *info)
 static void ep93xxfb_dealloc_videomem(struct fb_info *info)
 {
 	if (info->screen_base)
-		dma_free_coherent(info->dev, info->fix.smem_len,
+		dma_free_coherent(info->device, info->fix.smem_len,
 				  info->screen_base, info->fix.smem_start);
 }
 
-- 
2.41.0

