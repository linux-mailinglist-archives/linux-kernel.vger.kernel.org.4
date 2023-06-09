Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7EB728D14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjFIB3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjFIB33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:29:29 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062011FDA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:29:28 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-568af2f6454so11394447b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274167; x=1688866167;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEXGzvow+PeeAaek8TvLjmsJIBTHvkDkqgMD7Fw0vH4=;
        b=1iKYEdXQU7GyBWXXdTJ/eTNQaKjM8A5uGEtCPlSPe50PEEnGNTaKjIFQd2nLJWOfvh
         tPsKmHoib44kj+JEUNUeUUirOK6gcFjvoUWHBf5F5sWsiABdMBGtAthxe2WU9qh7noM4
         Zh/iyBIZbzHd4k5pq9B8glalrk6L5lYQzkgizx3QlltAhP4mUsNeTxTjLywFtxVFGNvZ
         jIQGXg/oBKKP81SqRx4Caj2rWxiav0FLHH/NmIS/432ybPMUtKQi+Yq1y0GkDZpiwhGe
         kNBiMEtti/dkcWXs/faQIjCPcs483ukabcMmUPTpwrdxz/Ln2gtVt+7567CoyLJvwmZM
         3ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274167; x=1688866167;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEXGzvow+PeeAaek8TvLjmsJIBTHvkDkqgMD7Fw0vH4=;
        b=ZRju5wkJJWZ3s7e6hUU+c9N6VeJKetfQFe2iqqMh2BuG3RexTITlhVFdaWp8fl+aQs
         hAny+zjZHiSrnxwQRqxQoaPozTShANerPDllHi14awqRhco3oYx2aJO/KZOwsk8olkl+
         aXLKZiZbS+rdsBeFouxDNOdVj0tUzzPX8hSb9sgD+AoUjIJV3X+XdJtEi3160uvrJehn
         gXDr/fkq5BXN0xVk9YbV4KMWYWx3P3DDMGDMgREkiL5Ad6D0MN1jruC5Lr3c/g/Iwt6m
         WCDTF/bCKndWpSN/eFC3WSKuhvoSIHeW9p7SH8LDFDVJUBkIby+oYo4GWSNyh8pBoeiH
         Fv5Q==
X-Gm-Message-State: AC+VfDx7Fa0CdqRi/eKMqd2c7LXzIv0JF/d65VBjeNd18pqUYxLwuRud
        wh4A3KsVvzaxyzRAii13siA/gA==
X-Google-Smtp-Source: ACHHUZ7s1itVLKfUVkBt3mJsfUoKC8ShOR4DXlaWFBNzOobINfIUYkdb8mmHGFUq5qbj4FXPU58kgA==
X-Received: by 2002:a0d:e8ce:0:b0:561:be2a:43f9 with SMTP id r197-20020a0de8ce000000b00561be2a43f9mr1268402ywe.41.1686274167029;
        Thu, 08 Jun 2023 18:29:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i130-20020a815488000000b00561e2cb2d3bsm300434ywb.23.2023.06.08.18.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:29:26 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:29:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 17/32] mm/various: give up if pte_offset_map[_lock]()
 fails
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <7b9bd85d-1652-cbf2-159d-f503b45e5b@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the examples of nearby code, various functions can just give
up if pte_offset_map() or pte_offset_map_lock() fails.  And there's no
need for a preliminary pmd_trans_unstable() or other such check, since
such cases are now safely handled inside.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/gup.c            | 9 ++++++---
 mm/ksm.c            | 7 ++++---
 mm/memcontrol.c     | 8 ++++----
 mm/memory-failure.c | 8 +++++---
 mm/migrate.c        | 3 +++
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3bd5d3854c51..bb67193c5460 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -544,10 +544,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
-	if (unlikely(pmd_bad(*pmd)))
-		return no_page_table(vma, flags);
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!ptep)
+		return no_page_table(vma, flags);
 	pte = *ptep;
 	if (!pte_present(pte))
 		goto no_page;
@@ -851,8 +851,9 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return -EFAULT;
-	VM_BUG_ON(pmd_trans_huge(*pmd));
 	pte = pte_offset_map(pmd, address);
+	if (!pte)
+		return -EFAULT;
 	if (pte_none(*pte))
 		goto unmap;
 	*vma = get_gate_vma(mm);
@@ -2377,6 +2378,8 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
+	if (!ptep)
+		return 0;
 	do {
 		pte_t pte = ptep_get_lockless(ptep);
 		struct page *page;
diff --git a/mm/ksm.c b/mm/ksm.c
index df2aa281d49d..3dc15459dd20 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -431,10 +431,9 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
 	pte_t *pte;
 	int ret;
 
-	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
-		return 0;
-
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	if (pte_present(*pte)) {
 		page = vm_normal_page(walk->vma, addr, *pte);
 	} else if (!pte_none(*pte)) {
@@ -1203,6 +1202,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	mmu_notifier_invalidate_range_start(&range);
 
 	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto out_mn;
 	if (!pte_same(*ptep, orig_pte)) {
 		pte_unmap_unlock(ptep, ptl);
 		goto out_mn;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..fdd953655fe1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6057,9 +6057,9 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
-		return 0;
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
 			mc.precharge++;	/* increment precharge temporarily */
@@ -6277,10 +6277,10 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
-		return 0;
 retry:
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; addr += PAGE_SIZE) {
 		pte_t ptent = *(pte++);
 		bool device = false;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b663eca1f29..b3cc8f213fe3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -414,6 +414,8 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	if (pmd_devmap(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
+	if (!pte)
+		return 0;
 	if (pte_present(*pte) && pte_devmap(*pte))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
@@ -800,11 +802,11 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmdp))
-		goto out;
-
 	mapped_pte = ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp,
 						addr, &ptl);
+	if (!ptep)
+		goto out;
+
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
 					     hwp->pfn, &hwp->tk);
diff --git a/mm/migrate.c b/mm/migrate.c
index 3ecb7a40075f..308a56f0b156 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -305,6 +305,9 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	swp_entry_t entry;
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!ptep)
+		return;
+
 	pte = *ptep;
 	pte_unmap(ptep);
 
-- 
2.35.3

