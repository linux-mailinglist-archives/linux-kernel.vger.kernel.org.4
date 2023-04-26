Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98A6EEBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbjDZBbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbjDZBbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:31:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D04C02
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682472691; x=1714008691;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=dbQM11BsMfhwEMEoPVos/xk8XjcqFHMg/6FxW7p8SfU=;
  b=Stu1yR9TNIe86xuYQSFp1TlYGNq+eeICgzCkDfMLRuoosTkGqEum07Yd
   F18053H30IQN7/ec2FnMifYf9MDUBIHD1DYH0qkPv0qJ6LrJbtdtGb4EO
   URk4DT9UFibve0BlJLbaBPrMtgexfVwWM/3sJ+AKktXqzlawcS8qm59PB
   eHOKGswrecH7rbCkldM/ERW3GZuTGd9VHEikUWgAo5p/RlEeZNunMHeEM
   LQhMQziWXVnsMBaWFC/EKJvVRAYv/epTSLh/31diPu3HPRdjU4+Ullogj
   4W8VlymqJVirwJRf7VN5MlXvV/PzvCaCR7oecMu7j5HRRBl326hyGmZkX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="348886893"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="348886893"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 18:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="783086823"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="783086823"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 18:31:28 -0700
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
Date:   Wed, 26 Apr 2023 09:30:23 +0800
In-Reply-To: <20230425142641.GA17132@cmpxchg.org> (Johannes Weiner's message
        of "Tue, 25 Apr 2023 10:26:41 -0400")
Message-ID: <87o7nbe8gg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Tue, Apr 25, 2023 at 11:12:28AM +0800, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> 
>> > Kswapd currently bails on higher-order allocations with an open-coded
>> > check for whether it's reclaimed the compaction gap.
>> >
>> > compaction_suitable() is the customary interface to coordinate reclaim
>> > with compaction.
>> >
>> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> > ---
>> >  mm/vmscan.c | 67 ++++++++++++++++++-----------------------------------
>> >  1 file changed, 23 insertions(+), 44 deletions(-)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index ee8c8ca2e7b5..723705b9e4d9 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -6872,12 +6872,18 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>> >  		if (!managed_zone(zone))
>> >  			continue;
>> >  
>> > +		/* Allocation can succeed in any zone, done */
>> >  		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>> >  			mark = wmark_pages(zone, WMARK_PROMO);
>> >  		else
>> >  			mark = high_wmark_pages(zone);
>> >  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
>> >  			return true;
>> > +
>> > +		/* Allocation can't succeed, but enough order-0 to compact */
>> > +		if (compaction_suitable(zone, order,
>> > +					highest_zoneidx) == COMPACT_CONTINUE)
>> > +			return true;
>> 
>> Should we check the following first?
>> 
>>         order > 0 && zone_watermark_ok_safe(zone, 0, mark, highest_zoneidx)
>
> That's what compaction_suitable() does. It checks whether there are
> enough migration targets for compaction (COMPACT_CONTINUE) or whether
> reclaim needs to do some more work (COMPACT_SKIPPED).

Yes.  And I found that the watermark used in compaction_suitable() is
low_wmark_pages() or min_wmark_pages(), which doesn't match the
watermark here.  Or did I miss something?

Best Regards,
Huang, Ying
