Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D29737FED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFUKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjFUKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:00:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067C10F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:00:28 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QmJsG4D2czqTl7;
        Wed, 21 Jun 2023 18:00:18 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 18:00:26 +0800
Message-ID: <2fb1f6dd-afea-caf5-a94b-6915b21258a4@huawei.com>
Date:   Wed, 21 Jun 2023 18:00:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] mm/min_free_kbytes: modify min_free_kbytes calculation
 rules
Content-Language: en-US
To:     liuq <liuq131@chinatelecom.cn>, <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        mawupeng 00564683 <mawupeng1@huawei.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230621092048.5242-1-liuq131@chinatelecom.cn>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230621092048.5242-1-liuq131@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liuq,

On 2023/6/21 17:20, liuq wrote:
> The current calculation of min_free_kbytes only uses ZONE_DMA and
> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
> will also divide part of min_free_kbytes.This will cause the min
> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.
> 
> __GFP_HIGH and PF_MEMALLOC allocations usually don't need movable
> zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
> value in __setup_per_zone_wmarks.
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

We see this issue and do the same change[1], and we add a per zone 
watermark configuration too, but both of them is not accepted,
let's add Mel and wupeng to see more comments.

[1]https://lore.kernel.org/linux-mm/20220905032858.1462927-1-mawupeng1@huawei.com/

> Signed-off-by: liuq <liuq131@chinatelecom.cn>
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
> +			 * to a small  value here.
>   			 *
>   			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
>   			 * deltas control async page reclaim, and so should
> -			 * not be capped for highmem.
> +			 * not be capped for highmem and movable zones.
>   			 */
>   			unsigned long min_pages;
>   
