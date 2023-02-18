Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B55D69B6CF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBRAar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBRA3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224F6BDF1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l206-20020a25ccd7000000b006fdc6aaec4fso2657262ybf.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRwFktkeJYIdKMusf4qC81y0TR6AbHEOFSy4VjO6bDw=;
        b=Zm6/7/QaEOKxvrDuMfeB7vwmF4lLu6UTGBUmswTJcUAlfDSMlIReG5bhg0wTj24gmC
         pyzKX/4iSeu0TJCnoaa5IeZeAwpPJP4t7J15FYcDft0GCDUyIekB7QiiA5d6VpYF6r1H
         nOxlRQfswvR4QTg+iFofMR17/iZTfwCKWd+Emo/OWhpb51k0Epcgf3/x2g21X+2fJvir
         E6KpK03FxgLoBdBKPFmKqjWGZ7c7Mw5BSnv8qT+zAW5LhNVyj/X7uCXj4k6ZrqZKQzWs
         jRtMwhX56IYmGhi9pxW4bL/oSI6T41SeQ+p8o0DKCkHwnC/wa7X1kwvdzUJ3ryjcOdKA
         7yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRwFktkeJYIdKMusf4qC81y0TR6AbHEOFSy4VjO6bDw=;
        b=6zuD6+cTjnAo9ZOucMhX7KQzXA0lrc+Pnzkkx1zo3zjGhW1v7vu1oOwz8luUMzo0Bb
         cguKoK10ttoPykd2z8k9mCb3jN359dzrDSreopHDt75jpgXqnzvBodDmNOWTRzFnaFr+
         UctmflXE5c+ImJdEpe87yKhlYAouXYQ9ZqYT2kNqORuLOZLD3woHdoIdYuOWaO6gDOVn
         QaT7R9IpdoZoFn8aKKEOg4vCifyMEhweAAtSA5I+Ai+yT4tbmk5oQ7UPCg7Q9Ub1Yd7W
         1PVa62HePTkLW/EmQ/n+94m2ZIIwDyBpB2asqkJRbjR20LRvgLHvTLjdI54BeRRgyh9u
         s5mQ==
X-Gm-Message-State: AO0yUKUGwLrspjBtDwxF0DEKMKyEUUMMZx13z6ehxrJ1SMLn+OE66lYv
        jEHshnsE11LUSQ+iJjUP3LJp1D1N1Hg7Tctx
X-Google-Smtp-Source: AK7set8dwJ3KQ5pRHgFDkybx18bdI4wSFLevnVCzXA1Or4MzQVqGPdFvHJZtBGks9A5Y7+5HxTvdx/c0MRnYUx9S
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1103:b0:8ed:3426:8a69 with
 SMTP id o3-20020a056902110300b008ed34268a69mr91121ybu.1.1676680152644; Fri,
 17 Feb 2023 16:29:12 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:02 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-30-jthoughton@google.com>
Subject: [PATCH v2 29/46] hugetlb: update page_vma_mapped to do
 high-granularity walks
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

Update the HugeTLB logic to look a lot more like the PTE-mapped THP
logic. When a user calls us in a loop, we will update pvmw->address to
walk to each page table entry that could possibly map the hugepage
containing pvmw->pfn.

Make use of the new pte_order so callers know what size PTE
they're getting.

The !pte failure case is changed to call not_found() instead of just
returning false. This should be a no-op, but if somehow the hstate-level
PTE were deallocated between iterations, not_found() should be called to
drop locks.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 08295b122ad6..03e8a4987272 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -133,7 +133,8 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
  *
  * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
  * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
- * adjusted if needed (for PTE-mapped THPs).
+ * adjusted if needed (for PTE-mapped THPs and high-granularity-mapped HugeTLB
+ * pages).
  *
  * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
  * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
@@ -165,23 +166,47 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 	if (unlikely(is_vm_hugetlb_page(vma))) {
 		struct hstate *hstate = hstate_vma(vma);
-		unsigned long size = huge_page_size(hstate);
-		/* The only possible mapping was handled on last iteration */
-		if (pvmw->pte)
-			return not_found(pvmw);
-		/*
-		 * All callers that get here will already hold the
-		 * i_mmap_rwsem.  Therefore, no additional locks need to be
-		 * taken before calling hugetlb_walk().
-		 */
-		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
-		if (!pvmw->pte)
-			return false;
+		struct hugetlb_pte hpte;
+		pte_t pteval;
+
+		end = (pvmw->address & huge_page_mask(hstate)) +
+			huge_page_size(hstate);
+
+		do {
+			if (pvmw->pte) {
+				if (pvmw->ptl)
+					spin_unlock(pvmw->ptl);
+				pvmw->ptl = NULL;
+				pvmw->address += PAGE_SIZE << pvmw->pte_order;
+				if (pvmw->address >= end)
+					return not_found(pvmw);
+			}
 
-		pvmw->pte_order = huge_page_order(hstate);
-		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
-		if (!check_pte(pvmw))
-			return not_found(pvmw);
+			/*
+			 * All callers that get here will already hold the
+			 * i_mmap_rwsem. Therefore, no additional locks need to
+			 * be taken before calling hugetlb_walk().
+			 */
+			if (hugetlb_full_walk(&hpte, vma, pvmw->address))
+				return not_found(pvmw);
+
+retry:
+			pvmw->pte = hpte.ptep;
+			pvmw->pte_order = hpte.shift - PAGE_SHIFT;
+			pvmw->ptl = hugetlb_pte_lock(&hpte);
+			pteval = huge_ptep_get(hpte.ptep);
+			if (pte_present(pteval) && !hugetlb_pte_present_leaf(
+						&hpte, pteval)) {
+				/*
+				 * Someone split from under us, so keep
+				 * walking.
+				 */
+				spin_unlock(pvmw->ptl);
+				hugetlb_full_walk_continue(&hpte, vma,
+						pvmw->address);
+				goto retry;
+			}
+		} while (!check_pte(pvmw));
 		return true;
 	}
 
-- 
2.39.2.637.g21b0678d19-goog

