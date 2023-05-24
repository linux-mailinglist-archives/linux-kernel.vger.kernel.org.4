Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05670F22D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjEXJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEXJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:22:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094E196
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7AECC223F2;
        Wed, 24 May 2023 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684920103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QM4gol7aWxHM+cK08fFzQCFpDFcExgXFNwjtTAaTJjY=;
        b=mGN2Q5yYXM3sOwkoOzVucYbctEeSV5S5CjOkCLnGTEX4OefaG6LdHozlo7VP6XoyR3w+zs
        aJwyN3Q3+kc0eBbgdcW+P4FmyeclYPk/qqszRMsJp/LXntlCz/P+YfHAy8JVcr78Ojuf9d
        umqXoEZQEF0uc3ym2HPN+x4PINZXtcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684920103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QM4gol7aWxHM+cK08fFzQCFpDFcExgXFNwjtTAaTJjY=;
        b=9ATs2viGI7oMBF8q/E6X4vUArTOwZzfVhlcbq6P33XT0G6FbJMnW7Si8dFysJ8aGcssps7
        BFFLOTiMxG6dFSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D43813425;
        Wed, 24 May 2023 09:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qIIJFifXbWSnewAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 May 2023 09:21:43 +0000
Message-ID: <8fd1a56d-5a22-4bde-59a5-169a4696219e@suse.cz>
Date:   Wed, 24 May 2023 11:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm: compaction: avoid GFP_NOFS ABBA deadlock
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230519111359.40475-1-hannes@cmpxchg.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230519111359.40475-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 13:13, Johannes Weiner wrote:
> During stress testing with higher-order allocations, a deadlock
> scenario was observed in compaction: One GFP_NOFS allocation was
> sleeping on mm/compaction.c::too_many_isolated(), while all CPUs in
> the system were busy with compactors spinning on buffer locks held by
> the sleeping GFP_NOFS allocation.
> 
> Reclaim is susceptible to this same deadlock; we fixed it by granting
> GFP_NOFS allocations additional LRU isolation headroom, to ensure it
> makes forward progress while holding fs locks that other reclaimers
> might acquire. Do the same here.
> 
> This code has been like this since compaction was initially merged,
> and I only managed to trigger this with out-of-tree patches that
> dramatically increase the contexts that do GFP_NOFS compaction. While
> the issue is real, it seems theoretical in nature given existing
> allocation sites. Worth fixing now, but no Fixes tag or stable CC.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

So IIUC the change is done by not giving GFP_NOFS extra headroom, but
instead restricting the headroom of __GFP_FS allocations. But the original
one was probably too generous anyway so it should be fine?

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> v2:
> - clarify too_many_isolated() comment (Mel)
> - split isolation deadlock from no-contiguous-anon lockups as that's
>   a different scenario and deserves its own patch
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c8bcdea15f5f..c9a4b6dffcf2 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -745,8 +745,9 @@ isolate_freepages_range(struct compact_control *cc,
>  }
>  
>  /* Similar to reclaim, but different enough that they don't share logic */
> -static bool too_many_isolated(pg_data_t *pgdat)
> +static bool too_many_isolated(struct compact_control *cc)
>  {
> +	pg_data_t *pgdat = cc->zone->zone_pgdat;
>  	bool too_many;
>  
>  	unsigned long active, inactive, isolated;
> @@ -758,6 +759,17 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
>  			node_page_state(pgdat, NR_ISOLATED_ANON);
>  
> +	/*
> +	 * Allow GFP_NOFS to isolate past the limit set for regular
> +	 * compaction runs. This prevents an ABBA deadlock when other
> +	 * compactors have already isolated to the limit, but are
> +	 * blocked on filesystem locks held by the GFP_NOFS thread.
> +	 */
> +	if (cc->gfp_mask & __GFP_FS) {
> +		inactive >>= 3;
> +		active >>= 3;
> +	}
> +
>  	too_many = isolated > (inactive + active) / 2;
>  	if (!too_many)
>  		wake_throttle_isolated(pgdat);
> @@ -806,7 +818,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	 * list by either parallel reclaimers or compaction. If there are,
>  	 * delay for some time until fewer pages are isolated
>  	 */
> -	while (unlikely(too_many_isolated(pgdat))) {
> +	while (unlikely(too_many_isolated(cc))) {
>  		/* stop isolation if there are still pages not migrated */
>  		if (cc->nr_migratepages)
>  			return -EAGAIN;

