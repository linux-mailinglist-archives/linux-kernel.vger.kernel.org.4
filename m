Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9B63B104
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiK1STd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiK1SSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:18:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84212A70E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:03:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t1so9112431wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUow5Vogs/7PnC9nrxFlLM/L16QCcApD5uJXFy4USuY=;
        b=rU/5WuLN/iM6g1+U2lBomEDv/g6EreorKfHwKtqRkF8SblU0VsIoZV8lMj7la44xOo
         RFhODdlKSvqR653yK+HRv3a22IBJ7tLBK5Z6ja7TLaM28AE7gzd8hZGHoFRg1XxIlqjJ
         WzZLuZdJo6sJsyS+ZZSUvjrHnUPfa6Ac26czHLanj7NP3nju9ONX3HUkVJHKHv9yZ1BF
         xmWKi8CRGLpW4bKOJghlq05QZvrVOUN3iDX+uFzjp2XCnvE1dkTCbY2bZ7loNCgKJ9US
         4XoznfiWY3eu0D8pWYcvLjab/VADOYaVOhIRlWOyHDbaAxmQm1iUD8calDDGZ6mT7Dcv
         kYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUow5Vogs/7PnC9nrxFlLM/L16QCcApD5uJXFy4USuY=;
        b=7pevsiCixJcaiiIkg6tv6sTqqPS+WiB1erRUEPNLltroUDhDRcC9dtcKwqMSlmyVmO
         PYrzg3v1R+4x68B4FEARKrS73taHPkaFibMIhtjZHaEjTEmmn8C90SMruv3iQpDK2n88
         O4ifi1CsOoO/o44jdMNaRtv65FqMq1wMe4tBigMegyDvQkRylBG7G5kz06Detr+Si28e
         hzaAf9oUt6z4zWaLJj5YyGEH+ks4QXORBv2u+KdW9pJyhkbj8HNp5sNJZ9b6XPmilOQT
         L3wL48+hpYRgiGPGNH5+lNJfkNDpGEX4SQ1/fvfwIFZmOz+k360twTZCfJECFIwLAWqc
         Da9w==
X-Gm-Message-State: ANoB5plUJ6uJkSjTJsN3y+BjSonYfOYQH23WMKnnPQaK6IEo5hbVIMvC
        mnkwk0G9AXhDJwEnlXkdnD7FTA==
X-Google-Smtp-Source: AA0mqf55TgU3FF0+HFze1Tgck+4ISKVwlxDQBSJiTP5rct0txTHiKl+xLdG68s5H54ewewN4ONkTvA==
X-Received: by 2002:a7b:cd18:0:b0:3cf:a359:de90 with SMTP id f24-20020a7bcd18000000b003cfa359de90mr28732913wmj.122.1669658587158;
        Mon, 28 Nov 2022 10:03:07 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:f4d1:b340:8675:e840])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b002420dba6447sm6628727wro.59.2022.11.28.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:03:05 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
Date:   Mon, 28 Nov 2022 19:02:51 +0100
Message-Id: <20221128180252.1684965-2-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221128180252.1684965-1-jannh@google.com>
References: <20221128180252.1684965-1-jannh@google.com>
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

Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
ensure that the page table was not removed by khugepaged in between.

However, lockless_pages_from_mm() still requires that the page table is not
concurrently freed or reused to store non-PTE data. Otherwise, problems
can occur because:

 - deposited page tables can be freed when a THP page somewhere in the
   mm is removed
 - some architectures store non-PTE information inside deposited page
   tables (see radix__pgtable_trans_huge_deposit())

Additionally, lockless_pages_from_mm() is also somewhat brittle with
regards to page tables being repeatedly moved back and forth, but
that shouldn't be an issue in practice.

Fix it by sending IPIs (if the architecture uses
semi-RCU-style page table freeing) before freeing/reusing page tables.

As noted in mm/gup.c, on configs that define CONFIG_HAVE_FAST_GUP,
there are two possible cases:

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
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
v4:
 - added ack from David Hildenbrand
 - made commit message more verbose

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

