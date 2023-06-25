Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0031173CDD9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjFYBnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFYBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:43:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D02710C9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687657417; x=1719193417;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=B5nFWmooHRky6c7V7OQZwlVIr7FyW8jco6PLxS4Zwwk=;
  b=U70t7cgTgVq5icqfqP4k89TR59/uG5mr2y1FwS+mLKlDCIHcmuPSon0S
   /encX7Q5/9bPY8MC9W/HsCl2tLsX/3HpvEFNA8j4SCnJ8bsIO2SN+hA/L
   tFOOVS1qfnKT1fYkLgWH1Zp7ozwf3biIve308ziwv2UiViqdPSCLsKWxL
   Vuf1DnjzlQC3fvOpSR70QL8mhXmwVmQup2+4C7ncfJJ7xw+EsZcnj56MI
   3YuMgF8LalGI5Mn8KycrVKgsjQuNZyGZVgdz4IU5yjMQtsPQEsXGgqenu
   65oyYU3gCmc6heg4jI4tQ18rHZ9z6KepamjZj/8eByPHyO/+EYo7roLbb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="424682014"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="424682014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 18:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="839852478"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="839852478"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 18:43:34 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     liuq <liuq131@chinatelecom.cn>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        mawupeng 00564683 <mawupeng1@huawei.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v3] mm/min_free_kbytes: modify min_free_kbytes
 calculation rules
References: <20230621092048.5242-1-liuq131@chinatelecom.cn>
        <2fb1f6dd-afea-caf5-a94b-6915b21258a4@huawei.com>
Date:   Sun, 25 Jun 2023 09:40:20 +0800
In-Reply-To: <2fb1f6dd-afea-caf5-a94b-6915b21258a4@huawei.com> (Kefeng Wang's
        message of "Wed, 21 Jun 2023 18:00:25 +0800")
Message-ID: <87pm5k720r.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Hi, Kefeng,

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> Hi Liuq,
>
> On 2023/6/21 17:20, liuq wrote:
>> The current calculation of min_free_kbytes only uses ZONE_DMA and
>> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
>> will also divide part of min_free_kbytes.This will cause the min
>> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.
>> __GFP_HIGH and PF_MEMALLOC allocations usually don't need movable
>> zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
>> value in __setup_per_zone_wmarks.
>> On my testing machine with 16GB of memory (transparent hugepage is
>> turned off by default, and movablecore=12G is configured)
>> The following is a comparative test data of watermark_min
>> 		no patch	add patch
>> ZONE_DMA	1		8
>> ZONE_DMA32	151		709
>> ZONE_NORMAL	233		1113
>> ZONE_MOVABLE	1434		128
>> min_free_kbytes	7288		7326
>> 
>
> We see this issue and do the same change[1], and we add a per zone
> watermark configuration too, but both of them is not accepted,
> let's add Mel and wupeng to see more comments.
>
> [1]https://lore.kernel.org/linux-mm/20220905032858.1462927-1-mawupeng1@huawei.com/

Thanks for your information!  That's very useful.

As Mel said, ZONE_MOVABLE or ZONE_HIGHMEM pages allocation will need low
memory to be allocated too.  But I don't understand why higher min
watermark of ZONE_MOVABLE will help this.  It's too small compared with
the size of ZONE_MOVABLE in most cases.  For example, on the system of
the patch description, the original "large" min watermark of
ZONE_MOVABLE is only (1434 * 4) = 5736 KB, which is too small compared
with 12 GB total ZONE_MOVABLE size.  That is, before reaching min or low
watermark, we will allocate almost same number of ZONE_MOVABLE pages:
~12GB vs. ~(12GB - 5MB).

Best Regards,
Huang, Ying

>> Signed-off-by: liuq <liuq131@chinatelecom.cn>
>> ---
>>   mm/page_alloc.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 47421bedc12b..590ed8725e09 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6362,9 +6362,9 @@ static void __setup_per_zone_wmarks(void)
>>   	struct zone *zone;
>>   	unsigned long flags;
>>   -	/* Calculate total number of !ZONE_HIGHMEM pages */
>> +	/* Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages */
>>   	for_each_zone(zone) {
>> -		if (!is_highmem(zone))
>> +		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
>>   			lowmem_pages += zone_managed_pages(zone);
>>   	}
>>   @@ -6374,15 +6374,15 @@ static void __setup_per_zone_wmarks(void)
>>   		spin_lock_irqsave(&zone->lock, flags);
>>   		tmp = (u64)pages_min * zone_managed_pages(zone);
>>   		do_div(tmp, lowmem_pages);
>> -		if (is_highmem(zone)) {
>> +		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
>>   			/*
>>   			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
>> -			 * need highmem pages, so cap pages_min to a small
>> -			 * value here.
>> +			 * need highmem and movable zones pages, so cap pages_min
>> +			 * to a small  value here.
>>   			 *
>>   			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
>>   			 * deltas control async page reclaim, and so should
>> -			 * not be capped for highmem.
>> +			 * not be capped for highmem and movable zones.
>>   			 */
>>   			unsigned long min_pages;
>>   
