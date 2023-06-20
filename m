Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6965737183
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjFTQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFTQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBFDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687278523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFzX5Es5mmSUfXtH4khhxU/bp/Nm0/eyecTWs7IUiJI=;
        b=TFB4aN/B6i92Yu3rKTD79P5raMtahuKD6fZAQ9Rk70uzWYXyFX0ibRPJuR1miC/bKx4kXD
        uQ+WWmUELpKRF8QudzkEgB9wlGJMP3yAcegYHIMCb0rz6G5Z7btt+DBm+hREAngEXBAA5w
        OhGjMW4btBqWp+eT+6MK3XQqL3dO/yo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-lM2GFAN0O5id0DZWdPSq0A-1; Tue, 20 Jun 2023 12:28:40 -0400
X-MC-Unique: lM2GFAN0O5id0DZWdPSq0A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74faf5008bbso112657385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278508; x=1689870508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFzX5Es5mmSUfXtH4khhxU/bp/Nm0/eyecTWs7IUiJI=;
        b=WyFKa8/7t3uJ0HK+/JBX9g3Mp/nJPm4wmSH9w+Plq7Jh2kwyhJikg7ApuGeQiag0Mx
         SXVTs7xjTKESj4dBWNR5fq8sVE7iUwPNAwLkkTtA4aehn8uDPNNLE3L3D/waY5BY5twU
         RKP+pQ+z7z33Sp66thL8j1XdXIg3Ntsat9UQ6saH3nlVMjkHe9vEgsPU/WT5+rDiCyAD
         Z1U4UfqS8LHLJZwaVWrmoVnVeaKH8wrxiU8iavK8CdOsqGcofrCM6Is8uVneP9mK0G+5
         GArjwBxRKdOM/3h7hUS1EpXUY1BbftMUGxIjc9rNSJQ+kr/ARDd0fEpgu9N6IgK63FTT
         spFQ==
X-Gm-Message-State: AC+VfDyTyx/Wlgn5BT4+d9e7q0E0ooC1rFfElsoThy7Az3KAA/mZnBPy
        JiLwhlqWnDAiim2AxJciUBFjWiu/pLm4Izu+8t5e7cNwFzj6t5GKidhVFwpK2VlaMmT+++ohBEc
        0dzq2qneBmZfK6TYszVTkUkAGVgOe/IY5
X-Received: by 2002:a05:620a:8c04:b0:763:a12a:7cfa with SMTP id qz4-20020a05620a8c0400b00763a12a7cfamr4683622qkn.2.1687278508239;
        Tue, 20 Jun 2023 09:28:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71NiowKoZnXI0RXZoW8fAHCKds8vFwNyHLsEQo0yrS4SphUronLHQcIRYQAoPJ0dWjBqC9sA==
X-Received: by 2002:a05:620a:8c04:b0:763:a12a:7cfa with SMTP id qz4-20020a05620a8c0400b00763a12a7cfamr4683610qkn.2.1687278507930;
        Tue, 20 Jun 2023 09:28:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a11-20020a05620a16cb00b0075c9abecdf8sm1303134qkn.1.2023.06.20.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:28:27 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:28:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 3/8] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
Message-ID: <ZJHTqsCsLUAprEPc@x1n>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-4-peterx@redhat.com>
 <d1f6c2c5-07d0-d430-49b3-68e9f5978534@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1f6c2c5-07d0-d430-49b3-68e9f5978534@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:23:09PM +0200, David Hildenbrand wrote:
> On 20.06.23 01:10, Peter Xu wrote:
> > follow_page() doesn't need it, but we'll start to need it when unifying gup
> > for hugetlb.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/hugetlb.h | 8 +++++---
> >   mm/gup.c                | 3 ++-
> >   mm/hugetlb.c            | 5 ++++-
> >   3 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index beb7c63d2871..2e2d89e79d6c 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -131,7 +131,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
> >   int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
> >   			    struct vm_area_struct *, struct vm_area_struct *);
> >   struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > -				unsigned long address, unsigned int flags);
> > +				      unsigned long address, unsigned int flags,
> > +				      unsigned int *page_mask);
> >   long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> >   			 struct page **, unsigned long *, unsigned long *,
> >   			 long, unsigned int, int *);
> > @@ -297,8 +298,9 @@ static inline void adjust_range_if_pmd_sharing_possible(
> >   {
> >   }
> > -static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > -				unsigned long address, unsigned int flags)
> > +static inline struct page *hugetlb_follow_page_mask(
> > +    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
> > +    unsigned int *page_mask)
> >   {
> >   	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
> >   }
> > diff --git a/mm/gup.c b/mm/gup.c
> > index abcd841d94b7..9fc9271cba8d 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -780,7 +780,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
> >   	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
> >   	 */
> >   	if (is_vm_hugetlb_page(vma))
> > -		return hugetlb_follow_page_mask(vma, address, flags);
> > +		return hugetlb_follow_page_mask(vma, address, flags,
> > +						&ctx->page_mask);
> >   	pgd = pgd_offset(mm, address);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 9a6918c4250a..fbf6a09c0ec4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6454,7 +6454,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
> >   }
> >   struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > -				unsigned long address, unsigned int flags)
> > +				      unsigned long address, unsigned int flags,
> > +				      unsigned int *page_mask)
> >   {
> >   	struct hstate *h = hstate_vma(vma);
> >   	struct mm_struct *mm = vma->vm_mm;
> > @@ -6499,6 +6500,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   			page = NULL;
> >   			goto out;
> >   		}
> > +
> > +		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;
> 
> As discussed, can be simplified. But can be done on top (or not at all, but
> it is confusing code).

Since we decided to make this prettier..  At last I decided to go with this:

		*page_mask = (1U << huge_page_order(h)) - 1;

The previous suggestion of PHYS_PFN() will do two shifts over PAGE_SIZE
(the other one in huge_page_size()) which might be unnecessary, also, PHYS_
can be slightly misleading too as prefix.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

I'll take this with above change, please shoot if not applicable.  Thanks,

-- 
Peter Xu

