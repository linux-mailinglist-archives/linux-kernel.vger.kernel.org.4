Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434A7670EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjARAmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjARAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:31 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168C3B65E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:49 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id n8-20020a6bf608000000b007048850aa92so8061651ioh.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6H89U5IeidH5uN+ug8sUPQpQtuhKWJCjw7/0EqS2ku0=;
        b=ehaqOT566l9lQNTopDpFadeCKqnbnQXDRjA4DPY/fYefKLjsNzYv9N4HuPSWfNkL/T
         4Tg/kA81AyBkg4BImcq3oqRmF/8TJybpfdFgXPSLolkWJ5mw6QHUgFCZBkBVQDibpWXw
         f/lXMaLAbJt0/JF5UEDKskx+8SxTkQBmDQJgygYwaPhtsoZOQXj+1AcNg97s38dmmyVz
         p2SYvvXrygWzdMYec36TtEcLVug0YvASHX2223Ft7SAt6HO5CKdMQRQazFhMMGSgulaE
         rAipKhxVwfCNyD+CnFMmGB/6pVkrS4W1S5qqf6Glc6OZDlHbiS2ijfudvQJ3gTUyA8mo
         KJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6H89U5IeidH5uN+ug8sUPQpQtuhKWJCjw7/0EqS2ku0=;
        b=z6bfZu1apCYCWdVDKNrwBHg1s5MjST7cyzOcChzHM4K87wVFELT5JgYCXEU09ERzAm
         of5/kZTVyMCUUKgRhAm7OriqnOZs5gYjI6DWKT9uHYV9omHfKEpm83ZxvFCTQNNGEVca
         D1gLzUwAN0YojHuiqzXNCb7ZZtQSfsu/X5yb1BSvh9eAL410X7bCJTQ76KNc8szJtAKh
         0jPkuJenaJ/CRaq1LZJG8GqDZBI8jIAEKsygX6Wr6co24YOU5Jr9Z5K77Tf7fECfmUjU
         FFSRtfW7DUW4HO+WBlqbDoS9kFPz+aQagsKfWGQJwZLrE32u5C7QZj+a/N83FKxEE/aB
         hQSA==
X-Gm-Message-State: AFqh2krM6kv5LNlDTDPoGg06CqeaiARgk7d4eMav8YuhPwdZzw0eauiY
        Y916ve/5auWu9EpKRiH6EVvYLrGXqjfV8A==
X-Google-Smtp-Source: AMrXdXszXwn79l9Gfb+KYtiDbMPXtgqCNArs+vjslWDauUohP23J2vUQSyakr6tDwA+c7CfabNXqBrhVmzxocQ==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a05:6e02:4a4:b0:30b:e92a:56b with SMTP id
 e4-20020a056e0204a400b0030be92a056bmr547629ils.53.1674001129175; Tue, 17 Jan
 2023 16:18:49 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:27 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-8-talumbau@google.com>
Subject: [PATCH mm-unstable v1 7/7] mm: multi-gen LRU: simplify lru_gen_look_around()
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
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

Update the folio generation in place with or without
current->reclaim_state->mm_walk. The LRU lock is held for longer, if
mm_walk is NULL and the number of folios to update is more than
PAGEVEC_SIZE.

This causes a measurable regression from the LRU lock contention
during a microbencmark. But a tiny regression is not worth the
complexity.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 mm/vmscan.c | 73 +++++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 50 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ff3b4aa3c31f..ac51150d2d36 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4587,13 +4587,12 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
 	int i;
-	pte_t *pte;
 	unsigned long start;
 	unsigned long end;
-	unsigned long addr;
 	struct lru_gen_mm_walk *walk;
 	int young = 0;
-	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] = {};
+	pte_t *pte = pvmw->pte;
+	unsigned long addr = pvmw->address;
 	struct folio *folio = pfn_folio(pvmw->pfn);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
@@ -4610,25 +4609,28 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
 
-	start = max(pvmw->address & PMD_MASK, pvmw->vma->vm_start);
-	end = min(pvmw->address | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
+	start = max(addr & PMD_MASK, pvmw->vma->vm_start);
+	end = min(addr | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
 
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
-		if (pvmw->address - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
+		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
 			end = start + MIN_LRU_BATCH * PAGE_SIZE;
-		else if (end - pvmw->address < MIN_LRU_BATCH * PAGE_SIZE / 2)
+		else if (end - addr < MIN_LRU_BATCH * PAGE_SIZE / 2)
 			start = end - MIN_LRU_BATCH * PAGE_SIZE;
 		else {
-			start = pvmw->address - MIN_LRU_BATCH * PAGE_SIZE / 2;
-			end = pvmw->address + MIN_LRU_BATCH * PAGE_SIZE / 2;
+			start = addr - MIN_LRU_BATCH * PAGE_SIZE / 2;
+			end = addr + MIN_LRU_BATCH * PAGE_SIZE / 2;
 		}
 	}
 
-	pte = pvmw->pte - (pvmw->address - start) / PAGE_SIZE;
+	/* folio_update_gen() requires stable folio_memcg() */
+	if (!mem_cgroup_trylock_pages(memcg))
+		return;
 
-	rcu_read_lock();
 	arch_enter_lazy_mmu_mode();
 
+	pte -= (addr - start) / PAGE_SIZE;
+
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
 
@@ -4653,56 +4655,27 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		      !folio_test_swapcache(folio)))
 			folio_mark_dirty(folio);
 
+		if (walk) {
+			old_gen = folio_update_gen(folio, new_gen);
+			if (old_gen >= 0 && old_gen != new_gen)
+				update_batch_size(walk, folio, old_gen, new_gen);
+
+			continue;
+		}
+
 		old_gen = folio_lru_gen(folio);
 		if (old_gen < 0)
 			folio_set_referenced(folio);
 		else if (old_gen != new_gen)
-			__set_bit(i, bitmap);
+			folio_activate(folio);
 	}
 
 	arch_leave_lazy_mmu_mode();
-	rcu_read_unlock();
+	mem_cgroup_unlock_pages();
 
 	/* feedback from rmap walkers to page table walkers */
 	if (suitable_to_scan(i, young))
 		update_bloom_filter(lruvec, max_seq, pvmw->pmd);
-
-	if (!walk && bitmap_weight(bitmap, MIN_LRU_BATCH) < PAGEVEC_SIZE) {
-		for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
-			folio = pfn_folio(pte_pfn(pte[i]));
-			folio_activate(folio);
-		}
-		return;
-	}
-
-	/* folio_update_gen() requires stable folio_memcg() */
-	if (!mem_cgroup_trylock_pages(memcg))
-		return;
-
-	if (!walk) {
-		spin_lock_irq(&lruvec->lru_lock);
-		new_gen = lru_gen_from_seq(lruvec->lrugen.max_seq);
-	}
-
-	for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
-		folio = pfn_folio(pte_pfn(pte[i]));
-		if (folio_memcg_rcu(folio) != memcg)
-			continue;
-
-		old_gen = folio_update_gen(folio, new_gen);
-		if (old_gen < 0 || old_gen == new_gen)
-			continue;
-
-		if (walk)
-			update_batch_size(walk, folio, old_gen, new_gen);
-		else
-			lru_gen_update_size(lruvec, folio, old_gen, new_gen);
-	}
-
-	if (!walk)
-		spin_unlock_irq(&lruvec->lru_lock);
-
-	mem_cgroup_unlock_pages();
 }
 
 /******************************************************************************
-- 
2.39.0.314.g84b9a713c41-goog

