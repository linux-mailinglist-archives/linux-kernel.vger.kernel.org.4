Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F370ECBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjEXEy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXEyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:54:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C81184
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:54:18 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso8241624276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684904058; x=1687496058;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqPOl9ypUlM9FOcJpAG9+3J18Ww9uHXlwCXL2XFf4aM=;
        b=cr+AzMNHLzBZehXjVbZ+6LzhsqAMJoB7wynFTygjsNCLn3hXwhPtGPFhdD4PqnAc9M
         jj35Sd9X1YYFQKHuxPfyuFw61GgVTeurqC72t0hz+TiRBgb1Mfm9tuWtWTX6DURJdCga
         gRSaqwx7qYKU3rUSR1AaWRazZRCDCqfL+20T8wlRqqLnHKlKFbQf0qEzcjAhX0Ym1Uo8
         D1l4etRSW7oEjEmszglGL6xjlMxjbmwhAes45bCna8eaa33Hi/AEKvt6F3TmlWfHnESv
         Y9RW4cUzgHMSGhz1/ANzV1xkfNI4iStIaXJjNyeYLQplolsqmQoBrRElRezNE3QEAQXV
         47NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684904058; x=1687496058;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqPOl9ypUlM9FOcJpAG9+3J18Ww9uHXlwCXL2XFf4aM=;
        b=erBnKoOLfn5AE4pAJH4VhxLCjjnXxcNJP1juwNXb7WBic48GYrgqjizxV1kdIHzkEd
         OjVpYBOqJZHlCmrgNfAxDjyOOgiEMvAkLTpcZyDUDElpuM2f2sv0zrM4JHZlaN7OiW01
         TTDurYe/1P5zIx/PbYBhfKBl6acKJTO6ZeIIUw8/X+qIvZAjYAS7HpdRy5Emq57vJGgm
         WAZEbr8Oum5DblJoerk70OUlRIvwFgh9jqwCMWf+c7HLJoUGhfqpp2z9fcZL6+4p68ef
         u5m9puAnEMld60cL0lhWQMfPUwKSaWStcV+8hb8SCFRssPcWMrOqPgnfUYKq66A0/hYo
         cBaw==
X-Gm-Message-State: AC+VfDxvSu5ql3B1porrOPfiIkQtrenGoZfYFxohDyactq1yQ+7hJHVp
        M1d3fVzJMCZeSu6nLOl6i3rdYQ==
X-Google-Smtp-Source: ACHHUZ6atGZH5fRFxmsfK54bzyEVqL7dJkCeyQRAeAXzu+E26Fai81nyT2Er1bQtHD5E8RbQ/8Oa6Q==
X-Received: by 2002:a81:ab4a:0:b0:55a:c779:d8c0 with SMTP id d10-20020a81ab4a000000b0055ac779d8c0mr16230329ywk.22.1684904057666;
        Tue, 23 May 2023 21:54:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g134-20020a0ddd8c000000b0055a382ae26fsm3432251ywe.49.2023.05.23.21.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:54:17 -0700 (PDT)
Date:   Tue, 23 May 2023 21:54:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Qi Zheng <qi.zheng@linux.dev>
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
Subject: Re: [PATCH 29/31] mm/memory: handle_pte_fault() use
 pte_offset_map_nolock()
In-Reply-To: <a56c92c9-44a0-97f4-1a3d-e1679471f19c@linux.dev>
Message-ID: <9cccc47c-d9c7-3071-098-4edb54b178a@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <5f10e87-c413-eb92-fc6-541e52c1f6be@google.com> <a56c92c9-44a0-97f4-1a3d-e1679471f19c@linux.dev>
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

On Mon, 22 May 2023, Qi Zheng wrote:
> On 2023/5/22 13:26, Hugh Dickins wrote:
> > handle_pte_fault() use pte_offset_map_nolock() to get the vmf.ptl which
> > corresponds to vmf.pte, instead of pte_lockptr() being used later, when
> > there's a chance that the pmd entry might have changed, perhaps to none,
> > or to a huge pmd, with no split ptlock in its struct page.
> > 
> > Remove its pmd_devmap_trans_unstable() call: pte_offset_map_nolock()
> > will handle that case by failing.  Update the "morph" comment above,
> > looking forward to when shmem or file collapse to THP may not take
> > mmap_lock for write (or not at all).
> > 
> > do_numa_page() use the vmf->ptl from handle_pte_fault() at first, but
> > refresh it when refreshing vmf->pte.
> > 
> > do_swap_page()'s pte_unmap_same() (the thing that takes ptl to verify a
> > two-part PAE orig_pte) use the vmf->ptl from handle_pte_fault() too; but
> > do_swap_page() is also used by anon THP's __collapse_huge_page_swapin(),
> > so adjust that to set vmf->ptl by pte_offset_map_nolock().
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   mm/khugepaged.c |  6 ++++--
> >   mm/memory.c     | 38 +++++++++++++-------------------------
> >   2 files changed, 17 insertions(+), 27 deletions(-)
> > 
...
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c7b920291a72..4ec46eecefd3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
...
> > @@ -4897,27 +4897,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault
> > *vmf)
> >     vmf->pte = NULL;
> >     vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
> >   	} else {
> > -		/*
> > -		 * If a huge pmd materialized under us just retry later.  Use
> > -		 * pmd_trans_unstable() via pmd_devmap_trans_unstable()
> > instead
> > -		 * of pmd_trans_huge() to ensure the pmd didn't become
> > -		 * pmd_trans_huge under us and then back to pmd_none, as a
> > -		 * result of MADV_DONTNEED running immediately after a huge
> > pmd
> > -		 * fault in a different thread of this mm, in turn leading to
> > a
> > -		 * misleading pmd_trans_huge() retval. All we have to ensure
> > is
> > -		 * that it is a regular pmd that we can walk with
> > -		 * pte_offset_map() and we can do that through an atomic read
> > -		 * in C, which is what pmd_trans_unstable() provides.
> > -		 */
> > -		if (pmd_devmap_trans_unstable(vmf->pmd))
> > -			return 0;
> >     /*
> >   		 * A regular pmd is established and it can't morph into a huge
> > -		 * pmd from under us anymore at this point because we hold the
> > -		 * mmap_lock read mode and khugepaged takes it in write mode.
> > -		 * So now it's safe to run pte_offset_map().
> > +		 * pmd by anon khugepaged, since that takes mmap_lock in write
> > +		 * mode; but shmem or file collapse to THP could still morph
> > +		 * it into a huge pmd: just retry later if so.
> >   		 */
> > -		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> > +		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
> > +						 vmf->address, &vmf->ptl);
> > +		if (unlikely(!vmf->pte))
> > +			return 0;
> 
> Just jump to the retry label below?

Shrug.  Could do.  But again I saw no reason to optimize this path,
the pmd_devmap_trans_unstable() treatment sets a good enough example.

Hugh
