Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2766E728D50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbjFIBxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFIBx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:53:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C761BF0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:53:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565d354b59fso12395647b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686275608; x=1688867608;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qSmbn7bhjg3RT15iglmwv4R1gESGfbvlyrc9z9nPg=;
        b=W1vFMPtinSndBcBgNlPbjuG1vI+MS4h79C73H3xECr5w/wVd+ID5QFfuBCbZ7w3Ayy
         CqgKuvbsR/UytKoF7Wy8rKKREq+DfXmPMzwuIXXWHCfXjS6w2FOZgMYNRgBe70zqe7iJ
         hE/jG7WdGUizvK/G6fx0GyFk9oLfadtxrkg+RkvFJ+RmYzOn5qIxJuKlmaDNTeDZEEE4
         Q9LEWq0qVGafHnb3ONnwEEktOqfHdhe87GaAA+HqXKGM3CI972T54tFojES5P7841qpO
         GKVXJvYG8HirDB7MzuADX+/RcwH8/w5ThO2DEpKlo8tc7BvvsNgYXTbXSVtPO7qfqPxu
         lwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686275608; x=1688867608;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++qSmbn7bhjg3RT15iglmwv4R1gESGfbvlyrc9z9nPg=;
        b=AgVvCe2kH4GO1vNojGZuBJ9msa0AK0i9PIUN6aTbWEa75b9GwZB1r9NeO2e7F9BwSQ
         Qh5WIuAnM4wdqrrMgnQ2iIDwve9A540Ue+gFcWmbB+zKnD7X/s0DWNU9lpmxff+NCvmB
         3oNhurgdGgvQwJ2mgfpWGDi4zW5PuTX7UOx4RhOARWFdJMDOvR2vFlcwSUT8At2FLdGt
         cFk3TmFLOVzhH9qNrkLrPbp9Kr4IDOYPjeKnVJW4xNcBB7Ie5TvUC+nxYPrS+I72Altg
         X7W4KRfuo688K/cI3+iwN/jMOcb7vJRW7pnM6c+7gWhMtCs5Pp6ckuOOMpKpNCodom5b
         R0Xg==
X-Gm-Message-State: AC+VfDyLaYLAHR/0eeefc3YItjgSUiXGI+H7KPNZBIds9be+CbARV32G
        vNUmD8wnApGJgZASRPuDy4DdPA==
X-Google-Smtp-Source: ACHHUZ7ms7OAKGCZkRczhA1SWfMIL/NPHAZni0NvY//Wj9lDtLQhlFsfX2EowXAYpVWs6Ek/Wh+UAA==
X-Received: by 2002:a81:8403:0:b0:565:eae8:793b with SMTP id u3-20020a818403000000b00565eae8793bmr1235947ywf.25.1686275608094;
        Thu, 08 Jun 2023 18:53:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r125-20020a0de883000000b00568c29c3c4csm307485ywe.38.2023.06.08.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:53:27 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:53:23 -0700 (PDT)
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
Subject: [PATCH v2 32/32] perf/core: Allow pte_offset_map() to fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <a194441b-63f3-adb6-5964-7ca3171ae7c2@google.com>
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

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offet_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
This is a perf patch, not an mm patch, and it will want to go in through
the tip tree in due course; but keep it in this series for now, so that
it's not missed, and not submitted before mm review.

 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db016e418931..174be710f3b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7490,6 +7490,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pud_leaf_size(pud);
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
+again:
 	pmd = pmdp_get_lockless(pmdp);
 	if (!pmd_present(pmd))
 		return 0;
@@ -7498,6 +7499,9 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pmd_leaf_size(pmd);
 
 	ptep = pte_offset_map(&pmd, addr);
+	if (!ptep)
+		goto again;
+
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
 		size = pte_leaf_size(pte);
-- 
2.35.3

