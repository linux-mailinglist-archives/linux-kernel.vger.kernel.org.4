Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EE6724376
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbjFFM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbjFFM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:59:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84410F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:58:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D16B1FD69;
        Tue,  6 Jun 2023 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686056328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OK2MXuNECGDPqZjzgWmkfkpBDGL9oo5X3x657WZQzkQ=;
        b=Sb/NBavrX9jHmuTQFxeQ9qYdZQf/zHtquhKvhHK82pROP9omA0OTf6E4kQFM8wn5toWyj9
        r0/TztDOFtsKu2cLASCiAqCJBSpnwLMbAV7yt/uTjfTlaPZWEohD+m7G8yo/3XTv9/lO0+
        BeVPi9sopC3bakb3uRu1cG8bX0VCnS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686056328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OK2MXuNECGDPqZjzgWmkfkpBDGL9oo5X3x657WZQzkQ=;
        b=97PTe0rkr3N5KOuUb6FflHjPTeTP08novX++g7/NvE1daNX2Qm8eXZOXEHo+uPp2rNFZ9M
        lwwwLHpMyA7f76Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31ECB13776;
        Tue,  6 Jun 2023 12:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JcFqC4gtf2TuSwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 06 Jun 2023 12:58:48 +0000
Message-ID: <1296cd8a-fd28-98fe-b132-c168d46e3202@suse.cz>
Date:   Tue, 6 Jun 2023 14:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/5] mm: compaction: simplify should_compact_retry()
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-3-hannes@cmpxchg.org>
 <1c3c9305-a678-279e-f015-7aed544ab3c8@suse.cz>
 <20230529163805.GA84971@cmpxchg.org> <20230602144705.GB161817@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230602144705.GB161817@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 16:47, Johannes Weiner wrote:
> On Mon, May 29, 2023 at 12:38:07PM -0400, Johannes Weiner wrote:
>> On Mon, May 29, 2023 at 03:03:52PM +0200, Vlastimil Babka wrote:
>> > I think you simplified this part too much, so now once it runs out of
>> > retries, it will return false, while previously it would increase the priority.
> 
> Here is the delta fix. If this looks good to everybody, can you please
> fold this into the patch you have in tree? Thanks!
> 
> ---
> From 4b9429f9ef04fcb7bb5ffae0db8ea113b26d097b Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 2 Jun 2023 16:02:37 +0200
> Subject: [PATCH] mm: compaction: simplify should_compact_retry() fix
> 
> Vlastimil points out an unintended change. Previously when hitting
> max_retries we'd bump the priority level and restart the loop. Now we
> bail out and fail instead. Restore the original behavior.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

For the 2/5 +fix

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 72660e924b95..e7d7db36582b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3768,6 +3768,15 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	if (fatal_signal_pending(current))
>  		return false;
>  
> +	/*
> +	 * Compaction was skipped due to a lack of free order-0
> +	 * migration targets. Continue if reclaim can help.
> +	 */
> +	if (compact_result == COMPACT_SKIPPED) {
> +		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
> +		goto out;
> +	}
> +
>  	/*
>  	 * Compaction managed to coalesce some page blocks, but the
>  	 * allocation failed presumably due to a race. Retry some.
> @@ -3785,17 +3794,10 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  		if (order > PAGE_ALLOC_COSTLY_ORDER)
>  			max_retries /= 4;
>  
> -		ret = ++(*compaction_retries) <= max_retries;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Compaction was skipped due to a lack of free order-0
> -	 * migration targets. Continue if reclaim can help.
> -	 */
> -	if (compact_result == COMPACT_SKIPPED) {
> -		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
> -		goto out;
> +		if (++(*compaction_retries) <= max_retries) {
> +			ret = true;
> +			goto out;
> +		}
>  	}
>  
>  	/*

