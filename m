Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828B8737129
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjFTQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFTQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7BE6E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687277058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3LcOrS6cknEcAz4IzFsrfkY0KBDg1wCLzWoEd8Eb3Y4=;
        b=JI2iDcaqhzUp+vOEoyo3GVVMfO0Pf2fCJGc6OJnXjAk2nDwokWVgch0TzPToN1AhZvYXjB
        QFd0sv3Lk2yGbRFIVA77t0+aBeVCzOpJYIQmNsdEfyjxNTeZbuvs3MrRuk4x6kdHeCjvPw
        PYRy4L298s3+MPszyxzKmOjxTq7UUq0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-EHFe4ijyPaClMgGFU--oxA-1; Tue, 20 Jun 2023 12:03:31 -0400
X-MC-Unique: EHFe4ijyPaClMgGFU--oxA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-471cd52f621so110834e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276995; x=1689868995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LcOrS6cknEcAz4IzFsrfkY0KBDg1wCLzWoEd8Eb3Y4=;
        b=ZYlOcftL99b13zBw8TdAYzsBAVrIZth+10TD/bhS1dsGHV6aceVtlzjmfgdG2jHNGT
         T9gwpusRas5lLrD+kAHTi27jGUYSWujfK5sPe5dZ3Z4GJZuggXYxwEWNEz9pz0JRG9je
         PsoVpmz+Nzer3PhwRLOwiHvhkU15uKQDbyixYwrbDZUfgHAYidVKepmUyv5K7dXfkh4z
         3q+CJR0qzvOF8H0H0SX/Qifv7TTZjVwkuTPLXNUicqvOZogQG+btH0cz152/sw1cOkdP
         mOyRaMKlVVxpekdYyZoHZHsoESKs7KINltqZFh94CAEd8owq4FbwNywK+NVc2OV/PW9G
         i5cA==
X-Gm-Message-State: AC+VfDylc6+DiDeztVq6AGDReLxJcPE9AHGUWZns8bBDipYr39fTW5R+
        7kDe7v1j6XeMNwCpAmmbm0a7k80Gcm9GSDzsP7dkXrQ+Sqc1PeRkxyICtIRFbOOtVYe42EzCawd
        GYf+Q1DsuDmh0wKu6DJGnSWUO
X-Received: by 2002:a67:c410:0:b0:440:afb0:2d3c with SMTP id c16-20020a67c410000000b00440afb02d3cmr2469003vsk.2.1687276994982;
        Tue, 20 Jun 2023 09:03:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RNYw1RaqvJfK03dNilpUmT/+OXHmI9rtvkJOktQOIrKg7RJTysHreFAJhaFScS2g631BngA==
X-Received: by 2002:a67:c410:0:b0:440:afb0:2d3c with SMTP id c16-20020a67c410000000b00440afb02d3cmr2468990vsk.2.1687276994718;
        Tue, 20 Jun 2023 09:03:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cdf05000000b00630c0ed6339sm1362675qvl.64.2023.06.20.09.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:03:14 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:03:12 -0400
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
Subject: Re: [PATCH v2 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask()
 for FOLL_PIN
Message-ID: <ZJHNwE+YKcOMCIpT@x1n>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-3-peterx@redhat.com>
 <c77f6aeb-ddfc-3b46-55f4-aff7cf40e6b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c77f6aeb-ddfc-3b46-55f4-aff7cf40e6b9@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:22:02PM +0200, David Hildenbrand wrote:
> On 20.06.23 01:10, Peter Xu wrote:
> > follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
> > target of FOLL_WRITE either.  However add the checks.
> > 
> > Namely, either the need to CoW due to missing write bit, or proper CoR on
> 
> s/CoR/unsharing/
> 
> > !AnonExclusive pages over R/O pins to reject the follow page.  That brings
> > this function closer to follow_hugetlb_page().
> > 
> > So we don't care before, and also for now.  But we'll care if we switch
> > over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
> > return -EMLINK properly, as that's the gup internal api to mean "we should
> > do CoR".  Not really needed for follow page path, though.
> 
> "we should unshare".
> 
> > 
> > When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> > clear that it just should never fail.
> > 
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/hugetlb.c | 24 +++++++++++++++---------
> >   1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f75f5e78ff0b..9a6918c4250a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6463,13 +6463,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   	spinlock_t *ptl;
> >   	pte_t *pte, entry;
> > -	/*
> > -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> > -	 * follow_hugetlb_page().
> > -	 */
> > -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> > -		return NULL;
> > -
> >   	hugetlb_vma_lock_read(vma);
> >   	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
> >   	if (!pte)
> > @@ -6478,8 +6471,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   	ptl = huge_pte_lock(h, mm, pte);
> >   	entry = huge_ptep_get(pte);
> >   	if (pte_present(entry)) {
> > -		page = pte_page(entry) +
> > -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> > +		page = pte_page(entry);
> > +
> > +		if (gup_must_unshare(vma, flags, page)) {
> 
> All other callers (like follow_page_pte(), including
> __follow_hugetlb_must_fault())
> 
> (a) check for write permissions first.
> 
> (b) check for gup_must_unshare() only if !pte_write(entry)
> 
> I'd vote to keep these checks as similar as possible to the other GUP code.

I'm pretty sure the order doesn't matter here since one for read and one
for write.. but sure I can switch the order.

> 
> > +			/* Tell the caller to do Copy-On-Read */
> 
> "Tell the caller to unshare".
> 
> > +			page = ERR_PTR(-EMLINK);
> > +			goto out;
> > +		}
> > +
> > +		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
> > +			page = NULL;
> > +			goto out;
> > +		}
> 
> 
> I'm confused about pte_write() vs. huge_pte_write(), and I don't know what's
> right or wrong here.

AFAICT, they should always be identical in code. But yeah.. I should just
use the huge_ version.

Thanks,

-- 
Peter Xu

