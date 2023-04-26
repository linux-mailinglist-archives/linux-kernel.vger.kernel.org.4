Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653EA6EF7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbjDZPWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjDZPWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:22:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3165D3C0C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:22:08 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-74df41e2e61so379302685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682522528; x=1685114528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef15Ov3pvrQ2pgycNFRBHaU07mMI1UW5IHnYE+IozeY=;
        b=qkdCix2P7HMB3uQ2e81uHtXLHflo/4cd/mtAubKmNJWUKFgRnZZU9IaEBLpwZSYSZh
         35cc6iSNybkg6evafA36dTp28QJxh4/UuaJxm5i95wiEv3QtRIdjTnVrSMJVau489SGq
         /A5Zuia1amqKux27dw/2/r136rv1L8BRW0FFWtqOfGCHv/aD/lE2NTnO/QGGkDh9ldNh
         i+bZkjmSAoFwPeGCKaHRevd+e8cWBdmKad9WHdjD35si6qk0EC1bP6bkvad4zYx+d2ur
         zq6AiB6ei5ox31oW9DK8ebBEM4/j2RQovJ0Wsxif3pSCrOiJzrJsVN6eFPSsqFxP0BqJ
         1ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682522528; x=1685114528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef15Ov3pvrQ2pgycNFRBHaU07mMI1UW5IHnYE+IozeY=;
        b=WQs+bxk5Xlhfc64ofjKdBYmy6WLsRkIFViQJFK8WVKgDehUzOnMKsOLG1zJ5Ol7KDs
         UjNYGsXVuliTrPw5oI9H9LVrh+If/zgdP8XctE2EwxSFoTFizCiXjnjw+hFNZz2EQX7f
         aicAeKCypza7Bj7fvrLZcF3R195pMEdaDgTgJtFv0kPHPp5wCUGGFFIMzawvO4rRuCwE
         uXHHWcAHNiiBqTPsOnsRQa4nvv8EdMZEHZli50hQcc60g1A9ndhRFfflUKMnzsN2iU/u
         SyPsRdl6pvZGvPfvhJ4DgXR8LWQipABK/1NhQeV+PmmusHrXBLoi5CYVwJJ559DvQ9nM
         xaVQ==
X-Gm-Message-State: AAQBX9fg02gs8E1jLD7PzGPKvXoJt9Z2Nk/HG6C6yDVIoZGSb9y73lr3
        y9DWWCt7vqfJ5vfGr+u3MjgfGA==
X-Google-Smtp-Source: AKy350Z6dg4HGzWyvdPitzabnkl2zzr6soo/rgAVk0yZLzuDRNaH7yQZJ2Eh+uK9ldebFf4ACtyoEQ==
X-Received: by 2002:a05:622a:19a9:b0:3e6:71d6:5d5d with SMTP id u41-20020a05622a19a900b003e671d65d5dmr33707209qtc.1.1682522528006;
        Wed, 26 Apr 2023 08:22:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id bp10-20020a05620a458a00b0074e0951c7e7sm5186055qkb.28.2023.04.26.08.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 08:22:07 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:22:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 20/26] mm: vmscan: use compaction_suitable() check in
 kswapd
Message-ID: <20230426152206.GA30064@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-21-hannes@cmpxchg.org>
 <87a5ywfyeb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230425142641.GA17132@cmpxchg.org>
 <87o7nbe8gg.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7nbe8gg.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 09:30:23AM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > On Tue, Apr 25, 2023 at 11:12:28AM +0800, Huang, Ying wrote:
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> 
> >> > Kswapd currently bails on higher-order allocations with an open-coded
> >> > check for whether it's reclaimed the compaction gap.
> >> >
> >> > compaction_suitable() is the customary interface to coordinate reclaim
> >> > with compaction.
> >> >
> >> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >> > ---
> >> >  mm/vmscan.c | 67 ++++++++++++++++++-----------------------------------
> >> >  1 file changed, 23 insertions(+), 44 deletions(-)
> >> >
> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > index ee8c8ca2e7b5..723705b9e4d9 100644
> >> > --- a/mm/vmscan.c
> >> > +++ b/mm/vmscan.c
> >> > @@ -6872,12 +6872,18 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
> >> >  		if (!managed_zone(zone))
> >> >  			continue;
> >> >  
> >> > +		/* Allocation can succeed in any zone, done */
> >> >  		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> >> >  			mark = wmark_pages(zone, WMARK_PROMO);
> >> >  		else
> >> >  			mark = high_wmark_pages(zone);
> >> >  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
> >> >  			return true;
> >> > +
> >> > +		/* Allocation can't succeed, but enough order-0 to compact */
> >> > +		if (compaction_suitable(zone, order,
> >> > +					highest_zoneidx) == COMPACT_CONTINUE)
> >> > +			return true;
> >> 
> >> Should we check the following first?
> >> 
> >>         order > 0 && zone_watermark_ok_safe(zone, 0, mark, highest_zoneidx)
> >
> > That's what compaction_suitable() does. It checks whether there are
> > enough migration targets for compaction (COMPACT_CONTINUE) or whether
> > reclaim needs to do some more work (COMPACT_SKIPPED).
> 
> Yes.  And I found that the watermark used in compaction_suitable() is
> low_wmark_pages() or min_wmark_pages(), which doesn't match the
> watermark here.  Or did I miss something?

Ahh, you're right, kswapd will bail prematurely. Compaction cannot
reliably meet the high watermark with a low watermark scratch space.

I'll add the order check before the suitable test, for clarity, and so
that order-0 requests don't check the same thing twice.

For the watermark, I'd make it an arg to compaction_suitable() and use
whatever the reclaimer targets (high for kswapd, min for direct).

However, there is a minor snag. compaction_suitable() currently has
its own smarts regarding the watermark:

	/*
	 * Watermarks for order-0 must be met for compaction to be able to
	 * isolate free pages for migration targets. This means that the
	 * watermark and alloc_flags have to match, or be more pessimistic than
	 * the check in __isolate_free_page(). We don't use the direct
	 * compactor's alloc_flags, as they are not relevant for freepage
	 * isolation. We however do use the direct compactor's highest_zoneidx
	 * to skip over zones where lowmem reserves would prevent allocation
	 * even if compaction succeeds.
	 * For costly orders, we require low watermark instead of min for
	 * compaction to proceed to increase its chances.
	 * ALLOC_CMA is used, as pages in CMA pageblocks are considered
	 * suitable migration targets
	 */
	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
				low_wmark_pages(zone) : min_wmark_pages(zone);

Historically it has always checked low instead of min. Then Vlastimil
changed it to min for non-costly orders here:

commit 8348faf91f56371d4bada6fc5915e19580a15ffe
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Fri Oct 7 16:58:00 2016 -0700

    mm, compaction: require only min watermarks for non-costly orders
    
    The __compaction_suitable() function checks the low watermark plus a
    compact_gap() gap to decide if there's enough free memory to perform
    compaction.  Then __isolate_free_page uses low watermark check to decide
    if particular free page can be isolated.  In the latter case, using low
    watermark is needlessly pessimistic, as the free page isolations are
    only temporary.  For __compaction_suitable() the higher watermark makes
    sense for high-order allocations where more freepages increase the
    chance of success, and we can typically fail with some order-0 fallback
    when the system is struggling to reach that watermark.  But for
    low-order allocation, forming the page should not be that hard.  So
    using low watermark here might just prevent compaction from even trying,
    and eventually lead to OOM killer even if we are above min watermarks.
    
    So after this patch, we use min watermark for non-costly orders in
    __compaction_suitable(), and for all orders in __isolate_free_page().

Lowering to min wasn't an issue for non-costly, but AFAICS there was
no explicit testing for whether min would work for costly orders too.

I'd propose trying it with min even for costly and see what happens.

If it does regress, a better place to boost scratch space for costly
orders might be compact_gap(), so I'd move it there.

Does that sound reasonable?
