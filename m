Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F086F0FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjD1AmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344685AbjD1Alz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:41:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF94487
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a6862e47edso58313645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642513; x=1685234513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4TaCEi/qu9zeBFiKyPkDKaAfUVepeL/TJwi41Ch5WU=;
        b=VnYGn8ix7ehNw4jSdgSliIEL30nuomoEdqnEPKIL+LwGe6Kq9F94+shVVxiheZbkWD
         6SCxFWByNoglqaAY8+2jwRBhhMv8is9cTlRndkNUAT+ekUicUpVUKSrYTJE1+1qgY1+T
         XalfCUNsRxx40XaKcI4Au6GAT6yyjsw2JmxEiO3jC331ijP61wbqZRvaor+AuQRY/EV0
         8xhF7Q/kD7NJMX6DeaoffwGfPsl1qiOTx1jh3A1GwOTpnDWdZFX3F96vp3dTkKAd/s8Q
         x0j8eh66XJ/N6SBvIyYPcrKHiqstUyfTb2pMBzaxOcrjP89vFasMLH8UbLHFT1qmcwmr
         pIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642513; x=1685234513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4TaCEi/qu9zeBFiKyPkDKaAfUVepeL/TJwi41Ch5WU=;
        b=fPqYua7Z5RY8ab25xmfPFyZp2EDyHu5FAHrc8xOLJys9/fYH8ppw+7opaObF5uLDkD
         Di/jC2eoK89gay+tHP9wiM8uyC05T4V825ws3zn85UISNNl9T66p/+IH2QawwHtRrEFb
         4Axg6VlnjCndabBP7duvr3rlK+lNNzhL7hPX0sximLFodhH3xToVmmrt0+tAnsfVJTA6
         /8Vmre4V6ttIYR7vej9xTDBXXqimWdq7V72rb5MWBylyQtlelRstzwwlhcLaGFxSul1M
         c9QUO1s2bLTV8UL9g1ZlRF0dKgdc19RsRM/ICZrQbrhUZSnpnrETp+vu8W8noTOUfnp2
         CZLg==
X-Gm-Message-State: AC+VfDzdADYGAMU56csJWCpGMgHrw3rGuxzQjqQSE6qIdMpJIZToRAtM
        MQx/vDnhug3EYzfKRl7SM8IooL7wWa7ELg==
X-Google-Smtp-Source: ACHHUZ6lB5FSBQICSdN4ldTt2OldKStIrw0Mu+868RMewcAyv255kFlkEUhCZW+eyXgtrhKbY3nUVvDJARNhtQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:cecf:b0:1a5:e03:55b with SMTP id
 d15-20020a170902cecf00b001a50e03055bmr992059plg.11.1682642513448; Thu, 27 Apr
 2023 17:41:53 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:37 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-6-jiaqiyan@google.com>
Subject: [RFC PATCH v1 5/7] hugetlb: only VM_FAULT_HWPOISON_LARGE raw page
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, peterx@redhat.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        rientjes@google.com, linmiaohe@huawei.com, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory raw pages can become HWPOISON between when userspace maps
a hugepage and when userspace faults in the hugepage.

Today when hugetlb faults somewhere in a hugepage containing
HWPOISON raw pages, the result is a VM_FAULT_HWPOISON_LARGE.

This commit teaches hugetlb page fault handler to only
VM_FAULT_HWPOISON_LARGE if the faulting address is within HWPOISON
raw page; otherwise, fault handler can continue to fault in healthy
raw pages.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/mm.h  |   2 +
 mm/hugetlb.c        | 129 ++++++++++++++++++++++++++++++++++++++++++--
 mm/memory-failure.c |   1 +
 3 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc192f98cb1d..7caa4530953f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3531,6 +3531,7 @@ extern const struct attribute_group memory_failure_attr_group;
  * @nr_expected_unmaps: if a VMA that maps @page when detected is eligible
  *   for high granularity mapping, @page is expected to be unmapped.
  * @nr_actual_unmaps: how many times the raw page is actually unmapped.
+ * @index: index of the poisoned subpage in the folio.
  */
 struct raw_hwp_page {
 	struct llist_node node;
@@ -3538,6 +3539,7 @@ struct raw_hwp_page {
 	int nr_vmas_mapped;
 	int nr_expected_unmaps;
 	int nr_actual_unmaps;
+	unsigned long index;
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1419176b7e51..f8ddf04ae0c4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6158,6 +6158,30 @@ static struct folio *hugetlb_try_find_lock_folio(struct address_space *mapping,
 	return folio;
 }
 
+static vm_fault_t hugetlb_no_page_hwpoison(struct mm_struct *mm,
+					   struct vm_area_struct *vma,
+					   struct folio *folio,
+					   unsigned long address,
+					   struct hugetlb_pte *hpte,
+					   unsigned int flags);
+
+#ifndef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+static vm_fault_t hugetlb_no_page_hwpoison(struct mm_struct *mm,
+					   struct vm_area_struct *vma,
+					   struct folio *folio,
+					   unsigned long address,
+					   struct hugetlb_pte *hpte,
+					   unsigned int flags)
+{
+	if (unlikely(folio_test_hwpoison(folio))) {
+		return VM_FAULT_HWPOISON_LARGE |
+		       VM_FAULT_SET_HINDEX(hstate_index(hstate_vma(vma)));
+	}
+
+	return 0;
+}
+#endif
+
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
@@ -6287,13 +6311,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		/*
 		 * If memory error occurs between mmap() and fault, some process
 		 * don't have hwpoisoned swap entry for errored virtual address.
-		 * So we need to block hugepage fault by PG_hwpoison bit check.
+		 * So we need to block hugepage fault by hwpoison check:
+		 * - without HGM, the check is based on PG_hwpoison
+		 * - with HGM, check if the raw page for address is poisoned
 		 */
-		if (unlikely(folio_test_hwpoison(folio))) {
-			ret = VM_FAULT_HWPOISON_LARGE |
-				VM_FAULT_SET_HINDEX(hstate_index(h));
+		ret = hugetlb_no_page_hwpoison(mm, vma, folio, address, hpte, flags);
+		if (unlikely(ret))
 			goto backout_unlocked;
-		}
 
 		/* Check for page in userfault range. */
 		if (userfaultfd_minor(vma)) {
@@ -8426,6 +8450,11 @@ int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * the allocated PTEs created before splitting fails.
 	 */
 
+	/*
+	 * For none and UFFD_WP marker PTEs, given try_to_unmap_one doesn't
+	 * unmap them, delay the splitting until page fault happens. See the
+	 * hugetlb_no_page_hwpoison check in hugetlb_no_page.
+	 */
 	if (unlikely(huge_pte_none_mostly(old_entry))) {
 		ret = -EAGAIN;
 		goto skip;
@@ -8479,6 +8508,96 @@ int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ret;
 }
 
+/*
+ * Given a hugetlb PTE, if we want to split it into its next smaller level
+ * PTE, return what size we should use to do HGM walk with allocations.
+ * If given hugetlb PTE is already at smallest PAGESIZE, returns -EINVAL.
+ */
+static int hgm_next_size(struct vm_area_struct *vma, struct hugetlb_pte *hpte)
+{
+	struct hstate *h = hstate_vma(vma), *tmp_h;
+	unsigned int shift;
+	unsigned long curr_size = hugetlb_pte_size(hpte);
+	unsigned long next_size;
+
+	for_each_hgm_shift(h, tmp_h, shift) {
+		next_size = 1UL << shift;
+		if (next_size < curr_size)
+			return next_size;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Check if address is in the range of a HWPOISON raw page.
+ * During checking hugetlb PTE may be split into smaller hguetlb PTEs.
+ */
+static vm_fault_t hugetlb_no_page_hwpoison(struct mm_struct *mm,
+					   struct vm_area_struct *vma,
+					   struct folio *folio,
+					   unsigned long address,
+					   struct hugetlb_pte *hpte,
+					   unsigned int flags)
+{
+	unsigned long range_start, range_end;
+	unsigned long start_index, end_index;
+	unsigned long folio_start = vma_address(folio_page(folio, 0), vma);
+	struct llist_node *t, *tnode;
+	struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
+	struct raw_hwp_page *p = NULL;
+	bool contain_hwpoison = false;
+	int hgm_size;
+	int hgm_ret = 0;
+
+	if (likely(!folio_test_hwpoison(folio)))
+		return 0;
+
+	if (hugetlb_enable_hgm_vma(vma))
+		return VM_FAULT_HWPOISON_LARGE |
+		       VM_FAULT_SET_HINDEX(hstate_index(hstate_vma(vma)));
+
+recheck:
+	range_start = address & hugetlb_pte_mask(hpte);
+	range_end = range_start + hugetlb_pte_size(hpte);
+	start_index = (range_start - folio_start) / PAGE_SIZE;
+	end_index = start_index + hugetlb_pte_size(hpte) / PAGE_SIZE;
+
+	contain_hwpoison = false;
+	llist_for_each_safe(tnode, t, raw_hwp_head->first) {
+		p = container_of(tnode, struct raw_hwp_page, node);
+		if (start_index <= p->index && p->index < end_index) {
+			contain_hwpoison = true;
+			break;
+		}
+	}
+
+	if (!contain_hwpoison)
+		return 0;
+
+	if (hugetlb_pte_size(hpte) == PAGE_SIZE)
+		return VM_FAULT_HWPOISON;
+
+	/*
+	 * hugetlb_fault already ensured hugetlb_vma_lock_read.
+	 * We also checked hugetlb_pte_size(hpte) != PAGE_SIZE,
+	 * so hgm_size must be something meaningful to HGM.
+	 */
+	hgm_size = hgm_next_size(vma, hpte);
+	VM_BUG_ON(hgm_size == -EINVAL);
+	hgm_ret = hugetlb_full_walk_alloc(hpte, vma, address, hgm_size);
+	if (hgm_ret) {
+		WARN_ON_ONCE(hgm_ret);
+		/*
+		 * When splitting using HGM fails, return like
+		 * HGM is not eligible or enabled.
+		 */
+		return VM_FAULT_HWPOISON_LARGE |
+		       VM_FAULT_SET_HINDEX(hstate_index(hstate_vma(vma)));
+	}
+	goto recheck;
+}
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 47b935918ceb..9093ba53feed 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1957,6 +1957,7 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 		raw_hwp->nr_vmas_mapped = 0;
 		raw_hwp->nr_expected_unmaps = 0;
 		raw_hwp->nr_actual_unmaps = 0;
+		raw_hwp->index = folio_page_idx(folio, page);
 		llist_add(&raw_hwp->node, head);
 		if (hgm_enabled)
 			/*
-- 
2.40.1.495.gc816e09b53d-goog

