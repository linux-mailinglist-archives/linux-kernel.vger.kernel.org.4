Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D26E13E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDMSHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:07:04 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65BD91735;
        Thu, 13 Apr 2023 11:07:01 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:59970.367170433
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 840D410029F;
        Fri, 14 Apr 2023 02:06:59 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-bkw2h with ESMTP id 7ce36ef6dddf4c1da3378e2ce90cb046 for mripard@kernel.org;
        Fri, 14 Apr 2023 02:07:00 CST
X-Transaction-ID: 7ce36ef6dddf4c1da3378e2ce90cb046
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2] drm/fbdev-generic: prohibit potential out-of-bounds access
Date:   Fri, 14 Apr 2023 02:06:22 +0800
Message-Id: <20230413180622.1014016-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The crazy fbdev test of IGT may write after EOF, which lead to out-of-bound
access for the drm drivers using fbdev-generic. For example, run fbdev test
on a x86-64+ast2400 platform with 1680x1050 resolution will cause the linux
kernel hang with following call trace:

  Oops: 0000 [#1] PREEMPT SMP PTI
  [IGT] fbdev: starting subtest eof
  Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
  [IGT] fbdev: starting subtest nullptr

  RIP: 0010:memcpy_erms+0xa/0x20
  RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
  RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
  RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
  RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
  R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
  R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
  FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
  Call Trace:
   <TASK>
   ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
   drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
   process_one_work+0x21f/0x430
   worker_thread+0x4e/0x3c0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xf4/0x120
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x2c/0x50
   </TASK>
  CR2: ffffa17d40e0b000
  ---[ end trace 0000000000000000 ]---

The indirect reason is drm_fb_helper_memory_range_to_clip() generate damage
rectangles which partially or completely go out of the active display area.
The second of argument 'off' is passing from the user-space, this will lead
to the out-of-bound if it is large than (fb_height + 1) * fb_pitches; while
DIV_ROUND_UP() may also controbute to error by 1.

This patch will add code to restrict the damage rect computed go beyond of
the last line of the framebuffer.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/drm_fb_helper.c     | 16 ++++++++++++----
 drivers/gpu/drm/drm_fbdev_generic.c |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 64458982be40..6bb1b8b27d7a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -641,19 +641,27 @@ static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
 static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
 					       struct drm_rect *clip)
 {
+	u32 line_length = info->fix.line_length;
+	u32 fb_height = info->var.yres;
 	off_t end = off + len;
 	u32 x1 = 0;
-	u32 y1 = off / info->fix.line_length;
+	u32 y1 = off / line_length;
 	u32 x2 = info->var.xres;
-	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
+	u32 y2 = DIV_ROUND_UP(end, line_length);
+
+	/* Don't allow any of them beyond the bottom bound of display area */
+	if (y1 > fb_height)
+		y1 = fb_height;
+	if (y2 > fb_height)
+		y2 = fb_height;
 
 	if ((y2 - y1) == 1) {
 		/*
 		 * We've only written to a single scanline. Try to reduce
 		 * the number of horizontal pixels that need an update.
 		 */
-		off_t bit_off = (off % info->fix.line_length) * 8;
-		off_t bit_end = (end % info->fix.line_length) * 8;
+		off_t bit_off = (off % line_length) * 8;
+		off_t bit_end = (end % line_length) * 8;
 
 		x1 = bit_off / info->var.bits_per_pixel;
 		x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index 8e5148bf40bb..b057cfbba938 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -94,7 +94,7 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	fb_helper->buffer = buffer;
 	fb_helper->fb = buffer->fb;
 
-	screen_size = buffer->gem->size;
+	screen_size = sizes->surface_height * buffer->fb->pitches[0];
 	screen_buffer = vzalloc(screen_size);
 	if (!screen_buffer) {
 		ret = -ENOMEM;
-- 
2.25.1

