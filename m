Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A5688837
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjBBUXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjBBUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6268136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675369375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C8mj02relLT5yXgzADcfXwaECaVPVU3XukbehCzKhxU=;
        b=cqNBeqnaux5m6I0z+Y3vSwSArhLrs5UBNtwDPYuMex5xy+f6bIMNA/+Oma7jHQ2+Uce01A
        +EN3w3GGw3b4fJ07WAoimQ8D1Nj3FZx+4ukgYH4piaaj+hNpWOcvn/Tjd3gP7G8jlTzk57
        Hc35KJ7vKqmk9M6x+YpUovokWvdL0M0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-a03a2bKOOrCnzD_eeau9OA-1; Thu, 02 Feb 2023 15:22:53 -0500
X-MC-Unique: a03a2bKOOrCnzD_eeau9OA-1
Received: by mail-qk1-f198.google.com with SMTP id j29-20020a05620a001d00b00724fd33cb3eso2015539qki.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8mj02relLT5yXgzADcfXwaECaVPVU3XukbehCzKhxU=;
        b=GLvjj0oc6l5afrEtZbo+6VotObIqw1kqlCj8CHJSrUQ+4NATdKjSktkl0oOR6QpfOV
         jNuJvHHaJG8Oo0w9WVRBrWks368Nae5tI2j34N4cqhb5hfIFqBUTltmBmaS+LA3lYdij
         P/PfxPBkbYFD0awoQKMgjAB0oAi7VvMuhcqVeLqEWWpbNU2yKJM5f5CNv/lR73bHaYWC
         J6QiBcWl0Rj4UyGFM0+GVvEhDLoBsJfsDbwQ0WwSIPhOTYZqDev7XbduLiBFs68SSQ6I
         lkhvdtQvSVRdvRMhUJi34Do4meutvoO9+IVzm9Pmdhv/Kx1ujjEcVUEwnQFHlrKrH6Mj
         9DzA==
X-Gm-Message-State: AO0yUKUlLXv0L1snCoeqQmPxbug8PW4MVroEaZ4kXPm8K2fFl/MLrYJg
        NxD0zHhiZ2W6Hj+SDRUEjb9ODVAu5hgyga/yxyl+ly64lu48vON5eR835B8cHR4r4ThEa5DUqDZ
        cCR0z19SgofQ3AQR19reF2e2G
X-Received: by 2002:ac8:7fc3:0:b0:3b6:35cb:b944 with SMTP id b3-20020ac87fc3000000b003b635cbb944mr13723149qtk.2.1675369372816;
        Thu, 02 Feb 2023 12:22:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8+W2L9PqxK+nZ6DUZhTv0aPWQjw2KE1797P9aB4M0bxUeMN0F2dvLAiIGhvNflvo/sIlOiTA==
X-Received: by 2002:ac8:7fc3:0:b0:3b6:35cb:b944 with SMTP id b3-20020ac87fc3000000b003b635cbb944mr13723104qtk.2.1675369372470;
        Thu, 02 Feb 2023 12:22:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id u186-20020a3760c3000000b0072c86374ddfsm381158qkb.71.2023.02.02.12.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:22:51 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:22:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Stevens <stevensd@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
Message-ID: <Y9wbmuEq0QjZATE6@x1n>
References: <20230201034137.2463113-1-stevensd@google.com>
 <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n>
 <CAD=HUj4FjuLpihQLGLzUu82vr5fdFFxfnyKNhApC6L67F5iV4g@mail.gmail.com>
 <CAHbLzko_cXrOQCsQC3g_id06Jkcg3=9dsVe+MwuzAh+iC9dDDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzko_cXrOQCsQC3g_id06Jkcg3=9dsVe+MwuzAh+iC9dDDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 09:40:12AM -0800, Yang Shi wrote:
> On Thu, Feb 2, 2023 at 1:56 AM David Stevens <stevensd@chromium.org> wrote:
> >
> > On Thu, Feb 2, 2023 at 5:52 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Wed, Feb 01, 2023 at 09:36:37AM -0800, Yang Shi wrote:
> > > > On Tue, Jan 31, 2023 at 7:42 PM David Stevens <stevensd@chromium.org> wrote:
> > > > >
> > > > > From: David Stevens <stevensd@chromium.org>
> > > > >
> > > > > Collapsing memory in a vma that has an armed userfaultfd results in
> > > > > zero-filling any missing pages, which breaks user-space paging for those
> > > > > filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
> > > > > pages in shmem reached via scanning a vma with an armed userfaultfd if
> > > > > doing so would zero-fill any pages.
> > > > >
> > > > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > > > ---
> > > > >  mm/khugepaged.c | 35 ++++++++++++++++++++++++-----------
> > > > >  1 file changed, 24 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 79be13133322..48e944fb8972 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -1736,8 +1736,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > > > >   *    + restore gaps in the page cache;
> > > > >   *    + unlock and free huge page;
> > > > >   */
> > > > > -static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > > -                        struct file *file, pgoff_t start,
> > > > > +static int collapse_file(struct mm_struct *mm, struct vm_area_struct *vma,
> > > > > +                        unsigned long addr, struct file *file, pgoff_t start,
> > > > >                          struct collapse_control *cc)
> > > > >  {
> > > > >         struct address_space *mapping = file->f_mapping;
> > > > > @@ -1784,6 +1784,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > > >          * be able to map it or use it in another way until we unlock it.
> > > > >          */
> > > > >
> > > > > +       if (is_shmem)
> > > > > +               mmap_read_lock(mm);
> > > >
> > > > If you release mmap_lock before then reacquire it here, the vma is not
> > > > trusted anymore. It is not safe to use the vma anymore.
> > > >
> > > > Since you already read uffd_was_armed before releasing mmap_lock, so
> > > > you could pass it directly to collapse_file w/o dereferencing vma
> > > > again. The problem may be false positive (not userfaultfd armed
> > > > anymore), but it should be fine. Khugepaged could collapse this area
> > > > in the next round.
> >
> > I didn't notice this race condition. It should be possible to adapt
> > hugepage_vma_revalidate for this situation, or at least to create an
> > analogous situation.
> 
> But once you release mmap_lock, the vma still may be changed,
> revalidation just can guarantee the vma is valid when you hold the
> mmap_lock unless mmap_lock is held for the whole collapse or at some
> point that the collapse doesn't have impact on userfaultfd anymore. We
> definitely don't want to hold mmap_lock for the whole collapse, but I
> don't know whether we could release it earlier or not due to my
> limited knowledge of userfaultfd.

I agree with Yang; I don't quickly see how that'll resolve the issue.

> 
> >
> > > Unfortunately that may not be enough.. because it's also possible that it
> > > reads uffd_armed==false, released mmap_sem, passed it over to the scanner,
> > > but then when scanning the file uffd got armed in parallel.
> > >
> > > There's another problem where the current vma may not have uffd armed,
> > > khugepaged may think it has nothing to do with uffd and moved on with
> > > collapsing, but actually it's armed in another vma of either the current mm
> > > or just another mm's.
> > >
> > > It seems non-trivial too to safely check this across all the vmas, let's
> > > say, by a reverse walk - the only safe way is to walk all the vmas and take
> > > the write lock for every mm, but that's not only too heavy but also merely
> > > impossible to always make it right because of deadlock issues and on the
> > > order of mmap write lock to take..
> > >
> > > So far what I can still think of is, if we can extend shmem_inode_info and
> > > have a counter showing how many uffd has been armed.  It can be a generic
> > > counter too (e.g. shmem_inode_info.collapse_guard_counter) just to avoid
> > > the page cache being collapsed under the hood, but I am also not aware of
> > > whether it can be reused by other things besides uffd.
> > >
> > > Then when we do the real collapsing, say, when:
> > >
> > >                 xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> > >                 xas_store(&xas, hpage);
> > >                 xas_unlock_irq(&xas);
> > >
> > > We may need to make sure that counter keeps static (probably by holding
> > > some locks during the process) and we only do that last phase collapse if
> > > counter==0.
> > >
> > > Similar checks in this patch can still be done, but that'll only service as
> > > a role of failing faster before the ultimate check on the uffd_armed
> > > counter.  Otherwise I just don't quickly see how to avoid race conditions.
> >
> > I don't know if it's necessary to go that far. Userfaultfd plus shmem
> > is inherently brittle. It's possible for userspace to bypass
> > userfaultfd on a shmem mapping by accessing the shmem through a
> > different mapping or simply by using the write syscall.

Yes this is possible, but this is user-visible operation - no matter it was
a read()/write() from another process, or mmap()ed memory accesses.
Khugepaged merges ptes in a way that is out of control of users.  That's
something the user can hardly control.

AFAICT currently file-based uffd missing mode all works in that way.  IOW
the user should have full control of the file/inode under the hood to make
sure there will be nothing surprising.  Otherwise I don't really see how
the missing mode can work solidly since it's page cache based.

> > It might be sufficient to say that the kernel won't directly bypass a
> > VMA's userfaultfd to collapse the underlying shmem's pages. Although on
> > the other hand, I guess it's not great for the presence of an unused
> > shmem mapping lying around to cause khugepaged to have user-visible
> > side effects.

Maybe it works for your use case already, for example, if in your app the
shmem is only and always be mapped once?  However that doesn't seem like a
complete solution to me.

There's nothing that will prevent another mapping being established, and
right after that happens it'll stop working, because khugepaged can notice
that new mm/vma which doesn't register with uffd at all, and thinks it a
good idea to collapse the shmem page cache again.  Uffd will silently fail
in another case even if not immediately in your current app/reproducer.

Again, I don't think what I propose above is anything close to good.. It'll
literally disable any collapsing possibility for a shmem node as long as
any small portion of the inode mapping address space got registered by any
process with uffd.  I just don't see any easier approach so far.

Thanks,

-- 
Peter Xu

