Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2279647759
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiLHUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiLHUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:35:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592FF8566C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:35:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gt4so1022860pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHUznzZJR/+2eFOYGxPgX5SObHA9uL1BQ/OTB3xHgrA=;
        b=NEepa2sCfJJvgnX3ejRFOGPrjMYmgXnKRjN5unAOsJ/tE/BFewdxSNeEpPh1ad1sGm
         sIvarvzBcw9Q3fQ8zNawaQb5T7z+NwATAYhUr1/Zzfia5k8LSv8jP7nLAWj12z2ly+ZT
         f1GUI5W5sCMhxUsXXmc3IaXRX1EDRvErMLIqll3a5CVIKNBy+z+Ps/lbk08QQ9KaT7Xk
         XnMYibTX66/3+am1vVR/kGAVRT7Ww4h9duW2iIIY993dThq5e7aPSkAMZ/4u08o/kpj9
         hMuvayRPzWZ61DFZfjIkSk7CofF4B5i1NolYOU2OWLJeiOsFr0kMvqfSPwlc83/zYe2K
         Aagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHUznzZJR/+2eFOYGxPgX5SObHA9uL1BQ/OTB3xHgrA=;
        b=B2O0XujTXoUJhQy//u25987oImAnoV3tDLjZ/7K44u2BvMFjEiry9/1zUmFgVUUbtU
         jsQgQNTG9MlkjdPEDq6NJDwVXm9Z/0FQM+l8MjeneYG5f/dacsFiPcGgiZzZoclwr32X
         6XzEQaNP6AdGHXM9cKqV5FFXzv3EUkTlBXab9jr4W+e1+7Braa66sPaZgEsPsafTy8++
         74ADDBOBgZyV5r7RLCx6HvqWj2z+3eZ+tlQErNEAwTKHpjFV86nd474FLJjI1RWvJ6mj
         zmtkufVm+9LzaC/llI3CP/aDrcnLdpmo0cLgvjiqqrTeVDFL4XQqKj1F489/FOi4L2GG
         nxHg==
X-Gm-Message-State: ANoB5plUOGTA1LgQzifMSz0jML/uK+3Ixr6v8lx0OPDXMIE/CjkEDpkD
        /7O/oGePh6zjdXJyM7nJVW0=
X-Google-Smtp-Source: AA0mqf5+O1BZXrE1YEC4dz/Cxj4pggZ4XHVB3Kve73sA6I4CTYSn6JfKCq6XbOm2qlu7J9B/7TW1zQ==
X-Received: by 2002:a17:902:d58a:b0:189:a11e:9995 with SMTP id k10-20020a170902d58a00b00189a11e9995mr3527512plh.13.1670531708818;
        Thu, 08 Dec 2022 12:35:08 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:08 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/4] madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
Date:   Thu,  8 Dec 2022 12:35:01 -0800
Message-Id: <20221208203503.20665-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208203503.20665-1-vishal.moola@gmail.com>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
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
 mm/madvise.c | 92 ++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..2a84b5dfbb4c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -332,8 +332,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
-	struct page *page = NULL;
-	LIST_HEAD(page_list);
+	struct folio *folio = NULL;
+	LIST_HEAD(folio_list);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -358,23 +358,23 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
 
@@ -386,25 +386,25 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
@@ -421,31 +421,31 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
@@ -453,13 +453,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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
 
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
 		if (pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
@@ -470,28 +470,28 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
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

