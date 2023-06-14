Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF7730420
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjFNPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjFNPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D622979
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686757593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhKKsDrj5NxG0kmdQxhpTPAVWRUsLQsIGYXNIq74kdI=;
        b=bpuETZfF1sYMM0TYeZ87iqTeNPGHiPaDRl5TJqCWgPSHOvZTUFfdep1kS/JVm7iUSrgNt4
        aWRJ0JB1l/M02xiWwQ+wY7iURbUukSOzKweZeX00TIcE2QGOlDIyACYw/JsGdfMXQEos9x
        HbemPqeCtYIS+ApkeVV5Mtskr3jtjRA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-pCrczpm8NbWV4dLcngMPGw-1; Wed, 14 Jun 2023 11:46:32 -0400
X-MC-Unique: pCrczpm8NbWV4dLcngMPGw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f8283a3a7aso15558081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757592; x=1689349592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhKKsDrj5NxG0kmdQxhpTPAVWRUsLQsIGYXNIq74kdI=;
        b=fEpFeo1DDVoNoXaYZtvz4/qmodXkQfcHj7RaLGOBbrF0pS5VkUoW3rUSUpLJbPaD7s
         s+4ykgR7x6OonBCckV94UEC/GrV36Q0P5Eo+QCyLJD00EEIpbhhhmAVqo9vE/fngB7gP
         g7YGuelcXAe6UO4lPkMfeisMvk/TYZdMY2GoNldxhEzYbLcbvKsd/aXkwWL+RfBK+hz9
         tQ6/F1ioZs7vMq66mbfeIEEhe2/kPGrEVyHWbbLbFtsq/N0BML+JOP9Ao09GUe8wXst3
         zDVpva4sgCYnWlVJat8Z8I/8t5twCJTb9HqtSQrldkWdeR0mPCzoWoT1Hxu9q/sOELsC
         PSSA==
X-Gm-Message-State: AC+VfDwi2biIlBQJM9t/oE2Gq+y9eqqhSi2UhabFaGYzEQ3La9897eqn
        zSCQn+btcoSGXiyRqcXDdtg8vgZtFlTD0xq6ENOc3tcFEMU+vreDyb4eqxb+G58RyQ3k2R0ErDo
        8yqTPqC2SfbhxgJl0PcAfIzpo
X-Received: by 2002:a05:622a:253:b0:3f9:aa64:7dab with SMTP id c19-20020a05622a025300b003f9aa647dabmr19576245qtx.6.1686757591897;
        Wed, 14 Jun 2023 08:46:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NwlNl6Akhvm2MhXCy1HxMJsM1KyCbNtghJVerchCD0v7n3q2L6EQJ6+NPG0PruSvzN2hRFA==
X-Received: by 2002:a05:622a:253:b0:3f9:aa64:7dab with SMTP id c19-20020a05622a025300b003f9aa647dabmr19576225qtx.6.1686757591551;
        Wed, 14 Jun 2023 08:46:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i6-20020ac84886000000b003f6bbd7863csm5091748qtq.86.2023.06.14.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:46:30 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:46:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 2/7] mm/hugetlb: Fix hugetlb_follow_page_mask() on
 permission checks
Message-ID: <ZIng1SQ0xZ+eBua8@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-3-peterx@redhat.com>
 <24bc512a-b5c2-b7ea-fa83-5752cec7455b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24bc512a-b5c2-b7ea-fa83-5752cec7455b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:31:36PM +0200, David Hildenbrand wrote:
> On 13.06.23 23:53, Peter Xu wrote:
> > It seems hugetlb_follow_page_mask() was missing permission checks.  For
> > example, one follow_page() can get the hugetlb page with FOLL_WRITE even if
> > the page is read-only.
> 
> I'm curious if there even is a follow_page() user that operates on hugetlb
> ...
> 
> s390x secure storage does not apply to hugetlb IIRC.

You're the expert, so I'll rely on you. :)

> 
> ksm.c? no.
> 
> huge_memory.c ? no
> 
> So what remains is most probably mm/migrate.c, which never sets FOLL_WRITE.
> 
> Or am I missing something a user?

Yes, non of the rest are with WRITE.

Then I assume no fixes /backport needed at all (which is what this patch
already does).  It's purely to be prepared only.  I'll mention that in the
new version.

Thanks,

> 
> >  > And it wasn't there even in the old follow_page_mask(), where we can
> > reference from before commit 57a196a58421 ("hugetlb: simplify hugetlb
> > handling in follow_page_mask").
> > 
> > Let's add them, namely, either the need to CoW due to missing write bit, or
> > proper CoR on !AnonExclusive pages over R/O pins to reject the follow page.
> > That brings this function closer to follow_hugetlb_page().
> > 
> > I just doubt how many of us care for that, for FOLL_PIN follow_page doesn't
> > really happen at all.  But we'll care, and care more if we switch over
> > slow-gup to use hugetlb_follow_page_mask().  We'll also care when to return
> > -EMLINK then, as that's the gup internal api to mean "we should do CoR".
> > 
> > When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> > clear that it just should never fail.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/hugetlb.c | 22 ++++++++++++++++------
> >   1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 82dfdd96db4c..9c261921b2cf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6481,8 +6481,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   	ptl = huge_pte_lock(h, mm, pte);
> >   	entry = huge_ptep_get(pte);
> >   	if (pte_present(entry)) {
> > -		page = pte_page(entry) +
> > -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> > +		page = pte_page(entry);
> > +
> > +		if (gup_must_unshare(vma, flags, page)) {
> > +			/* Tell the caller to do Copy-On-Read */
> > +			page = ERR_PTR(-EMLINK);
> > +			goto out;
> > +		}
> > +
> > +		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
> > +			page = NULL;
> > +			goto out;
> > +		}
> > +
> > +		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> > +
> >   		/*
> >   		 * Note that page may be a sub-page, and with vmemmap
> >   		 * optimizations the page struct may be read only.
> > @@ -6492,10 +6505,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   		 * try_grab_page() should always be able to get the page here,
> >   		 * because we hold the ptl lock and have verified pte_present().
> >   		 */
> > -		if (try_grab_page(page, flags)) {
> > -			page = NULL;
> > -			goto out;
> > -		}
> > +		WARN_ON_ONCE(try_grab_page(page, flags));
> >   	}
> >   out:
> >   	spin_unlock(ptl);
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu

