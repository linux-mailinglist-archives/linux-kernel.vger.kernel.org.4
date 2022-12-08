Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121A64777E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLHUs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F42A0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670532452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2IaWo/ElxMU4U0hZAO6Xw6wjYlafg6eLVU3ehWaqxQ=;
        b=BIzF6giuxPZwrV4ASWyev4VqI/CHYCAsIjsRKhAZccH9BRVgJ7r2TlZYrVDqw3AheP88Xg
        DfwdKeks9eUy7dKVfE1KBtgCG1VTvMKGfoqcdlvAkAFR9KxMIelGYFzXsk99Om7eNp5TS3
        mp25KH2CQthL71+v/Iq4GKj/aG3pGlI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-2ScsKk5uNxmG1p3QAhBMfQ-1; Thu, 08 Dec 2022 15:47:31 -0500
X-MC-Unique: 2ScsKk5uNxmG1p3QAhBMfQ-1
Received: by mail-qt1-f200.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so2518214qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2IaWo/ElxMU4U0hZAO6Xw6wjYlafg6eLVU3ehWaqxQ=;
        b=WVh7EeUfV23lGB7B/dtl6s/CGO9CItjbtv056BZlfdUP/Do3XsXXWuPGaMtk3HW65c
         5zy3SB2BLjNm+DnUYvYyTgNkAXRJAL3qO9R5v8yC4R7HQUqCaFbZQwV+vq5XjSlQOqBM
         Rbs+/1zKtmTygisvorLIsPhQyBkuTKS5yxqt0dp1JUtWTN/CPFrOQNvbjmo4QAFMrLtU
         44lRua0IKLI5NFZv1Df/l6uTED8zDprzPYoHuNSrCWTP+dNdcsCMEOOJ29Fv0lNTl7Xu
         tSMX8jrj0tLCQX4aO3BWd5e+9X7poRolLnSEtkgrp6RSPiVYMMzTKiYzAM7Y8bovc7Qb
         53Qw==
X-Gm-Message-State: ANoB5pn6Kr3Um4eJnKLj/OsIyxgXxUh8yvrZzBDBJrF8UkHDuOik6A33
        N+TXuwPpmwj3B3fNXUbDnyljpN3EiTcxAphJpD7XGYR3TB1hH7w2TpAWcMagLthP+tdKzQ8MbzN
        6NMAf9Mr3V7ObDFKNOzMU2uVW
X-Received: by 2002:ac8:5347:0:b0:3a6:8be4:b0b1 with SMTP id d7-20020ac85347000000b003a68be4b0b1mr4346635qto.33.1670532448350;
        Thu, 08 Dec 2022 12:47:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf76qx0fTDXNDecqcepM9jyXl4zuHN/DRq9/4bEhX31vPTvcUzwXEWh3/CDlV8qnyDBkqmKdnQ==
X-Received: by 2002:ac8:5347:0:b0:3a6:8be4:b0b1 with SMTP id d7-20020ac85347000000b003a68be4b0b1mr4346610qto.33.1670532448017;
        Thu, 08 Dec 2022 12:47:28 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id x13-20020ac86b4d000000b0035badb499c7sm15469372qts.21.2022.12.08.12.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:47:27 -0800 (PST)
Date:   Thu, 8 Dec 2022 15:47:26 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to
 pmd unshare
Message-ID: <Y5JNXomE5eGo8DyF@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-9-peterx@redhat.com>
 <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 02:14:42PM +0100, David Hildenbrand wrote:
> On 07.12.22 21:30, Peter Xu wrote:
> > Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> > to make sure the pgtable page will not be freed concurrently.
> > 
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   arch/s390/mm/gmap.c      |  2 ++
> >   fs/proc/task_mmu.c       |  2 ++
> >   include/linux/pagewalk.h | 11 ++++++++++-
> >   mm/hmm.c                 | 15 ++++++++++++++-
> >   mm/pagewalk.c            |  2 ++
> >   5 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> > index 8947451ae021..292a54c490d4 100644
> > --- a/arch/s390/mm/gmap.c
> > +++ b/arch/s390/mm/gmap.c
> > @@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
> >   	end = start + HPAGE_SIZE - 1;
> >   	__storage_key_init_range(start, end);
> >   	set_bit(PG_arch_1, &page->flags);
> > +	hugetlb_vma_unlock_read(walk->vma);
> >   	cond_resched();
> > +	hugetlb_vma_lock_read(walk->vma);
> >   	return 0;
> >   }
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index e35a0398db63..cf3887fb2905 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1613,7 +1613,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
> >   			frame++;
> >   	}
> > +	hugetlb_vma_unlock_read(walk->vma);
> >   	cond_resched();
> > +	hugetlb_vma_lock_read(walk->vma);
> 
> We already hold the mmap_lock and reschedule. Even without the
> cond_resched() we might happily reschedule on a preemptive kernel. So I'm
> not sure if this optimization is strictly required or even helpful in
> practice here.

It's just low hanging fruit if we need that complexity anyway.

That's also why I didn't do that for v1 (where I missed hmm special case,
though..), but I think since we'll need that anyway, we'd better release
the vma lock if we can easily do so.

mmap_lock is just more special because it needs more work in the caller to
release (e.g. vma invalidations).  Otherwise I'm happy dropping that too.

> 
> In the worst case, concurrent unsharing would have to wait.
> For example, s390_enable_skey() is called at most once for a VM, for most
> VMs it gets never even called.
> 
> Or am I missing something important?

Nothing important.  I just don't see why we need to strictly follow the
same release rule of mmap_lock here when talking about vma lock.

In short - if we can drop a lock earlier before sleep, why not?

I tend to just keep it as-is, but let me know if you have further thoughts
or concerns.

-- 
Peter Xu

