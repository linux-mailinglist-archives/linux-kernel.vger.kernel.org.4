Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756F160D19F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiJYQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:28:32 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D14EFBA257;
        Tue, 25 Oct 2022 09:28:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 98E2992009C; Tue, 25 Oct 2022 18:28:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9129092009B;
        Tue, 25 Oct 2022 17:28:28 +0100 (BST)
Date:   Tue, 25 Oct 2022 17:28:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
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
In-Reply-To: <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2210240054280.50489@angie.orcam.me.uk>
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com> <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com> <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net> <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com> <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net> <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org> <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com> <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk> <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
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

On Sun, 23 Oct 2022, Linus Torvalds wrote:

> >  Given the presence of generic atomics we can emulate CMPXCHG8B easily
> > LL/SC-style using a spinlock with XCHG even on SMP let alone UP.
> 
> We already do that (admittedly badly - it's not SMP safe, but
> 486-class SMP machines have never been supported even if they
> technically did exist), see
> 
>   arch/x86/lib/cmpxchg8b_emu.S
>   arch/x86/lib/atomic64_386_32.S
> 
> for some pretty disgusting code.

 I skimmed over these, yeah, before writing my previous reply and hence 
my proposal to make the approach somewhat less disgusting.

 FWIW Intel talks about 486 SMP systems in their MP spec, but even back 25
years ago I was unable to track down a single mention of a product name 
for an APIC-based 486 SMP system let alone a specimen.  I guess the MP 
spec and the APIC simply came too late in the game for the 486.

 Compaq did however make 486 SMP systems based on their proprietary 
solution (I can't remember the name offhand), which they also propagated 
to their later Pentium products, some of which could be switched into the 
APIC mode instead via a BIOS setting.  ISTR a 16-way brand new Xeon box 
still using the Compaq solution in early 2000s.  Compaq never bothered to 
publish the spec for their solution and nobody was determined enough to 
reverse-engineer it, so we never had support for it.

> But it's all the other infrastructure to support this that is just an
> unnecessary weight. Grep for CONFIG_X86_CMPXCHG64 and X86_FEATURE_CX8.

 Some of these are syntactic sugar really, but I agree there seem to be 
too many of them and I guess even that perhaps could be simplified at the 
expense of some performance loss with 486 systems, by assuming universal 
presence of CMPXCHG8B and emulating the instruction in #UD handler where 
unavailable.  I could live with that, and that could get away with no 
conditionals (except maybe one to have the emulation handler optimised 
away where not needed based on a single CONFIG_X86_CMPXCHG64 instance).

> We already have increasingly bad coverage testing for x86-32 - and
> your example of MIPS really doesn't strengthen your argument all that
> much, because MIPS has never been very widely used in the first place,
> and doesn't affect any mainline development.

 TBH by the number of pieces of hardware I am fairly sure there have been 
significantly more MIPS Linux deployments in the world than x86 ones, and
second only to ARM ones, though indeed the diversity of configurations may 
have been smaller.  And all of them seem to have survived having ancient 
MIPS CPU support alongside.

> The odd features and CPU selection really do not help.
> 
> Honestly, I wouldn't mind upgrading the minimum requirements to at
> least M586TSC - leaving some of those early "fake Pentium" clones
> behind too. Because 'rdtsc' is probably an even worse issue than
> CMPXCHG8B.
> 
> In fact, I don't understand how current kernels work on an i486 at
> all, since it looks like
> 
>   exit_to_user_mode_prepare ->
>     arch_exit_to_user_mode_prepare
> 
> ends up having an unconditional 'rdtsc' instruction in it.
> 
> I'm guessing that you don't have RANDOMIZE_KSTACK_OFFSET enabled?

 I have checked and I have not moved past 5.11.0 yet for my 486 box, and 
that's before the addition of RANDOMIZE_KSTACK_OFFSET.

 Sigh, time flies by and there's been too much breakage around for me to 
deal with to schedule an upgrade of what has been mostly a stable 
trouble-free configuration for me.  E.g. after three unrelated bug fixes 
the parport_pc driver still does not work with my RISC-V box, and that's 
of course only once I figured out how to work around a hardware erratum 
with a pair of upstream PCIe switches that let the PCIe parallel port 
option card to be reachable in the first place.  So I gave those issues 
priority over upgrading the 486 kernel, though obviously I'll get to it 
sooner or later.

 The fix here is obviously and trivially:

	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET if !M486SX && !M486

Not all features have to be available everywhere and there are compromises 
to make.  I can live with my 486 box being less secure: I don't intend to 
hand out accounts to people I don't trust or run a web server there.

 I don't know offhand how much we rely on RDTSC and if necessary how much 
a trivial emulation referring to jiffies plus maybe reading the 8254 PIT
counter would suck.  Maybe it's not a big deal.  Again, it all depends on 
the application.

 NB I have seen this in the logs appearing since a while ago with my dual
Pentium-MMX box:

clocksource: timekeeping watchdog on CPU0: Marking clocksource 'tsc-early' as unstable because the skew is too large:
clocksource:                       'refined-jiffies' wd_nsec: 500000000 wd_now:ffff8b3e wd_last: ffff8b0c mask: ffffffff
clocksource:                       'tsc-early' cs_nsec: 829966007 cs_now: 6049e0005 cs_last: 5f91b3cff mask: ffffffffffffffff
clocksource:                       No current clocksource.
tsc: Marking TSC unstable due to clocksource watchdog

so I guess this system would qualify as one without RDTSC too (even though 
it's M586MMX, i.e. a superset of M586TSC, so hardly early "fake Pentium"), 
right?  It's interesting to see how we can't (anymore) make use of any of 
the various timers this system has (i.e. the PIT, the TSC, the APIC timer) 
for timekeeping.

> In other words, our non-Pentium support is ACTIVELY BUGGY AND BROKEN 
> right now.

 We have plenty of bugs elsewhere too.  I hit them all the time and try to 
fix as my time permits; I guess other people do too.  I think it's just a 
matter of willing to deal with issues.  And we won't ever fix all the bugs 
we have.  There will always be some remaining even if the exact set 
changes.

> This is not some theoretical issue, but very much a "look, ma, this
> has never been tested, and cannot actually work" issue, that nobody
> has ever noticed because nobody really cares.

 Same with parport_pc on RISC-V.  That just happens with more rarely used 
features, even if it's brand new hardware (I bought both pieces new in 
retail boxes last year or so).

> It took me a couple of minutes of "let's go hunting" to find that
> thing, and it's just an example of how broken our current support is.
> That RANDOMIZE_KSTACK_OFFSET code *compiles* just fine. It just
> doesn't actually work.

 Nobody tried it, and that's just it.  We may have bots building random 
configs, but not all will ever be tried at run time.  Bugs creep in all 
the time, because nobody has the ability to foresee all the scenarios, or 
sometimes they are genuine human errors.

> That's the kind of maintenance burden we simply shouldn't have - no
> developer actually cares (correctly), nobody really tests that
> situation (also correctly - it's old and irrelevant hardware), but it
> also means that code just randomly doesn't actually work.

 I think this is a strawman's argument really.  For various reasons there 
are always combinations of hardware that do not work just because one 
cannot verify everything and the age of hardware may or may not be the 
culprit.  It's more about the user base.  Niche use gets less coverage.  
If something doesn't work and someone actually cares about it, they will 
come and fix it.

 The only argument I buy is extra maintenance burden caused *elsewhere*, 
so if support for old 486 systems staying around causes extra work for 
mainstream x86-64 systems, only then I will consider it a valid concern.

 So what's the actual burden from keeping this support around?  Would my 
proposal to emulate CMPXCHG8B (and possibly RDTSC) in #UD handler help?  

 Getting the decoding of x86 address modes in software right is a pain and 
tedious (I've seen fixes to get the corner cases right in the disassembler 
in binutils fly by quite recently, after so many years), but I guess we 
can try if we don't have it implemented already for another purpose (I 
haven't checked; I've been hardly involved with x86 recently).

 Thoughts?

  Maciej
