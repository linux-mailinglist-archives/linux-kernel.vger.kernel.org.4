Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5A6132FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJaJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJaJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:46:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D27CE24
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1LT+IJGInDBKkqvcdSfAEMexu/jCj7/5OuTrYDg+YBU=; b=T+O8w0UHsM1MpLqWjLZ8/z4VUI
        OIVLI+IW6IihMaAOgTZyWUAgD5SyrUHXsfwJ5QpCA4YxU0hCroC028vVuDZ3ef/Mo1qL1RPAZI8LO
        Ir7yEodRBItmQBys8sO719TJHFA8GspYbb865wMTLnuXIc/KlkF+ZteoP/SovAWFXq+Fk/bwrM7VD
        L8yEyp/Kh0UNVQ75nl2l92Yb/oXzBW7kI6nUE5k4ebynSomQp5MzDOE/kqxqAnkcaCMe/HUjxeskF
        /+AoHBEMhUlSCgQH6bHQb/KmFPHrq+hPgTOw29N7KoJ7NI+65aQsGqmN3ShkHrO+8JMi55NwBAuAP
        I4wr/RxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opRN1-007q4D-Gh; Mon, 31 Oct 2022 09:46:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEE6C30010B;
        Mon, 31 Oct 2022 10:46:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93B6F2B9C3936; Mon, 31 Oct 2022 10:46:14 +0100 (CET)
Date:   Mon, 31 Oct 2022 10:46:14 +0100
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
Message-ID: <Y1+ZZvNorSqevfbd@hirez.programming.kicks-ass.net>
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 06:47:23PM -0700, Linus Torvalds wrote:

> diff --git a/mm/memory.c b/mm/memory.c
> index ba1d08a908a4..c893f5ffc5a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1451,9 +1451,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				if (pte_young(ptent) &&
>  				    likely(!(vma->vm_flags & VM_SEQ_READ)))
>  					mark_page_accessed(page);
> +			}
> +			page_zap_pte_rmap(page);
>  			munlock_vma_page(page, vma, false);
>  			rss[mm_counter(page)]--;
>  			if (unlikely(page_mapcount(page) < 0))
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 69de6c833d5c..28b51a31ebb0 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1413,47 +1413,26 @@ static void page_remove_anon_compound_rmap(struct page *page)
>  }
>  
>  /**
> + * page_zap_pte_rmap - take down a pte mapping from a page
>   * @page:	page to remove mapping from
>   *
> + * This is the simplified form of page_remove_rmap(), that only
> + * deals with last-level pages, so 'compound' is always false,
> + * and the caller does 'munlock_vma_page(page, vma, compound)'
> + * separately.
>   *
> + * This allows for a much simpler calling convention and code.
>   *
>   * The caller holds the pte lock.
>   */
> +void page_zap_pte_rmap(struct page *page)
>  {
>  	if (!atomic_add_negative(-1, &page->_mapcount))
>  		return;
>  
>  	lock_page_memcg(page);
> +	__dec_lruvec_page_state(page,
> +		PageAnon(page) ? NR_ANON_MAPPED : NR_FILE_MAPPED);
>  	unlock_page_memcg(page);
>  }

So we *could* use atomic_add_return() and include the print_bad_pte()
thing in this function -- however that turns the whole thing into a mess
again :/
