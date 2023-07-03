Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D6745DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGCNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGCNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:53:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0716010C8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:53:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71661C14;
        Mon,  3 Jul 2023 06:54:27 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDAF83F73F;
        Mon,  3 Jul 2023 06:53:42 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 1/5] mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
Date:   Mon,  3 Jul 2023 14:53:26 +0100
Message-Id: <20230703135330.1865927-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703135330.1865927-1-ryan.roberts@arm.com>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
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

In preparation for FLEXIBLE_THP support, improve
folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
passed to it. In this case, all contained pages are accounted using the
"small" pages scheme.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/rmap.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1d8369549424..82ef5ba363d1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1278,31 +1278,43 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
  * This means the inc-and-test can be bypassed.
  * The folio does not have to be locked.
  *
- * If the folio is large, it is accounted as a THP.  As the folio
+ * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
  * is new, it's assumed to be mapped exclusively by a single process.
  */
 void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address)
 {
-	int nr;
+	int nr = folio_nr_pages(folio);
+	int i;
+	struct page *page;
 
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
+	VM_BUG_ON_VMA(address < vma->vm_start ||
+			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 	__folio_set_swapbacked(folio);
 
-	if (likely(!folio_test_pmd_mappable(folio))) {
+	if (!folio_test_large(folio)) {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_mapcount, 0);
-		nr = 1;
+		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
+	} else if (!folio_test_pmd_mappable(folio)) {
+		/* increment count (starts at 0) */
+		atomic_set(&folio->_nr_pages_mapped, nr);
+
+		page = &folio->page;
+		for (i = 0; i < nr; i++, page++, address += PAGE_SIZE) {
+			/* increment count (starts at -1) */
+			atomic_set(&page->_mapcount, 0);
+			__page_set_anon_rmap(folio, page, vma, address, 1);
+		}
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
-		nr = folio_nr_pages(folio);
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
+		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
 	}
 
 	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
-	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
 }
 
 /**
-- 
2.25.1

