Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A38639124
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKYVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKYVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:37:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FDD101C4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:37:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id cl5so8508359wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXD6TekHCwWyaJjEnEUCIQwhKm8R4syqj2EShSG9CG4=;
        b=LbycPTZagQ51nPLmloFB/7NtnvTiSeUQAuZZ2EkPPlQgtWmKZxxpz1La+0Sg5Wa4Rr
         QPK0+z28OGsP2RhtKkhY6uwU9FRTAt/NqXjZ7MjCe3YETc37AnNoh2YcVnwLSIA/A2in
         ozUtyauDDVkAhz9m29tRAE0JI3b3myHPK1RVcbBAl0asvNRR5Vy+CDZXCw/8tuXxqhjS
         yrv6noxZgbshgZx84/f8bQc2LkkMA/Z9vXXk6Bo0tqg2j/ykUC5HaVHtCvv4sb+G8fPj
         1eJ657mhGUY43wuEPXURLQhISq427MEO8FteYgZbLF00C0vgmD5VPh021QAYYnfkDmNV
         3Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXD6TekHCwWyaJjEnEUCIQwhKm8R4syqj2EShSG9CG4=;
        b=MLE4Ci77Q8PNMjsKox8N5BRgmBjNoqqQoku45H7Mc5zJVhiRL7zPZtur6UjaYdBLq7
         e2dTsG4zSogod1v8T4rsP92tu//0wGnDw0Uyxx6DfF9wdxBe6L7Y/K3TPWvIXkB7vAdH
         QIXQ8jLr899lLkvqhzsvNHoukxfiEGO2Fe57Z8f+SiakTcKb1DivZm8ps0028QJiU7Qq
         DoVvt9ACgut1aDKBu2g8I9fmP6v6coE0Xe3VIi+SaxgSlioHbINiI0bzwcZQR1WOdW8x
         VhNgqhwqUWM8MdOV8MrDJ08b+2b0WYl5fcNZ/NsYBGw8ReCNx8YjgN/uWqClmHEARZFD
         WFRA==
X-Gm-Message-State: ANoB5pnL9gaOT7mhlsZevx8LViVtJZSZAp1++BY4zDzUJn7rVKi4nBKG
        LVByXgd5wvCaqKyDAe0jf4wpaw==
X-Google-Smtp-Source: AA0mqf5MLHrAyzs+7KAfomgqrFtT5xPA83/WPLEYaIucLGWlV7Rf/Y2a73erzIdA6X9yklrsVtx2Nw==
X-Received: by 2002:a05:6000:235:b0:241:bd2b:f718 with SMTP id l21-20020a056000023500b00241bd2bf718mr23371777wrz.89.1669412265015;
        Fri, 25 Nov 2022 13:37:45 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:9104:e316:5846:858e])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm16931581wms.3.2022.11.25.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 13:37:44 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/3] mm/khugepaged: Fix GUP-fast interaction by sending IPI
Date:   Fri, 25 Nov 2022 22:37:13 +0100
Message-Id: <20221125213714.4115729-2-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221125213714.4115729-1-jannh@google.com>
References: <20221125213714.4115729-1-jannh@google.com>
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
concurrently freed. Fix it by sending IPIs (if the architecture uses
semi-RCU-style page table freeing) before freeing/reusing page tables.

Cc: stable@kernel.org
Fixes: ba76149f47d8 ("thp: khugepaged")
Signed-off-by: Jann Horn <jannh@google.com>
---
replaced the mmu_gather-based scheme with an RCU call as suggested by
Peter Xu

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

