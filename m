Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B03170CFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjEWAxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjEWAwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:52:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9030CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684802769; x=1716338769;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Zw1KmdjsbS5Kd4VsbrQGPX4PE9kzdomn3cNjKEJ1Y9g=;
  b=EEotZUwcE/MrpF7ry+3ASJTjIO6n02yKR9omEdHuJsGBI/b1Tf4/qZpB
   D9NTC13nlSDsfUGCxROpm/tb3pSFHV32jy+oOz/CzN2MjvotTpZr/iTbm
   k31YCIebzZL6Qu4pIvoXE4nbaIdVVagJIi8ing7xd4SulnMHItcKipBIE
   lMJLT6MREZMB/uLj7HG3hy7NjZQRe66hMamVFdN/LpLOqUhWL7srL1Vzs
   8w4fwX7ehNdcn1N5IAcCQuQTRcbo3cFHLgg9pFcYMQ3twwjMCclsb7DXn
   FtPnfkwPty1CydP+P9ogLiWJM6BV1F95Ltg0/aDsaQkimiP5Ms63L9/es
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="332697760"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="332697760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703748487"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703748487"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:44:18 -0700
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
Subject: Re: [PATCH -V2 2/5] swap, __read_swap_cache_async(): enlarge
 get/put_swap_device protection range
References: <20230522070905.16773-1-ying.huang@intel.com>
        <20230522070905.16773-3-ying.huang@intel.com>
        <653a4881-d17b-6d8e-8066-300c0497a702@redhat.com>
Date:   Tue, 23 May 2023 08:43:15 +0800
In-Reply-To: <653a4881-d17b-6d8e-8066-300c0497a702@redhat.com> (David
        Hildenbrand's message of "Mon, 22 May 2023 14:01:32 +0200")
Message-ID: <87wn0zyj18.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 22.05.23 09:09, Huang Ying wrote:
>> This makes the function a little easier to be understood because we
>> don't need to consider swapoff.  And this makes it possible to remove
>> get/put_swap_device() calling in some functions called by
>> __read_swap_cache_async().
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
>>   mm/swap_state.c | 33 ++++++++++++++++++++++-----------
>>   1 file changed, 22 insertions(+), 11 deletions(-)
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index b76a65ac28b3..a1028fe7214e 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -417,9 +417,13 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>   {
>>   	struct swap_info_struct *si;
>>   	struct folio *folio;
>> +	struct page *page;
>>   	void *shadow = NULL;
>>     	*new_page_allocated = false;
>> +	si = get_swap_device(entry);
>> +	if (!si)
>> +		return NULL;
>>     	for (;;) {
>>   		int err;
>> @@ -428,14 +432,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>   		 * called after swap_cache_get_folio() failed, re-calling
>>   		 * that would confuse statistics.
>>   		 */
>> -		si = get_swap_device(entry);
>> -		if (!si)
>> -			return NULL;
>>   		folio = filemap_get_folio(swap_address_space(entry),
>>   						swp_offset(entry));
>> -		put_swap_device(si);
>> -		if (!IS_ERR(folio))
>> -			return folio_file_page(folio, swp_offset(entry));
>> +		if (!IS_ERR(folio)) {
>> +			page = folio_file_page(folio, swp_offset(entry));
>> +			goto got_page;
>> +		}
>>     		/*
>>   		 * Just skip read ahead for unused swap slot.
>> @@ -445,8 +447,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>   		 * as SWAP_HAS_CACHE.  That's done in later part of code or
>>   		 * else swap_off will be aborted if we return NULL.
>>   		 */
>> -		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
>> -			return NULL;
>> +		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
>> +			goto fail;
>>     		/*
>>   		 * Get a new page to read into from swap.  Allocate it now,
>> @@ -455,7 +457,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>   		 */
>>   		folio = vma_alloc_folio(gfp_mask, 0, vma, addr, false);
>>   		if (!folio)
>> -			return NULL;
>> +                        goto fail;
>>     		/*
>>   		 * Swap entry may have been freed since our caller observed it.
>> @@ -466,7 +468,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>     		folio_put(folio);
>>   		if (err != -EEXIST)
>> -			return NULL;
>> +			goto fail;
>>     		/*
>>   		 * We might race against __delete_from_swap_cache(), and
>> @@ -500,12 +502,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>   	/* Caller will initiate read into locked folio */
>>   	folio_add_lru(folio);
>>   	*new_page_allocated = true;
>> -	return &folio->page;
>> +	page = &folio->page;
>> +got_page:
>> +	put_swap_device(si);
>> +	return page;
>>     fail_unlock:
>>   	put_swap_folio(folio, entry);
>>   	folio_unlock(folio);
>>   	folio_put(folio);
>> +fail:
>
> Maybe better "fail_put_swap".
>
> We now hold the swap device ref longer than we used to, prevent
> swapoff over the whole operation. I guess there is no way we can
> deadlock this way?

I think that we are safe.  In swapoff() syscall, we call
percpu_ref_kill() after all pages are swapped in (via try_to_unuse()).

> In general, looks good to me.

Thanks!

Best Regards,
Huang, Ying
