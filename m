Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521596F0FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbjD1Aly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD1Alu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:41:50 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AF210E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:49 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24736839649so5120970a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642508; x=1685234508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bYeQzrUNDYZNhkuugE6jf2Akn1BdGdutTjwyn1e4o8=;
        b=3F224aKzgYOc/AvfHDwiitWzc6njaindjq7TzzaiPro6lvt8bS0DSSV6QcWa4f2xh7
         OCnqi82Pv2zBPGZRbSpyfGekXLluJqCZbi0SwBFNzDNX1eKvR5Qfu8UGApuRJSegTD23
         Wf2t/MaVERhWf96SaiPu5FGxffT+fMBXn6u0g35bMo7NXOc0+4rjPu9+Py3aLIXOJajh
         UJQg241cRBfw3XHvvrB95hKTnaifEYCXS1lCQau+Z9JvPKFx1KSnltCBZWdCG+eStjbn
         Omnk245IfYkhnNTfMfBDS7p3Nby60Fh1QgneJKJYHONxX26YbbNS96JQhxWa0+pZZPH8
         XV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642508; x=1685234508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bYeQzrUNDYZNhkuugE6jf2Akn1BdGdutTjwyn1e4o8=;
        b=cX0jlZHjFB6FIxTeEuZijvNruZH1F/yEIs9rFkCBcR66XXEK1vL9AiDjN6XXEkduIu
         kD6PJ43JM9EQHMuVNXOgz82HBu3augtiW5oZeZkJfUbVx2sfDc3038Dm21jXR+nEkDx6
         c87vZxtldCt3+uplSgYPavQHruZcSuHZmnoRxSyP8eDP1JB2MvW2QZf4TVioPMCFvFs7
         1EiVDdh7uYDsaTYS6gGKQfEciUeHP5H2U4oItMlNuW8byi3quYLIg0EOTijEeYE0eFo3
         kqHD13DyzD7fJYUn1e9zI1r2p8+JoHtJx3aOlQ0vjk8FVI0hXztIuXFwdy8wtS8FFKB/
         G80w==
X-Gm-Message-State: AC+VfDxeJSSl6VenFNdEMQKYY5Dv1v/ERSbSfrw9qRcsvpFZz34kHRRu
        o+WhN2xP97fmCyNNNa4dvV5A3dSIJQP7KA==
X-Google-Smtp-Source: ACHHUZ5+4VboIN/jABrhB8fFk35/7s+Bqip+YL9U3H3a9Ag2csktvsv65xDsOQoeBdKjAUSnnyd2diBmQx0p/A==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:90a:304b:b0:247:1639:9650 with SMTP
 id q11-20020a17090a304b00b0024716399650mr1011181pjl.2.1682642508523; Thu, 27
 Apr 2023 17:41:48 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:34 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-3-jiaqiyan@google.com>
Subject: [RFC PATCH v1 2/7] hugetlb: create PTE level mapping when possible
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

In memory_failure handling, for each VMA that the HWPOISON HugeTLB
page mapped to, enable HGM if eligible, then split the P*D mapped
hugepage to smaller PTEs. try_to_unmap still unmaps the entire hugetlb
page, one PTE by one PTE, at levels smaller than original P*D.
For example, if a hugepage was original mapped at PUD size, it will
be split into PMDs and PTEs, and all of these PMDs and PTEs will
be unmapped. The next commit will only unmap the raw HWPOISON PTE.

For VMA that is not HGM eligible, or failed to enable HGM, or
failed to split hugepage mapping, the hugepage is still mapped by
its original P*D then unmapped at this P*D.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h |  5 +++
 mm/hugetlb.c            | 27 ++++++++++++++++
 mm/memory-failure.c     | 68 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d44bf6a794e5..03074b23c396 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1266,6 +1266,7 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 			      unsigned long end);
 int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 		     unsigned long end);
+int hugetlb_enable_hgm_vma(struct vm_area_struct *vma);
 int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
 			   struct hugetlb_pte *hpte, unsigned long addr,
 			   unsigned int desired_shift);
@@ -1295,6 +1296,10 @@ int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 {
 	return -EINVAL;
 }
+int hugetlb_enable_hgm_vma(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
 int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
 			   const struct hugetlb_pte *hpte, unsigned long addr,
 			   unsigned int desired_shift)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d3f3f1c2d293..1419176b7e51 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -8203,6 +8203,33 @@ int hugetlb_collapse(struct mm_struct *mm, unsigned long start,
 	return ret;
 }
 
+int hugetlb_enable_hgm_vma(struct vm_area_struct *vma)
+{
+	if (hugetlb_hgm_enabled(vma))
+		return 0;
+
+	if (!is_vm_hugetlb_page(vma)) {
+		pr_warn("VMA=[%#lx, %#lx) is not HugeTLB\n",
+			vma->vm_start, vma->vm_end);
+		return -EINVAL;
+	}
+
+	if (!hugetlb_hgm_eligible(vma)) {
+		pr_warn("VMA=[%#lx, %#lx) is not HGM eligible\n",
+			vma->vm_start, vma->vm_end);
+		return -EINVAL;
+	}
+
+	hugetlb_unshare_all_pmds(vma);
+
+	/*
+	 * TODO: add the ability to tell if HGM is enabled by kernel
+	 * (for HWPOISON unmapping) or by userspace (via MADV_SPLIT).
+	 */
+	vm_flags_set(vma, VM_HUGETLB_HGM);
+	return 0;
+}
+
 /*
  * Find the optimal HugeTLB PTE shift that @desired_addr could be mapped at.
  */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0b37cbc6e8ae..eb5579b6787e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1479,6 +1479,73 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+/*
+ * For each HGM-eligible VMA that the poisoned page mapped to, create new
+ * HGM mapping for hugepage @folio and make sure @poisoned_page is mapped
+ * by a PAGESIZE level PTE. Caller (hwpoison_user_mappings) must ensure
+ * 1. folio's address space (mapping) is locked in write mode.
+ * 2. folio is locked.
+ */
+static void try_to_split_huge_mapping(struct folio *folio,
+				      struct page *poisoned_page)
+{
+	struct address_space *mapping = folio_mapping(folio);
+	pgoff_t pgoff_start;
+	pgoff_t pgoff_end;
+	struct vm_area_struct *vma;
+	unsigned long poisoned_addr;
+	unsigned long head_addr;
+	struct hugetlb_pte hpte;
+
+	if (WARN_ON(!mapping))
+		return;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	pgoff_start = folio_pgoff(folio);
+	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
+
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff_start, pgoff_end) {
+		/* Enable HGM on HGM-eligible VMAs. */
+		if (!hugetlb_hgm_eligible(vma))
+			continue;
+
+		i_mmap_assert_locked(vma->vm_file->f_mapping);
+		if (hugetlb_enable_hgm_vma(vma)) {
+			pr_err("Failed to enable HGM on eligible VMA=[%#lx, %#lx)\n",
+				vma->vm_start, vma->vm_end);
+			continue;
+		}
+
+		poisoned_addr = vma_address(poisoned_page, vma);
+		head_addr = vma_address(folio_page(folio, 0), vma);
+		/*
+		 * Get the hugetlb_pte of the PUD-mapped hugepage first,
+		 * then split the PUD entry into PMD + PTE entries.
+		 *
+		 * Both getting original huge PTE and splitting requires write
+		 * lock on vma->vm_file->f_mapping, which caller
+		 * (e.g. hwpoison_user_mappings) should already acquired.
+		 */
+		if (hugetlb_full_walk(&hpte, vma, head_addr))
+			continue;
+
+		if (hugetlb_split_to_shift(vma->vm_mm, vma, &hpte,
+					   poisoned_addr, PAGE_SHIFT)) {
+			pr_err("Failed to split huge mapping: pfn=%#lx, vaddr=%#lx in VMA=[%#lx, %#lx)\n",
+				page_to_pfn(poisoned_page), poisoned_addr,
+				vma->vm_start, vma->vm_end);
+		}
+	}
+}
+#else
+static void try_to_split_huge_mapping(struct folio *folio,
+				      struct page *poisoned_page)
+{
+}
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+
 /*
  * Do all that is necessary to remove user space mappings. Unmap
  * the pages and send SIGBUS to the processes if the data was dirty.
@@ -1555,6 +1622,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		 */
 		mapping = hugetlb_page_mapping_lock_write(hpage);
 		if (mapping) {
+			try_to_split_huge_mapping(folio, p);
 			try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
 			i_mmap_unlock_write(mapping);
 		} else
-- 
2.40.1.495.gc816e09b53d-goog

