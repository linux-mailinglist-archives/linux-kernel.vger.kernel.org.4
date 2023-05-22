Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7770B485
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjEVFXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:23:31 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4CAA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:23:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba1815e12efso4784744276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733009; x=1687325009;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzQPoLjWXuP3+Ka40j/FX+cgzbLo3MyR/78LE/Otflc=;
        b=OqBANCRQzvanaas2fLT/vDBYw2XZ+pto0Z3I0g1aU/R1OYHuij2QrMo2xy+Rr6C35x
         l86kCF5UL52/GbeJlQ6bHEBRSpOVELHuSaKXNybOZhqbs+opPxUSDPmtJNEm+jrMaklN
         ft3L6EaR3I8ziuMCU5sNY2OaZ+zGmtKvbNZ9Tsv9F9B6wECrNMIjTpzlO5d+Z255LDVp
         yEk+S1bLKTQfkqEB9/oNMA15Vbb0/7X2Ek3v5V8dnbfTlUQxMGQNWKaElfOhfI5B5peu
         qIbnRaHYRIRCfQSqqRnyf0yf2fu8VPlbHJkeNdMJAA3hkVwFBfoZ10oZW3ZVmkHCSkfx
         eCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733009; x=1687325009;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzQPoLjWXuP3+Ka40j/FX+cgzbLo3MyR/78LE/Otflc=;
        b=S4jBqKp8JdodbskzYJHzAPTd8jDWsDM1BgE1xI82F5bq828e2GpRDt7Eg1wqjgWRhu
         91QFXHBeHj31sfJSHJv2ESVugylnbHWHp0TACqa3M4MvYrqeF0SdqIoNFTZB82QbvHP1
         alpAvXUF8tvn3pCRm0N4ZprPUk40vdwgAgYb1WNSPIa9fgPb1V/p6GvOc5kskZ/MOFZN
         X8+YNuFmRSVcwNhNDBuRGnS04dr7kUrlJFJn40S+K4vAlgCxwAGAopd/C7xSX3B6uH0g
         gUI7HnoWZee2CgangzwXCGjqps4m0zZSuT9a7fXtKDpu5AOXjO6u6Ib5AQueanHJ61Qb
         VjEg==
X-Gm-Message-State: AC+VfDwZGcSaJ6kt9oxSOqeHiTfGyy/tAUQ3zHah2E2h3CvxSQFqbzme
        7h5QgzCsrHX97oKgnuOutUOqRw==
X-Google-Smtp-Source: ACHHUZ7qqz3U4uOnP6Ec8LA+Qz8AEibK4IaZAP5jwPoGGf6Fy3SqZkPf36XnHstJeJW2gmcrXMZvlw==
X-Received: by 2002:a25:d2c5:0:b0:ba7:20a:3967 with SMTP id j188-20020a25d2c5000000b00ba7020a3967mr11645090ybg.43.1684733009011;
        Sun, 21 May 2023 22:23:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g10-20020a056902134a00b00b9db62abff3sm1277036ybu.58.2023.05.21.22.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:23:28 -0700 (PDT)
Date:   Sun, 21 May 2023 22:23:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 26/31] mm/huge_memory: split huge pmd under one
 pte_offset_map()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <3f442a9c-af6d-573d-1ad1-f6f413b1abc9@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__split_huge_zero_page_pmd() use a single pte_offset_map() to sweep the
extent: it's already under pmd_lock(), so this is no worse for latency;
and since it's supposed to have full control of the just-withdrawn page
table, here choose to VM_BUG_ON if it were to fail.  And please don't
increment haddr by PAGE_SIZE, that should remain huge aligned: declare
a separate addr (not a bugfix, but it was deceptive).

__split_huge_pmd_locked() likewise (but it had declared a separate addr);
and change its BUG_ON(!pte_none) to VM_BUG_ON, for consistency with zero
(those deposited page tables are sometimes victims of random corruption).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d4bd5fa7c823..839c13fa0bbe 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2037,6 +2037,8 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	pgtable_t pgtable;
 	pmd_t _pmd, old_pmd;
+	unsigned long addr;
+	pte_t *pte;
 	int i;
 
 	/*
@@ -2052,17 +2054,20 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
 	pmd_populate(mm, &_pmd, pgtable);
 
-	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
-		pte_t *pte, entry;
-		entry = pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
+	pte = pte_offset_map(&_pmd, haddr);
+	VM_BUG_ON(!pte);
+	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t entry;
+
+		entry = pfn_pte(my_zero_pfn(addr), vma->vm_page_prot);
 		entry = pte_mkspecial(entry);
 		if (pmd_uffd_wp(old_pmd))
 			entry = pte_mkuffd_wp(entry);
-		pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*pte));
-		set_pte_at(mm, haddr, pte, entry);
-		pte_unmap(pte);
+		set_pte_at(mm, addr, pte, entry);
+		pte++;
 	}
+	pte_unmap(pte - 1);
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
 }
@@ -2077,6 +2082,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
 	bool anon_exclusive = false, dirty = false;
 	unsigned long addr;
+	pte_t *pte;
 	int i;
 
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
@@ -2205,8 +2211,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
 	pmd_populate(mm, &_pmd, pgtable);
 
+	pte = pte_offset_map(&_pmd, haddr);
+	VM_BUG_ON(!pte);
 	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
-		pte_t entry, *pte;
+		pte_t entry;
 		/*
 		 * Note that NUMA hinting access restrictions are not
 		 * transferred to avoid any possibility of altering
@@ -2249,11 +2257,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mkuffd_wp(entry);
 			page_add_anon_rmap(page + i, vma, addr, false);
 		}
-		pte = pte_offset_map(&_pmd, addr);
-		BUG_ON(!pte_none(*pte));
+		VM_BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
-		pte_unmap(pte);
+		pte++;
 	}
+	pte_unmap(pte - 1);
 
 	if (!pmd_migration)
 		page_remove_rmap(page, vma, true);
-- 
2.35.3

