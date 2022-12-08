Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2858964763E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLHTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:33:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D0A66C8A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=O5Q6FwLPWf/ojE4bErGewZWkACboNhaOT79XbgwFx/M=; b=S50po2I/E6Oec6KqCzMeN8/b8H
        sovQ29kkwnDLIDABM1CAzrokg1hirN+B4O0d1XsY9aFCZppvKUwZP4CXJ2eCtYL1i7D0+/wcbKj9h
        d+5YEt4PxdOr4fIyGvm/zgwelfRRFj9gnKAIxVVnrEWH0EU5SlDfbG5aadyXKR0ek4o4ZFa+qg0E3
        bVcNkHofAbi5eqUO1W4jdv2cWBC8Eu9YnRhGs5Y5obaHWGckt3+1fdm3OFWozizeE+PaVIWNQbX+/
        1OCNZUg2c33pbjzM3i51WlDtgrlIB2nCnU5G7Djv6RxScYO9vNy/ei/ZvCMMsN0lEy1UoQyTbGpEQ
        1EdR9KKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3Mdm-007Fbh-3z; Thu, 08 Dec 2022 19:33:06 +0000
Date:   Thu, 8 Dec 2022 19:33:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        tsahu@linux.ibm.com, david@redhat.com
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Message-ID: <Y5I78soNmAFv7pi8@casper.infradead.org>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 10:06:07AM -0800, Sidhartha Kumar wrote:
> On 12/7/22 6:27 PM, John Hubbard wrote:
> > On 12/7/22 17:42, Sidhartha Kumar wrote:
> > > > Wouldn't it be better to instead just create a new function for that
> > > > case, such as:
> > > > 
> > > >      dissolve_large_folio()
> > > > 
> > > 
> > > Prior to the folio conversion, the helper function
> > > __destroy_compound_gigantic_page() did:
> > > 
> > >      set_compound_order(page, 0);
> > > #ifdef CONFIG_64BIT
> > >      page[1].compound_nr = 0;
> > > #endif
> > > 
> > > as part of dissolving the page. My goal for this patch was to create
> > > a function that would encapsulate that segment of code with a single
> > > call of folio_set_compound_order(folio, 0). set_compound_order()
> > > does not set compound_nr to 0 when 0 is passed in to the order
> > > argument so explicitly setting it is required. I don't think a
> > > separate dissolve_large_folio() function for the hugetlb case is
> > > needed as __destroy_compound_gigantic_folio() is pretty concise as
> > > it is.
> > > 
> > 
> > Instead of "this is abusing function X()" comments, we should prefer
> > well-named functions that do something understandable. And you can get
> > that by noticing that folio_set_compound_order() collapses down to
> > nearly nothing in the special "order 0" case. So just inline that code
> > directly into __destroy_compound_gigantic_folio(), taking a moment to
> > fill in and consolidate the CONFIG_64BIT missing parts in mm.h.
> > 
> > And now you can get rid of this cruft and "abuse" comment, and instead
> > just end up with two simple lines of code that are crystal clear--as
> > they should be, in a "__destroy" function. Like this:
> > 
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 105878936485..cf227ed00945 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1754,6 +1754,7 @@ static inline void set_page_links(struct page
> > *page, enum zone_type zone,
> >   #endif
> >   }
> > 
> > +#ifdef CONFIG_64BIT
> >   /**
> >    * folio_nr_pages - The number of pages in the folio.
> >    * @folio: The folio.
> > @@ -1764,13 +1765,32 @@ static inline long folio_nr_pages(struct folio
> > *folio)
> >   {
> >       if (!folio_test_large(folio))
> >           return 1;
> > -#ifdef CONFIG_64BIT
> >       return folio->_folio_nr_pages;
> > +}
> > +
> > +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
> > +{
> > +    folio->_folio_nr_pages = nr_pages;
> > +}
> >   #else
> > +/**
> > + * folio_nr_pages - The number of pages in the folio.
> > + * @folio: The folio.
> > + *
> > + * Return: A positive power of two.
> > + */
> > +static inline long folio_nr_pages(struct folio *folio)
> > +{
> > +    if (!folio_test_large(folio))
> > +        return 1;
> >       return 1L << folio->_folio_order;
> > -#endif
> >   }
> > 
> > +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
> > +{
> > +}
> > +#endif
> > +
> >   /**
> >    * folio_next - Move to the next physical folio.
> >    * @folio: The folio we're currently operating on.
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index e3500c087893..b507a98063e6 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1344,7 +1344,8 @@ static void
> > __destroy_compound_gigantic_folio(struct folio *folio,
> >               set_page_refcounted(p);
> >       }
> > 
> > -    folio_set_compound_order(folio, 0);
> > +    folio->_folio_order = 0;
> > +    folio_set_nr_pages(folio, 0);
> >       __folio_clear_head(folio);
> >   }
> > 
> > 
> > Yes?
> 
> This works for me, I will take this approach along with Muchun's feedback
> about a wrapper function so as not to touch _folio_order directly and send
> out a new version.
> 
> One question I have is if I should then get rid of
> folio_set_compound_order() as hugetlb is the only compound page user I've
> converted to folios so far and its use can be replaced by the suggested
> folio_set_nr_pages() and folio_set_order().
> 
> Hugetlb also has one has one call to folio_set_compound_order() with a
> non-zero order, should I replace this with a call to folio_set_order() and
> folio_set_nr_pages() as well, or keep folio_set_compound_order() and remove
> zero order support and the comment. Please let me know which approach you
> would prefer.

None of the above!

Whatever we're calling this function *it does not belong* in mm.h.
Anything outside the MM calling it is going to be a disaster -- can you
imagine what will happen if a filesystem or device driver is handed a
folio and decides "Oh, I'll just change the size of this folio"?  It is
an attractive nuisance and should be confined to mm/internal.h *at best*.

Equally, we *must not have* separate folio_set_order() and
folio_set_nr_pages().  These are the same thing!  They must be kept
in sync!  If we are to have a folio_set_order() instead of open-coding
it, then it should also update nr_pages.

So, given that this is now an internal-to-mm, if not internal-to-hugetlb
function, I see no reason that it should not handle the case of 0.
I haven't studied what hugetlb_dissolve does, or why it can't use the
standard split_folio(), but I'm sure there's a good reason.
