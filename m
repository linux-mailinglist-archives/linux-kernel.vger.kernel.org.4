Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C1F65E8E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjAEKWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAEKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6956D559FA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t13-20020a056902018d00b0074747131938so36503973ybh.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yt8Zfl8fNE6CjUoa2m2ZbJ28GLtsXtxPk8weKgz6Sk=;
        b=mmJynU/TU9vgbAWdVBnooR6qbWy6e6Xt4HjkahKPBivEshc97MtogxTwIBRYXaYqJ0
         fSpmPH7oyypf8QtZl1TBck6C8Qnc5vP3vXChtZzIua5/HPzB+uT2N0El75+vpSdXgb3I
         fXUucvYApqmIOdNMwmWBYNiybAbob8pq547IG5xhW67a2+7RxSBPQsKdkno0G9NfjnHR
         vThJc94sL2B5jTo0R162NfJZTasyE6NQSOqGcbgqMDv7BN8cJUhlAVO1ikA07733qw6v
         J0FL1bdTenfsSmm7z4ZB7CRnQWtuNtJNF7SWWWGOq6wzEvgYIHYppRVKiHaPtU8vk09q
         t6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yt8Zfl8fNE6CjUoa2m2ZbJ28GLtsXtxPk8weKgz6Sk=;
        b=cXo5JUEh4o8GWtFh0oryi0iMbw+nEYMwepqaRK37DFNyHS3xixrNsxy4GnAhhfESbO
         9Cc+Cq3cT/mYzX2t9pxUg03ukXJ8lpJgCRRqcW2Yt0P4lj5u2wFhx+DvB46SKjN4/JVh
         wI5wlL7udYE7HTWNkeMVcA/r9zlqCdwAGo5W7XqMlM/7LJRDbRyMjzjVjM4Nv8flAxYe
         Tl8FDnvyy0Dw/NzR8+6iK+n9F9xdJq3gaIlBS9FxAayJ3WDmnmFrYcyJEg0BWHETQT5P
         npn259uRI1jWaOJ1o6NGg1SnMWgcMbWkFOiUPiF1hMA83mfX0URmJCGaQteSQUy7q9zz
         D0Jw==
X-Gm-Message-State: AFqh2ko+AcwQSKmLOxIONL3y7Ua3XET/wdCAa6h/3QWWjeX7nRkD+wsj
        zK3FLGeOLD6lWvNihQTecY0ehcRN0CF9cWL0
X-Google-Smtp-Source: AMrXdXuVcGaIehPK3ggZHRYdepJOSa1ZuL0a2MndWjzlHZKir2rPDwMHed4R9zmgcZPJJPozNStrKME793+njzVf
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:5056:0:b0:7b6:2b8f:f2c0 with SMTP
 id e83-20020a255056000000b007b62b8ff2c0mr25432ybb.46.1672913971225; Thu, 05
 Jan 2023 02:19:31 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:23 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-26-jthoughton@google.com>
Subject: [PATCH 25/46] hugetlb: update page_vma_mapped to do high-granularity walks
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
---
 mm/page_vma_mapped.c | 59 +++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

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
2.39.0.314.g84b9a713c41-goog

