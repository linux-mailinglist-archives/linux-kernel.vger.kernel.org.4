Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F0737CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjFUHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFUHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:47:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05F1718
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687333624; x=1718869624;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=v2gjwEToFRuJ5IZl6784+ZpMbSbQbMfelLt7/7YIpU8=;
  b=GOxRaAl2JbzDSkBzJfOFZppUm0+vmuqfoTGSoJKpjGQDFVIOFspeIUF+
   aS/uUHZL58rwQNfQUfI++4FdiKBNsgOZPHkDnrXUZh+ljJiaC2sVLlgHl
   dGJrSG3O0BO1tWepT+2K1r3dJxqcvRkb50r6JxGOEckLEOScZ3LT3HRek
   0uG5o8EQV+M6HWDCn0O9ixsGohGoV3/rsm006UvYsMp/u3RiseIN08F/2
   koy/wKCtJBvGvTX/myPPaY8v5KbyDxB96p4BTuGbYS70P1wx2dLmK2o2w
   3unegTKN5lfs9aKOQFQ+0FdoO9gWHTtNj2M4TMqdWgLKlSUi3ECb6OuKE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357594952"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="357594952"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="784385178"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="784385178"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:46:34 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     liuq <liuq131@chinatelecom.cn>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/min_free_kbytes: modify min_free_kbytes
 calculation rules
References: <20230621073912.21747-1-liuq131@chinatelecom.cn>
Date:   Wed, 21 Jun 2023 15:45:01 +0800
In-Reply-To: <20230621073912.21747-1-liuq131@chinatelecom.cn> (liuq's message
        of "Wed, 21 Jun 2023 15:39:12 +0800")
Message-ID: <87ttv16yyq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Liuq,

Thanks for updated patch.

liuq <liuq131@chinatelecom.cn> writes:

> The current calculation of min_free_kbytes only uses ZONE_DMA and
> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
> will also divide part of min_free_kbytes.This will cause the min
> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.
>
> __GFP_HIGH and PF_MEMALLOC allocations usually don't need moveable
> zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
> value in __setup_per_zone_wmarks.

Please list the test result of your patch.  That is, WMARK_MIN before
and after your patch in a system with large ZONE_MOVABLE.

> Signed-off-by: liuq <liuq131@chinatelecom.cn>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b..608384712a89 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6364,7 +6364,7 @@ static void __setup_per_zone_wmarks(void)
>  
>  	/* Calculate total number of !ZONE_HIGHMEM pages */
>  	for_each_zone(zone) {
> -		if (!is_highmem(zone))
> +		if (!is_highmem(zone) || zone_idx(zone) != ZONE_MOVABLE)
>  			lowmem_pages += zone_managed_pages(zone);
>  	}
>  
> @@ -6374,7 +6374,7 @@ static void __setup_per_zone_wmarks(void)
>  		spin_lock_irqsave(&zone->lock, flags);
>  		tmp = (u64)pages_min * zone_managed_pages(zone);
>  		do_div(tmp, lowmem_pages);
> -		if (is_highmem(zone)) {
> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>  			/*
>  			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
>  			 * need highmem pages, so cap pages_min to a small
                                ~~~~~~~

Change the comments above too?

Best Regards,
Huang, Ying
