Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF46E8B49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjDTHYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDTHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:24:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A3C6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681975457; x=1713511457;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=qYzZ6ZIe1ih7rPAsTnxSOh7P5cfjCrZOjaZ15iTC+bU=;
  b=D8btguvsw1BHNRKkSQz9mENhnklTwENfY0lQ7VFcggmrF+Ei/NUJf49j
   UlC55kw62E2HxBrmGiX1jtwUraU+YxHGXczzIhwalOFDMWNPtaEtvRZtT
   TR6OEAs8vB08L4kCbPpi0A+mObdPj6qPaKSvEYWwOfyD1D5jGDeHSVJot
   Xanh40XvnG9YcWKksm4riELnrEYR9caWRM95dIa6nl20u475PrD0v+7EZ
   FmPZ0XN9J8Lw3XY20LNmyfFJjWBoaWKibDZjMT5OgNMprPPtEiWZcOXem
   +vVTTMXe89aIn7tRfJ5NPs3U9knKwzJXe70j0Ly1iGnGp30wfv76cvy0U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="408569535"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="408569535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="761040972"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="761040972"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:24:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
        <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
        <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
Date:   Thu, 20 Apr 2023 15:22:57 +0800
In-Reply-To: <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com> (Baolin
        Wang's message of "Wed, 12 Apr 2023 20:16:27 +0800")
Message-ID: <87cz3zt3u6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 4/12/2023 7:25 PM, David Hildenbrand wrote:
>> On 12.04.23 12:45, Baolin Wang wrote:
>>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>>> which checks whether the given zone contains holes, and uses pfn_valid()
>>> to check if the end pfn is valid. However pfn_valid() can not make sure
>>> the end pfn is not a hole if the size of a pageblock is larger than the
>>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>>> may represent a hole or an unusable page frame, which may cause incorrect
>>> zone contiguous is set.
>>>
>>> Though another user of pageblock_pfn_to_page() in compaction seems work
>>> well now, it is better to avoid scanning or touching these offline pfns.
>>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>>> populated to have holes"), we should also use pfn_to_online_page() for
>>> the end pfn to make sure it is a valid pfn with usable page frame.
>>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>>
>>> Moreover we've already used pfn_to_online_page() for start pfn to make
>>> sure it is online and valid, so the pfn_valid() for the start pfn is
>>> unnecessary, drop it.
>> pageblocks are supposed to fall into a single memory section, so in
>> mos > cases, if the start is online, so is the end.
>
> Yes, the granularity of memory hotplug is a mem_section.
>
> However, suppose the pageblock order is MAX_ORDER-1, and the size of a
> sub-section is 2M, that means a pageblock will fall into 2 sub 
> mem-section, and if there is a hole in the zone, that means the 2nd
> sub mem-section can be invalid without setting subsection_map bitmap.
>
> So the start is online can make sure the end pfn of a pageblock is
> online, but a valid start pfn can not make sure the end pfn is valid
> in the bitmap of ms->usage->subsection_map.

arch_add_memory
  add_pages
    __add_pages
      sparse_add_section /* set subsection_map */

arch_add_memory() is only called by add_memory_resource() and
pagemap_range() (called add_pages() too).  In add_memory_resource(),
check_hotplug_memory_range() will enforce a strict hotplug range
alignment requirement (128 MB on x86_64).  pagemap_range() are used for
ZONE_DEVICE only.  That is, for normal memory, hotplug granularity is
much larger than 2MB.

IIUC, the situation you mentioned above is impossible.  Or do I miss
something?

Best Regards,
Huang, Ying

>> THE exception to this rule is when we have a mixture of ZONE_DEVICE
>> and ZONE_* within the same section.
>> Then, indeed the end might not be online.
>> BUT, if the end is valid (-> ZONE_DEVICE), then the zone_id will
>> differ. [let's ignore any races for now, up to this point they are
>> mostly of theoretical nature]
>> So I don't think this change actually fixes something.
>> 
>> Getting rid of the pfn_valid(start_pfn). makes sense. Replacing the 
>
> Yes, my motivation is try to optimize the __pageblock_pfn_to_page()
> which is hot when doing compaction, and I saw these pfn_valid() can be 
> dropped.
>
>> pfn_valid(end_pfn) by a pfn_to_online_page(end_pfn) could make that
>> function less efficient.
>> 
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> . mm/page_alloc.c | 7 +++----
>>> . 1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index d0eb280ec7e4..8076f519c572 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1512,9 +1512,6 @@ struct page *__pageblock_pfn_to_page(unsigned
>>> long start_pfn,
>>> . . . /* end_pfn is one past the range we are checking */
>>> . . . end_pfn--;
>>> -. . if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
>>> -. . . . return NULL;
>>> -
>>> . . . start_page = pfn_to_online_page(start_pfn);
>>> . . . if (!start_page)
>>> . . . . . return NULL;
>>> @@ -1522,7 +1519,9 @@ struct page *__pageblock_pfn_to_page(unsigned
>>> long start_pfn,
>>> . . . if (page_zone(start_page) != zone)
>>> . . . . . return NULL;
>>> -. . end_page = pfn_to_page(end_pfn);
>>> +. . end_page = pfn_to_online_page(end_pfn);
>>> +. . if (!end_page)
>>> +. . . . return NULL;
>>> . . . /* This gives a shorter code than deriving page_zone(end_page) */
>>> . . . if (page_zone_id(start_page) != page_zone_id(end_page))
>> 
