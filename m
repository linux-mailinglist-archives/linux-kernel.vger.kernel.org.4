Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F40730498
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjFNQJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFNQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CD1FE2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8420364444
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC839C433C0;
        Wed, 14 Jun 2023 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758962;
        bh=z4EO55OEov8HV8Wooyvn+q5dcyjiojnBToINyf+P/T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1w2SMZEqvPgnn1xshZ8ykXfYKbNxrLz/tdiJ3WsRf/xUzq6E3+WaDmKvihJeMIXX
         2CNGO1JXYmjZdEZg2JgfbSaeIHsK0I0eTjNUo5N5UoTUUKgJ+b5uA9QVNMMRi1bsvX
         pGLjXv7MOFt/ygIDdqZDXZlPcERrTbJlgkMCzRwDOS7vPkc1JW+Z97Blxib/WwWeVV
         rrVdXSP99GmRxaerC7hZ5YrJqLwEZDBLe+AbIuJYkODjMYkjxqhU9TajFMWWKWurHu
         9Ruy4U2yX3dD+KZgLBoRtEyWq7NKHgbkZx4lrw4ucCwLPRNkPBPoxB6YDyc/NMqral
         5YWXemSe7/cyA==
Date:   Wed, 14 Jun 2023 17:09:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: x86: pgtable / kaslr initialisation (OOB) help
Message-ID: <20230614160917.GA3635807@google.com>
References: <20230614132339.GS3635807@google.com>
 <20230614141654.GA1640123@hirez.programming.kicks-ass.net>
 <20230614143732.GW3635807@google.com>
 <0cefb67a-6fae-daa2-c871-ae35b96aac08@intel.com>
 <20230614150615.GX3635807@google.com>
 <20230614151003.GY3635807@google.com>
 <20230614152632.GZ3635807@google.com>
 <e72e3246-1803-6a17-5b9c-30fb2dc078e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e72e3246-1803-6a17-5b9c-30fb2dc078e3@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Dave Hansen wrote:

> On 6/14/23 08:26, Lee Jones wrote:
> > On Wed, 14 Jun 2023, Lee Jones wrote:
> > 
> >> On Wed, 14 Jun 2023, Lee Jones wrote:
> >>
> >>> Thanks for chiming in Dave.  I hoped you would.
> >>>
> >>> On Wed, 14 Jun 2023, Dave Hansen wrote:
> >>>
> >>>> On 6/14/23 07:37, Lee Jones wrote:
> >>>>> Still unsure how we (the kernel) can/should write to an area of memory
> >>>>> that does not belong to it.  Should we allocate enough memory
> >>>>> (2*PAGE_SIZE? rather than 8-Bytes) for trampoline_pgd_entry to consume
> >>>>> in a more sane way?
> >>>>
> >>>> No.
> >>>>
> >>>> I think this:
> >>>>
> >>>>                 set_pgd(&trampoline_pgd_entry,
> >>>>                         __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> >>>>
> >>>> is bogus-ish.  set_pgd() wants to operate on a pgd_t inside a pgd
> >>>> *PAGE*.  But it's just being pointed at a single  _entry_.  The address
> >>>> of 'trampoline_pgd_entry' in your case  also just (unfortunately)
> >>>> happens to pass the:
> >>>>
> >>>> 	__pti_set_user_pgtbl -> pgdp_maps_userspace()
> >>>>
> >>>> test.  I _think_ we want these to just be something like:
> >>>>
> >>>> 	trampoline_pgd_entry = __pgd(_KERNPG_TABLE |
> >>>> 				     __pa(p4d_page_tramp);
> >>>>
> >>>> That'll keep us away from all of the set_pgd()-induced nastiness.
> >>>
> >>> Okay.  Is this what you're suggesting?
> >>>
> >>> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c                 v
> >>> index d336bb0cb38b..803595c7dcc8 100644
> >>> --- a/arch/x86/mm/kaslr.c
> >>> +++ b/arch/x86/mm/kaslr.c
> >>> @@ -176,7 +176,7 @@ void __meminit init_trampoline_kaslr(void)
> >>>                 set_pgd(&trampoline_pgd_entry,
> >>>                         __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> >>>         } else {
> >>> -               set_pgd(&trampoline_pgd_entry,
> >>> -                       __pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> >>> +               trampoline_pgd_entry =
> >>> +                       __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp);
> >>
> >> Note the change of *.page_tramp here.
> >>
> >>   s/pud/p4d/
> >>
> >> I'm assuming that too was intentional?
> > 
> > Never mind.  I can see that p4d_page_tramp is local to the if() segment.
> > 
> > While we're at it, does the if() segment look correct to you:
> > 
> >   if (pgtable_l5_enabled()) {
> >         p4d_page_tramp = alloc_low_page();
> > 
> >         p4d_tramp = p4d_page_tramp + p4d_index(paddr);
> > 
> >         set_p4d(p4d_tramp,
> >                 __p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > 
> >         set_pgd(&trampoline_pgd_entry,
> >                 __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> >   } else {
> >         trampoline_pgd_entry =
> >                 __pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
> >   }
> > 
> >  - pud_page_tramp is being passed to set_p4d()
> >  - p4d_page_tramp is being passed to set_pgd()
> > 
> > Should those be the other way around, or am I missing the point?
> 
> You're missing the point. :)

Super, thanks for the explanation.
 
> PGDs are always set up to point to the physical address of the thing at
> one lower level than them.  A page is allocated for that level when
> 5-level paging is in play.  No page is needed when it is not in play.
> 
> The pattern is _almost_ always
> 
> 	pgd = ... __pa(p4d);
> 
> In other words, point the PGD at the physical address of a p4d.  But
> things get funky on systems without p4ds, thus the special casing here.
> 
> Does the (completely untested) attached patch fix your problem?

I just submitted a (tested) patch.

It doesn't cover the if() segment though.  I'll do so and resubmit.

> ---
> 
>  b/arch/x86/mm/kaslr.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff -puN arch/x86/mm/kaslr.c~trampoline_pgd_entry arch/x86/mm/kaslr.c
> --- a/arch/x86/mm/kaslr.c~trampoline_pgd_entry	2023-06-14 08:54:08.685554094 -0700
> +++ b/arch/x86/mm/kaslr.c	2023-06-14 08:55:36.077089793 -0700
> @@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(voi
>  		set_p4d(p4d_tramp,
>  			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
>  
> -		set_pgd(&trampoline_pgd_entry,
> -			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> +		trampoline_pgd_entry =
> +			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
>  	} else {
> -		set_pgd(&trampoline_pgd_entry,
> -			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> +		trampoline_pgd_entry =
> +		       	__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
>  	}
>  }
> _


-- 
Lee Jones [李琼斯]
