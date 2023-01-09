Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2091A6632F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjAIVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAIVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:33:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA3E2E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:33:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6599E61414
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3813C433F2;
        Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300028;
        bh=CFEeibNvvYAHsooB/GZxZzGLeG1gUo5uWWp85VJYZOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkayMLf4IhwPE5yfzgDGZfwtnsgWnvEkfeAXD5O25NOF846s/PGNbZIBST+o9XJfu
         YTzFb7YVkNVDpiaxedFNYwJ5bGBdaSZlzL0dJifZseNQaZ9fVWqVQmyDdHhV+vKXja
         HASc/1EM1sgLdlweKLpxJWF0NKPshrKc8IjLEngSJK+LCP2VWTSJxuduVYw99ul/ij
         NzCuJU0/oB5GhgMqwXkr0/VEu2XMLuavwrhnAr0bYcTbsg9oa3xyQuy7Jd7rGl+BIG
         b/Aw174M8zeE6Hi9q4YH1GA+PwK7bX+GynKfII38j5rrg51mvQfOX0XcBjXRTshqIX
         7XmdlB/xwMVHg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm/damon/paddr: rename 'damon_pa_access_chk_result->page_sz' to 'folio_sz'
Date:   Mon,  9 Jan 2023 21:33:33 +0000
Message-Id: <20230109213335.62525-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109213335.62525-1-sj@kernel.org>
References: <20230109213335.62525-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON's physical address space monitoring operations set is using folio
now.  Rename 'damon_pa_access_chk_result->page_sz' to reflect the fact.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 99d4c357ef2b..65c1e0f91535 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -80,7 +80,8 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_pa_access_chk_result {
-	unsigned long page_sz;
+	/* size of the folio for the access checked physical memory address */
+	unsigned long folio_sz;
 	bool accessed;
 };
 
@@ -91,7 +92,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
 	result->accessed = false;
-	result->page_sz = PAGE_SIZE;
+	result->folio_sz = PAGE_SIZE;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
@@ -103,7 +104,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 			result->accessed = pmd_young(*pvmw.pmd) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
-			result->page_sz = HPAGE_PMD_SIZE;
+			result->folio_sz = HPAGE_PMD_SIZE;
 #else
 			WARN_ON_ONCE(1);
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -118,11 +119,11 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return !result->accessed;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
+static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct damon_pa_access_chk_result result = {
-		.page_sz = PAGE_SIZE,
+		.folio_sz = PAGE_SIZE,
 		.accessed = false,
 	};
 	struct rmap_walk_control rwc = {
@@ -157,25 +158,25 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	folio_put(folio);
 
 out:
-	*page_sz = result.page_sz;
+	*folio_sz = result.folio_sz;
 	return result.accessed;
 }
 
 static void __damon_pa_check_access(struct damon_region *r)
 {
 	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
+	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
+	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
 		if (last_accessed)
 			r->nr_accesses++;
 		return;
 	}
 
-	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
+	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
 	if (last_accessed)
 		r->nr_accesses++;
 
-- 
2.25.1

