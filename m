Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B0265E8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjAEKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjAEKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:42 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE38574D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-46eb8a5a713so313721737b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NW6wHLpIenfZ4H83ugQ2cvHsKjvU5VzZf+cgjAGHY40=;
        b=rEGgdMvuu+27Ici8qii/KRILsHn9RlUYSO9K/TJzur40T3t5kesN5ok/NY1HloAU4L
         Z7iSC9U8uLAkzjnzBDCE6RwQaxIdaGRfRBI7Ay4/uqsXEpMpfJH5fXmrdGe8jBMdebhB
         PTfqNSSWxeBYlcJ/n89QdrXzg+3piVs9cMRx16JezvMUtD4M+SLYVIhAlR6VJsoaz/0q
         LIveRtwE+XWa1auke1aNsrJsM9rgwGQVMhxbEoL1PGm2s5/+Us9MZpK3VqY68e/ucGb6
         rLqEJyLAlrwQyolGVPX3aLH9GGNSXJQpX581J5jygzsuQLpiwPMUgm2Gwf8Q06CukAiZ
         8Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW6wHLpIenfZ4H83ugQ2cvHsKjvU5VzZf+cgjAGHY40=;
        b=RTR6GN1vHS4yjBFCnzr9Jp9uOh4VNwNaOKJqAP75vAh1UefWCUvZkUj6xDe1Zqy2Jx
         H0PGcxUif1TmhW6PYspoAVZKwFKIhYb9Q0ARxazraQth9lRfLL8zmylcy//heoCt6rnD
         jAg1d7jPZmShUPJ9HRv5Zjz5RCSEgBuDwARTcrL3MHnLmFJZuLo4MDAK73Yv0Untz4Wk
         OR5RM/z4lvVQ1qEG4ENCG3er2gBYY3HL4XJpb/rMKAMiLzsCPdnoKKyZk3ku6yINlDnF
         FOVC8clLSvRH46IOmnQqmx0VfOBmyayeVkdZCSgU/s0v1f/gtFyec4Bz0w7w2BGrwy+B
         V3Qg==
X-Gm-Message-State: AFqh2koqaXJB4+piqBAFA9t096yI8hRaYY2ZM17ScIWkM2KN2bSsTXr3
        Kk0E/Yr09GCsD4cD2rXl4050PnaQKAW9xC/i
X-Google-Smtp-Source: AMrXdXsgAfnLGLH/tQnO5IQRR4cK4f4YIvu7i1V91wP/6Pz7HgI4U5X4q/x6mDIyEA8c+u2ZnwHVp4g63zKjZ7Sk
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:4bc4:0:b0:794:4ff7:1111 with SMTP
 id y187-20020a254bc4000000b007944ff71111mr1789851yba.603.1672913973763; Thu,
 05 Jan 2023 02:19:33 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:25 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-28-jthoughton@google.com>
Subject: [PATCH 27/46] hugetlb: add HGM support for move_hugetlb_page_tables
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
 mm/hugetlb.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 21a5116f509b..582d14a206b5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5313,16 +5313,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
+	dst_ptl = hugetlb_pte_lock(dst_hpte);
+	src_ptl = hugetlb_pte_lockptr(src_hpte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
@@ -5331,8 +5331,8 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
-	set_huge_pte_at(mm, new_addr, dst_pte, pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_hpte->ptep);
+	set_huge_pte_at(mm, new_addr, dst_hpte->ptep, pte);
 
 	if (src_ptl != dst_ptl)
 		spin_unlock(src_ptl);
@@ -5350,9 +5350,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long old_end = old_addr + len;
 	unsigned long last_addr_mask;
-	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
 	bool shared_pmd = false;
+	struct hugetlb_pte src_hpte, dst_hpte;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
 				old_end);
@@ -5368,28 +5368,35 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	/* Prevent race with file truncation */
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
-	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
-		src_pte = hugetlb_walk(vma, old_addr, sz);
-		if (!src_pte) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+	while (old_addr < old_end) {
+		if (hugetlb_full_walk(&src_hpte, vma, old_addr)) {
+			/* The hstate-level PTE wasn't allocated. */
+			old_addr = (old_addr | last_addr_mask) + sz;
+			new_addr = (new_addr | last_addr_mask) + sz;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+
+		if (huge_pte_none(huge_ptep_get(src_hpte.ptep))) {
+			old_addr += hugetlb_pte_size(&src_hpte);
+			new_addr += hugetlb_pte_size(&src_hpte);
 			continue;
+		}
 
-		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
+		if (hugetlb_pte_size(&src_hpte) == sz &&
+		    huge_pmd_unshare(mm, vma, old_addr, src_hpte.ptep)) {
 			shared_pmd = true;
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr = (old_addr | last_addr_mask) + sz;
+			new_addr = (new_addr | last_addr_mask) + sz;
 			continue;
 		}
 
-		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
-		if (!dst_pte)
+		if (hugetlb_full_walk_alloc(&dst_hpte, new_vma, new_addr,
+					hugetlb_pte_size(&src_hpte)))
 			break;
 
-		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte);
+		move_hugetlb_pte(vma, old_addr, new_addr, &src_hpte, &dst_hpte);
+		old_addr += hugetlb_pte_size(&src_hpte);
+		new_addr += hugetlb_pte_size(&src_hpte);
 	}
 
 	if (shared_pmd)
-- 
2.39.0.314.g84b9a713c41-goog

