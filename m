Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4E65E8C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjAEKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjAEKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474004E436
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:18:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4bdeb1bbeafso12312247b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0YYyrn/i5J+Hdl7Oce+Vi3RxVXkQH55IR2Pj2f6MRss=;
        b=OvRCq1K7vBr4jC60kQ8Em8RrEuL5pvhvHnKcAsgERc3uS+w79rqkAY+8zuKClMXYP1
         9Ko8z21BLtt7+dY9dy1V18U882pGXu/OE6i+Xr0iQPnYIyNgznMU4MIYAU10i4V8msYi
         vF8PBI3bFXNBLc45eUtC+jumcHqn1CRhScBqxVt0/BNc1x40y+nrTfMPbTVNaD7phI6p
         n1O1IlZLttIwzPlRgdc/hc2CmAd1C15Vy/o6AJ8g8UFwO7fkbcWUnHCUscKvp68diaN9
         zV3S/Vot4voCzs8e2T5wk56DNUb4ssJaLwx9z6hGPfl2a20zFaxom/8VdWD8sa1qWbzF
         3Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YYyrn/i5J+Hdl7Oce+Vi3RxVXkQH55IR2Pj2f6MRss=;
        b=fhcXL4/myGNM52DgXDv3lbc7cjcEybYuQ8OqJQwIuS3LxzSEnahPMZFigb5BaB2U+w
         bRzLtb0O/wzftA3I9hKzjhrL3UY1hlC9zvdhM/+X5mCmartI31F6+LHiODQYpvDFfTlA
         5hUI3XBNUjLN1CFaMDweTBb59Qvl41y81xBQ4X8LG/B0nh8OD3fINZRaXWRPzZX89rDm
         57s65LszxsN9MAWh4TsMs8qRSI0N3+Tm64EIaoYFFzJn1wrati4iNtzfXiGq2W2yPWXR
         62PtjARyDt+AyOs3XFBeZkK0MwZIY9HI9Jpqp9G3TJhSVsLDbDxJZ7SVlcHIRnDoqIhx
         fAlA==
X-Gm-Message-State: AFqh2kpPb3ODrmFr7hhEugSMDLyT24CoBOz758HKF283ViN2x8EM3vwo
        hjplqIwnIIG8YPkcTfhNHQXvwv6NrUQJ8sED
X-Google-Smtp-Source: AMrXdXtC8k5di86WReSiaGhD69tMGn+bIeELhRcjp6aIf2STjTrG//8SeY01j3sLTLnAywMSOT6aefEO4rMpcD9u
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:5056:0:b0:7b6:2b8f:f2c0 with SMTP
 id e83-20020a255056000000b007b62b8ff2c0mr25297ybb.46.1672913934575; Thu, 05
 Jan 2023 02:18:54 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:00 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-3-jthoughton@google.com>
Subject: [PATCH 02/46] hugetlb: remove mk_huge_pte; it is unused
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

mk_huge_pte is unused and not necessary. pte_mkhuge is the appropriate
function to call to create a HugeTLB PTE (see
Documentation/mm/arch_pgtable_helpers.rst).

It is being removed now to avoid complicating the implementation of
HugeTLB high-granularity mapping.

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/s390/include/asm/hugetlb.h | 5 -----
 include/asm-generic/hugetlb.h   | 5 -----
 mm/debug_vm_pgtable.c           | 2 +-
 mm/hugetlb.c                    | 7 +++----
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index ccdbccfde148..c34893719715 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -77,11 +77,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte(page, pgprot);
-}
-
 static inline int huge_pte_none(pte_t pte)
 {
 	return pte_none(pte);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d7f6335d3999..be2e763e956f 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -5,11 +5,6 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte(page, pgprot);
-}
-
 static inline unsigned long huge_pte_write(pte_t pte)
 {
 	return pte_write(pte);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c631ade3f1d2..643cce3493cc 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -900,7 +900,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 	 * as it was previously derived from a real kernel symbol.
 	 */
 	page = pfn_to_page(args->fixed_pmd_pfn);
-	pte = mk_huge_pte(page, args->page_prot);
+	pte = mk_pte(page, args->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b061e31c1fb8..7e9793b602ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4870,11 +4870,10 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 	if (writable) {
-		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
-					 vma->vm_page_prot)));
+		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_pte(page,
+						vma->vm_page_prot)));
 	} else {
-		entry = huge_pte_wrprotect(mk_huge_pte(page,
-					   vma->vm_page_prot));
+		entry = huge_pte_wrprotect(mk_pte(page, vma->vm_page_prot));
 	}
 	entry = pte_mkyoung(entry);
 	entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
-- 
2.39.0.314.g84b9a713c41-goog

