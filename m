Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8855C61349C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJaLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJaLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:38:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C56DFD4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:38:31 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1B025lVczpW9B;
        Mon, 31 Oct 2022 19:34:58 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 19:38:29 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <adaplas@gmail.com>, <akpm@linux-foundation.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/fonts: fix undefined behavior in bit shift for get_default_font
Date:   Mon, 31 Oct 2022 19:38:29 +0800
Message-ID: <20221031113829.4183153-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined, so changing
significant bit to unsigned. The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in lib/fonts/fonts.c:139:20
left shift of 1 by 31 places cannot be represented in type 'int'
 <TASK>
 dump_stack_lvl+0x7d/0xa5
 dump_stack+0x15/0x1b
 ubsan_epilogue+0xe/0x4e
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
 get_default_font+0x1c7/0x1f0
 fbcon_startup+0x347/0x3a0
 do_take_over_console+0xce/0x270
 do_fbcon_takeover+0xa1/0x170
 do_fb_registered+0x2a8/0x340
 fbcon_fb_registered+0x47/0xe0
 register_framebuffer+0x294/0x4a0
 __drm_fb_helper_initial_config_and_unlock+0x43c/0x880 [drm_kms_helper]
 drm_fb_helper_initial_config+0x52/0x80 [drm_kms_helper]
 drm_fbdev_client_hotplug+0x156/0x1b0 [drm_kms_helper]
 drm_fbdev_generic_setup+0xfc/0x290 [drm_kms_helper]
 bochs_pci_probe+0x6ca/0x772 [bochs]
 local_pci_probe+0x4d/0xb0
 pci_device_probe+0x119/0x320
 really_probe+0x181/0x550
 __driver_probe_device+0xc6/0x220
 driver_probe_device+0x32/0x100
 __driver_attach+0x195/0x200
 bus_for_each_dev+0xbb/0x120
 driver_attach+0x27/0x30
 bus_add_driver+0x22e/0x2f0
 driver_register+0xa9/0x190
 __pci_register_driver+0x90/0xa0
 bochs_pci_driver_init+0x52/0x1000 [bochs]
 do_one_initcall+0x76/0x430
 do_init_module+0x61/0x28a
 load_module+0x1f82/0x2e50
 __do_sys_finit_module+0xf8/0x190
 __x64_sys_finit_module+0x23/0x30
 do_syscall_64+0x58/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Fixes: c81f717cb9e0 ("fbcon: Fix typo and bogus logic in get_default_font")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 lib/fonts/fonts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 5f4b07b56cd9..973866438608 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -135,8 +135,8 @@ const struct font_desc *get_default_font(int xres, int yres, u32 font_w,
 		if (res > 20)
 			c += 20 - res;
 
-		if ((font_w & (1 << (f->width - 1))) &&
-		    (font_h & (1 << (f->height - 1))))
+		if ((font_w & (1U << (f->width - 1))) &&
+		    (font_h & (1U << (f->height - 1))))
 			c += 1000;
 
 		if (c > cc) {
-- 
2.25.1

