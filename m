Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0465D205
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjADMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbjADMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:04:47 -0500
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBAB321A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:04:39 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 63AC5BECEE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:04:38 +0000 (GMT)
Received: (qmail 28552 invoked from network); 4 Jan 2023 12:04:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Jan 2023 12:04:38 -0000
Date:   Wed, 4 Jan 2023 12:04:36 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] mm: discard __GFP_ATOMIC
Message-ID: <20230104120436.nto7semvbrsvakjg@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-7-mgorman@techsingularity.net>
 <e7b8c312-5433-757d-fb9c-f2f993e4f999@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e7b8c312-5433-757d-fb9c-f2f993e4f999@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:17:48PM +0100, Vlastimil Babka wrote:
> > @@ -4081,13 +4081,14 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> >  	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
> >  					free_pages))
> >  		return true;
> > +
> >  	/*
> > -	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> > +	 * Ignore watermark boosting for GFP_HIGH order-0 allocations
> 
> There's no GFP_HIGH. We could either keep GFP_ATOMIC here if we want to talk
> about the high-level flag combo, or __GFP_HIGH if about the low-level
> detail. We're deep in the page allocator implementation so the latter would
> be OK.
> 

Fixed

-- 
Mel Gorman
SUSE Labs
