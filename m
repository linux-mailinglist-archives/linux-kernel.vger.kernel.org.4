Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBF710748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbjEYI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEYI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3299
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8426A61870
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ADAC433EF;
        Thu, 25 May 2023 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685003204;
        bh=G5OcWyr2B122xVxY4jWblz0GjpAgP1YgwoGovSGpD6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Skq/px/LD9AWrEW21C+JiplzLT933iwefqVEE/ES4HQWqWRvI58QrCMTQna8tMjRh
         y9JFaZfEpRX1IHKqh1CFn4UyvylK6puq66sOkRvOCGoUzEeu546iXGzAhg+PwwsqBp
         YxDttTA2CcVeA4I9jSuxaUXnVY0/12H3cQS1CY2QhfosbhLiPWjYiwi115WBN6TrOU
         V+GGutoJIdL3iDw7jeSOh/DzpQQp+r7wM6TvseL9nbnQIjyFzaM45vbm4V4IS+S7RN
         2vw52hFQqpLhf2v+4O3OFsMIobyk3IoxXJ7uJEVmOG13v+zVrkhezchKWaVgxi3P7f
         2kGnRPKrKEaaw==
Date:   Thu, 25 May 2023 11:26:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mm_init.c: do not calculate
 zone_start_pfn/zone_end_pfn in zone_absent_pages_in_node()
Message-ID: <20230525082624.GU4967@kernel.org>
References: <20230525040150.1588-3-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040150.1588-3-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:01:50AM +0000, Haifeng Xu wrote:
> In calculate_node_totalpages(), zone_start_pfn/zone_end_pfn are
> calculated in zone_spanned_pages_in_node(), so use them as parameters
> instead of node_start_pfn/node_end_pfn and the duplicated calculation
> process can de dropped.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/mm_init.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 898af4eb9ce2..88c4a9266e2a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1166,23 +1166,11 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
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
> -	if (!node_start_pfn && !node_end_pfn)
> -		return 0;
> -
> -	zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
> -	zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
> -
> -	adjust_zone_range_for_zone_movable(nid, zone_type,
> -			node_start_pfn, node_end_pfn,
> -			&zone_start_pfn, &zone_end_pfn);
>  	nr_absent = __absent_pages_in_range(nid, zone_start_pfn, zone_end_pfn);
>  
>  	/*
> @@ -1254,6 +1242,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  						unsigned long node_end_pfn)
>  {
>  	unsigned long realtotalpages = 0, totalpages = 0;
> +	int nid = pgdat->node_id;
>  	enum zone_type i;
>  
>  	for (i = 0; i < MAX_NR_ZONES; i++) {
> @@ -1262,15 +1251,15 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  		unsigned long spanned, absent;
>  		unsigned long real_size;
>  
> -		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
> -						     node_start_pfn,
> -						     node_end_pfn,
> -						     &zone_start_pfn,
> -						     &zone_end_pfn);
> +		spanned = zone_spanned_pages_in_node(nid, i,
> +						node_start_pfn,
> +						node_end_pfn,
> +						&zone_start_pfn,
> +						&zone_end_pfn);

Please remove unrelated whitespace changes.
Also I don't see a strong need to replace pgdat->node_id with a local
variable here and below.

>  		if (spanned) {
> -			absent = zone_absent_pages_in_node(pgdat->node_id, i,
> -							   node_start_pfn,
> -							   node_end_pfn);
> +			absent = zone_absent_pages_in_node(nid, i,
> +							zone_start_pfn,
> +							zone_end_pfn);
>  			real_size = spanned - absent;
>  			zone->zone_start_pfn = zone_start_pfn;
>  		} else {
> @@ -1289,7 +1278,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  
>  	pgdat->node_spanned_pages = totalpages;
>  	pgdat->node_present_pages = realtotalpages;
> -	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
> +	pr_debug("On node %d totalpages: %lu\n", nid, realtotalpages);
>  }
>  
>  static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
