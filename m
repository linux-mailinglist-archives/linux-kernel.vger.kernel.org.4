Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC006901EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBIIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:12:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE303B0FD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:12:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC4E734EE5;
        Thu,  9 Feb 2023 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675930351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOVo2W/NrKuKki1TsxqsoW2omFPhUBOvX9kvZ0SIc4w=;
        b=YWx/8K6kZ0h5qgQKdGnFuV6lEJVMK7Ou+5EmOsVJhfangpU0zb5ZOEShdZ83CEJhUaHXM0
        EUfGXy7u3fipxFBUzHyL+KjsjMt5Y6uheLEYfL+L/3cxmgqjxPXVWbc0IKS7hRSLYhGVVl
        TRx+GtyhkZ6gKJcg57VrIRefOGfpPsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675930351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOVo2W/NrKuKki1TsxqsoW2omFPhUBOvX9kvZ0SIc4w=;
        b=q7ceL1PukVH3r+Ckrs+gZxrPCZStjsv4ZBLzOU8R7MGur3l1ZvgN6PKUBVufHeCr4I2ywx
        1GbZJZyhjtxe23CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FB8713A1F;
        Thu,  9 Feb 2023 08:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yGNCJu+q5GNADAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Feb 2023 08:12:31 +0000
Message-ID: <362e1270-8a54-36f5-f7c0-d922b3d12860@suse.cz>
Date:   Thu, 9 Feb 2023 09:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/page_alloc: optimize the loop in
 find_suitable_fallback()
To:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, mgorman@techsingularity.net, david@redhat.com,
        rppt@linux.ibm.com, osalvador@suse.de, rppt@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230209024435.3392916-1-yajun.deng@linux.dev>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230209024435.3392916-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 03:44, Yajun Deng wrote:
> There is no need to execute the next loop if it not return in the first
> loop. So add a break at the end of the loop.
> 
> There are only three rows in fallbacks, so reduce the first index size
> from MIGRATE_TYPES to MIGRATE_PCPTYPES.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1113483fa6c5..536e8d838fb5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>   *
>   * The other migratetypes do not have fallbacks.
>   */
> -static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {
> +static int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
>  	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },
> @@ -2861,7 +2861,7 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>  	int i;
>  	int fallback_mt;
>  
> -	if (area->nr_free == 0)
> +	if (area->nr_free == 0 || !migratetype_is_mergeable(migratetype))

Just curious, did you the check for extra safety or did you find (by running
or code inspection) that this can be indeed called with a non-mergeable
migratetype, and cause out of bounds access of the shrinked fallbacks array?

BTW, I noticed the commment on migratetype_is_mergeable() contains:

"See fallbacks[MIGRATE_TYPES][3] in page_alloc.c. "

Should probably change it to e.g. "See fallbacks[][] array ..." so we don't
have to keep it in exact sync...

>  		return -1;
>  
>  	*can_steal = false;
> @@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>  		if (can_steal_fallback(order, migratetype))
>  			*can_steal = true;
>  
> -		if (!only_stealable)
> -			return fallback_mt;
> -
> -		if (*can_steal)
> +		if (!only_stealable || *can_steal)
>  			return fallback_mt;
> +		else
> +			break;
>  	}
>  
>  	return -1;

