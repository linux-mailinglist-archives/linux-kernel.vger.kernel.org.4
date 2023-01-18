Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3B671071
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjARB41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjARB4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:56:21 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5564614E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:56:17 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:56:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674006975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyWTxF4FfJMeDbUGZTVRzt6Lmnq30K9ei9PlhTnyc/s=;
        b=uluUZb7gb/031l90RszkUgv+R23MlNN1gM9xJ6uuErvXIsK5hBi8tJ8c/6Jd91pZehWp4l
        C2PI8CodSCp5WYWcHLFwy828AfcxpeiDMFJ7rHTR+OLNC0YGQmh1JkHJO3vgYIkBw0uPu7
        b0r6MWymx1k0Xf18uoBYfFgH+5bhJA4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable v2 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <20230118015607.GA1620837@u2004>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
 <20230110212821.984047-9-sidhartha.kumar@oracle.com>
 <Y73bP5CFT/8T/DvO@casper.infradead.org>
 <Y738EQkRcgv1eO66@monkey>
 <2f9ef115-a508-090b-d804-23235a447063@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f9ef115-a508-090b-d804-23235a447063@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:16:23AM -0600, Sidhartha Kumar wrote:
> On 1/10/23 6:00 PM, Mike Kravetz wrote:
> > On 01/10/23 21:40, Matthew Wilcox wrote:
> > > On Tue, Jan 10, 2023 at 03:28:21PM -0600, Sidhartha Kumar wrote:
> > > > @@ -3505,6 +3505,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
> > > >   {
> > > >   	int nr_nodes, node;
> > > >   	struct page *page;
> > > > +	struct folio *folio;
> > > >   	lockdep_assert_held(&hugetlb_lock);
> > > > @@ -3518,8 +3519,8 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
> > > >   		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
> > > >   			if (PageHWPoison(page))
> > > >   				continue;
> > > > -
> > > > -			return demote_free_huge_page(h, page);
> > > > +			folio = page_folio(page);
> > > > +			return demote_free_hugetlb_folio(h, folio);
> > > >   		}
> > > >   	}
> > > 
> > > Can't this be
> > > 		list_for_each_entry(folio, &h->hugepage_freelists[node], lru)
> > > 
> > > which avoids the call to page_folio() here.
> > > 
> > > I think the call to PageHWPoison is actually wrong here.  That would
> > > only check the hwpoison bit on the first page, whereas we want to know
> > > about the hwpoison bit on any page (don't we?)  So this should be
> > > folio_test_has_hwpoisoned()?
> > > 
> > > Or is that a THP-thing that is different for hugetlb pages?
> > 
> > I believe it is different for hugetlb pages.  See hugetlb_set_page_hwpoison()
> > where it sets PageHWPoison on head page as well as allocating a raw_hwp_page
> 
> I agree, this line in hugetlb_set_page_hwpoison (which is now
> folio_set_hugetlb_hwpoison) sets the HWPoison flag on the head page
> 
> int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> 
> so the correct code in demote_pool_huge_page() would be:
> 
> 	list_for_each_entry(folio, &h->hugepage_freelists[node], lru) {
> 			if (folio_test_hwpoison(folio))
> 				continue;
> 			return demote_free_hugetlb_folio(h, folio);
> 		}
> 
> 
> > to track the actual page with poison.  Note that we can not directly flag
> > hugetlb 'subpages' because we may not have the struct pages due to vmemmap
> > optimization.  Adding Naoya just to be sure.

Yes, the above code and the reason totally make sense to me.
Thanks for the patch and the update.

- Naoya Horiguchif
