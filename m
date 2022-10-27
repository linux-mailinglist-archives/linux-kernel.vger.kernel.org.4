Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889C860F11C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiJ0H2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJ0H17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:27:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A76AA341
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jIdXoveHpdJhxsDFwLhwCoDvMUr3LOjoTAAeFN1VZDQ=; b=g65dTzP5bb0fhavL07nyRH67sL
        JxPUwHx33jCezjgWMyZ/zIRcKV747ZUDgHTkXrrstMI3mR4lR+UnZ52hRh6EIX6CPKUMlEzYtEcZf
        ENNDp2T908EBfh0CapbhhRzQAaRii980WW83/tj0rno7AGTb6mAHOtI8dlestPf5eTzLYVIhq6zlS
        3/OSWHsnT0BcatXfMGrcBq/n/r6KUuFxE4Zk+T5RYoYPQx40ydg7WLYbUC8F/Ks6NSt30Pv0ulsXM
        YZPImpEsJerxzOqjdaLjzzxyelWx+ZyGdUJZD/MnGPuLDZdYQ+qQFYZ2DyTXZmzW7/8zWVax3OyNo
        CZ+tbLOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onxIs-0000zr-3v; Thu, 27 Oct 2022 07:27:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E350730029C;
        Thu, 27 Oct 2022 09:27:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C96D22012B90F; Thu, 27 Oct 2022 09:27:43 +0200 (CEST)
Date:   Thu, 27 Oct 2022 09:27:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
        X86 ML <x86@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1oy7+TnTkelR89U@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <A3677D1D-3631-4E57-8C5C-6C202B47700C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A3677D1D-3631-4E57-8C5C-6C202B47700C@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 10:43:21PM +0300, Nadav Amit wrote:
> On Oct 25, 2022, at 6:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > 			if (!force_flush && !tlb->fullmm && details &&
> > +			    details->zap_flags & ZAP_FLAG_FORCE_FLUSH)
> > +				force_flush = 1;
> 
> Isn’t it too big of a hammer?

It is the obvious hammer :-) TLB invalidate under pte_lock when
clearing.

> At the same time, the whole reasoning about TLB flushes is not getting any
> simpler. We had cases in which MADV_DONTNEED and another concurrent
> operation that effectively zapped PTEs (e.g., another MADV_DONTNEED) caused
> the zap_pte_range() to skip entries since pte_none() was true. To resolve
> these cases we relied on tlb_finish_mmu() to flush the range when needed
> (i.e., flush the whole range when mm_tlb_flush_nested()).

Yeah, whoever thought that allowing concurrency there was a great idea :/

And I must admit to hating the pending thing with a passion. And that
mm_tlb_flush_nested() thing in tlb_finish_mmu() is a giant hack at the
best of times.

Also; I feel it's part of the problem here; it violates the basic rules
we've had for a very long time.

> Now, I do not have a specific broken scenario in mind following this change,
> but it is all sounds to me a bit dangerous and at same time can potentially
> introduce new overheads.

I'll take correctness over being fast. As you say, this whole TLB thing
is getting out of hand.

> One alternative may be using mm_tlb_flush_pending() when setting a new PTE
> to check for pending flushes and flushing the TLB if that is the case. This
> is somewhat similar to what ptep_clear_flush() does. Anyhow, I guess this
> might induce some overheads. As noted before, it is possible to track
> pending TLB flushes in VMA/page-table granularity, with different tradeoffs
> of overheads.

Right; I just don't believe in VMAs for this, they're *waaay* to big.
