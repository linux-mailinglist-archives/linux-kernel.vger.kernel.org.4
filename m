Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00362610622
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiJ0XIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiJ0XIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:08:52 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62CA78FD4A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:08:51 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4729E92009D; Fri, 28 Oct 2022 01:08:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3E4F792009B;
        Fri, 28 Oct 2022 00:08:18 +0100 (BST)
Date:   Fri, 28 Oct 2022 00:08:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
In-Reply-To: <d24a5273-1c66-4653-9730-4de31ffcf0e8@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2210272332590.3199@angie.orcam.me.uk>
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com> <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com> <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net> <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com> <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net> <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org> <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com> <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk> <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
 <alpine.DEB.2.21.2210240054280.50489@angie.orcam.me.uk> <d24a5273-1c66-4653-9730-4de31ffcf0e8@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022, Arnd Bergmann wrote:

> >> In fact, I don't understand how current kernels work on an i486 at
> >> all, since it looks like
> >> 
> >>   exit_to_user_mode_prepare ->
> >>     arch_exit_to_user_mode_prepare
> >> 
> >> ends up having an unconditional 'rdtsc' instruction in it.
> >> >
> >  The fix here is obviously and trivially:
> >
> > 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET if !M486SX && !M486
> 
> I think that would be "if X86_TSC", otherwise you still include the
> TSC-less 586-class (5x86, 6x86, Elan, Winchip C6, MediaGX, ...)

 Right, I tend to forget about these more exotic chips from the 1990s era.  
I'll run some verification and come up with the actual fix in the next 
several days.

> > So what's the actual burden from keeping this support around?  Would my 
> > proposal to emulate CMPXCHG8B (and possibly RDTSC) in #UD handler help?
> 
> That sounds worse to me than the current use of runtime alternatives
> for picking between cmpxchg8b_emu and the native instruction.

 Why is that so?  Because of the trap-and-emulate technique?  It's been 
around since forever and specified in some processor ISAs even, where some 
machine instructions are explicitly allowed to be omitted from actual 
hardware and delegated to OS emulation without making affected hardware 
non-compliant.  VAX had it back from 1970s and RISC-V has it now.  We've 
been using it to retrofit operations ourselves, though maybe not with the 
x86 arch.

 Or is it because of the complex address decoding x86 requires?  Well, I 
have actually realised we do have it already, in the x87 CR0.EM emulator.  
While IEEE-754 exceptions can make use of the address of the operand 
recorded in the FPU environment full emulation requires decoding by hand.

> For arm32, we have a combination of two other approaches:
> 
> - On the oldest processors that never had SMP support (ARMv5 and
>   earlier), it is not possible to enable support for SMP at all.
>   Using a Kconfig 'depends on X86_CMPXCHG64' for CONFIG_SMP would
>   still allow building 486 kernels, but completely avoid the problem
>   of trying to make the same kernel work on later SMP machines.

 That would be fine with me of course.

> - For the special case of early ARMv6 hardware that has 32-bit
>   atomics but not 64-bit ones, the kernel just falls back to
>   CONFIG_GENERIC_ATOMIC64 and no cmpxchg64(). The same should work
>   for an i486+SMP kernel. It's obviously slower, but most users
>   can trivially avoid this by either running an i686 SMP kernel
>   or an i486 UP kernel.

 You meant an M586TSC+ SMP kernel presumably (I have such a machine), but 
otherwise I'd be fine with such an approach too.

 So it looks to me like we have at least three options to keep 486 alive,
two of which seem fairly straightforward to deploy and maintain long-term.  
I like your last proposal the most, FWIW.  Do we have a consensus here?

  Maciej
