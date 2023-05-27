Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11F713336
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjE0H5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjE0H5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C65B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82F261355
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 07:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6085C433EF;
        Sat, 27 May 2023 07:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685174249;
        bh=QVGsdUWRa7+6zdomEtsHcXdZSbuGegR+5TFaLMUQvEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZUSTqgKkqifSGE1El9TcNeSYuoe5dbA/eaBUZUkYlUC7So1rdOvNFCGUpVMJss31
         DJSG/W4JlcPrciNeL7QHFYuSFfdzefd3+DUT5bkVTiJS6T0YEHLpisOjLp/n8xKxy9
         GXF0WDNcVXePYT9ESOF/GKYFrixzwf2kc+KlqVNQblT4a31F2sAc/VutdMsk7PzqBH
         wdpy18cZJnCoGMvbScyO9HxvQ/4m3+mBBh9JC4551BM3wePdSfHcuyPiZWSC7+KKaK
         +a1/lzhwqFTlEKn2eIW0zxOutsm8pY5ZwsGyU3YyHdo82wHrKCgxzFDBbuNU4gr7bA
         XgtB7Kw97pd+Q==
Date:   Sat, 27 May 2023 10:57:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/mm_init.c: introduce
 reset_memoryless_node_totalpages()
Message-ID: <20230527075707.GC4967@kernel.org>
References: <20230526085251.1977-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526085251.1977-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:52:50AM +0000, Haifeng Xu wrote:
> Currently, no matter whether a node actually has memory or not,
> calculate_node_totalpages() is used to account number of pages
> in zone/node. However, for node without memory, these unnecessary
> calculations can be skipped. All the zone/node page counts can be
> set to 0 directly. So introduce reset_memoryless_node_totalpages()
> to perform this action.
> 
> Furthermore, calculate_node_totalpages() only gets called for the
> node with memory.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2:
> - drop patch 2 in v1
> - inroduce new function reset_memoryless_node_totalpages()
> - call calculate_node_totalpages only if node actually has
>   memory
> ---
>  mm/mm_init.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 7f7f9c677854..f674e5798f7d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1174,10 +1174,6 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
>  	unsigned long zone_start_pfn, zone_end_pfn;
>  	unsigned long nr_absent;
>  
> -	/* When hotadd a new node from cpu_up(), the node should be empty */
> -	if (!node_start_pfn && !node_end_pfn)
> -		return 0;
> -
>  	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
>  	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
>  
> @@ -1227,9 +1223,6 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
>  {
>  	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
>  	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
> -	/* When hotadd a new node from cpu_up(), the node should be empty */
> -	if (!node_start_pfn && !node_end_pfn)
> -		return 0;
>  
>  	/* Get the start and end of the zone */
>  	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
> @@ -1250,6 +1243,24 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
>  	return *zone_end_pfn - *zone_start_pfn;
>  }
>  
> +static void __init reset_memoryless_node_totalpages(struct pglist_data *pgdat)
> +{
> +	struct zone *z;
> +
> +	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++) {
> +		z->zone_start_pfn = 0;
> +		z->spanned_pages = 0;
> +		z->present_pages = 0;
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +		z->present_early_pages = 0;
> +#endif
> +	}
> +
> +	pgdat->node_spanned_pages = 0;
> +	pgdat->node_present_pages = 0;
> +	pr_debug("On node %d totalpages: 0\n", pgdat->node_id);
> +}
> +
>  static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  						unsigned long node_start_pfn,
>  						unsigned long node_end_pfn)
> @@ -1702,11 +1713,13 @@ static void __init free_area_init_node(int nid)
>  		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
>  			(u64)start_pfn << PAGE_SHIFT,
>  			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
> +
> +		calculate_node_totalpages(pgdat, start_pfn, end_pfn);
>  	} else {
>  		pr_info("Initmem setup node %d as memoryless\n", nid);
> -	}
>  
> -	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
> +		reset_memoryless_node_totalpages(pgdat);
> +	}
>  
>  	alloc_node_mem_map(pgdat);
>  	pgdat_set_deferred_range(pgdat);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
