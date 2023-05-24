Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC670EB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjEXCu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjEXCuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:50:21 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2BE9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:50:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba6d024a196so404906276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684896620; x=1687488620;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXoxikPl3gEJxlnM6PPv+fB+r1BmUcnQVHMJHjf9m9w=;
        b=E242buCI6Gers0XctOZ0oDN64lMMOcafyfENPz5whRcrKDFQx6LDEoH8FZYFW88CBK
         q5UjVKR4tfE+oWLtkypPnF7Sf1S6e4tRr0QDHX62SpT+aOGz3v9yx+U1GHBkbpHp8zpF
         oJa6tqNPuQRrDOBcC9YETc6fGxIMIZdl5GjggCjTtDw8nULfK7I0UrUct6FvAsV//fiV
         1+xuEX4PvoShCuPVta1XDAffD/sk2GMjAwgTzDBphXrLcHGQUCTXsYVgE2IRZJyQlTBh
         6FB6zwFl3S5jC41456lkVhfaI4/7djXgJjieao8l05wxylkq9Ufz8v6W5fk4/I4b4Gsi
         5CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684896620; x=1687488620;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXoxikPl3gEJxlnM6PPv+fB+r1BmUcnQVHMJHjf9m9w=;
        b=PKZnu6ZYYXK9zKKhgUo9HTUxSVlNXwKJHzK/0oaebHKeOgUoNpM53U3wyyqo7rn6JL
         Zus7vEB0NHzcwshQkksB5Yi6g5XMGPwtvpX+1yvLjLaAiFfmHo36V3gGny1V2ekehVo0
         cLddimsGPWxNKoNrZQdkHVUnpE4h5cHwgReRQKscEkByTyQtygBSh6mkAM1esx9rVgl4
         fUMUMUOvtNa7I/WLJ7Trpw3DcnETvGrrXz0w+8Yldel6fLyiY0gRIV0VwvbyYDae4Gp6
         quQx3JMoaVrvUUwEQPRFiCztDLNmkyhdSL+I2fXYif0QDHN5e74kSQ1nOhUKrACy43IC
         XvDQ==
X-Gm-Message-State: AC+VfDw4pmXmzvT+scJsk3lwTTbPH+2BkKQbO6SvvzHjP9h096OOEigK
        TTkS1YQlJ//2UtsFPl/+aW4eaQ==
X-Google-Smtp-Source: ACHHUZ4iJ+u6pCZV4miMKFbhg+2eSHrwqr7FXyA957lHKdcq3XE9+TzdSP6uIBPbGEMy4RtZzKy33g==
X-Received: by 2002:a81:75c4:0:b0:561:f6eb:d18a with SMTP id q187-20020a8175c4000000b00561f6ebd18amr16272154ywc.13.1684896619945;
        Tue, 23 May 2023 19:50:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f126-20020a0dc384000000b00560df23d30csm3381845ywd.117.2023.05.23.19.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:50:19 -0700 (PDT)
Date:   Tue, 23 May 2023 19:50:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Qi Zheng <qi.zheng@linux.dev>
cc:     Alistair Popple <apopple@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCH 13/31] mm/hmm: retry if pte_offset_map() fails
In-Reply-To: <1d5d7f30-1a6a-5ea1-165f-65d34e7658e9@linux.dev>
Message-ID: <89461cb2-ec2c-719c-8a50-1f76e8048ef@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <2edc4657-b6ff-3d6e-2342-6b60bfccc5b@google.com> <0e3c5937-2f04-25d9-98eb-01e4c2b04150@linux.dev> <87353n9354.fsf@nvidia.com> <1d5d7f30-1a6a-5ea1-165f-65d34e7658e9@linux.dev>
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

On Tue, 23 May 2023, Qi Zheng wrote:
> On 2023/5/23 10:39, Alistair Popple wrote:
> > Qi Zheng <qi.zheng@linux.dev> writes:
> >> On 2023/5/22 13:05, Hugh Dickins wrote:
> >>> hmm_vma_walk_pmd() is called through mm_walk, but already has a goto
> >>> again loop of its own, so take part in that if pte_offset_map() fails.
> >>> Signed-off-by: Hugh Dickins <hughd@google.com>
> >>> ---
> >>>    mm/hmm.c | 2 ++
> >>>    1 file changed, 2 insertions(+)
> >>> diff --git a/mm/hmm.c b/mm/hmm.c
> >>> index e23043345615..b1a9159d7c92 100644
> >>> --- a/mm/hmm.c
> >>> +++ b/mm/hmm.c
> >>> @@ -381,6 +381,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >>>     }
> >>>      	ptep = pte_offset_map(pmdp, addr);
> >>> +	if (!ptep)
> >>> +		goto again;
> >>>     for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
> >>>      int r;
> >>>    
> >>
> >> I haven't read the entire patch set yet, but taking a note here.
> >> The hmm_vma_handle_pte() will unmap pte and then call
> >> migration_entry_wait() to remap pte, so this may fail, we need to
> >> handle this case like below:
> > 
> > I don't see a problem here. Sure, hmm_vma_handle_pte() might return
> > -EBUSY but that will get returned up to hmm_range_fault() which will
> > retry the whole thing again and presumably fail when looking at the PMD.
> 
> Yeah. There is no problem with this and the modification to
> migration_entry_wait() can be simplified. My previous thought was that
> we can finish the retry logic in hmm_vma_walk_pmd() without handing it
> over to the caller. :)

Okay, Alistair has resolved this one, thanks, I agree; but what is
"the modification to migration_entry_wait()" that you refer to there?

I don't think there's any need to make it a bool, it's normal for there
to be races on entry to migration_entry_wait(), and we're used to just
returning to caller (and back up to userspace) when it does not wait.

Hugh
