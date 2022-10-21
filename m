Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A4607C69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJUQiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiJUQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:32 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EE277A0D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:28 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id h8-20020a056102104800b003a7cdc977c4so1052363vsq.21
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBshBOuvfy/W1BjcC6heQpMSQfDF2AIsZyDOsSW4TwI=;
        b=P3qv/MTBLsES5DUqVSKD8A/FOo67uH/5QWjk7bZ+AuC2vtVepaPv7nXDMe6jBJdGnF
         wl5tbLBKoSRJgFze6Rqcla+5Wu3Y/4rq+qR1z//VWWhDq0hfdl1Bqviwajdis7GX6dZJ
         M+ZE1jHFudjivAP+u9jN3zLgWg43Li5LR/f+WX7fNKTL12loHBOO3vplCGTU1vujjFPN
         SEUF2jc3R6lL4b97sxviNu/EraGla9thkJDq4ogtS6wyKOHp0XSnD3L/ikmoBB4oGubq
         FmBAKVQpWv//kqqkvT5yrCIh6Yo6KqBzzodM7qpeTlTRCCK5jlC7slq4si+uHRhLiq/Z
         jmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBshBOuvfy/W1BjcC6heQpMSQfDF2AIsZyDOsSW4TwI=;
        b=8KNC5gInjL4MKrMhH/PzeaettF1tSbiumK42hY9OTuETW5k2OIxywTya977DNT5Mdy
         hOjpleQvXZJtKw/u4P1zC8SLUABd244jaojtJXh0G5payTtKl/QcpvH+VuRlN5sPxkoG
         43BKCyJaaat+Rm3V1OXFoUUkuQ6IYcbz3lbKYgiAk6DOOl9QmW1cKfZaHthHQEPc3t7t
         69+ylKfeAg70s89Z5lAhGegqzAQnCsFC7stlkK6WpqkaYSz7+LvBoAmMNk43q4T+hqTI
         xCJBq8a69UBrUiaOP5HlFGJkIZVLGJgMt8dWUOjazLQZhYWcMwv74bgNDFCGqPuaEdbr
         1IDQ==
X-Gm-Message-State: ACrzQf0mTFweZBjsNIiwd/FMUAEYQzTOouIggp9RucKzznyJK43OgzxZ
        kB2OSFzESnjc8XuRku7BARut1mXeJn/8GYs/
X-Google-Smtp-Source: AMsMyM4Vh7NfINhYVI9VNbRp8uXsxB4z8lmQPmQVUZspSIfA3zXevP+3q84mKE9ZQnNKvownRcHvr2VDIrpSXS5f
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:b99:0:b0:3c2:b377:61e1 with SMTP id
 c25-20020ab00b99000000b003c2b37761e1mr13835270uak.2.1666370246908; Fri, 21
 Oct 2022 09:37:26 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:27 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-12-jthoughton@google.com>
Subject: [RFC PATCH v2 11/47] hugetlb: add hugetlb_pmd_alloc and hugetlb_pte_alloc
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
 include/linux/hugetlb.h |  5 +++
 mm/hugetlb.c            | 94 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d30322108b34..003255b0e40f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -119,6 +119,11 @@ void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
 
 bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
 
+pmd_t *hugetlb_pmd_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr);
+pte_t *hugetlb_pte_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr);
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a0e46d35dabc..e3733388adee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -341,6 +341,100 @@ static bool has_same_uncharge_info(struct file_region *rg,
 #endif
 }
 
+pmd_t *hugetlb_pmd_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
+	pmd_t *new;
+	pud_t *pudp;
+	pud_t pud;
+
+	if (hpte->level != HUGETLB_LEVEL_PUD)
+		return ERR_PTR(-EINVAL);
+
+	pudp = (pud_t *)hpte->ptep;
+retry:
+	pud = *pudp;
+	if (likely(pud_present(pud)))
+		return unlikely(pud_leaf(pud))
+			? ERR_PTR(-EEXIST)
+			: pmd_offset(pudp, addr);
+	else if (!huge_pte_none(huge_ptep_get(hpte->ptep)))
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
+pte_t *hugetlb_pte_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		unsigned long addr)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
+	pgtable_t new;
+	pmd_t *pmdp;
+	pmd_t pmd;
+
+	if (hpte->level != HUGETLB_LEVEL_PMD)
+		return ERR_PTR(-EINVAL);
+
+	pmdp = (pmd_t *)hpte->ptep;
+retry:
+	pmd = *pmdp;
+	if (likely(pmd_present(pmd)))
+		return unlikely(pmd_leaf(pmd))
+			? ERR_PTR(-EEXIST)
+			: pte_offset_kernel(pmdp, addr);
+	else if (!huge_pte_none(huge_ptep_get(hpte->ptep)))
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
2.38.0.135.g90850a2211-goog

