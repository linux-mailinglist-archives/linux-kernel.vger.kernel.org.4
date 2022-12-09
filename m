Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711EC647BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLIBxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiLIBxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:53:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E5A0FB4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:53:40 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSv8Q6DYWzqSyF;
        Fri,  9 Dec 2022 09:49:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 09:53:38 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>
CC:     <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: hwposion: support recovery from ksm_might_need_to_copy()
Date:   Fri, 9 Dec 2022 10:10:40 +0800
Message-ID: <20221209021041.192835-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
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

When the kernel copy a page from ksm_might_need_to_copy(), but runs
into an uncorrectable error, it will crash since poisoned page is
consumed by kernel, this is similar to Copy-on-write poison recovery,
When an error is detected during the page copy, return VM_FAULT_HWPOISON,
which help us to avoid system crash. Note, memory failure on a KSM
page will be skipped, but still call memory_failure_queue() to be
consistent with general memory failure process.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/ksm.c      | 8 ++++++--
 mm/memory.c   | 3 +++
 mm/swapfile.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f1e06b1d47f3..356e93b85287 100644
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
index 2615fa615be4..bb7b35e42297 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3840,6 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (unlikely(!page)) {
 			ret = VM_FAULT_OOM;
 			goto out_page;
+		} els if (unlikely(PTR_ERR(page) == -EHWPOISON)) {
+			ret = VM_FAULT_HWPOISON;
+			goto out_page;
 		}
 		folio = page_folio(page);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f670ffb7df7e..763ff6a8a576 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1767,7 +1767,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 
 	swapcache = page;
 	page = ksm_might_need_to_copy(page, vma, addr);
-	if (unlikely(!page))
+	if (IS_ERR_OR_NULL(!page))
 		return -ENOMEM;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-- 
2.35.3

