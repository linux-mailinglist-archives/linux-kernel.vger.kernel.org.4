Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F39665F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjAKP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjAKP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:27:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01442FE3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:27:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 281B94C5E;
        Wed, 11 Jan 2023 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673450850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1eUl4jxJDNbdWQ3YdpoRYPsUON8AwuxLmE+58zdEI8=;
        b=j9o3aXuenBDvWzcYcaXN+hiTaQVHhxazS18bRxTnhkfYvi5JOhSgtrg2Hf4e+Xqi04fKmd
        TuNi+rPP6LqMjUIZdAfUDWXLdjuX5xo6zLWqYmipOMkQAPMH/wvnftojVMgIcXKOn+ksD0
        c6o2yKb0HBTj4rxsT7BodMlgkh0S3Hg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 069ED1358A;
        Wed, 11 Jan 2023 15:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t2vqOmHVvmOvMgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 15:27:29 +0000
Date:   Wed, 11 Jan 2023 16:27:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Message-ID: <Y77VYdboKBUsILhD@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109151631.24923-3-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 15:16:26, Mel Gorman wrote:
> RT tasks are allowed to dip below the min reserve but ALLOC_HARDER is
> typically combined with ALLOC_MIN_RESERVE so RT tasks are a little
> unusual. While there is some justification for allowing RT tasks
> access to memory reserves, there is a strong chance that a RT task
> that is also under memory pressure is at risk of missing deadlines
> anyway. Relax how much reserves an RT task can access by treating
> it the same as __GFP_HIGH allocations.

TBH, I would much rather drop the RT special casing here. As you say if
a RT task need to dip into memory reserves it is either already too late
because the execution is already under RT constrains or this is init
phase where the reclaim is not a problem yet.

I have tried to trace down this special case and only found a patch from
Robert Love from 2003 which says:
: - Let real-time tasks dip further into the reserves than usual in
:   __alloc_pages().  There are a lot of ways to special case this.  This
:   patch just cuts z->pages_low in half, before doing the incremental min
:   thing, for real-time tasks.  I do not do anything in the low memory slow
:   path.  We can be a _lot_ more aggressive if we want.  Right now, we just
:   give real-time tasks a little help.

This doesn't really explain why this is needed.

We are really great at preserving a behavior and cementing it for
future generations. Maybe we should just drop it and see if something
breaks. We would get some reasoning at least finally.

So I am not opposed to the patch per se but I would much rather see this
branch go away. If you want me I can condense the above into a changelog
and send a patch (either on top of this one or replacing it). WDYT?

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 244c1e675dc8..0040b4e00913 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4847,7 +4847,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  		 */
>  		alloc_flags &= ~ALLOC_CPUSET;
>  	} else if (unlikely(rt_task(current)) && in_task())
> -		alloc_flags |= ALLOC_HARDER;
> +		alloc_flags |= ALLOC_MIN_RESERVE;
>  
>  	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
>  
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
