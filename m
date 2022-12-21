Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE736535EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiLUSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLUSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:10:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858E9252AA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:10:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2855468pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V90+BfZtK1slvLn1n1Jx1RIzI90mSXqsrWzPZLU3PF8=;
        b=idgtJWZU6cXL8auQ5suH1EAlK2iOZX3Y/jKu/mNOZua5+aWbsw51hqTcyRM4Nh2OOB
         lIKT1uam8nzXBWXebN9JokPLVjBrVByu9Zw/5eU+Wi3xiXKqxd07Q3LuIYo45eVOKasK
         mGNbB9QfNxPeTkWrUnEQBMDIarluZ7WItM3qk6RsVRp2ivxASFV4CgCjERRAFEW0++rt
         KRFaw31a5udcVll9o4BxJ1YkyovfEAOfGF3WzX3q/fZTyZDsiFwEocQbbwahXxpNA6Wz
         xFl1ImHFXxYf7psocCMqL7In5Jh/aghKIznStF2vEp7T0TREjVepbMTM0KjSrnzORygY
         +ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V90+BfZtK1slvLn1n1Jx1RIzI90mSXqsrWzPZLU3PF8=;
        b=rp552+sczrnEx6mAof+5Z2XDmcGQRI97wRwHUlmgjSjIgnvPWO29790iHe/xfkwJ+8
         HgQ/qc3uBL1DV5ELBXcyXBYGpAVtVpf5jaNVdE+L3j6st56jknn44THVcqwItAiLdJ9r
         mWuNUvzu8l4xuv198O3StluSCjZBQcjgVWL/bU74CuLsnXhoWNsPJyjgeay5tsYX4rcS
         HBk7LC7Kv0d1K8mCBv8tpsPBiWYy4BfDL/18Jizxw2hTRwGeU0iZOjzc5AucJe2GH1l/
         WTW8H9l2uviJKcjSN9OF+0aJlf40tzASka0pZwA9ip8NBrsVpANm9Sjqn4003XZkuIIS
         mtGg==
X-Gm-Message-State: AFqh2krktOQ9aZVBT4tNxOOKpJVjDyfc+8YsP1v4icrma9SPyAAuRMpM
        tNfq9MZIljmcxdVJiqxNDdY=
X-Google-Smtp-Source: AMrXdXubRnPot5zpMhDyHPp0OTNzVi5od2gLZPVrt/vb+U6VUKCE5XuBc6Z5YFmHx3I3sJn0Vkn8+Q==
X-Received: by 2002:a05:6a20:1a84:b0:a7:89fd:884c with SMTP id ci4-20020a056a201a8400b000a789fd884cmr3628709pzb.11.1671646199957;
        Wed, 21 Dec 2022 10:09:59 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:09:59 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org, willy@infradead.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 2/4] madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
Date:   Wed, 21 Dec 2022 10:08:46 -0800
Message-Id: <20221221180848.20774-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221180848.20774-1-vishal.moola@gmail.com>
References: <20221221180848.20774-1-vishal.moola@gmail.com>
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

This change removes a number of calls to compound_head(), and saves
1729 bytes of kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/madvise.c | 98 ++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 7b7549a54a6d..851d977b9b03 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -345,8 +345,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
-	struct page *page = NULL;
-	LIST_HEAD(page_list);
+	struct folio *folio = NULL;
+	LIST_HEAD(folio_list);
 	bool pageout_anon_only_filter;
 
 	if (fatal_signal_pending(current))
@@ -375,26 +375,26 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			goto huge_unlock;
 		}
 
-		page = pmd_page(orig_pmd);
+		folio = pfn_folio(pmd_pfn(orig_pmd));
 
-		/* Do not interfere with other mappings of this page */
-		if (page_mapcount(page) != 1)
+		/* Do not interfere with other mappings of this folio */
+		if (folio_mapcount(folio) != 1)
 			goto huge_unlock;
 
-		if (pageout_anon_only_filter && !PageAnon(page))
+		if (pageout_anon_only_filter && !folio_test_anon(folio))
 			goto huge_unlock;
 
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
-			get_page(page);
+			folio_get(folio);
 			spin_unlock(ptl);
-			lock_page(page);
-			err = split_huge_page(page);
-			unlock_page(page);
-			put_page(page);
+			folio_lock(folio);
+			err = split_folio(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 			if (!err)
-				goto regular_page;
+				goto regular_folio;
 			return 0;
 		}
 
@@ -406,25 +406,25 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
 		if (pageout) {
-			if (!isolate_lru_page(page)) {
-				if (PageUnevictable(page))
-					putback_lru_page(page);
+			if (!folio_isolate_lru(folio)) {
+				if (folio_test_unevictable(folio))
+					folio_putback_lru(folio);
 				else
-					list_add(&page->lru, &page_list);
+					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(page);
+			deactivate_page(&folio->page);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&page_list);
+			reclaim_pages(&folio_list);
 		return 0;
 	}
 
-regular_page:
+regular_folio:
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
@@ -441,33 +441,33 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (!pte_present(ptent))
 			continue;
 
-		page = vm_normal_page(vma, addr, ptent);
-		if (!page || is_zone_device_page(page))
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio || folio_is_zone_device(folio))
 			continue;
 
 		/*
 		 * Creating a THP page is expensive so split it only if we
 		 * are sure it's worth. Split it if we are only owner.
 		 */
-		if (PageTransCompound(page)) {
-			if (page_mapcount(page) != 1)
+		if (folio_test_large(folio)) {
+			if (folio_mapcount(folio) != 1)
 				break;
-			if (pageout_anon_only_filter && !PageAnon(page))
+			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
-			get_page(page);
-			if (!trylock_page(page)) {
-				put_page(page);
+			folio_get(folio);
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
 				break;
 			}
 			pte_unmap_unlock(orig_pte, ptl);
-			if (split_huge_page(page)) {
-				unlock_page(page);
-				put_page(page);
+			if (split_folio(folio)) {
+				folio_unlock(folio);
+				folio_put(folio);
 				orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 				break;
 			}
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 			pte--;
 			addr -= PAGE_SIZE;
@@ -475,16 +475,16 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		/*
-		 * Do not interfere with other mappings of this page and
-		 * non-LRU page.
+		 * Do not interfere with other mappings of this folio and
+		 * non-LRU folio.
 		 */
-		if (!PageLRU(page) || page_mapcount(page) != 1)
+		if (!folio_test_lru(folio) || folio_mapcount(folio) != 1)
 			continue;
 
-		if (pageout_anon_only_filter && !PageAnon(page))
+		if (pageout_anon_only_filter && !folio_test_anon(folio))
 			continue;
 
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
 		if (pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
@@ -495,28 +495,28 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		/*
-		 * We are deactivating a page for accelerating reclaiming.
-		 * VM couldn't reclaim the page unless we clear PG_young.
+		 * We are deactivating a folio for accelerating reclaiming.
+		 * VM couldn't reclaim the folio unless we clear PG_young.
 		 * As a side effect, it makes confuse idle-page tracking
 		 * because they will miss recent referenced history.
 		 */
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
 		if (pageout) {
-			if (!isolate_lru_page(page)) {
-				if (PageUnevictable(page))
-					putback_lru_page(page);
+			if (!folio_isolate_lru(folio)) {
+				if (folio_test_unevictable(folio))
+					folio_putback_lru(folio);
 				else
-					list_add(&page->lru, &page_list);
+					list_add(&folio->lru, &folio_list);
 			}
 		} else
-			deactivate_page(page);
+			deactivate_page(&folio->page);
 	}
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
-		reclaim_pages(&page_list);
+		reclaim_pages(&folio_list);
 	cond_resched();
 
 	return 0;
-- 
2.38.1

