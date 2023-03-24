Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B486C776B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCXFeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXFeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:34:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A370559B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:34:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e21so556306ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679636058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihdwQfoEezGxqR6WrNVsm93Xtzogh+uSlo3dStgls4E=;
        b=lW1I1PalkvMxQVW3EKj8PdRtk0UtgDwWoPx1Vdx18IHR5EqzCG3+Q8n5s7Iskm9db2
         DkEN1hBwH1aS+G8U8HQme/Kn1P1cdXGSuDevieJMLhgYpTiriTIFkuwmAnvVX60b0OIf
         UJWR0EGGDcsMODoP2F6G/mGmE/ml0Zsda/AR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679636058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihdwQfoEezGxqR6WrNVsm93Xtzogh+uSlo3dStgls4E=;
        b=Nb+zpxltfNwq1KO6qmQEKD7vzPoVfUTRGXtFj/LYCklHAsHwDE/okZSlHC4w9A9LVA
         Ysc6k8aGdY8LmmUX7zX4ceLACu9oDipDYAuno/M19cgGCL8fdmelG5iVmQFNpVOCNgrH
         r7tNU9ajNZmcMBTqgtmfe3UPqpOn8C4ibJLnNwqriBfyNVkiFGHLxdU3GLGsbaMchHIz
         +cLJIQf6/d9RI7sNyRKDc+t7VSiwqDyuOPO+MbTRYt9AaazvQ7pQiA1FYMWyJ6q7qWLQ
         tZzEJYzWP8SKd9bsy8hSB4qCu6Rp2zgB+TSITD9TdmQrbBQMASF6QpQeMG10p/yi6nGt
         qm2w==
X-Gm-Message-State: AAQBX9ezHfe75FbsE+7AiI9/ZRJY/spEfAMoEPbBy8c3IoFKd8ojQikz
        7wCNljggtKVUSHr6oSNcTg5zHJgb0YrDAsbo/yUorA==
X-Google-Smtp-Source: AKy350aiiXE25HXw8DKwPix/bDgAOu0r9ZgN6RJwp485lB8K9d60ryfycdzjMlf7fVhH2A0VkjS9YjmJt272JfVANnw=
X-Received: by 2002:a2e:b1d2:0:b0:293:4e6d:f4f7 with SMTP id
 e18-20020a2eb1d2000000b002934e6df4f7mr482182lja.3.1679636058545; Thu, 23 Mar
 2023 22:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-3-stevensd@google.com>
 <28afde5c-a9e7-9d18-8375-4368eb137b5@google.com>
In-Reply-To: <28afde5c-a9e7-9d18-8375-4368eb137b5@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 24 Mar 2023 14:34:07 +0900
Message-ID: <CAD=HUj4q0yMXmUHNNqDS1y_GSy100Tm52utg5eZytixeq6ce+Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm/khugepaged: skip shmem with userfaultfd
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 4:48=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Tue, 7 Mar 2023, David Stevens wrote:
>
> > From: David Stevens <stevensd@chromium.org>
> >
> > Make sure that collapse_file respects any userfaultfds registered with
> > MODE_MISSING. If userspace has any such userfaultfds registered, then
> > for any page which it knows to be missing, it may expect a
> > UFFD_EVENT_PAGEFAULT. This means collapse_file needs to be careful when
> > collapsing a shmem range would result in replacing an empty page with a
> > THP, to avoid breaking userfaultfd.
> >
> > Synchronization when checking for userfaultfds in collapse_file is
> > tricky because the mmap locks can't be used to prevent races with the
> > registration of new userfaultfds. Instead, we provide synchronization b=
y
> > ensuring that userspace cannot observe the fact that pages are missing
> > before we check for userfaultfds. Although this allows registration of =
a
> > userfaultfd to race with collapse_file, it ensures that userspace canno=
t
> > observe any pages transition from missing to present after such a race
> > occurs. This makes such a race indistinguishable to the collapse
> > occurring immediately before the userfaultfd registration.
> >
> > The first step to provide this synchronization is to stop filling gaps
> > during the loop iterating over the target range, since the page cache
> > lock can be dropped during that loop. The second step is to fill the
> > gaps with XA_RETRY_ENTRY after the page cache lock is acquired the fina=
l
> > time, to avoid races with accesses to the page cache that only take the
> > RCU read lock.
> >
> > The fact that we don't fill holes during the initial iteration means
> > that collapse_file now has to handle faults occurring during the
> > collapse. This is done by re-validating the number of missing pages
> > after acquiring the page cache lock for the final time.
> >
> > This fix is targeted at khugepaged, but the change also applies to
> > MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> > return EBUSY if there are any missing pages (instead of succeeding on
> > shmem and returning EINVAL on anonymous memory). There is also now a
> > window during MADV_COLLAPSE where a fault on a missing page will cause
> > the syscall to fail with EAGAIN.
> >
> > The fact that intermediate page cache state can no longer be observed
> > before the rollback of a failed collapse is also technically a
> > userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> > is exceedingly unlikely that anything relies on being able to observe
> > that transient state.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > Acked-by: Peter Xu <peterx@redhat.com>
>
> This patch looks to me like a lot of unnecessary (and not very pretty)
> change, with surprising use of XA_RETRY_ENTRY outside of xarray internals=
.
>
> I think you probably worked on this one, knowing what you intended in 3/3
> to follow.  But if 3/3 as such does not follow, why can't this one just
> leave collapse_file()'s code flow unchanged, but insert the
> > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, s=
tart) {
> > +                     if (userfaultfd_missing(vma)) {
> you need somewhere just before copying and clearing the pages data?
> Limited to CONFIG_USERFAULTFD=3Dy and shmem and nr_none to minimize impac=
t.
> The locked !uptodate hpage in the xarray keeping others at bay as before.

The complication here is that there are places that examine the page
cache without actually examining the pages in the page cache, and thus
don't lock the pages they see. At the very least, folio_seek_hole_data
and shmem_mfill_atomic_pte do so today. I should have included this in
the commit message.

I suppose we could require that anything that might examine shmem page
cache must lock any pages it sees regardless of whether or not it
actually needs to access the pages, and then update the two functions
I referenced plus any other similar functions I've missed. I went with
the approach I did because I felt that localized complexity in
collapse_file that minimizes intermediate state visible throughout the
mm subsystem would be preferable. However, if that isn't actually
preferable, I can take the approach you suggested. Especially now that
we probably want to fix folio_seek_hole_data anyway.

> Hmm, looking at that extract, is "start, start" correct?

That's definitely a bug, good catch.

> And everywhere
> else in mm/khugepaged.c is checking userfaultfd_armed(vma): I imagine
> one or the other is more correct, but I'm not at all a userfaultfder.

IIUC, the check for userfaultfd_wp in retract_page_tables is
sufficient for uffd-wp in the shmem case. Simply collapsing a range in
the underlying shmem file shouldn't affect the semantics of uffd-wp. I
could be missing something, though, so Peter would probably be the one
to know for sure. As for uffd-minor, its interactions with khugepaged
are currently hopelessly undefined.

-David

> And now I think that I was mistaken to Ack hch's "shmem: open code
> the page cache lookup in shmem_get_folio_gfp" a few days ago: its
> userfault_missing() case needs folio_lock() to be taken after
> filemap_get_entry(), in order to exclude the race with collapse_file()
> as it used to do.  I think.  He and I will sort that out in due course,
> maybe mm/shmem.c wants its own replacement for what he's removing.
>
> Hugh
>
> > ---
> >  include/trace/events/huge_memory.h |  3 +-
> >  mm/khugepaged.c                    | 92 +++++++++++++++++++++++-------
> >  2 files changed, 73 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/=
huge_memory.h
> > index 46cce509957b..7ee85fff89a3 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -37,7 +37,8 @@
> >       EM( SCAN_CGROUP_CHARGE_FAIL,    "ccgroup_charge_failed")        \
> >       EM( SCAN_TRUNCATED,             "truncated")                    \
> >       EM( SCAN_PAGE_HAS_PRIVATE,      "page_has_private")             \
> > -     EMe(SCAN_COPY_MC,               "copy_poisoned_page")           \
> > +     EM( SCAN_COPY_MC,               "copy_poisoned_page")           \
> > +     EMe(SCAN_PAGE_FILLED,           "page_filled")                  \
> >
> >  #undef EM
> >  #undef EMe
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b954e3c685e7..51ae399f2035 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -57,6 +57,7 @@ enum scan_result {
> >       SCAN_TRUNCATED,
> >       SCAN_PAGE_HAS_PRIVATE,
> >       SCAN_COPY_MC,
> > +     SCAN_PAGE_FILLED,
> >  };
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -1873,8 +1874,8 @@ static int retract_page_tables(struct address_spa=
ce *mapping, pgoff_t pgoff,
> >   *  - allocate and lock a new huge page;
> >   *  - scan page cache replacing old pages with the new one
> >   *    + swap/gup in pages if necessary;
> > - *    + fill in gaps;
> >   *    + keep old pages around in case rollback is required;
> > + *  - finalize updates to the page cache;
> >   *  - if replacing succeeds:
> >   *    + copy data over;
> >   *    + free old pages;
> > @@ -1952,13 +1953,12 @@ static int collapse_file(struct mm_struct *mm, =
unsigned long addr,
> >                                               result =3D SCAN_TRUNCATED=
;
> >                                               goto xa_locked;
> >                                       }
> > -                                     xas_set(&xas, index);
> > +                                     xas_set(&xas, index + 1);
> >                               }
> >                               if (!shmem_charge(mapping->host, 1)) {
> >                                       result =3D SCAN_FAIL;
> >                                       goto xa_locked;
> >                               }
> > -                             xas_store(&xas, hpage);
> >                               nr_none++;
> >                               continue;
> >                       }
> > @@ -2169,21 +2169,57 @@ static int collapse_file(struct mm_struct *mm, =
unsigned long addr,
> >               index++;
> >       }
> >
> > -     /*
> > -      * Copying old pages to huge one has succeeded, now we
> > -      * need to free the old pages.
> > -      */
> > -     list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> > -             list_del(&page->lru);
> > -             page->mapping =3D NULL;
> > -             page_ref_unfreeze(page, 1);
> > -             ClearPageActive(page);
> > -             ClearPageUnevictable(page);
> > -             unlock_page(page);
> > -             put_page(page);
> > +     if (nr_none) {
> > +             struct vm_area_struct *vma;
> > +             int nr_none_check =3D 0;
> > +
> > +             i_mmap_lock_read(mapping);
> > +             xas_lock_irq(&xas);
> > +
> > +             xas_set(&xas, start);
> > +             for (index =3D start; index < end; index++) {
> > +                     if (!xas_next(&xas)) {
> > +                             xas_store(&xas, XA_RETRY_ENTRY);
> > +                             nr_none_check++;
> > +                     }
> > +             }
> > +
> > +             if (nr_none !=3D nr_none_check) {
> > +                     result =3D SCAN_PAGE_FILLED;
> > +                     goto immap_locked;
> > +             }
> > +
> > +             /*
> > +              * If userspace observed a missing page in a VMA with an =
armed
> > +              * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAU=
LT for
> > +              * that page, so we need to roll back to avoid suppressin=
g such
> > +              * an event. Any userfaultfds armed after this point will=
 not be
> > +              * able to observe any missing pages due to the previousl=
y
> > +              * inserted retry entries.
> > +              */
> > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, s=
tart) {
> > +                     if (userfaultfd_missing(vma)) {
> > +                             result =3D SCAN_EXCEED_NONE_PTE;
> > +                             goto immap_locked;
> > +                     }
> > +             }
> > +
> > +immap_locked:
> > +             i_mmap_unlock_read(mapping);
> > +             if (result !=3D SCAN_SUCCEED) {
> > +                     xas_set(&xas, start);
> > +                     for (index =3D start; index < end; index++) {
> > +                             if (xas_next(&xas) =3D=3D XA_RETRY_ENTRY)
> > +                                     xas_store(&xas, NULL);
> > +                     }
> > +
> > +                     xas_unlock_irq(&xas);
> > +                     goto rollback;
> > +             }
> > +     } else {
> > +             xas_lock_irq(&xas);
> >       }
> >
> > -     xas_lock_irq(&xas);
> >       if (is_shmem)
> >               __mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> >       else
> > @@ -2213,6 +2249,20 @@ static int collapse_file(struct mm_struct *mm, u=
nsigned long addr,
> >       result =3D retract_page_tables(mapping, start, mm, addr, hpage,
> >                                    cc);
> >       unlock_page(hpage);
> > +
> > +     /*
> > +      * The collapse has succeeded, so free the old pages.
> > +      */
> > +     list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> > +             list_del(&page->lru);
> > +             page->mapping =3D NULL;
> > +             page_ref_unfreeze(page, 1);
> > +             ClearPageActive(page);
> > +             ClearPageUnevictable(page);
> > +             unlock_page(page);
> > +             put_page(page);
> > +     }
> > +
> >       goto out;
> >
> >  rollback:
> > @@ -2224,15 +2274,13 @@ static int collapse_file(struct mm_struct *mm, =
unsigned long addr,
> >       }
> >
> >       xas_set(&xas, start);
> > -     xas_for_each(&xas, page, end - 1) {
> > +     end =3D index;
> > +     for (index =3D start; index < end; index++) {
> > +             xas_next(&xas);
> >               page =3D list_first_entry_or_null(&pagelist,
> >                               struct page, lru);
> >               if (!page || xas.xa_index < page->index) {
> > -                     if (!nr_none)
> > -                             break;
> >                       nr_none--;
> > -                     /* Put holes back where they were */
> > -                     xas_store(&xas, NULL);
> >                       continue;
> >               }
> >
> > @@ -2750,12 +2798,14 @@ static int madvise_collapse_errno(enum scan_res=
ult r)
> >       case SCAN_ALLOC_HUGE_PAGE_FAIL:
> >               return -ENOMEM;
> >       case SCAN_CGROUP_CHARGE_FAIL:
> > +     case SCAN_EXCEED_NONE_PTE:
> >               return -EBUSY;
> >       /* Resource temporary unavailable - trying again might succeed */
> >       case SCAN_PAGE_COUNT:
> >       case SCAN_PAGE_LOCK:
> >       case SCAN_PAGE_LRU:
> >       case SCAN_DEL_PAGE_LRU:
> > +     case SCAN_PAGE_FILLED:
> >               return -EAGAIN;
> >       /*
> >        * Other: Trying again likely not to succeed / error intrinsic to
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
