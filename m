Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7390644A86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiLFRly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiLFRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33C6248
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670348396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9eSdDE0c0U/MUBWPyCAEkbqVPoDx/BF4tw0MN/NmEp8=;
        b=McaPpzj8GvaQLT8KRuKmFml1m5qYediqWhB4Vw3whN5UCZl1xAEHEFyMvRp+UoO1TyZ3cV
        uE+I+Hy65nfTNi9J4S4TpBb4GWNOmSFNiQwYmVnYJjAhVCY69TKw9jQ00uD3+KK3L0cJSO
        YLR8Qc/ol5YawjJpk6+YBasp9JsPZNs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484--kste0MNNPeuto5FCLBFjA-1; Tue, 06 Dec 2022 12:39:55 -0500
X-MC-Unique: -kste0MNNPeuto5FCLBFjA-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so21046916qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eSdDE0c0U/MUBWPyCAEkbqVPoDx/BF4tw0MN/NmEp8=;
        b=WGAylfaN03zKTdssa+YpZO8fbnawfWbMTUIH/3d1ZIrz/ZL4pNijhhceTnpeLSQc1k
         Fw4VYlXZG/BMeEzvplqW4kCZjUhVd1Rt7T5A57AJ7FQwuMOcStOXHD68599d6vUo08A5
         /m0PzEaDttncdtJ8bTWVznya/Jw8q/1fufIGX7zhyJPjfAHy95cLAKfTy/3KOUFjRrz9
         3YAVST3L9Tm+fABpY6u3cgCv3OGY5KrXlS9ARj258FEdqiVX0aX8ucBz25ezNUF9qArM
         GsIV8vvXp4xW/JKrUYddaEem8iK6wGKeTjHlIq5o8ucEDRwVLWouuwMaBt3qPG0sXkWw
         VfyA==
X-Gm-Message-State: ANoB5pkSoDjGsTrmdF5jNHVWp+Ozh06ef2N5GSexrFouWQ9oPQkHa6qB
        gTG8j/1JOKT5uNGGSuwqd2CZ1Kp4zKnwK9N6CAB4Icel8GQwC6D3qasXoEb5skSJ9Co2UHHzKI5
        4GHEwcBZzJ/hcA3KsVKLjkjEw
X-Received: by 2002:a0c:ee91:0:b0:4b4:a0b0:2dd8 with SMTP id u17-20020a0cee91000000b004b4a0b02dd8mr64284674qvr.19.1670348395067;
        Tue, 06 Dec 2022 09:39:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6b1+ISqrlH0lLOb+7V4W6ygsRdI5Zxx1V2ZKnqYPdlh7HbE9R+/H01/HLMkvJ008ZRLgd5lA==
X-Received: by 2002:a0c:ee91:0:b0:4b4:a0b0:2dd8 with SMTP id u17-20020a0cee91000000b004b4a0b02dd8mr64284657qvr.19.1670348394821;
        Tue, 06 Dec 2022 09:39:54 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id f25-20020ac86ed9000000b003a4f2510e5dsm11815516qtv.24.2022.12.06.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:39:54 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:39:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to
 pmd unshare
Message-ID: <Y49+aYHTy/UwV7JQ@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
 <Y46EMlDLCThbrl+E@monkey>
 <Y493aNfcK7n7s1B1@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y493aNfcK7n7s1B1@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:10:00AM -0800, Mike Kravetz wrote:
> On 12/05/22 15:52, Mike Kravetz wrote:
> > On 11/29/22 14:35, Peter Xu wrote:
> > > Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> > > to make sure the pgtable page will not be freed concurrently.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/linux/rmap.h | 4 ++++
> > >  mm/page_vma_mapped.c | 5 ++++-
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > index bd3504d11b15..a50d18bb86aa 100644
> > > --- a/include/linux/rmap.h
> > > +++ b/include/linux/rmap.h
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/highmem.h>
> > >  #include <linux/pagemap.h>
> > >  #include <linux/memremap.h>
> > > +#include <linux/hugetlb.h>
> > >  
> > >  /*
> > >   * The anon_vma heads a list of private "related" vmas, to scan if
> > > @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
> > >  		pte_unmap(pvmw->pte);
> > >  	if (pvmw->ptl)
> > >  		spin_unlock(pvmw->ptl);
> > > +	/* This needs to be after unlock of the spinlock */
> > > +	if (is_vm_hugetlb_page(pvmw->vma))
> > > +		hugetlb_vma_unlock_read(pvmw->vma);
> > >  }
> > >  
> > >  bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index 93e13fc17d3c..f94ec78b54ff 100644
> > > --- a/mm/page_vma_mapped.c
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >  		if (pvmw->pte)
> > >  			return not_found(pvmw);
> > >  
> > > +		hugetlb_vma_lock_read(vma);
> > >  		/* when pud is not present, pte will be NULL */
> > >  		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> > > -		if (!pvmw->pte)
> > > +		if (!pvmw->pte) {
> > > +			hugetlb_vma_unlock_read(vma);
> > >  			return false;
> > > +		}
> > >  
> > >  		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
> > >  		if (!check_pte(pvmw))
> > 
> > I think this is going to cause try_to_unmap() to always fail for hugetlb
> > shared pages.  See try_to_unmap_one:
> > 
> > 	while (page_vma_mapped_walk(&pvmw)) {
> > 		...
> > 		if (folio_test_hugetlb(folio)) {
> > 			...
> > 			/*
> >                          * To call huge_pmd_unshare, i_mmap_rwsem must be
> >                          * held in write mode.  Caller needs to explicitly
> >                          * do this outside rmap routines.
> >                          *
> >                          * We also must hold hugetlb vma_lock in write mode.
> >                          * Lock order dictates acquiring vma_lock BEFORE
> >                          * i_mmap_rwsem.  We can only try lock here and fail
> >                          * if unsuccessful.
> >                          */
> >                         if (!anon) {
> >                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> >                                 if (!hugetlb_vma_trylock_write(vma)) {
> >                                         page_vma_mapped_walk_done(&pvmw);
> >                                         ret = false;
> > 				}
> > 
> > 
> > Can not think of a great solution right now.
> 
> Thought of this last night ...
> 
> Perhaps we do not need vma_lock in this code path (not sure about all
> page_vma_mapped_walk calls).  Why?  We already hold i_mmap_rwsem.

Exactly.  The only concern is when it's not in a rmap.

I'm actually preparing something that adds a new flag to PVMW, like:

#define PVMW_HUGETLB_NEEDS_LOCK	(1 << 2)

But maybe we don't need that at all, since I had a closer look the only
outliers of not using a rmap is:

__replace_page
write_protect_page

I'm pretty sure ksm doesn't have hugetlb involved, then the other one is
uprobe (uprobe_write_opcode).  I think it's the same.  If it's true, we can
simply drop this patch.  Then we also have hugetlb_walk and the lock checks
there guarantee that we're safe anyways.

Potentially we can document this fact, which I also attached a comment
patch just for it to be appended to the end of the patchset.

Mike, let me know what do you think.

Andrew, if this patch to be dropped then the last patch may not cleanly
apply.  Let me know if you want a full repost of the things.

Thanks,

-- 
Peter Xu

