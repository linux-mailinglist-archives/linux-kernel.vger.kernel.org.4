Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4588728D2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbjFIBi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjFIBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:38:25 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF918C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:38:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b2993c9652so261143a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274702; x=1688866702;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiDluOv2NKQXWITQOVsUWe3sj/TRHmtPFYOGjZ2ttyw=;
        b=T0KllypmaI6dTB7DB6gV+sXkQkzh1ghuQsJWEK3jBazIFUwKZcsQ3r5kr988Onz36X
         Dex8mQRK1D2tkuguCbuqQKOnDZrak1tNbdPv9EQlJylAGS/JOPCnfCNAKd3nfZKgjEDX
         NyjKhyt6lzb+I77gA/PrGWpgqss/Ipf03liz3QsE5ZInJrgAzICnzUTYMrBYboMu8+Ko
         Te1BCCl46W+vNegr6tum9ZNWdColvrZcB8P0b/1QpqOrN9yiBM3NUya9DmMuMuxFqXqJ
         gRuJjfPoEiaWO0bbttWGNF01oOM4LC9iGoxIWBtycc73x4aBvX+fDbj/NGV2UJ/71lCf
         Nnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274702; x=1688866702;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiDluOv2NKQXWITQOVsUWe3sj/TRHmtPFYOGjZ2ttyw=;
        b=d8ZvJRiEINg5LtWCaKk1ndGwufvihXUWXmJyI14yAy8mzulU4+PO2F4Fo+E62dYYAF
         vsZGnqMgFeDvfC+jXwMen858VHC8tQ3AW1QhYkrn32P6QfNJKwyYfmhQ2MhD458GMhz3
         S/ZdnTljEou88FbVrAUOnkNGzmAHi5B+giz0XmXhvlgSJXWnshuVAxSO+I8UP/b2PJkQ
         mD34YafQqbH3vAP/ZMOOP8dN7NIkI2vBzrVHqQIkGzzcMUl9yk9k6s8a5MLyFVouE/9G
         BUHzY7uxww8BCf0rWMZmT/kRatZVMR6MZrJJqTeo7t8ES7fWlsEnaKOphFQuB4oDGICS
         AXMw==
X-Gm-Message-State: AC+VfDyG6+7/obxGJUuvdGneQX/SY2C93wk4q6m8n3ZL2JqWavQuxdyX
        lxpHFTabjCF9P1KfLhh5Ir9OHw==
X-Google-Smtp-Source: ACHHUZ4lATUYWdzZUuFyIeEB4NQ1kndPyTKKCxuz2TahCj6Q7NKx5y9YMV8W26QVvIO6910YNrrjBg==
X-Received: by 2002:a05:6830:cb:b0:6b1:570c:de5 with SMTP id x11-20020a05683000cb00b006b1570c0de5mr88477oto.17.1686274701910;
        Thu, 08 Jun 2023 18:38:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y7-20020a056902052700b00b8f13ff2a8esm586262ybs.61.2023.06.08.18.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:38:21 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:38:17 -0700 (PDT)
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
Subject: [PATCH v2 24/32] mm/migrate_device: allow pte_offset_map_lock() to
 fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <1131be62-2e84-da2f-8f45-807b2cbeeec5@google.com>
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

migrate_vma_collect_pmd(): remove the pmd_trans_unstable() handling after
splitting huge zero pmd, and the pmd_none() handling after successfully
splitting huge page: those are now managed inside pte_offset_map_lock(),
and by "goto again" when it fails.

But the skip after unsuccessful split_huge_page() must stay: it avoids an
endless loop.  The skip when pmd_bad()?  Remove that: it will be treated
as a hole rather than a skip once cleared by pte_offset_map_lock(), but
with different timing that would be so anyway; and it's arguably best to
leave the pmd_bad() handling centralized there.

migrate_vma_insert_page(): remove comment on the old pte_offset_map()
and old locking limitations; remove the pmd_trans_unstable() check and
just proceed to pte_offset_map_lock(), aborting when it fails (page has
been charged to memcg, but as in other cases, it's uncharged when freed).

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
---
 mm/migrate_device.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..a14af6b12b04 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -83,9 +83,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmdp, addr);
-			if (pmd_trans_unstable(pmdp))
-				return migrate_vma_collect_skip(start, end,
-								walk);
 		} else {
 			int ret;
 
@@ -100,16 +97,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (ret)
 				return migrate_vma_collect_skip(start, end,
 								walk);
-			if (pmd_none(*pmdp))
-				return migrate_vma_collect_hole(start, end, -1,
-								walk);
 		}
 	}
 
-	if (unlikely(pmd_bad(*pmdp)))
-		return migrate_vma_collect_skip(start, end, walk);
-
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
@@ -595,27 +588,10 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-
 	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
 		goto abort;
-
-	/*
-	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
-	 * pte_offset_map() on pmds where a huge pmd might be created
-	 * from a different thread.
-	 *
-	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
-	 * parallel threads are excluded by other means.
-	 *
-	 * Here we only have mmap_read_lock(mm).
-	 */
 	if (pte_alloc(mm, pmdp))
 		goto abort;
-
-	/* See the comment in pte_alloc_one_map() */
-	if (unlikely(pmd_trans_unstable(pmdp)))
-		goto abort;
-
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
 	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
@@ -650,7 +626,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
-
+	if (!ptep)
+		goto abort;
 	if (check_stable_address_space(mm))
 		goto unlock_abort;
 
-- 
2.35.3

