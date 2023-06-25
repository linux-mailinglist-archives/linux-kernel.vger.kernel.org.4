Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7D73CE68
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFYE1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:27:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B59114
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687667238; x=1719203238;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=WG/a/leZ5bfG3f0ZpT4IG5ONI8r8aX0EZR5+oB50gPI=;
  b=acSeeQ/BgYUArx7DIKdx2l5NnAF39/MxpzB/ybLKPyUJIrxhpT7ZTCT1
   N9VuxraNYOz9AsiKP77LFM3cDHAw0mvugUTlHMMfes00fVUyA7PYEfPY9
   f1Fxgt3xlWTaSiCYDYP3Tph/r2/EcdyOkpfF5lfKeE3QOZeXESTkNuFNR
   iTFUTVRtkByqjSTvON2a4MLVT/knt5txp/FMJATJ8NyMCQIHs01tD41yR
   zeDr/N9cQsGi0HcaKEVxxMmD0Mum9hs4G9CYzPMxulnST1ZMPcvFR1XNP
   qQ3c7zpBzslRo5UTPwOvVLpRTtwq2Xtbt4Q/ZdKXLDyteT7D5Vl9WMg5d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="341362924"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="341362924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 21:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="693082585"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="693082585"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 21:27:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     liuq <liuq131@chinatelecom.cn>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] mm/page_alloc: fix min_free_kbytes calculation
 regarding ZONE_MOVABLE
References: <20230625031656.23941-1-liuq131@chinatelecom.cn>
Date:   Sun, 25 Jun 2023 12:25:14 +0800
In-Reply-To: <20230625031656.23941-1-liuq131@chinatelecom.cn> (liuq's message
        of "Sun, 25 Jun 2023 11:16:56 +0800")
Message-ID: <87h6qw6udx.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

liuq <liuq131@chinatelecom.cn> writes:

> The current calculation of min_free_kbytes only uses ZONE_DMA and
> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
> will also divide part of min_free_kbytes.This will cause the min
> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.
>
> __GFP_HIGH and PF_MEMALLOC allocations usually don't need movable
> zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
> value in __setup_per_zone_wmarks().
>
> On my testing machine with 16GB of memory (transparent hugepage is
> turned off by default, and movablecore=12G is configured)
> The following is a comparative test data of watermark_min
>
> 		no patch	add patch
> ZONE_DMA	1		8
> ZONE_DMA32	151		709
> ZONE_NORMAL	233		1113
> ZONE_MOVABLE	1434		128
> min_free_kbytes	7288		7326
>
> Signed-off-by: liuq <liuq131@chinatelecom.cn>

Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/page_alloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b..590ed8725e09 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6362,9 +6362,9 @@ static void __setup_per_zone_wmarks(void)
>  	struct zone *zone;
>  	unsigned long flags;
>  
> -	/* Calculate total number of !ZONE_HIGHMEM pages */
> +	/* Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages */
>  	for_each_zone(zone) {
> -		if (!is_highmem(zone))
> +		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
>  			lowmem_pages += zone_managed_pages(zone);
>  	}
>  
> @@ -6374,15 +6374,15 @@ static void __setup_per_zone_wmarks(void)
>  		spin_lock_irqsave(&zone->lock, flags);
>  		tmp = (u64)pages_min * zone_managed_pages(zone);
>  		do_div(tmp, lowmem_pages);
> -		if (is_highmem(zone)) {
> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>  			/*
>  			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
> -			 * need highmem pages, so cap pages_min to a small
> -			 * value here.
> +			 * need highmem and movable zones pages, so cap pages_min
> +			 * to a small  value here.
>  			 *
>  			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
>  			 * deltas control async page reclaim, and so should
> -			 * not be capped for highmem.
> +			 * not be capped for highmem and movable zones.
>  			 */
>  			unsigned long min_pages;
