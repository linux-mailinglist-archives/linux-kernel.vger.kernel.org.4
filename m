Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A136E825F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDSUID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjDSUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:08:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB44526F;
        Wed, 19 Apr 2023 13:07:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxjdobSkBkLhcfAA--.37226S3;
        Thu, 20 Apr 2023 04:07:55 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxfb4XSkBkM88vAA--.17264S2;
        Thu, 20 Apr 2023 04:07:51 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>, Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4] drm/fbdev-generic: prohibit potential out-of-bounds access
Date:   Thu, 20 Apr 2023 04:07:42 +0800
Message-Id: <20230419200742.1571818-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxfb4XSkBkM88vAA--.17264S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF1rXFWUCw1DtrWrZF13Jwb_yoWrAr4fpF
        W7GayDKr4kJFn8WrWxA3WUAw15Zan7ZFWIqrZ7G348ZF45A3ZF9F1UGF4UWry5Jr1xZr13
        twn0yw1jkr1qkaDanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
        AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev test of IGT may write after EOF, which lead to out-of-bound
access for the drm drivers hire fbdev-generic. However, run fbdev test
on x86 +ast2400 platform, with 1680x1050 resolution, will cause the
linux kernel hang with the following call trace:

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

The is because damage rectangle rectange computed by
drm_fb_helper_memory_range_to_clip() does not guaranteed to be bound in the
screen's active display area. In details, we typically allocate buffers in
the granularity of the page-size for mmap system call support.

Exporting bit larger buffer in size than the size of active display to user
space do allow the userspace write below the bottom of the display, it is
not a big issue because there still have memory resolve the access.

Yet, draft too far from the boundary is dangerious. Because such a access
put the system in the situation of out-of-bound access. The root cause is
that we do not do the validation, also DIV_ROUND_UP() may also introduce
off-by-one error.

This patch add logic to restrict the damage rectangle dract out of the
visiable boundary.

Fixes: aa15c677cc34 ("drm/fb-helper: Fix vertical damage clipping")

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/dri-devel/ad44df29-3241-0d9e-e708-b0338bf3c623@189.cn/
---
 drivers/gpu/drm/drm_fb_helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

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
-- 
2.25.1

