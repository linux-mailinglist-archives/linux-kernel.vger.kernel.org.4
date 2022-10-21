Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF69607C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJUQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJUQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5582277A14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-369d18a90c3so25164097b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pO7qfdtljC0cQEtW68yd+sWFuuFiNFYwsARvURkZJUk=;
        b=F5EfAc0EFaqIHDJwcnG3SX+PWOaohJQFLM2kFecrOP2UMSCoQVjg78Y10c4j1PI46N
         x3pQT8CD3Oz4bgPgYC/hkNHGtoaKAp+KDoJ159WXQmk8tAlHkqBPm8EcDd37g5RKAzHh
         OvLW9vkuEzWvkq5Y6LbXK3yN9XL3aGUUggRQqwFgMqJtrLkxrke5o4a9R8EwmQ1kcj1S
         Hppt92/szI1X7GCxGOniN98/J1Tm1vwZRKo9WhiiZPqGEQDCeU4Uj32Clokiwp8SefxD
         ZHhuRWT6/KZWweMGNRSX67APat2/HtcUTuMbrmhoGIuQHcxDyVwqWe/kONRtmfkeK79F
         UDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pO7qfdtljC0cQEtW68yd+sWFuuFiNFYwsARvURkZJUk=;
        b=jz+fnZtfHpBmF7A3MZ/ReMFUgbGZtR+WCx4rI/5uEvNWZQZ7gi/yhozoc/GZrJsdjK
         m1auZyNLho1GInwYYuGsXb3xi/+gVU0jhflmtPA32pLeoydzp/ZOCysZ9kW0iqOxfepq
         O7LyaCuDA5gv/i5KW7WLTdXzS+bD4AOSh3/FOGBkBJqSnsXER70fzvg+tLNV+gpqZAFv
         UIqP8mM3wF87CLvhWIeVmH5YN7YS6M5YyuqCPqDTsaPj+lIovAi9Ib96s050EgmNzJtL
         wOzR3PRXIfwGXtTBwFEQ3q3lpaKQlbwqCym/km4m0oOQlM6lthLvmKgwccQp1ppgoHwZ
         vrqg==
X-Gm-Message-State: ACrzQf0zbtgIUGgXy2NhlfZ6SEzf2TXtgI3Mf04eAePl6i/pfKY+Rryt
        EAr9RpXOWOVPvMeNYE182VZ176GhvuvKJWV7
X-Google-Smtp-Source: AMsMyM7rpb5mjTGAEgy2DHwIFR1eIfpS/I9RsBpBYNRwglN8Yvfr24l7aLFFrSr+D9OVYLDzvsu+JgqdYQ0MB69h
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:da85:0:b0:360:819a:ffa8 with SMTP
 id c127-20020a0dda85000000b00360819affa8mr17910682ywe.414.1666370270941; Fri,
 21 Oct 2022 09:37:50 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:53 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-38-jthoughton@google.com>
Subject: [RFC PATCH v2 37/47] hugetlb: remove huge_pte_lock and huge_pte_lockptr
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

They are replaced with hugetlb_pte_lock{,ptr}. All callers that haven't
already been replaced don't get called when using HGM, so we handle them
by populating hugetlb_ptes with the standard, hstate-sized huge PTEs.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 28 +++-------------------------
 mm/hugetlb.c            | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5378b98cc7b8..e6dc25b15403 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1015,14 +1015,6 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }
 
-static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
-					   struct mm_struct *mm, pte_t *pte)
-{
-	if (shift == PMD_SHIFT)
-		return pmd_lockptr(mm, (pmd_t *) pte);
-	return &mm->page_table_lock;
-}
-
 #ifndef hugepages_supported
 /*
  * Some platform decide whether they support huge pages at boot
@@ -1226,12 +1218,6 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
-					   struct mm_struct *mm, pte_t *pte)
-{
-	return &mm->page_table_lock;
-}
-
 static inline void hugetlb_count_init(struct mm_struct *mm)
 {
 }
@@ -1307,16 +1293,6 @@ int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 #endif
 
-static inline spinlock_t *huge_pte_lock(struct hstate *h,
-					struct mm_struct *mm, pte_t *pte)
-{
-	spinlock_t *ptl;
-
-	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
-	spin_lock(ptl);
-	return ptl;
-}
-
 static inline
 spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
 {
@@ -1324,7 +1300,9 @@ spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
 	BUG_ON(!hpte->ptep);
 	if (hpte->ptl)
 		return hpte->ptl;
-	return huge_pte_lockptr(hugetlb_pte_shift(hpte), mm, hpte->ptep);
+	if (hugetlb_pte_level(hpte) == HUGETLB_LEVEL_PMD)
+		return pmd_lockptr(mm, (pmd_t *) hpte->ptep);
+	return &mm->page_table_lock;
 }
 
 static inline
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d80db81a1fa5..9d4e41c41f78 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5164,9 +5164,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				put_page(hpage);
 
 				/* Install the new huge page if src pte stable */
-				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(huge_page_shift(h),
-							   src, src_pte);
+				dst_ptl = hugetlb_pte_lock(dst, &dst_hpte);
+				src_ptl = hugetlb_pte_lockptr(src, &src_hpte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -7465,6 +7464,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *spte = NULL;
 	pte_t *pte;
 	spinlock_t *ptl;
+	struct hugetlb_pte hpte;
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
@@ -7485,7 +7485,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!spte)
 		goto out;
 
-	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
+	hugetlb_pte_populate(&hpte, (pte_t *)pud, PUD_SHIFT, HUGETLB_LEVEL_PUD);
+	ptl = hugetlb_pte_lock(mm, &hpte);
 	if (pud_none(*pud)) {
 		pud_populate(mm, pud,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
@@ -8179,6 +8180,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	unsigned long address, start, end;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	struct hugetlb_pte hpte;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
@@ -8203,7 +8205,10 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
 			continue;
-		ptl = huge_pte_lock(h, mm, ptep);
+
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+				hpage_size_to_level(sz));
+		ptl = hugetlb_pte_lock(mm, &hpte);
 		huge_pmd_unshare(mm, vma, address, ptep);
 		spin_unlock(ptl);
 	}
-- 
2.38.0.135.g90850a2211-goog

