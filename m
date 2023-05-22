Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148AC70B47F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEVFTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjEVFTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:19:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C21A0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:19:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba1815e12efso4782697276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732787; x=1687324787;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooTKFpGgFIG6tpdJyTdSPdnhROWHUT8BFdRqrlDYiG0=;
        b=c16Z4sMpjKlgLDYv6Gs/y1EYdzJZLSgcmaTkBaIf9Gh+M6R5Fj28OTQhOSCRw7EEv5
         CoXdOMLH5hzAb7ctwTVEzalqQl9a+Um/b9wFPM2bKdaAzb1WrTE0ZJDEimE6nNgaQriX
         ekKs2u5sm5n3wdVCVhRqBQ64w5hCu6jc8AAKpTKma9h0EDNZhsm+d/uAlNMvz+IWh9Vi
         IdWQzCcYU/nxwQLTQZI99miGWNLqkFHHVO984XkRjgpZ7eBUTR4yIiwEf+nz+MbqBbbu
         qrDeOVuSWS3vwtPVFhgFnPNPF1tXG11tH/YIDKTxJb7j0INA2XTKzLvkIppZ9XEZec1f
         V+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732787; x=1687324787;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooTKFpGgFIG6tpdJyTdSPdnhROWHUT8BFdRqrlDYiG0=;
        b=DaTL7e5aD33N1gGI1a7WC6VVwlPGZb1UlzX0mp2ARQDjUT37Oe1u9GPay7Zn0Zo9ef
         lTbgPmJwJqCvY3bXqcCpznwoaH/zUC1jS6uWLm97JhlVURDrXYoPkWe+SlrTuNxVFmcb
         /aS7MyRu5Ojf6c+lBWKceYUhLFb59Rggg1S5u00SIBUTPL3OfHKO0ZW675F83cOehQFZ
         Qzp14pne63gvxukYbdKi8GNTfxJ0SVC+HTtVFGomd5p0KJUz2Rrz3Sb5I5FbCXkDD9xt
         GXj8mLpufM1EEw2jUcapMbhuhjImPfzBYTntFotI60cCoPBLHKvJ+LMzH1KdMimZw0lj
         Z21w==
X-Gm-Message-State: AC+VfDx+IDSUnkZ/4y9kPCDLoxb0yG6drBx5sEstQtTzBVpVL7kbEAtG
        UaT+AVIw/X405i5OHF6B/H7oyw==
X-Google-Smtp-Source: ACHHUZ4/iOac0pg6azmy6Y4+9ZIQvlTnkM+d3E/2233dtMLIq4uN1+AwZtw93iYqYZBi+HEHW+NHVQ==
X-Received: by 2002:a0d:d743:0:b0:55a:59cb:4c1a with SMTP id z64-20020a0dd743000000b0055a59cb4c1amr9770012ywd.14.1684732787446;
        Sun, 21 May 2023 22:19:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o9-20020a817309000000b00556aa81f615sm1809311ywc.68.2023.05.21.22.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:19:47 -0700 (PDT)
Date:   Sun, 21 May 2023 22:19:44 -0700 (PDT)
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
Subject: [PATCH 23/31] mm/mglru: allow pte_offset_map_nolock() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <242721-1e64-845e-226a-bf2b2dc72dd@google.com>
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

MGLRU's walk_pte_range() use the safer pte_offset_map_nolock(), rather
than pte_lockptr(), to get the ptl for its trylock.  Just return false
and move on to next extent if it fails, like when the trylock fails.
Remove the VM_WARN_ON_ONCE(pmd_leaf) since that will happen, rarely.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/vmscan.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d257916f39e5..1c344589c145 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3992,15 +3992,15 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
 
-	VM_WARN_ON_ONCE(pmd_leaf(*pmd));
-
-	ptl = pte_lockptr(args->mm, pmd);
-	if (!spin_trylock(ptl))
+	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	if (!pte)
 		return false;
+	if (!spin_trylock(ptl)) {
+		pte_unmap(pte);
+		return false;
+	}
 
 	arch_enter_lazy_mmu_mode();
-
-	pte = pte_offset_map(pmd, start & PMD_MASK);
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
@@ -4041,10 +4041,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	if (i < PTRS_PER_PTE && get_next_vma(PMD_MASK, PAGE_SIZE, args, &start, &end))
 		goto restart;
 
-	pte_unmap(pte);
-
 	arch_leave_lazy_mmu_mode();
-	spin_unlock(ptl);
+	pte_unmap_unlock(pte, ptl);
 
 	return suitable_to_scan(total, young);
 }
-- 
2.35.3

