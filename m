Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3471F9D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjFBGDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjFBGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:03:19 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638C1A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:03:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb167972cffso1826007276.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685685796; x=1688277796;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zsFlKAGcv+fQqN1VVT9TBfhOrr8gOpZnbD5J9Rbft4=;
        b=Y1BisDvMhSzU6oLolCbfFVEgLMBmkQqmlhDVPpW2AJeK8jBOlWFdFzL1tmuKOpvK63
         GHp/SMU2i1PecHncq+b0lH3okXqlru+09I8QXCT9NALz59R7lsKaFrIT52Hiqg0zxTrC
         jqOVLA4YrHbMJ8glWqmmX18tl8OerbjfR8d4jWr1vj09V6zTyWVo1xxkRbkx8FKG4Z9E
         o7UIT7SMKh+6qHbb35DHGZE2LGVQgAMuvaanUZKjDX1mZVWuXTA1af7RiiJxIJKDI/Fw
         yZw6JHtIxsA5qBBvdFUR4HhBdS3PC2/xGlBXKlhRRsZvH9HBG7Q8HWGC15eDYbLtpv+i
         H45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685685796; x=1688277796;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zsFlKAGcv+fQqN1VVT9TBfhOrr8gOpZnbD5J9Rbft4=;
        b=b1XhDCJ9PR5MbrswQwRH83F6lkFv8vNEJf8+nkLQGGmDFsdZKPVvdERZkTFo1DoHVT
         I6RGKlVu1fg/LEjSYQvwVAgekRHsOcPY+ZoiPIIKEZo2wDVcn/3weuWfJCBJZZiyrL2Q
         +08Ibzv41FIXWeyqoqDXNd5FR+VDDwZ2PG0RyNuDV+E2weZdG/T0KpXzZXrplEtc5d2n
         MQgcyMcqCHtoncbT8cjtUoObqb05hUzuSFJdFGYqf/3QRbY7b2nB/KGNPwXG52ft5uGo
         kYHKVFunQmiriwDGzqiO1jrks/DNRAHS/25z2cx1eJ2QfxLLuIlSWclkV+5Xf0HrZaVv
         8YKQ==
X-Gm-Message-State: AC+VfDwgH6NIMh6TqJyHf3G1m042Lg1oxzkwl4aJPMwks41B8FbiI9GA
        SbTEkPbi4x0HuO5dCggLmnxgoA==
X-Google-Smtp-Source: ACHHUZ6eYdbQngpbs2i38U7FBW9tfhwKdbT7ZR71DCB3qxUId8cHs0QRFbdpfBZ1Bt76wUVanJBNhQ==
X-Received: by 2002:a0d:d447:0:b0:568:bec5:ebaf with SMTP id w68-20020a0dd447000000b00568bec5ebafmr12482758ywd.12.1685685796445;
        Thu, 01 Jun 2023 23:03:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u17-20020a818411000000b0055d7fc2b704sm184207ywf.16.2023.06.01.23.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 23:03:15 -0700 (PDT)
Date:   Thu, 1 Jun 2023 23:03:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/12] mm/pgtable: add pte_free_defer() for pgtable as
 page
In-Reply-To: <ZHekpAKJ05cr/GLl@ziepe.ca>
Message-ID: <a7f4722-8af2-f7be-eada-ff1e6e918da1@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <739964d-c535-4db4-90ec-2166285b4d47@google.com> <ZHekpAKJ05cr/GLl@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Jason Gunthorpe wrote:
> On Sun, May 28, 2023 at 11:23:47PM -0700, Hugh Dickins wrote:
> > Add the generic pte_free_defer(), to call pte_free() via call_rcu().
> > pte_free_defer() will be called inside khugepaged's retract_page_tables()
> > loop, where allocating extra memory cannot be relied upon.  This version
> > suits all those architectures which use an unfragmented page for one page
> > table (none of whose pte_free()s use the mm arg which was passed to it).
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > +	page = pgtable;
> > +	call_rcu(&page->rcu_head, pte_free_now);
> 
> People have told me that we can't use the rcu_head on the struct page
> backing page table blocks. I understood it was because PPC was using
> that memory for something else.

In the 05/12 thread, Matthew pointed out that powerpc (and a few others)
use the one struct page for multiple page tables, and the lack of
multiple rcu_heads means I've got that patch and 06/12 sparc and
07/12 s390 embarrassingly wrong (whereas this generic 08/12 is okay).

I believe I know the extra grossness needed for powerpc and sparc: I had
it already for powerpc, but fooled myself into thinking not yet needed.

But (I haven't quite got there yet) it looks like Gerald is pointing
out that s390 is using lru which coincides with rcu_head: I already knew
s390 the most difficult, but that will be another layer of difficulty.

I expect it was s390 which people warned you of.

> 
> I was hoping Mathew's folio conversion would help clarify this..

I doubt that: what we have for use today is pages, however they are
dressed up.

> 
> On the flip side, if we are able to use rcu_head here then we should
> use it everywhere and also use it mmu_gather.c instead of allocating
> memory and having the smp_call_function() fallback. This would fix it
> to be actual RCU.
> 
> There have been a few talks that it sure would be nice if the page
> tables were always freed via RCU and every arch just turns on
> CONFIG_MMU_GATHER_RCU_TABLE_FREE. It seems to me that patch 10 is kind
> of half doing that by making this one path always use RCU on all
> arches.
> 
> AFAIK the main reason it hasn't been done was the lack of a rcu_head..

I haven't paid attention to that part of the history, and won't be
competent to propagate this further, into MMU-Gather-World; but agree
that would be a satisfying conclusion.

Hugh
