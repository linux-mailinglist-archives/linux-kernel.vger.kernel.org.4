Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101570D077
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjEWBYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEWBYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:24:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F192
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684805071; x=1716341071;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=R2bwulSitpiMNefzkQURMvBQZqOHvZc4MsH0ZIFOZuQ=;
  b=ZFnE9jjN6QtReaSxR8wiMogMd62wiG8MjzSvAZCKvV/5J6HbDhdekZvB
   eME/E2mq9hHSkbvY8Non1p6I1BMA4sZFRCnd1J/KJFPCGrlcTyZkZmHMB
   mhBKsU9231Zy1qMQF+koLIV38cVLSNSLFQ+5TBc4EGVhV7CNuCWnb1YFS
   bLRmQgPyRgLTDK1k/V8tGEJe3oP3tV2+PbPSMQ3ZkC0m7g/v7QdEw6cZM
   yuToqh5nMjrKbexsG3PD8T1OAnsRPOaEvHzPHj08U3FdOXL0LnjnVEINk
   2NDjgLPRMZEY8sK5RdeL01a5eHm3wsek4DqqUTSlvTxqzsawR3IiAd+Si
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356321724"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356321724"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="815913033"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="815913033"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:24:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        willy@infradead.org, steven.sistare@oracle.com,
        mgorman@techsingularity.net, khalid@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
        <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
        <87sfbubg3j.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <5f43a17c-94a0-4bff-b451-e5014de36ed9@redhat.com>
        <875y8k3o60.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <5ba66714-b4a9-4fd3-1149-4d67b26c370a@oracle.com>
Date:   Tue, 23 May 2023 09:23:25 +0800
In-Reply-To: <5ba66714-b4a9-4fd3-1149-4d67b26c370a@oracle.com> (Khalid Aziz's
        message of "Mon, 22 May 2023 09:12:38 -0600")
Message-ID: <87bkibyh6a.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
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

Khalid Aziz <khalid.aziz@oracle.com> writes:

> On 5/21/23 23:55, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 18.05.23 03:09, Huang, Ying wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 17.05.23 18:15, Khalid Aziz wrote:
>>>>>> Pages pinned in memory through extra refcounts can not be migrated.
>>>>>> Currently as isolate_migratepages_block() scans pages for
>>>>>> compaction, it skips any pinned anonymous pages. All non-migratable
>>>>>> pages should be skipped and not just the anonymous pinned pages.
>>>>>> This patch adds a check for extra refcounts on a page to determine
>>>>>> if the page can be migrated.  This was seen as a real issue on a
>>>>>> customer workload where a large number of pages were pinned by vfio
>>>>>> on the host and any attempts to allocate hugepages resulted in
>>>>>> significant amount of cpu time spent in either direct compaction or
>>>>>> in kcompactd scanning vfio pinned pages over and over again that can
>>>>>> not be migrated.
>>>>>
>>>>> How will this change affect alloc_contig_range(), such as used for CMA
>>>>> allocations or virtio-mem? alloc_contig_range() ends up calling
>>>>> isolate_migratepages_range() -> isolate_migratepages_block().
>>>> IIUC, cc->alloc_contig can be used to distinguish contiguous
>>>> allocation
>>>> and compaction.  And, from the original commit which introduced
>>>> anonymous pages skipping (commit 119d6d59dcc0 ("mm, compaction: avoid
>>>> isolating pinned pages ")) and this patch, large number of migration
>>>> failure during compaction causes real issue too.  So, I suggest to use
>>>> cc->alloc_contig here.
>>>
>>> Agreed. I further wonder if we want to special-case the !alloc_contig
>>> case also for MIGRATE_CMA and ZONE_MOVABLE, where we cannot have
>>> longterm page pinnings (e.g., vfio pinned pages).
>> This makes sense.  The skipping is more accurate in this way.
>> 
>
>
> Something like this?
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f04c00981172..014e21d3d7e9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1025,7 +1025,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>                  * lru_lock and isolating it unnecessarily
>                  */
>                 mapping = page_mapping(page);
> -               if (page_has_extra_refs(page))
> +               if (!cc->alloc_contig && page_has_extra_refs(page))
>                         goto isolate_fail_put;
>
>                 /*

As suggested by David above, you can check the current zone type (for
ZONE_MOVABLE) and page block migrate type (MIGRATE_CMA) too.  Because
pages there will not be pinned in long term, and should be tried to be
migrated.

Best Regards,
Huang, Ying
