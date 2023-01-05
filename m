Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1165E8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAEKU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjAEKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D8E52753
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-47ede4426e1so257847787b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXjDdGeof+pkTOexvpTub2FYR/fAsSt0/calmVQ1OdU=;
        b=XCDU0evHwnZkmMXLipslFPIAImW1wnD5gg1yPSGJZCiJT1xNPXMtFtNvS/kZpXrh6h
         /YzmZN/osO/uOmKFuvSiBStVwQ/r8eUxfoBViWLdx/V5nbPmzEDvLxPqD88BhVRIk6gx
         BdYsxNiAVkM52/C8UupP5zDev9GYfWWEQNeFa2R3dl6z5oPntfdNRseZqzzslEjMFOLL
         US6rpYr3YdIccRX77RBQrSex+xbAKFESNnT8PrAfGIQxncDhYiZquJomS8iN2RA/dlmE
         I/ng9bMh5yIaNqpp0R/MRqgY3ugfYkSYOlYkBPLzLzHOxuzNSoTLFIrbRaCLRi+7kJln
         BAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXjDdGeof+pkTOexvpTub2FYR/fAsSt0/calmVQ1OdU=;
        b=Qq24O2ptzRSXv5u+Qyse61T3GPupfRQAlKYudOaF9YsT8ENby5FHyRj0VunlEaBM7+
         gS7JahBVWsQjjhr7PSLsacolvUQ7bh4Lg5u3qb6xRYd9OFp4Z/2u0mziA6/TwO/NzBaB
         Pd1KhT+N2SAloDfx5FaV5hev5PNRZHnkjnMf308o5xoS9b2d1TcHtu8mTNVvlmDn52Ah
         tLM2mKA+9KTh9nNJc+5wlFHDtnevFawmx0ve52EgA7WSjmtimJw8VHt6DyjIZOXcIGoS
         jjfVYihTPlLkY6zwBUBPw5hoPKMayDgpcALk6Nr4ojIbjGaKgkO8byyvE8+FTpE7Gg00
         N9Bw==
X-Gm-Message-State: AFqh2kqERsLAUdtsEYDZzWouLnWR5t999I987+yeStfLCtbWFPm9E4sZ
        kTJEQb/+FoCImonay46G1LyhpyGNNmdSwNh0
X-Google-Smtp-Source: AMrXdXvYDZWYkFpM6Bavubt5Vuec9lD7DHb7hBD7HW0U1DxPG0tR0i3mLWWTosVSiS0INVOOwY+3Lu37HfMNvQD7
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:c054:0:b0:725:2e78:3fd3 with SMTP
 id c81-20020a25c054000000b007252e783fd3mr3300724ybf.41.1672913951341; Thu, 05
 Jan 2023 02:19:11 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:10 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-13-jthoughton@google.com>
Subject: [PATCH 12/46] hugetlb: add hugetlb_alloc_pmd and hugetlb_alloc_pte
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

These functions are used to allocate new PTEs below the hstate PTE. This
will be used by hugetlb_walk_step, which implements stepping forwards in
a HugeTLB high-granularity page table walk.

The reasons that we don't use the standard pmd_alloc/pte_alloc*
functions are:
 1) This prevents us from accidentally overwriting swap entries or
    attempting to use swap entries as present non-leaf PTEs (see
    pmd_alloc(); we assume that !pte_none means pte_present and
    non-leaf).
 2) Locking hugetlb PTEs can different than regular PTEs. (Although, as
    implemented right now, locking is the same.)
 3) We can maintain compatibility with CONFIG_HIGHPTE. That is, HugeTLB
    HGM won't use HIGHPTE, but the kernel can still be built with it,
    and other mm code will use it.

When GENERAL_HUGETLB supports P4D-based hugepages, we will need to
implement hugetlb_pud_alloc to implement hugetlb_walk_step.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |   5 ++
 mm/hugetlb.c            | 114 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bf441d8a1b52..ad9d19f0d1b9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -86,6 +86,11 @@ unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
 
 bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
 
+pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr);
+pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr);
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2d83a2c359a2..2160cbaf3311 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -480,6 +480,120 @@ static bool has_same_uncharge_info(struct file_region *rg,
 #endif
 }
 
+/*
+ * hugetlb_alloc_pmd -- Allocate or find a PMD beneath a PUD-level hpte.
+ *
+ * This is meant to be used to implement hugetlb_walk_step when one must go to
+ * step down to a PMD. Different architectures may implement hugetlb_walk_step
+ * differently, but hugetlb_alloc_pmd and hugetlb_alloc_pte are architecture-
+ * independent.
+ *
+ * Returns:
+ *	On success: the pointer to the PMD. This should be placed into a
+ *		    hugetlb_pte. @hpte is not changed.
+ *	ERR_PTR(-EINVAL): hpte is not PUD-level
+ *	ERR_PTR(-EEXIST): there is a non-leaf and non-empty PUD in @hpte
+ *	ERR_PTR(-ENOMEM): could not allocate the new PMD
+ */
+pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
+	pmd_t *new;
+	pud_t *pudp;
+	pud_t pud;
+
+	if (hpte->level != HUGETLB_LEVEL_PUD)
+		return ERR_PTR(-EINVAL);
+
+	pudp = (pud_t *)hpte->ptep;
+retry:
+	pud = READ_ONCE(*pudp);
+	if (likely(pud_present(pud)))
+		return unlikely(pud_leaf(pud))
+			? ERR_PTR(-EEXIST)
+			: pmd_offset(pudp, addr);
+	else if (!pud_none(pud))
+		/*
+		 * Not present and not none means that a swap entry lives here,
+		 * and we can't get rid of it.
+		 */
+		return ERR_PTR(-EEXIST);
+
+	new = pmd_alloc_one(mm, addr);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(ptl);
+	if (!pud_same(pud, *pudp)) {
+		spin_unlock(ptl);
+		pmd_free(mm, new);
+		goto retry;
+	}
+
+	mm_inc_nr_pmds(mm);
+	smp_wmb(); /* See comment in pmd_install() */
+	pud_populate(mm, pudp, new);
+	spin_unlock(ptl);
+	return pmd_offset(pudp, addr);
+}
+
+/*
+ * hugetlb_alloc_pte -- Allocate a PTE beneath a pmd_none PMD-level hpte.
+ *
+ * See the comment above hugetlb_alloc_pmd.
+ */
+pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
+	pgtable_t new;
+	pmd_t *pmdp;
+	pmd_t pmd;
+
+	if (hpte->level != HUGETLB_LEVEL_PMD)
+		return ERR_PTR(-EINVAL);
+
+	pmdp = (pmd_t *)hpte->ptep;
+retry:
+	pmd = READ_ONCE(*pmdp);
+	if (likely(pmd_present(pmd)))
+		return unlikely(pmd_leaf(pmd))
+			? ERR_PTR(-EEXIST)
+			: pte_offset_kernel(pmdp, addr);
+	else if (!pmd_none(pmd))
+		/*
+		 * Not present and not none means that a swap entry lives here,
+		 * and we can't get rid of it.
+		 */
+		return ERR_PTR(-EEXIST);
+
+	/*
+	 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
+	 * in page tables being allocated in high memory, needing a kmap to
+	 * access. Instead, we call __pte_alloc_one directly with
+	 * GFP_PGTABLE_USER to prevent these PTEs being allocated in high
+	 * memory.
+	 */
+	new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(ptl);
+	if (!pmd_same(pmd, *pmdp)) {
+		spin_unlock(ptl);
+		pgtable_pte_page_dtor(new);
+		__free_page(new);
+		goto retry;
+	}
+
+	mm_inc_nr_ptes(mm);
+	smp_wmb(); /* See comment in pmd_install() */
+	pmd_populate(mm, pmdp, new);
+	spin_unlock(ptl);
+	return pte_offset_kernel(pmdp, addr);
+}
+
 static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 {
 	struct file_region *nrg, *prg;
-- 
2.39.0.314.g84b9a713c41-goog

