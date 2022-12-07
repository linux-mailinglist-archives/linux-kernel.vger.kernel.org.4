Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770796464AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLGXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLGXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:01:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942554740
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:01:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d7so2178944pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYZlpNMA+Acznxg5e3x9zZ+EdiKxFlZgSChFwOm2lRk=;
        b=HiV/oY75y2SgvXSPgyC4fy1/yI+dEmaKpwJP9rcT9dvAgK7E9TPad3a0idSitkerjT
         Rrx0RTHSsmtv3oYd5pfyIkV0y4GmO+Ls1xkjiaFCRuEDjWgdtfBwXFaxlF5rV4ac7dhC
         CTZ+IdatW3dUUDP49usWcGXfNyH1/cFNk/xhDASziYsASDFEEJQN1T4Qz8o2+HDwFMZQ
         n4bL6G0h7Mv4SDokh1Hd/WE4OycJFvigMqFcBjH3A6gGRp/2gfMSNyIay1/n3CcbXFu0
         JYMWAnXquC8dwcR+vBFJiWJXrY4ZOi92H5zeUQj/dJopHjbdAk622Ttf2+x+Y1B265qB
         6RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYZlpNMA+Acznxg5e3x9zZ+EdiKxFlZgSChFwOm2lRk=;
        b=fYRbSVZ6eZusaQOj0otat2WkNEnoI4mZ98tbl4w+ifufEGoI7eiJDu8oIdg1RAbBIK
         lsC3x0SksYmAWkoc3tEaEtjS3sKh0VAD9d5w+2xL9ZHlk7mSFhaTifIG8g73AxoL2TJR
         XciWVtYFuqVDveJ4RTCvd90o1fAp+++BiNocCSdAKQVqK7lPK0QT407ESkmTuXBdPwJ7
         K12+CK0HUrqnHZ9VDqfjyaJ1HZeUmPeOaRmYK1sFo880b75p4yt6Akoqma+5PSctdJOY
         CQmpbFjG5EC2IptoKYkAg9Oop16HRb0gugNYrcP9FJw4n6tPR0s8w5o7z2prmxnMtadq
         ZTEQ==
X-Gm-Message-State: ANoB5pkGnfaDrHzrGYGNg1pI0qxYlCkYMx7X8L94oKzFa21ZfkSOr6Wt
        nEPhucTg2ufLX5phi7ncu0g=
X-Google-Smtp-Source: AA0mqf4uIlwwTywDq7pnmSssjoqZm8uc2lM/w6x1j1eyco1kE6LT4+WStL0ZREb8lSZ3UNkCCMIzPA==
X-Received: by 2002:a17:90b:1913:b0:219:396c:9e30 with SMTP id mp19-20020a17090b191300b00219396c9e30mr1056216pjb.20.1670454117492;
        Wed, 07 Dec 2022 15:01:57 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5411033pjb.1.2022.12.07.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:01:57 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 1/3] madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
Date:   Wed,  7 Dec 2022 15:01:50 -0800
Message-Id: <20221207230152.22938-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207230152.22938-1-vishal.moola@gmail.com>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
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
index 2baa93ca2310..b323672c969d 100644
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
+		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
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

