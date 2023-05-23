Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF170CFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjEWA5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEWA5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:57:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A248B1BE3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684803149; x=1716339149;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=diFwzbT3OxeffISLG2blwOVUHxqT8mdCxf9vNwSn2po=;
  b=DeX0J41wV5HA3LnwDjBxVMcqLLYM2G0KUcc3aA3G6rOqsW3pe7NJKlIe
   lm0zScCP3gcALIzj5Bmq/wlPjD+L/ttebc4Yv82IvlYUBqTh7XoPWe/gF
   32F4XRmIfAZyLO8rmnOKD+SVY3QJSyYuaNBQkTgOx3bXSFFu3eIm0jbeK
   CR5x8Bo2UvyKnjAcN7wjePpDfJvmazZOjBMJXxLKVxcE44blA9i4V4prd
   84A1mDZgxzlLtBb94HqGdyUw64ey9fgXUG1vn+T2SXM+ROGZN+qsvRSnh
   q+QtNkrDLTyJtP301XucOB8tVnGtFZ/GOEB3E6DyVTme8VLgLATL6t6pW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381328606"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="381328606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="848055285"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="848055285"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:51:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH -V2 3/5] swap: remove __swp_swapcount()
References: <20230522070905.16773-1-ying.huang@intel.com>
        <20230522070905.16773-4-ying.huang@intel.com>
        <200a094f-7ca9-8a64-1c9b-7cf2e546f3eb@redhat.com>
Date:   Tue, 23 May 2023 08:50:24 +0800
In-Reply-To: <200a094f-7ca9-8a64-1c9b-7cf2e546f3eb@redhat.com> (David
        Hildenbrand's message of "Mon, 22 May 2023 14:03:36 +0200")
Message-ID: <87sfbnyipb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 22.05.23 09:09, Huang Ying wrote:
>> __swp_swapcount() just encloses the calling to swap_swapcount() with
>> get/put_swap_device().  It is called in __read_swap_cache_async()
>> only, which encloses the calling with get/put_swap_device() already.
>> So, __read_swap_cache_async() can call swap_swapcount() directly.
>
> The previous patch contained the hunk
>
> -		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
> -			return NULL;
> +		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
> +			goto fail;
>  
> So something is a bit off here. Either that hunk should go here, or
> this patch description has to be adjusted.
>
>
> But I guess patch #2 doesn't compile on its own because this patch
> here adds swap_swapcount() to include/linux/swap.h ?

Good catch!  Will change this in the next version.

Best Regards,
Huang, Ying

>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> ---
>>   include/linux/swap.h |  4 ++--
>>   mm/swapfile.c        | 20 +-------------------
>>   2 files changed, 3 insertions(+), 21 deletions(-)
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 3c69cb653cb9..f6bd51aa05ea 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -512,7 +512,7 @@ int find_first_swap(dev_t *device);
>>   extern unsigned int count_swap_pages(int, int);
>>   extern sector_t swapdev_block(int, pgoff_t);
>>   extern int __swap_count(swp_entry_t entry);
>> -extern int __swp_swapcount(swp_entry_t entry);
>> +extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
>>   extern int swp_swapcount(swp_entry_t entry);
>>   extern struct swap_info_struct *page_swap_info(struct page *);
>>   extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
>> @@ -590,7 +590,7 @@ static inline int __swap_count(swp_entry_t entry)
>>   	return 0;
>>   }
>>   -static inline int __swp_swapcount(swp_entry_t entry)
>> +static inline int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>>   {
>>   	return 0;
>>   }
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 8419cba9c192..e9cce775fb25 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1443,7 +1443,7 @@ int __swap_count(swp_entry_t entry)
>>    * This does not give an exact answer when swap count is continued,
>>    * but does include the high COUNT_CONTINUED flag to allow for that.
>>    */
>> -static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>> +int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>>   {
>>   	pgoff_t offset = swp_offset(entry);
>>   	struct swap_cluster_info *ci;
>> @@ -1455,24 +1455,6 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>>   	return count;
>>   }
>>   -/*
>> - * How many references to @entry are currently swapped out?
>> - * This does not give an exact answer when swap count is continued,
>> - * but does include the high COUNT_CONTINUED flag to allow for that.
>> - */
>> -int __swp_swapcount(swp_entry_t entry)
>> -{
>> -	int count = 0;
>> -	struct swap_info_struct *si;
>> -
>> -	si = get_swap_device(entry);
>> -	if (si) {
>> -		count = swap_swapcount(si, entry);
>> -		put_swap_device(si);
>> -	}
>> -	return count;
>> -}
>> -
>>   /*
>>    * How many references to @entry are currently swapped out?
>>    * This considers COUNT_CONTINUED so it returns exact answer.
