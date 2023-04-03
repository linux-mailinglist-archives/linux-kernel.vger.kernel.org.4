Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACFE6D40E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjDCJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjDCJly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:41:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B06FF05;
        Mon,  3 Apr 2023 02:41:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D44621B4C;
        Mon,  3 Apr 2023 09:41:31 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 03E502C14F;
        Mon,  3 Apr 2023 09:41:31 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MIPS: mm: Remove local_cache_flush_page
Date:   Mon,  3 Apr 2023 11:41:12 +0200
Message-Id: <20230403094113.6056-3-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230403094113.6056-1-tsbogend@alpha.franken.de>
References: <20230403094113.6056-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After ide.h is gone, there are no users of local_cache_flush_page() left.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/include/asm/cacheflush.h | 1 -
 arch/mips/mm/c-r3k.c               | 5 -----
 arch/mips/mm/c-r4k.c               | 3 ---
 arch/mips/mm/cache.c               | 2 --
 4 files changed, 11 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index b3dc9c589442..d8d3f80f9fc0 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -110,7 +110,6 @@ extern void copy_from_user_page(struct vm_area_struct *vma,
 	unsigned long len);
 
 extern void (*flush_icache_all)(void);
-extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
 /* Run kernel code uncached, useful for cache probing functions. */
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index df6755ca1892..5869df848fab 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -261,10 +261,6 @@ static void r3k_flush_cache_page(struct vm_area_struct *vma,
 		r3k_flush_icache_range(kaddr, kaddr + PAGE_SIZE);
 }
 
-static void local_r3k_flush_data_cache_page(void *addr)
-{
-}
-
 static void r3k_flush_data_cache_page(unsigned long addr)
 {
 }
@@ -302,7 +298,6 @@ void r3k_cache_init(void)
 
 	__flush_kernel_vmap_range = r3k_flush_kernel_vmap_range;
 
-	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
 	flush_data_cache_page = r3k_flush_data_cache_page;
 
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3e0fe9eefdf6..a04047487e83 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1759,7 +1759,6 @@ void r4k_cache_init(void)
 	__flush_kernel_vmap_range = r4k_flush_kernel_vmap_range;
 
 	flush_icache_all	= r4k_flush_icache_all;
-	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
 	flush_data_cache_page	= r4k_flush_data_cache_page;
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
@@ -1802,7 +1801,6 @@ void r4k_cache_init(void)
 		/* I$ fills from D$ just by emptying the write buffers */
 		flush_cache_page = (void *)b5k_instruction_hazard;
 		flush_cache_range = (void *)b5k_instruction_hazard;
-		local_flush_data_cache_page = (void *)b5k_instruction_hazard;
 		flush_data_cache_page = (void *)b5k_instruction_hazard;
 		flush_icache_range = (void *)b5k_instruction_hazard;
 		local_flush_icache_range = (void *)b5k_instruction_hazard;
@@ -1822,7 +1820,6 @@ void r4k_cache_init(void)
 		flush_cache_range	= (void *)cache_noop;
 		flush_icache_all	= (void *)cache_noop;
 		flush_data_cache_page	= (void *)cache_noop;
-		local_flush_data_cache_page	= (void *)cache_noop;
 		break;
 	}
 }
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 11b3e7ddafd5..e9e6c0cfa7e1 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -48,11 +48,9 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
 EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
 
 /* MIPS specific cache operations */
-void (*local_flush_data_cache_page)(void * addr);
 void (*flush_data_cache_page)(unsigned long addr);
 void (*flush_icache_all)(void);
 
-EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
 EXPORT_SYMBOL(flush_icache_all);
 
-- 
2.35.3

