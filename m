Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAD68FFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBIFKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjBIFKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:10:24 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A51CAD11
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:10:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j17so1683248lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 21:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/g8ONxAswj4wfgsSHSlKz0vSNm3x2HjlrC970y+BKOk=;
        b=axRWuqS3bpuW5u19Cc7sE3VGd1tk4T+EFQOO1vdC8iei4tGTYErXEQCWeHybyzGABq
         3tixCdC19N/iFc2/eXMy8P6bFiRtF6FM42No+6lo08dzIOf+gsCLZcJRZlNwMWFJB1Ot
         TF1vEcOZXvwPo3x/zgViXuP8y794ZHMsfY020=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g8ONxAswj4wfgsSHSlKz0vSNm3x2HjlrC970y+BKOk=;
        b=B+eFRZ3uBTEniQj2n9YXiVMQbxQoppPVp0Ui39QmXnJeTjgYOGA8XA3KKPYe6aIlJ7
         OkNvzXZRXZYxf6siiAR6GZqwC5ZC5uFn9skTQQ2s6080hUsuJJXVOWjh3XVBRel20fl1
         sBVqNQxXVHOLMbucn/14Ijsqo7WlFzIoAw9D1jPNVj3fwPcZCRc0pwZgHMRnzq7UlrnX
         FIR0+TN/HVQ4zvN7fCw+qY0P5aksq+3Yrf2I2ZdCnMK9fOC4ndb7addenI/S0YfwQimh
         oGctuWUZyVKf7qLb3FZQzCzqEzIxN6+r6eCjkUAg0TEHu3aw6R9uxMls96oi639lECvw
         DWMA==
X-Gm-Message-State: AO0yUKWQVcSnnkhguKDp5kx3a1gOCuE4X0z3x9x6634HjjHnyAB1klrb
        cKiqG/gfnwUYz0Hkdy90TSN+tHkvoiUFvgfPt1KatytF/biq1yBi
X-Google-Smtp-Source: AK7set/zcP7jfDxsV+7reESEIIXn3OYbqhb4qqDvW23yZNzbwau8lY6dnuE5m3ecbkDjtYfTSLft1qd7/ZtsQxZ8qjk=
X-Received: by 2002:a05:6512:3769:b0:4cb:1ddd:3b5 with SMTP id
 z9-20020a056512376900b004cb1ddd03b5mr1419973lft.171.1675919419790; Wed, 08
 Feb 2023 21:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20230206112856.1802547-1-stevensd@google.com> <Y+Fq8lwsl7RXwlNS@x1n>
 <CAD=HUj67pC_0f8LwaD_bcYvtpZ1Wi8Hz2SpZD7eXpBVgmZ3p8g@mail.gmail.com>
 <Y+J9jnhEC7xYoCCW@x1n> <CAD=HUj6zhD6gVqG8VOJVmzXzzp5WC3QwP9wQ-Osk3MTsNSE3jQ@mail.gmail.com>
 <Y+PauOuAO4nu6Q0k@x1n>
In-Reply-To: <Y+PauOuAO4nu6Q0k@x1n>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 9 Feb 2023 14:10:08 +0900
Message-ID: <CAD=HUj6Adtfthbj0i8QU6eY4oRRti-Sr39fCQcKyrAbCv28ZRQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 9, 2023 at 2:24 AM Peter Xu <peterx@redhat.com> wrote:
> On Wed, Feb 08, 2023 at 11:42:22AM +0900, David Stevens wrote:
> > On Wed, Feb 8, 2023 at 1:34 AM Peter Xu <peterx@redhat.com> wrote:
> > > On Tue, Feb 07, 2023 at 12:56:56PM +0900, David Stevens wrote:
> > > > On Tue, Feb 7, 2023 at 6:02 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> > > > > > From: David Stevens <stevensd@chromium.org>
> > > > > > @@ -1802,13 +1810,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > > >                                               result = SCAN_TRUNCATED;
> > > > > >                                               goto xa_locked;
> > > > > >                                       }
> > > > > > -                                     xas_set(&xas, index);
> > > > > > +                                     xas_set(&xas, index + 1);
> > > > >
> > > > > I failed to figure out why this index needs a shift here... It seems to me
> > > > > it'll ignore the initial empty page cache, is that what the patch wanted?
> > > >
> > > > This chunk is preceded by a call to xas_next_entry. Previously,
> > > > xas_store(hpage) would pair with xas_set(index) to walk the xarray and
> > > > prepare xas for the xas_next at the start of the next loop iteration.
> > > > Now that we're no longer calling xas_store, xas_set(index+1) is
> > > > necessary to prepare xas for the next iteration of the loop.
> > >
> > > If I'm not wrong, xas_store() doesn't move the niddle at all.  It's the
> > > xas_next() at the entry of the loop that does.
> >
> > xas_set(n) resets the cursor to the top of the tree. If the cursor is
> > at the top of the tree, then xas_next() walks to n instead of
> > advancing n to n+1. xas_store() on the other hand behaves the same
> > regardless of whether or not the cursor is at the top of the tree (it
> > starts by calling xas_create or xas_load, which will walk the tree if
> > necessary).
> >
> > Looking at it another way, if we're here, then start == index. So if
> > we were to call xas_set(&xas, index), xas at the start of the next
> > iteration would be in an identical state to when we entered the loop
> > the first time. So xas would be one value behind index, and we would
> > never actually examine the last entry in the range being collapsed.
>
> Are you suggesting that this is a bug in the existing code?
>
> My read on this whole chunk is: if this is the first page we're scanning
> and it's missing, let's have a look to make sure the whole THP isn't
> truncated.  If it is, we return SCAN_TRUNCATED.  Otherwise, we fill up the
> holes _starting from this index 0_.

This overlooks the fact that we've already processed index 0 during
this iteration. The last sentence should be along the lines of:
Otherwise, we continue examining subsequent pages in the chunk.

> AFAIU your change here will make that last sentence start from index 1.

The original code is correct. The important thing to keep in mind is
that xas_next() behaves differently depending on whether or not
xas_not_node(xa_node) is true. Stepping through the relevant lines of
the code and showing the relevant state after each xas call executes:

xas_set(&xas, start);
  (index == start, xa_index == start, xa_node == XAS_RESTART)
xas_next(&xas); -> returns entry at start
  (index == start, xa_index == start, xa_node == start)
xas_next_entry(&xas, end - 1);
  (index == start , xa_index == x, xa_node == x, where x > start)

From here, the original code has:

xas_set(&xas, start);
  (index == start, xa_index == start, xa_node == XAS_RESTART)
xas_store(&xas, hpage);
  (index == start, xa_index == start, xa_node == start)
xas_next(&xas); -> returns entry at start + 1
  (index == start + 1, xa_index == start + 1, xa_node == start + 1)

With my patch, we have:

xas_set(&xas, start + 1);
  (index == start, xa_index == start + 1, xa_node == XAS_RESTART)
xas_next(&xas); -> returns entry at start + 1
  (index == start + 1, xa_index == start + 1, xa_node == start + 1)

If instead we were to do as you suggest, we would have:

xas_set(&xas, start);
  (index == start, xa_index == start, xa_node == XAS_RESTART)
xas_next(&xas); -> returns entry at start
  (index == start + 1, xa_index == start, xa_node == start)

In this version, there is a mismatch between index and xa_index.
Because of this, we will end up breaking out of the loop before
xa_index is able to reach xa_index +  HPAGE_PMD_NR - 1, so we will
miss the last entry in the chunk.

> > > > > > @@ -1967,6 +1974,46 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > > >               put_page(page);
> > > > > >               goto xa_unlocked;
> > > > > >       }
> > > > > > +
> > > > > > +     if (nr_none) {
> > > > > > +             struct vm_area_struct *vma;
> > > > > > +             int nr_none_check = 0;
> > > > > > +
> > > > > > +             xas_unlock_irq(&xas);
> > > > > > +             i_mmap_lock_read(mapping);
> > > > > > +             i_mmap_locked = true;
> > > > > > +             xas_lock_irq(&xas);
> > > > > > +
> > > > > > +             xas_set(&xas, start);
> > > > > > +             for (index = start; index < end; index++) {
> > > > > > +                     if (!xas_next(&xas))
> > > > > > +                             nr_none_check++;
> > > > > > +             }
> > > > > > +
> > > > > > +             if (nr_none != nr_none_check) {
> > > > > > +                     result = SCAN_PAGE_FILLED;
> > > > > > +                     goto xa_locked;
> > > > > > +             }
> > > > > > +
> > > > > > +             /*
> > > > > > +              * If userspace observed a missing page in a VMA with an armed
> > > > > > +              * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> > > > > > +              * that page, so we need to roll back to avoid suppressing such
> > > > > > +              * an event. Any userfaultfds armed after this point will not be
> > > > > > +              * able to observe any missing pages, since the page cache is
> > > > > > +              * locked until after the collapse is completed.
> > > > > > +              *
> > > > > > +              * Pairs with smp_wmb() in userfaultfd_set_vm_flags().
> > > > > > +              */
> > > > > > +             smp_rmb();
> > > > > > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> > > > > > +                     if (userfaultfd_missing(vma)) {
> > > > > > +                             result = SCAN_EXCEED_NONE_PTE;
> > > > > > +                             goto xa_locked;
> > > > > > +                     }
> > > > > > +             }
> > > > > > +     }
> > > > >
> > > > > Thanks for writting the patch, but I am still confused why this can avoid
> > > > > race conditions of uffd missing mode.
> > > > >
> > > > > I assume UFFDIO_REGISTER is defined as: after UFFDIO_REGISTER ioctl
> > > > > succeeded on a specific shmem VMA, any page faults due to missing page
> > > > > cache on this vma should generate a page fault.  If not, it's violating the
> > > > > userfaultfd semantics.
> > > > >
> > > > > Here, I don't see what stops a new vma from registering MISSING mode right
> > > > > away in parallel of collapsing.
> > > > >
> > > > > When registration completes, it means we should report uffd missing
> > > > > messages on the holes that collapse_file() scanned previously.  However
> > > > > they'll be filled very possibly later with the thp which means the messages
> > > > > can be lost.  Then the issue can still happen, while this patch only makes
> > > > > it very unlikely to happen, or am I wrong?
> > > >
> > > > This race can still happen, but I don't think it's actually a problem.
> > > > In particular, I think the semantics you've given for UFFDIO_REGISTER
> > > > are overly restrictive on the kernel in a way that provides no
> > > > meaningful benefit to userspace.
> > > >
> > > > To simplify things a little bit, we only need to consider going from
> > > > zero to non-zero (i.e. one) userfaultfd. The case where a userfaultfd
> > > > is already registered isn't particularly interesting, since khugepaged
> > > > would have seen the existing userfaultfd and given up on the collapse.
> > >
> > > Could you point me which part of the code you're referencing here?
> >
> > I'm referencing the behavior with this patch. With my patch, all
> > khugepaged cares about is whether there exists an armed userfaultfd on
> > a given VMA. If there already exists an armed userfaultfd on a given
> > VMA, then with my patch, khugepaged will give up collapsing. So the
> > case where a second/third/etc userfaultfd is being armed isn't
> > interesting, because khugepaged will already not be doing anything, so
> > there cannot be any race condition.
> >
> > > Note that unlike anonymous thp collapsing scan (hpage_collapse_scan_pmd),
> > > hpage_collapse_scan_file works on page caches only.
> > >
> > > >
> > > > When userspace registers the first userfaultfd, it cannot rely on any
> > > > knowledge about the presence or absence of pages from before when
> > > > UFFDIO_REGISTER completes. This is because, as far as userspace is
> > > > concerned, khugepaged could have come along and collapsed every single
> > > > page in the shmem right after UFFDIO_REGISTER entered the kernel. So
> > > > to properly use the userfaultfd API, userspace must re-examine the
> > > > state of memory after UFFDIO_REGISTER completes. Because of that,
> > > > having UFFDIO_REGISTER be a complete barrier with regards to
> > > > khugepaged is essentially meaningless from the perspective of
> > > > userspace. The guarantee might slightly reduce the window for some
> > > > races in userspace programs, but there are no userspace races that it
> > > > can completely resolve.
> > > >
> > > > Given that, the kernel just needs to guarantee that no missing page
> > > > which userspace might have observed after registering a userfaultfd is
> > > > filled by khugepaged. This patch takes the page cache lock, checks
> > > > that there are no registered userfaultfds, fills the missing pages,
> > > > and then releases the page cache lock. That's sufficient to guarantee
> > > > that any UFFDIO_REGISTER which occurs after the userfaultfd check but
> > > > before we finish the collapse can't actually observe any missing
> > > > pages.
> > >
> > > I don't think your current patch guaranteed that?
> > >
> > > Now I'm confused why you removed population of the small pages using hpage,
> > > because that seems to support what you're doing here.  Note that your
> > > current code is added _before_ the replacement of the huge page here:
> > >
> > >         /* Join all the small entries into a single multi-index entry */
> > >         xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> > >         xas_store(&xas, hpage);
> > >
> > > So either the patch needs to keep the original logic to fill up the holes
> > > with hpage, or the vma checks needs to be done later, to achieve what you
> > > proposed to happen, IIUC.
> >
> > Maybe I'm fundamentally misunderstanding how locking for shmem works?
> > With my patch, we effectively have:
> >
> > xas_lock_irq(&xas);
> > <check that userfaultfd_missing(VMA) == false for all VMAs>
> > xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> > xas_store(&xas, hpage);
> > xas_unlock_irq(&xas);
> >
> > Here's my understanding. If there are no armed userfaultfds during the
> > check, then userspace could not have made any observations of the
> > shmem with an armed userfaultfd before collapse_file locked xas. The
> > xas_store() is where missing pages become present pages. Since this
> > happens while xas is still locked, we know that no additional
> > observations of shmem could have occured since locking xas. So even if
> > registration of a new userfaultfd raced with the check, we know that
> > new userfaultfd couldn't have made any observations of shmem.
> >
> > Are you saying that it's possible for something to come in and observe
> > a missing page from the shmem between when we check the VMAs and when
> > we store hpage, even though xas is locked? Or that userspace can
> > observe shmem completely independently of the locking done by
> > xas_lock_irq(&xas)?
>
> AFAIU a pure lookup is done without xas lock but rcu read lock.  More
> below.
>
> >
> > > Besides, please imagine an uffd program that does this:
> > >
> > >   (1) ioctl(UFFDIO_REGISTER) upon the shmem vma
> > >   (2) lseek(SEEK_DATA) on one page P1 (which is part of THP range T1), it
> > >       noticed that it returns DATA, means this is not a hole.  So it's
> > >       expected that there will be no further message generated to this page.
> > >   (3) After a while, it received a missing fault on page P1
> > >
> > > My question is whether above is a problem or not?  Whether it violates the
> > > userfaultfd missing mode semantics?
> > >
> > > AFAICT, above can happen if some program accidentally registers UFFD
> > > missing mode during collapsing of the shmem thp P1 if with current logic
> > > applied.
> >
> > That's a bug that can occur with khugepaged as it exists before my
> > patch, if collapse_file fills a missing page but then needs to roll
> > back the collapse. With my patch, khugepaged doesn't fill any missing
> > pages until after it knows for sure the collapse will succeed, so I
> > don't see any way for collapse_file to cause a formerly present page
> > to become absent.
>
> Right, I should have reversed the conditions, sorry:
>
>   (1) ioctl(UFFDIO_REGISTER) upon the shmem vma
>   (2) lseek(SEEK_DATA) on one page P1 (which is part of THP range T1), it
>       noticed that it returns HOLE.
>   (3) The HOLE got collapsed into a THP
>
> I think it can still happen after the patch applied.  lseek has:
>
>   shmem_file_llseek -> mapping_seek_hole_data -> find_get_entry
>
> So I think it can happen concurrently, that one thread does (1+2) before
> your patch collapsed the thp in the page cache but after the vma checks.

Ah, I see what you're saying. I didn't fully understand the locking in
the page cache.

I think Matthew's suggestion earlier of using RETRY entries might
work. We would still need to consolidate the mark/check/collapse
sequence into a single xas_lock critical section, though, since things
will end up spinning on the RETRY within rcu critical sections.

That said, is using XA_RETRY_ENTRY a proper use of the xarray API? I
don't see anything in the kernel external to xarray using it. I would
think XA_ZERO_ENTRY would be more appropriate (i.e. what xa_reserve
uses), but the handling for that is inconsistent. XA_ZERO_ENTRY is
sufficient to cause mapping_get_entry to retry, but it looks like
everywhere else in filemap/shmem that directly iterates over the page
cache does if (xas_retry()) continue, which would end up not retrying
in the XA_ZERO_ENTRY case.

> What I'm so far sincerely not sure is whether we should care about the case
> like lseek (or, mincore can do similar if without swap being considered).

It would be nice to at least get lseek to work. We want to use lseek
to determine what pages of guest memory are actually allocated, to
reduce how much data needs to be processed. I guess the occasional
race with khugepaged causing pages to spuriously be present isn't
really a huge problem for us, though.

-David
