Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC86632FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjAIVe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjAIVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:33:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8645F07
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:33:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A51B2B80FEA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A46C433EF;
        Mon,  9 Jan 2023 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300029;
        bh=yyLlHJ6cCbnE9uJxOcQpPH/RrlJ6RvTE2YIE61/Wx0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAy7p9Oo4rnxI8GLrmgFxMW8bg3bc0a6rhboNr/pDoTXUJa/1WuxNkcfwiaTal5Qj
         cJeU1YtDugehNEgYy10tXVIP9704KyIcYqgJB1XPyih1XgdwGsY3yB1jlftCqwGFkh
         b1BCNiOtBjwFb+W6p7BgsdAx/mZCc5js7lQHXm714dhd8gRHbQG2IVCI8+78jzBRAO
         mzwvSfk9tmeqxo4dZ2KZ0aYfYzBBBs2Rem1exKOEDzeCUHJ0A5WeVud90fEjHQDPdT
         wDwFO+awaMRvsIHUIyMf7D6mnO+NeNg60nJs3ADcB6MYMFW9ilQdwN4vbeyLBvwOkd
         B/ImoIfbYK7iA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm/damon/paddr: remove damon_pa_access_chk_result struct
Date:   Mon,  9 Jan 2023 21:33:35 +0000
Message-Id: <20230109213335.62525-7-sj@kernel.org>
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

'damon_pa_access_chk_result' struct contains only one field.  Use a
variable instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b51606519bbd..b4df9b9bcc0a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -79,50 +79,44 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-struct damon_pa_access_chk_result {
-	bool accessed;
-};
-
 static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
 {
-	struct damon_pa_access_chk_result *result = arg;
+	bool *accessed = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
-	result->accessed = false;
+	*accessed = false;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			result->accessed = pte_young(*pvmw.pte) ||
+			*accessed = pte_young(*pvmw.pte) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			result->accessed = pmd_young(*pvmw.pmd) ||
+			*accessed = pmd_young(*pvmw.pmd) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 #else
 			WARN_ON_ONCE(1);
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 		}
-		if (result->accessed) {
+		if (*accessed) {
 			page_vma_mapped_walk_done(&pvmw);
 			break;
 		}
 	}
 
 	/* If accessed, stop walking */
-	return !result->accessed;
+	return *accessed == false;
 }
 
 static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
-	struct damon_pa_access_chk_result result = {
-		.accessed = false,
-	};
+	bool accessed = false;
 	struct rmap_walk_control rwc = {
-		.arg = &result,
+		.arg = &accessed,
 		.rmap_one = __damon_pa_young,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
@@ -133,9 +127,9 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		if (folio_test_idle(folio))
-			result.accessed = false;
+			accessed = false;
 		else
-			result.accessed = true;
+			accessed = true;
 		folio_put(folio);
 		goto out;
 	}
@@ -154,7 +148,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 
 out:
 	*folio_sz = folio_size(folio);
-	return result.accessed;
+	return accessed;
 }
 
 static void __damon_pa_check_access(struct damon_region *r)
-- 
2.25.1

