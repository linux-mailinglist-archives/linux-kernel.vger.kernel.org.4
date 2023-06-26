Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BA73E4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFZQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFZQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE22107
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687796586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igMfXFR5kNoI10TQDurWKUzwN6Z45JekZK2Q72EILNo=;
        b=GaDyr3cVu1DNKsQ8pqoXBjwzdBQgtkJsV/H4MtFLVgjE1uzKebyqeODdCoT8GTs97WtG4B
        6r1y21BMTtOqHUB+eW9sWEPF3Nve2ZIss0CTkzxwtoEbXjk5k+xNllZYXguX4uWx7Rafvb
        L4Vbmgfyy9XqGQ/9rNvMQWA7l7dMGOQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-t9xs6tmKORif65ww_Ke-bA-1; Mon, 26 Jun 2023 12:23:03 -0400
X-MC-Unique: t9xs6tmKORif65ww_Ke-bA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62ffa1214edso6296736d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796582; x=1690388582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igMfXFR5kNoI10TQDurWKUzwN6Z45JekZK2Q72EILNo=;
        b=P7ZwJhmf+u1xy1vlxTCIUimGX80E0UmCBvpL5m9OQ0b6fqrF8kEh2UbKdO8Kvrcrhj
         cI3tkbWUdV/StqTcSn7/QYkJyX/3dxoxoj083qV36rJlBOgTh/f5RAOygXWYmuJdI08g
         s50GPIpBYvISrinw4ZwswrnGh13V8zh+wdigonIuAMeOtHUwPixQ1uCPcZHM+GAoTKs3
         64dB6T9rwzG7nSfCqJ8UXqF2ty2WWTCw7Vzbv8JTJImsborF9uk7fCSPMsBxOnC0OyZJ
         ZpELx6WG4kj+YfcHj7/xQk+onQv0sYb1gsub0R3OB5GL288CUON/S6EPM6NDv4ZvZfuj
         ASxg==
X-Gm-Message-State: AC+VfDzBYeFwAqHp0AB4zwGMTp3C/qr6Dj9ClWjFn+bh1D6kmqO9xTfN
        Yvg41n/u33fEI1dOyRoR+o1tAveENcO9kI0CG9ZE/lmlmkCGC9lOjidq13zm0brYB6+YzzP6Uux
        ZJ6X41kBkNn9/eg9c4L/12TLw48KBJI/5
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr36132629qvb.3.1687796582595;
        Mon, 26 Jun 2023 09:23:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oVBR2URFNF062kj36ByRSo63M2eJzjnhcU1VZ6ZJnCR3z2r+9LNb0CCEiOx2Y22cP34jYBA==
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr36132612qvb.3.1687796582255;
        Mon, 26 Jun 2023 09:23:02 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f19-20020ae9ea13000000b007592174cb08sm2864932qkg.10.2023.06.26.09.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:23:01 -0700 (PDT)
Date:   Mon, 26 Jun 2023 12:23:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask()
 for FOLL_PIN
Message-ID: <ZJm7ZMdo7+G541wG@x1n>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-3-peterx@redhat.com>
 <89fee4bf-29a1-db19-e0ae-dd827d277504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89fee4bf-29a1-db19-e0ae-dd827d277504@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:06:24AM +0200, David Hildenbrand wrote:
> On 23.06.23 16:29, Peter Xu wrote:
> > follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
> > target of FOLL_WRITE either.  However add the checks.
> > 
> > Namely, either the need to CoW due to missing write bit, or proper
> > unsharing on !AnonExclusive pages over R/O pins to reject the follow page.
> > That brings this function closer to follow_hugetlb_page().
> > 
> > So we don't care before, and also for now.  But we'll care if we switch
> > over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
> > return -EMLINK properly, as that's the gup internal api to mean "we should
> > unshare".  Not really needed for follow page path, though.
> > 
> > When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> > clear that it just should never fail.  When error happens, instead of
> > setting page==NULL, capture the errno instead.
> > 
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/hugetlb.c | 31 ++++++++++++++++++++-----------
> >   1 file changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f75f5e78ff0b..27367edf5c72 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6462,13 +6462,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   	struct page *page = NULL;
> >   	spinlock_t *ptl;
> >   	pte_t *pte, entry;
> > -
> > -	/*
> > -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> > -	 * follow_hugetlb_page().
> > -	 */
> > -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> > -		return NULL;
> > +	int ret;
> >   	hugetlb_vma_lock_read(vma);
> >   	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
> > @@ -6478,8 +6472,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> >   	ptl = huge_pte_lock(h, mm, pte);
> >   	entry = huge_ptep_get(pte);
> >   	if (pte_present(entry)) {
> > -		page = pte_page(entry) +
> > -				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> > +		page = pte_page(entry);
> > +
> > +		if ((flags & FOLL_WRITE) && !huge_pte_write(entry)) {
> > +			page = NULL;
> > +			goto out;
> > +		}
> > +
> > +		if (gup_must_unshare(vma, flags, page)) {
> > +			/* Tell the caller to do unsharing */
> > +			page = ERR_PTR(-EMLINK);
> > +			goto out;
> > +		}
> 
> 
> No need to check if the page is writable (like all other callers and as
> gup_must_unshare() documents -- "for which pages that are write-protected in
> the page table")
> 
> if (!huge_pte_write(entry) && gup_must_unshare(vma, flags, page)) {

Sure.

I was wondering whether we should just allow passing in "write" into
gup_must_unshare(), it'll just be a bit weird that it'll return false
directly if write, meanwhile hopefully that makes it easier to be
consistent.  I'll leave that as-is for now, anyway.

For this one I'll just merge it into:

		if (!huge_pte_write(entry)) {
			if (flags & FOLL_WRITE) {
				page = NULL;
				goto out;
			}

			if (gup_must_unshare(vma, flags, page)) {
				/* Tell the caller to do unsharing */
				page = ERR_PTR(-EMLINK);
				goto out;
			}
		}

> 
> 
> With that
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu

