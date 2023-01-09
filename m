Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191B66632FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjAIVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjAIVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:33:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D005D67
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:33:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2064B80D50
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18BDC433F1;
        Mon,  9 Jan 2023 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300026;
        bh=8zePhCnELAS1QJzxrjEP75j3wPseZorjwjhVisLqJLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI0kvQY14VYnZdX+nOXPYkE3NYQ684HNWh99BZ3HGSB44hAC1XoKXeyhI00O79K6w
         baT02EhqlaaajEh5EOvLemJQ/HQvCXaL6sXFaCAqhiR5TnV4vHFxqkYJsxwHwsiUbL
         RRxzElNee++MXz9VfFsYQ8CR47R+UgOqES3k8M4JMiDSkcE+7rSG6/r4dpWWLTprUL
         DXXWH5WGqOtB3POAMRJ/7HmiW0iPUezsF6QKlwQVYwZcYHaD93ZvADEpOP5D6eBoO1
         rDzq6VTp6zIC3RvJ28SRNRMF5F3miHkJE18KNJl7SuBX8OaT9jC4tF4OzqsUfIcI9O
         vCW3K43C/4img==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm/damon/vaddr: rename 'damon_young_walk_private->page_sz' to 'folio_sz'
Date:   Mon,  9 Jan 2023 21:33:30 +0000
Message-Id: <20230109213335.62525-2-sj@kernel.org>
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

DAMON's virtual address space monitoring operations set is using folio
now.  Rename 'damon_pa_access_chk_result->page_sz' to reflect the fact.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 9d92c5eb3a1f..d6cb1fca1769 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -422,7 +422,8 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_young_walk_private {
-	unsigned long *page_sz;
+	/* size of the folio for the access checked virtual memory address */
+	unsigned long *folio_sz;
 	bool young;
 };
 
@@ -452,7 +453,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
 					mmu_notifier_test_young(walk->mm,
 						addr)) {
-			*priv->page_sz = HPAGE_PMD_SIZE;
+			*priv->folio_sz = HPAGE_PMD_SIZE;
 			priv->young = true;
 		}
 		folio_put(folio);
@@ -474,7 +475,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		goto out;
 	if (pte_young(*pte) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->page_sz = PAGE_SIZE;
+		*priv->folio_sz = PAGE_SIZE;
 		priv->young = true;
 	}
 	folio_put(folio);
@@ -504,7 +505,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 
 	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->page_sz = huge_page_size(h);
+		*priv->folio_sz = huge_page_size(h);
 		priv->young = true;
 	}
 
@@ -524,10 +525,10 @@ static const struct mm_walk_ops damon_young_ops = {
 };
 
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-		unsigned long *page_sz)
+		unsigned long *folio_sz)
 {
 	struct damon_young_walk_private arg = {
-		.page_sz = page_sz,
+		.folio_sz = folio_sz,
 		.young = false,
 	};
 
@@ -547,18 +548,18 @@ static void __damon_va_check_access(struct mm_struct *mm,
 				struct damon_region *r, bool same_target)
 {
 	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
+	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (same_target && (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
+	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
 		if (last_accessed)
 			r->nr_accesses++;
 		return;
 	}
 
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_page_sz);
+	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
 	if (last_accessed)
 		r->nr_accesses++;
 
-- 
2.25.1

