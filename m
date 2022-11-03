Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726E9618729
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCSMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiKCSMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6622718
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667499096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WMjOJmGY0GsqjDFw7J9b6jhLGxRZTGjZleyCuJ0qI4=;
        b=Eg7ao3KB8TwBrkB5/lnltYldpOMFOOvgT4MfqkGgYMgyeyMGyK8IYLQJto96LH6TQogRZW
        ft7V26Az6y7YgYKQuxmwiMpAAjzPmSVH2+ChlJ+K0HG8JmzN4uucuMn+TcPZLj99aoMkU+
        pdaE3n+OoZ0do4p7BKc8WoayB2lQtGU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461-mPSjdz1TOxG5OWbPdX-S4Q-1; Thu, 03 Nov 2022 14:11:34 -0400
X-MC-Unique: mPSjdz1TOxG5OWbPdX-S4Q-1
Received: by mail-qt1-f197.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso2339901qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WMjOJmGY0GsqjDFw7J9b6jhLGxRZTGjZleyCuJ0qI4=;
        b=e7MvmgeMlW/wyqamSpMaAsThICINsNi/W/vZUNSY222HxDrCv+9mdgzODpYujUowsR
         4Y6cO0R0T+IgE4mWRnT2hp1rGt8QCHUx4YH5ywrdxE95gRW6KfE4gHmJgpzR6ScY4Gv8
         cZRuHDagaNMYN3oLAZhAp+yvzd3vWPdJxL0I9yqc3JMHF7p+qI1OBsKa/7vQ599+5rA3
         KVdYrzpSqrj0CRuUOluUSYlrEmD68yqHaV95ILyGzDbZYxSXLp32lONpTzSRgbtIsAMd
         P7/7DbbRKq8StZspsz9qXxGlS8RcGR071tgs7vG10dSTBUy/D9afF+gQ7a56Js1jQeON
         mREw==
X-Gm-Message-State: ACrzQf3zhn3c2PDk7Hbg6qceXKpeFl+25nxrLSChGp0wvAykGPy+RvrQ
        KojIdGa6osDh3ZAh8WR9HuKAMnqaqKcxv7i9oQJQf12jz3Fi7CiiTllaDGTrvx5pr+WUl9ydWpG
        SnE+x3BsyCU+c+ccwtQ5jAg0V
X-Received: by 2002:ac8:7190:0:b0:3a5:10c1:5d3d with SMTP id w16-20020ac87190000000b003a510c15d3dmr25252448qto.483.1667499094026;
        Thu, 03 Nov 2022 11:11:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM45yQ8MdqKISd6W1U+UOvmGYfurrB6CD4B4rFpjr+ZM1lRQ4FxyzPKu9VEbP8mAK7W3NlT0iA==
X-Received: by 2002:ac8:7190:0:b0:3a5:10c1:5d3d with SMTP id w16-20020ac87190000000b003a510c15d3dmr25252422qto.483.1667499093772;
        Thu, 03 Nov 2022 11:11:33 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id fe4-20020a05622a4d4400b00397b1c60780sm918078qtb.61.2022.11.03.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:11:33 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:11:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 02/10] mm/hugetlb: Comment huge_pte_offset() for its
 locking requirements
Message-ID: <Y2QEU53BMDgEHXbG@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-3-peterx@redhat.com>
 <Y2PhSUnufjkoqSaH@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2PhSUnufjkoqSaH@monkey>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:42:01AM -0700, Mike Kravetz wrote:
> On 10/30/22 17:29, Peter Xu wrote:
> > huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> > hugetlb address.
> > 
> > Normally, it's always safe to walk the pgtable as long as we're with the
> > mmap lock held for either read or write, because that guarantees the
> > pgtable pages will always be valid during the process.
> > 
> > But it's not true for hugetlbfs: hugetlbfs has the pmd sharing feature, it
> > means that even with mmap lock held, the PUD pgtable page can still go away
> > from under us if pmd unsharing is possible during the walk.
> > 
> > It's not always the case, e.g.:
> > 
> >   (1) If the mapping is private we're not prone to pmd sharing or
> >       unsharing, so it's okay.
> > 
> >   (2) If we're with the hugetlb vma lock held for either read/write, it's
> >       okay too because pmd unshare cannot happen at all.
> > 
> > Document all these explicitly for huge_pte_offset(), because it's really
> > not that obvious.  This also tells all the callers on what it needs to
> > guarantee huge_pte_offset() thread-safety.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/arm64/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index 35e9a468d13e..0bf930c75d4b 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -329,6 +329,38 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> >  	return ptep;
> >  }
> >  
> > +/*
> > + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> > + * Returns the pte_t* if found, or NULL if the address is not mapped.
> > + *
> > + * NOTE: since this function will walk all the pgtable pages (including not
> > + * only high-level pgtable page, but also PUD that can be unshared
> > + * concurrently for VM_SHARED), the caller of this function should be
> > + * responsible of its thread safety.  One can follow this rule:
> > + *
> > + *  (1) For private mappings: pmd unsharing is not possible, so it'll
> > + *      always be safe if we're with the mmap sem for either read or write.
> > + *      This is normally always the case, so IOW we don't need to do
> > + *      anything special.
> 
> Not sure if it is worth calling out that we are safe if the process owning the
> page table being walked is single threaded?  Although, a pmd can be 'unshared'
> due to an operation in another process, the primary is when the pmd is cleared
> which only happens when the unshare is initiated by a thread of the process
> owning the page tables being walked.

Even if the process is single threaded, the pmd unshare can still trigger
from other threads too, am I right?

Looking at huge_pmd_unshare() callers, the major ones that doesn't need
current mm context are:

  - __unmap_hugepage_range() (e.g. hole punch from other process on file?)
  - try_to_unmap_one()
  - try_to_migrate_one()

So for example, even for a single thread process, if its pmd shared with
another process, the other process can do (1) punch hole on pmd shared
region, then (2) munmap() the pmd shared region, then it seems the single
thread process can be still on risk of accessing freed pgtable.

Thanks,

-- 
Peter Xu

