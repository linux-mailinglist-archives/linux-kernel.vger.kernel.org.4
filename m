Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9777C607C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiJUQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJUQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9344E2892DF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m66-20020a257145000000b006c23949ec98so3762402ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBv8Qeh3umlbRvLwHQeNwyurmrBSLw5TULsp1T6zjOQ=;
        b=suyR7+ETHnPADETLXijl2rxvK4S0l8lKXahB00jRy94KrLql58bgTIu6Xtq+wEAutw
         3qSk5gGSMSLsMT2bwUVmLbiHjZ0JM//d+Va50N+iIzaNRXrtWFUP2ujYlH1+zkVlnTBY
         o4N+HujD+Uvd3YUSbtc6XaGAqm8geaCN4uRH8TMKVxMsk5SRi2j9odHj3AlMttSaThcn
         piV7sQs60kSX1tbZIg1XS5TZQJHNgM0uTI7X8y1AXFlegWGyn7RhVj6zPo9K9F6hUJ3t
         H8alvqf47S17+GW/5DSv1v7fEO6GtqbrtOg9qQM+8ny5ZkncQHoN4Y8WiC0iIHWzuQsy
         2f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBv8Qeh3umlbRvLwHQeNwyurmrBSLw5TULsp1T6zjOQ=;
        b=5Mzdsc7CsKuEqubgr+2xux6i0L/aDsRcSo1BEi/5dUw8ppuyMwC1m36+wdujhy1lIT
         YVZgOYVEWFRjC+yCOVotFibhuoH9IITIWdWDABIyQAHikv6GHB852X270KG7YY8fNFyE
         L8Kwu+j59mva2LgDVrCh4MBySF0J6AR28o4hhWrcbF/8lmSsIDGUPmsK34o9hNZw4o8A
         wh1PF3z77/Q/EqqS5R76Z/WoXs8nYFHMOnUJSFy1yvnQbVQaPeEdqR3w4grOEt9Cu2bA
         1P1LOSaA5PvaFE+BwlVwM54rBZiqfnHO2yLBWs/CX6Nv9zvUi2B3bpUmb46HpcxW8qB5
         yRwA==
X-Gm-Message-State: ACrzQf228TMlyqrxYpJ78lc4KTCPgqFmLjB+LkwCLGDGV4ptug8I4NcB
        BNQTuyo2Fp6Ls+ax3pLlwBRduwDAjq7MS/ll
X-Google-Smtp-Source: AMsMyM6dL+1MEn3usFlfe2w4rDmoALEsJetzdzp0dKvN3alW4LkUGv7Gm0+RZmYNLBhMIeQTdlGoqaYDlTAsktx8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:84cc:0:b0:6c4:95:f1c1 with SMTP id
 x12-20020a2584cc000000b006c40095f1c1mr18790616ybm.131.1666370260537; Fri, 21
 Oct 2022 09:37:40 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:42 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-27-jthoughton@google.com>
Subject: [RFC PATCH v2 26/47] hugetlb: make move_hugetlb_page_tables
 compatible with HGM
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very similar to the support that was added to
copy_hugetlb_page_range. We simply do a high-granularity walk now, and
most of the rest of the code stays the same.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7d692907cbf3..16b0d192445c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5174,16 +5174,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	return ret;
 }
 
-static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte)
+static void move_hugetlb_pte(struct vm_area_struct *vma, unsigned long old_addr,
+			     unsigned long new_addr, struct hugetlb_pte *src_hpte,
+			     struct hugetlb_pte *dst_hpte)
 {
-	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *src_ptl, *dst_ptl;
 	pte_t pte;
 
-	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
+	dst_ptl = hugetlb_pte_lock(mm, dst_hpte);
+	src_ptl = hugetlb_pte_lockptr(mm, src_hpte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
@@ -5192,8 +5192,8 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
-	set_huge_pte_at(mm, new_addr, dst_pte, pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_hpte->ptep);
+	set_huge_pte_at(mm, new_addr, dst_hpte->ptep, pte);
 
 	if (src_ptl != dst_ptl)
 		spin_unlock(src_ptl);
@@ -5214,6 +5214,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
 	bool shared_pmd = false;
+	struct hugetlb_pte src_hpte, dst_hpte;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
 				old_end);
@@ -5229,20 +5230,28 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	/* Prevent race with file truncation */
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
-	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+	while (old_addr < old_end) {
 		src_pte = huge_pte_offset(mm, old_addr, sz);
 		if (!src_pte) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr = (old_addr | last_addr_mask) + sz;
+			new_addr = (new_addr | last_addr_mask) + sz;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+
+		hugetlb_pte_populate(&src_hpte, src_pte, huge_page_shift(h),
+				     hpage_size_to_level(sz));
+		hugetlb_hgm_walk(mm, vma, &src_hpte, old_addr,
+				PAGE_SIZE, /*stop_at_none=*/true);
+		if (huge_pte_none(huge_ptep_get(src_hpte.ptep))) {
+			old_addr += hugetlb_pte_size(&src_hpte);
+			new_addr += hugetlb_pte_size(&src_hpte);
 			continue;
+		}
 
-		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
+		if (huge_pmd_unshare(mm, vma, old_addr, src_hpte.ptep)) {
 			shared_pmd = true;
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr = (old_addr | last_addr_mask) + sz;
+			new_addr = (new_addr | last_addr_mask) + sz;
 			continue;
 		}
 
@@ -5250,7 +5259,15 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		if (!dst_pte)
 			break;
 
-		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte);
+		hugetlb_pte_populate(&dst_hpte, dst_pte, huge_page_shift(h),
+				     hpage_size_to_level(sz));
+		if (hugetlb_hgm_walk(mm, vma, &dst_hpte, new_addr,
+				     hugetlb_pte_size(&src_hpte),
+				     /*stop_at_none=*/false))
+			break;
+		move_hugetlb_pte(vma, old_addr, new_addr, &src_hpte, &dst_hpte);
+		old_addr += hugetlb_pte_size(&src_hpte);
+		new_addr += hugetlb_pte_size(&src_hpte);
 	}
 
 	if (shared_pmd)
-- 
2.38.0.135.g90850a2211-goog

