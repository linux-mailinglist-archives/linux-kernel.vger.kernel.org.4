Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB16132B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJaJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJaJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:29:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9E0C74
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m26dbh7SjZHwQm0vw8FQlUAYjNdiwKxLSgQsfeZ1PmE=; b=PspoWzpzdQZwU1bDxNJlFTQCSd
        BmsCZ5XvRS7VcCAqXfgCqL3jdajhe8rVZieSueir12iklJ2deY2idzmQfnoQegSEWFIzp4PyjxD6u
        Etimo3Dz5Vb1e8tTJ/ylYS6q1rHd2vu0TLc4JqFuN4t/VaaqvF06yo0dlFF5EVvPLT+Dpvv+3VYxs
        iPAIgPRHoTUeQEPfkP0D/vjpTs80KtpNFjsYkO1DUuEdHjBY3aO7CwYGcCOWxIVqIZ+QOBWHTvLwz
        p0Zr6R9GhjokkEM1fa6qiZErP9m+8M/lXn28QEcPRV/a4zrKr68gmFOb0B8EMBYNL0ETBWVnbL/gt
        lXVV3x5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opR6N-003YhK-Uh; Mon, 31 Oct 2022 09:29:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0A1930008D;
        Mon, 31 Oct 2022 10:28:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD70C20FEEEC2; Mon, 31 Oct 2022 10:28:57 +0100 (CET)
Date:   Mon, 31 Oct 2022 10:28:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1+VWfNC7BvP8Pr2@hirez.programming.kicks-ass.net>
References: <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 03:47:36PM -0700, Linus Torvalds wrote:

>  include/linux/rmap.h |  1 +
>  mm/memory.c          |  3 ++-
>  mm/rmap.c            | 24 ++++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index bd3504d11b15..f62af001707c 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -196,6 +196,7 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address);
>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> +void page_zap_pte_rmap(struct page *);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index f88c351aecd4..c893f5ffc5a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1452,8 +1452,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				    likely(!(vma->vm_flags & VM_SEQ_READ)))
>  					mark_page_accessed(page);
>  			}
> +			page_zap_pte_rmap(page);
> +			munlock_vma_page(page, vma, false);
>  			rss[mm_counter(page)]--;
> -			page_remove_rmap(page, vma, false);
>  			if (unlikely(page_mapcount(page) < 0))
>  				print_bad_pte(vma, addr, ptent, page);
>  			if (unlikely(__tlb_remove_page(tlb, page))) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2ec925e5fa6a..28b51a31ebb0 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1412,6 +1412,30 @@ static void page_remove_anon_compound_rmap(struct page *page)
>  		__mod_lruvec_page_state(page, NR_ANON_MAPPED, -nr);
>  }
>  
> +/**
> + * page_zap_pte_rmap - take down a pte mapping from a page
> + * @page:	page to remove mapping from
> + *
> + * This is the simplified form of page_remove_rmap(), that only
> + * deals with last-level pages, so 'compound' is always false,
> + * and the caller does 'munlock_vma_page(page, vma, compound)'
> + * separately.
> + *
> + * This allows for a much simpler calling convention and code.
> + *
> + * The caller holds the pte lock.
> + */
> +void page_zap_pte_rmap(struct page *page)
> +{

One could consider adding something like:

#ifdef USE_SPLIT_PTE_PTLOCKS
	lockdep_assert_held(ptlock_ptr(page))
#endif


> +	if (!atomic_add_negative(-1, &page->_mapcount))
> +		return;
> +
> +	lock_page_memcg(page);
> +	__dec_lruvec_page_state(page,
> +		PageAnon(page) ? NR_ANON_MAPPED : NR_FILE_MAPPED);
> +	unlock_page_memcg(page);
> +}

Took me a little while, but yes, .compound=false seems to reduce to
this.
