Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1E68F46E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBHRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBHRZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5254FC28
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675877055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1O208xwpA+XPV1yqxxdJvxAmzu5PDRiplXlogdLwEdg=;
        b=Hm3WXC9nxn8DNztEjNJDtRjC6OxkjfbVA1Wyk8arZ9+ThbhsdMiXyJurP2+xY7QQjJbiho
        1y7WGBF4KjH+ljO3ZgwFx8tl6S+k90g6rG53HGjXhdvyDz3U1e63khzVlGeDa0ZTCwvgjR
        RfUsfXQB5C3wPrnbYAgrRP6JAnmgknA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-Tc1amSlLNDusiTsMRKl8qg-1; Wed, 08 Feb 2023 12:24:11 -0500
X-MC-Unique: Tc1amSlLNDusiTsMRKl8qg-1
Received: by mail-qk1-f198.google.com with SMTP id g6-20020ae9e106000000b00720f9e6e3e2so12694507qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O208xwpA+XPV1yqxxdJvxAmzu5PDRiplXlogdLwEdg=;
        b=dZ1WQidbundgTGFM6/D26X8ZK5hjacvvf5tORadrY3RsvgNLoymViMzsYsR4ye9Orq
         7EUvdnLpGR1shuXNhqHrMbogKZqc+Mq7yT3U+I+WfDenuMD54Q8DXXF3bQHWt5QukYjt
         bnUcM8+Pi5jIjcwutCWOJRVe9i8wTDYELb668IR7k7t+94XnpP0GP+4Il224hwuMHqM7
         sFTqcAV/x9G/xUyT6wYhPEqGGIesQRV3i7GYS0IKleacKXpQ7Jci3/OKYzg12H0JgNiL
         INj0ONLx5nIarWvoebzjnMNwo7JLfw/MnzMWoO0aj6M1H/McZ5WhzgRJftz937qJH+eT
         9MYg==
X-Gm-Message-State: AO0yUKWlXyifjOoddft7pk8MkOv1EHRbIH/EmD1ix3dCpEbbzG1ORygp
        l1i2kchaI//7WdjTNC9VCeQ1ktOBlGclKBXm1DWGgKXZGVvdyho0vxSHLMUOo9hqdo9jau1H43x
        PTjzRE2tfsw3Z2QMOdDQogzAG
X-Received: by 2002:a0c:dd91:0:b0:56c:1816:b58 with SMTP id v17-20020a0cdd91000000b0056c18160b58mr4788785qvk.2.1675877051051;
        Wed, 08 Feb 2023 09:24:11 -0800 (PST)
X-Google-Smtp-Source: AK7set+LPGNr8W0kaOnaqhk/qV3bmAtxAA0wxDa4ciJ2JR7CgVA8rTbz9b94vHywaQAjc+zQX6VR8g==
X-Received: by 2002:a0c:dd91:0:b0:56c:1816:b58 with SMTP id v17-20020a0cdd91000000b0056c18160b58mr4788737qvk.2.1675877050606;
        Wed, 08 Feb 2023 09:24:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm11956769qkb.79.2023.02.08.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:24:09 -0800 (PST)
Date:   Wed, 8 Feb 2023 12:24:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+PauOuAO4nu6Q0k@x1n>
References: <20230206112856.1802547-1-stevensd@google.com>
 <Y+Fq8lwsl7RXwlNS@x1n>
 <CAD=HUj67pC_0f8LwaD_bcYvtpZ1Wi8Hz2SpZD7eXpBVgmZ3p8g@mail.gmail.com>
 <Y+J9jnhEC7xYoCCW@x1n>
 <CAD=HUj6zhD6gVqG8VOJVmzXzzp5WC3QwP9wQ-Osk3MTsNSE3jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=HUj6zhD6gVqG8VOJVmzXzzp5WC3QwP9wQ-Osk3MTsNSE3jQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:42:22AM +0900, David Stevens wrote:
> On Wed, Feb 8, 2023 at 1:34 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Feb 07, 2023 at 12:56:56PM +0900, David Stevens wrote:
> > > On Tue, Feb 7, 2023 at 6:02 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> > > > > From: David Stevens <stevensd@chromium.org>
> > > > >
> > > > > Collapsing memory will result in any empty pages in the target range
> > > > > being filled by the new THP. If userspace has a userfaultfd registered
> > > > > with MODE_MISSING, for any page which it knows to be missing after
> > > > > registering the userfaultfd, it may expect a UFFD_EVENT_PAGEFAULT.
> > > > > Taking these two facts together, khugepaged needs to take care when
> > > > > collapsing pages in shmem to make sure it doesn't break the userfaultfd
> > > > > API.
> > > > >
> > > > > This change first makes sure that the intermediate page cache state
> > > > > during collapse is not visible by moving when gaps are filled to after
> > > > > the page cache lock is acquired for the final time. This is necessary
> > > > > because the synchronization provided by locking hpage is insufficient
> > > > > for functions which operate on the page cache without actually locking
> > > > > individual pages to examine their content (e.g. shmem_mfill_atomic_pte).
> > > > >
> > > > > This refactoring allows us to iterate over i_mmap to check for any VMAs
> > > > > with userfaultfds and then finalize the collapse if no such VMAs exist,
> > > > > all while holding the page cache lock. Since no mm locks are held, it is
> > > > > necessary to add smb_rmb/smb_wmb to ensure that userfaultfd updates to
> > > > > vm_flags are visible to khugepaged. However, no further locking of
> > > > > userfaultfd state is necessary. Although new userfaultfds can be
> > > > > registered concurrently with finalizing the collapse, any missing pages
> > > > > that are being replaced can no longer be observed by userspace, so there
> > > > > is no data race.
> > > > >
> > > > > This fix is targeted at khugepaged, but the change also applies to
> > > > > MADV_COLLAPSE. The fact that the intermediate page cache state before
> > > > > the rollback of a failed collapse can no longer be observed is
> > > > > technically a userspace-visible change (via at least SEEK_DATA and
> > > > > SEEK_END), but it is exceedingly unlikely that anything relies on being
> > > > > able to observe that transient state.
> > > > >
> > > > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > > > ---
> > > > >  fs/userfaultfd.c |  2 ++
> > > > >  mm/khugepaged.c  | 67 ++++++++++++++++++++++++++++++++++++++++--------
> > > > >  2 files changed, 59 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > index cc694846617a..6ddfcff11920 100644
> > > > > --- a/fs/userfaultfd.c
> > > > > +++ b/fs/userfaultfd.c
> > > > > @@ -114,6 +114,8 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> > > > >       const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
> > > > >
> > > > >       vma->vm_flags = flags;
> > > > > +     /* Pairs with smp_rmb() in khugepaged's collapse_file() */
> > > > > +     smp_wmb();
> > > >
> > > > Could you help to explain why this is needed?  What's the operation to
> > > > serialize against updating vm_flags?
> > >
> > > We need to ensure that any updates to VM_UFFD_MISSING from
> > > UFFDIO_REGISTER are visible to khugepaged before the ioctl returns to
> > > userspace. There aren't any locks that obviously provide that
> > > synchronization, so I added the smp_wmb/smp_rmb pair. It's possible
> > > that page cache lock indirectly provides sufficient synchronization,
> > > though.
> >
> > If so I don't think it's needed.  If vm_flags cannot be flushed to memory
> > and present to the rest before the syscall returns, then it's a fatal
> > problem already before this patch.  I bet there're quite a few barriers to
> > protect it, while the world switch should be the last guardline.
> >
> > One example: vm_flags updates need mmap write lock, then: mmap_write_unlock
> > -> up_write -> __up_write -> preempt_disable() -> barrier().
> >
> > >
> > > > >       /*
> > > > >        * For shared mappings, we want to enable writenotify while
> > > > >        * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 79be13133322..97435c226b18 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -55,6 +55,7 @@ enum scan_result {
> > > > >       SCAN_CGROUP_CHARGE_FAIL,
> > > > >       SCAN_TRUNCATED,
> > > > >       SCAN_PAGE_HAS_PRIVATE,
> > > > > +     SCAN_PAGE_FILLED,
> > > > >  };
> > > > >
> > > > >  #define CREATE_TRACE_POINTS
> > > > > @@ -1725,8 +1726,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > > > >   *  - allocate and lock a new huge page;
> > > > >   *  - scan page cache replacing old pages with the new one
> > > > >   *    + swap/gup in pages if necessary;
> > > > > - *    + fill in gaps;
> > > > >   *    + keep old pages around in case rollback is required;
> > > > > + *  - finalize updates to the page cache;
> > > > >   *  - if replacing succeeds:
> > > > >   *    + copy data over;
> > > > >   *    + free old pages;
> > > > > @@ -1747,6 +1748,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > >       XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
> > > > >       int nr_none = 0, result = SCAN_SUCCEED;
> > > > >       bool is_shmem = shmem_file(file);
> > > > > +     bool i_mmap_locked = false;
> > > > >       int nr = 0;
> > > > >
> > > > >       VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
> > > > > @@ -1780,8 +1782,14 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > >
> > > > >       /*
> > > > >        * At this point the hpage is locked and not up-to-date.
> > > > > -      * It's safe to insert it into the page cache, because nobody would
> > > > > -      * be able to map it or use it in another way until we unlock it.
> > > > > +      *
> > > > > +      * While iterating, we may drop the page cache lock multiple times. It
> > > > > +      * is safe to replace pages in the page cache with hpage while doing so
> > > > > +      * because nobody is able to map or otherwise access the content of
> > > > > +      * hpage until we unlock it. However, we cannot insert hpage into empty
> > > > > +      * indicies until we know we won't have to drop the page cache lock
> > > > > +      * again, as doing so would let things which only check the presence
> > > > > +      * of pages in the page cache see a state that may yet be rolled back.
> > > > >        */
> > > > >
> > > > >       xas_set(&xas, start);
> > > > > @@ -1802,13 +1810,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > >                                               result = SCAN_TRUNCATED;
> > > > >                                               goto xa_locked;
> > > > >                                       }
> > > > > -                                     xas_set(&xas, index);
> > > > > +                                     xas_set(&xas, index + 1);
> > > >
> > > > I failed to figure out why this index needs a shift here... It seems to me
> > > > it'll ignore the initial empty page cache, is that what the patch wanted?
> > >
> > > This chunk is preceded by a call to xas_next_entry. Previously,
> > > xas_store(hpage) would pair with xas_set(index) to walk the xarray and
> > > prepare xas for the xas_next at the start of the next loop iteration.
> > > Now that we're no longer calling xas_store, xas_set(index+1) is
> > > necessary to prepare xas for the next iteration of the loop.
> >
> > If I'm not wrong, xas_store() doesn't move the niddle at all.  It's the
> > xas_next() at the entry of the loop that does.
> 
> xas_set(n) resets the cursor to the top of the tree. If the cursor is
> at the top of the tree, then xas_next() walks to n instead of
> advancing n to n+1. xas_store() on the other hand behaves the same
> regardless of whether or not the cursor is at the top of the tree (it
> starts by calling xas_create or xas_load, which will walk the tree if
> necessary).
> 
> Looking at it another way, if we're here, then start == index. So if
> we were to call xas_set(&xas, index), xas at the start of the next
> iteration would be in an identical state to when we entered the loop
> the first time. So xas would be one value behind index, and we would
> never actually examine the last entry in the range being collapsed.

Are you suggesting that this is a bug in the existing code?

My read on this whole chunk is: if this is the first page we're scanning
and it's missing, let's have a look to make sure the whole THP isn't
truncated.  If it is, we return SCAN_TRUNCATED.  Otherwise, we fill up the
holes _starting from this index 0_.

AFAIU your change here will make that last sentence start from index 1.

> 
> > >
> > > > >                               }
> > > > >                               if (!shmem_charge(mapping->host, 1)) {
> > > > >                                       result = SCAN_FAIL;
> > > > >                                       goto xa_locked;
> > > > >                               }
> > > > > -                             xas_store(&xas, hpage);
> > > >
> > > > [I raised a question in the other thread on whether it's legal to not
> > > >  populate page cache holes at all.  We can keep the discussion there]
> > > >
> > > > >                               nr_none++;
> > > > >                               continue;
> > > > >                       }
> > > > > @@ -1967,6 +1974,46 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > >               put_page(page);
> > > > >               goto xa_unlocked;
> > > > >       }
> > > > > +
> > > > > +     if (nr_none) {
> > > > > +             struct vm_area_struct *vma;
> > > > > +             int nr_none_check = 0;
> > > > > +
> > > > > +             xas_unlock_irq(&xas);
> > > > > +             i_mmap_lock_read(mapping);
> > > > > +             i_mmap_locked = true;
> > > > > +             xas_lock_irq(&xas);
> > > > > +
> > > > > +             xas_set(&xas, start);
> > > > > +             for (index = start; index < end; index++) {
> > > > > +                     if (!xas_next(&xas))
> > > > > +                             nr_none_check++;
> > > > > +             }
> > > > > +
> > > > > +             if (nr_none != nr_none_check) {
> > > > > +                     result = SCAN_PAGE_FILLED;
> > > > > +                     goto xa_locked;
> > > > > +             }
> > > > > +
> > > > > +             /*
> > > > > +              * If userspace observed a missing page in a VMA with an armed
> > > > > +              * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> > > > > +              * that page, so we need to roll back to avoid suppressing such
> > > > > +              * an event. Any userfaultfds armed after this point will not be
> > > > > +              * able to observe any missing pages, since the page cache is
> > > > > +              * locked until after the collapse is completed.
> > > > > +              *
> > > > > +              * Pairs with smp_wmb() in userfaultfd_set_vm_flags().
> > > > > +              */
> > > > > +             smp_rmb();
> > > > > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> > > > > +                     if (userfaultfd_missing(vma)) {
> > > > > +                             result = SCAN_EXCEED_NONE_PTE;
> > > > > +                             goto xa_locked;
> > > > > +                     }
> > > > > +             }
> > > > > +     }
> > > >
> > > > Thanks for writting the patch, but I am still confused why this can avoid
> > > > race conditions of uffd missing mode.
> > > >
> > > > I assume UFFDIO_REGISTER is defined as: after UFFDIO_REGISTER ioctl
> > > > succeeded on a specific shmem VMA, any page faults due to missing page
> > > > cache on this vma should generate a page fault.  If not, it's violating the
> > > > userfaultfd semantics.
> > > >
> > > > Here, I don't see what stops a new vma from registering MISSING mode right
> > > > away in parallel of collapsing.
> > > >
> > > > When registration completes, it means we should report uffd missing
> > > > messages on the holes that collapse_file() scanned previously.  However
> > > > they'll be filled very possibly later with the thp which means the messages
> > > > can be lost.  Then the issue can still happen, while this patch only makes
> > > > it very unlikely to happen, or am I wrong?
> > >
> > > This race can still happen, but I don't think it's actually a problem.
> > > In particular, I think the semantics you've given for UFFDIO_REGISTER
> > > are overly restrictive on the kernel in a way that provides no
> > > meaningful benefit to userspace.
> > >
> > > To simplify things a little bit, we only need to consider going from
> > > zero to non-zero (i.e. one) userfaultfd. The case where a userfaultfd
> > > is already registered isn't particularly interesting, since khugepaged
> > > would have seen the existing userfaultfd and given up on the collapse.
> >
> > Could you point me which part of the code you're referencing here?
> 
> I'm referencing the behavior with this patch. With my patch, all
> khugepaged cares about is whether there exists an armed userfaultfd on
> a given VMA. If there already exists an armed userfaultfd on a given
> VMA, then with my patch, khugepaged will give up collapsing. So the
> case where a second/third/etc userfaultfd is being armed isn't
> interesting, because khugepaged will already not be doing anything, so
> there cannot be any race condition.
> 
> > Note that unlike anonymous thp collapsing scan (hpage_collapse_scan_pmd),
> > hpage_collapse_scan_file works on page caches only.
> >
> > >
> > > When userspace registers the first userfaultfd, it cannot rely on any
> > > knowledge about the presence or absence of pages from before when
> > > UFFDIO_REGISTER completes. This is because, as far as userspace is
> > > concerned, khugepaged could have come along and collapsed every single
> > > page in the shmem right after UFFDIO_REGISTER entered the kernel. So
> > > to properly use the userfaultfd API, userspace must re-examine the
> > > state of memory after UFFDIO_REGISTER completes. Because of that,
> > > having UFFDIO_REGISTER be a complete barrier with regards to
> > > khugepaged is essentially meaningless from the perspective of
> > > userspace. The guarantee might slightly reduce the window for some
> > > races in userspace programs, but there are no userspace races that it
> > > can completely resolve.
> > >
> > > Given that, the kernel just needs to guarantee that no missing page
> > > which userspace might have observed after registering a userfaultfd is
> > > filled by khugepaged. This patch takes the page cache lock, checks
> > > that there are no registered userfaultfds, fills the missing pages,
> > > and then releases the page cache lock. That's sufficient to guarantee
> > > that any UFFDIO_REGISTER which occurs after the userfaultfd check but
> > > before we finish the collapse can't actually observe any missing
> > > pages.
> >
> > I don't think your current patch guaranteed that?
> >
> > Now I'm confused why you removed population of the small pages using hpage,
> > because that seems to support what you're doing here.  Note that your
> > current code is added _before_ the replacement of the huge page here:
> >
> >         /* Join all the small entries into a single multi-index entry */
> >         xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> >         xas_store(&xas, hpage);
> >
> > So either the patch needs to keep the original logic to fill up the holes
> > with hpage, or the vma checks needs to be done later, to achieve what you
> > proposed to happen, IIUC.
> 
> Maybe I'm fundamentally misunderstanding how locking for shmem works?
> With my patch, we effectively have:
> 
> xas_lock_irq(&xas);
> <check that userfaultfd_missing(VMA) == false for all VMAs>
> xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> xas_store(&xas, hpage);
> xas_unlock_irq(&xas);
> 
> Here's my understanding. If there are no armed userfaultfds during the
> check, then userspace could not have made any observations of the
> shmem with an armed userfaultfd before collapse_file locked xas. The
> xas_store() is where missing pages become present pages. Since this
> happens while xas is still locked, we know that no additional
> observations of shmem could have occured since locking xas. So even if
> registration of a new userfaultfd raced with the check, we know that
> new userfaultfd couldn't have made any observations of shmem.
> 
> Are you saying that it's possible for something to come in and observe
> a missing page from the shmem between when we check the VMAs and when
> we store hpage, even though xas is locked? Or that userspace can
> observe shmem completely independently of the locking done by
> xas_lock_irq(&xas)?

AFAIU a pure lookup is done without xas lock but rcu read lock.  More
below.

> 
> > Besides, please imagine an uffd program that does this:
> >
> >   (1) ioctl(UFFDIO_REGISTER) upon the shmem vma
> >   (2) lseek(SEEK_DATA) on one page P1 (which is part of THP range T1), it
> >       noticed that it returns DATA, means this is not a hole.  So it's
> >       expected that there will be no further message generated to this page.
> >   (3) After a while, it received a missing fault on page P1
> >
> > My question is whether above is a problem or not?  Whether it violates the
> > userfaultfd missing mode semantics?
> >
> > AFAICT, above can happen if some program accidentally registers UFFD
> > missing mode during collapsing of the shmem thp P1 if with current logic
> > applied.
> 
> That's a bug that can occur with khugepaged as it exists before my
> patch, if collapse_file fills a missing page but then needs to roll
> back the collapse. With my patch, khugepaged doesn't fill any missing
> pages until after it knows for sure the collapse will succeed, so I
> don't see any way for collapse_file to cause a formerly present page
> to become absent.

Right, I should have reversed the conditions, sorry:

  (1) ioctl(UFFDIO_REGISTER) upon the shmem vma
  (2) lseek(SEEK_DATA) on one page P1 (which is part of THP range T1), it
      noticed that it returns HOLE.
  (3) The HOLE got collapsed into a THP

I think it can still happen after the patch applied.  lseek has:

  shmem_file_llseek -> mapping_seek_hole_data -> find_get_entry

So I think it can happen concurrently, that one thread does (1+2) before
your patch collapsed the thp in the page cache but after the vma checks.

What I'm so far sincerely not sure is whether we should care about the case
like lseek (or, mincore can do similar if without swap being considered).

What I used to propose before on the inode counter should be able to avoid
that by serializing the collapse thp operation against step (1) with a
per-inode lock.  So IIUC that should even protect things like lseek().  The
problem with that is the change is slightly more involved (the counter will
enlarge every shmem inode struct as long as CONFIG_USERFAULTFD), also the
impact will be upon the whole inode too even if only 1 page is registered
with uffd.

Thanks,

-- 
Peter Xu

