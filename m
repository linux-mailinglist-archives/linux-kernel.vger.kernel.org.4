Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD3666C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbjALIR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjALIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:17:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B935902
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:17:35 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nsy3m238PzJq98;
        Thu, 12 Jan 2023 16:13:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 16:17:32 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 2/7] mm: memory: convert do_anonymous_page() to use a folio
Date:   Thu, 12 Jan 2023 16:30:01 +0800
Message-ID: <20230112083006.163393-3-wangkefeng.wang@huawei.com>
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

Convert do_anonymous_page() to use a folio and replace related functions
to folio functions.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 56b571c83a0e..1cfdb0fd8d79 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4002,6 +4002,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
+	struct folio *folio;
 	vm_fault_t ret = 0;
 	pte_t entry;
 
@@ -4055,16 +4056,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
+	folio = page_folio(page);
+	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
-	cgroup_throttle_swaprate(page, GFP_KERNEL);
+	folio_throttle_swaprate(folio, GFP_KERNEL);
 
 	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	__folio_mark_uptodate(folio);
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
@@ -4085,13 +4087,13 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Deliver the page fault to userland, check inside PT lock */
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		put_page(page);
+		folio_put(folio);
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address);
-	lru_cache_add_inactive_or_unevictable(page, vma);
+	folio_add_lru_vma(folio, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -4101,10 +4103,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 release:
-	put_page(page);
+	folio_put(folio);
 	goto unlock;
 oom_free_page:
-	put_page(page);
+	folio_put(folio);
 oom:
 	return VM_FAULT_OOM;
 }
-- 
2.35.3

