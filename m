Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640577303EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbjFNPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbjFNPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677491FE4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686756670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlSsjvlCC2CeUtBnTEzL5Gko2Ykpb9cphhRAoLHObEE=;
        b=Lu2fA/kifYOgKttptOf531QKScOiv42AK+f49RdAcMdYXko8qXDKq+sGstS6sEsdoLAqrR
        G1pUYfb7Ovo3csyXI5PrivhUQZhw/Q4FIbBsOsD/6HXU7gxmvxSQIPSZnOonyDuUOfnOJc
        +7zb4X5bSF1Hugk9+aiXk9dXQjfHbk8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-EY3dvAj0MtS4zDSY35KQQA-1; Wed, 14 Jun 2023 11:31:07 -0400
X-MC-Unique: EY3dvAj0MtS4zDSY35KQQA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76077669a5aso78231685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756666; x=1689348666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlSsjvlCC2CeUtBnTEzL5Gko2Ykpb9cphhRAoLHObEE=;
        b=KXv+dpNOGT3AezLhLm6ynWwGnqGQK5hh3UYcnb33NfRFREGoyhblOkasNrMCs4+/bg
         AHgY10FoztgSRi96jNQ0Zvkfll5KCOZmv7SK5owDlktL+ZePpL2Sj5O2+H7RoKCAxfuw
         QyXxl2ABYhapRgC49BZbVBPg9iVl2w2T8lgtWN9V4WMn9cvssn1Y91j/8PJh6xPTnZSs
         zodxXNpmjHOS/P9amZZy1bDN1sc+95NgEzeug2+CCDxNa9iAtN0ftbMCCEQ7puT3sjYu
         d5rjcmbGwW6JJfkbmePBmMzN/d36Zsi4yzDMxWI1oBno9vKrmLazeUR9BUiPD0XmJteI
         6Dnw==
X-Gm-Message-State: AC+VfDwcZ+R2Gs6m3xRijJgzMY+XX2H+zhq7pQyyiEGSnvLB13af8gUC
        3Vw3xUVz/Q48excEpdZQdPdPMz7LXIunRNpw1418ttG7XFpXByg45v2juQ1twZkWJYk4+3ptqQV
        jlkKGRiIdyeccZdoR9kfDuMd+
X-Received: by 2002:a05:620a:1923:b0:75e:ce67:c665 with SMTP id bj35-20020a05620a192300b0075ece67c665mr19744444qkb.5.1686756665804;
        Wed, 14 Jun 2023 08:31:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SvuLY2mXLOR8xhs4uAme+H5cjdmkliDikMBK1xmNVk1vvvRxU2pKzRVol5pZEqIR5hHYN5w==
X-Received: by 2002:a05:620a:1923:b0:75e:ce67:c665 with SMTP id bj35-20020a05620a192300b0075ece67c665mr19744420qkb.5.1686756665467;
        Wed, 14 Jun 2023 08:31:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id m2-20020ae9f202000000b00761fae866c7sm980408qkg.76.2023.06.14.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:31:04 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:31:03 -0400
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
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Message-ID: <ZIndN9isc4pTp2zK@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
 <ZInYh3cVUil9R/cf@x1n>
 <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:17:13PM +0200, David Hildenbrand wrote:
> On 14.06.23 17:11, Peter Xu wrote:
> > On Wed, Jun 14, 2023 at 04:57:37PM +0200, David Hildenbrand wrote:
> > > On 13.06.23 23:53, Peter Xu wrote:
> > > > It's coming, not yet, but soon.  Loose the restriction.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    mm/hugetlb.c | 7 -------
> > > >    1 file changed, 7 deletions(-)
> > > > 
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > > index f037eaf9d819..31d8f18bc2e4 100644
> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -6467,13 +6467,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> > > >    	spinlock_t *ptl;
> > > >    	pte_t *pte, entry;
> > > > -	/*
> > > > -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> > > > -	 * follow_hugetlb_page().
> > > > -	 */
> > > > -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> > > > -		return NULL;
> > > > -
> > > >    	hugetlb_vma_lock_read(vma);
> > > >    	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
> > > >    	if (!pte)
> > > Did you fix why the warning was placed there in the first place? (IIRC, at
> > > least unsharing support needs to be added, maybe more)
> > 
> > Feel free to have a look at patch 2 - it should be done there, hopefully in
> > the right way.  And IIUC it could be a bug to not do that before (besides
> > CoR there was also the pgtable permission checks that was missing).  More
> > details in patch 2's commit message.  Thanks,
> 
> Oh, that slipped my eyes (unsharing is not really a permission check) -- and

I think it is still a "permission check"?  It means, we forbid anyone R/O
taking the page if it's not exclusively owned, just like we forbid anyone
RW taking the page if it's not writable?

It's just that the permission check only applies to PIN which follow_page()
doesn't yet care, so it won't ever trigger.

> the patch description could have been more explicit about why we can now
> lift the restrictions.
> 
> For the records: we don't use CoR terminology upstream. As suggested by
> John, we use "GUP-triggered unsharing".

Sure.

> 
> As unsharing only applies to FOLL_PIN, it doesn't quite fit into patch #2.
> Either move that to this patch or squash both.

Sure, no strong opinions here.

The plan is _if_ someone wants to backport patch 2, this patch should not
be part of it.  But then maybe it makes more sense to move the CoR change
there into this one, not because "it's not permission check", but because
CoR is not relevant in follow_page(), so not relevant to a backport.

-- 
Peter Xu

