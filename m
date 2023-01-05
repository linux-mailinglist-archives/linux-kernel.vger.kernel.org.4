Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94E65E8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjAEKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjAEKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6622A58D0C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e12-20020a25500c000000b007b48c520262so1904943ybb.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQJKiUDoV/4j52zLo+Pfg4lOVIUQ9TTfXf4yaRNkk0o=;
        b=atlQfqiEgy1xYzhT4IyUVUGbPAhpghAx33YY9Ut2pzp0mD93Mh/Yq8hJbUQYMZUGyv
         79g4SUp7Afeizjld4KBniyNCxadcDLxlzNbxhQuOC/KyWBzgN0ZCC7l0KieF/fpc4kkJ
         iUr6M0pdgU5RSZag7PDJbcOaLT6TYs/HCTL9W9Jb1R+becqgtzJQGEONP4TOXQWnH4F0
         DYOLfXy51tLR/SmFY1q18P7ZJv+GrFzaVXxYkXHmZUnrB2+y7sCsAz/aoRq7ER2ueTN4
         kZf3HAYzz5w5uKAKpFJxkGcQKV4Ix4sjQ5F5h/IZxCSAjyzQRxzHbXvVGGDZzdryGq3g
         sSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQJKiUDoV/4j52zLo+Pfg4lOVIUQ9TTfXf4yaRNkk0o=;
        b=E1mJCr2kdn1ZNfbdKpv4vqFKBioTdwwDlzGw7qFyMGdIQIIRwu3q60xx1e3OAgIjGu
         WZO+GC7pdQVbotGVK7xsPpSG33AnLXN5KEpeuM252wfhcpV4Q3LcFW9HMpsJgVfEYUGw
         ZJa4Be2FFsBetED6YPZmWqWFpMXnoR5KnpqBLhWyrS6KatgT8YdsYG43ZTml47byscKE
         O/ZT3Q/aMuZSW1FBXAC8KZjpgtTNmk0QcQmMCNl1plA47GfA5GpowcKNWVnwJG2RTFRG
         hDevHE33be28WmppSGXOik5hAfWk6kQE6b1XNKD39nkDEmpaWxYP++2Lz6P3bTE88hZa
         TQew==
X-Gm-Message-State: AFqh2koHtqYDYzTVz4DFEs4MmTf9IvtdSbCh0fz3gYSQReTZI38J7A0+
        fEc+gIaoDWedBHHSHZtQeS5IazrvtSrCyzg7
X-Google-Smtp-Source: AMrXdXskgc9vPcHYbKiHVU6KI+i99SMBDDXKXKUoGyd1uzZY3LEXY9tDZtAeOm/gOkCBpHD2OdRdbv4oR1vsSaUo
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:cc8:0:b0:38d:c23a:c541 with SMTP id
 191-20020a810cc8000000b0038dc23ac541mr53560ywm.109.1672913985945; Thu, 05 Jan
 2023 02:19:45 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:34 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-37-jthoughton@google.com>
Subject: [PATCH 36/46] hugetlb: remove huge_pte_lock and huge_pte_lockptr
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
 arch/powerpc/mm/pgtable.c |  7 +++++--
 include/linux/hugetlb.h   | 42 +++++++++++++++------------------------
 mm/hugetlb.c              | 22 +++++++++++++-------
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 035a0df47af0..e20d6aa9a2a6 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -258,11 +258,14 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		struct hstate *h = hstate_vma(vma);
+		struct hugetlb_pte hpte;
 
 		psize = hstate_get_psize(h);
 #ifdef CONFIG_DEBUG_VM
-		assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),
-						    vma->vm_mm, ptep));
+		/* HGM is not supported for powerpc yet. */
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+				hpage_size_to_level(psize));
+		assert_spin_locked(hpte.ptl);
 #endif
 
 #else
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e1baf939afb6..4d318bf2ced9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1032,14 +1032,6 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
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
@@ -1248,12 +1240,6 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
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
@@ -1328,16 +1314,6 @@ int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
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
 spinlock_t *hugetlb_pte_lockptr(struct hugetlb_pte *hpte)
 {
@@ -1358,8 +1334,22 @@ void hugetlb_pte_populate(struct mm_struct *mm, struct hugetlb_pte *hpte,
 			  pte_t *ptep, unsigned int shift,
 			  enum hugetlb_level level)
 {
-	__hugetlb_pte_populate(hpte, ptep, shift, level,
-			huge_pte_lockptr(shift, mm, ptep));
+	spinlock_t *ptl;
+
+	/*
+	 * For contiguous HugeTLB PTEs that can contain other HugeTLB PTEs
+	 * on the same level, the same PTL for both must be used.
+	 *
+	 * For some architectures that implement hugetlb_walk_step, this
+	 * version of hugetlb_pte_populate() may not be correct to use for
+	 * high-granularity PTEs. Instead, call __hugetlb_pte_populate()
+	 * directly.
+	 */
+	if (level == HUGETLB_LEVEL_PMD)
+		ptl = pmd_lockptr(mm, (pmd_t *) ptep);
+	else
+		ptl = &mm->page_table_lock;
+	__hugetlb_pte_populate(hpte, ptep, shift, level, ptl);
 }
 
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 388c46c7e77a..d71adc03138d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5303,9 +5303,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				put_page(hpage);
 
 				/* Install the new huge page if src pte stable */
-				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(huge_page_shift(h),
-							   src, src_pte);
+				dst_ptl = hugetlb_pte_lock(&dst_hpte);
+				src_ptl = hugetlb_pte_lockptr(&src_hpte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -7383,7 +7382,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long saddr;
 	pte_t *spte = NULL;
 	pte_t *pte;
-	spinlock_t *ptl;
+	struct hugetlb_pte hpte;
+	struct hstate *shstate;
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
@@ -7404,7 +7404,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!spte)
 		goto out;
 
-	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
+	shstate = hstate_vma(svma);
+
+	hugetlb_pte_populate(mm, &hpte, spte, huge_page_shift(shstate),
+			hpage_size_to_level(huge_page_size(shstate)));
+	spin_lock(hpte.ptl);
 	if (pud_none(*pud)) {
 		pud_populate(mm, pud,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
@@ -7412,7 +7416,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	} else {
 		put_page(virt_to_page(spte));
 	}
-	spin_unlock(ptl);
+	spin_unlock(hpte.ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
 	i_mmap_unlock_read(mapping);
@@ -8132,6 +8136,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	unsigned long address, start, end;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	struct hugetlb_pte hpte;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
@@ -8156,7 +8161,10 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
 			continue;
-		ptl = huge_pte_lock(h, mm, ptep);
+
+		hugetlb_pte_populate(mm, &hpte, ptep, huge_page_shift(h),
+				     hpage_size_to_level(sz));
+		ptl = hugetlb_pte_lock(&hpte);
 		huge_pmd_unshare(mm, vma, address, ptep);
 		spin_unlock(ptl);
 	}
-- 
2.39.0.314.g84b9a713c41-goog

