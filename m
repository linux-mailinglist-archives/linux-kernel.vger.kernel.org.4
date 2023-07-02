Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3107451D3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGBT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjGBT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289A1BEB;
        Sun,  2 Jul 2023 12:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9B560CEE;
        Sun,  2 Jul 2023 19:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C95BC433C8;
        Sun,  2 Jul 2023 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327577;
        bh=hKA3OasGi5qSM6+604JNLo/FIehKkyuXmgjWF7XUvj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIo1tAhAYUh3HtuJD5FpJW3T+/CxhsGsuwH8IhdvyKDPIHKAYXqBLeNTyian32eJi
         0E89qyrSuLuQ7w41odoVMZGG+LIqrADpckI06jQnbJJyihbxXkHUE2lyJ2Ry7ogtHR
         DzSUreLRvg2Tpzf2x4i8iJMV1N3woVaACTk0HPqOdQxmE7+gG76ocgbyfpellUPI/W
         RLsIUlarwHubw/dw/JgYaTH3N6MVfVoXMxGjXlxLrhZaM38za8uQg3rDUv2k0k4Ehu
         FaQIjyyoGVE26xWK6Ve5GZ5HlU1gwZ+MAsmBQXOWcWSzU6GEWGRx7fIFwhO7APBds+
         7nu2SzLTBnURw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Youngmin Nam <youngmin.nam@samsung.com>,
        SEO HOYOUNG <hy50.seo@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>, will@kernel.org,
        broonie@kernel.org, anshuman.khandual@arm.com, ardb@kernel.org,
        jpoimboe@kernel.org, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 4/5] arm64: set __exception_irq_entry with __irq_entry as a default
Date:   Sun,  2 Jul 2023 15:52:46 -0400
Message-Id: <20230702195247.1788860-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195247.1788860-1-sashal@kernel.org>
References: <20230702195247.1788860-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youngmin Nam <youngmin.nam@samsung.com>

[ Upstream commit f6794950f0e5ba37e3bbedda4d6ab0aad7395dd3 ]

filter_irq_stacks() is supposed to cut entries which are related irq entries
from its call stack.
And in_irqentry_text() which is called by filter_irq_stacks()
uses __irqentry_text_start/end symbol to find irq entries in callstack.

But it doesn't work correctly as without "CONFIG_FUNCTION_GRAPH_TRACER",
arm64 kernel doesn't include gic_handle_irq which is entry point of arm64 irq
between __irqentry_text_start and __irqentry_text_end as we discussed in below link.
https://lore.kernel.org/all/CACT4Y+aReMGLYua2rCLHgFpS9io5cZC04Q8GLs-uNmrn1ezxYQ@mail.gmail.com/#t

This problem can makes unintentional deep call stack entries especially
in KASAN enabled situation as below.

[ 2479.383395]I[0:launcher-loader: 1719] Stack depot reached limit capacity
[ 2479.383538]I[0:launcher-loader: 1719] WARNING: CPU: 0 PID: 1719 at lib/stackdepot.c:129 __stack_depot_save+0x464/0x46c
[ 2479.385693]I[0:launcher-loader: 1719] pstate: 624000c5 (nZCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[ 2479.385724]I[0:launcher-loader: 1719] pc : __stack_depot_save+0x464/0x46c
[ 2479.385751]I[0:launcher-loader: 1719] lr : __stack_depot_save+0x460/0x46c
[ 2479.385774]I[0:launcher-loader: 1719] sp : ffffffc0080073c0
[ 2479.385793]I[0:launcher-loader: 1719] x29: ffffffc0080073e0 x28: ffffffd00b78a000 x27: 0000000000000000
[ 2479.385839]I[0:launcher-loader: 1719] x26: 000000000004d1dd x25: ffffff891474f000 x24: 00000000ca64d1dd
[ 2479.385882]I[0:launcher-loader: 1719] x23: 0000000000000200 x22: 0000000000000220 x21: 0000000000000040
[ 2479.385925]I[0:launcher-loader: 1719] x20: ffffffc008007440 x19: 0000000000000000 x18: 0000000000000000
[ 2479.385969]I[0:launcher-loader: 1719] x17: 2065726568207475 x16: 000000000000005e x15: 2d2d2d2d2d2d2d20
[ 2479.386013]I[0:launcher-loader: 1719] x14: 5d39313731203a72 x13: 00000000002f6b30 x12: 00000000002f6af8
[ 2479.386057]I[0:launcher-loader: 1719] x11: 00000000ffffffff x10: ffffffb90aacf000 x9 : e8a74a6c16008800
[ 2479.386101]I[0:launcher-loader: 1719] x8 : e8a74a6c16008800 x7 : 00000000002f6b30 x6 : 00000000002f6af8
[ 2479.386145]I[0:launcher-loader: 1719] x5 : ffffffc0080070c8 x4 : ffffffd00b192380 x3 : ffffffd0092b313c
[ 2479.386189]I[0:launcher-loader: 1719] x2 : 0000000000000001 x1 : 0000000000000004 x0 : 0000000000000022
[ 2479.386231]I[0:launcher-loader: 1719] Call trace:
[ 2479.386248]I[0:launcher-loader: 1719]  __stack_depot_save+0x464/0x46c
[ 2479.386273]I[0:launcher-loader: 1719]  kasan_save_stack+0x58/0x70
[ 2479.386303]I[0:launcher-loader: 1719]  save_stack_info+0x34/0x138
[ 2479.386331]I[0:launcher-loader: 1719]  kasan_save_free_info+0x18/0x24
[ 2479.386358]I[0:launcher-loader: 1719]  ____kasan_slab_free+0x16c/0x170
[ 2479.386385]I[0:launcher-loader: 1719]  __kasan_slab_free+0x10/0x20
[ 2479.386410]I[0:launcher-loader: 1719]  kmem_cache_free+0x238/0x53c
[ 2479.386435]I[0:launcher-loader: 1719]  mempool_free_slab+0x1c/0x28
[ 2479.386460]I[0:launcher-loader: 1719]  mempool_free+0x7c/0x1a0
[ 2479.386484]I[0:launcher-loader: 1719]  bvec_free+0x34/0x80
[ 2479.386514]I[0:launcher-loader: 1719]  bio_free+0x60/0x98
[ 2479.386540]I[0:launcher-loader: 1719]  bio_put+0x50/0x21c
[ 2479.386567]I[0:launcher-loader: 1719]  f2fs_write_end_io+0x4ac/0x4d0
[ 2479.386594]I[0:launcher-loader: 1719]  bio_endio+0x2dc/0x300
[ 2479.386622]I[0:launcher-loader: 1719]  __dm_io_complete+0x324/0x37c
[ 2479.386650]I[0:launcher-loader: 1719]  dm_io_dec_pending+0x60/0xa4
[ 2479.386676]I[0:launcher-loader: 1719]  clone_endio+0xf8/0x2f0
[ 2479.386700]I[0:launcher-loader: 1719]  bio_endio+0x2dc/0x300
[ 2479.386727]I[0:launcher-loader: 1719]  blk_update_request+0x258/0x63c
[ 2479.386754]I[0:launcher-loader: 1719]  scsi_end_request+0x50/0x304
[ 2479.386782]I[0:launcher-loader: 1719]  scsi_io_completion+0x88/0x160
[ 2479.386808]I[0:launcher-loader: 1719]  scsi_finish_command+0x17c/0x194
[ 2479.386833]I[0:launcher-loader: 1719]  scsi_complete+0xcc/0x158
[ 2479.386859]I[0:launcher-loader: 1719]  blk_mq_complete_request+0x4c/0x5c
[ 2479.386885]I[0:launcher-loader: 1719]  scsi_done_internal+0xf4/0x1e0
[ 2479.386910]I[0:launcher-loader: 1719]  scsi_done+0x14/0x20
[ 2479.386935]I[0:launcher-loader: 1719]  ufshcd_compl_one_cqe+0x578/0x71c
[ 2479.386963]I[0:launcher-loader: 1719]  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
[ 2479.386991]I[0:launcher-loader: 1719]  ufshcd_intr+0x868/0xc0c
[ 2479.387017]I[0:launcher-loader: 1719]  __handle_irq_event_percpu+0xd0/0x348
[ 2479.387044]I[0:launcher-loader: 1719]  handle_irq_event_percpu+0x24/0x74
[ 2479.387068]I[0:launcher-loader: 1719]  handle_irq_event+0x74/0xe0
[ 2479.387091]I[0:launcher-loader: 1719]  handle_fasteoi_irq+0x174/0x240
[ 2479.387118]I[0:launcher-loader: 1719]  handle_irq_desc+0x7c/0x2c0
[ 2479.387147]I[0:launcher-loader: 1719]  generic_handle_domain_irq+0x1c/0x28
[ 2479.387174]I[0:launcher-loader: 1719]  gic_handle_irq+0x64/0x158
[ 2479.387204]I[0:launcher-loader: 1719]  call_on_irq_stack+0x2c/0x54
[ 2479.387231]I[0:launcher-loader: 1719]  do_interrupt_handler+0x70/0xa0
[ 2479.387258]I[0:launcher-loader: 1719]  el1_interrupt+0x34/0x68
[ 2479.387283]I[0:launcher-loader: 1719]  el1h_64_irq_handler+0x18/0x24
[ 2479.387308]I[0:launcher-loader: 1719]  el1h_64_irq+0x68/0x6c
[ 2479.387332]I[0:launcher-loader: 1719]  blk_attempt_bio_merge+0x8/0x170
[ 2479.387356]I[0:launcher-loader: 1719]  blk_mq_attempt_bio_merge+0x78/0x98
[ 2479.387383]I[0:launcher-loader: 1719]  blk_mq_submit_bio+0x324/0xa40
[ 2479.387409]I[0:launcher-loader: 1719]  __submit_bio+0x104/0x138
[ 2479.387436]I[0:launcher-loader: 1719]  submit_bio_noacct_nocheck+0x1d0/0x4a0
[ 2479.387462]I[0:launcher-loader: 1719]  submit_bio_noacct+0x618/0x804
[ 2479.387487]I[0:launcher-loader: 1719]  submit_bio+0x164/0x180
[ 2479.387511]I[0:launcher-loader: 1719]  f2fs_submit_read_bio+0xe4/0x1c4
[ 2479.387537]I[0:launcher-loader: 1719]  f2fs_mpage_readpages+0x888/0xa4c
[ 2479.387563]I[0:launcher-loader: 1719]  f2fs_readahead+0xd4/0x19c
[ 2479.387587]I[0:launcher-loader: 1719]  read_pages+0xb0/0x4ac
[ 2479.387614]I[0:launcher-loader: 1719]  page_cache_ra_unbounded+0x238/0x288
[ 2479.387642]I[0:launcher-loader: 1719]  do_page_cache_ra+0x60/0x6c
[ 2479.387669]I[0:launcher-loader: 1719]  page_cache_ra_order+0x318/0x364
[ 2479.387695]I[0:launcher-loader: 1719]  ondemand_readahead+0x30c/0x3d8
[ 2479.387722]I[0:launcher-loader: 1719]  page_cache_sync_ra+0xb4/0xc8
[ 2479.387749]I[0:launcher-loader: 1719]  filemap_read+0x268/0xd24
[ 2479.387777]I[0:launcher-loader: 1719]  f2fs_file_read_iter+0x1a0/0x62c
[ 2479.387806]I[0:launcher-loader: 1719]  vfs_read+0x258/0x34c
[ 2479.387831]I[0:launcher-loader: 1719]  ksys_pread64+0x8c/0xd0
[ 2479.387857]I[0:launcher-loader: 1719]  __arm64_sys_pread64+0x48/0x54
[ 2479.387881]I[0:launcher-loader: 1719]  invoke_syscall+0x58/0x158
[ 2479.387909]I[0:launcher-loader: 1719]  el0_svc_common+0xf0/0x134
[ 2479.387935]I[0:launcher-loader: 1719]  do_el0_svc+0x44/0x114
[ 2479.387961]I[0:launcher-loader: 1719]  el0_svc+0x2c/0x80
[ 2479.387985]I[0:launcher-loader: 1719]  el0t_64_sync_handler+0x48/0x114
[ 2479.388010]I[0:launcher-loader: 1719]  el0t_64_sync+0x190/0x194
[ 2479.388038]I[0:launcher-loader: 1719] Kernel panic - not syncing: kernel: panic_on_warn set ...

So let's set __exception_irq_entry with __irq_entry as a default.
Applying this patch, we can see gic_hande_irq is included in Systemp.map as below.

* Before
ffffffc008010000 T __do_softirq
ffffffc008010000 T __irqentry_text_end
ffffffc008010000 T __irqentry_text_start
ffffffc008010000 T __softirqentry_text_start
ffffffc008010000 T _stext
ffffffc00801066c T __softirqentry_text_end
ffffffc008010670 T __entry_text_start

* After
ffffffc008010000 T __irqentry_text_start
ffffffc008010000 T _stext
ffffffc008010000 t gic_handle_irq
ffffffc00801013c t gic_handle_irq
ffffffc008010294 T __irqentry_text_end
ffffffc008010298 T __do_softirq
ffffffc008010298 T __softirqentry_text_start
ffffffc008010904 T __softirqentry_text_end
ffffffc008010908 T __entry_text_start

Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230424010436.779733-1-youngmin.nam@samsung.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/exception.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 0756191f44f64..59c3facb8a560 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -8,16 +8,11 @@
 #define __ASM_EXCEPTION_H
 
 #include <asm/esr.h>
-#include <asm/kprobes.h>
 #include <asm/ptrace.h>
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry	__kprobes
-#endif
 
 static inline u32 disr_to_esr(u64 disr)
 {
-- 
2.39.2

