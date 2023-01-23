Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE08E67805A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjAWPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjAWPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:48:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D811EA9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KFAbC6/LnUvhZt2KUIpbaDNLUdiCloSuFSNDg9tXQCg=; b=s7Az+tKooxnLkQ/AMW4/LRGZmh
        hI6KbpM+sJzFESK7oBd+4KtibzqEg0r7zsWPPKroNyV038yFtHBqNLYmg+kh8Lsbc1hVSZBZTOps3
        CRHxyQTGmAUDU84tqz7wTIUe9KA8kZxmR5VwFz9k2x9+X22REj+3dnrHotCr6Tw0sWJUszx47Zus5
        3O1CWDPO5qSoJWXj5B06oeLfAgXg2SWeTQEwC7c3wNGambyIkbSQt8iIkAWdav4ql7q6dCo/97FKK
        KjP+nnVA+0c63lN5Ndo9kILtTMfEQ2+yYQfjbNcLzIV3gsph8S+wRXF4muW5IDtvs9UHK45hJ1V/R
        IyFoJEZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJz3W-004L3V-By; Mon, 23 Jan 2023 15:48:22 +0000
Date:   Mon, 23 Jan 2023 15:48:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/migrate: Convert isolate_movable_page() to use
 folios
Message-ID: <Y86sRiKAAOz2myNe@casper.infradead.org>
References: <20230121005622.57808-1-vishal.moola@gmail.com>
 <20230121005622.57808-3-vishal.moola@gmail.com>
 <Y80wKtc22eHApjEN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y80wKtc22eHApjEN@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 12:46:34PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 20, 2023 at 04:56:21PM -0800, Vishal Moola (Oracle) wrote:
> >  int isolate_movable_page(struct page *page, isolate_mode_t mode)
> >  {
> > +	struct folio *folio = page_folio(page);
> >  	const struct movable_operations *mops;
> >  
> >  	/*
> > @@ -71,11 +72,11 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
> >  	 * the put_page() at the end of this block will take care of
> >  	 * release this page, thus avoiding a nasty leakage.
> >  	 */
> > -	if (unlikely(!get_page_unless_zero(page)))
> > +	if (unlikely(!folio_try_get(folio)))
> 
> This changes behaviour.  Previously when called on a tail page, the
> call failed.  Now it succeeds, getting a ref on something that at
> least was the folio head at some point.
> 
> If you're going to do this, you need to recheck that the page is still
> part of the folio after getting the ref (see gup.c for an example).
> But I think we should probably maintain the behaviour of failing on
> tail pages.
> 
> Maybe something like ...
> 
> 	if (unlikely(!get_page_unless_zero(page)))
> 		goto out;
> 	/* Refcount is zero on tail pages, so we must have a head */
> 	folio = (struct folio *)page;

I've been thinking about this some more as I don't like doing these
kinds of casts (except in the helper functions).  What do you think
to adding:

struct folio *folio_get_nontail_page(struct page *)
{
	if unlikely(!get_page_unless_zero(page))
		return NULL;
	return (struct folio *)page;
}

and then isolate_movable_page() looks like:

	struct folio *folio;
[...]

	folio = folio_get_nontail_page(page);
	if (!folio)
		goto out;

I keep thinking about how this is all going to work when we get to
one-pointer-per-page.  Telling tail pages from head pages becomes hard.
This probably becomes an out-of-line function that looks something like ..

	struct memdesc *memdesc = READ_ONCE(page->memdesc);
	struct folio *folio;

	if (!memdesc_is_folio(memdesc))
		return NULL;
	folio = memdesc_folio(memdesc);
	if (!folio_try_get(folio))
		return NULL;
	if (READ_ONCE(page->memdesc) != memdesc ||
	    folio->pfn != page_pfn(page)) {
		folio_put(folio);
		return NULL;
	}

	return folio;

(note: We need to check that page->memdesc still points to this folio after 
getting the refcount on it.  we could loop around if it fails, but
failing the entire get is OK; if memdesc changed then either before this
function was called, after this function was called or while this
function was called, the refcount on the memdesc it was pointing to
was zero)
