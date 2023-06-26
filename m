Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074773E633
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFZRQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjFZRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:15:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE95B10FD;
        Mon, 26 Jun 2023 10:15:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C721595;
        Mon, 26 Jun 2023 10:15:46 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1553F663;
        Mon, 26 Jun 2023 10:14:59 -0700 (PDT)
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
Subject: [PATCH v1 07/10] mm: Batch-zap large anonymous folio PTE mappings
Date:   Mon, 26 Jun 2023 18:14:27 +0100
Message-Id: <20230626171430.3167004-8-ryan.roberts@arm.com>
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

This allows batching the rmap removal with folio_remove_rmap_range(),
which means we avoid spuriously adding a partially unmapped folio to the
deferrred split queue in the common case, which reduces split queue lock
contention.

Previously each page was removed from the rmap individually with
page_remove_rmap(). If the first page belonged to a large folio, this
would cause page_remove_rmap() to conclude that the folio was now
partially mapped and add the folio to the deferred split queue. But
subsequent calls would cause the folio to become fully unmapped, meaning
there is no value to adding it to the split queue.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 53896d46e686..9165ed1b9fc2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -914,6 +914,57 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	return 0;
 }
 
+static inline unsigned long page_addr(struct page *page,
+				struct page *anchor, unsigned long anchor_addr)
+{
+	unsigned long offset;
+	unsigned long addr;
+
+	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
+	addr = anchor_addr + offset;
+
+	if (anchor > page) {
+		if (addr > anchor_addr)
+			return 0;
+	} else {
+		if (addr < anchor_addr)
+			return ULONG_MAX;
+	}
+
+	return addr;
+}
+
+static int calc_anon_folio_map_pgcount(struct folio *folio,
+				       struct page *page, pte_t *pte,
+				       unsigned long addr, unsigned long end)
+{
+	pte_t ptent;
+	int floops;
+	int i;
+	unsigned long pfn;
+
+	end = min(page_addr(&folio->page + folio_nr_pages(folio), page, addr),
+		  end);
+	floops = (end - addr) >> PAGE_SHIFT;
+	pfn = page_to_pfn(page);
+	pfn++;
+	pte++;
+
+	for (i = 1; i < floops; i++) {
+		ptent = ptep_get(pte);
+
+		if (!pte_present(ptent) ||
+		    pte_pfn(ptent) != pfn) {
+			return i;
+		}
+
+		pfn++;
+		pte++;
+	}
+
+	return floops;
+}
+
 /*
  * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
  * is required to copy this pte.
@@ -1379,6 +1430,44 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
 }
 
+static unsigned long zap_anon_pte_range(struct mmu_gather *tlb,
+					struct vm_area_struct *vma,
+					struct page *page, pte_t *pte,
+					unsigned long addr, unsigned long end,
+					bool *full_out)
+{
+	struct folio *folio = page_folio(page);
+	struct mm_struct *mm = tlb->mm;
+	pte_t ptent;
+	int pgcount;
+	int i;
+	bool full;
+
+	pgcount = calc_anon_folio_map_pgcount(folio, page, pte, addr, end);
+
+	for (i = 0; i < pgcount;) {
+		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		tlb_remove_tlb_entry(tlb, pte, addr);
+		full = __tlb_remove_page(tlb, page, 0);
+
+		if (unlikely(page_mapcount(page) < 1))
+			print_bad_pte(vma, addr, ptent, page);
+
+		i++;
+		page++;
+		pte++;
+		addr += PAGE_SIZE;
+
+		if (unlikely(full))
+			break;
+	}
+
+	folio_remove_rmap_range(folio, page - i, i, vma);
+
+	*full_out = full;
+	return i;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1415,6 +1504,36 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
+
+			/*
+			 * Batch zap large anonymous folio mappings. This allows
+			 * batching the rmap removal, which means we avoid
+			 * spuriously adding a partially unmapped folio to the
+			 * deferrred split queue in the common case, which
+			 * reduces split queue lock contention. Require the VMA
+			 * to be anonymous to ensure that none of the PTEs in
+			 * the range require zap_install_uffd_wp_if_needed().
+			 */
+			if (page && PageAnon(page) && vma_is_anonymous(vma)) {
+				bool full;
+				int pgcount;
+
+				pgcount = zap_anon_pte_range(tlb, vma,
+						page, pte, addr, end, &full);
+
+				rss[mm_counter(page)] -= pgcount;
+				pgcount--;
+				pte += pgcount;
+				addr += pgcount << PAGE_SHIFT;
+
+				if (unlikely(full)) {
+					force_flush = 1;
+					addr += PAGE_SIZE;
+					break;
+				}
+				continue;
+			}
+
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
-- 
2.25.1

