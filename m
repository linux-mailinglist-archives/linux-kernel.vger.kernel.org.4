Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5464756A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLHSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLHSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:17:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1F18393
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:17:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E039208C5;
        Thu,  8 Dec 2022 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670523469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WOpbqhi4deoSPQ5gjb+StOVqnfFIV+93wgbp/8W+O+E=;
        b=1KSv5ZPicrjspUpQgVfP5D7FhQYHnvc+FaGZQR6RMgEY7A+G91LNeXkAGT6s2lWhUvGno8
        BGlQZUw6ccq1iRdRElG7L4tiyQnPAFRfqlOe6HAE8poCMsz82FtoQbFN/wTIPc+RkGYR7F
        t7Ur75e/ldHF7e3LbCA8DFm9oDdX16s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670523469;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WOpbqhi4deoSPQ5gjb+StOVqnfFIV+93wgbp/8W+O+E=;
        b=XBUKp0CH5acsWj28r2DVmK+P6suJul5ddvzmk9HmNOLh8EEVKxMDHMf6Wd5noRThT5bVGp
        eIIDqVE456wlWLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2922D138E0;
        Thu,  8 Dec 2022 18:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8c0mCU0qkmNYVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 08 Dec 2022 18:17:49 +0000
Message-ID: <e7b8c312-5433-757d-fb9c-f2f993e4f999@suse.cz>
Date:   Thu, 8 Dec 2022 19:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 6/6] mm: discard __GFP_ATOMIC
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221129151701.23261-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 16:17, Mel Gorman wrote:
> From: NeilBrown <neilb@suse.de>
> 
> __GFP_ATOMIC serves little purpose.  Its main effect is to set
> ALLOC_HARDER which adds a few little boosts to increase the chance of an
> allocation succeeding, one of which is to lower the water-mark at which it
> will succeed.
> 
> It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> adjusts this watermark.  It is probable that other users of __GFP_HIGH
> should benefit from the other little bonuses that __GFP_ATOMIC gets.
> 
> __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM.
> There is little point to this.  We already get a might_sleep() warning if
> __GFP_DIRECT_RECLAIM is set.
> 
> __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> probable that testing ALLOC_HARDER is a better fit here.
> 
> __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> 
> This patch:
>  - removes __GFP_ATOMIC
>  - allows __GFP_HIGH allocations to ignore watermark boosting as well
>    as GFP_ATOMIC requests.
>  - makes other adjustments as suggested by the above.
> 
> The net result is not change to GFP_ATOMIC allocations.  Other
> allocations that use __GFP_HIGH will benefit from a few different extra
> privileges.  This affects:
>   xen, dm, md, ntfs3
>   the vermillion frame buffer
>   hibernation
>   ksm
>   swap
> all of which likely produce more benefit than cost if these selected
> allocation are more likely to succeed quickly.
> 
> [mgorman: Minor adjustments to rework on top of a series]
> Link: https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name
> Signed-off-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Just a nit below.


> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4081,13 +4081,14 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
>  					free_pages))
>  		return true;
> +
>  	/*
> -	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> +	 * Ignore watermark boosting for GFP_HIGH order-0 allocations

There's no GFP_HIGH. We could either keep GFP_ATOMIC here if we want to talk
about the high-level flag combo, or __GFP_HIGH if about the low-level
detail. We're deep in the page allocator implementation so the latter would
be OK.

>  	 * when checking the min watermark. The min watermark is the
>  	 * point where boosting is ignored so that kswapd is woken up
>  	 * when below the low watermark.
>  	 */
> -	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
> +	if (unlikely(!order && (alloc_flags & ALLOC_MIN_RESERVE) && z->watermark_boost

