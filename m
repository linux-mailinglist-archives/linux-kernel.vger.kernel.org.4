Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4933D6997B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBPOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBPOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:42:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CADF4D616
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676558494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9RDP1c6xkNkVax9cafkp6rZ/0yeZhIak6lzwPuSvqM=;
        b=IsdrVYUUdVpEb7mgxE+dvpWTcPPcEU31inftw3NVm5UvYKuuKh5IDjVeVF230+zWatqCkl
        MmDOl9uRLGg8dVTl8SjS6HU6ih+fYFAd4UbpE1QKvJpqIYICbHK1JOXV+Yl1km7xfpw9lY
        82w3/0Siiol/5EHhqIQfDobNpdlas1c=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-216vyaTuMUOy3EuVzuYKoQ-1; Thu, 16 Feb 2023 09:41:25 -0500
X-MC-Unique: 216vyaTuMUOy3EuVzuYKoQ-1
Received: by mail-io1-f70.google.com with SMTP id i136-20020a6b3b8e000000b00745469852cfso338713ioa.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9RDP1c6xkNkVax9cafkp6rZ/0yeZhIak6lzwPuSvqM=;
        b=lXLxUSekj6r0ooqCYXBVEJbc8nxtHVSGm4GrkvKu6UFc7loi6A7keNh7FctVMt/IYL
         nT7Bdmu5vyvqKrfB7/BDQDFtyOCxNq/V9hIUGOcaUw8RJz+2/7DTOlZwX5uvDcuNLHED
         MYh6r6zv5QLFIzY5UtrGaL989BxS+izDqR9A64LWGYvmJWqJ3gkPkzf3bqfgH916FjUw
         NTibEf4oiEI2DsxFX8Wsyqcb2kfA9PG6MCsdQUr8Yf+QJDRLLwHw5gtdcSGnPEqHkx0F
         +tXW1hpgx+UhxjWsP7h6Kl921VlWo3Ju9w8x4pZnxvzx8mscnr+7aHTpQyBWCj/6zCWa
         QdmA==
X-Gm-Message-State: AO0yUKURONLWUgO5d5ed7sH5yZVyPEqnRzDYehHcfVWfra3XXZiIz157
        dZSD8LkL7q4s3PuV51AYUxVLgIAlLhryxl8sUq7041O2ljQ7LEsXbReI3VZTgb+Dsc7AFrwgT4n
        wskHijZ7EuSHREsHRFArvarIa
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr3626518iox.0.1676558484712;
        Thu, 16 Feb 2023 06:41:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+98roKKBnuZxMyibOAjamWK9+xx6bFibIU+6FWg5RGiFXyilSLEuIP/FrNR9EITJLB0rpQUA==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr3626503iox.0.1676558484380;
        Thu, 16 Feb 2023 06:41:24 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b9-20020a6be709000000b0074549126e97sm166725ioh.1.2023.02.16.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:41:23 -0800 (PST)
Date:   Thu, 16 Feb 2023 09:41:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+5Akpz4CvGywt6R@x1n>
References: <20230214075710.2401855-1-stevensd@google.com>
 <20230214075710.2401855-2-stevensd@google.com>
 <Y+1hMsm4eQIUtag5@x1n>
 <CAD=HUj69L2e-Z4TB19qFt8h1cn0r1oGbWovJGMOjjyvfDcQ7NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=HUj69L2e-Z4TB19qFt8h1cn0r1oGbWovJGMOjjyvfDcQ7NA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:37:47AM +0900, David Stevens wrote:
> On Thu, Feb 16, 2023 at 7:48 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Feb 14, 2023 at 04:57:10PM +0900, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Make sure that collapse_file respects any userfaultfds registered with
> > > MODE_MISSING. If userspace has any such userfaultfds registered, then
> > > for any page which it knows to be missing, it may expect a
> > > UFFD_EVENT_PAGEFAULT. This means collapse_file needs to take care when
> > > collapsing a shmem range would result in replacing an empty page with a
> > > THP, so that it doesn't break userfaultfd.
> > >
> > > Synchronization when checking for userfaultfds in collapse_file is
> > > tricky because the mmap locks can't be used to prevent races with the
> > > registration of new userfaultfds. Instead, we provide synchronization by
> > > ensuring that userspace cannot observe the fact that pages are missing
> > > before we check for userfaultfds. Although this allows registration of a
> > > userfaultfd to race with collapse_file, it ensures that userspace cannot
> > > observe any pages transition from missing to present after such a race.
> > > This makes such a race indistinguishable to the collapse occurring
> > > immediately before the userfaultfd registration.
> > >
> > > The first step to provide this synchronization is to stop filling gaps
> > > during the loop iterating over the target range, since the page cache
> > > lock can be dropped during that loop. The second step is to fill the
> > > gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> > > time, to avoid races with accesses to the page cache that only take the
> > > RCU read lock.
> > >
> > > This fix is targeted at khugepaged, but the change also applies to
> > > MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> > > return EBUSY if there are any missing pages (instead of succeeding on
> > > shmem and returning EINVAL on anonymous memory). There is also now a
> > > window during MADV_COLLAPSE where a fault on a missing page will cause
> > > the syscall to fail with EAGAIN.
> > >
> > > The fact that intermediate page cache state can no longer be observed
> > > before the rollback of a failed collapse is also technically a
> > > userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> > > is exceedingly unlikely that anything relies on being able to observe
> > > that transient state.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > ---
> > >  mm/khugepaged.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 58 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index b648f1053d95..8c2e2349e883 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -55,6 +55,7 @@ enum scan_result {
> > >       SCAN_CGROUP_CHARGE_FAIL,
> > >       SCAN_TRUNCATED,
> > >       SCAN_PAGE_HAS_PRIVATE,
> > > +     SCAN_PAGE_FILLED,
> >
> > PS: You may want to also touch SCAN_STATUS in huge_memory.h next time.
> >
> > >  };
> > >
> > >  #define CREATE_TRACE_POINTS
> > > @@ -1725,8 +1726,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > >   *  - allocate and lock a new huge page;
> > >   *  - scan page cache replacing old pages with the new one
> > >   *    + swap/gup in pages if necessary;
> > > - *    + fill in gaps;
> >
> > IIUC it's not a complete removal, but just moved downwards:
> >
> > >   *    + keep old pages around in case rollback is required;
> > > + *  - finalize updates to the page cache;
> >
> >          + fill in gaps with RETRY entries
> >          + detect race conditions with userfaultfds
> >
> > >   *  - if replacing succeeds:
> > >   *    + copy data over;
> > >   *    + free old pages;
> > > @@ -1805,13 +1806,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > >                                               result = SCAN_TRUNCATED;
> > >                                               goto xa_locked;
> > >                                       }
> > > -                                     xas_set(&xas, index);
> > > +                                     xas_set(&xas, index + 1);
> > >                               }
> > >                               if (!shmem_charge(mapping->host, 1)) {
> > >                                       result = SCAN_FAIL;
> > >                                       goto xa_locked;
> > >                               }
> > > -                             xas_store(&xas, hpage);
> > >                               nr_none++;
> > >                               continue;
> > >                       }
> > > @@ -1970,6 +1970,56 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > >               put_page(page);
> > >               goto xa_unlocked;
> > >       }
> > > +
> > > +     if (nr_none) {
> > > +             struct vm_area_struct *vma;
> > > +             int nr_none_check = 0;
> > > +
> > > +             xas_unlock_irq(&xas);
> > > +             i_mmap_lock_read(mapping);
> > > +             xas_lock_irq(&xas);
> > > +
> > > +             xas_set(&xas, start);
> > > +             for (index = start; index < end; index++) {
> > > +                     if (!xas_next(&xas)) {
> > > +                             xas_store(&xas, XA_RETRY_ENTRY);
> > > +                             nr_none_check++;
> > > +                     }
> > > +             }
> > > +
> > > +             if (nr_none != nr_none_check) {
> > > +                     result = SCAN_PAGE_FILLED;
> > > +                     goto immap_locked;
> > > +             }
> > > +
> > > +             /*
> > > +              * If userspace observed a missing page in a VMA with an armed
> > > +              * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> > > +              * that page, so we need to roll back to avoid suppressing such
> > > +              * an event. Any userfaultfds armed after this point will not be
> > > +              * able to observe any missing pages due to the previously
> > > +              * inserted retry entries.
> > > +              */
> > > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> > > +                     if (userfaultfd_missing(vma)) {
> > > +                             result = SCAN_EXCEED_NONE_PTE;
> > > +                             goto immap_locked;
> > > +                     }
> > > +             }
> > > +
> > > +immap_locked:
> > > +             i_mmap_unlock_read(mapping);
> > > +             if (result != SCAN_SUCCEED) {
> > > +                     xas_set(&xas, start);
> > > +                     for (index = start; index < end; index++) {
> > > +                             if (xas_next(&xas) == XA_RETRY_ENTRY)
> > > +                                     xas_store(&xas, NULL);
> > > +                     }
> > > +
> > > +                     goto xa_locked;
> > > +             }
> > > +     }
> > > +
> >
> > Until here, all look fine to me (ignoring patch 1 for now; assuming the
> > hpage is always uptodate).
> >
> > My question is after here we'll release page cache lock again before
> > try_to_unmap_flush(), but is it safe to keep RETRY entries after releasing
> > page cache lock?  It means other threads can be spinning.  I assume page
> > lock is always safe and sleepable, but not sure about the page cache lock
> > here.
> 
> We insert the multi-index entry for hpage before releasing the page
> cache lock, which should replace all of the XA_RETRY_ENTRYs. So the
> page cache will be fully up to date when we release the lock, at least
> in terms of which pages it contains.

IIUC we released it before copying the pages:

xa_locked:
	xas_unlock_irq(&xas);  <-------------------------------- here
xa_unlocked:

	/*
	 * If collapse is successful, flush must be done now before copying.
	 * If collapse is unsuccessful, does flush actually need to be done?
	 * Do it anyway, to clear the state.
	 */
	try_to_unmap_flush();

Before insertion of the multi-index:

        /* Join all the small entries into a single multi-index entry. */
        xas_set_order(&xas, start, HPAGE_PMD_ORDER);
        xas_store(&xas, hpage);

Thanks,

-- 
Peter Xu

