Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2DB687218
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBAX5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBAX5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:57:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888065ECE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:57:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g9so40696pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGa7e7F/TDsF1urwxiuZqzkKC/7RmX/Br21vDTl0s/M=;
        b=OeejTvcPsRHGIN95mlSNc1CP0w8sZUDEEvXvvk7Tyk4wijIdV4JFo5weE9VJcAxZ7R
         5ACbbyFDzxzCGmICVjZURapBvavx3BuCMCLuy5Gdu5Nu6IbukQZFX20qLlmG/WFV6yFH
         TSCNxKUzHSMiYCCwnHldv2o1UoF0xKNpUyl1EqN1FxpARvvyd71Ye9igmFBWyqFrelcY
         xeTThieUZNPtNM5JoPNbv3Dx0F9oShCb4Umz904D2vMbiyE1hPPAdJk/Zw4JEWT8X222
         9JrWlCOvBs3NQd85XBD0RcLI6Jhll6BJiKvHGyf8l0pE0ALDcHTybgTkrXMS5Re9B7MG
         4Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGa7e7F/TDsF1urwxiuZqzkKC/7RmX/Br21vDTl0s/M=;
        b=c81idOTdI+TSFrOFCjUC+6xnUf1uSbOfiHI4i5pgHadJ/YYjfEvFVOJREiAPj/SRSi
         3t24o8+7LHstY68dE2gAfNK4qeogVeP4qIxPi52gspgGApPkfhTXW3BgRbPUE49N5mt/
         kz7FF48fhayseVh6OOC1Zfb9XUlZA9uXohBuU57SkpAgqzq8na/GNVsJhruNGQ1hAUAR
         chPN30+u5qHgSWPKwUfQA0/XoMzpyHn4935GQEBpAtUAvtU2swydpd/5B+O4clpC0d1c
         fwR9lCLibSPtUJJCD1YQdae8fxDUT61HO3P93e70540XLRnXl82gCHob2sevZTMV0/eL
         cYxQ==
X-Gm-Message-State: AO0yUKV9MHadQp90uccqbyfaGBBSjWSLr5Zo7/AVNtPddkwV9S5uVUYf
        x1MaFzMD3YcmtasokvWeHQDQ/UTS3TaOJVN92bg=
X-Google-Smtp-Source: AK7set9aT91CCQY72WKSkYBwyIBGTU5zCp1zvRULyUrU9L9yfRjNRCbZ52VE04Z0LDBznEiARn0ZUaMIAstpoQIz39Y=
X-Received: by 2002:a05:6a00:1589:b0:592:7c9a:1236 with SMTP id
 u9-20020a056a00158900b005927c9a1236mr899484pfk.26.1675295865289; Wed, 01 Feb
 2023 15:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20230201034137.2463113-1-stevensd@google.com> <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n>
In-Reply-To: <Y9rRCN9EfqzwYnDG@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 1 Feb 2023 15:57:33 -0800
Message-ID: <CAHbLzkqyhS5thdVKa-jcS5iNUNxe95hagBncWaG=CQTh=LU70w@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 12:52 PM Peter Xu <peterx@redhat.com> wrote:
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
>
> Unfortunately that may not be enough.. because it's also possible that it
> reads uffd_armed==false, released mmap_sem, passed it over to the scanner,
> but then when scanning the file uffd got armed in parallel.

Aha, yeah, I missed that part... thanks for pointing it out.

>
> There's another problem where the current vma may not have uffd armed,
> khugepaged may think it has nothing to do with uffd and moved on with
> collapsing, but actually it's armed in another vma of either the current mm
> or just another mm's.

Out of curiosity, could you please elaborate how another vma armed
with userfaultfd could have an impact on the vmas that are not armed?

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
>
> It'll be great if someone can come up with something better than above..
> Copy Hugh too.
>
> Thanks,
>
> --
> Peter Xu
>
