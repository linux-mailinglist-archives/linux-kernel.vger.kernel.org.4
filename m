Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05647678E46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjAXCcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:32:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE3B46D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OzPDZ4GQurQ3Wi5M3nuD8SPGO947lucDtaqwO/v+ugk=; b=RIRW6FzX1L2Ilb64mAF0WuK3ZC
        IBKJEySwbhjJJTDy7YouhVBaxSKPoQa37sOqk72zNmcLnk3SLsnWsOYmk+k230wp3vUpUNUt8tFwM
        IVaNu+mhaCne7fWB7xV5LybzEeLVpWLfqa9G5BABDRyV/JhG1zhgqT98+wrRQJA+29bf52YO7s0Io
        p0cS3Lf8PwxSQj0V9z7cOM2SF5sbB5gJ3M38hD5vQZwTIA2NHq+30Ocr7GslJdzE2tP/iaKQN8Ize
        9UVfUzqtmiZEGM5IAqHrO8HCFrjev+UIC0G+y9rShQ5AMJyxpHd0rUoolIWSws82CeBfh2WiJYIu5
        cDWOa1yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK96Z-004hsI-Bs; Tue, 24 Jan 2023 02:32:11 +0000
Date:   Tue, 24 Jan 2023 02:32:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de
Subject: Re: [PATCH 1/2] mm/memory_hotplug: remove head page reference in
 do_migrate_range
Message-ID: <Y89DK23hYiLtgGNk@casper.infradead.org>
References: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
 <Y87wJ6ERhdujjo6P@casper.infradead.org>
 <5c40ed66-1e51-78fa-193c-0eb0db814b01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c40ed66-1e51-78fa-193c-0eb0db814b01@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:08:49PM -0800, Sidhartha Kumar wrote:
> On 1/23/23 12:37 PM, Matthew Wilcox wrote:
> > On Mon, Jan 23, 2023 at 12:23:46PM -0800, Sidhartha Kumar wrote:
> > > @@ -1637,14 +1637,13 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> > >   			continue;
> > >   		page = pfn_to_page(pfn);
> > >   		folio = page_folio(page);
> > > -		head = &folio->page;
> > > -		if (PageHuge(page)) {
> > > -			pfn = page_to_pfn(head) + compound_nr(head) - 1;
> > > +		if (folio_test_hugetlb(folio)) {
> > > +			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
> > >   			isolate_hugetlb(folio, &source);
> > >   			continue;
> > > -		} else if (PageTransHuge(page))
> > > -			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
> > > +		} else if (folio_test_transhuge(folio))
> > > +			pfn = folio_pfn(folio) + thp_nr_pages(page) - 1;
> > 
> > I'm pretty sure those two lines should be...
> > 
> > 		} else if (folio_test_large(folio) > 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
> > 
> > But, erm ... we're doing this before we have a refcount on the page,
> > right?  So this is unsafe because the page might change which folio
> > it is in.  And the folio we found earlier might become a tail page
> > of a different folio.  (As the comment below explains, HWPoison pages
> > won't, so it's not unsafe for them).
> > 
> 
> Thanks for the explanation of why this is unsafe. Would it be worth to put
> this code block inside the
> 
> 		if (!get_page_unless_zero(page))
> 			continue;
> 
> 		put_page(page);
> 
> block found lower? My motivation for this series is the HPageMigratable call
> in patch 2 is the last user of the huge page flag test macros so a
> conversion would allow for the removal of the macro. I thought I could also
> remove the head page references found in this function, but if that would
> cause too much churn in a complicated sub-system it can be dropped.

I think we just have to be very careful when working without a page ref.

Now, specifically to the matter of converting HPageMigratable(), I think
that's fine.  Your folio_test_hugetlb_##flname macro does not have a
VM_BUG_ON_PGFLAGS(PageTail(page), page) in it, unlike folio_flags().
So it looks like even if your folio becomes a tail page in the middle
of scan_movable_pages(), you won't hit a BUG().

Now, should we go further?  Possibly.  But I'm more concerned that we
haven't really figured out which functions should be checking this.
Maybe we should drop the BUG entirely and rely more on the type system
(and people not casting) to prevent errors.

We could go a lot further with the type system and define a new type for
"might be a folio but we don't have a refcount on it".  But we don't
do a lot of work with unreferenced folios, so I'm not inclined to go to
all that effort.

Perhaps we want a folio_maybe_X() series of functions that don't warn
if the folio has morphed into not-a-folio.  I don't know.
