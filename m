Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064563C41D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiK2PsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiK2Prw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:47:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4BC1E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:47:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so11165956wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT8IZrjdmDIMAqdPXo5e6xGOYanI26oKv2vQ1WDKtQk=;
        b=BL0l4dA+hwXaxDagId779Kfqnra35IhbXewFqGa9/iFcvBB3etkTunBBW79/i36Z7W
         FfYpfWUnFoFz59NOcvGwEnZS33GiDNsps7XypTQfxe7OCHjHXk+z0tOPFjYOE+cACcsZ
         BXOa2b+J8eBTp5BN0CToCCnb2NeAqGP9snzI7hhPMzlf2jIo2SFynaVZjlfQYYi0iCSw
         GPCs7ry1zENWaAccRHHdPcJ6eAZekj2Pr5KT7h76W9ibjnORNwIxH00ODyhVgzvlN1vh
         CW16wRyiAnWnHq7GeBxH72cDAsZOijNEWdnWbcouFDuLz3dJ+2kRu6/4vmBtPncSAits
         V0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kT8IZrjdmDIMAqdPXo5e6xGOYanI26oKv2vQ1WDKtQk=;
        b=B3u2TXTzGODRPrCoz6rlFDe4o47QUNLPuXQfOHP+zazWljwEn4qwa0Tb0d85X8X2H1
         oMEc3hQAtckUDnzE2oy7NxUuAd9RMNfQrBBbisN/7HedjkACJ2UZYv/9cenKMzkkqp6I
         N1wvL5lzS8X9veNNH4PvXGz8VCl5mav6e16F8sbxsQGgyU2AsxuxsiDkkZuh9AxKz4uK
         neLrsC5oZrB32HOjO1oNQw1FTvusgxkqfAfu7eNBGlgStmXL7Q0oFb5Y3y2b/eEcVe20
         m4H4fSMt+4Si6T6wKTdc3lS8ndAW0aFYQe4dr3w92PyUmHBsrEvpRRNMbXzJZVFOxoLS
         YwYA==
X-Gm-Message-State: ANoB5pmB8UEE2QRonjwDIh5gRlep0fbWAL8HE6goE7zF4XC7EyVb0flF
        1VL6uFJUbsdFV3rdaylNDt88Tw==
X-Google-Smtp-Source: AA0mqf6a5G/8CLXnb0SAy9z118CKG1gCpO4zhtBYmnvQa4oO/gHafcMunPZk/HVikU3D8gdKcQu13g==
X-Received: by 2002:a05:600c:19ce:b0:3d0:5160:e0e2 with SMTP id u14-20020a05600c19ce00b003d05160e0e2mr11570874wmq.147.1669736863055;
        Tue, 29 Nov 2022 07:47:43 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:5011:adcc:fddd:accf])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4a89000000b00241fde8fe04sm14090930wrq.7.2022.11.29.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:47:42 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
Date:   Tue, 29 Nov 2022 16:47:29 +0100
Message-Id: <20221129154730.2274278-2-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221129154730.2274278-1-jannh@google.com>
References: <20221129154730.2274278-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The khugepaged paths that remove page tables have to be careful to
synchronize against the lockless_pages_from_mm() path, which traverses
page tables while only being protected by disabled IRQs.
lockless_pages_from_mm() must not:

 1. interpret the contents of freed memory as page tables (and once a
    page table has been deposited, it can be freed)
 2. interpret the contents of deposited page tables as PTEs, since some
    architectures will store non-PTE data inside deposited page tables
    (see radix__pgtable_trans_huge_deposit())
 3. create new page references from PTEs after the containing page
    table has been detached and:
    3a. __collapse_huge_page_isolate() has checked the page refcount
    3b. the page table has been reused at another virtual address and
        populated with new PTEs

("new page references" here refer to stable references returned to the
caller; speculative references that are dropped on an error path are
fine)

commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
collapse") addressed issue 3 by making the lockless_pages_from_mm()
fastpath recheck the pmd_t to ensure that the page table was not
removed by khugepaged in between (under the assumption that the page
table is not repeatedly moving back and forth between two addresses,
with one PTE repeatedly being populated with the same value).

But to address issues 1 and 2, we need to send IPIs before
freeing/reusing page tables. By doing that, issue 3 is also
automatically addressed, so the fix from commit 70cbc3cc78a99 ("mm: gup:
fix the fast GUP race against THP collapse") becomes redundant.

We can ensure that the necessary IPI is sent by calling
tlb_remove_table_sync_one() because, as noted in mm/gup.c, under
configurations that define CONFIG_HAVE_FAST_GUP, there are two possible
cases:

 1. CONFIG_MMU_GATHER_RCU_TABLE_FREE is set, causing
    tlb_remove_table_sync_one() to send an IPI to synchronize with
    lockless_pages_from_mm().
 2. CONFIG_MMU_GATHER_RCU_TABLE_FREE is unset, indicating that all
    TLB flushes are already guaranteed to send IPIs.
    tlb_remove_table_sync_one() will do nothing, but we've already
    run pmdp_collapse_flush(), which did a TLB flush, which must have
    involved IPIs.

Cc: stable@kernel.org
Fixes: ba76149f47d8 ("thp: khugepaged")
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v4:
     - added ack from David Hildenbrand
     - made commit message more verbose
    v5:
     - added reviewed-by from Yang Shi
     - rewrote commit message based on feedback from Yang Shi

 include/asm-generic/tlb.h | 4 ++++
 mm/khugepaged.c           | 2 ++
 mm/mmu_gather.c           | 4 +---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 492dce43236ea..cab7cfebf40bd 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -222,12 +222,16 @@ extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 #define tlb_needs_table_invalidate() (true)
 #endif
 
+void tlb_remove_table_sync_one(void);
+
 #else
 
 #ifdef tlb_needs_table_invalidate
 #error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
 #endif
 
+static inline void tlb_remove_table_sync_one(void) { }
+
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 674b111a24fa7..c3d3ce596bff7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1057,6 +1057,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(&range);
+	tlb_remove_table_sync_one();
 
 	spin_lock(pte_ptl);
 	result =  __collapse_huge_page_isolate(vma, address, pte, cc,
@@ -1415,6 +1416,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
 
 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
+	tlb_remove_table_sync_one();
 	mm_dec_nr_ptes(mm);
 	page_table_check_pte_clear_range(mm, addr, pmd);
 	pte_free(mm, pmd_pgtable(pmd));
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index add4244e5790d..3a2c3f8cad2fe 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -153,7 +153,7 @@ static void tlb_remove_table_smp_sync(void *arg)
 	/* Simply deliver the interrupt */
 }
 
-static void tlb_remove_table_sync_one(void)
+void tlb_remove_table_sync_one(void)
 {
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
@@ -177,8 +177,6 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
 
 #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
-static void tlb_remove_table_sync_one(void) { }
-
 static void tlb_remove_table_free(struct mmu_table_batch *batch)
 {
 	__tlb_remove_table_free(batch);
-- 
2.38.1.584.g0f3c55d4c2-goog

