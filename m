Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E196443BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiLFM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLFM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:58:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C4BF55;
        Tue,  6 Dec 2022 04:58:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01EF5CE19A1;
        Tue,  6 Dec 2022 12:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2BBC433C1;
        Tue,  6 Dec 2022 12:57:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oFzeBUMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670331470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=liPeNLw89LSsmfUf/XpEXJGiJ2gApcr7EO13bm4ZYks=;
        b=oFzeBUMT5l1FnzbihzsK4Gs4lm23KIcxbKgVzPvG5IU+cbU8WJMWrTv3IFjEMwCTFVVri7
        vOXWG1RSr8Q3p4RL+lcENAjtUXvZxak9eyyW/XacY0cHjeVmyxG5gYgLCdoGM9RzV2PGt5
        qg2UsP6vW7bn+KNIDYUoKNFMEcHlYiw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f37b35d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Dec 2022 12:57:49 +0000 (UTC)
Date:   Tue, 6 Dec 2022 13:57:46 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org, vbabka@suse.cz
Subject: Re: [PATCH v11 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y488SnSlQALH9+Yk@zx2c4.com>
References: <20221205020046.1876356-1-Jason@zx2c4.com>
 <20221205020046.1876356-2-Jason@zx2c4.com>
 <CAG48ez2R=Ov2Z9zn_W9+C3gHqOkPdQKAY=4SMWDUG=NfP=3eJw@mail.gmail.com>
 <Y45OWhyN+U975vIN@zx2c4.com>
 <87bkohpqdt.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkohpqdt.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, Dec 05, 2022 at 09:06:06PM +0100, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> > Hi Jann,
> >
> > On Mon, Dec 05, 2022 at 08:13:36PM +0100, Jann Horn wrote:
> >> On Mon, Dec 5, 2022 at 3:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >> > +       mm->def_flags |=
> >> > +               /*
> >> > +                * Don't allow state to be written to swap, to preserve forward secrecy.
> >> > +                * This works in conjunction with MAP_LOCKED in do_mmap(), below, which
> >> > +                * actually does the locking (and associated permission check and accounting).
> >> > +                * Here, VM_LOCKONFAULT together with VM_NORESERVE simply make the mlocking
> >> > +                * happen the first time it's actually used, the same as when calling
> >> > +                * mlock2(MLOCK_ONFAULT) from userspace.
> >> > +                */
> >> > +               VM_LOCKONFAULT | VM_NORESERVE |
> >> 
> >> Have you checked the interaction with this line in dup_mmap()?
> >> "tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);"
> >> 
> >> As the mlock.2 manpage says, "Memory locks are not inherited by a
> >> child created via fork(2)". I think the intention here is that the VMA
> >> should stay unswappable after fork(), right?
> >> 
> >> Of course, trying to reserve more mlocked memory in fork() would also
> >> be problematic...
> >
> > Thanks for pointing that out! Indeed that seems problematic.
> > Fortunately, the use of WIPEONFORK at the same time as LOCKONFAULT means
> > that memory doesn't actually need to be reserved in fork() itself. So
> > something like the below seems correct and doable.
> >
> > Jason
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index ec57cae58ff1..cd53ffff615d 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -656,7 +656,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
> >  			tmp->anon_vma = NULL;
> >  		} else if (anon_vma_fork(tmp, mpnt))
> >  			goto fail_nomem_anon_vma_fork;
> > -		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> > +		if ((tmp->vm_flags & (VM_LOCKONFAULT | VM_WIPEONFORK)) !=
> > +		    (VM_LOCKONFAULT | VM_WIPEONFORK))
> > +			tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> >  		file = tmp->vm_file;
> >  		if (file) {
> >  			struct address_space *mapping = file->f_mapping;
> 
> Still it's a bit concerning that calling getrandom (the libc function)
> now apparently can kill the process if the system is under severe memory
> pressure.  In many cases, that's okay, but we wouldn't want that for
> PID 1, for example.  vm.overcommit_memory=2 mode is supposed to prevent
> such crashes, and I think NORESERVE (not shown here) sidesteps that.

Right. Setting VM_NORESERVE this way sidesteps it. Passing MAP_NORESERVE
to do_mmap() would make it respect vm.overcommit_memory=2, but then we'd
face problems at fork() time, as Jann pointed out, when we might go down
the path of trying to mlock memory from the fork() handler, and that
seems not so desirable. But moreover, the overcommitment potentially
makes the allocation scheme a lot simpler for libcs. Do any init daemons
actually use vm.overcommit_memory=2? Is this actually something to care
about?

If this isn't something we really care about so much, then my little
diff above should suffice, and this all remains very simple. I suspect
that's the case, because there are several VMAs that get set with
VM_NORESERVE already in the kernel.

If this is something we need to care about, then perhaps it's worth
rethinking the problem space from its basic goals:

- This memory must not be written to swap. Even if we added some flag to
  zero that part of swap when paging back in, that wouldn't cut it,
  because it's often very hard to "truly" zero out disk writes (and
  nobody wants to TRIM so often). (Rationale: forward secrecy.)

- It would be "nice" if untouched allocations didn't actually take
  up any memory.

- This needs to be wiped on fork.

Complications thus far encountered:

- VM_LOCKED|VM_LOCKONFAULT isn't inherited by forks.

- You're worried about forcing VM_LOCKONFAULT (rightfully or wrongly,
  as yet established).

However, there are two useful characteristics of this series that we
might be able to exploit in order to arrive at a solution:

1) Due to being wiped during fork(), the code is already robust to
   having the contents of those pages zeroed out midway through.

2) In the absolute worst case of whatever contingency we're coding for,
   we have the option to fallback to the getrandom() syscall, and
   everything is fine.

So, putting together the basic goals with the complications thus far
encountered, and trying to make use of (1) and (2), what if we introduce
a VM_DROPPABLE flag. The semantics would be:

a) It never is written out to swap.
b) No memory is pre-reserved / committed.
c) Under memory pressure, mm can just drop the pages and make them zero.
d) If there's not enough memory to service a page fault, it's not fatal,
   and no signal is sent. Instead, writes are simply lost, and reads
   return zero, as if the page was dropped.
e) It is inherited by fork.
f) The pages are zeroed on fork (like VM_WIPEONFORK).
g) It doesn't count against the mlock budget, since nothing is locked.

Then, as an emergent restriction, we require that each opaque_state
never straddle two pages, by returning a rounded up size_per_each.

What do you think of this plan? It's harder to implement, so I still
would prefer the simpler diff I sent to Jann above. But if you're really
convinced that disrespecting vm.overcommit_memory=2 is abominable, then
maybe this more complicated plan could work. Plus, semantic (g) has its
own advantages alone.

I'm CC'ing linux-mm about this matter, as I'm sure they'll have
something to contribute here. (And linux-mm@, if your reaction is "why
do we need this syscall at all, can't userspace just bla bla bla bla",
please read the cover letter of the series, this patch's commit message,
and prior discussion on that topic, so we don't have to rehash that.)

Jason
