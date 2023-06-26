Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D197973E627
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFZRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFZROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:14:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8962B1729;
        Mon, 26 Jun 2023 10:14:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD8D143D;
        Mon, 26 Jun 2023 10:15:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577523F663;
        Mon, 26 Jun 2023 10:14:44 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: [PATCH v1 02/10] mm: pass gfp flags and order to vma_alloc_zeroed_movable_folio()
Date:   Mon, 26 Jun 2023 18:14:22 +0100
Message-Id: <20230626171430.3167004-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626171430.3167004-1-ryan.roberts@arm.com>
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow allocation of large folios with vma_alloc_zeroed_movable_folio().
This prepares the ground for large anonymous folios. The generic
implementation of vma_alloc_zeroed_movable_folio() now uses
clear_huge_page() to zero the allocated folio since it may now be a
non-0 order.

Currently the function is always called with order 0 and no extra gfp
flags, so no functional change intended. But a subsequent commit will
take advantage of the new parameters to allocate large folios. The extra
gfp flags will be used to control the reclaim policy.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/alpha/include/asm/page.h   |  5 +++--
 arch/arm64/include/asm/page.h   |  3 ++-
 arch/arm64/mm/fault.c           |  7 ++++---
 arch/ia64/include/asm/page.h    |  5 +++--
 arch/m68k/include/asm/page_no.h |  7 ++++---
 arch/s390/include/asm/page.h    |  5 +++--
 arch/x86/include/asm/page.h     |  5 +++--
 include/linux/highmem.h         | 23 +++++++++++++----------
 mm/memory.c                     |  5 +++--
 9 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 4db1ebc0ed99..6fc7fe91b6cb 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -17,8 +17,9 @@
 extern void clear_page(void *page);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
+#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp), \
+			order, vma, vaddr, false)
 
 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 2312e6ee595f..47710852f872 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -30,7 +30,8 @@ void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-						unsigned long vaddr);
+						unsigned long vaddr,
+						gfp_t gfp, int order);
 #define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
 
 void tag_clear_highpage(struct page *to);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6045a5117ac1..0a43c3b3f190 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -961,9 +961,10 @@ NOKPROBE_SYMBOL(do_debug_exception);
  * Used during anonymous page fault handling.
  */
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-						unsigned long vaddr)
+						unsigned long vaddr,
+						gfp_t gfp, int order)
 {
-	gfp_t flags = GFP_HIGHUSER_MOVABLE | __GFP_ZERO;
+	gfp_t flags = GFP_HIGHUSER_MOVABLE | __GFP_ZERO | gfp;
 
 	/*
 	 * If the page is mapped with PROT_MTE, initialise the tags at the
@@ -973,7 +974,7 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_MTE)
 		flags |= __GFP_ZEROTAGS;
 
-	return vma_alloc_folio(flags, 0, vma, vaddr, false);
+	return vma_alloc_folio(flags, order, vma, vaddr, false);
 }
 
 void tag_clear_highpage(struct page *page)
diff --git a/arch/ia64/include/asm/page.h b/arch/ia64/include/asm/page.h
index 310b09c3342d..ebdf04274023 100644
--- a/arch/ia64/include/asm/page.h
+++ b/arch/ia64/include/asm/page.h
@@ -82,10 +82,11 @@ do {						\
 } while (0)
 
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr)			\
+#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order)		\
 ({									\
 	struct folio *folio = vma_alloc_folio(				\
-		GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false); \
+		GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp),		\
+		order, vma, vaddr, false);				\
 	if (folio)							\
 		flush_dcache_folio(folio);				\
 	folio;								\
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index 060e4c0e7605..4a2fe57fef5e 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -3,7 +3,7 @@
 #define _M68K_PAGE_NO_H
 
 #ifndef __ASSEMBLY__
- 
+
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
@@ -13,8 +13,9 @@ extern unsigned long memory_end;
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
+#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp), \
+			order, vma, vaddr, false)
 
 #define __pa(vaddr)		((unsigned long)(vaddr))
 #define __va(paddr)		((void *)((unsigned long)(paddr)))
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 8a2a3b5d1e29..b749564140f1 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -73,8 +73,9 @@ static inline void copy_page(void *to, void *from)
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
+#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp), \
+			order, vma, vaddr, false)
 
 /*
  * These are used to make use of C type-checking..
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9..34deab1a8dae 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -34,8 +34,9 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 	copy_page(to, from);
 }
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
+#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp), \
+			order, vma, vaddr, false)
 
 #ifndef __pa
 #define __pa(x)		__phys_addr((unsigned long)(x))
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 4de1dbcd3ef6..b9a9b0340557 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -209,26 +209,29 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 
 #ifndef vma_alloc_zeroed_movable_folio
 /**
- * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
- * @vma: The VMA the page is to be allocated for.
- * @vaddr: The virtual address the page will be inserted into.
- *
- * This function will allocate a page suitable for inserting into this
- * VMA at this virtual address.  It may be allocated from highmem or
+ * vma_alloc_zeroed_movable_folio - Allocate a zeroed folio for a VMA.
+ * @vma: The start VMA the folio is to be allocated for.
+ * @vaddr: The virtual address the folio will be inserted into.
+ * @gfp: Additional gfp falgs to mix in or 0.
+ * @order: The order of the folio (2^order pages).
+ *
+ * This function will allocate a folio suitable for inserting into this
+ * VMA starting at this virtual address.  It may be allocated from highmem or
  * the movable zone.  An architecture may provide its own implementation.
  *
- * Return: A folio containing one allocated and zeroed page or NULL if
+ * Return: A folio containing 2^order allocated and zeroed pages or NULL if
  * we are out of memory.
  */
 static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-				   unsigned long vaddr)
+				   unsigned long vaddr, gfp_t gfp, int order)
 {
 	struct folio *folio;
 
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE | gfp,
+					order, vma, vaddr, false);
 	if (folio)
-		clear_user_highpage(&folio->page, vaddr);
+		clear_huge_page(&folio->page, vaddr, 1U << order);
 
 	return folio;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 3d4ea668c4d1..367bbbb29d91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3073,7 +3073,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		goto oom;
 
 	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
-		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
+		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address,
+									0, 0);
 		if (!new_folio)
 			goto oom;
 	} else {
@@ -4087,7 +4088,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
+	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address, 0, 0);
 	if (!folio)
 		goto oom;
 
-- 
2.25.1

