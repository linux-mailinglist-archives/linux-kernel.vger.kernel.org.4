Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6479F74D6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGJNBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjGJNBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A768118;
        Mon, 10 Jul 2023 06:01:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C15CE221BA;
        Mon, 10 Jul 2023 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688994075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88rPmDGaS5gKniv3Edf9SKUMMSNGLxAYotJPEpDKSY0=;
        b=iI+YdRNDj5roFr+qOpBW4pQiEAaBopdRUiHG5zuIRb1y0+ybtz/NnVxVBMa5EIJRu6ltWS
        +fc/WnmvzwBboWzDqmOj5Qob383Is/QvSeg41r5d75Sr0CU8Qf8Gzrsq/+f7Ssni6U/Qea
        O5hM6rasaSVFgFepwU9E2Sc7GM1WzHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688994075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88rPmDGaS5gKniv3Edf9SKUMMSNGLxAYotJPEpDKSY0=;
        b=UtgwnR9WK2m89ypILgWLnJMM0a9zUC2f0u22B30PTkORSB9Ev+brG4x1VLnbIsxRmb0NOA
        jcaYZmAYjwgIieBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70DE313A05;
        Mon, 10 Jul 2023 13:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mIWQGhsBrGTTFAAAMHmgww
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
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/17] fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
Date:   Mon, 10 Jul 2023 14:50:06 +0200
Message-ID: <20230710130113.14563-3-tzimmermann@suse.de>
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
has been allocated to zero by a static declaration. So do not set it.

Flags should signal differences from the default values. After cleaning
up all occurences of FBINFO_DEFAULT, the token can be removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/68328fb.c  | 2 +-
 drivers/video/fbdev/acornfb.c  | 2 +-
 drivers/video/fbdev/g364fb.c   | 2 +-
 drivers/video/fbdev/hpfb.c     | 1 -
 drivers/video/fbdev/macfb.c    | 1 -
 drivers/video/fbdev/maxinefb.c | 1 -
 6 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/68328fb.c b/drivers/video/fbdev/68328fb.c
index 07d6e8dc686b..956dd2399cc0 100644
--- a/drivers/video/fbdev/68328fb.c
+++ b/drivers/video/fbdev/68328fb.c
@@ -448,7 +448,7 @@ static int __init mc68x328fb_init(void)
 		fb_info.var.red.offset = fb_info.var.green.offset = fb_info.var.blue.offset = 0;
 	}
 	fb_info.pseudo_palette = &mc68x328fb_pseudo_palette;
-	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	fb_info.flags = FBINFO_HWACCEL_YPAN;
 
 	if (fb_alloc_cmap(&fb_info.cmap, 256, 0))
 		return -ENOMEM;
diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index 1b72edc01cfb..8fec21dfca09 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -694,7 +694,7 @@ static void acornfb_init_fbinfo(void)
 	first = 0;
 
 	fb_info.fbops		= &acornfb_ops;
-	fb_info.flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	fb_info.flags		= FBINFO_HWACCEL_YPAN;
 	fb_info.pseudo_palette	= current_par.pseudo_palette;
 
 	strcpy(fb_info.fix.id, "Acorn");
diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
index c5b7673ddc6c..0825cbde116e 100644
--- a/drivers/video/fbdev/g364fb.c
+++ b/drivers/video/fbdev/g364fb.c
@@ -219,7 +219,7 @@ int __init g364fb_init(void)
 	fb_info.screen_base = (char *) G364_MEM_BASE;	/* virtual kernel address */
 	fb_info.var = fb_var;
 	fb_info.fix = fb_fix;
-	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	fb_info.flags = FBINFO_HWACCEL_YPAN;
 
 	fb_alloc_cmap(&fb_info.cmap, 255, 0);
 
diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index 77fbff47b1a8..406c1383cbda 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -287,7 +287,6 @@ static int hpfb_init_one(unsigned long phys_base, unsigned long virt_base)
 	else
 		strcat(fb_info.fix.id, "Catseye");
 	fb_info.fbops = &hpfb_ops;
-	fb_info.flags = FBINFO_DEFAULT;
 	fb_info.var   = hpfb_defined;
 	fb_info.screen_base = (char *)fb_start;
 
diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 44ff860a3f37..5ca208d992cc 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -876,7 +876,6 @@ static int __init macfb_init(void)
 	fb_info.var		= macfb_defined;
 	fb_info.fix		= macfb_fix;
 	fb_info.pseudo_palette	= pseudo_palette;
-	fb_info.flags		= FBINFO_DEFAULT;
 
 	err = fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 	if (err)
diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinefb.c
index 4e6b05232ae2..0ac1873b2acb 100644
--- a/drivers/video/fbdev/maxinefb.c
+++ b/drivers/video/fbdev/maxinefb.c
@@ -155,7 +155,6 @@ int __init maxinefb_init(void)
 	fb_info.screen_base = (char *)maxinefb_fix.smem_start;
 	fb_info.var = maxinefb_defined;
 	fb_info.fix = maxinefb_fix;
-	fb_info.flags = FBINFO_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-- 
2.41.0

