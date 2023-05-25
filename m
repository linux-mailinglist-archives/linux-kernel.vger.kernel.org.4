Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2292711866
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjEYUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjEYUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:46:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB6194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SBmKO8aSIQFep/NI9A33SHF1dRQ/pJp/iFl292SxJdw=; b=pSLzkSTgiRLP8DJyWeeqovKscL
        JqUYhwsn25Sm4ZgWYHJj7m1U3gKzVopniqtlr/tysys/dDmdWkde7HLtc/cIx81KyybalNl3QBfoV
        mX17ra6xv/3timmBT4ryBoLdfQAhSvBN8klq5n+YfTdGnZTW9rA2zSVlg0B8tgZAP6mTDq6Xm5pEW
        IhN7zs9bmPrc7ZvIq7C0BjvPhFUyaVepC3UDsD4auY0sFcpsC3eRjm/2lORybUtFEgsykt7DsiW1A
        5PYx4MtHXib70Kv3W/YoFowaEjuz8lH0PCbFT9SsFjNMijwH65VFt4gAwaABuRYj6VjosLmvqz9ti
        r+vXXZPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2Hq2-00D9v5-Ge; Thu, 25 May 2023 20:45:34 +0000
Date:   Thu, 25 May 2023 21:45:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        david@redhat.com, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Message-ID: <ZG/I7tYY4uV/32hP@casper.infradead.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:15:07PM -0400, Steven Sistare wrote:
> On 5/25/2023 3:58 PM, Matthew Wilcox wrote:
> > On Thu, May 25, 2023 at 01:15:07PM -0600, Khalid Aziz wrote:
> >> diff --git a/mm/compaction.c b/mm/compaction.c
> >> index 5a9501e0ae01..b548e05f0349 100644
> >> --- a/mm/compaction.c
> >> +++ b/mm/compaction.c
> >> @@ -764,6 +764,42 @@ static bool too_many_isolated(pg_data_t *pgdat)
> >>  	return too_many;
> >>  }
> >>  
> >> +/*
> >> + * Check if this base page should be skipped from isolation because
> >> + * it has extra refcounts that will prevent it from being migrated.
> >> + * This code is inspired by similar code in migrate_vma_check_page(),
> >> + * can_split_folio() and folio_migrate_mapping()
> >> + */
> >> +static inline bool page_has_extra_refs(struct page *page,
> >> +					struct address_space *mapping)
> >> +{
> >> +	unsigned long extra_refs;
> >> +	struct folio *folio;
> >> +
> >> +	/*
> >> +	 * Skip this check for pages in ZONE_MOVABLE or MIGRATE_CMA
> >> +	 * pages that can not be long term pinned
> >> +	 */
> >> +	if (is_zone_movable_page(page) || is_migrate_cma_page(page))
> >> +		return false;
> >> +
> >> +	folio = page_folio(page);
> >> +
> >> +	/*
> >> +	 * caller holds a ref already from get_page_unless_zero()
> >> +	 * which is accounted for in folio_expected_refs()
> >> +	 */
> >> +	extra_refs = folio_expected_refs(mapping, folio);
> >> +
> >> +	/*
> >> +	 * This is an admittedly racy check but good enough to determine
> >> +	 * if a page is pinned and can not be migrated
> >> +	 */
> >> +	if ((folio_ref_count(folio) - extra_refs) > folio_mapcount(folio))
> >> +		return true;
> >> +	return false;
> >> +}
> >> +
> >>  /**
> >>   * isolate_migratepages_block() - isolate all migrate-able pages within
> >>   *				  a single pageblock
> >> @@ -992,12 +1028,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >>  			goto isolate_fail;
> > 
> > Just out of shot, we have ...
> > 
> >                 if (unlikely(!get_page_unless_zero(page)))
> > 
> > This is the perfect opportunity to use folio_get_nontail_page() instead.
> > You get back the folio without having to cast the pointer yourself
> > or call page_folio().  Now you can use a folio throughout your new
> > function, saving a call to compound_head().
> > 
> > For a followup patch, everything in this loop below this point can use
> > the folio ... that's quite a lot of change.
> > 
> >>  		/*
> >> -		 * Migration will fail if an anonymous page is pinned in memory,
> >> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
> >> -		 * admittedly racy check.
> >> +		 * Migration will fail if a page has extra refcounts
> >> +		 * from long term pinning preventing it from migrating,
> >> +		 * so avoid taking lru_lock and isolating it unnecessarily.
> >>  		 */
> > 
> > Isn't "long term pinning" the wrong description of the problem?  Long term
> > pins suggest to me FOLL_LONGTERM.  I think this is simple short term
> > pins that we care about here.
> 
> vfio pins are held for a long time - Steve

So this is a third sense of "pinned pages" that is neither what
filesystems nor the mm means by pinned pages, but whatever it is that
vfio means by pinned pages?  If only "pin" weren't such a desirable
word.  Can somebody explain to me in small words what a vfio pin looks
like because I've tried reading vfio_iommu_type1_pin_pages() and I
don't recognise anything there that looks like pinning in either of
the other two senses.

