Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D184728D32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbjFIBlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjFIBli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:41:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC118C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:41:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565ba6aee5fso11407947b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274896; x=1688866896;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rqctUCF3S3JfLMZMEb80lefSOXfBunLGXTWgvpiAkU=;
        b=ZUnTRtdJaKuP8HpCFk7QtfKJXS4h7TMBZvOJMvdH3Kb9GiIDkKt+HetF/u5hNY0iBZ
         C1Kvof77sPcx1H7YMQXI4g7GvGYj+dOG69GUGVHoheyoLtvIX7JK20pKUCPc88Hz5F7K
         1vDSIi4a6aoe2Zceom9Svwsk2YImxUMqdpYy3MpT8APM++H9OeEHUgaErR5PTJoWvDnG
         Ooj+D4UNVVjEzEkwYMDebnqNIzPrU3Z0+Y3Vz1q/c+oe13fguEZcDxrw/xPw7f0EQgh9
         2MxgqZ31UDTio0TPV7BeKiTntn6xKzAMDwB1lip/A72zUIdR7jZaKNlHZ1NNT8xv0XOp
         wchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274896; x=1688866896;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rqctUCF3S3JfLMZMEb80lefSOXfBunLGXTWgvpiAkU=;
        b=RROmMbfz1k8qf8gEMcbUyn8M/bRnEckjvMw4Ma1pJkd27czc0XA93mzHL9LQK82Mq8
         KSVXtKAxUjCQ+O3UlaktpHt6LZoBx+tIgddsv4Yr7Jt7WaaVwUaxbEoyoyBEE7SIoH/j
         RHzASwBaQhQiTJQlCRx1NXu1fTt9U/4QCPMcSHJo80t7EZjNOwwFVoS5Ni9yNGVv2RYK
         PD/X8+SrFEMJe3ctFewYAXWTD+Ieuf9JGTGfOA8DMKhpjYdHlIayAV4V3H4hZKmNbqs4
         I2b9MvypKd9912Qoy4jKyEwolf/1TQSYMfyNW4qGlOpdZNrL2kpu2BW4+Yc2kN882xtU
         EtQQ==
X-Gm-Message-State: AC+VfDzMkKux4Z4ZQON/GUU78BcMaRsleyZLm8NG31Q6T3L3HL6IXRtl
        drXgZbJCCmpgr/ZsxottIy0jkA==
X-Google-Smtp-Source: ACHHUZ4dqn2pyv+NnV1us+V+eC0MmFm8NCi0bji00YqYjgvIjBIANrUXMpCs8h/qJKTmj/xoG04trg==
X-Received: by 2002:a81:6d04:0:b0:565:d3f9:209e with SMTP id i4-20020a816d04000000b00565d3f9209emr1374109ywc.34.1686274896335;
        Thu, 08 Jun 2023 18:41:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r205-20020a0de8d6000000b00559d9989490sm304902ywe.41.2023.06.08.18.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:41:34 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:41:31 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 26/32] mm/huge_memory: split huge pmd under one
 pte_offset_map()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <90cbed7f-90d9-b779-4a46-d2485baf9595@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
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
Reviewed-by: Yang Shi <shy828301@gmail.com>
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

