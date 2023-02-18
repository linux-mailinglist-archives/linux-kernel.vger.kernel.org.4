Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA869B6D1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjBRAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjBRA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6268E64
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 84-20020a251457000000b0091231592671so2246930ybu.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4SpvvUSe/+H51r29czUV8oyanUNWvkyfpCFhzIRnLk=;
        b=URp4YrNRsXrEMcz5vF68rwrPTWL0r/1PsOn0iwRwzUv8fGWjA2Zj3WsCDtOHnnEOXI
         9xQcdgSYjiC0L8FMkrysuWd8Z4rTcFfESiyb98ZDWB3Rpv8/7b3sLIWRQtcVzhoZSCmY
         1q2oSqG9SQQKP9k9222Pkp5CKnK0J5shuyy4KwIs9snSVsRw3F9uu39yYj2MkyXE/1KV
         b/75TnZWsolWJ9o2Dg5OQzts7dH32JqEhtpz0u50LcpTAXPOuZwDBizDHafxqGuZbm79
         w0zdlsUS9tlTAwK9A8se/3bTurakeHRO+WC3ta4JwV799mBHwIfC4VY+Lrp2ra7exXyR
         sdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4SpvvUSe/+H51r29czUV8oyanUNWvkyfpCFhzIRnLk=;
        b=l4nyNGIA82EOLkVfVbGmyZ9oYoEjpM40IK7WRIpknJNFsF/FP9w7aE+RyFdITyxf5H
         IDuSHPscFo9kfhk9KotlF3KUwEJp2tASZiuxALhCMli0w3MHqpNRrOQyD+ZWkCrQl+32
         Bz80GmRAutjWPpyOYFXC/EuWGbWcs4LuEXF8pWq8d/H5XJa1YaOG3KlC0sGZ9ZGXk3ZV
         qV6OftL5xkUykX+OOCnRryY9EAHXo8eO1IfTf2Crnse9JG1RuhLTCOxOZ71LXjd74sSf
         ruPZl3aFAOKpDNimYzkPfDkMkZImrgekpJdCx5H9xwcSghzT3qLQKdMtT0bDAWz1+7Oc
         5ziA==
X-Gm-Message-State: AO0yUKWVmX4X6bypioKQk/qtPd2LB6a34+Q3PaW1GdTUBP56Se3qLf1w
        1MR8nUk3Yel4xrM5wNoGvU7rfWnLQcPfv5gn
X-Google-Smtp-Source: AK7set/928+LwO6Lgp5pRPZtsNiWTzN/B8EG4aLn4PvCGnxGZvLIKoC9wr4DtxldmQEi9jOl1xJbJJDcIzKsLS/r
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:ac66:0:b0:52e:ed7f:6e82 with SMTP
 id z38-20020a81ac66000000b0052eed7f6e82mr257319ywj.9.1676680150801; Fri, 17
 Feb 2023 16:29:10 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:00 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-28-jthoughton@google.com>
Subject: [PATCH v2 27/46] mm: rmap: update try_to_{migrate,unmap} to handle
 mapcount for HGM
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

Make use of the new pvmw->pte_order field to determine the size of the
PTE we're unmapping/migrating.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/migrate.c b/mm/migrate.c
index 9b4a7e75f6e6..616afcc40fdc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -247,7 +247,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
+			unsigned int shift = pvmw.pte_order + PAGE_SHIFT;
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
diff --git a/mm/rmap.c b/mm/rmap.c
index c010d0af3a82..0a019ae32f04 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1609,7 +1609,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-				hugetlb_count_sub(folio_nr_pages(folio), mm);
+				hugetlb_count_sub(1UL << pvmw.pte_order, mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
@@ -1757,7 +1757,13 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (folio_test_hugetlb(folio))
+			hugetlb_remove_rmap(subpage,
+					pvmw.pte_order + PAGE_SHIFT,
+					hstate_vma(vma), vma);
+		else
+			page_remove_rmap(subpage, vma, false);
+
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -2020,7 +2026,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-				hugetlb_count_sub(folio_nr_pages(folio), mm);
+				hugetlb_count_sub(1L << pvmw.pte_order, mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
@@ -2112,7 +2118,12 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (folio_test_hugetlb(folio))
+			hugetlb_remove_rmap(subpage,
+					pvmw.pte_order + PAGE_SHIFT,
+					hstate_vma(vma), vma);
+		else
+			page_remove_rmap(subpage, vma, false);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -2196,6 +2207,8 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 				      args->owner);
 	mmu_notifier_invalidate_range_start(&range);
 
+	VM_BUG_ON_FOLIO(folio_test_hugetlb(folio), folio);
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-- 
2.39.2.637.g21b0678d19-goog

