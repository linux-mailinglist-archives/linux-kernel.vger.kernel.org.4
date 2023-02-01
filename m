Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6439687024
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBAUym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBAUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF166779A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675284751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S587H/AHgtqLelKRqRW9IyHD7csvvblJVyxaPynGgt4=;
        b=ErKfcHuYEXr9xNnaADcdDA+GbI2AB5FFuTtSTwWhvqUaKpKsYoPOfdLbUHOYCx7RR56GyW
        8eCFazYo7ulSAt2pasqh3nmz3YNeK7+cABW15KW8jwJQRyiIV1RQeBUyMkBeacTKUPEctn
        MV9kuZdWs7nCupvZLuQG1r7yeMWxoYY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-xX528IC3MRyud6z8fFRDpA-1; Wed, 01 Feb 2023 15:52:27 -0500
X-MC-Unique: xX528IC3MRyud6z8fFRDpA-1
Received: by mail-qk1-f200.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so36937qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S587H/AHgtqLelKRqRW9IyHD7csvvblJVyxaPynGgt4=;
        b=qlBypOF1lE+0hJ+cVDURLf4v9jrCpaOHtbfew+RIRCiq4bWnLBR70z1ELJigiiPk40
         CRYjOlOtu27eH3EZxTogRO9AeW6YNUCFEqL2cc6vnoPd6zFi4lS7iWWdE7i4i8qp7CZG
         b0Wy11HT5RVdovVvFydRoIZOMgu2U+jLgwLK8MrkXXAJRAa3UBcUVQ8mRkFE88Z2ilLM
         OymnlLz3EmOYx94E8EBvOsnC2Wb9yEOivte8WLRx7uGioIrjpSRr0Uf2EPDdi1CdIa4p
         BywWldCoEPN4dEUIYBXHQwAnHLSPihb0+ju/wYrnXU7fLXTQrv7dkjW1wt4IS5Ro3scO
         rNeQ==
X-Gm-Message-State: AO0yUKX8MCY49JcFiwlwXyVdlGVCsYvMMQImoSZ9ML2H6oJghucE1uSr
        VoZM+inEgOPc6S2YSpRVl5vSuPwCXUhuxDE1/+YxLEnmQqta1PAA5YaaALpw5duhTJXTWPHYqdy
        cWo+QY6YER8Wg39ICy+6xBCR0
X-Received: by 2002:a05:622a:1e10:b0:3b8:68df:fc72 with SMTP id br16-20020a05622a1e1000b003b868dffc72mr5768716qtb.2.1675284747295;
        Wed, 01 Feb 2023 12:52:27 -0800 (PST)
X-Google-Smtp-Source: AK7set/1l/OfMXsvHPEGBhvk9wxikeE80tcy9FA+8CSUjxWzqv1kAcmQ0SOJNC5SyVkazaEdThSshQ==
X-Received: by 2002:a05:622a:1e10:b0:3b8:68df:fc72 with SMTP id br16-20020a05622a1e1000b003b868dffc72mr5768699qtb.2.1675284747045;
        Wed, 01 Feb 2023 12:52:27 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id fu3-20020a05622a5d8300b003a7eb5baf3csm12324867qtb.69.2023.02.01.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:52:26 -0800 (PST)
Date:   Wed, 1 Feb 2023 15:52:24 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Stevens <stevensd@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
Message-ID: <Y9rRCN9EfqzwYnDG@x1n>
References: <20230201034137.2463113-1-stevensd@google.com>
 <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:36:37AM -0800, Yang Shi wrote:
> On Tue, Jan 31, 2023 at 7:42 PM David Stevens <stevensd@chromium.org> wrote:
> >
> > From: David Stevens <stevensd@chromium.org>
> >
> > Collapsing memory in a vma that has an armed userfaultfd results in
> > zero-filling any missing pages, which breaks user-space paging for those
> > filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
> > pages in shmem reached via scanning a vma with an armed userfaultfd if
> > doing so would zero-fill any pages.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  mm/khugepaged.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 79be13133322..48e944fb8972 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1736,8 +1736,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> >   *    + restore gaps in the page cache;
> >   *    + unlock and free huge page;
> >   */
> > -static int collapse_file(struct mm_struct *mm, unsigned long addr,
> > -                        struct file *file, pgoff_t start,
> > +static int collapse_file(struct mm_struct *mm, struct vm_area_struct *vma,
> > +                        unsigned long addr, struct file *file, pgoff_t start,
> >                          struct collapse_control *cc)
> >  {
> >         struct address_space *mapping = file->f_mapping;
> > @@ -1784,6 +1784,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >          * be able to map it or use it in another way until we unlock it.
> >          */
> >
> > +       if (is_shmem)
> > +               mmap_read_lock(mm);
> 
> If you release mmap_lock before then reacquire it here, the vma is not
> trusted anymore. It is not safe to use the vma anymore.
> 
> Since you already read uffd_was_armed before releasing mmap_lock, so
> you could pass it directly to collapse_file w/o dereferencing vma
> again. The problem may be false positive (not userfaultfd armed
> anymore), but it should be fine. Khugepaged could collapse this area
> in the next round.

Unfortunately that may not be enough.. because it's also possible that it
reads uffd_armed==false, released mmap_sem, passed it over to the scanner,
but then when scanning the file uffd got armed in parallel.

There's another problem where the current vma may not have uffd armed,
khugepaged may think it has nothing to do with uffd and moved on with
collapsing, but actually it's armed in another vma of either the current mm
or just another mm's.

It seems non-trivial too to safely check this across all the vmas, let's
say, by a reverse walk - the only safe way is to walk all the vmas and take
the write lock for every mm, but that's not only too heavy but also merely
impossible to always make it right because of deadlock issues and on the
order of mmap write lock to take..

So far what I can still think of is, if we can extend shmem_inode_info and
have a counter showing how many uffd has been armed.  It can be a generic
counter too (e.g. shmem_inode_info.collapse_guard_counter) just to avoid
the page cache being collapsed under the hood, but I am also not aware of
whether it can be reused by other things besides uffd.

Then when we do the real collapsing, say, when:

		xas_set_order(&xas, start, HPAGE_PMD_ORDER);
		xas_store(&xas, hpage);
		xas_unlock_irq(&xas);

We may need to make sure that counter keeps static (probably by holding
some locks during the process) and we only do that last phase collapse if
counter==0.

Similar checks in this patch can still be done, but that'll only service as
a role of failing faster before the ultimate check on the uffd_armed
counter.  Otherwise I just don't quickly see how to avoid race conditions.

It'll be great if someone can come up with something better than above..
Copy Hugh too.

Thanks,

-- 
Peter Xu

