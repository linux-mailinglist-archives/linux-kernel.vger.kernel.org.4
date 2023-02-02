Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C42687992
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBBJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjBBJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:56:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DBC70D63
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:56:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f34so2128446lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Et1yOPHuWuwUUtD1YE0TSilhNb27QJfJADrrMJq+0v0=;
        b=TjptjBDiactzfKrHMuO2Z00fY2DaOBxUU6HUMSOrRXHJnPEL+5jjvxSoh4BfQpa350
         TC9aT+jlpH8XKUj7b8C0N+h4kJBbE2FSoj3QgBqjYcDOTbCO1wh3X21X0wxp7P6hkxs2
         JLCQmBvxI/6UfVDTmaNc8qL4tVi6rnFLyIJ2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Et1yOPHuWuwUUtD1YE0TSilhNb27QJfJADrrMJq+0v0=;
        b=4wtDTLErRhEUYSWDyVonmWNYNCrisA8cTkrVwqy1HQyWDkHW6Pzea6NT13E7H1BD76
         rRz6bi4CQs1yF2WtWBWOqZA3rMtirwbsQ1FBnz0XPX1xiCdcM8UT+fV39PB8ZsVaYfgk
         nEnDt8Zel1jFRSqnOMe3bQWz4j7lef8qgOgRRhlPePS6STyH+H+f+22krEWIIBjVe/aW
         JgBmoQk2XL0TSXrcFvjGZeoLN8R6S+RpZ/fO1MDZIh6z4ZStM86Xx0Y1gtxQ0+cinD7D
         PrY4B6T/wpIPiHOjrobXoNfaLi6E1hQz39rLeSzJ/3g4tNxHukHgOkQLYpaXqLNsf2IK
         Zqig==
X-Gm-Message-State: AO0yUKXhwVtfbSggiWZ2zWIAGx4u7zU9Elk07HWGWZ3I4ik5gPkhx6g0
        iH2bsDkbW3ebxtopNBbWBT0QLqzTS/Puupn9E4triA==
X-Google-Smtp-Source: AK7set/+LRUeC+y7hURPLw3FDp13bWqyHKjm6FhqDKZXu/4BvgyeX2K9tedksP7JXqTzGG4YdKEE0oEkumQJliuj6/I=
X-Received: by 2002:a19:5f54:0:b0:4cb:1ddd:3b5 with SMTP id
 a20-20020a195f54000000b004cb1ddd03b5mr905136lfj.171.1675331776263; Thu, 02
 Feb 2023 01:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20230201034137.2463113-1-stevensd@google.com> <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n>
In-Reply-To: <Y9rRCN9EfqzwYnDG@x1n>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 2 Feb 2023 18:56:04 +0900
Message-ID: <CAD=HUj4FjuLpihQLGLzUu82vr5fdFFxfnyKNhApC6L67F5iV4g@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 5:52 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 01, 2023 at 09:36:37AM -0800, Yang Shi wrote:
> > On Tue, Jan 31, 2023 at 7:42 PM David Stevens <stevensd@chromium.org> wrote:
> > >
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Collapsing memory in a vma that has an armed userfaultfd results in
> > > zero-filling any missing pages, which breaks user-space paging for those
> > > filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
> > > pages in shmem reached via scanning a vma with an armed userfaultfd if
> > > doing so would zero-fill any pages.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > ---
> > >  mm/khugepaged.c | 35 ++++++++++++++++++++++++-----------
> > >  1 file changed, 24 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 79be13133322..48e944fb8972 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1736,8 +1736,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > >   *    + restore gaps in the page cache;
> > >   *    + unlock and free huge page;
> > >   */
> > > -static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > > -                        struct file *file, pgoff_t start,
> > > +static int collapse_file(struct mm_struct *mm, struct vm_area_struct *vma,
> > > +                        unsigned long addr, struct file *file, pgoff_t start,
> > >                          struct collapse_control *cc)
> > >  {
> > >         struct address_space *mapping = file->f_mapping;
> > > @@ -1784,6 +1784,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > >          * be able to map it or use it in another way until we unlock it.
> > >          */
> > >
> > > +       if (is_shmem)
> > > +               mmap_read_lock(mm);
> >
> > If you release mmap_lock before then reacquire it here, the vma is not
> > trusted anymore. It is not safe to use the vma anymore.
> >
> > Since you already read uffd_was_armed before releasing mmap_lock, so
> > you could pass it directly to collapse_file w/o dereferencing vma
> > again. The problem may be false positive (not userfaultfd armed
> > anymore), but it should be fine. Khugepaged could collapse this area
> > in the next round.

I didn't notice this race condition. It should be possible to adapt
hugepage_vma_revalidate for this situation, or at least to create an
analogous situation.

> Unfortunately that may not be enough.. because it's also possible that it
> reads uffd_armed==false, released mmap_sem, passed it over to the scanner,
> but then when scanning the file uffd got armed in parallel.
>
> There's another problem where the current vma may not have uffd armed,
> khugepaged may think it has nothing to do with uffd and moved on with
> collapsing, but actually it's armed in another vma of either the current mm
> or just another mm's.
>
> It seems non-trivial too to safely check this across all the vmas, let's
> say, by a reverse walk - the only safe way is to walk all the vmas and take
> the write lock for every mm, but that's not only too heavy but also merely
> impossible to always make it right because of deadlock issues and on the
> order of mmap write lock to take..
>
> So far what I can still think of is, if we can extend shmem_inode_info and
> have a counter showing how many uffd has been armed.  It can be a generic
> counter too (e.g. shmem_inode_info.collapse_guard_counter) just to avoid
> the page cache being collapsed under the hood, but I am also not aware of
> whether it can be reused by other things besides uffd.
>
> Then when we do the real collapsing, say, when:
>
>                 xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>                 xas_store(&xas, hpage);
>                 xas_unlock_irq(&xas);
>
> We may need to make sure that counter keeps static (probably by holding
> some locks during the process) and we only do that last phase collapse if
> counter==0.
>
> Similar checks in this patch can still be done, but that'll only service as
> a role of failing faster before the ultimate check on the uffd_armed
> counter.  Otherwise I just don't quickly see how to avoid race conditions.

I don't know if it's necessary to go that far. Userfaultfd plus shmem
is inherently brittle. It's possible for userspace to bypass
userfaultfd on a shmem mapping by accessing the shmem through a
different mapping or simply by using the write syscall. It might be
sufficient to say that the kernel won't directly bypass a VMA's
userfaultfd to collapse the underlying shmem's pages. Although on the
other hand, I guess it's not great for the presence of an unused shmem
mapping lying around to cause khugepaged to have user-visible side
effects.

-David

> It'll be great if someone can come up with something better than above..
> Copy Hugh too.
>
> Thanks,
>
> --
> Peter Xu
>
