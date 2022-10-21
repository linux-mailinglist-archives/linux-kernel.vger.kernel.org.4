Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD9607C61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJUQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJUQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7B24BAA4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y126-20020a257d84000000b006c554365f5aso3713557ybc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=esgdcnz6KGc3B9V+LZ2N8Ds4/nBZJJcBbCbHMbBwHjk=;
        b=pIJH5olO/I2dA/fnJ38RNDUNag1jCBRbSJReNXDuFWFG47O9hxJi0FrZmqRDXnMQI/
         /1xVDVB5mv31fhcLpuKcwsVOmx47jsNdpgEmx1ogSlHkiRq2gQSCkBfkeXDdnWNMRdDn
         WgoWwu2YOgG4/TAj7KoF7BJ0B/PakCZecR5Fz7AxDD2HusQ0sKx0GmA+SDCOGrHBGHKJ
         9+3IXcRAfLkNOoszDtrPaH07o7iDaKBcPTzeRh8Cc75lTqqKCgJ+kxoLRkdDPkZ1rJBO
         w37Zjh0EOVT4NqJ7iFe9EVTQT2dlpacbUdy+60R4swoG2PQ3BsajOoLaJnerCKU7XJt3
         wX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esgdcnz6KGc3B9V+LZ2N8Ds4/nBZJJcBbCbHMbBwHjk=;
        b=hXlOKougrp1L1NzAjkP9Eph4tp55PF7HFQeXy7pITp+zSFRcYo25YGcVMyIPiJJtS7
         qwqn/V+dS6u77aNSzK2s1jdcKdw5buVdlBXgxE6w7X9FSmBlxKyFt8TGh7iuJHxGiGwF
         qLuW5M4fa9i5CColDaeV+tF65dGjKE8nJZLsJtFZ4y19MM3XQB9s4IO8cvyMHyvLuSWb
         9kpYkQKLsRObTQcSm90+hT3NcyUOeHkmNdr7CQlX9vBmEd0pSROEQY8WJcMUzFhJSDTc
         o7xfnzfXvgOrky1U82d9h+qQgHtJP+6FY4sjO59JX/OqQWTDehMzZuQHHtlTnK6R/NqU
         q+0A==
X-Gm-Message-State: ACrzQf0LK0HOrs4YdP7v6wqJ7NY4cf5QYxMYH6LqhTMB0qoBSjMALetU
        q07sFvjo+N1rZmRQlTxhW/yytsBO/3tOqGgP
X-Google-Smtp-Source: AMsMyM5MFGoqy8wia1mdc/lLpWSr3NMH5TcxOdBPl8JHYJ3m/WiGfOvhhzuYtwCQ7+h6B+nksqPI0zssr+I/zZcM
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:3cc4:0:b0:6af:c67e:909e with SMTP
 id j187-20020a253cc4000000b006afc67e909emr17009872yba.266.1666370236967; Fri,
 21 Oct 2022 09:37:16 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:18 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-3-jthoughton@google.com>
Subject: [RFC PATCH v2 02/47] hugetlb: remove mk_huge_pte; it is unused
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
index a57d667addd2..aab9e46fa628 100644
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
index 2b61fde8c38c..10573a283a12 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -929,7 +929,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 	 * as it was previously derived from a real kernel symbol.
 	 */
 	page = pfn_to_page(args->fixed_pmd_pfn);
-	pte = mk_huge_pte(page, args->page_prot);
+	pte = mk_pte(page, args->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 650761cdd2f6..20a111b532aa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4728,11 +4728,10 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
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
2.38.0.135.g90850a2211-goog

