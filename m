Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BFC675F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjATVRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:17:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC2B86BC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z3qwBR1dme9ZLOZh/BdaJZP6SjgmfrYQcarF0e5ic9A=; b=ZxXUlCsdh/y0w6ElZl8eI3uddq
        zzz7OABkK4eO5/v1XGNVIGaS0fYe6nH6xrzZA2PMBERmN1uUoYLXBmBPlJ/uzSnPq0lwzuSrqlelD
        o5wGqUVzS1ssbhyafBNuDT8i4MOpb2XpC1b6JrlcYdo5k+FkrGEKD1xch69OiMBDzRUB3ibxb+AIK
        ZEDUy9Ov8qmD/3N/JUt1/trsLlYXF6PWhinKI4Ull8Ed/OC9HY4htzEgHZpvNREw0SXA+iWtO6Eoz
        ruDN0BJ54ilE1kG0lxgwDHA7ssa7HyEhux2H22BAy0PEel6xiWTyR7VXBVM9dWWWXvT8roNVVpqNI
        HlWDGUmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIyl8-002RNk-SW; Fri, 20 Jan 2023 21:17:14 +0000
Date:   Fri, 20 Jan 2023 21:17:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
Subject: Re: [PATCH 4/9] mm/rmap: change hugepage_add_new_anon_rmap to take
 in a folio
Message-ID: <Y8sE2l7EvBPnTCab@casper.infradead.org>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-5-sidhartha.kumar@oracle.com>
 <Y8ot5Y01TWmB4sBj@casper.infradead.org>
 <9c276d01-379f-9bd7-0a7a-6a831b7b4571@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c276d01-379f-9bd7-0a7a-6a831b7b4571@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:45:38PM -0800, Sidhartha Kumar wrote:
> > > @@ -6176,6 +6186,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >   	spinlock_t *ptl;
> > >   	int ret = -ENOMEM;
> > >   	struct page *page;
> > > +	struct folio *folio = NULL;
> > >   	int writable;
> > >   	bool page_in_pagecache = false;
> > > @@ -6251,12 +6262,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >   		*pagep = NULL;
> > >   	}
> > > +	if (page)
> > > +		folio = page_folio(page);
> > > +
> > >   	/*
> > > -	 * The memory barrier inside __SetPageUptodate makes sure that
> > > +	 * The memory barrier inside __folio_mark_uptodate makes sure that
> > >   	 * preceding stores to the page contents become visible before
> > >   	 * the set_pte_at() write.
> > >   	 */
> > > -	__SetPageUptodate(page);
> > > +	__folio_mark_uptodate(folio);
> > 
> 
> Hi Matthew,
> 
> In the snippet:
> 
> page = alloc_huge_page(dst_vma, dst_addr, 0);
> if (IS_ERR(page)) {
> 	put_page(*pagep);
> 	ret = -ENOMEM;
> 	*pagep = NULL;
> 	goto out;
> }
> copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
> 		pages_per_huge_page(h));
> 
> I thought the IS_ERR() call does not handle the NULL case and is a check for
> high memory addresses, and copy_user_huge_page() path does not seem to
> handle the NULL case as well but alloc_huge_page() can possibly return NULL
> so I was unsure about how to handle the folio conversion.

I'm not sure how alloc_huge_page() can return NULL.  It seems like it
returns ERR_PTR(-ENOSPC) or ERR_PTR(-ENOMEM) if it cannot allocate memory?
