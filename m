Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B776F0FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbjD1Alw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbjD1Als (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:41:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DD213A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b5a2099a6so6138461b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642507; x=1685234507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlsvVMr5wJrguvOpjMRMDu7HLXIfjm1V1/lZO+i2wEY=;
        b=bk8krxONTSthWw2wf37v9leSTroOrwRjUmemZZJ/Lyh5va07os3jH0SdlKMX2Zlkwj
         1mnDEDdY4bjpGnEORTKMNTb16HBb+EUa0NxlyJbDTbRUJSGV6xcl2sUkO+b9xA1tcteZ
         kE4xcf4qAtxu+ZvDVFv6OUnvm2WuKr6H5Zk0Y26N+8UjC/Dh1ZosktrEV0alGZDuZAzp
         xmSlF2vf5rAlQF9o5tSrvz/IpWboDcrV66QOeb2d7d9hznArgM+WJwI7eI/8GgRge0wi
         qWiUu+8FqsMv/fRAtfP3XkQ/i7K33M36dADdpudayfMi988owv/SqJUleGXA2KWm6Zbv
         D8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642507; x=1685234507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlsvVMr5wJrguvOpjMRMDu7HLXIfjm1V1/lZO+i2wEY=;
        b=VB4EoNVkS0aURalAKxFb+11906k/MUFw0zCD1KlBtiuyupJqzPBgiPT7n/Izxw//42
         K8Tsdl1LQqcp5b1iMQIwI5lYC//OQqefFlVuTBMzRvCxKe00fG8AImEPFdqQi3Afgh3H
         9hIDq+tsJ97LJAqiMLkBt5tEeLKPhcx75V9qv3MF6h3iQfbMsXsYzKhRThoWsaQXWah6
         oAnWL9EtOGPky4TTDdsTtTaGhVfTkEFepH2FAV/QgLW9bjbb1ZDSRl2C8YRUhDNEv053
         0ank8Tton84LexqC5CmeA/AZiglMDojjfU0zjvrrgRnKts8bn5vzH1y5IrOYUip9D1qN
         h7Ng==
X-Gm-Message-State: AC+VfDwkd5leoCL1VkfqKtV31TGYQFQOCwosLJDsztrlk2u3PTErAaUP
        FqPWzQsUexRXTtlmq8+3GAIvpv648MBMWw==
X-Google-Smtp-Source: ACHHUZ6W1gTtUmt2zvgUtAGLFr+kDeiH7f4S+nefzbrb5wMoRtHw15HiLOJ2LVfoGQEoCXbFDUBF4Z+2JZW82A==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6a00:80de:b0:63b:234e:d641 with SMTP
 id ei30-20020a056a0080de00b0063b234ed641mr928248pfb.4.1682642506763; Thu, 27
 Apr 2023 17:41:46 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:33 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-2-jiaqiyan@google.com>
Subject: [RFC PATCH v1 1/7] hugetlb: add HugeTLB splitting functionality
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

The new function, hugetlb_split_to_shift, optimally splits the page
table to map a particular address at a paricular granularity. This
is useful for punching a hole in the mapping and for mapping (and
unmapping) small sections of a HugeTLB page.

Splitting is for present leaf HugeTLB PTE only. None HugeTLB PTEs
and other non-present HugeTLB PTE types are not supported as they
are better left untouched:
* None PTEs
* Migration PTEs
* HWPOISON PTEs
* UFFD writeprotect PTEs

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h |   9 ++
 mm/hugetlb.c            | 249 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 742e7f2cb170..d44bf6a794e5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1266,6 +1266,9 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 			      unsigned long end);
 int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 		     unsigned long end);
+int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
+			   struct hugetlb_pte *hpte, unsigned long addr,
+			   unsigned int desired_shift);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
@@ -1292,6 +1295,12 @@ int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 {
 	return -EINVAL;
 }
+int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
+			   const struct hugetlb_pte *hpte, unsigned long addr,
+			   unsigned int desired_shift)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index df4c17164abb..d3f3f1c2d293 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -8203,6 +8203,255 @@ int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 	return ret;
 }
 
+/*
+ * Find the optimal HugeTLB PTE shift that @desired_addr could be mapped at.
+ */
+static int hugetlb_find_shift(struct vm_area_struct *vma,
+			      unsigned long curr,
+			      unsigned long end,
+			      unsigned long desired_addr,
+			      unsigned long desired_shift,
+			      unsigned int *shift_found)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct hstate *tmp_h;
+	unsigned int shift;
+	unsigned long sz;
+
+	for_each_hgm_shift(h, tmp_h, shift) {
+		sz = 1UL << shift;
+		/* This sz is not aligned or too large. */
+		if (!IS_ALIGNED(curr, sz) || curr + sz > end)
+			continue;
+		/*
+		 * When desired_addr is in [curr, curr + sz),
+		 * we want shift to be as close to desired_shift
+		 * as possible.
+		 */
+		if (curr <= desired_addr && desired_addr < curr + sz
+		    && shift > desired_shift)
+			continue;
+
+		*shift_found = shift;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Given a particular address @addr and it is a present leaf HugeTLB PTE,
+ * split it so that the PTE that maps @addr is at @desired_shift.
+ */
+static int hugetlb_split_to_shift_present_leaf(struct mm_struct *mm,
+					       struct vm_area_struct *vma,
+					       pte_t old_entry,
+					       unsigned long start,
+					       unsigned long end,
+					       unsigned long addr,
+					       unsigned int orig_shift,
+					       unsigned int desired_shift)
+{
+	bool old_entry_dirty;
+	bool old_entry_write;
+	bool old_entry_uffd_wp;
+	pte_t new_entry;
+	unsigned long curr;
+	unsigned long sz;
+	unsigned int shift;
+	int ret = 0;
+	struct hugetlb_pte new_hpte;
+	struct page *subpage = NULL;
+	struct folio *folio = page_folio(compound_head(pte_page(old_entry)));
+	struct hstate *h = hstate_vma(vma);
+	spinlock_t *ptl;
+
+	/* Unmap original unsplit hugepage per huge_ptep_get_and_clear. */
+	hugetlb_remove_rmap(folio_page(folio, 0), orig_shift, h, vma);
+
+	old_entry_dirty = huge_pte_dirty(old_entry);
+	old_entry_write = huge_pte_write(old_entry);
+	old_entry_uffd_wp = huge_pte_uffd_wp(old_entry);
+
+	for (curr = start; curr < end; curr += sz) {
+		ret = hugetlb_find_shift(vma, curr, end, addr,
+					 desired_shift, &shift);
+
+		/* Unable to find a shift that works */
+		if (WARN_ON(ret))
+			goto abort;
+
+		/*
+		 * Do HGM full walk and allocate new page table structures
+		 * to continue to walk to the level we want.
+		 */
+		sz = 1UL << shift;
+		ret = hugetlb_full_walk_alloc(&new_hpte, vma, curr, sz);
+		if (WARN_ON(ret))
+			goto abort;
+
+		BUG_ON(hugetlb_pte_size(&new_hpte) > sz);
+		/*
+		 * When hugetlb_pte_size(new_hpte) is than sz, increment
+		 * curr by hugetlb_pte_size(new_hpte) to avoid skip over
+		 * some PTEs.
+		 */
+		if (hugetlb_pte_size(&new_hpte) < sz)
+			sz = hugetlb_pte_size(&new_hpte);
+
+		subpage = hugetlb_find_subpage(h, folio, curr);
+		/*
+		 * Creating a new (finer granularity) PT entry and
+		 * populate it with old_entry's bits.
+		 */
+		new_entry = make_huge_pte(vma, subpage,
+					  huge_pte_write(old_entry), shift);
+		if (old_entry_dirty)
+			new_entry = huge_pte_mkdirty(new_entry);
+		if (old_entry_write)
+			new_entry = huge_pte_mkwrite(new_entry);
+		if (old_entry_uffd_wp)
+			new_entry = huge_pte_mkuffd_wp(new_entry);
+		ptl = hugetlb_pte_lock(&new_hpte);
+		set_huge_pte_at(mm, curr, new_hpte.ptep, new_entry);
+		spin_unlock(ptl);
+		/* Increment ref/mapcount per set_huge_pte_at(). */
+		hugetlb_add_file_rmap(subpage, shift, h, vma);
+		folio_get(folio);
+	}
+	/*
+	 * This refcount decrement is for the huge_ptep_get_and_clear
+	 * on the hpte BEFORE splitting, for the same reason as
+	 * hugetlb_remove_rmap(), but we cannot do it at that time.
+	 * Now that splitting succeeded, the refcount can be decremented.
+	 */
+	folio_put(folio);
+	return 0;
+abort:
+	/*
+	 * Restore mapcount on unsplitted hugepage. No need to restore
+	 * refcount as we won't folio_put() until splitting succeeded.
+	 */
+	hugetlb_add_file_rmap(folio_page(folio, 0), orig_shift, h, vma);
+	return ret;
+}
+
+/*
+ * Given a particular address @addr, split the HugeTLB PTE that currently
+ * maps it so that, for the given @addr, the PTE that maps it is @desired_shift.
+ * The splitting is always done optimally.
+ *
+ * Example: given a HugeTLB 1G page mapped from VA 0 to 1G, if caller calls
+ * this API with addr=0 and desired_shift=PAGE_SHIFT, we will change the page
+ * table as follows:
+ * 1. The original PUD will be split into 512 2M PMDs first
+ * 2. The 1st PMD will further be split into 512 4K PTEs
+ *
+ * Callers are required to hold locks on the file mapping within vma.
+ */
+int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
+			   struct hugetlb_pte *hpte, unsigned long addr,
+			   unsigned int desired_shift)
+{
+	unsigned long start, end;
+	unsigned long desired_sz = 1UL << desired_shift;
+	int ret;
+	pte_t old_entry;
+	struct mmu_gather tlb;
+	struct mmu_notifier_range range;
+	spinlock_t *ptl;
+
+	BUG_ON(!hpte->ptep);
+
+	start = addr & hugetlb_pte_mask(hpte);
+	end = start + hugetlb_pte_size(hpte);
+	BUG_ON(!IS_ALIGNED(start, desired_sz));
+	BUG_ON(!IS_ALIGNED(end, desired_sz));
+	BUG_ON(addr < start || end <= addr);
+
+	if (hpte->shift == desired_shift)
+		return 0;
+
+	/*
+	 * Non none-mostly hugetlb PTEs must be present leaf-level PTE,
+	 * i.e. not split before.
+	 */
+	ptl = hugetlb_pte_lock(hpte);
+	BUG_ON(!huge_pte_none_mostly(huge_ptep_get(hpte->ptep)) &&
+	       !hugetlb_pte_present_leaf(hpte, huge_ptep_get(hpte->ptep)));
+
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, start, end);
+	mmu_notifier_invalidate_range_start(&range);
+
+	/*
+	 * Get and clear the PTE. We will allocate new page table structures
+	 * when walking the page table.
+	 */
+	old_entry = huge_ptep_get_and_clear(mm, start, hpte->ptep);
+	spin_unlock(ptl);
+
+	/*
+	 * From now on, any failure exit needs to go through "skip" to
+	 * put old_entry back. If any form of hugetlb_split_to_shift_xxx
+	 * is invoked, it also needs to go through "abort" to get rid of
+	 * the allocated PTEs created before splitting fails.
+	 */
+
+	if (unlikely(huge_pte_none_mostly(old_entry))) {
+		ret = -EAGAIN;
+		goto skip;
+	}
+	if (unlikely(!pte_present(old_entry))) {
+		if (is_hugetlb_entry_migration(old_entry))
+			ret = -EBUSY;
+		else if (is_hugetlb_entry_hwpoisoned(old_entry))
+			ret = -EHWPOISON;
+		else {
+			WARN_ONCE(1, "Unexpected case of non-present HugeTLB PTE\n");
+			ret = -EINVAL;
+		}
+		goto skip;
+	}
+
+	if (!hugetlb_pte_present_leaf(hpte, old_entry)) {
+		WARN_ONCE(1, "HugeTLB present PTE is not leaf\n");
+		ret = -EAGAIN;
+		goto skip;
+	}
+	/* From now on old_entry is present leaf entry. */
+	ret = hugetlb_split_to_shift_present_leaf(mm, vma, old_entry,
+						  start, end, addr,
+						  hpte->shift,
+						  desired_shift);
+	if (ret)
+		goto abort;
+
+	/* Splitting done, new page table entries successfully setup. */
+	mmu_notifier_invalidate_range_end(&range);
+	return 0;
+abort:
+	/* Splitting failed, restoring to the original page table state. */
+	tlb_gather_mmu(&tlb, mm);
+	/* Decrement mapcount for all the split PTEs. */
+	__unmap_hugepage_range(&tlb, vma, start, end, NULL, ZAP_FLAG_DROP_MARKER);
+	/*
+	 * Free any newly allocated page table entries.
+	 * Ok if no new entries allocated at all.
+	 */
+	hugetlb_free_pgd_range(&tlb, start, end, start, end);
+	/* Decrement refcount for all the split PTEs. */
+	tlb_finish_mmu(&tlb);
+skip:
+	/* Restore the old entry. */
+	ptl = hugetlb_pte_lock(hpte);
+	set_huge_pte_at(mm, start, hpte->ptep, old_entry);
+	spin_unlock(ptl);
+	mmu_notifier_invalidate_range_end(&range);
+	return ret;
+}
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
-- 
2.40.1.495.gc816e09b53d-goog

