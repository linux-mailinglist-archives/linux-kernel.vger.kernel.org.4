Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE806D40DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjDCJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjDCJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:41:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9C746A9;
        Mon,  3 Apr 2023 02:41:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6A9A51FD9B;
        Mon,  3 Apr 2023 09:41:25 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 50C1F2C15D;
        Mon,  3 Apr 2023 09:41:25 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: mm: Remove unused *cache_page_indexed flush functions
Date:   Mon,  3 Apr 2023 11:41:10 +0200
Message-Id: <20230403094113.6056-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
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

The *cache_page_indexed flush functions are no (longer) used.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/mm/c-r4k.c | 100 -------------------------------------------
 1 file changed, 100 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 7d447050a20b..3e0fe9eefdf6 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -201,24 +201,6 @@ static void r4k_blast_dcache_user_page_setup(void)
 
 #endif
 
-static void (* r4k_blast_dcache_page_indexed)(unsigned long addr);
-
-static void r4k_blast_dcache_page_indexed_setup(void)
-{
-	unsigned long dc_lsize = cpu_dcache_line_size();
-
-	if (dc_lsize == 0)
-		r4k_blast_dcache_page_indexed = (void *)cache_noop;
-	else if (dc_lsize == 16)
-		r4k_blast_dcache_page_indexed = blast_dcache16_page_indexed;
-	else if (dc_lsize == 32)
-		r4k_blast_dcache_page_indexed = blast_dcache32_page_indexed;
-	else if (dc_lsize == 64)
-		r4k_blast_dcache_page_indexed = blast_dcache64_page_indexed;
-	else if (dc_lsize == 128)
-		r4k_blast_dcache_page_indexed = blast_dcache128_page_indexed;
-}
-
 void (* r4k_blast_dcache)(void);
 EXPORT_SYMBOL(r4k_blast_dcache);
 
@@ -280,39 +262,6 @@ static inline void tx49_blast_icache32(void)
 				     addr | ws, 32);
 }
 
-static inline void blast_icache32_r4600_v1_page_indexed(unsigned long page)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	blast_icache32_page_indexed(page);
-	local_irq_restore(flags);
-}
-
-static inline void tx49_blast_icache32_page_indexed(unsigned long page)
-{
-	unsigned long indexmask = current_cpu_data.icache.waysize - 1;
-	unsigned long start = INDEX_BASE + (page & indexmask);
-	unsigned long end = start + PAGE_SIZE;
-	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
-	unsigned long ws_end = current_cpu_data.icache.ways <<
-			       current_cpu_data.icache.waybit;
-	unsigned long ws, addr;
-
-	CACHE32_UNROLL32_ALIGN2;
-	/* I'm in even chunk.  blast odd chunks */
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start + 0x400; addr < end; addr += 0x400 * 2)
-			cache_unroll(32, kernel_cache, Index_Invalidate_I,
-				     addr | ws, 32);
-	CACHE32_UNROLL32_ALIGN;
-	/* I'm in odd chunk.  blast even chunks */
-	for (ws = 0; ws < ws_end; ws += ws_inc)
-		for (addr = start; addr < end; addr += 0x400 * 2)
-			cache_unroll(32, kernel_cache, Index_Invalidate_I,
-				     addr | ws, 32);
-}
-
 static void (* r4k_blast_icache_page)(unsigned long addr);
 
 static void r4k_blast_icache_page_setup(void)
@@ -355,34 +304,6 @@ static void r4k_blast_icache_user_page_setup(void)
 
 #endif
 
-static void (* r4k_blast_icache_page_indexed)(unsigned long addr);
-
-static void r4k_blast_icache_page_indexed_setup(void)
-{
-	unsigned long ic_lsize = cpu_icache_line_size();
-
-	if (ic_lsize == 0)
-		r4k_blast_icache_page_indexed = (void *)cache_noop;
-	else if (ic_lsize == 16)
-		r4k_blast_icache_page_indexed = blast_icache16_page_indexed;
-	else if (ic_lsize == 32) {
-		if (IS_ENABLED(CONFIG_WAR_R4600_V1_INDEX_ICACHEOP) &&
-		    cpu_is_r4600_v1_x())
-			r4k_blast_icache_page_indexed =
-				blast_icache32_r4600_v1_page_indexed;
-		else if (IS_ENABLED(CONFIG_WAR_TX49XX_ICACHE_INDEX_INV))
-			r4k_blast_icache_page_indexed =
-				tx49_blast_icache32_page_indexed;
-		else if (current_cpu_type() == CPU_LOONGSON2EF)
-			r4k_blast_icache_page_indexed =
-				loongson2_blast_icache32_page_indexed;
-		else
-			r4k_blast_icache_page_indexed =
-				blast_icache32_page_indexed;
-	} else if (ic_lsize == 64)
-		r4k_blast_icache_page_indexed = blast_icache64_page_indexed;
-}
-
 void (* r4k_blast_icache)(void);
 EXPORT_SYMBOL(r4k_blast_icache);
 
@@ -428,24 +349,6 @@ static void r4k_blast_scache_page_setup(void)
 		r4k_blast_scache_page = blast_scache128_page;
 }
 
-static void (* r4k_blast_scache_page_indexed)(unsigned long addr);
-
-static void r4k_blast_scache_page_indexed_setup(void)
-{
-	unsigned long sc_lsize = cpu_scache_line_size();
-
-	if (scache_size == 0)
-		r4k_blast_scache_page_indexed = (void *)cache_noop;
-	else if (sc_lsize == 16)
-		r4k_blast_scache_page_indexed = blast_scache16_page_indexed;
-	else if (sc_lsize == 32)
-		r4k_blast_scache_page_indexed = blast_scache32_page_indexed;
-	else if (sc_lsize == 64)
-		r4k_blast_scache_page_indexed = blast_scache64_page_indexed;
-	else if (sc_lsize == 128)
-		r4k_blast_scache_page_indexed = blast_scache128_page_indexed;
-}
-
 static void (* r4k_blast_scache)(void);
 
 static void r4k_blast_scache_setup(void)
@@ -1821,13 +1724,10 @@ void r4k_cache_init(void)
 	setup_scache();
 
 	r4k_blast_dcache_page_setup();
-	r4k_blast_dcache_page_indexed_setup();
 	r4k_blast_dcache_setup();
 	r4k_blast_icache_page_setup();
-	r4k_blast_icache_page_indexed_setup();
 	r4k_blast_icache_setup();
 	r4k_blast_scache_page_setup();
-	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
 	r4k_blast_scache_node_setup();
 #ifdef CONFIG_EVA
-- 
2.35.3

