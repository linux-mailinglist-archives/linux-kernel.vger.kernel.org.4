Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49A6B7774
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCMM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCMM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:29:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BAA37559
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:29:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso4731385wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678710566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4VVQpoDamLm4iSGgyTcxUJbskifYCP8YkUsAdfGEbg=;
        b=ilW4Issw6poGCbNjTVwFmlU0lWsgBygyLFZDLIyAyzoED7YxH86wCNwJyFwB/D6xUU
         i43HaZVbGctnUi7RkD3A+4ljGakIHdDb/lJavivGXLYBKSjvhHTpgvqe5yV74BIYhh3O
         DwiEgpvhf3nuo5LNAzMzgCNXtKey5v8xYZ7EKExLGhzaK78bhsck0/p/U2GHElcMM7fi
         vQSnAUhXntO+8kUsUlRZKjHaYdM3fvHpX3DgdLfZp94I9x/c5lXOe1wFduWc74TdVOJm
         4lP56ZLBt+uh1R6XgySYJ/T9QCE9qSFUn8JUa7/0LJefGPEyluBfp7SPdKEvEXGUMaVF
         sOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4VVQpoDamLm4iSGgyTcxUJbskifYCP8YkUsAdfGEbg=;
        b=n5tMkr4uYqGauUB1/dyuXKpxxOyflVqnCaH5L5Svlf+bdFLTRvReYgN8hs3R+YcQ8B
         WXsR0Htu6+9R5B6wSSo4CilvK9ep24vSkftTrZwSVK6yw47yH+10EvUkcB52pzrBtlEs
         n+f1Nks/xJvCLexGS4BunJxywekKqcH4ihdZ7Awuh0kFmrP0sMg4vFNAvDb196oN6rmm
         AspeAbU4wwbOZqBL5b3aqzIdzSke9lYHpz+TS+0DjU8BViEfYN+tFiHEOuhI48D68OY7
         g2RxXn0c0crq42yDQZUMDGVEJz+A6wD3EMleepihJABk8EIv3U2hWGRyOUwtDGnh87I5
         aZAA==
X-Gm-Message-State: AO0yUKV/+rFfyRwT/AeytIh0umBc7P7wpcZy2FYj5KorwDBJFr6oSBXa
        H3Wr07+IWCVAjMZyFkrUAbLozctak6I=
X-Google-Smtp-Source: AK7set/gaQp/O/t0O7Ep564CIWvNM8VYVfB7hjofaZjtq9xS+1OFwnb37Wvi1GwJby9ax+AWtLf3bQ==
X-Received: by 2002:a05:600c:3107:b0:3dc:55d9:ec8 with SMTP id g7-20020a05600c310700b003dc55d90ec8mr9958755wmo.41.1678710566134;
        Mon, 13 Mar 2023 05:29:26 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id p9-20020a05600c23c900b003ed23e9e03bsm3512317wmb.46.2023.03.13.05.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 05:29:25 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm: prefer xxx_page() alloc/free functions for order-0 pages
Date:   Mon, 13 Mar 2023 12:27:14 +0000
Message-Id: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update instances of alloc_pages(..., 0), __get_free_pages(..., 0) and
__free_pages(..., 0) to use alloc_page(), __get_free_page() and
__free_page() respectively in core code.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/asm-generic/pgalloc.h | 4 ++--
 mm/debug_vm_pgtable.c         | 4 ++--
 mm/hugetlb_vmemmap.c          | 2 +-
 mm/mmu_gather.c               | 2 +-
 mm/page_alloc.c               | 2 +-
 mm/vmalloc.c                  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 977bea16cf1b..a7cf825befae 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -123,11 +123,11 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)

 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	page = alloc_pages(gfp, 0);
+	page = alloc_page(gfp);
 	if (!page)
 		return NULL;
 	if (!pgtable_pmd_page_ctor(page)) {
-		__free_pages(page, 0);
+		__free_page(page);
 		return NULL;
 	}
 	return (pmd_t *)page_address(page);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 7887cc2b75bf..4362021b1ce7 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1048,7 +1048,7 @@ static void __init destroy_args(struct pgtable_debug_args *args)

 	if (args->pte_pfn != ULONG_MAX) {
 		page = pfn_to_page(args->pte_pfn);
-		__free_pages(page, 0);
+		__free_page(page);

 		args->pte_pfn = ULONG_MAX;
 	}
@@ -1290,7 +1290,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 		}
 	}

-	page = alloc_pages(GFP_KERNEL, 0);
+	page = alloc_page(GFP_KERNEL);
 	if (page)
 		args->pte_pfn = page_to_pfn(page);

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a15cc56cf70a..1198064f80eb 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -400,7 +400,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	return 0;
 out:
 	list_for_each_entry_safe(page, next, list, lru)
-		__free_pages(page, 0);
+		__free_page(page);
 	return -ENOMEM;
 }

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 2b93cf6ac9ae..ea9683e12936 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
 		return false;

-	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
+	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 	if (!batch)
 		return false;

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 680a4d76460e..256e8d3c8742 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5538,7 +5538,7 @@ EXPORT_SYMBOL(__get_free_pages);

 unsigned long get_zeroed_page(gfp_t gfp_mask)
 {
-	return __get_free_pages(gfp_mask | __GFP_ZERO, 0);
+	return __get_free_page(gfp_mask | __GFP_ZERO);
 }
 EXPORT_SYMBOL(get_zeroed_page);

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5e60e9792cbf..978194dc2bb8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2739,7 +2739,7 @@ void vfree(const void *addr)
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
 		 */
-		__free_pages(page, 0);
+		__free_page(page);
 		cond_resched();
 	}
 	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
--
2.39.2
