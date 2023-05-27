Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37759713335
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjE0IAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjE0IAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A5B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 915B661013
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE395C433D2;
        Sat, 27 May 2023 08:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685174434;
        bh=1IJdM/Bry22ESZ9un0C7ZvpkLJqgF412vz9PcaQjdIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrCI02dryYG9OHO3mYKo2BBgLeIlw+ElNUV0aH9Wdc/NH2b+J5QIdIGXJexUS5sNW
         +JMj5YGpSOLFP+yOoBAso0dUSDDFSrfOQOPGYZruEwUHLV/pAizUbs/n5SPx+1rEZ7
         +YEHSd4tlKNmlGsRfmPCj5ufH3dYpSVv9RMIAyb6+72bpvhbqnTyhVL6KrMAv8Db2Y
         S7mgF2AbAwDtFYfIFZhvuyNK5skvr+CzUwRFmqibpVRT8xjAbjiQD9fQC7zv6IFBsP
         6tQxC0qR+rp7FUB99VtQTeh5YSkQcxAPWYVd9NElX3tcssMp7qesq1X2cCaKu0EBlC
         K+W/iSib06T8A==
Date:   Sat, 27 May 2023 11:00:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/mm_init.c: do not calculate
 zone_start_pfn/zone_end_pfn in zone_absent_pages_in_node()
Message-ID: <20230527080014.GD4967@kernel.org>
References: <20230526085251.1977-2-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526085251.1977-2-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:52:51AM +0000, Haifeng Xu wrote:
> In calculate_node_totalpages(), zone_start_pfn/zone_end_pfn are already
> calculated in zone_spanned_pages_in_node(), so use them as parameters
> instead of node_start_pfn/node_end_pfn and the duplicated calculation
> process can de dropped.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2:
> - remove unrelated whitespace changes
> - do not replace pgdat->node_id with a local
>   variable
> - remove redundant variable 'size'
> - add check that whether a zone is empty or not
> ---
>  mm/mm_init.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f674e5798f7d..2d91bb52c619 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1166,20 +1166,15 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
>  /* Return the number of page frames in holes in a zone on a node */
>  static unsigned long __init zone_absent_pages_in_node(int nid,
>  					unsigned long zone_type,
> -					unsigned long node_start_pfn,
> -					unsigned long node_end_pfn)
> +					unsigned long zone_start_pfn,
> +					unsigned long zone_end_pfn)
>  {
> -	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
> -	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
> -	unsigned long zone_start_pfn, zone_end_pfn;
>  	unsigned long nr_absent;
>  
> -	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
> -	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
> +	/* zone is empty, we don't have any absent pages */
> +	if (zone_start_pfn == zone_end_pfn)
> +		return 0;
>  
> -	adjust_zone_range_for_zone_movable(nid, zone_type,
> -			node_start_pfn, node_end_pfn,
> -			&zone_start_pfn, &zone_end_pfn);
>  	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
>  
>  	/*
> @@ -1272,7 +1267,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  		struct zone *zone = pgdat->node_zones + i;
>  		unsigned long zone_start_pfn, zone_end_pfn;
>  		unsigned long spanned, absent;
> -		unsigned long size, real_size;
> +		unsigned long real_size;
>  
>  		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
>  						     node_start_pfn,
> @@ -1280,23 +1275,22 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  						     &zone_start_pfn,
>  						     &zone_end_pfn);
>  		absent = zone_absent_pages_in_node(pgdat->node_id, i,
> -						   node_start_pfn,
> -						   node_end_pfn);
> +						   zone_start_pfn,
> +						   zone_end_pfn);
>  
> -		size = spanned;
> -		real_size = size - absent;
> +		real_size = spanned - absent;
>  
> -		if (size)
> +		if (spanned)
>  			zone->zone_start_pfn = zone_start_pfn;
>  		else
>  			zone->zone_start_pfn = 0;
> -		zone->spanned_pages = size;
> +		zone->spanned_pages = spanned;
>  		zone->present_pages = real_size;
>  #if defined(CONFIG_MEMORY_HOTPLUG)
>  		zone->present_early_pages = real_size;
>  #endif
>  
> -		totalpages += size;
> +		totalpages += spanned;
>  		realtotalpages += real_size;
>  	}
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
