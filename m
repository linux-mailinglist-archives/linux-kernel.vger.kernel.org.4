Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B172F356
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbjFND7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242477AbjFND6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:58:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61211BD3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:58:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bc5566538fdso255539276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686715118; x=1689307118;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=32HdmVOewK5uBWcPqCzKK7B9PyAlOQ6MrudxZirB7g0=;
        b=y+wiz6YEOG+gFWvGvLIELTfeOFEEjmj6VmaR4l5TEimPZrrRLWRSt67ByLkFBEMR+v
         bCP9oADXmuV0X+UBXpkPh4CBHLVb9CeP7vecSyHdtjJV2q0LIZM6RCX3/ZfE6OLeWFuI
         RiYBtFemg/LsWw9EhkVn/sj3pOi+OiGTz8E7ryhSTLpImY9d2aChiJnI96YcSsN8AOPd
         hjqxszOZWh9Q2sMO5YuVZzDVyhYrY/tnHRLv39XACFcZROvrM2V8a8bWDGtUlzxxP5x2
         TRoeM13pnRcG1mCAxxo6J+bKVlILKRbVPh5FsuLuBv2UjtpOiUABzvEcJZliHrpOEVfZ
         D1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686715118; x=1689307118;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32HdmVOewK5uBWcPqCzKK7B9PyAlOQ6MrudxZirB7g0=;
        b=Ealp4TRVMK3/XDV9hFPeFvpRDnl4Tp+zoaLL7mZaewl7QhvxElaPG2bbJmskfxA1ME
         WOOnbJCRIFYc7aZO3ZavQxlX7Ve4MEgs5b6T1mejOnHDyKInacz/O5HpFGzWiDMGKtrF
         8qQ5g3ct6aajklA6Q9MRctPH/pgeWcAIEJJXcmLJH9bOGSFLE25vNGQ4NxoFXUtRrN8q
         RRENIJH6r96TEWwW6OsvW0h89ygm8Y69Y4McdpRVgGwYvNe4u2NBe3FO6ovG6G8F9BMK
         JdnJOWhHkhP2/b6OQIAi5elkRrzeLT0vokMHIncOjinzPqnqy4kBt5iDN4s0dk95R+h2
         L+yg==
X-Gm-Message-State: AC+VfDzFZraejVzXdJrwvdbdmDwhNiZZLuE82ZLkKe25xaGpFn/bD5hJ
        46+nOW6Xidu4djg/WKw1/52qww==
X-Google-Smtp-Source: ACHHUZ5QJxsmW1EPJI5lNLxk67iObZwfxlfltjicyCutkDlAJrrC3Q1bCfMXk/s/5Zo1o/n8QLEDXg==
X-Received: by 2002:a25:ec0d:0:b0:b9e:2b25:be56 with SMTP id j13-20020a25ec0d000000b00b9e2b25be56mr899743ybh.32.1686715117548;
        Tue, 13 Jun 2023 20:58:37 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w188-20020a25dfc5000000b00b923b2935d9sm2143983ybg.20.2023.06.13.20.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 20:58:37 -0700 (PDT)
Date:   Tue, 13 Jun 2023 20:58:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
Subject: Re: [PATCH v2 31/32] mm/swap: swap_vma_readahead() do the
 pte_offset_map()
In-Reply-To: <87legp6rax.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <da939b84-d543-8dd1-aef-cf7935d5b98@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <b7c64ab3-9e44-aac0-d2b-c57de578af1c@google.com> <87legp6rax.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 12 Jun 2023, Huang, Ying wrote:

> Hi, Hugh,
> 
> Sorry for late reply.

Never apologize to *me* for being "late" or "slow" or "unresponsive".

Thanks for looking, yes, it was indeed for this one that I particularly
added you to the Cc.

> 
> Hugh Dickins <hughd@google.com> writes:
> 
> > swap_vma_readahead() has been proceeding in an unconventional way, its
> > preliminary swap_ra_info() doing the pte_offset_map() and pte_unmap(),
> > then relying on that pte pointer even after the pte_unmap() - in its
> > CONFIG_64BIT case (I think !CONFIG_HIGHPTE was intended; whereas 32-bit
> > copied ptes to stack while they were mapped, but had to limit how many).
> >
> > Though it would be difficult to construct a failing testcase, accessing
> > page table after pte_unmap() will become bad practice, even on 64-bit:
> > an rcu_read_unlock() in pte_unmap() will allow page table to be freed.
> >
> > Move relevant definitions from include/linux/swap.h to mm/swap_state.c,
> > nothing else used them.  Delete the CONFIG_64BIT distinction and buffer,
> > delete all reference to ptes from swap_ra_info(), use pte_offset_map()
> > repeatedly in swap_vma_readahead(), breaking from the loop if it fails.
> >
> > (Will the repeated "map" and "unmap" show up as a slowdown anywhere?
> > If so, maybe modify __read_swap_cache_async() to do the pte_unmap()
> > only when it does not find the page already in the swapcache.)
> >
> > Use ptep_get_lockless(), mainly for its READ_ONCE().  Correctly advance
> > the address passed down to each call of __read__swap_cache_async().
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  include/linux/swap.h | 19 -------------------
> >  mm/swap_state.c      | 45 +++++++++++++++++++++++---------------------
> >  2 files changed, 24 insertions(+), 40 deletions(-)

...

> Because we don't deal with PTEs in struct vma_swap_readahead anymore, it
> appears simpler to record addresses directly, for example,
> 
> struct vma_swap_readahead {
> 	unsigned long start;
> 	unsigned long end;
> };
> 
> we can make ra_info.win to be the return value of swap_ra_info().
> 
> Anyway, this can be a separate cleanup patch based on this patch.

Ooh, that would have required me to think, rather than just delete
lines.  Mmm, if you see a cleaner way forward, yes, please do add
some cleanup on top.

> 
> For the patch itself, feel free to add,
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Great, thanks a lot.

Hugh
