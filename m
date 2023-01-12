Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12632666C23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbjALILW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbjALILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:11:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B8E022
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:11:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD5243F60C;
        Thu, 12 Jan 2023 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673511067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3rOVtr3FiiKyQNYoIzTg/bnyNbi0bomA2m3YXQL33w=;
        b=MXQcfGJtyiYGn9YKNiZfgcR6UavUB8jL8lrmiMtqR5MAAPuSmslm2tPu1u2O3i7WdJc7xf
        fgiRDb2OA5aUFeAi8O4AyRa3VF3VNQJkGaQxYiw7u47jzOTjWXI7csyGvxHITikyKaXi1M
        MRzCvMocbBP6zr3ga7ziGR4sfiNy87M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACB80134B3;
        Thu, 12 Jan 2023 08:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jyjfJ5vAv2NJaAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 12 Jan 2023 08:11:07 +0000
Date:   Thu, 12 Jan 2023 09:11:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Message-ID: <Y7/AmgN1Wz73lyVz@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-7-mgorman@techsingularity.net>
 <Y77cikPSHepZ/GQj@dhcp22.suse.cz>
 <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-01-23 17:05:52, Mel Gorman wrote:
> On Wed, Jan 11, 2023 at 04:58:02PM +0100, Michal Hocko wrote:
> > On Mon 09-01-23 15:16:30, Mel Gorman wrote:
> > > Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> > > vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> > > other non-blocking allocation requests equal access to reserve.  Rename
> > > ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> > > means.
> > 
> > GFP_NOWAIT can be also used for opportunistic allocations which can and
> > should fail quickly if the memory is tight and more elaborate path
> > should be taken (e.g. try higher order allocation first but fall back to
> > smaller request if the memory is fragmented). Do we really want to give
> > those access to memory reserves as well?
> 
> Good question. Without __GFP_ATOMIC, GFP_NOWAIT only differs from GFP_ATOMIC
> by __GFP_HIGH but that is not enough to distinguish between a caller that
> cannot sleep versus one that is speculatively attempting an allocation but
> has other options. That changelog is misleading, it's not equal access
> as GFP_NOWAIT ends up with 25% of the reserves which is less than what
> GFP_ATOMIC gets.
> 
> Because it becomes impossible to distinguish between non-blocking and
> atomic without __GFP_ATOMIC, there is some justification for allowing
> access to reserves for GFP_NOWAIT. bio for example attempts an allocation
> (clears __GFP_DIRECT_RECLAIM) before falling back to mempool but delays
> in IO can also lead to further allocation pressure. mmu gather failing
> GFP_WAIT slows the rate memory can be freed. NFS failing GFP_NOWAIT will
> have to retry IOs multiple times. The examples were picked at random but
> the point is that there are cases where failing GFP_NOWAIT can degrade
> the system, particularly delay the cleaning of pages before reclaim.

Fair points.

> A lot of the truly speculative users appear to use GFP_NOWAIT | __GFP_NOWARN
> so one compromise would be to avoid using reserves if __GFP_NOWARN is
> also specified.
> 
> Something like this as a separate patch?

I cannot say I would be happy about adding more side effects to
__GFP_NOWARN. You are right that it should be used for those optimistic
allocation requests but historically all many of these subtle side effects
have kicked back at some point. Wouldn't it make sense to explicitly
mark those places which really benefit from reserves instead? This is
more work but it should pay off long term. Your examples above would use
GFP_ATOMIC instead of GFP_NOWAIT.

The semantic would be easier to explain as well. GFP_ATOMIC - non
sleeping allocations which are important so they have access to memory
reserves. GFP_NOWAIT - non sleeping allocations.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7244ab522028..0a7a0ac1b46d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4860,9 +4860,11 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
>  		/*
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
> -		 * if it can't schedule.
> +		 * if it can't schedule. Similarly, a caller specifying
> +		 * __GFP_NOWARN is likely a speculative allocation with a
> +		 * graceful recovery path.
>  		 */
> -		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
> +		if (!(gfp_mask & (__GFP_NOMEMALLOC|__GFP_NOWARN))) {
>  			alloc_flags |= ALLOC_NON_BLOCK;
>  
>  			if (order > 0)

-- 
Michal Hocko
SUSE Labs
