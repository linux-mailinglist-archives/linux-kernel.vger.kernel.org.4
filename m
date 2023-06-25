Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CB73CE0C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFYCeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFYCef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:34:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07A13E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 19:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687660474; x=1719196474;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=FBCY4OxzLlEFK9Pjzk6FhGgxr9EDjNsRJK4vH72YXKQ=;
  b=lbW0/3C+tW1jidEhWjJ+YsDjYrQ3mCzbMrknckM3NRX97bkavbmzVPOX
   zDZHOiuvHqclErYwhoFXSx18TLNiRmeo9kqzECzKYl/51hQaSlbZdGV/t
   JOCEnDm/e9+iR+mv37PWFW9aSyiuMd7jNhvqnipuaR8lKXLUbiAJamCMP
   HIoH0y+rnvywi+0XGWElUILMSVwUFR1eVRYgdSH9FfI2ipG2ZMNbnVii0
   L7Ia7xP3ycWLbMQwzdbGjZBcDO5cDcuiMUJGLNj/NXKQHBc4KQBSVmiVR
   x5TOP6OyyiqZQ21dRFYPkd8fGB0/O0KgZD6uVU8dBSIPL84UhqYT5192c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="364459421"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="364459421"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 19:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="745386194"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="745386194"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 19:34:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     liuq <liuq131@chinatelecom.cn>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm/page_alloc: fix min_free_kbytes calculation
 regarding ZONE_MOVABLE
References: <37d8c6c3-0dd1-94b1-19cd-4743968b0fce@chinatelecom.cn>
Date:   Sun, 25 Jun 2023 10:33:02 +0800
In-Reply-To: <37d8c6c3-0dd1-94b1-19cd-4743968b0fce@chinatelecom.cn> (liuq's
        message of "Wed, 21 Jun 2023 21:48:01 +0800")
Message-ID: <87leg86zkx.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> value in __setup_per_zone_wmarks.
           ~~~~~~~~~~~~~~~~~~~~~~~

Better to add () in function name to make it easier to understand.  That
is, "__setup_per_zone_wmarks()".

Otherwise looks good to me.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

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
> Signed-off-by: liuq<liuq131@chinatelecom.cn>
> ---
>   mm/page_alloc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b..590ed8725e09 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6362,9 +6362,9 @@ static void __setup_per_zone_wmarks(void)
>   	struct zone *zone;
>   	unsigned long flags;
>   
> -	/* Calculate total number of !ZONE_HIGHMEM pages */
> +	/* Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages */
>   	for_each_zone(zone) {
> -		if (!is_highmem(zone))
> +		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
>   			lowmem_pages += zone_managed_pages(zone);
>   	}
>   
> @@ -6374,15 +6374,15 @@ static void __setup_per_zone_wmarks(void)
>   		spin_lock_irqsave(&zone->lock, flags);
>   		tmp = (u64)pages_min * zone_managed_pages(zone);
>   		do_div(tmp, lowmem_pages);
> -		if (is_highmem(zone)) {
> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>   			/*
>   			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
> -			 * need highmem pages, so cap pages_min to a small
> -			 * value here.
> +			 * need highmem and movable zones pages, so cap pages_min
> +			 * to a small value here.
>   			 *
>   			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
>   			 * deltas control async page reclaim, and so should
> -			 * not be capped for highmem.
> +			 * not be capped for highmem and movable zones.
>   			 */
>   			unsigned long min_pages;
>   
> -- 2.27.0
