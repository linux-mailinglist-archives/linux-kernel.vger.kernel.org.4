Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A220270B45A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEVFJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjEVFJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:09:31 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEDA130
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:09:00 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561bcd35117so70117817b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732137; x=1687324137;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rTGIbKCcYdvVJu9Ybd88rQGNMtFs0WCnevY0u3jIzc=;
        b=FWm+aAqCrTI8L5F1peTncvX2j+gJ1K5pdecyQ2SgwMPmXn8TR/t30T7yAueI1Z1Prx
         +ZNB4HFJeDGCEa3TY+DbZFPXAQMoW0lt0/cPYFkOtZn9pNtwNaAji3QwKEg49ie0wiso
         /aqMK319Yal/5gxVXR6hyaD4EBzJg8qItdk0tBwwmogEtt3sYbaEVCj54AVP/iyafLSN
         g3n7sbdycHd6xijbyr/rauTFVAs7KxoLkcQWJDCzbFut9bVjwaE8Xx0Mf3/CDuWrY3hk
         wIWhl9hSpGsCek8QZILjryCAxN2GrBpCITRg0NVy+fYzjrAIzOzQeSq16gHJmxidsl5V
         /Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732137; x=1687324137;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rTGIbKCcYdvVJu9Ybd88rQGNMtFs0WCnevY0u3jIzc=;
        b=hOsWBwHH0w7/3YIZ04LkX87D6UukroLP1iiw1SRI9Z/6VOJm0fvTXorldxsFT3qZl4
         5XyzR549eVJvdFAk53oigyG+jGjmIGUH8+TI/FMk2n4n4exizuocG2iwE2sgRjdvtA5E
         KVCX3aQbF5e8OJwAYOSGkjiDtWTlQ+iPOZPfrsuKtT1oFw0Dd6jogUnoeDc3e2BbtBWS
         4nBEKvv7xnO5i7J2SWkHGAWsHqEZAbXy0vZWzisErAGiTy9bsc2XB0Nmctlo67P3XmLH
         v/ViPFAUu30Vp2iNKdy89i2nqxP+8sgfKkcAKEWLVEt/MGwf6w20dZt2egzSP/ZbRAJn
         9BZw==
X-Gm-Message-State: AC+VfDy1R3bw8pf6v+xau4p6GzMvwMlNDfPDW+e8vwQUBzSUSbS/JYu4
        +qzNzCIVp4+85m1eRlLqo2NzxA==
X-Google-Smtp-Source: ACHHUZ7MEfF9deLoAIS2DPpctOmVhab2WCwoG7BFDeIpVNW1XvRRPWqoYkqwVwVotMomYmO1i86qzw==
X-Received: by 2002:a0d:d74a:0:b0:55a:14df:5c10 with SMTP id z71-20020a0dd74a000000b0055a14df5c10mr12334350ywd.18.1684732136920;
        Sun, 21 May 2023 22:08:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t67-20020a818346000000b0055a503ca1e8sm1804176ywf.109.2023.05.21.22.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:08:56 -0700 (PDT)
Date:   Sun, 21 May 2023 22:08:53 -0700 (PDT)
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
Subject: [PATCH 16/31] mm/debug_vm_pgtable,page_table_check: warn pte map
 fails
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <87c0e8cc-85c0-806e-da9f-b7b3cacde7d@google.com>
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

Failures here would be surprising: pte_advanced_tests() and
pte_clear_tests() and __page_table_check_pte_clear_range() each
issue a warning if pte_offset_map() or pte_offset_map_lock() fails.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/debug_vm_pgtable.c | 9 ++++++++-
 mm/page_table_check.c | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c54177aabebd..ee119e33fef1 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -138,6 +138,9 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PTE advanced\n");
+	if (WARN_ON(!args->ptep))
+		return;
+
 	pte = pfn_pte(args->pte_pfn, args->page_prot);
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	flush_dcache_page(page);
@@ -619,6 +622,9 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 	 * the unexpected overhead of cache flushing is acceptable.
 	 */
 	pr_debug("Validating PTE clear\n");
+	if (WARN_ON(!args->ptep))
+		return;
+
 #ifndef CONFIG_RISCV
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
 #endif
@@ -1377,7 +1383,8 @@ static int __init debug_vm_pgtable(void)
 	args.ptep = pte_offset_map_lock(args.mm, args.pmdp, args.vaddr, &ptl);
 	pte_clear_tests(&args);
 	pte_advanced_tests(&args);
-	pte_unmap_unlock(args.ptep, ptl);
+	if (args.ptep)
+		pte_unmap_unlock(args.ptep, ptl);
 
 	ptl = pmd_lock(args.mm, args.pmdp);
 	pmd_clear_tests(&args);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 25d8610c0042..0c511330dbc9 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -240,6 +240,8 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		pte_t *ptep = pte_offset_map(&pmd, addr);
 		unsigned long i;
 
+		if (WARN_ON(!ptep))
+			return;
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			__page_table_check_pte_clear(mm, addr, *ptep);
 			addr += PAGE_SIZE;
-- 
2.35.3

