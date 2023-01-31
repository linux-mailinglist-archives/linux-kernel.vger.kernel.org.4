Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B468257F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjAaHXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaHXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:23:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4002C30280
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:23:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4FF2F4;
        Mon, 30 Jan 2023 23:24:14 -0800 (PST)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72CD3F71E;
        Mon, 30 Jan 2023 23:23:28 -0800 (PST)
Message-ID: <4f088ff9-d88b-e35b-e8b5-712874b2be8c@arm.com>
Date:   Tue, 31 Jan 2023 12:53:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Content-Language: en-US
To:     Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 12:40, Sukadev Bhattiprolu wrote:
> 
> Commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma pageblocks for movable allocations")
> added support to use CMA pages when more than 50% of total free pages in
> the zone are free CMA pages.
> 
> However, with multiplatform kernels a single binary is used across different
> targets of varying memory sizes. A low memory target using one such kernel
> would incur allocation failures even when sufficient memory is available in
> the CMA region. On these targets we would want to utilize a higher percentage
> of the CMA region and reduce the allocation failures, even if it means that a
> subsequent cma_alloc() would take longer.
> 
> Make the percentage of CMA utilization a configurable parameter to allow
> for such usecases.
> 
> Signed-off-by: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
> ---
> Note:	There was a mention about it being the last resort to making this
> 	percentage configurable (https://lkml.org/lkml/2020/3/12/751). But
> 	as explained above, multi-platform kernels for varying memory size
> 	targets would need this to be configurable.
> ---
>  include/linux/mm.h |  1 +
>  kernel/sysctl.c    |  8 ++++++++
>  mm/page_alloc.c    | 18 +++++++++++++++---
>  mm/util.c          |  2 ++
>  4 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8f857163ac89..e4e5d508e9eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -203,6 +203,7 @@ extern unsigned long sysctl_admin_reserve_kbytes;
>  
>  extern int sysctl_overcommit_memory;
>  extern int sysctl_overcommit_ratio;
> +extern int sysctl_cma_utilization_ratio;
>  extern unsigned long sysctl_overcommit_kbytes;
>  
>  int overcommit_ratio_handler(struct ctl_table *, int, void *, size_t *,
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 137d4abe3eda..2dce6a908aa6 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2445,6 +2445,14 @@ static struct ctl_table vm_table[] = {
>  		.extra2		= SYSCTL_ONE,
>  	},
>  #endif
> +	{
> +		.procname	= "cma_utilization_ratio",
> +		.data		= &sysctl_cma_utilization_ratio,
> +		.maxlen		= sizeof(sysctl_cma_utilization_ratio),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +	},
>  	{ }
>  };
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..b72db3824687 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,6 +3071,20 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>  
>  }
>  
> +static __always_inline bool zone_can_use_cma_pages(struct zone *zone)
> +{
> +	unsigned long cma_free_pages;
> +	unsigned long zone_free_pages;
> +
> +	cma_free_pages = zone_page_state(zone, NR_FREE_CMA_PAGES);
> +	zone_free_pages = zone_page_state(zone, NR_FREE_PAGES);
> +
> +	if (cma_free_pages > zone_free_pages / sysctl_cma_utilization_ratio)
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
> @@ -3087,9 +3101,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  		 * allocating from CMA when over half of the zone's free memory
>  		 * is in the CMA area.
>  		 */
> -		if (alloc_flags & ALLOC_CMA &&
> -		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> +		if (alloc_flags & ALLOC_CMA && zone_can_use_cma_pages(zone)) {
>  			page = __rmqueue_cma_fallback(zone, order);
>  			if (page)
>  				return page;
> diff --git a/mm/util.c b/mm/util.c
> index b56c92fb910f..4de81f04b249 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -781,6 +781,8 @@ void folio_copy(struct folio *dst, struct folio *src)
>  }
>  
>  int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
> +
> +int sysctl_cma_utilization_ratio __read_mostly = 2;

Make '2' here a macro e.g CMA_UTILIZATION_DEFAULT ? Also it might be a good
opportunity to comment why the default value is '2' i.e 50 %.

>  int sysctl_overcommit_ratio __read_mostly = 50;
>  unsigned long sysctl_overcommit_kbytes __read_mostly;
>  int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
