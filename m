Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8F65E8E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjAEKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjAEKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:52 -0500
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9215568AE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:37 -0800 (PST)
Received: by mail-vs1-xe49.google.com with SMTP id d187-20020a671dc4000000b003c3a754b594so8077740vsd.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OkucptRSHaE2jww1tz6Gz5twfCMvXYe7c+PeOdayik=;
        b=iSGNYib6WI9KvfmqIGZ0i7Vk1UHRi9UDSqMCmoRyiWYTjMJCfkdilKxemSSs37rmEB
         LHey9zQAKiluMdfQLrqTJC18PcagtYORncHX8xb4slmIglKAK8i5xsLn8irb+SQa5QzI
         4QtmQAfki38HB20NjnEKifiLax0woXit1rzbXzd6DiZJt4TmQVa8Cw2yCoz++5MjYfVN
         pYOtQPvRLchwdc3u+rabZTzy1X2ezxmhCkcFxceEMFn6sa9jw6mf0hk0rjrfbLUnoyi1
         4OF7tPUD2sGPQORVj4TOgSn8kcTeH6qegdWylrCr5/p3m+hVSlBOd7UYhD1rHychySU9
         7SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OkucptRSHaE2jww1tz6Gz5twfCMvXYe7c+PeOdayik=;
        b=0sqPzHhhximMH3UFFyHVd5G8D9053dqgrrhpsiOqMT6x79mFT2R42ZtZ6nPJDbHQnO
         /zoPyvDKq8FjdkA6n9WOxr7BcvggELuFAP/1wbutc1EQ9zvy3zNg0bGRT8ITNHNi8Mb9
         y9EGIGUD3UavitFwFBMfmTgygSduzuqq7rw6OlFKA0aHOP1wEUMHu6Kcz1MZaI3zR6V0
         o4I3TsN6VdOn+Q6CYdHvs8z8KV6MRLHpoMZtxJ99kFr1yQ4znfeaCea1UBtnF2qaNynW
         lGv0u0C9+ZqXDu31KuyFoNjyGQFNK5SegHOFf8ptm42aGwui2fhux1VVwYMdYs9G4r54
         WC/w==
X-Gm-Message-State: AFqh2koWSrscDzhgeuVD1UpmMurIPTV3WZJgp65nZZkvh+VK3teZ3OSR
        +auZfQkyAiwPUJEo2ICvJggY/5buP0EvC8ae
X-Google-Smtp-Source: AMrXdXuvwrh8nHt5LTtM5ZzmX7uEySb+WBxPJnc+22e/KgH4n1viiq8PVmwhxdb0dwfC5zkTILrp/OH5b2XpbHmH
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ac5:cbcc:0:b0:3cf:a8e:4620 with SMTP id
 h12-20020ac5cbcc000000b003cf0a8e4620mr5931022vkn.31.1672913976826; Thu, 05
 Jan 2023 02:19:36 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:27 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-30-jthoughton@google.com>
Subject: [PATCH 29/46] rmap: in try_to_{migrate,unmap}_one, check head page
 for page flags
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

The main complication here is that HugeTLB pages have their poison
status stored in the head page as the HWPoison page flag. Because
HugeTLB high-granularity mapping can create PTEs that point to subpages
instead of always the head of a hugepage, we need to check the
compound_head for page flags.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/rmap.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 076ea77010e5..a6004d6b0415 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1456,10 +1456,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	pte_t pteval;
-	struct page *subpage;
+	struct page *subpage, *page_flags_page;
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	bool page_poisoned;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1512,9 +1513,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 		subpage = folio_page(folio,
 					pte_pfn(*pvmw.pte) - folio_pfn(folio));
+		/*
+		 * We check the page flags of HugeTLB pages by checking the
+		 * head page.
+		 */
+		page_flags_page = folio_test_hugetlb(folio)
+			? &folio->page
+			: subpage;
+		page_poisoned = PageHWPoison(page_flags_page);
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
-				 PageAnonExclusive(subpage);
+				 PageAnonExclusive(page_flags_page);
 
 		if (folio_test_hugetlb(folio)) {
 			bool anon = folio_test_anon(folio);
@@ -1523,7 +1532,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * The try_to_unmap() is only passed a hugetlb page
 			 * in the case where the hugetlb page is poisoned.
 			 */
-			VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
+			VM_BUG_ON_FOLIO(!page_poisoned, folio);
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1606,7 +1615,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
+		if (page_poisoned && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(1UL << pvmw.pte_order, mm);
@@ -1632,7 +1641,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
 		} else if (folio_test_anon(folio)) {
-			swp_entry_t entry = { .val = page_private(subpage) };
+			swp_entry_t entry = {
+				.val = page_private(page_flags_page)
+			};
 			pte_t swp_pte;
 			/*
 			 * Store the swap location in the pte.
@@ -1831,7 +1842,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	pte_t pteval;
-	struct page *subpage;
+	struct page *subpage, *page_flags_page;
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
@@ -1911,9 +1922,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			subpage = folio_page(folio,
 					pte_pfn(*pvmw.pte) - folio_pfn(folio));
 		}
+		/*
+		 * We check the page flags of HugeTLB pages by checking the
+		 * head page.
+		 */
+		page_flags_page = folio_test_hugetlb(folio)
+			? &folio->page
+			: subpage;
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
-				 PageAnonExclusive(subpage);
+				 PageAnonExclusive(page_flags_page);
 
 		if (folio_test_hugetlb(folio)) {
 			bool anon = folio_test_anon(folio);
@@ -2032,7 +2050,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
 			 */
-		} else if (PageHWPoison(subpage)) {
+		} else if (PageHWPoison(page_flags_page)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(1L << pvmw.pte_order, mm);
-- 
2.39.0.314.g84b9a713c41-goog

