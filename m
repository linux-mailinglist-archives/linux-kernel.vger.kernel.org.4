Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB90965E8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjAEKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjAEKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725F5559E7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e12-20020a25500c000000b007b48c520262so1904388ybb.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PQiqeYYa8WUfPyd+HQWnupwn9/KSP4leVRdHky4yOM=;
        b=d8vpxkw4cTLgxinECDNkHM+FwEcUinhdEQd7152gUdKOFJEIQWa1NKtdQXLphkyKcT
         bpdH2lMDTgH/beB2g0VRtLMbp+YcroXFdVWLsiB6oveY6i22u5iwTllcBXk4KZYEr5Lx
         jObYGpas5lPGHqnShPWhNo4LAECP+oEcPhuNZUZ42WhflXI8bNSy0hV3UJuJvQz9gAgU
         aaKzW0AsLx6ESc+6vZVPFmko4ZGS7CpMbtELN0GU2kUY+xSiGVcH6pE6avyLi3c5Nfa7
         BUv7WnFzE7GEtpQgVFx2SZ3xKkQNMHAOjJODDJtAiHOnqYYOeN0dJ26YV8xiaDyNelrQ
         A/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PQiqeYYa8WUfPyd+HQWnupwn9/KSP4leVRdHky4yOM=;
        b=ai0elht5qYDCtIAyphQjSHum/aQ3uPL3cBT/cTQQs7w8pz+t5pJXXsXBzhc3a5WQH6
         pqcmi2rPtAJQC9Duq98oTFdijlb9IVg7vP+m3Fc8Pp3wo5PEEJvBCa041nUYDZd+zDXv
         /Q1vAQYWrid5s2D2Ik5it4ZsTVl4igBiWRAJ5JCbyf6CapSuljORMMMOmewoy3LB/xcl
         9RLj5pxKdlITFHN7ANvjFpIzGWRtiGAyDBVH17WQPJCie5+XL7xvmygFyNglsHpVqOhe
         cB5d16eu/mbgTsRcmokBrRyi/BHtyazZdu/n35EQiwpZZKjRl4W0dbRCrKAXIryyc5Hw
         jn7A==
X-Gm-Message-State: AFqh2ko2f8FURqgnw0/LxvONnffsEw3FH8vIc/OkKLFcUZ5WnDpCi049
        LPI6wPf76VX+Y7YHoRjegWE2BMXlGbqNKx9Y
X-Google-Smtp-Source: AMrXdXuHdxtCjAeXg0wpQsCwfeAOcMgREXgzkYqYmxQ5/aPde2G7xFjeSk9hNA3xk1wNawTqTTGKNIYZYTNmO/5v
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:ab26:0:b0:703:481:a16b with SMTP id
 u35-20020a25ab26000000b007030481a16bmr4722307ybi.301.1672913968726; Thu, 05
 Jan 2023 02:19:28 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:21 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-24-jthoughton@google.com>
Subject: [PATCH 23/46] mm: rmap: make page_vma_mapped_walk callers use pte_order
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

This also updates the callers' hugetlb mapcounting code to handle
mapcount properly for subpage-mapped hugetlb pages.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/migrate.c |  2 +-
 mm/rmap.c    | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 832f639fc49a..0062689f4878 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -244,7 +244,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
+			unsigned int shift = pvmw.pte_order + PAGE_SHIFT;
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
diff --git a/mm/rmap.c b/mm/rmap.c
index 8a24b90d9531..ff7e6c770b0a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1608,7 +1608,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-				hugetlb_count_sub(folio_nr_pages(folio), mm);
+				hugetlb_count_sub(1UL << pvmw.pte_order, mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
@@ -1767,7 +1767,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (folio_test_hugetlb(folio))
+			page_remove_rmap(&folio->page, vma, true);
+		else
+			page_remove_rmap(subpage, vma, false);
+
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_page_drain_local();
 		folio_put(folio);
@@ -2030,7 +2034,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-				hugetlb_count_sub(folio_nr_pages(folio), mm);
+				hugetlb_count_sub(1L << pvmw.pte_order, mm);
 				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
@@ -2122,7 +2126,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+		if (folio_test_hugetlb(folio))
+			page_remove_rmap(&folio->page, vma, true);
+		else
+			page_remove_rmap(subpage, vma, false);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_page_drain_local();
 		folio_put(folio);
@@ -2206,6 +2213,8 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 				      args->owner);
 	mmu_notifier_invalidate_range_start(&range);
 
+	VM_BUG_ON_FOLIO(folio_test_hugetlb(folio), folio);
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
-- 
2.39.0.314.g84b9a713c41-goog

