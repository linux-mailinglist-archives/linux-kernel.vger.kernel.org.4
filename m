Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7275BF811
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiIUHqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiIUHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E278F844EB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DA50B82E4C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89637C4314C;
        Wed, 21 Sep 2022 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663746340;
        bh=n31Y6AdG0xE7ERoY/0e7YImYspgu/75p57sOk3lpH2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lsluR1G7qGjU8qVoSNCb3aFgddPjgLYVMYCrrcy3Kph3fLK+9uHvD6CQg6io4wk5A
         NYmPRN+Kdcc40UjyZSn0OB/C2jcGtw24VDE2HSyASjB7LIGOcyqIKrZ5UcWOk4OCqt
         wG8RCBFoIkkmC80dj90ZTJ0NjOWvIee2+G9KjT6DRdpaoJn5z3z+Uwr63wt0O4kMQG
         JFT7Lo5bEgZ6BM8u1pXBHpgeu9a00QL+CyqYJU3zfycydKT+p9WMbiDeqqWfz0UgnU
         pdUTEMcR8SOWoFudIM5FG7WlqoS1A2K5YCblixJXENX7TImtPxfSqIkYWWjjXTphd9
         rFY9uFH/EIRng==
Date:   Wed, 21 Sep 2022 10:45:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YyrBFvD2ID8sqhEK@kernel.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
 <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
 <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:05:57PM +0200, Ard Biesheuvel wrote:
> 
> While I appreciate the effort that has gone into solving this problem,
> I don't think there is any consensus that an elaborate fix is required
> to ensure that the crash kernel can be unmapped from the linear map at
> all cost. In fact, I personally think we shouldn't bother, and IIRC,
> Will made a remark along the same lines back when the Huawei engineers
> were still driving this effort.
> 
> So perhaps we could align on that before doing yet another version of this?

I suggest to start with disabling crash kernel protection when its memory
reservation is deferred and then Baoquan and kdump folks can take it from
here.

From 6430407f784f3571da9b4d79340487f2647a44ab Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 21 Sep 2022 10:14:46 +0300
Subject: [PATCH] arm64/mm: don't protect crash kernel memory with
 CONFIG_ZONE_DMA/DMA32

Currently, in order to allow protection of crash kernel memory when
CONFIG_ZONE_DMA/DMA32 is enabled, the block mappings in the linear map are
disabled and the entire linear map uses base size pages.

This results in performance degradation because of higher TLB pressure for
kernel memory accesses, so there is a trade off between performance and
ability to protect the crash kernel memory.

Baoquan He said [1]:

	In fact, panic is a small probability event, and accidental
	corruption on kdump kernel data is a much smaller probability
	event.

With this, it makes sense to only protect crash kernel memory only when it
can be reserved before creation of the linear map.

Simplify the logic around crash kernel protection in map_mem() so that it
will use base pages only if crash kernel memory is already reserved and
introduce crashkres_protection_possible variable to ensure that
arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres() won't
try to modify page table if crash kernel is not mapped with base pages.

[1] https://lore.kernel.org/all/Yw2C9ahluhX4Mg3G@MiWiFi-R3L-srv

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/mmu.h      |  1 +
 arch/arm64/kernel/machine_kexec.c |  6 ++++
 arch/arm64/mm/init.c              | 30 +++++++++-----------
 arch/arm64/mm/mmu.c               | 46 ++++++++-----------------------
 4 files changed, 32 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 48f8466a4be9..975607843548 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
+extern bool crashkres_protection_possible;
 
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 19c2d487cb08..68295403aa40 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -272,6 +272,9 @@ void arch_kexec_protect_crashkres(void)
 {
 	int i;
 
+	if (!crashkres_protection_possible)
+		return;
+
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
@@ -282,6 +285,9 @@ void arch_kexec_unprotect_crashkres(void)
 {
 	int i;
 
+	if (!crashkres_protection_possible)
+		return;
+
 	for (i = 0; i < kexec_crash_image->nr_segments; i++)
 		set_memory_valid(
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b9af30be813e..220d45655918 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,27 +62,21 @@ EXPORT_SYMBOL(memstart_addr);
  * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
  * otherwise it is empty.
  *
- * Memory reservation for crash kernel either done early or deferred
- * depending on DMA memory zones configs (ZONE_DMA) --
+ * Memory reservation for crash kernel must know the upper limit of low
+ * memory in order to allow DMA access for devices with kdump kernel. When
+ * ZONE_DMA/DMA32 is enabled, this limit is determined after DT/ACPI is
+ * parsed, and crash kernel reservation happens afterwards. In this case,
+ * the crash kernel memory is reserved after linear map is created, there
+ * is no guarantee that crash kernel memory will be mapped with the base
+ * pages in the linear map, and thus the protection if the crash kernel
+ * memory is disabled.
  *
  * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
  * here instead of max_zone_phys().  This lets early reservation of
  * crash kernel memory which has a dependency on arm64_dma_phys_limit.
- * Reserving memory early for crash kernel allows linear creation of block
- * mappings (greater than page-granularity) for all the memory bank rangs.
- * In this scheme a comparatively quicker boot is observed.
- *
- * If ZONE_DMA configs are defined, crash kernel memory reservation
- * is delayed until DMA zone memory range size initialization performed in
- * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
- * memory range to avoid overlap allocation.  So crash kernel memory boundaries
- * are not known when mapping all bank memory ranges, which otherwise means
- * not possible to exclude crash kernel range from creating block mappings
- * so page-granularity mappings are created for the entire memory range.
- * Hence a slightly slower boot is observed.
- *
- * Note: Page-granularity mappings are necessary for crash kernel memory
- * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
+ * Reserving crash kernel memory early allows mapping it with base pages in
+ * the linear map so that it can be protected, without preventing usage of
+ * block mappings for creation of the linear map.
  */
 #if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
@@ -90,6 +84,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+bool __ro_after_init crashkres_protection_possible;
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c5065abec55a..7b40f38dd3ee 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -502,21 +502,6 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
-
-static int __init enable_crash_mem_map(char *arg)
-{
-	/*
-	 * Proper parameter parsing is done by reserve_crashkernel(). We only
-	 * need to know if the linear map has to avoid block mappings so that
-	 * the crashkernel reservations can be unmapped later.
-	 */
-	crash_mem_map = true;
-
-	return 0;
-}
-early_param("crashkernel", enable_crash_mem_map);
-
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -547,13 +532,9 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map) {
-		if (defer_reserve_crashkernel())
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
-	}
+	if (crashk_res.end)
+		memblock_mark_nomap(crashk_res.start,
+				    resource_size(&crashk_res));
 #endif
 
 	/* map all the memory banks */
@@ -584,20 +565,17 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
 	/*
-	 * Use page-level mappings here so that we can shrink the region
-	 * in page granularity and put back unused memory to buddy system
-	 * through /sys/kernel/kexec_crash_size interface.
+	 * Use page-level mappings here so that we can protect crash kernel
+	 * memory to allow post-mortem analysis despite memory errors in
+	 * the main kernel.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !defer_reserve_crashkernel()) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
+	if (crashk_res.end) {
+		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
+			       PAGE_KERNEL, NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
+		crashkres_protection_possible = true;
 	}
 #endif
 }
-- 
2.35.3


-- 
Sincerely yours,
Mike.
