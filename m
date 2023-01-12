Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60BB666E75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjALJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjALJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:40:43 -0500
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893C813D34
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:36:27 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 44FB51EE8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:36:26 +0000 (GMT)
Received: (qmail 6429 invoked from network); 12 Jan 2023 09:36:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2023 09:36:25 -0000
Date:   Thu, 12 Jan 2023 09:36:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Message-ID: <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-3-mgorman@techsingularity.net>
 <Y77VYdboKBUsILhD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y77VYdboKBUsILhD@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:27:29PM +0100, Michal Hocko wrote:
> On Mon 09-01-23 15:16:26, Mel Gorman wrote:
> > RT tasks are allowed to dip below the min reserve but ALLOC_HARDER is
> > typically combined with ALLOC_MIN_RESERVE so RT tasks are a little
> > unusual. While there is some justification for allowing RT tasks
> > access to memory reserves, there is a strong chance that a RT task
> > that is also under memory pressure is at risk of missing deadlines
> > anyway. Relax how much reserves an RT task can access by treating
> > it the same as __GFP_HIGH allocations.
> 
> TBH, I would much rather drop the RT special casing here. As you say if
> a RT task need to dip into memory reserves it is either already too late
> because the execution is already under RT constrains or this is init
> phase where the reclaim is not a problem yet.
> 

I completely agree. I included it in the changelog because I was tempted
to delete it now. I'm wary that the series will result in some
allocation failure bug reports and so played it cautious.

Hard realtime tasks should be locking down resources in advance. Even a
soft-realtime task like audio or video live decoding which cannot jitter
should be allocating both memory and any disk space required up-front
before the recording starts instead of relying on reserves. At best,
reserve access will only delay the problem by a very short interval.

> I have tried to trace down this special case and only found a patch from
> Robert Love from 2003 which says:
> : - Let real-time tasks dip further into the reserves than usual in
> :   __alloc_pages().  There are a lot of ways to special case this.  This
> :   patch just cuts z->pages_low in half, before doing the incremental min
> :   thing, for real-time tasks.  I do not do anything in the low memory slow
> :   path.  We can be a _lot_ more aggressive if we want.  Right now, we just
> :   give real-time tasks a little help.
> 
> This doesn't really explain why this is needed.
> 

No, it does not but I'm not willing to complain either. 20 years ago,
it might have been completely reasonable.

> We are really great at preserving a behavior and cementing it for
> future generations. Maybe we should just drop it and see if something
> breaks. We would get some reasoning at least finally.
> 
> So I am not opposed to the patch per se but I would much rather see this
> branch go away. If you want me I can condense the above into a changelog
> and send a patch (either on top of this one or replacing it). WDYT?
> 

I agree with you but given the risk of bisections hitting this series,
would you be opposed to delaying the removal by 1 kernel release? That
way bisections for failures will hit 6.3 and a single commit or at least
just a report against 6.3. That would mitigate the risk of a full revert
of the series. I can add a note to the changelog mentioning the expected
removal so git blame will also highlight it.

> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
