Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA296A8196
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCBLyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCBLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:54:09 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749A91ADFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:53:56 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PS8Cp0vWWz16P6X;
        Thu,  2 Mar 2023 19:35:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 19:37:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/7] mm: huge_memory: convert __do_huge_pmd_anonymous_page() to use a folio
Date:   Thu, 2 Mar 2023 19:58:29 +0800
Message-ID: <20230302115835.105364-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230302115835.105364-1-wangkefeng.wang@huawei.com>
References: <20230302115835.105364-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert from page to folio within __do_huge_pmd_anonymous_page(),
as we need the precise page which is to be stored at this PTE in
the folio, the function still keep a page as the parameter.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4fc43859e59a..39c19c5345ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -656,19 +656,20 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio = page_folio(page);
 	pgtable_t pgtable;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
 
-	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
-	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, gfp)) {
-		put_page(page);
+	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
+		folio_put(folio);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
 		return VM_FAULT_FALLBACK;
 	}
-	cgroup_throttle_swaprate(page, gfp);
+	folio_throttle_swaprate(folio, gfp);
 
 	pgtable = pte_alloc_one(vma->vm_mm);
 	if (unlikely(!pgtable)) {
@@ -678,11 +679,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 	clear_huge_page(page, vmf->address, HPAGE_PMD_NR);
 	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * clear_huge_page writes become visible before the set_pmd_at()
 	 * write.
 	 */
-	__SetPageUptodate(page);
+	__folio_mark_uptodate(folio);
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_none(*vmf->pmd))) {
@@ -697,7 +698,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		/* Deliver the page fault to userland */
 		if (userfaultfd_missing(vma)) {
 			spin_unlock(vmf->ptl);
-			put_page(page);
+			folio_put(folio);
 			pte_free(vma->vm_mm, pgtable);
 			ret = handle_userfault(vmf, VM_UFFD_MISSING);
 			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
@@ -706,8 +707,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr);
-		lru_cache_add_inactive_or_unevictable(page, vma);
+		folio_add_new_anon_rmap(folio, vma, haddr);
+		folio_add_lru_vma(folio, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
@@ -724,7 +725,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 release:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
-	put_page(page);
+	folio_put(folio);
 	return ret;
 
 }
-- 
2.35.3

