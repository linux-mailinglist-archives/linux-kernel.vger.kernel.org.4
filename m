Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B06F5C09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjECQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjECQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:30:22 -0400
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [IPv6:2001:41d0:1004:224b::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAE4EF9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:30:07 -0700 (PDT)
Date:   Wed, 3 May 2023 09:30:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683131405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGRmvkXZgWwSDmksHZZl3JTraRryAOxL8ndOPqqQNzA=;
        b=Ift34KQ4ikJ+WTvGN4Y1OvAtcUpwNgFBqPVKyB/ZjJIBe4waIyJ6EEGw3c34v1edy4+gQ2
        XyDIcpEZezSpg/S7ZbDKsgJESbBEkk9vVPmSflPSUnU3TeP3oYLioq9ZKVh/07Aa/hArij
        Va9IoVhT15FgtFN32qFN/Lvy8cybTS4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= mm:
 optimization on page allocation when CMA enabled
Message-ID: <ZFKMCBWvOqMk3g1V@P9FQF9L96D.corp.robot.car>
References: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZE/y5wMggipQrKvb@P9FQF9L96D>
 <e0bd4476c7854cbfafea0ced9569220c@BJMBX01.spreadtrum.com>
 <ZFGIN5Gnc2W7LhmK@P9FQF9L96D.corp.robot.car>
 <CAGWkznGpi7YKYeNcKrOr=58=4VApq285ocCPVh22HJCWwCU85Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznGpi7YKYeNcKrOr=58=4VApq285ocCPVh22HJCWwCU85Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 03:58:21PM +0800, Zhaoyang Huang wrote:
> On Wed, May 3, 2023 at 6:01 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Tue, May 02, 2023 at 12:12:28PM +0000, 黄朝阳 (Zhaoyang Huang) wrote:
> > > > Hi Zhaoyang!
> > > >
> > > > On Fri, Apr 28, 2023 at 07:00:41PM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > Please be notice bellowing typical scenario that commit 168676649
> > > > > introduce, that is, 12MB free cma pages 'help' GFP_MOVABLE to keep
> > > > > draining/fragmenting U&R page blocks until they shrink to 12MB without
> > > > > enter slowpath which against current reclaiming policy. This commit change
> > > > the criteria from hard coded '1/2'
> > > > > to watermark check which leave U&R free pages stay around WMARK_LOW
> > > > > when being fallback.
> > > >
> > > > Can you, please, explain the problem you're solving in more details?
> > > I am trying to solve a OOM problem caused by slab allocation fail as all free pages are MIGRATE_CMA by applying 168676649, which could help to reduce the fault ration from 12/20 to 2/20. I noticed it introduce the phenomenon which I describe above.
> > > >
> > > > If I understand your code correctly, you're effectively reducing the use of cma
> > > > areas for movable allocations. Why it's good?
> > > Not exactly. In fact, this commit lead to the use of cma early than it is now, which could help to protect U&R be 'stolen' by GFP_MOVABLE. Imagine this scenario, 30MB total free pages composed of 10MB CMA and 20MB U&R, while zone's watermark low is 25MB. An GFP_MOVABLE allocation can keep stealing U&R pages(don't meet 1/2 criteria) without enter slowpath(zone_watermark_ok(WMARK_LOW) is true) until they shrink to 15MB. In my opinion, it makes more sense to have CMA take its duty to help movable allocation when U&R lower to certain zone's watermark instead of when their size become smaller than CMA.
> > > > Also, this is a hot path, please, make sure you're not adding much overhead.
> > > I would like to take more thought.
> >
> > Got it, thank you for the explanation!
> >
> > How about the following approach (completely untested)?
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6da423ec356f..4b50f497c09d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2279,12 +2279,13 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
> >         if (IS_ENABLED(CONFIG_CMA)) {
> >                 /*
> >                  * Balance movable allocations between regular and CMA areas by
> > -                * allocating from CMA when over half of the zone's free memory
> > -                * is in the CMA area.
> > +                * allocating from CMA when over half of the zone's easily
> > +                * available free memory is in the CMA area.
> >                  */
> >                 if (alloc_flags & ALLOC_CMA &&
> >                     zone_page_state(zone, NR_FREE_CMA_PAGES) >
> > -                   zone_page_state(zone, NR_FREE_PAGES) / 2) {
> > +                   (zone_page_state(zone, NR_FREE_PAGES) -
> > +                    zone->_watermark[WMARK_LOW]) / 2) {
> IMO, we should focus on non-cma area which trigger use of cma when
> they are lower than corresponding watermark(there is still
> WMARK_MIN/HIGH to deal with within slowpath)
> >                         page = __rmqueue_cma_fallback(zone, order);
> >                         if (page)
> >                                 return page;
> >
> > Basically the idea is to keep free space equally split between cma and non-cma areas.
> > Will it work for you?
> I don't think it makes sense to 'equally split' cma and non-cma areas
> over free space while cma could occupy various proportions in a single
> zone. This fixed 1/2 could lead to different situation on 20% or 50%
> cma occupation.

Can you then, please, explain in details what you're proposing instead
and why it's better (not only in your case, but generally as well)?
For the context, my original usecase was cma size under 10G and
the total memory size between 32G and 128G.

Looking at your original patch, I see that __if_use_cma_first() always returns
false if zone_watermark_ok() returns true. It worries me.

Thanks!
