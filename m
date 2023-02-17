Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4CD69B622
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBQXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99D542BE5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676675095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnjdH0ea2P72zfm1WHC+KD/KQEyH6Y4KuHMKINexhD8=;
        b=C8IpVNMAgt5IE9KMFhMhVuQICz7k894+g90dV6rTgJ0AEkJ1t1xV3h0Ea1MA8KQYya4XHZ
        PoUURmA/W68bE+AXOM2rzDyBN3Nse8+y4tRhkcC7oR1j2syGbFKZaKx1iKMhYdQaOMlKxo
        psUg0ZJ1cQW0AZkyHSqFH5WP2VU3UYA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-xmKm9yrfPqa6RI070R6rNQ-1; Fri, 17 Feb 2023 18:04:54 -0500
X-MC-Unique: xmKm9yrfPqa6RI070R6rNQ-1
Received: by mail-qv1-f71.google.com with SMTP id q5-20020a056214194500b0056ed45f262dso1153046qvk.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnjdH0ea2P72zfm1WHC+KD/KQEyH6Y4KuHMKINexhD8=;
        b=TLJWfn4dNHH+wM4tGN1YRQ1QuEKhxL0rnXkvxGQp5dubyMQ/q/ON/+AlhosN7/LxRa
         rVyUwyeyCDWKk8KhkSZKEdPrueq31D4LlNsshY9FNHavsEc/eWyxQLv1cvqtF+aDj9uX
         FMjavnCmALfaLCHiEzs/O0P/YjzArQ1VP/Efn0mwCGOeD1QTmWwfn7GiYuAEGHye+er8
         U2SFv+3gxLzUmFP11xvPsXQZgBF6wlbWANYMvl5b0zdq6V+Y9UB0ChKtGW0DwFkIASjw
         PHQpVr3TF3MnlbBEHsNQht+V/DIzcHeOWz6RSJIxvBYIH1kwIVgEzKQrxXyM1wl5CG8E
         U5bw==
X-Gm-Message-State: AO0yUKVtvafMUrhwvu8sciMLbLQgwnPaDxsrsi741nvfCRXpyznECBpH
        a/btqh5Go1C+myVQRRobp6qpuDbAdQxmC0DtnxBw5N2MRy135VtauJ+uiSG6LJTVidZY/rvI9+b
        2Kn2hbKHi8909h7L2BywZgtcU
X-Received: by 2002:a05:622a:188f:b0:3a9:86dd:3c5d with SMTP id v15-20020a05622a188f00b003a986dd3c5dmr5616157qtc.5.1676675093571;
        Fri, 17 Feb 2023 15:04:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8HDIH4smmBMyDLW72bkKQbFIpE7/z5Ld604Okr9JoYm0qMNdmYBTf0lGp0wJC9kHemXUU1Ww==
X-Received: by 2002:a05:622a:188f:b0:3a9:86dd:3c5d with SMTP id v15-20020a05622a188f00b003a986dd3c5dmr5616085qtc.5.1676675093034;
        Fri, 17 Feb 2023 15:04:53 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85045000000b003bd1a464346sm2167740qtm.9.2023.02.17.15.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 15:04:52 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:04:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Message-ID: <Y/AIEvHJoMUnh4b6@x1n>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
 <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com>
 <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
 <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:41:40PM +0100, David Hildenbrand wrote:
> On 16.02.23 21:08, Peter Xu wrote:
> >          On Thu, Feb 16, 2023 at 07:23:17PM +0100, David Hildenbrand wrote:
> > > On 16.02.23 18:55, Peter Xu wrote:
> > > > On Thu, Feb 16, 2023 at 06:00:51PM +0100, David Hildenbrand wrote:
> > > > > > > 
> > > > > > > There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
> > > > > > > PTE markers, would be more benficial:
> > > > > > > 
> > > > > > > 1) It would be applicable to anon hugetlb
> > > > > > 
> > > > > > Anon hugetlb should already work with non ptes with the markers?
> > > > > > 
> > > > > 
> > > > > ... really? I thought we'd do the whole pte marker handling only when
> > > > > dealing with hugetlb/shmem. Interesting, thanks. (we could skip population
> > > > > in QEMU in that case as well -- we always do it for now)
> > > > 
> > > > Hmm, you're talking about "anon hugetlb", so it's still hugetlb, right? :)
> > > 
> > > I mean especially MAP_PRIVATE|MAP_HUGETLB|MAP_ANONYMOUS, so "in theory"
> > > without any fd and thus pagecache. ... but anon hugetlb keeps confusing me
> > > with pagecache handling.
> > 
> > IIUC when mmap(fd==-1) it's the same as MAP_PRIVATE|MAP_HUGETLB.
> 
> Let me rephrase my original statement: I thought we'd do the whole pte
> marker handling only when dealing with MAP_SHARED hugetlb ("hugetlb shared
> memory (shmem)"). So not on MAP_PRIVATE hugetlb where we might have anon
> hugetlb pages.

Okay, then we're good - I believe private was handled there.

> 
> 
> > > The focus of that paper is on CoW latency yes (and deduplication
> > > instantiating shared zeropages -- but building a covert channel using CoW
> > > latency might be rather tricky I think, because they will get deduplciated
> > > independently of a sender action ...).
> > > 
> > > However, in theory, one could build a covert channel between two VMs simply
> > > by using cache flushes and reading from the shared zeropage. Measuring
> > > access time can reveal if the sender read the page (L3 filled) or not (L3
> > > not filled).
> > 
> > So the attacker will know when someone reads a zeropage, but I still don't
> > get how that can leads to data leak..
> 
> Oh, a covert channel is not for leaking data, but for communicating via an
> unofficial channel (bypassing firewalls etc). I also don't think one can
> really leak data with the shared zeropage ... unless that data is all zero
> :)

I see.

> 
> > > 
> > > Having that said, I don't think that we are going to disable the shared
> > > zeropage because of that for some workloads, I assume in most cases it will
> > > simply be way too noisy to transmit any kind of data and we have more
> > > critical covert channels to sort out if we want to.
> > > 
> > > Just wanted to raise it because you asked :)
> > > 
> > > > 
> > > > Another note for s390: when it comes we can consider moving to pte markers
> > > > conditionally when !zeropage.  But we can leave that for later.
> > > 
> > > Sure, we could always have another feature flag.
> > 
> > I think that doesn't need to be another feature flag.  If someone will port
> > uffd-wp to s390 we can implement pte markers for WP_ZEROPAGE, then we
> > either use it when zeropage not exist, or we can switch to pte markers
> > completely too without changing the interface if we want, depending on
> > whether we think replacing zeropages with pte markers will be a major issue
> > with existing apps.  I don't worry too much on that part.
> 
> Then maybe the feature name/description should be more generic, such that
> it's merely an implementation detail that could change?
> 
> "
> UFFD_FEATURE_WP_UNPOPULATED: for anonymous memory, if PTEs/PMDs are still
> unpopulated (no page mapped), uffd-wp protection to work will not require a
> previous manual population (e.g., using MADV_POPULATE_READ). The kernel
> might or might not populate the shared zeropage for that purpose. So after a
> uffd-wp protection with UFFD_FEATURE_WP_UNPOPULATED enabled, the PTEs/PMDs
> might or might not be populated.
> "

I would really hope we don't mention "manual population" in the man page or
header comments for app developers.

That's "how to workaound some issue", I'll read it as "with flag XXX you
don't need to work around (issue YYY) by doing ZZZ".

It's much more straightforward to state what the flag will do.  The
workaround can be documented somewhere but that shouldn't be in the general
description of the feature.

I don't have a strong opinion on the name, though.  I guess you would like
the new feature to avoid using the term zeropage; I'm fine with changing it.

> 
> For example, it has to be clear that when doing an uffd-wp protect +
> unprotect, that there could be suddenly zeropages mapped (observable via
> uffd-missing later, /proc/pagemap).
> 
> I'd be fine with something like that.
> 
> [...]
> 
> > > > > Using PTE markers would provide a real advantage IMHO for some users (IMHO
> > > > > background snapshots), where we might want to avoid populating
> > > > > zeropages/page tables as best as we can completely if the VM memory is
> > > > > mostly untouched.
> > > > > 
> > > > > Naturally, I wonder if UFFD_FEATURE_WP_ZEROPAGE is really worth it. Is there
> > > > > is another good reason to combine the populate zeropage+wp that I am missing
> > > > > (e.g., atomicity by doing both in one operation)?
> > > > 
> > > > It also makes the new WP_ASYNC and pagemap interface clean: we don't want
> > > > to have user pre-fault it every time too as a common tactic..  It's hard to
> > > > use, and the user doesn't need to know the internals of why it is needed,
> > > > either.
> > > 
> > > I feel like we're building a lot of infrastructure on uffd-wp instead of
> > > having an alternative softdirty mode (using a world switch?) that works as
> > > expected and doesn't require that many uffd-wp extensions. ;)
> > 
> > We used to discuss this WP_ZEROPAGE before, and I thought we were all happy
> > to have that.  Obviously you changed your mind. :)
> 
> As I said, I'd be sold on the PTE marker idea, or designing the feature more
> generic that it is an implementation detail. :)
> 
> The whole "let's place zeropages" is rather a hack and IMHO suboptimal.
> 
> For example, when uffd-wp unprotecting again (e.g., after a VM snapshot),
> we'd be left with zeropages mapped. Getting rid of them (for example, to
> reclaim page tables), will require TLB flushes, mmu notifiers, because we
> had present PTEs. In comparison, the nice thing about a PTE marker is that
> it is !present and you can just rip it out.

MMU notifiers do not make a difference, afaict, because that's
unconditional and irrelevant of what's changed underneath.

For TLB flush - I'm not sure how large will there be a difference
(e.g. considering tlb batching being there), but it's a very valid point.

> 
> Similarly, with zeropages (as in your current patch), getting a THP later
> allocated requires going through khugepaged. In comparison, a PMD marker
> could more easily avoid that. The huge zeropage can work around that, but
> you'd still need an MADV_DONTNEED on the hole huge zeropage first to remove
> it, in order to replace it with a "real" THP.

IMHO relying on khugepaged is fine.

Note again that the whole wr-protect idea so far is always talking on
PAGE_SIZE.  Any write happened in whatever PMD/PUD marker will go into:

  - A pte marker population storm, which happens _inside_ a page fault of
    the workload thread (rather than the monitor thread),

  - The bigger the pte marker (PUD > PMD > PTE), the higher possibility
    that it'll trigger such a storm as long as any of the page is written.

It means no matter which way we choose, as long as a write happened the
whole THP idea will get lost as long as the tracking is still in progress.

I still think zeropage should be rare in serious productions, I think it's
more likely that above will happen easily in practise and it can have an
negative impact on page faults.  Even if we give more chance of having THPs
in the future, we at least pay something else.  It's hard to tell which is
more worthwhile.

Not to mention that'll introduce more compexity to the kernel besides the
anonymous support, which should still be relatively straightforward.

So I'm fine with switching to pte markers, but I'd leave the PMD+ markers
alone for now.

> 
> > 
> > I wasn't really eager on this before because the workaround of pre-read
> > works good already (I assume slightly slower but it's fine; not until
> > someone starts to worry).  But if we want to extend soft-dirty that's not
> > good at all to have any new user being requested to prefault memory and
> > figuring out why it's needed.
> > 
> > > 
> > > Having that said, I have the feeling that you and Muhammad have a plan to
> > > make it work using uffd-wp and I won't interfere. It would be nicer to use
> > > softdirty infrastructure IMHO, though.
> > 
> > Thanks.  If you have any good idea on reusing soft-dirty, please shoot.
> > I'll be perfectly happy with it as long as it resolves the issue for
> > Muhammad.  Trust me - I wished the soft dirty thing worked out, but
> > unfortunately it didn't..  Because at least so far uffd-wp has two major
> > issues as I can see:
> > 
> >    (1) Memory type limitations (e.g. general fs memories stop working)

[1]

> >    (2) Tracing uffd application is, afaict, impossible
> 
> I guess the nice thing is, that you can only track individual ranges, you
> don't have to enable it for the whole process. I assume softdirty tracking
> could be similarly extended, but with uffd-wp this comes naturally.
> 
> > 
> > So if there's better way to do with soft-dirty or anything else (and I
> > assume it'll not be limited to any of above) it's time to say..
> 
> I started discussing that [1] but as nobody seemed to care about my input I
> decided to not further spend my time on that. But maybe it's a more
> fundamental issue we'd have to solve to get this clean.

The idea of merging VMAs during clear_refs sounds interesting.

> 
> The problem I had with the original approach is that it required precise
> softdirty tracking even when nobody cared about softdirty tracking, and that
> it made wrong assumptions about the meaning of VM_SOFTDIRTY. We shouldn't
> have to worry about any of that if it's disabled (just like with uffd-wp).
> 
> 
> The semantical difference I see is that with uffd-wp, initially (pte_none())
> all PTEs are "dirty". With soft-dirty, initially (pte_none()) all PTEs are
> "clean". We work around that with VM_SOFTIDRTY, which sets all PTEs of a VMA
> effectively dirty.
> 
> 
> Maybe we should rethink that approach and logically track soft-clean
> instead. That is, everything is assumed to be soft-dirty until we set it
> clean on a PTE/PMD/PUD level. Setting something clean is wp'ing a PTE and
> marking it soft-clean (which is, clearing the soft-dirty bit logically).

To me both solutions should be mostly the same but just inverted bits.  The
bits (for async) doesn't make sense before the "trigger" is pulled, then
it's about 0/1 with inverted meanings to me.  It's just that soft-dirty
will naturally work well with none ptes but uffd-wp is not (since none pte
has all bits 0).

> 
> The special case is when we don't have anything mapped yet, which is the
> same thing we are trying to handle AFAICS for uffd-wp here. A PTE
> (pte_none()) in which case we have to install a soft-dirty PTE/PMD marker to
> remember that we marked it as clean -- or map the shared zeropage to mark
> that one clean (not set the soft-dirty bit).

Yes, soft-dirty is another valid user to pte markers; that's also in my
very original proposal of it.  If we can have async-uffd-wp then it's
easier because the uffd-wp marker will simply be reused naturally.

> 
> Further, I would propose to have VM_SOFTDIRTY_ENABLED flags per VMA and
> interfaces to (a) enable/disable it either for some VMAs or the whole MM and
> (b) a process toggle to automatically enable softclean tracking on new VMAs.
> So we can really only care about it when someone cares about softdirty
> tracking. The old "VM_SOFTDIRTY" flag could go, because everything
> (pte_none()) starts out softdirty. So VM_SOFTDIRTY -> VM_SOFTDIRTY_ENABLED
> with changed semantics.
> 
> Enabling softdirty-tracking on a VMA might have to go over PTEs, to make
> sure we really don't have any soft-clean leftovers due to imprecise
> soft-dirty tracking on VMA level while it was disabled (setting all PTEs
> soft-dirty if they not already are). Might require a thought if it's really
> required.
> 
> Note that I think this resembles what we are doing with uffd-wp. Not sure if
> we'd still have to handle some unmap handling on pagecache pages. We might
> want to remember that they are soft-clean using a PTE marker.
> 
> 
> Requires some more thought, but I'm going to throw it out here that I think
> there might be ways to modify softdirty tracking.

As you mentioned, I think the new proposal is growing into uffd-wp-alike.
I think that's (maybe) also another reason why reusing uffd here is a good
idea, because we don't need to reinvent everything.

Need a new vma flag to identify from old?  Uffd-wp already has it.

What happens if shmem swapped out?  Uffd-wp handles it.

Need to be accurate and walk the pgtables?  Uffd-wp does it..

One thing I didn't mention before (mostly referring to the 1st major
"defect" of using uffd-wp above I said [1] on memory types): _maybe_ we can
someday extend at least async mode of uffd-wp to all memory types, so it'll
even get everything covered.  So far I don't see a strong requirement of
doing so, but I don't see a major blocker either.

While the other "uffd cannot be nested" defect is actually the same to
soft-dirty (no way to have a tracee being able to clear_refs itself or
it'll also go a mess), it's just that we can still use soft-dirty to track
an uffd application.

> 
> > > > 
> > > > The other thing is it provides a way to make anon and !anon behave the same
> > > > on empty ptes; it's a pity that it was not already like that.
> > > 
> > > In an ideal world, we'd simply be using PTE markers unconditionally I think
> > > and avoid this zeropage feature :/
> > > 
> > > Is there any particular reason to have UFFD_FEATURE_WP_ZEROPAGE and not
> > > simply always do that unconditionally? (sure, we have to indicate to user
> > > space that it now works as expected) Are we really expecting to break user
> > > space by protecting what was asked for to protect?
> > 
> > I suspect so.
> > 
> >  From high level, the major functional changes will be:
> > 
> >    (1) The user will start to receive more WP message with zero page being
> >        reported,
> > 
> >    (2) Wr-protecting a very sparse memory can be much slower
> > 
> > I would expect there're cases where the app just works as usual.
> > 
> > However in some other cases the user may really not care about zero pages
> > at all, and I had a feeling that's actually the majority.
> > 
> > Live snapshot is actually special because IIUC the old semantics should
> > work perfectly if the guest OS won't try to sanity check freed pages being
> > all zeros..  IOW that's some corner case, and if we can control that we may
> > not even need WP_ZEROPAGE too for QEMU, iiuc.  For many other apps people
> > may leverage this (ignoring mem holes) and make the app faster.
> > 
> > Normally when I'm not confident of any functional change, I'd rather use a
> > flag.  Luckily uffd is very friendly to that, so the user can have better
> > control of what to expect.  Some future app may explicitly want to always
> > ignore zero pages when on extremely sparse mem, and without the flag it
> > can't choose.
> > 
> > > 
> > > > 
> > > > We can always optimize this behavior in the future with either
> > > > PMD/PUD/.. pte markers as you said, but IMHO that just needs further
> > > > justification on the complexity, and also on whether that's beneficial to
> > > > the majority to become the default behavior.
> > > 
> > > As I said, usually any new features require good justification. Maybe there
> > > really is a measurable performance gain (less syscalls, less pgtable walks).
> > 
> > Muhammad may have a word to say here; let's see whether he has any comment.
> > 
> > Besides that, as I replied above I'll collect some data in my next post
> > regardless, with an attempt to optimize with huge zeropages on top.
> 
> If we can agree on making the shared zeropage an implementation detail, that
> would be great and I'd see long-term value in that.
> 
> [1]
> https://lkml.kernel.org/r/d95d59d7-308d-831c-d8bd-16d06e66e8af@redhat.com

So I assume there's no major issue to not continue with a new version, then
I'll move on.

Thanks,

-- 
Peter Xu

