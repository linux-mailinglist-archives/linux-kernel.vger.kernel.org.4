Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663EA64B46C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiLMLsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiLMLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:48:48 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F75FADE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:48:45 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NWcDz0cZyz15NKj;
        Tue, 13 Dec 2022 19:47:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 19:48:43 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>
CC:     <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next resend v3] mm: hwposion: support recovery from ksm_might_need_to_copy()
Date:   Tue, 13 Dec 2022 20:05:23 +0800
Message-ID: <20221213120523.141588-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
References: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel copy a page from ksm_might_need_to_copy(), but runs
into an uncorrectable error, it will crash since poisoned page is
consumed by kernel, this is similar to Copy-on-write poison recovery,
When an error is detected during the page copy, return VM_FAULT_HWPOISON
in do_swap_page(), and install a hwpoison entry in unuse_pte() when
swapoff, which help us to avoid system crash. Note, memory failure on
a KSM page will be skipped, but still call memory_failure_queue() to
be consistent with general memory failure process.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v3 resend: 
- enhance unuse_pte() if ksm_might_need_to_copy() return -EHWPOISON
- fix issue found by lkp 

 mm/ksm.c      |  8 ++++++--
 mm/memory.c   |  3 +++
 mm/swapfile.c | 20 ++++++++++++++------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index dd02780c387f..83e2f74ae7da 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2629,8 +2629,12 @@ struct page *ksm_might_need_to_copy(struct page *page,
 		new_page = NULL;
 	}
 	if (new_page) {
-		copy_user_highpage(new_page, page, address, vma);
-
+		if (copy_mc_user_highpage(new_page, page, address, vma)) {
+			put_page(new_page);
+			new_page = ERR_PTR(-EHWPOISON);
+			memory_failure_queue(page_to_pfn(page), 0);
+			return new_page;
+		}
 		SetPageDirty(new_page);
 		__SetPageUptodate(new_page);
 		__SetPageLocked(new_page);
diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..5b2c137dfb2a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3840,6 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (unlikely(!page)) {
 			ret = VM_FAULT_OOM;
 			goto out_page;
+		} else if (unlikely(PTR_ERR(page) == -EHWPOISON)) {
+			ret = VM_FAULT_HWPOISON;
+			goto out_page;
 		}
 		folio = page_folio(page);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 908a529bca12..0efb1c2c2415 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1763,12 +1763,15 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *swapcache;
 	spinlock_t *ptl;
 	pte_t *pte, new_pte;
+	bool hwposioned = false;
 	int ret = 1;
 
 	swapcache = page;
 	page = ksm_might_need_to_copy(page, vma, addr);
 	if (unlikely(!page))
 		return -ENOMEM;
+	else if (unlikely(PTR_ERR(page) == -EHWPOISON))
+		hwposioned = true;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
@@ -1776,15 +1779,19 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto out;
 	}
 
-	if (unlikely(!PageUptodate(page))) {
-		pte_t pteval;
+	if (hwposioned || !PageUptodate(page)) {
+		swp_entry_t swp_entry;
 
 		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-		pteval = swp_entry_to_pte(make_swapin_error_entry());
-		set_pte_at(vma->vm_mm, addr, pte, pteval);
-		swap_free(entry);
+		if (hwposioned) {
+			swp_entry = make_hwpoison_entry(swapcache);
+			page = swapcache;
+		} else {
+			swp_entry = make_swapin_error_entry();
+		}
+		new_pte = swp_entry_to_pte(swp_entry);
 		ret = 0;
-		goto out;
+		goto setpte;
 	}
 
 	/* See do_swap_page() */
@@ -1816,6 +1823,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		new_pte = pte_mksoft_dirty(new_pte);
 	if (pte_swp_uffd_wp(*pte))
 		new_pte = pte_mkuffd_wp(new_pte);
+setpte:
 	set_pte_at(vma->vm_mm, addr, pte, new_pte);
 	swap_free(entry);
 out:
-- 
2.35.3

