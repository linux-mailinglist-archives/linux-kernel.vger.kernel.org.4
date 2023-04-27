Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA26F007A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbjD0FnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0FnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:43:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DFE2D79
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682574182; x=1714110182;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=CpfjGZP5sNi8QN42pWns4vxK9C3j3dLDfG7m/DJ9cYg=;
  b=Sf3IJjvtAD29joZyf1hURaH6wgpfk9aH7sxY+Wr617HiBfIYBuVtfXTV
   Jq0vnAJPH6ciZ/h5kU/zVB6XZYlE0rBB3GwUBgx9xs0wEt6mnTQhu1+VA
   IBPDhcoeplKuDdHERFZMsEMJeH7pZDfJfIWLQV1sK9domIc7GtRE4g59j
   3gDouD8hEfdKoY6lCUX/P2NobRtuHK+JZn2bKae95PizjxWAIQv7+ccsv
   BkhQRh8/wuo/2bGyGkPS68yHSttbNVpoxHGFlwiIZNarUzsrneYKyYzNn
   kHUg6Kdx+ETZN44fNcVGOGq5/n/Om2wCJpvzZnI+5NVFHFqx8Ab5ajZxD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412665841"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="412665841"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 22:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="724744907"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="724744907"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 22:42:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 20/26] mm: vmscan: use compaction_suitable() check
 in kswapd
References: <20230418191313.268131-1-hannes@cmpxchg.org>
        <20230418191313.268131-21-hannes@cmpxchg.org>
        <87a5ywfyeb.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230425142641.GA17132@cmpxchg.org>
        <87o7nbe8gg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230426152206.GA30064@cmpxchg.org>
Date:   Thu, 27 Apr 2023 13:41:38 +0800
In-Reply-To: <20230426152206.GA30064@cmpxchg.org> (Johannes Weiner's message
        of "Wed, 26 Apr 2023 11:22:06 -0400")
Message-ID: <87cz3peval.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Wed, Apr 26, 2023 at 09:30:23AM +0800, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> 
>> > On Tue, Apr 25, 2023 at 11:12:28AM +0800, Huang, Ying wrote:
>> >> Johannes Weiner <hannes@cmpxchg.org> writes:
>> >> 
>> >> > Kswapd currently bails on higher-order allocations with an open-coded
>> >> > check for whether it's reclaimed the compaction gap.
>> >> >
>> >> > compaction_suitable() is the customary interface to coordinate reclaim
>> >> > with compaction.
>> >> >
>> >> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> >> > ---
>> >> >  mm/vmscan.c | 67 ++++++++++++++++++-----------------------------------
>> >> >  1 file changed, 23 insertions(+), 44 deletions(-)
>> >> >
>> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> >> > index ee8c8ca2e7b5..723705b9e4d9 100644
>> >> > --- a/mm/vmscan.c
>> >> > +++ b/mm/vmscan.c
>> >> > @@ -6872,12 +6872,18 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>> >> >  		if (!managed_zone(zone))
>> >> >  			continue;
>> >> >  
>> >> > +		/* Allocation can succeed in any zone, done */
>> >> >  		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>> >> >  			mark = wmark_pages(zone, WMARK_PROMO);
>> >> >  		else
>> >> >  			mark = high_wmark_pages(zone);
>> >> >  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
>> >> >  			return true;
>> >> > +
>> >> > +		/* Allocation can't succeed, but enough order-0 to compact */
>> >> > +		if (compaction_suitable(zone, order,
>> >> > +					highest_zoneidx) == COMPACT_CONTINUE)
>> >> > +			return true;
>> >> 
>> >> Should we check the following first?
>> >> 
>> >>         order > 0 && zone_watermark_ok_safe(zone, 0, mark, highest_zoneidx)
>> >
>> > That's what compaction_suitable() does. It checks whether there are
>> > enough migration targets for compaction (COMPACT_CONTINUE) or whether
>> > reclaim needs to do some more work (COMPACT_SKIPPED).
>> 
>> Yes.  And I found that the watermark used in compaction_suitable() is
>> low_wmark_pages() or min_wmark_pages(), which doesn't match the
>> watermark here.  Or did I miss something?
>
> Ahh, you're right, kswapd will bail prematurely. Compaction cannot
> reliably meet the high watermark with a low watermark scratch space.
>
> I'll add the order check before the suitable test, for clarity, and so
> that order-0 requests don't check the same thing twice.
>
> For the watermark, I'd make it an arg to compaction_suitable() and use
> whatever the reclaimer targets (high for kswapd, min for direct).
>
> However, there is a minor snag. compaction_suitable() currently has
> its own smarts regarding the watermark:
>
> 	/*
> 	 * Watermarks for order-0 must be met for compaction to be able to
> 	 * isolate free pages for migration targets. This means that the
> 	 * watermark and alloc_flags have to match, or be more pessimistic than
> 	 * the check in __isolate_free_page(). We don't use the direct
> 	 * compactor's alloc_flags, as they are not relevant for freepage
> 	 * isolation. We however do use the direct compactor's highest_zoneidx
> 	 * to skip over zones where lowmem reserves would prevent allocation
> 	 * even if compaction succeeds.
> 	 * For costly orders, we require low watermark instead of min for
> 	 * compaction to proceed to increase its chances.
> 	 * ALLOC_CMA is used, as pages in CMA pageblocks are considered
> 	 * suitable migration targets
> 	 */
> 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
> 				low_wmark_pages(zone) : min_wmark_pages(zone);
>
> Historically it has always checked low instead of min. Then Vlastimil
> changed it to min for non-costly orders here:
>
> commit 8348faf91f56371d4bada6fc5915e19580a15ffe
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Fri Oct 7 16:58:00 2016 -0700
>
>     mm, compaction: require only min watermarks for non-costly orders
>     
>     The __compaction_suitable() function checks the low watermark plus a
>     compact_gap() gap to decide if there's enough free memory to perform
>     compaction.  Then __isolate_free_page uses low watermark check to decide
>     if particular free page can be isolated.  In the latter case, using low
>     watermark is needlessly pessimistic, as the free page isolations are
>     only temporary.  For __compaction_suitable() the higher watermark makes
>     sense for high-order allocations where more freepages increase the
>     chance of success, and we can typically fail with some order-0 fallback
>     when the system is struggling to reach that watermark.  But for
>     low-order allocation, forming the page should not be that hard.  So
>     using low watermark here might just prevent compaction from even trying,
>     and eventually lead to OOM killer even if we are above min watermarks.
>     
>     So after this patch, we use min watermark for non-costly orders in
>     __compaction_suitable(), and for all orders in __isolate_free_page().
>
> Lowering to min wasn't an issue for non-costly, but AFAICS there was
> no explicit testing for whether min would work for costly orders too.
>
> I'd propose trying it with min even for costly and see what happens.
>
> If it does regress, a better place to boost scratch space for costly
> orders might be compact_gap(), so I'd move it there.
>
> Does that sound reasonable?

Sounds good to me, Thanks!

Best Regards,
Huang, Ying
