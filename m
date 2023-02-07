Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD368CDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBGD5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjBGD5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:57:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95136FE1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:57:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x40so20605226lfu.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 19:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cmbgy/dk/KM5fNnP/CWmg75pB7stm98G07WjYtP+amc=;
        b=NhW/mAsJLUcZ5cUgFaALR06OBhCB2W4HdnNqNi0jZdgAics2Z8mLECVSlxcCN6OnDs
         xfjmUCUVTINatPYxEkqjTXwW13cSY8XjVvKB32qxPKOLoWmXiWcjqKmpZwmrSvL14cBO
         jvwg1ixTUN+IHZi/CuBGX56IaRgkGINrhRciM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmbgy/dk/KM5fNnP/CWmg75pB7stm98G07WjYtP+amc=;
        b=ONXWKG3AUW9B0JjShfseO1RnlrAhQ9qAVsTn2daXLfbBzq+Xp4RT9Sz5xakucl7BbB
         pC/3qsxEbptirD+y7smoAClvQs2jY3me742RteqsLDgH209A7m4em3M5EyGYPleEzCLw
         3VaZLLXhEn7g3N5trbTMU/8AVFSnrWNn2PgpYwgJc4xXsLcoEvWFcX1xXGWXohLsrun1
         6NkgnLKnT5+itCqPmFpuxYSKH7kEr3QX17YAe+mf7WRG+C8Ae8J6/szqfhbp3mhZF1bK
         RmcGMJyGXtp4VYEI16u0p/pvk0oFKxqBjTQWqD0uAfAPFQVc90pe/rAlqw76QXPI0jeH
         SonA==
X-Gm-Message-State: AO0yUKVdwzmb+Bf82PsZh6N0Fu+fS0s7vW8ZqzXpN82SGoLGdYCFwrl5
        ZCjt02lRF1UwdLlo/DEdpCx0qQKG3g5V4aad/flegQ==
X-Google-Smtp-Source: AK7set/YZbgbvISnNERs7dOsmgWxaz2WQd+WUAOaANjJCQ3Zs4QKHFSH7oL+ncgcuYDsP1wJH6fXRi26DnmkGdR248E=
X-Received: by 2002:ac2:42cf:0:b0:499:f8e4:6dd0 with SMTP id
 n15-20020ac242cf000000b00499f8e46dd0mr198076lfl.162.1675742227863; Mon, 06
 Feb 2023 19:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20230206112856.1802547-1-stevensd@google.com> <Y+Fq8lwsl7RXwlNS@x1n>
In-Reply-To: <Y+Fq8lwsl7RXwlNS@x1n>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 7 Feb 2023 12:56:56 +0900
Message-ID: <CAD=HUj67pC_0f8LwaD_bcYvtpZ1Wi8Hz2SpZD7eXpBVgmZ3p8g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:02 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Collapsing memory will result in any empty pages in the target range
> > being filled by the new THP. If userspace has a userfaultfd registered
> > with MODE_MISSING, for any page which it knows to be missing after
> > registering the userfaultfd, it may expect a UFFD_EVENT_PAGEFAULT.
> > Taking these two facts together, khugepaged needs to take care when
> > collapsing pages in shmem to make sure it doesn't break the userfaultfd
> > API.
> >
> > This change first makes sure that the intermediate page cache state
> > during collapse is not visible by moving when gaps are filled to after
> > the page cache lock is acquired for the final time. This is necessary
> > because the synchronization provided by locking hpage is insufficient
> > for functions which operate on the page cache without actually locking
> > individual pages to examine their content (e.g. shmem_mfill_atomic_pte).
> >
> > This refactoring allows us to iterate over i_mmap to check for any VMAs
> > with userfaultfds and then finalize the collapse if no such VMAs exist,
> > all while holding the page cache lock. Since no mm locks are held, it is
> > necessary to add smb_rmb/smb_wmb to ensure that userfaultfd updates to
> > vm_flags are visible to khugepaged. However, no further locking of
> > userfaultfd state is necessary. Although new userfaultfds can be
> > registered concurrently with finalizing the collapse, any missing pages
> > that are being replaced can no longer be observed by userspace, so there
> > is no data race.
> >
> > This fix is targeted at khugepaged, but the change also applies to
> > MADV_COLLAPSE. The fact that the intermediate page cache state before
> > the rollback of a failed collapse can no longer be observed is
> > technically a userspace-visible change (via at least SEEK_DATA and
> > SEEK_END), but it is exceedingly unlikely that anything relies on being
> > able to observe that transient state.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  fs/userfaultfd.c |  2 ++
> >  mm/khugepaged.c  | 67 ++++++++++++++++++++++++++++++++++++++++--------
> >  2 files changed, 59 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index cc694846617a..6ddfcff11920 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -114,6 +114,8 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> >       const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
> >
> >       vma->vm_flags = flags;
> > +     /* Pairs with smp_rmb() in khugepaged's collapse_file() */
> > +     smp_wmb();
>
> Could you help to explain why this is needed?  What's the operation to
> serialize against updating vm_flags?

We need to ensure that any updates to VM_UFFD_MISSING from
UFFDIO_REGISTER are visible to khugepaged before the ioctl returns to
userspace. There aren't any locks that obviously provide that
synchronization, so I added the smp_wmb/smp_rmb pair. It's possible
that page cache lock indirectly provides sufficient synchronization,
though.

> >       /*
> >        * For shared mappings, we want to enable writenotify while
> >        * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 79be13133322..97435c226b18 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -55,6 +55,7 @@ enum scan_result {
> >       SCAN_CGROUP_CHARGE_FAIL,
> >       SCAN_TRUNCATED,
> >       SCAN_PAGE_HAS_PRIVATE,
> > +     SCAN_PAGE_FILLED,
> >  };
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -1725,8 +1726,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> >   *  - allocate and lock a new huge page;
> >   *  - scan page cache replacing old pages with the new one
> >   *    + swap/gup in pages if necessary;
> > - *    + fill in gaps;
> >   *    + keep old pages around in case rollback is required;
> > + *  - finalize updates to the page cache;
> >   *  - if replacing succeeds:
> >   *    + copy data over;
> >   *    + free old pages;
> > @@ -1747,6 +1748,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >       XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
> >       int nr_none = 0, result = SCAN_SUCCEED;
> >       bool is_shmem = shmem_file(file);
> > +     bool i_mmap_locked = false;
> >       int nr = 0;
> >
> >       VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
> > @@ -1780,8 +1782,14 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >
> >       /*
> >        * At this point the hpage is locked and not up-to-date.
> > -      * It's safe to insert it into the page cache, because nobody would
> > -      * be able to map it or use it in another way until we unlock it.
> > +      *
> > +      * While iterating, we may drop the page cache lock multiple times. It
> > +      * is safe to replace pages in the page cache with hpage while doing so
> > +      * because nobody is able to map or otherwise access the content of
> > +      * hpage until we unlock it. However, we cannot insert hpage into empty
> > +      * indicies until we know we won't have to drop the page cache lock
> > +      * again, as doing so would let things which only check the presence
> > +      * of pages in the page cache see a state that may yet be rolled back.
> >        */
> >
> >       xas_set(&xas, start);
> > @@ -1802,13 +1810,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >                                               result = SCAN_TRUNCATED;
> >                                               goto xa_locked;
> >                                       }
> > -                                     xas_set(&xas, index);
> > +                                     xas_set(&xas, index + 1);
>
> I failed to figure out why this index needs a shift here... It seems to me
> it'll ignore the initial empty page cache, is that what the patch wanted?

This chunk is preceded by a call to xas_next_entry. Previously,
xas_store(hpage) would pair with xas_set(index) to walk the xarray and
prepare xas for the xas_next at the start of the next loop iteration.
Now that we're no longer calling xas_store, xas_set(index+1) is
necessary to prepare xas for the next iteration of the loop.

> >                               }
> >                               if (!shmem_charge(mapping->host, 1)) {
> >                                       result = SCAN_FAIL;
> >                                       goto xa_locked;
> >                               }
> > -                             xas_store(&xas, hpage);
>
> [I raised a question in the other thread on whether it's legal to not
>  populate page cache holes at all.  We can keep the discussion there]
>
> >                               nr_none++;
> >                               continue;
> >                       }
> > @@ -1967,6 +1974,46 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >               put_page(page);
> >               goto xa_unlocked;
> >       }
> > +
> > +     if (nr_none) {
> > +             struct vm_area_struct *vma;
> > +             int nr_none_check = 0;
> > +
> > +             xas_unlock_irq(&xas);
> > +             i_mmap_lock_read(mapping);
> > +             i_mmap_locked = true;
> > +             xas_lock_irq(&xas);
> > +
> > +             xas_set(&xas, start);
> > +             for (index = start; index < end; index++) {
> > +                     if (!xas_next(&xas))
> > +                             nr_none_check++;
> > +             }
> > +
> > +             if (nr_none != nr_none_check) {
> > +                     result = SCAN_PAGE_FILLED;
> > +                     goto xa_locked;
> > +             }
> > +
> > +             /*
> > +              * If userspace observed a missing page in a VMA with an armed
> > +              * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> > +              * that page, so we need to roll back to avoid suppressing such
> > +              * an event. Any userfaultfds armed after this point will not be
> > +              * able to observe any missing pages, since the page cache is
> > +              * locked until after the collapse is completed.
> > +              *
> > +              * Pairs with smp_wmb() in userfaultfd_set_vm_flags().
> > +              */
> > +             smp_rmb();
> > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> > +                     if (userfaultfd_missing(vma)) {
> > +                             result = SCAN_EXCEED_NONE_PTE;
> > +                             goto xa_locked;
> > +                     }
> > +             }
> > +     }
>
> Thanks for writting the patch, but I am still confused why this can avoid
> race conditions of uffd missing mode.
>
> I assume UFFDIO_REGISTER is defined as: after UFFDIO_REGISTER ioctl
> succeeded on a specific shmem VMA, any page faults due to missing page
> cache on this vma should generate a page fault.  If not, it's violating the
> userfaultfd semantics.
>
> Here, I don't see what stops a new vma from registering MISSING mode right
> away in parallel of collapsing.
>
> When registration completes, it means we should report uffd missing
> messages on the holes that collapse_file() scanned previously.  However
> they'll be filled very possibly later with the thp which means the messages
> can be lost.  Then the issue can still happen, while this patch only makes
> it very unlikely to happen, or am I wrong?

This race can still happen, but I don't think it's actually a problem.
In particular, I think the semantics you've given for UFFDIO_REGISTER
are overly restrictive on the kernel in a way that provides no
meaningful benefit to userspace.

To simplify things a little bit, we only need to consider going from
zero to non-zero (i.e. one) userfaultfd. The case where a userfaultfd
is already registered isn't particularly interesting, since khugepaged
would have seen the existing userfaultfd and given up on the collapse.

When userspace registers the first userfaultfd, it cannot rely on any
knowledge about the presence or absence of pages from before when
UFFDIO_REGISTER completes. This is because, as far as userspace is
concerned, khugepaged could have come along and collapsed every single
page in the shmem right after UFFDIO_REGISTER entered the kernel. So
to properly use the userfaultfd API, userspace must re-examine the
state of memory after UFFDIO_REGISTER completes. Because of that,
having UFFDIO_REGISTER be a complete barrier with regards to
khugepaged is essentially meaningless from the perspective of
userspace. The guarantee might slightly reduce the window for some
races in userspace programs, but there are no userspace races that it
can completely resolve.

Given that, the kernel just needs to guarantee that no missing page
which userspace might have observed after registering a userfaultfd is
filled by khugepaged. This patch takes the page cache lock, checks
that there are no registered userfaultfds, fills the missing pages,
and then releases the page cache lock. That's sufficient to guarantee
that any UFFDIO_REGISTER which occurs after the userfaultfd check but
before we finish the collapse can't actually observe any missing
pages.

-David





> Thanks,
>
> > +
> >       nr = thp_nr_pages(hpage);
> >
> >       if (is_shmem)
> > @@ -2000,6 +2047,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >       xas_store(&xas, hpage);
> >  xa_locked:
> >       xas_unlock_irq(&xas);
> > +     if (i_mmap_locked)
> > +             i_mmap_unlock_read(mapping);
> >  xa_unlocked:
> >
> >       /*
> > @@ -2065,15 +2114,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >               }
> >
> >               xas_set(&xas, start);
> > -             xas_for_each(&xas, page, end - 1) {
> > +             end = index;
> > +             for (index = start; index < end; index++) {
> > +                     xas_next(&xas);
> >                       page = list_first_entry_or_null(&pagelist,
> >                                       struct page, lru);
> >                       if (!page || xas.xa_index < page->index) {
> > -                             if (!nr_none)
> > -                                     break;
> >                               nr_none--;
> > -                             /* Put holes back where they were */
> > -                             xas_store(&xas, NULL);
> >                               continue;
> >                       }
> >
> > --
> > 2.39.1.519.gcb327c4b5f-goog
> >
>
> --
> Peter Xu
>
