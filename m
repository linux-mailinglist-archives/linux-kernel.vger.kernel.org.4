Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF6645048
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLGAW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGAWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:22:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED74B99C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:22:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n3so11817771pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoYl04wmxXLxezPOZ+70Ro47XrPK1TtSWHCWNCKBtck=;
        b=gBamaz4OVaEVv9YnAytPCavKroW8kAh0EpjPfndUHawsWX+Te45e0LTcygfzxt8QE1
         2SqiGRJcTWSCe+7cD3rFTWy6y+tYqHCvXgbJn+r4VQFX9HnuyvW8NZJ9lLFTWfnmkcmE
         MMe2xsoL8lhOPC+CRDfEqdjzr18ZgvwViZoUlSeR/Zo9B1Hp6uxR7DCzEGnBB8tYFU/Q
         2AzyPIkz77tzkdOVaKf+MI5ugr+rsOEWFabgMLVJaRBaDHs2x7YAnjXbYL/4n9bexpZK
         YzC2T83N0X1QGW2u7NSK3lLFlSrooexvnhal3jwHDd5x9guBM1nkqYqdiQceIRsbYvYm
         D4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoYl04wmxXLxezPOZ+70Ro47XrPK1TtSWHCWNCKBtck=;
        b=xClwhKEOE8O3pw7n59Rlc4Ryf/IdviKMZCD00TI/r6x9iIXdn+eDeb9yGQ6mho7QTM
         M4chWu24yy99S3otskXZoicRdGpSr/EYkJpb1SvqwMFifda+aDVaBzs6mV2YnCnMNKws
         47E/VCjhpFPYmEuuD4jQBwfQ28ZxMtGijSvYo9T5upEF7VGl8xpPCW41O3NRZXV7dkmh
         i6bxyXIkf2FN00BSI4MvzYF9vKnS46F6WTDatDvXMSbbGe/9cU8K2NB/a0Ev/e8OcI5I
         hM0LOSFDTjFxbSAmV38d14S6fDlKdnFlIHav5adN+1MrSjm5PD9vzM1XLZqVRH0bNbFT
         gq+Q==
X-Gm-Message-State: ANoB5pkohrOIrErHPRkgAORkWHDMnqgbR67Tpa/rwkEgZa9Ehnb1AKof
        bfdcaB+3HyzLYArikxRIjmI=
X-Google-Smtp-Source: AA0mqf6EdiHewDQc4qwEXQ+ag0vm95jDVzDY/1oaMRvcZpUYxt8oTIUgeuu68qGZp6quL3u90D6TUA==
X-Received: by 2002:a63:1464:0:b0:46a:f665:ed96 with SMTP id 36-20020a631464000000b0046af665ed96mr63031285pgu.486.1670372530940;
        Tue, 06 Dec 2022 16:22:10 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:10 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/3] madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
Date:   Tue,  6 Dec 2022 16:21:56 -0800
Message-Id: <20221207002158.418789-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207002158.418789-1-vishal.moola@gmail.com>
References: <20221207002158.418789-1-vishal.moola@gmail.com>
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

This change removes a number of calls to compound_head(), and saves 1319
bytes of kernel text.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/madvise.c | 88 +++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..59bfc6c9c548 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -332,8 +332,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
+	struct folio *folio = NULL;
 	struct page *page = NULL;
-	LIST_HEAD(page_list);
+	LIST_HEAD(folio_list);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -358,23 +359,23 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			goto huge_unlock;
 		}
 
-		page = pmd_page(orig_pmd);
+		folio = pfn_folio(pmd_pfn(orig_pmd));
 
-		/* Do not interfere with other mappings of this page */
-		if (page_mapcount(page) != 1)
+		/* Do not interfere with other mappings of this folio */
+		if (folio_mapcount(folio) != 1)
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
 
@@ -386,25 +387,25 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
@@ -424,28 +425,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		page = vm_normal_page(vma, addr, ptent);
 		if (!page || is_zone_device_page(page))
 			continue;
+		folio = page_folio(page);
 
 		/*
 		 * Creating a THP page is expensive so split it only if we
 		 * are sure it's worth. Split it if we are only owner.
 		 */
-		if (PageTransCompound(page)) {
-			if (page_mapcount(page) != 1)
+		if (folio_test_large(folio)) {
+			if (folio_mapcount(folio) != 1)
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
@@ -453,13 +455,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		/*
-		 * Do not interfere with other mappings of this page and
-		 * non-LRU page.
+		 * Do not interfere with other mappings of this folio and
+		 * non-LRU folio.
 		 */
-		if (!PageLRU(page) || page_mapcount(page) != 1)
+		if (!folio_test_lru(folio))
 			continue;
 
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+		VM_BUG_ON_PAGE(folio_test_large(folio), folio);
 
 		if (pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
@@ -470,28 +472,28 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

