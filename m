Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56973E628
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFZRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjFZRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:15:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B03FF10EF;
        Mon, 26 Jun 2023 10:14:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864C1150C;
        Mon, 26 Jun 2023 10:15:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D3913F663;
        Mon, 26 Jun 2023 10:14:53 -0700 (PDT)
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
Subject: [PATCH v1 05/10] mm: Implement folio_remove_rmap_range()
Date:   Mon, 26 Jun 2023 18:14:25 +0100
Message-Id: <20230626171430.3167004-6-ryan.roberts@arm.com>
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

Like page_remove_rmap() but batch-removes the rmap for a range of pages
belonging to a folio, for effciency savings. All pages are accounted as
small pages.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/rmap.h |  2 ++
 mm/rmap.c            | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 15433a3d0cbf..50f50e4cb0f8 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -204,6 +204,8 @@ void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
 		struct vm_area_struct *, bool compound);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+		int nr, struct vm_area_struct *vma);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/rmap.c b/mm/rmap.c
index 4050bcea7ae7..ac1d93d43f2b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1434,6 +1434,68 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
 }
 
+/*
+ * folio_remove_rmap_range - take down pte mappings from a range of pages
+ * belonging to a folio. All pages are accounted as small pages.
+ * @folio:	folio that all pages belong to
+ * @page:       first page in range to remove mapping from
+ * @nr:		number of pages in range to remove mapping from
+ * @vma:        the vm area from which the mapping is removed
+ *
+ * The caller needs to hold the pte lock.
+ */
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+					int nr, struct vm_area_struct *vma)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int nr_unmapped = 0;
+	int nr_mapped;
+	bool last;
+	enum node_stat_item idx;
+
+	VM_BUG_ON_FOLIO(folio_test_hugetlb(folio), folio);
+
+	if (!folio_test_large(folio)) {
+		/* Is this the page's last map to be removed? */
+		last = atomic_add_negative(-1, &page->_mapcount);
+		nr_unmapped = last;
+	} else {
+		for (; nr != 0; nr--, page++) {
+			/* Is this the page's last map to be removed? */
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last) {
+				/* Page still mapped if folio mapped entirely */
+				nr_mapped = atomic_dec_return_relaxed(mapped);
+				if (nr_mapped < COMPOUND_MAPPED)
+					nr_unmapped++;
+			}
+		}
+	}
+
+	if (nr_unmapped) {
+		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
+		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
+
+		/*
+		 * Queue anon THP for deferred split if we have just unmapped at
+		 * least 1 page, while at least 1 page remains mapped.
+		 */
+		if (folio_test_large(folio) && folio_test_anon(folio))
+			if (nr_mapped)
+				deferred_split_folio(folio);
+	}
+
+	/*
+	 * It would be tidy to reset folio_test_anon mapping when fully
+	 * unmapped, but that might overwrite a racing page_add_anon_rmap
+	 * which increments mapcount after us but sets mapping before us:
+	 * so leave the reset to free_pages_prepare, and remember that
+	 * it's only reliable while mapped.
+	 */
+
+	munlock_vma_folio(folio, vma, false);
+}
+
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
-- 
2.25.1

