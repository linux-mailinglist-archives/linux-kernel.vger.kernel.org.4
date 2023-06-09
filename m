Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F157728D12
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjFIB2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjFIB16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:27:58 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24D1716
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:27:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-569fc874498so12183277b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686274077; x=1688866077;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyPFy0gUSdpV3ibLKHHJg/J/UWoL9nTKOb5gbs61iKQ=;
        b=OyAJimk3fc+/Li5me7PIcu882/+lDPwqec67fOflTDld8VWvm0ZySNcdoJgLTrD9rx
         WoOLU/XWyP4MN+Eoi7KJZTv1R6ExtbK2SMofkB2PIt1uKNhRHeS+xx4hN9Wks9SB/Hkk
         4gzmFYarU9qov9Uzj7o9h1zLdkAzYRq/b/kKfVItrvxfhKgU8iMFFvE5pQZ3kgV2up+L
         hNFZoE2nbmMWdsnJ1XbGUBg6gK5gwmUXxa01pub4RN5ECsXTRQyDMvk6goIXaQohEPKU
         wCMnLqlIXUxUsnIlKrzfLeDs5rhQwhiPDht5XmK01inAm6KH0sUkni/+00j7bluhyFK7
         RwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274077; x=1688866077;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyPFy0gUSdpV3ibLKHHJg/J/UWoL9nTKOb5gbs61iKQ=;
        b=Amj2ZZfBE1zJhGKS+OgYIko1V49Q2o1WAKfytxdhRnAs8xzzASIGk+1gF91fxOcjQv
         PceFjKd5LP/niU9HktHHRt3siGFClqGaZ/t8VwnjfWRkP1yOiT6Ibp17+WJG0D6cMova
         ypgNNqAzjDNbZDFIIzD+mGgFxjzaf3Rs7RCzYS54TuHoZ7l+vICQxGc9T8GS0TYpIRl+
         cbjv4aPn8wJ5wxxjOR0v/u2ErbCqYbHB4Y3+LQQuqRh3KQ+L2qpOQUDDAxmD6bW1cZVN
         mEI+p3HYJcwTaXTQufoe0E13GDIb94fK3c9v0EW/sD541s+Dh/v5bBoWbfTXwJmwXWxP
         q2lA==
X-Gm-Message-State: AC+VfDy7O/TYRS44rJRIWXeM02EwnNdCecexC4FP4LE0hwZ8dSj8bwYf
        TA+p2Lh2IIn6N9TG1srk7kSFbg==
X-Google-Smtp-Source: ACHHUZ5jGBBEQ5gswQSXjac3sdwb/7+VqiRoKupCeGhVPyqG0jNqvRoD86vqt+pEd3PQOO1HZrsBzg==
X-Received: by 2002:a81:8005:0:b0:569:74f3:ed2e with SMTP id q5-20020a818005000000b0056974f3ed2emr1337210ywf.22.1686274077005;
        Thu, 08 Jun 2023 18:27:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c205-20020a814ed6000000b005688ca40c4bsm291663ywb.61.2023.06.08.18.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:27:56 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:27:52 -0700 (PDT)
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
Subject: [PATCH v2 16/32] mm/debug_vm_pgtable,page_table_check: warn pte map
 fails
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <3ea9e4f-e5cf-d7d9-4c2-291b3c5a3636@google.com>
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
index f2baf97d5f38..b743a2f6bce0 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -246,6 +246,8 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		pte_t *ptep = pte_offset_map(&pmd, addr);
 		unsigned long i;
 
+		if (WARN_ON(!ptep))
+			return;
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			__page_table_check_pte_clear(mm, addr, *ptep);
 			addr += PAGE_SIZE;
-- 
2.35.3

