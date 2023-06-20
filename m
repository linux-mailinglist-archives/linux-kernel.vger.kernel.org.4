Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60237363D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFTGuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTGuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:50:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD5B1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:50:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57083a06b71so35803397b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687243813; x=1689835813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/bRJJ7HKAxHd08pJcszqvVk2aL6jH9Ld13vowySjkQ=;
        b=Vz0vexlm8Fi1kRWWLKFH0afGyZbpoHfUCJFGK5u6d1yfX9pcmaTaF8B9KhDWYwm1jW
         Z3OHmDGoXUe3JhXcUAbF965Onew9srRDivZSbN3wndiTA6j7qLe46+c7OONnoi1awyTP
         PxuAvKUdhV9NZgbHaRPq9uuToBYnY7B3RKXHUc3DgHDN4+2mhVMJWHieVVS5XvM7nsua
         94bKAJ2uPjOf+d8ibOrtydWioDkIQYoSfFcweFsuWKU+f3lbQACGTY8l9iGBLIH2Kqz6
         q1zwm0178oZv/vq0nCnIzWVviStyiAH7Q6JscZHrNhFJ3utksGPBC2KEKTxPj80uNjMh
         YJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687243813; x=1689835813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/bRJJ7HKAxHd08pJcszqvVk2aL6jH9Ld13vowySjkQ=;
        b=jgRpP0eRYcwv67MHXXt+nhBc4MMmClldGBOK5kO0TNgYrwiBc+Hmlj/LGP9lEsKoJt
         xhFxT0zTniCotLriBs2GkJ3nifdw+61OAi7+f1lL/PHHXpaKkhyDT7EUJUkL/M5FkTZQ
         aDIPnWzaorJX4b1PErKeLxZFPmz9B7NleGCsp1o0axv74bKfBV5LCIjbs0gr4gMscwDe
         RY3KKlbYeuQhPAQ2WQon1wWfeLyKM0molfLZE+/KQyhf97ETAjXtsBO4KdLU9NwCSBrB
         EfNPgadF78h9AEBXVL7SndSSZwWrSTN11YGAWbAdCbAG/7pRP9RtmxFFWwPt/aChvX22
         tK1Q==
X-Gm-Message-State: AC+VfDxqM012fqSK3m3/UB54OziMHK5twEP5zop3uS40O1j+FwJfy6Uw
        SgNvQRF+V1IDUzwgQoIN1f779Q==
X-Google-Smtp-Source: ACHHUZ6xe3gTMi2H2TKLGiqQf2yXBFKo4zstK8P2uGDdenyDLR1k6x+/t7pyX3iqc5ah0hb++0ZtyQ==
X-Received: by 2002:a0d:d412:0:b0:56d:3402:b9a0 with SMTP id w18-20020a0dd412000000b0056d3402b9a0mr11226869ywd.14.1687243812830;
        Mon, 19 Jun 2023 23:50:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w1-20020a818601000000b0057328423a05sm356123ywf.80.2023.06.19.23.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 23:50:12 -0700 (PDT)
Date:   Mon, 19 Jun 2023 23:50:00 -0700 (PDT)
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
Subject: [PATCH] mm/swapfile: delete outdated pte_offset_map() comment
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <9022632b-ba9d-8cb0-c25-4be9786481b5@google.com>
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

Delete a triply out-of-date comment from add_swap_count_continuation():
1. vmalloc_to_page() changed from pte_offset_map() to pte_offset_kernel()
2. pte_offset_map() changed from using kmap_atomic() to kmap_local_page()
3. kmap_atomic() changed from using fixed FIX_KMAP addresses in 2.6.37.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Here's a late "33/32" to the series just moved to mm-stable - thank you!

 mm/swapfile.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12d204e6dae2..0a17d85b50cb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3470,11 +3470,6 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 		goto out;
 	}
 
-	/*
-	 * We are fortunate that although vmalloc_to_page uses pte_offset_map,
-	 * no architecture is using highmem pages for kernel page tables: so it
-	 * will not corrupt the GFP_ATOMIC caller's atomic page table kmaps.
-	 */
 	head = vmalloc_to_page(si->swap_map + offset);
 	offset &= ~PAGE_MASK;
 
-- 
2.35.3

