Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4BF666C45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbjALITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239507AbjALIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:17:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695E35912
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:17:36 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nsy6j6Y2kz16Mkg;
        Thu, 12 Jan 2023 16:15:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 16:17:33 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use folios
Date:   Thu, 12 Jan 2023 16:30:04 +0800
Message-ID: <20230112083006.163393-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old_page/new_page are converted to old_folio/new_folio in
wp_page_copy(), then replaced related page functions to folio
functions.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b66c425b4d7c..746f485366e8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3044,7 +3044,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *old_page = vmf->page;
+	struct folio *old_folio = page_folio(old_page);
 	struct page *new_page = NULL;
+	struct folio *new_folio = NULL;
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
@@ -3060,12 +3062,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 							      vmf->address);
 		if (!new_page)
 			goto oom;
+		new_folio = page_folio(new_page);
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
-				vmf->address);
-		if (!new_page)
+		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
+					    vmf->address, false);
+		if (!new_folio)
 			goto oom;
-
+		new_page = &new_folio->page;
 		ret = __wp_page_copy_user(new_page, old_page, vmf);
 		if (ret) {
 			/*
@@ -3075,9 +3078,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * from the second attempt.
 			 * The -EHWPOISON case will not be retried.
 			 */
-			put_page(new_page);
-			if (old_page)
-				put_page(old_page);
+			folio_put(new_folio);
+			if (old_folio)
+				folio_put(old_folio);
 
 			delayacct_wpcopy_end();
 			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
@@ -3085,11 +3088,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		kmsan_copy_page_meta(new_page, old_page);
 	}
 
-	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
+	if (mem_cgroup_charge(new_folio, mm, GFP_KERNEL))
 		goto oom_free_new;
-	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
+	folio_throttle_swaprate(new_folio, GFP_KERNEL);
 
-	__SetPageUptodate(new_page);
+	__folio_mark_uptodate(new_folio);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				vmf->address & PAGE_MASK,
@@ -3101,8 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
-		if (old_page) {
-			if (!PageAnon(old_page)) {
+		if (old_folio) {
+			if (!folio_test_anon(old_folio)) {
 				dec_mm_counter(mm, mm_counter_file(old_page));
 				inc_mm_counter(mm, MM_ANONPAGES);
 			}
@@ -3130,7 +3133,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address);
-		lru_cache_add_inactive_or_unevictable(new_page, vma);
+		folio_add_lru_vma(new_folio, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
@@ -3139,7 +3142,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		BUG_ON(unshare && pte_write(entry));
 		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
 		update_mmu_cache(vma, vmf->address, vmf->pte);
-		if (old_page) {
+		if (old_folio) {
 			/*
 			 * Only after switching the pte to the new page may
 			 * we remove the mapcount here. Otherwise another
@@ -3166,14 +3169,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 
 		/* Free the old page.. */
-		new_page = old_page;
+		new_folio = old_folio;
 		page_copied = 1;
 	} else {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 	}
 
-	if (new_page)
-		put_page(new_page);
+	if (new_folio)
+		folio_put(new_folio);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	/*
@@ -3181,19 +3184,19 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 * the above ptep_clear_flush_notify() did already call it.
 	 */
 	mmu_notifier_invalidate_range_only_end(&range);
-	if (old_page) {
+	if (old_folio) {
 		if (page_copied)
 			free_swap_cache(old_page);
-		put_page(old_page);
+		folio_put(old_folio);
 	}
 
 	delayacct_wpcopy_end();
 	return 0;
 oom_free_new:
-	put_page(new_page);
+	folio_put(new_folio);
 oom:
-	if (old_page)
-		put_page(old_page);
+	if (old_folio)
+		folio_put(old_folio);
 
 	delayacct_wpcopy_end();
 	return VM_FAULT_OOM;
-- 
2.35.3

