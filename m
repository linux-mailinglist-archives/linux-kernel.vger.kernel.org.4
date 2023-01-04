Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E765D1DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbjADLyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbjADLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:54:13 -0500
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 03:54:06 PST
Received: from outbound-smtp47.blacknight.com (outbound-smtp47.blacknight.com [46.22.136.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E161EEDA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:54:06 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 9C733FACE0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:45:04 +0000 (GMT)
Received: (qmail 1950 invoked from network); 4 Jan 2023 11:45:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Jan 2023 11:45:04 -0000
Date:   Wed, 4 Jan 2023 11:45:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Explicitly record high-order atomic
 allocations in alloc_flags
Message-ID: <20230104114502.j4hzzjohxk7bdkcj@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-4-mgorman@techsingularity.net>
 <915a5034-53e6-9464-3fc7-4d1b5a0aa26d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <915a5034-53e6-9464-3fc7-4d1b5a0aa26d@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First off, sorry for the long delay getting back to you. I was sick for
a few weeks and still catching up. I'm still not 100%.

On Thu, Dec 08, 2022 at 05:51:11PM +0100, Vlastimil Babka wrote:
> On 11/29/22 16:16, Mel Gorman wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index da746e9eb2cf..e2b65767dda0 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3710,7 +3710,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
> >  		 * reserved for high-order atomic allocation, so order-0
> >  		 * request should skip it.
> >  		 */
> > -		if (order > 0 && alloc_flags & ALLOC_HARDER)
> > +		if (alloc_flags & ALLOC_HIGHATOMIC)
> >  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> >  		if (!page) {
> >  			page = __rmqueue(zone, order, migratetype, alloc_flags);
> > @@ -4028,8 +4028,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
> >  			return true;
> >  		}
> >  #endif
> > -		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
> > +		if ((alloc_flags & ALLOC_HIGHATOMIC) &&
> > +		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
> >  			return true;
> 
> alloc_harder is defined as
> 	(alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> AFAICS this means we no longer allow ALLOC_OOM to use the highatomic
> reserve. Isn't that a risk?
> 

Yes, it is. I intend to apply the patch below on top. I didn't alter the
first check for ALLOC_HIGHATOMIC as I wanted OOM handling to only use the
high-order reserves if there was no other option. While this is a change
in behaviour, it should be a harmless one. I'll add a note in the changelog.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 50fc1e7cb154..0ef4f3236a5a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3710,6 +3710,16 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
+
+			/*
+			 * If the allocation fails, allow OOM handling access
+			 * to HIGHATOMIC reserves as failing now is worse than
+			 * failing a high-order atomic allocation in the
+			 * future.
+			 */
+			if (!page && (alloc_flags & ALLOC_OOM))
+				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+
 			if (!page) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return NULL;
@@ -4023,7 +4033,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
-		if ((alloc_flags & ALLOC_HIGHATOMIC) &&
+		if ((alloc_flags & (ALLOC_HIGHATOMIC|ALLOC_OOM)) &&
 		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
 			return true;
 		}
-- 
Mel Gorman
SUSE Labs
