Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935AA6E46A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDQLkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDQLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:40:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 205741706;
        Mon, 17 Apr 2023 04:39:18 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxEk5ILj1kOO0dAA--.34881S3;
        Mon, 17 Apr 2023 19:32:24 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx97xDLj1kB8AqAA--.48515S2;
        Mon, 17 Apr 2023 19:32:21 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>, Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3] drm/fbdev-generic: prohibit potential out-of-bounds access
Date:   Mon, 17 Apr 2023 19:32:19 +0800
Message-Id: <20230417113219.1354078-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx97xDLj1kB8AqAA--.48515S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF17tr43CFWDJF1UGw17Wrg_yoW5ZrWxpF
        WfKFWUKr4kJFn8Xr47A3WUJw1UAanrZFWxurWxKryjyFyYy3429ryjyrWUWFy5Gr18Jr13
        trn093W0kr1qyaUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AF
        wI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
        AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev test of IGT may write after EOF, which lead to out-of-bound
access for the drm drivers using fbdev-generic. For example, on a x86
+ aspeed bmc card platform, with a 1680x1050 resolution display, running
fbdev test if IGT will cause the linux kernel hang with the following
call trace:

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

The direct reason is that damage rectange computed by
drm_fb_helper_memory_range_to_clip() does not guaranteed to be in-bound.
It is already results in workaround code populate to elsewhere. Another
reason is that exposing a larger buffer size than the actual needed help
to trigger this bug intrinsic in drm_fb_helper_memory_range_to_clip().

Others fbdev emulation solutions write to the GEM buffer directly, they
won't reproduce this bug because the .fb_dirty function callback do not
being hooked, so no chance is given to drm_fb_helper_memory_range_to_clip()
to generate a out-of-bound when drm_fb_helper_sys_write() is called.

This patch break the trigger condition of this bug by shrinking the shadow
buffer size to sizes->surface_height * buffer->fb->pitches[0].

Fixes: '8fbc9af55de0 ("drm/fbdev-generic: Set screen size to size of GEM
buffer")'

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

