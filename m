Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F96EA520
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDUHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDUHpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:45:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E09E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682063124; x=1713599124;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OQAsHnT4uuyLaswSUOBoKvMIQescywp9WfPVkAAvc6M=;
  b=EbYMDvDZo7/agpXa5CodGflC1eS+YrqNlgtxeP5MYBKEziy1LQPpN7J8
   4Y91/UvC1ch/rKpfFuJqVXRh71P3zp/mc1s4RGhhznSjbyCaHs6AS9LEX
   y9PH2AgiZ8+QQnrHSrlY+CjUd4OazSt7Kz4sgWUGBDs8Jwqd+kTw8hk2C
   O4WJomarPRx3eQXJ3RlemFP+WftoA4DBH3YgceU/0aUCThSFYKUGR+Nky
   LnKBGjJ4z/jvX9PqTckFbBadqayriv2H0CSCvvgLmJI7BpPKUF0dcgqyZ
   kTZp7gpRaBavt0AcoMhXGMU19pl5K6cOFwHn74g5iYyEUtDHNy1iz5gLJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="347838704"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="347838704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 00:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="866617145"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="866617145"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 00:45:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <mgorman@techsingularity.net>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
        <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
        <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
        <87cz3zt3u6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <52dfdd2e-9c99-eac4-233e-59919a24323e@linux.alibaba.com>
        <874jp9uapj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <e112881b-f2c0-2c8e-e5d4-b0323a3b8f16@linux.alibaba.com>
Date:   Fri, 21 Apr 2023 15:44:13 +0800
In-Reply-To: <e112881b-f2c0-2c8e-e5d4-b0323a3b8f16@linux.alibaba.com> (Baolin
        Wang's message of "Fri, 21 Apr 2023 15:13:24 +0800")
Message-ID: <87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 4/21/2023 12:21 PM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> On 4/20/2023 3:22 PM, Huang, Ying wrote:
>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>
>>>>> On 4/12/2023 7:25 PM, David Hildenbrand wrote:
>>>>>> On 12.04.23 12:45, Baolin Wang wrote:
>>>>>>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>>>>>>> which checks whether the given zone contains holes, and uses pfn_valid()
>>>>>>> to check if the end pfn is valid. However pfn_valid() can not make sure
>>>>>>> the end pfn is not a hole if the size of a pageblock is larger than the
>>>>>>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>>>>>>> may represent a hole or an unusable page frame, which may cause incorrect
>>>>>>> zone contiguous is set.
>>>>>>>
>>>>>>> Though another user of pageblock_pfn_to_page() in compaction seems work
>>>>>>> well now, it is better to avoid scanning or touching these offline pfns.
>>>>>>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>>>>>>> populated to have holes"), we should also use pfn_to_online_page() for
>>>>>>> the end pfn to make sure it is a valid pfn with usable page frame.
>>>>>>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>>>>>>
>>>>>>> Moreover we've already used pfn_to_online_page() for start pfn to make
>>>>>>> sure it is online and valid, so the pfn_valid() for the start pfn is
>>>>>>> unnecessary, drop it.
>>>>>> pageblocks are supposed to fall into a single memory section, so in
>>>>>> mos > cases, if the start is online, so is the end.
>>>>>
>>>>> Yes, the granularity of memory hotplug is a mem_section.
>>>>>
>>>>> However, suppose the pageblock order is MAX_ORDER-1, and the size of a
>>>>> sub-section is 2M, that means a pageblock will fall into 2 sub
>>>>> mem-section, and if there is a hole in the zone, that means the 2nd
>>>>> sub mem-section can be invalid without setting subsection_map bitmap.
>>>>>
>>>>> So the start is online can make sure the end pfn of a pageblock is
>>>>> online, but a valid start pfn can not make sure the end pfn is valid
>>>>> in the bitmap of ms->usage->subsection_map.
>>>> arch_add_memory
>>>>     add_pages
>>>>       __add_pages
>>>>         sparse_add_section /* set subsection_map */
>>>> arch_add_memory() is only called by add_memory_resource() and
>>>> pagemap_range() (called add_pages() too).  In add_memory_resource(),
>>>> check_hotplug_memory_range() will enforce a strict hotplug range
>>>> alignment requirement (128 MB on x86_64).  pagemap_range() are used for
>>>> ZONE_DEVICE only.  That is, for normal memory, hotplug granularity is
>>>> much larger than 2MB.
>>>> IIUC, the situation you mentioned above is impossible.  Or do I miss
>>>> something?
>>>
>>> Thanks for your input. Your example is correct, but this is not the
>>> case I want to describe. My case is not about the memory hotplug,
>>> instead about the early memory holes when initialzing the memory. Let
>>> me try to describe explicity:
>>>
>>> First suppose the pageblock order is MAX_ORDER-1, and see below memory
>>> layout as an example:
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000001fa3c7ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7dfffff]
>>>
>>> Focus on the last memory range, and there is a hole for the range [mem
>>> 0x0000001fa7590000-0x0000001fa7dfffff]. That means the last pageblock
>>> will contain the range from 0x1fa7c00000 to 0x1fa7ffffff, since the
>>> pageblock must be 4M aligned. And in this page block, these pfns will
>>> fall into 2 sub-section (the sub-section size is 2M aligned).
>>>
>>> So, the 1st sub-section (indicates pfn range: 0x1fa7c00000 -
>>> 0x1fa7dfffff ) in this pageblock is valid by
>>> free_area_init()--->subsection_map_init(), but the 2nd sub-section
>>> (indicates pfn range: 0x1fa7e00000 - 0x1fa7ffffff ) in this pageblock
>>> is not valid.
>>>
>>> The problem is, if we just check the pageblock start of the hole pfn
>>> (such as 0x1fa7dfffff) to make sure the hole pfn (0x1fa7dfffff) is
>>> also valid, which is NOT correct. So that is what I mean "the start is
>>> online can make sure the end pfn of a pageblock is online, but a valid
>>> start pfn can not make sure the end pfn is valid in the bitmap of
>>> ms->usage->subsection_map."
>>>
>>> Hope I make it clear. Does that make sense to you? Thanks.
>> Thanks for your detailed description.  You are right, it's possible
>> that
>> the second subsection of a pageblock is a hole.
>> It's good to remove unnecessary pfn_valid(start_pfn) check in your
>> original patch.  But it appears unnecessary to replace
>
> OK. I will split this into a separate patch.

Thanks!

>> pfn_valid(end_pfn) with pfn_to_online_page(end_pfn).  Yes, it's possible
>> that there's a hole in a page block.  But it appears that this will not
>> break anything.  Per my understanding, even if we had fixed this one,
>
> Yes, it will not break anything now, the worst case is the compaction
> will waste more time to scan unnecessary hole pfns, though I did not 
> have a performance report to show this issue.

I think the scanning should be fast.

> Another concern is that the zone->contiguous is fragile IMO, and not
> sure if there are pfn walkers will meet the holes though the 
> zone->contiguous = 1 in future.

If there's any issue in the future, we can fix it at that time.

> So at least we can add some comments for __pageblock_pfn_to_page() to
> describe this issue? what do you think?

I'm OK to add some comments there.

>> there may be other smaller memory holes in a pageblock represented as
>> reserved pages

Best Regards,
Huang, Ying
