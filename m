Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9899B734A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFSD1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFSD1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:27:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9281AB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687145235; x=1718681235;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=O5zztc/f2oQYxwqzTnF+e2glrsNYbDR/DOPtIyJtEdc=;
  b=Rss3W05gUytkmjrHnFxod8C2oGuFu2w+Ps57DfZc/4C1uOWrpTxLYWpC
   HKdMeOxnvvPwrfimAnIz2jq4IqoOUszywRxRJOYENmgXKelDMRu62evfD
   GM6sePubO0bYv/4ryHKFVKWjzN0MYsNRLsHY8oZkwDPMBY8jMxVPZb3s1
   /nEb1vXX7/ORXYT26vdxzIPsPUUPb9BkL5iU3LsF5v2Giicq4ovyBa+8h
   NNvY8zRbsVboEvlJczXLo2+MN2CxVpmuadY2mEGuLPHO1t7yoDuP7XhZk
   OrrPikP9Pb2XqjM5petTQcv7xBlKEDmY/5xV7W8Lz2uIEmvsyfdlql5Ls
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339870383"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339870383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 20:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="707739014"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="707739014"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 20:27:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     liuq <liuq131@chinatelecom.cn>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm/min_free_kbytes: modify min_free_kbytes calculation
 rules
References: <20230609032552.218010-1-liuq131@chinatelecom.cn>
Date:   Mon, 19 Jun 2023 11:25:38 +0800
In-Reply-To: <20230609032552.218010-1-liuq131@chinatelecom.cn> (liuq's message
        of "Fri, 9 Jun 2023 11:25:52 +0800")
Message-ID: <87edm88765.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Added Mel and Vlastimil.

liuq <liuq131@chinatelecom.cn> writes:

> The current calculation of min_free_kbytes only uses ZONE_DMA and
> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
> will also divide part of min_free_kbytes.This will cause the min
> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.

This seems like a real problem per my understanding.  Can you show the
contents of /proc/zoneinfo on a problem system?

But, per my understanding, min_free_kbytes are used for __GFP_HIGH and
PF_MEMALLOC allocations.  While ZONE_MOVABLE will not be used for them
usually.  So I think we should treat ZONE_MOVABLE as ZONE_HIGHMEM in
__setup_per_zone_wmarks().

Best Regards,
Huang, Ying

> Signed-off-by: liuq <liuq131@chinatelecom.cn>
> ---
>  include/linux/mm.h |  1 +
>  mm/khugepaged.c    |  2 +-
>  mm/page_alloc.c    | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cf3d0d673f6b..1f91d035bcaf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -863,6 +863,7 @@ void split_page(struct page *page, unsigned int order);
>  void folio_copy(struct folio *dst, struct folio *src);
>  
>  unsigned long nr_free_buffer_pages(void);
> +unsigned long nr_free_pagecache_pages(void);
>  
>  /*
>   * Compound pages have a destructor function.  Provide a
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 16be62d493cd..6632264b951c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2342,7 +2342,7 @@ static void set_recommended_min_free_kbytes(void)
>  
>  	/* don't ever allow to reserve more than 5% of the lowmem */
>  	recommended_min = min(recommended_min,
> -			      (unsigned long) nr_free_buffer_pages() / 20);
> +			      (unsigned long) nr_free_pagecache_pages() / 20);
>  	recommended_min <<= (PAGE_SHIFT-10);
>  
>  	if (recommended_min > min_free_kbytes) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..489b564526dd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5775,6 +5775,19 @@ unsigned long nr_free_buffer_pages(void)
>  }
>  EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
>  
> +/**
> + * nr_free_pagecache_pages - count number of pages beyond high watermark
> + *
> + * nr_free_pagecache_pages() counts the number of pages which are beyond the
> + * high watermark within all zones.
> + *
> + * Return: number of pages beyond high watermark within all zones.
> + */
> +unsigned long nr_free_pagecache_pages(void)
> +{
> +	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
> +}
> +
>  static inline void show_node(struct zone *zone)
>  {
>  	if (IS_ENABLED(CONFIG_NUMA))
> @@ -8651,7 +8664,7 @@ void calculate_min_free_kbytes(void)
>  	unsigned long lowmem_kbytes;
>  	int new_min_free_kbytes;
>  
> -	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
> +	lowmem_kbytes = nr_free_pagecache_pages() * (PAGE_SIZE >> 10);
>  	new_min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
>  
>  	if (new_min_free_kbytes > user_min_free_kbytes)
