Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4865C2A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjACPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjACPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:01:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDEE6257;
        Tue,  3 Jan 2023 07:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34056B80F9D;
        Tue,  3 Jan 2023 15:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32045C433EF;
        Tue,  3 Jan 2023 15:01:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZEU+QTFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672758083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Wi9ZRVeh3Pac9gdkou/v2cNOa31fCafYfyWUT3Kr3k=;
        b=ZEU+QTFdcn8/wM4uwmRXY0iTfeJnw462+uvwVijCHAYTRzMEM9X/fGwuq4H0hB0+vdAWUN
        0SpQRZa9aIrwhFWWESP/keVgBqliMvdVcIE7ybqRBGR/tZoWvuQL52s0/l/9CZfvo6pWQl
        HrwsOL4AmDFm2NFf1S0OS9Y2pYyvu4s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f7395740 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 15:01:23 +0000 (UTC)
Date:   Tue, 3 Jan 2023 16:01:20 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7RDQLEvlLM0o4cp@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7QIg/hAIk7eZE42@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:50:43AM +0100, Ingo Molnar wrote:
> 
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > The vDSO getrandom() implementation works with a buffer allocated with a
> > new system call that has certain requirements:
> > 
> > - It shouldn't be written to core dumps.
> >   * Easy: VM_DONTDUMP.
> > - It should be zeroed on fork.
> >   * Easy: VM_WIPEONFORK.
> > 
> > - It shouldn't be written to swap.
> >   * Uh-oh: mlock is rlimited.
> >   * Uh-oh: mlock isn't inherited by forks.
> > 
> > - It shouldn't reserve actual memory, but it also shouldn't crash when
> >   page faulting in memory if none is available
> >   * Uh-oh: MAP_NORESERVE respects vm.overcommit_memory=2.
> >   * Uh-oh: VM_NORESERVE means segfaults.
> > 
> > It turns out that the vDSO getrandom() function has three really nice
> > characteristics that we can exploit to solve this problem:
> > 
> > 1) Due to being wiped during fork(), the vDSO code is already robust to
> >    having the contents of the pages it reads zeroed out midway through
> >    the function's execution.
> > 
> > 2) In the absolute worst case of whatever contingency we're coding for,
> >    we have the option to fallback to the getrandom() syscall, and
> >    everything is fine.
> > 
> > 3) The buffers the function uses are only ever useful for a maximum of
> >    60 seconds -- a sort of cache, rather than a long term allocation.
> > 
> > These characteristics mean that we can introduce VM_DROPPABLE, which
> > has the following semantics:
> > 
> > a) It never is written out to swap.
> > b) Under memory pressure, mm can just drop the pages (so that they're
> >    zero when read back again).
> > c) If there's not enough memory to service a page fault, it's not fatal,
> >    and no signal is sent. Instead, writes are simply lost.
> > d) It is inherited by fork.
> > e) It doesn't count against the mlock budget, since nothing is locked.
> > 
> > This is fairly simple to implement, with the one snag that we have to
> > use 64-bit VM_* flags, but this shouldn't be a problem, since the only
> > consumers will probably be 64-bit anyway.
> > 
> > This way, allocations used by vDSO getrandom() can use:
> > 
> >     VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> > 
> > And there will be no problem with OOMing, crashing on overcommitment,
> > using memory when not in use, not wiping on fork(), coredumps, or
> > writing out to swap.
> > 
> > At the moment, rather than skipping writes on OOM, the fault handler
> > just returns to userspace, and the instruction is retried. This isn't
> > terrible, but it's not quite what is intended. The actual instruction
> > skipping has to be implemented arch-by-arch, but so does this whole
> > vDSO series, so that's fine. The following commit addresses it for x86.
> 
> Yeah, so VM_DROPPABLE adds a whole lot of complexity, corner cases, per 
> arch low level work and rarely tested functionality (seriously, whose 
> desktop system touches swap these days?), just so we can add a few pages of 
> per thread vDSO data of a quirky type that in 99.999% of cases won't ever 
> be 'dropped' from under the functionality that is using it and will thus 
> bitrot fast?

It sounds like you've misunderstood the issue.

Firstly, the arch work is +19 lines (in the vdso branch of random.git).
That's very small and basic. Don't misrepresent it just to make a point.

Secondly, and more importantly, swapping this data is *not* permissible.
It doesn't matter if you think that certain systems don't use swap
anyway (you're wrong though regardless -- desktops will swap things
pretty regularly). It simply must *not* be swapped under any
circumstances. It's not that swapping is simply undesirable; it's
absolutely catastrophic. Do you understand that distinction?

If so, then if you don't like this solution, perhaps you could mention
something that accomplishes the goals in the commit message.

> The maintainability baby is being thrown out with the bath water IMO ...

Really? Are you sure this isn't just a matter of you not having written
it yourself or something? The commit is pretty short and basic. All the
actual internals for this kind of thing are already in present. The
commit just pipes it through.

> And we want to add more complexity to a facility people desperately want to 
> trust *more*? [RNG]

That seems like a ridiculous rhetorical leap.

> What's wrong with making mlock() more usable? Or just saying that "yeah, 
> the vDSO can allocate a few more permanent pages outside of existing 
> rlimits & mlock budgets"?

Did you actually read the commit message?

And now you're suggesting a rlimit backdoor? And adding more cases for
fork() to fail or block? That sounds terrible.

> The rest of the series looks fine to me, but this special one of a kind 
> VM_DROPPABLE is just way over-engineered cornercase functionality that 
> pushes us well past the maintenance_overhead<->complexity trade-off sweet spot ...

I think you should reevaluate that judgement. Consider the actual
problem. I think if you look at it carefully you'll see that this is a
pretty straight forward solution. It's deliberately not over-engineered.
It uses existing facilities and just does the plumbing in the right way
to make it work. It's really not that complicated.

The commit is +38, -4. The commit message has more lines than that.

Jason
