Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB83A7149D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjE2NEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjE2NDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:03:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3762B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:03:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 568761F88E;
        Mon, 29 May 2023 13:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685365433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tc5kSCmE2FMssHmpJJAR9HCJO9j6BfEH8BHbYAEXixc=;
        b=AvJfha7PIKScylt2Z/almeX1F5TD0fU21Msa+qwAegXte80G6b+8M+99OOrFz4mt/SNK0s
        T+gYD9w0lREPEW6qTnacnociAi7VKwntYyTsMPmYIpIGp+ZgzNAOtppIJZHHXvCKUtKm2j
        bB972uronf/uWmCr7PlaAPVTGTCQJ2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685365433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tc5kSCmE2FMssHmpJJAR9HCJO9j6BfEH8BHbYAEXixc=;
        b=RlzNCcpoH9Y2NmrGJQX69OAIR5iUyDmtNTwx5iyWcDylK+hlLd9CetIRX+rGGWRCbxYqC6
        z2wTFHg3E44wRdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3297C13466;
        Mon, 29 May 2023 13:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NyL/CrmidGSaIQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 29 May 2023 13:03:53 +0000
Message-ID: <1c3c9305-a678-279e-f015-7aed544ab3c8@suse.cz>
Date:   Mon, 29 May 2023 15:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/5] mm: compaction: simplify should_compact_retry()
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-3-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230519123959.77335-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 14:39, Johannes Weiner wrote:
> The different branches for retry are unnecessarily complicated. There
> are really only three outcomes: progress (retry n times), skipped
> (retry if reclaim can help), failed (retry with higher priority).
> 
> Rearrange the branches and the retry counter to make it simpler.
> 
> v2:
> - fix trace point build (Mel)
> - fix max_retries logic for costly allocs (Huang)
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 53 +++++++++++++++----------------------------------
>  1 file changed, 16 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5a84a0bebc37..72660e924b95 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3772,16 +3772,22 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	 * Compaction managed to coalesce some page blocks, but the
>  	 * allocation failed presumably due to a race. Retry some.
>  	 */
> -	if (compact_result == COMPACT_SUCCESS)
> -		(*compaction_retries)++;
> +	if (compact_result == COMPACT_SUCCESS) {
> +		/*
> +		 * !costly requests are much more important than
> +		 * __GFP_RETRY_MAYFAIL costly ones because they are de
> +		 * facto nofail and invoke OOM killer to move on while
> +		 * costly can fail and users are ready to cope with
> +		 * that. 1/4 retries is rather arbitrary but we would
> +		 * need much more detailed feedback from compaction to
> +		 * make a better decision.
> +		 */
> +		if (order > PAGE_ALLOC_COSTLY_ORDER)
> +			max_retries /= 4;
>  
> -	/*
> -	 * All zones were scanned completely and still no result. It
> -	 * doesn't really make much sense to retry except when the
> -	 * failure could be caused by insufficient priority
> -	 */
> -	if (compact_result == COMPACT_COMPLETE)
> -		goto check_priority;
> +		ret = ++(*compaction_retries) <= max_retries;
> +		goto out;

I think you simplified this part too much, so now once it runs out of
retries, it will return false, while previously it would increase the priority.

> +	}
>  
>  	/*
>  	 * Compaction was skipped due to a lack of free order-0
> @@ -3793,35 +3799,8 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	}
>  
>  	/*
> -	 * If compaction backed due to being deferred, due to
> -	 * contended locks in async mode, or due to scanners meeting
> -	 * after a partial scan, retry with increased priority.
> -	 */
> -	if (compact_result == COMPACT_DEFERRED ||
> -	    compact_result == COMPACT_CONTENDED ||
> -	    compact_result == COMPACT_PARTIAL_SKIPPED)
> -		goto check_priority;
> -
> -	/*
> -	 * !costly requests are much more important than __GFP_RETRY_MAYFAIL
> -	 * costly ones because they are de facto nofail and invoke OOM
> -	 * killer to move on while costly can fail and users are ready
> -	 * to cope with that. 1/4 retries is rather arbitrary but we
> -	 * would need much more detailed feedback from compaction to
> -	 * make a better decision.
> -	 */
> -	if (order > PAGE_ALLOC_COSTLY_ORDER)
> -		max_retries /= 4;
> -	if (*compaction_retries <= max_retries) {
> -		ret = true;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Make sure there are attempts at the highest priority if we exhausted
> -	 * all retries or failed at the lower priorities.
> +	 * Compaction failed. Retry with increasing priority.
>  	 */
> -check_priority:
>  	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
>  			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
>  

