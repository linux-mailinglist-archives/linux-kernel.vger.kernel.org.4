Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFA607C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiJUQiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJUQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA8724AE2A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36810cfa61fso34036617b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiouMOIIjJOYM6j/82rHxYpjcD4eEhikQkMBGqa8BjI=;
        b=CKDVMh2S2MhbdslRa+CI5ddIMrp2Tg/ONWgjdp1mlNaXKwpLWu4solm3u9LKSEZhXe
         p5A9lENwGfwCeYMW/FG7oLitUyH1M07pAul99TUAng6w3bindvWi4y2ob1DEtfPdFWqB
         mEbbZRsIEV0rMs/1QSkPYQ7dFlZlPFhQZCI2VPY2cOuqpSHhoSsI6hY56xx7Nrh4CjVM
         eSbPEMydq6pzO8+REx/zjXLNqei8CW9W8LlzdHQcvqY0UxSls9cI1rUTL/nhPpVdrYN7
         CrKaq5o7mD0KjcbV9vAH7QbcGy2DhuZdmXzsjVy3O3QG6hDph0GIp/gUmOcRtHlgiQyh
         o1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiouMOIIjJOYM6j/82rHxYpjcD4eEhikQkMBGqa8BjI=;
        b=kAPv8GsckLnNW/gYoV1/aonBYhLVlTH8kobuFa0kg5rJXQBtYKlk7O0kOsg0yR7eZ9
         tJdqTBRS8a3pFeHwz5u83QBKI/Al278ryxKWubdRbE0bcLRqViOeVF+L3NEkWhG9dUIu
         /yh+3jXN+TuPug0N6a2ZcSDWpYW6mJpy7ycSgJY3N2aRxpIoEa7lPPl+DiMLHtpw5VNB
         MA/myvZyqKdbT3n8lB/773p50R6wmeSD8OmDhLaBDEcW8lVz+d3QtqUPk64bb7Cr/lrY
         Toc4CkZ2xPkg1v4U1daUYIdNWixiORtBUGVoKcHTw0C1diUCGUm3+KH6XueXjjhGndjL
         zVJw==
X-Gm-Message-State: ACrzQf1lX/iknXdVtbr3PWgq2UVF1Rx5gCvo+by0F0dZDT9pb1viRbu/
        8Ie5PDyHPQ6Ffl7BV6mXvToHq52W9vzOtEDa
X-Google-Smtp-Source: AMsMyM7X8/tb9BRsckLDnqlJFeET3NZqXynOVW5o2aTa1Z25kXUp3nnDPZi442QY8I4RggrVWYOsHolTPZE57Spr
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:124f:b0:66e:e3da:487e with
 SMTP id t15-20020a056902124f00b0066ee3da487emr18532629ybu.310.1666370247777;
 Fri, 21 Oct 2022 09:37:27 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:28 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-13-jthoughton@google.com>
Subject: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
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

hugetlb_hgm_walk implements high-granularity page table walks for
HugeTLB. It is safe to call on non-HGM enabled VMAs; it will return
immediately.

hugetlb_walk_step implements how we step forwards in the walk. For
architectures that don't use GENERAL_HUGETLB, they will need to provide
their own implementation.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  13 +++++
 mm/hugetlb.c            | 125 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 003255b0e40f..4b1548adecde 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -276,6 +276,10 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
 
+int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
+		     struct hugetlb_pte *hpte, unsigned long addr,
+		     unsigned long sz, bool stop_at_none);
+
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
 extern int sysctl_hugetlb_shm_group;
@@ -288,6 +292,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
+int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		      unsigned long addr, unsigned long sz);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
@@ -1066,6 +1072,8 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
+enum hugetlb_level hpage_size_to_level(unsigned long sz);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1253,6 +1261,11 @@ static inline void hugetlb_register_node(struct node *node)
 static inline void hugetlb_unregister_node(struct node *node)
 {
 }
+
+static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
+{
+	return HUGETLB_LEVEL_PTE;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e3733388adee..90db59632559 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -95,6 +95,29 @@ static void hugetlb_vma_data_free(struct vm_area_struct *vma);
 static int hugetlb_vma_data_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
+/*
+ * hpage_size_to_level() - convert @sz to the corresponding page table level
+ *
+ * @sz must be less than or equal to a valid hugepage size.
+ */
+enum hugetlb_level hpage_size_to_level(unsigned long sz)
+{
+	/*
+	 * We order the conditionals from smallest to largest to pick the
+	 * smallest level when multiple levels have the same size (i.e.,
+	 * when levels are folded).
+	 */
+	if (sz < PMD_SIZE)
+		return HUGETLB_LEVEL_PTE;
+	if (sz < PUD_SIZE)
+		return HUGETLB_LEVEL_PMD;
+	if (sz < P4D_SIZE)
+		return HUGETLB_LEVEL_PUD;
+	if (sz < PGDIR_SIZE)
+		return HUGETLB_LEVEL_P4D;
+	return HUGETLB_LEVEL_PGD;
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -7321,6 +7344,70 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 }
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
+/* hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
+ * the page table entry for @addr.
+ *
+ * @hpte must always be pointing at an hstate-level PTE (or deeper).
+ *
+ * This function will never walk further if it encounters a PTE of a size
+ * less than or equal to @sz.
+ *
+ * @stop_at_none determines what we do when we encounter an empty PTE. If true,
+ * we return that PTE. If false and @sz is less than the current PTE's size,
+ * we make that PTE point to the next level down, going until @sz is the same
+ * as our current PTE.
+ *
+ * If @stop_at_none is true and @sz is PAGE_SIZE, this function will always
+ * succeed, but that does not guarantee that hugetlb_pte_size(hpte) is @sz.
+ *
+ * Return:
+ *	-ENOMEM if we couldn't allocate new PTEs.
+ *	-EEXIST if the caller wanted to walk further than a migration PTE,
+ *		poison PTE, or a PTE marker. The caller needs to manually deal
+ *		with this scenario.
+ *	-EINVAL if called with invalid arguments (@sz invalid, @hpte not
+ *		initialized).
+ *	0 otherwise.
+ *
+ *	Even if this function fails, @hpte is guaranteed to always remain
+ *	valid.
+ */
+int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
+		     struct hugetlb_pte *hpte, unsigned long addr,
+		     unsigned long sz, bool stop_at_none)
+{
+	int ret = 0;
+	pte_t pte;
+
+	if (WARN_ON_ONCE(sz < PAGE_SIZE))
+		return -EINVAL;
+
+	if (!hugetlb_hgm_enabled(vma)) {
+		if (stop_at_none)
+			return 0;
+		return sz == huge_page_size(hstate_vma(vma)) ? 0 : -EINVAL;
+	}
+
+	hugetlb_vma_assert_locked(vma);
+
+	if (WARN_ON_ONCE(!hpte->ptep))
+		return -EINVAL;
+
+	while (hugetlb_pte_size(hpte) > sz && !ret) {
+		pte = huge_ptep_get(hpte->ptep);
+		if (!pte_present(pte)) {
+			if (stop_at_none)
+				return 0;
+			if (unlikely(!huge_pte_none(pte)))
+				return -EEXIST;
+		} else if (hugetlb_pte_present_leaf(hpte, pte))
+			return 0;
+		ret = hugetlb_walk_step(mm, hpte, addr, sz);
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
@@ -7388,6 +7475,44 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return (pte_t *)pmd;
 }
 
+/*
+ * hugetlb_walk_step() - Walk the page table one step to resolve the page
+ * (hugepage or subpage) entry at address @addr.
+ *
+ * @sz always points at the final target PTE size (e.g. PAGE_SIZE for the
+ * lowest level PTE).
+ *
+ * @hpte will always remain valid, even if this function fails.
+ */
+int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		      unsigned long addr, unsigned long sz)
+{
+	pte_t *ptep;
+	spinlock_t *ptl;
+
+	switch (hpte->level) {
+	case HUGETLB_LEVEL_PUD:
+		ptep = (pte_t *)hugetlb_pmd_alloc(mm, hpte, addr);
+		if (IS_ERR(ptep))
+			return PTR_ERR(ptep);
+		hugetlb_pte_populate(hpte, ptep, PMD_SHIFT, HUGETLB_LEVEL_PMD);
+		break;
+	case HUGETLB_LEVEL_PMD:
+		ptep = hugetlb_pte_alloc(mm, hpte, addr);
+		if (IS_ERR(ptep))
+			return PTR_ERR(ptep);
+		ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);
+		hugetlb_pte_populate(hpte, ptep, PAGE_SHIFT, HUGETLB_LEVEL_PTE);
+		hpte->ptl = ptl;
+		break;
+	default:
+		WARN_ONCE(1, "%s: got invalid level: %d (shift: %d)\n",
+				__func__, hpte->level, hpte->shift);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * Return a mask that can be used to update an address to the last huge
  * page in a page table page mapping size.  Used to skip non-present
-- 
2.38.0.135.g90850a2211-goog

