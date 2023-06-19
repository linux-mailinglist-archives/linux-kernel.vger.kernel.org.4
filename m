Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279A1735DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFSTiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFSTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D0106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687203457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tl6PHbc+VyYybGOhiv2rCh7kHt25l23EfmA39lRewBs=;
        b=QX7U9x2bpKEp6A38t/CIUmQvut0vGIo/wqY6KKMd3yzC6c4j9NzA8uIgaMexN+Yo17icCw
        P8KlpMFNnRKwUZ9gILIkZzfge0H1+kRNqDwRUCL8BrWtJn9b1jucdAj6bxwIN9u0UsHb2z
        41qJwG/wBKbnh9bWHELXibW7b3EVNk4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-2dqP3yp2N5G_baN2X2EUiA-1; Mon, 19 Jun 2023 15:37:36 -0400
X-MC-Unique: 2dqP3yp2N5G_baN2X2EUiA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7606a134623so60933685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203455; x=1689795455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl6PHbc+VyYybGOhiv2rCh7kHt25l23EfmA39lRewBs=;
        b=DrYRUksMIyNRXkmoiO/tNOrs9dl2IOS63TKyejHEf1kHCvaLZH82650ekJszFRXvP2
         riHvEOJ404PaApGMzzqrDgKcfQcqt8FRKifsNUBVl9PKlQL/XE3ZDf89pLE1EXO4ERD3
         jxZKGxwqbRf/+RDHsoxCXfxX5D5vBUx8a5xKoqLyaB+cIxymATVt1mDOnFbH37G+O5tC
         z2kFpOObRAQiQ6uk6DZXmCsZ8T/u4DsGb/Ut5F1NvzVWbowbPlSPA+Mg4woRX4EIq5+B
         HRHnoo6Xd1SwNksXQ3DTMBYnU3L/NaI/1Lkq5QLp0jnsB+iSvHhZ4ebOpl7AEtYXZmXK
         yQcQ==
X-Gm-Message-State: AC+VfDwAaop29cyiDjQV82ID4YJhuq98Nvz9g64TD0LzR8l0zfMdyJ87
        dwWY2UF8pwkKPZk5PVBno4LZNaVUCLuqkZHSe6Z+heFofmkRuP19UPVS+3KcoimTB7DS4Lx8vHT
        f8gK+OnglOO0ByPuYTFpP6oY5nqJ3HxLt
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr13121859qvb.2.1687203455489;
        Mon, 19 Jun 2023 12:37:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vycr93q9nZDfE7eqifHLn7LWkIsJW1lnFzitjV/i0b+6uSxUhyWoTVcx9J4AH10Kuev/zPQ==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr13121850qvb.2.1687203455193;
        Mon, 19 Jun 2023 12:37:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f19-20020a0cf3d3000000b005fdbcab3065sm280254qvm.72.2023.06.19.12.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:37:34 -0700 (PDT)
Date:   Mon, 19 Jun 2023 15:37:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 6/7] mm/gup: Accelerate thp gup even for "pages != NULL"
Message-ID: <ZJCuepgy3+66S03G@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-7-peterx@redhat.com>
 <d8c76484-1030-44a3-b148-7e69fa84243a@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8c76484-1030-44a3-b148-7e69fa84243a@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:27:22PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jun 13, 2023 at 05:53:45PM -0400, Peter Xu wrote:
> > The acceleration of THP was done with ctx.page_mask, however it'll be
> > ignored if **pages is non-NULL.
> >
> > The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
> > accelerate mm_populate() treatment of THP pages").  It didn't explain why
> > we can't optimize the **pages non-NULL case.  It's possible that at that
> > time the major goal was for mm_populate() which should be enough back then.
> >
> > Optimize thp for all cases, by properly looping over each subpage, doing
> > cache flushes, and boost refcounts / pincounts where needed in one go.
> >
> > This can be verified using gup_test below:
> >
> >   # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10
> >
> > Before:    13992.50 ( +-8.75%)
> > After:       378.50 (+-69.62%)
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/gup.c | 36 +++++++++++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index a2d1b3c4b104..cdabc8ea783b 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1210,16 +1210,38 @@ static long __get_user_pages(struct mm_struct *mm,
> >  			goto out;
> >  		}
> >  next_page:
> > -		if (pages) {
> > -			pages[i] = page;
> > -			flush_anon_page(vma, page, start);
> > -			flush_dcache_page(page);
> > -			ctx.page_mask = 0;
> > -		}
> > -
> >  		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
> >  		if (page_increm > nr_pages)
> >  			page_increm = nr_pages;
> > +
> > +		if (pages) {
> > +			struct page *subpage;
> > +			unsigned int j;
> > +
> > +			/*
> > +			 * This must be a large folio (and doesn't need to
> > +			 * be the whole folio; it can be part of it), do
> > +			 * the refcount work for all the subpages too.
> > +			 * Since we already hold refcount on the head page,
> > +			 * it should never fail.
> > +			 *
> > +			 * NOTE: here the page may not be the head page
> > +			 * e.g. when start addr is not thp-size aligned.
> > +			 */
> > +			if (page_increm > 1)
> > +				WARN_ON_ONCE(
> > +				    try_grab_folio(compound_head(page),
> > +						   page_increm - 1,
> > +						   foll_flags) == NULL);
> 
> I'm not sure this should be warning but otherwise ignoring this returning
> NULL?  This feels like a case that could come up in realtiy,
> e.g. folio_ref_try_add_rcu() fails, or !folio_is_longterm_pinnable().

Note that we hold already at least 1 refcount on the folio (also mentioned
in the comment above this chunk of code), so both folio_ref_try_add_rcu()
and folio_is_longterm_pinnable() should already have been called on the
same folio and passed.  If it will fail it should have already, afaict.

I still don't see how that would trigger if the refcount won't overflow.

Here what I can do is still guard this try_grab_folio() and fail the GUP if
for any reason it failed.  Perhaps then it means I'll also keep that one
untouched in hugetlb_follow_page_mask() too.  But I suppose keeping the
WARN_ON_ONCE() seems still proper.

Thanks,

-- 
Peter Xu

