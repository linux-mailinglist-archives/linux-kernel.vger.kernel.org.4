Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8965D204
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbjADME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjADMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:04:04 -0500
Received: from outbound-smtp57.blacknight.com (outbound-smtp57.blacknight.com [46.22.136.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6923219E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:03:49 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id E4D68FACEE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:03:47 +0000 (GMT)
Received: (qmail 18400 invoked from network); 4 Jan 2023 12:03:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Jan 2023 12:03:47 -0000
Date:   Wed, 4 Jan 2023 12:03:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Message-ID: <20230104120345.imuc3pguzyjm5oi4@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-6-mgorman@techsingularity.net>
 <ebe54af3-f679-32ab-1ef1-17f565796ef2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ebe54af3-f679-32ab-1ef1-17f565796ef2@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:07:06PM +0100, Vlastimil Babka wrote:
> On 11/29/22 16:17, Mel Gorman wrote:
> > @@ -4846,28 +4846,30 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> >  	 * The caller may dip into page reserves a bit more if the caller
> >  	 * cannot run direct reclaim, or if the caller has realtime scheduling
> >  	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
> > -	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_MIN_RESERVE(__GFP_HIGH).
> > +	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> >  	 */
> >  	alloc_flags |= (__force int)
> >  		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> >  
> > -	if (gfp_mask & __GFP_ATOMIC) {
> > +	if (!(gfp_mask & __GFP_RECLAIM)) {
> 
> This is supposed to be __GFP_DIRECT_RECLAIM right? Otherwise that includes
> also __GFP_KSWAPD_RECLAIM and GFP_ATOMIC sets that one...
> 

Yes

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b2093d17b48..2217bab2dbb2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4856,7 +4856,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
-	if (!(gfp_mask & __GFP_RECLAIM)) {
+	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.

-- 
Mel Gorman
SUSE Labs
