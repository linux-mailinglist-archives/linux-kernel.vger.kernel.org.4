Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC3675430
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjATMJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjATMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B43A1016
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqUuYSilJanvI6AcOWoQdMxrU3ZSpibdQFaGNCu/ttw=;
        b=EGhDdAldprAOYtuzq3wXJYYYKi1ihFDe8wRkvQYaf4M4KpPRaYxkzEfqsqAhRR7qjhkvFP
        hSug8f/hkSXLQIhR1p0+9thCsUljNaveChbCTdjyaZklX50zfXDmysbPTfqI9ycX3yzGLh
        i33eINac/RzeI67Yfs2CXIyyU7ScDyc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-295-GawQUWB1NRedQk5H1wjShg-1; Fri, 20 Jan 2023 07:08:35 -0500
X-MC-Unique: GawQUWB1NRedQk5H1wjShg-1
Received: by mail-wr1-f69.google.com with SMTP id o11-20020adf8b8b000000b002be143c4827so914799wra.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqUuYSilJanvI6AcOWoQdMxrU3ZSpibdQFaGNCu/ttw=;
        b=VD2hJDyjLt8ExVuD/G1E7S9e7NTz2G0lqY8F1vG3/WHuSjyrI+sLcjpws5ACxpKtqT
         Msmauwcni7X9hVZQVV9IAzHjtV1vJdKS5/cAs7dgPJ2EXsKrrMih7bvEtmo5nh6jo4rF
         2S/VsIHbKn7imq9Vm+bPTN1Scs3MhsbvXace174pZS7LkAfTrfuMRbH6+x0v/zCWb6K2
         mp4fkKUjnP0NpoWJri0xcxvlY+SORvrFm3CzkaUNTGUzjf9X7db4BIsan9omvh+FBF9w
         N8Gl9MFKzynMg4LNij/zFKTx352zLp2AWDAI5/Im4hcejG9xpZ2HCTVGx/7ALkJrJ60v
         rNyQ==
X-Gm-Message-State: AFqh2koBT8JV4RLnmOEUtdAX5E+01pQ7EKWrCtSjxsUJDvQATKl2rTt8
        oF36vhbHX98UipmqSy9q9HhPOukUOS1MQ5aPkndIQISOP/rvLDtEz+3egotK3sznRzxLvz+JDfe
        UVBzx+0mJL7slHIamD88OSuJutRvUu+l2ohpwoRraxE2XbjqgzuO1tsU33GrbZBeYjrk+W2JFq8
        Q=
X-Received: by 2002:a05:600c:1d19:b0:3db:1838:3f01 with SMTP id l25-20020a05600c1d1900b003db18383f01mr8394123wms.32.1674216513565;
        Fri, 20 Jan 2023 04:08:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsltWTsS74K+GwUiFBdFMOU5E3E3rABKvdj8rYfh/a6M4rEvqwkD4GXcTg7GFO09fFZSogS7g==
X-Received: by 2002:a05:600c:1d19:b0:3db:1838:3f01 with SMTP id l25-20020a05600c1d1900b003db18383f01mr8394099wms.32.1674216513271;
        Fri, 20 Jan 2023 04:08:33 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm32766336wrx.14.2023.01.20.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:08:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/fb-helper: Use a per-driver FB deferred I/O handler
Date:   Fri, 20 Jan 2023 13:08:22 +0100
Message-Id: <20230120120822.2536032-4-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120120822.2536032-1-javierm@redhat.com>
References: <20230120120822.2536032-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM fbdev emulation layer sets the struct fb_info .fbdefio field to
a struct fb_deferred_io pointer, that is shared across all drivers that
use the generic drm_fbdev_generic_setup() helper function.

It is a problem because the fbdev core deferred I/O logic assumes that
the struct fb_deferred_io data is not shared between devices, and it's
stored there state such as the list of pages touched and a mutex that
is use to synchronize between the fb_deferred_io_track_page() function
that track the dirty pages and fb_deferred_io_work() workqueue handler
doing the actual deferred I/O.

The latter can lead to the following error, since it may happen that two
drivers are probed and then one is removed, which causes the mutex bo be
destroyed and not existing anymore by the time the other driver tries to
grab it for the fbdev deferred I/O logic:

[  369.756553] ------------[ cut here ]------------
[  369.756604] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  369.756631] WARNING: CPU: 2 PID: 1023 at kernel/locking/mutex.c:582 __mutex_lock+0x348/0x424
[  369.756744] Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ip
v6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr btsdio bluetooth sunrpc brcmfmac snd_soc_hdmi_codec cpufreq_dt cfg80211 vfat fat vc4 rfkill brcmutil raspberrypi_cpufreq i2c_bcm2835 iproc_rng200 bcm2711_thermal snd_soc_core snd_pcm_dmaen
gine leds_gpio nvmem_rmem joydev hid_cherry uas usb_storage gpio_raspberrypi_exp v3d snd_pcm raspberrypi_hwmon gpu_sched bcm2835_wdt broadcom bcm_phy_lib snd_timer genet snd mdio_bcm_unimac clk_bcm2711_dvp soundcore drm_display_helper pci
e_brcmstb cec ip6_tables ip_tables fuse
[  369.757400] CPU: 2 PID: 1023 Comm: fbtest Not tainted 5.19.0-rc6+ #94
[  369.757455] Hardware name: raspberrypi,4-model-b Raspberry Pi 4 Model B Rev 1.4/Raspberry Pi 4 Model B Rev 1.4, BIOS 2022.10 10/01/2022
[  369.757538] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  369.757596] pc : __mutex_lock+0x348/0x424
[  369.757635] lr : __mutex_lock+0x348/0x424
[  369.757672] sp : ffff80000953bb00
[  369.757703] x29: ffff80000953bb00 x28: ffff17fdc087c000 x27: 0000000000000002
[  369.757771] x26: ffff17fdc349f9b0 x25: fffffc5ff72e0100 x24: 0000000000000000
[  369.757838] x23: 0000000000000000 x22: 0000000000000002 x21: ffffa618df636f10
[  369.757903] x20: ffff80000953bb68 x19: ffffa618e0f18138 x18: 0000000000000001
[  369.757968] x17: 0000000020000000 x16: 0000000000000002 x15: 0000000000000000
[  369.758032] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
[  369.758097] x11: 00000000ffffdfff x10: ffffa618e0c79f88 x9 : ffffa618de472484
[  369.758162] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 00000000000affa8
[  369.758227] x5 : 0000000000001fff x4 : 0000000000000000 x3 : 0000000000000027
[  369.758292] x2 : 0000000000000001 x1 : ffff17fdc087c000 x0 : 0000000000000028
[  369.758357] Call trace:
[  369.758383]  __mutex_lock+0x348/0x424
[  369.758420]  mutex_lock_nested+0x4c/0x5c
[  369.758459]  fb_deferred_io_mkwrite+0x78/0x1d8
[  369.758507]  do_page_mkwrite+0x5c/0x19c
[  369.758550]  wp_page_shared+0x70/0x1a0
[  369.758590]  do_wp_page+0x3d0/0x510
[  369.758628]  handle_pte_fault+0x1c0/0x1e0
[  369.758670]  __handle_mm_fault+0x250/0x380
[  369.758712]  handle_mm_fault+0x17c/0x3a4
[  369.758753]  do_page_fault+0x158/0x530
[  369.758792]  do_mem_abort+0x50/0xa0
[  369.758831]  el0_da+0x78/0x19c
[  369.758864]  el0t_64_sync_handler+0xbc/0x150
[  369.758904]  el0t_64_sync+0x190/0x194
[  369.758942] irq event stamp: 11395
[  369.758973] hardirqs last  enabled at (11395): [<ffffa618de472554>] __up_console_sem+0x74/0x80
[  369.759042] hardirqs last disabled at (11394): [<ffffa618de47254c>] __up_console_sem+0x6c/0x80
[  369.760554] softirqs last  enabled at (11392): [<ffffa618de330a74>] __do_softirq+0x4c4/0x6b8
[  369.762060] softirqs last disabled at (11383): [<ffffa618de3c9124>] __irq_exit_rcu+0x104/0x214
[  369.763564] ---[ end trace 0000000000000000 ]---

Fixes: d536540f304c ("drm/fb-helper: Add generic fbdev emulation .fb_probe function")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

 drivers/gpu/drm/drm_fbdev_generic.c | 11 +++++------
 include/drm/drm_fb_helper.h         | 10 ++++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index b2df8c03594c..bd1f8f28297c 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -171,11 +171,6 @@ static const struct fb_ops drm_fbdev_fb_ops = {
 	.fb_imageblit	= drm_fbdev_fb_imageblit,
 };
 
-static struct fb_deferred_io drm_fbdev_defio = {
-	.delay		= HZ / 20,
-	.deferred_io	= drm_fb_helper_deferred_io,
-};
-
 /*
  * This function uses the client API to create a framebuffer backed by a dumb buffer.
  */
@@ -222,7 +217,11 @@ static int drm_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
 			return -ENOMEM;
 		fbi->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
 
-		fbi->fbdefio = &drm_fbdev_defio;
+		/* Set a default deferred I/O handler */
+		fb_helper->fbdefio.delay = HZ / 20;
+		fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
+
+		fbi->fbdefio = &fb_helper->fbdefio;
 		ret = fb_deferred_io_init(fbi);
 		if (ret)
 			return ret;
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index f443e1f11654..39b42c1a1954 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -203,6 +203,16 @@ struct drm_fb_helper {
 	 * the smem_start field should always be cleared to zero.
 	 */
 	bool hint_leak_smem_start;
+
+	/**
+	 * @fbdefio:
+	 *
+	 * Temporary storage for the driver's FB deferred I/O handler. If the
+	 * driver uses the DRM fbdev emulation layer, this is set by the core
+	 * to a generic deferred I/O handler if a driver is preferring to use
+	 * a shadow buffer.
+	 */
+	struct fb_deferred_io fbdefio;
 };
 
 static inline struct drm_fb_helper *
-- 
2.39.0

