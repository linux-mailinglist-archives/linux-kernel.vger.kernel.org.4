Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFD68B64F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBFHWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:22:29 -0500
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Feb 2023 23:22:28 PST
Received: from smtp-out0.aaront.org (smtp-out0.aaront.org [IPv6:2600:1f14:3bf:e504::15:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E71ABED
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 23:22:28 -0800 (PST)
Received: by smtp-out0.aaront.org (Postfix) with ESMTP id 4P9HXJ40cczMs;
        Mon,  6 Feb 2023 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=elwxqanhxhag6erl; bh=
    y7pa9vIM1shhX8XOKE3m/lGhsBFqy8v63C8PQIRZIGM=; b=OwmytaBmSoCrxLGI
    b8oAMXxhIH7QvQKaG4U4JLebDboLonVTHpvdJ6en1jIOKO+QiT4uVzGJn5ZX2VZ2
    SO4oHbcOKSCIQoRPHwW0esQyvNM1jueruaA+xlbjcYwHnuNFODy20F/LY4RRzPPK
    mq5JGpXgLgSKLhFprIT/pL+8pycJK03kyGu6XO02V0ZHsez1d6DnTNPcCUdGc9c5
    oea9XEUCXzM1GVoNJfd7e1b68eAqlmjeX4KzwN46iC1YTswqHyIEcX6O5jbIH5yu
    monSUsEZwaKAyQwJ77Q3/Ue5hnKNAt1xpXTgp0p82TvEgBNLEyf73IzNDg3+F0Yw
    yfZXLA==
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH 1/1] mm: Defer freeing reserved pages in memblock_free_late()
Date:   Mon,  6 Feb 2023 07:12:10 +0000
Message-Id: <20230206071211.3157-2-dev@aaront.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230206071211.3157-1-dev@aaront.org>
References: <20230206071211.3157-1-dev@aaront.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 115d9d77bb0f ("mm: Always release pages to the buddy allocator in
memblock_free_late().") introduced a bug. The pages being freed by
memblock_free_late() have already been initialized, but if they are in
the deferred init range, __free_one_page() might access nearby
uninitialized pages when trying to coalesce buddies. This can, for
example, trigger this BUG:

  BUG: unable to handle page fault for address: ffffe964c02580c8
  RIP: 0010:__list_del_entry_valid+0x3f/0x70
   <TASK>
   __free_one_page+0x139/0x410
   __free_pages_ok+0x21d/0x450
   memblock_free_late+0x8c/0xb9
   efi_free_boot_services+0x16b/0x25c
   efi_enter_virtual_mode+0x403/0x446
   start_kernel+0x678/0x714
   secondary_startup_64_no_verify+0xd2/0xdb
   </TASK>

Instead of freeing such pages immediately, remove the range from
memblock.reserved. This causes the deferred init process to treat it as
a range of free pages, which means they will be initialized and freed by
deferred_init_maxorder().

Fixes: 115d9d77bb0f ("mm: Always release pages to the buddy allocator in memblock_free_late().")
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 mm/internal.h                     |  2 ++
 mm/memblock.c                     | 36 ++++++++++++++++++++-----------
 mm/page_alloc.c                   | 17 +++++++++++++++
 tools/testing/memblock/internal.h |  7 +++---
 4 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..48d87f334f8c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -358,6 +358,8 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
+extern void memblock_free_reserved_pages(struct page *page, unsigned long pfn,
+					 unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order);
 extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
diff --git a/mm/memblock.c b/mm/memblock.c
index 685e30e6d27c..8f65ea3533c6 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -160,6 +160,7 @@ static bool system_has_some_mirror __initdata_memblock = false;
 static int memblock_can_resize __initdata_memblock;
 static int memblock_memory_in_slab __initdata_memblock = 0;
 static int memblock_reserved_in_slab __initdata_memblock = 0;
+static bool memblock_discard_called __initdata = false;
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
@@ -366,6 +367,8 @@ void __init memblock_discard(void)
 {
 	phys_addr_t addr, size;
 
+	memblock_discard_called = true;
+
 	if (memblock.reserved.regions != memblock_reserved_init_regions) {
 		addr = __pa(memblock.reserved.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
@@ -1620,13 +1623,16 @@ void * __init memblock_alloc_try_nid(
 }
 
 /**
- * memblock_free_late - free pages directly to buddy allocator
- * @base: phys starting address of the  boot memory block
+ * memblock_free_late - free boot memory block after memblock_free_all() has run
+ * @base: phys starting address of the boot memory block
  * @size: size of the boot memory block in bytes
  *
- * This is only useful when the memblock allocator has already been torn
- * down, but we are still initializing the system.  Pages are released directly
- * to the buddy allocator.
+ * Free boot memory block previously allocated or reserved via memblock APIs.
+ * This function is to be used after memblock_free_all() has run (prior to that,
+ * use memblock_free()/memblock_phys_free()). Pages will be released to the
+ * buddy allocator, either immediately or as part of deferred page
+ * initialization. The block will also be removed from the reserved regions if
+ * memblock_discard() has not yet run.
  */
 void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
@@ -1640,15 +1646,21 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 	end = PFN_DOWN(base + size);
 
 	for (; cursor < end; cursor++) {
-		/*
-		 * Reserved pages are always initialized by the end of
-		 * memblock_free_all() (by memmap_init() and, if deferred
-		 * initialization is enabled, memmap_init_reserved_pages()), so
-		 * these pages can be released directly to the buddy allocator.
-		 */
-		__free_pages_core(pfn_to_page(cursor), 0);
+		memblock_free_reserved_pages(pfn_to_page(cursor), cursor, 0);
 		totalram_pages_inc();
 	}
+
+	if (!memblock_discard_called)
+		/*
+		 * Also remove the range from memblock.reserved. If deferred
+		 * page init is enabled, memblock_free_reserved_pages() does not
+		 * free pages that are in the deferred range, but because the
+		 * range is no longer reserved, deferred init will initialize
+		 * and free the pages. Note that such pages will be initialized
+		 * twice, first by memmap_init_reserved_pages() and again by
+		 * deferred_init_maxorder().
+		 */
+		memblock_remove_range(&memblock.reserved, base, size);
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..4583215bfe3a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1813,6 +1813,23 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	__free_pages_core(page, order);
 }
 
+void __init memblock_free_reserved_pages(struct page *page, unsigned long pfn,
+					 unsigned int order)
+{
+	/*
+	 * All reserved pages have been initialized at this point by either
+	 * memmap_init() or memmap_init_reserved_pages(), but if the pages to
+	 * be freed are in the deferred init range (which is what
+	 * early_page_uninitialised() checks), freeing them now could result
+	 * in __free_one_page() accessing nearby uninitialized pages when it
+	 * tries to coalesce buddies. They will be freed as part of deferred
+	 * init instead.
+	 */
+	if (early_page_uninitialised(pfn))
+		return;
+	__free_pages_core(page, order);
+}
+
 /*
  * Check that the whole (or subset of) a pageblock given by the interval of
  * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 85973e55489e..524d93e71bee 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -15,12 +15,13 @@ bool mirrored_kernelcore = false;
 
 struct page {};
 
-void __free_pages_core(struct page *page, unsigned int order)
+void memblock_free_pages(struct page *page, unsigned long pfn,
+			 unsigned int order)
 {
 }
 
-void memblock_free_pages(struct page *page, unsigned long pfn,
-			 unsigned int order)
+void memblock_free_reserved_pages(struct page *page, unsigned long pfn,
+				  unsigned int order)
 {
 }
 
-- 
2.30.2

