Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69CA737166
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFTQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFTQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C74C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687278241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkfPb81x8lQ4BDOiIbrDPIMFlQfa70cNVIYaWHHcOPc=;
        b=HH6ek0fIXhNpvydiM7VpwMX3OWQOr0hr55Ej5DqLDPL40nVz3JCCEgvOCE9+XJACORthDV
        yUtYQ6vK6pEYuIiZfjn3z94IzWEraEKYGWWekjtEPHkzudFvPiB0hX9Ohni0Zfm6W67Mzw
        OxAxiEtmxUQlt3u4iDDN1XZtyGXV3AU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-1__iazb0OQ2qMrIxc371CA-1; Tue, 20 Jun 2023 12:23:58 -0400
X-MC-Unique: 1__iazb0OQ2qMrIxc371CA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62849c5e9f0so7635156d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278237; x=1689870237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkfPb81x8lQ4BDOiIbrDPIMFlQfa70cNVIYaWHHcOPc=;
        b=IhhV4ZHasqmNvnyHDR2wSTonk+JJkwP0/jZOdtYuiv4eJu1M5oZyng0RA/ANTyyQ/i
         eQJV80GwMFraijiLSruXW9HaHHz218QO3NeYPOId3AwL1YlMVXBmNeZuPcoDCW0bxP8z
         VlMavbQgST+ZuxhDqWOiDrK+G7LLJWrYX/AHOIK25wJBMgW6Jk0wjxmi/wPXZMck5IRF
         yvd1AzyNUKKRqYjkqrAYDPwLqc4NZUexy50d9qr3+dzskmFGTOGpRep11BKNrRIVF+9J
         8+w7spkS1H5o74ztZAIEQd0T1tWbhbnSy7qYDfc/1As4akKT4wYqODIH5gURChWz6ING
         g7xA==
X-Gm-Message-State: AC+VfDz54GE07XuiPPrmAC4kWoRf9O17i6BPBBi5/fdfF3d6Gu0/dmAk
        guMx6Y4PW8ON4qLf73GZ9rxGpor0cEVpJ+D8Nh2QLPktmY+3DtS/cnO8ueGpd/w9k40HXw9w5FV
        Jbj/9OcfwyeX5aChTZwGzRU7Z
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id kc28-20020a056214411c00b0062df62b0907mr16609599qvb.0.1687278237408;
        Tue, 20 Jun 2023 09:23:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ562mP7vivYVjBC2Ee6xsjKs0n5SEqb0Mareafy6oOvsh/uQz9MO5aQRwdB7fCi+rCy/Ai9eQ==
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id kc28-20020a056214411c00b0062df62b0907mr16609588qvb.0.1687278237142;
        Tue, 20 Jun 2023 09:23:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t2-20020a0cde02000000b0062dd9254429sm1358895qvk.142.2023.06.20.09.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:23:56 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:23:55 -0400
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
Subject: Re: [PATCH v2 5/8] mm/gup: Accelerate thp gup even for "pages !=
 NULL"
Message-ID: <ZJHSm/UbEy3JndZ4@x1n>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-6-peterx@redhat.com>
 <02a057a3-3d9e-4013-8762-25ceb1beec86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02a057a3-3d9e-4013-8762-25ceb1beec86@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:43:35PM +0200, David Hildenbrand wrote:
> On 20.06.23 01:10, Peter Xu wrote:
> > The acceleration of THP was done with ctx.page_mask, however it'll be
> > ignored if **pages is non-NULL.
> > 
> > The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
> > accelerate mm_populate() treatment of THP pages").  It didn't explain why
> > we can't optimize the **pages non-NULL case.  It's possible that at that
> > time the major goal was for mm_populate() which should be enough back then.
> 
> In the past we had these sub-page refcounts for THP. My best guess (and I
> didn't check if that was still the case in 2013) would be that it was
> simpler regarding refcount handling to to do it one-subpage at a time.
> 
> But I might be just wrong.
> 
> > 
> > Optimize thp for all cases, by properly looping over each subpage, doing
> > cache flushes, and boost refcounts / pincounts where needed in one go.
> > 
> > This can be verified using gup_test below:
> > 
> >    # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10
> > 
> > Before:    13992.50 ( +-8.75%)
> > After:       378.50 (+-69.62%)
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
> >   1 file changed, 44 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 4a00d609033e..b50272012e49 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1199,16 +1199,53 @@ static long __get_user_pages(struct mm_struct *mm,
> >   			goto out;
> >   		}
> >   next_page:
> > -		if (pages) {
> > -			pages[i] = page;
> > -			flush_anon_page(vma, page, start);
> > -			flush_dcache_page(page);
> > -			ctx.page_mask = 0;
> > -		}
> > -
> >   		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
> >   		if (page_increm > nr_pages)
> >   			page_increm = nr_pages;
> > +
> > +		if (pages) {
> > +			struct page *subpage;
> > +			unsigned int j;
> > +
> > +			/*
> > +			 * This must be a large folio (and doesn't need to
> > +			 * be the whole folio; it can be part of it), do
> > +			 * the refcount work for all the subpages too.
> > +			 *
> > +			 * NOTE: here the page may not be the head page
> > +			 * e.g. when start addr is not thp-size aligned.
> > +			 * try_grab_folio() should have taken care of tail
> > +			 * pages.
> > +			 */
> > +			if (page_increm > 1) {
> > +				struct folio *folio;
> > +
> > +				/*
> > +				 * Since we already hold refcount on the
> > +				 * large folio, this should never fail.
> > +				 */
> > +				folio = try_grab_folio(page, page_increm - 1,
> > +						       foll_flags);
> > +				if (WARN_ON_ONCE(!folio)) {
> > +					/*
> > +					 * Release the 1st page ref if the
> > +					 * folio is problematic, fail hard.
> > +					 */
> > +					gup_put_folio(page_folio(page), 1,
> > +						      foll_flags);
> > +					ret = -EFAULT;
> > +					goto out;
> > +				}
> > +			}
> > +
> > +			for (j = 0; j < page_increm; j++) {
> > +				subpage = nth_page(page, j);
> > +				pages[i+j] = subpage;
> 
> Doe checkpatch like pages[i+j]? I'd have used spaces around the +.

Can do.

> 
> > +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
> > +				flush_dcache_page(subpage);
> > +			}
> > +		}
> > +
> >   		i += page_increm;
> >   		start += page_increm * PAGE_SIZE;
> >   		nr_pages -= page_increm;
> 
> 
> So, we did the first try_grab_folio() while our page was PMD-mapped udner
> the PT lock and we had sufficient permissions (e.g., mapped writable, no
> unsharing required). With FOLL_PIN, we incremented the pincount.
> 
> 
> I was wondering if something could have happened ever since we unlocked the
> PT table lock and possibly PTE-mapped the THP. ... but as it's already
> pinned, it cannot get shared during fork() [will stay exclusive].
> 
> So we can just take additional pins on that folio.
> 
> 
> LGTM, although I do like the GUP-fast way of recording+ref'ing it at a
> central place (see gup_huge_pmd() with record_subpages() and friends), not
> after the effects.

My read on this is follow_page_mask() is also used in follow page, which
does not need page*.

No strong opinion here. Maybe we leave this as a follow up even if it can
be justified?  This patch is probably still the smallest (and still clean)
change to speed this whole thing up over either thp or hugetlb.

-- 
Peter Xu

