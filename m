Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242368EDE9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjBHL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBHL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:28:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869DD3CE33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675855735; x=1707391735;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OnZWGQ8za0qKBoTu5h8/4r6Ygll40Nkso+5HJAIcPPY=;
  b=YYOSjpcjDT6Ihl6sKuDu5MSGYACPP1uMNtgueDDkEpmNfE/fKBBp7YWG
   djls+VsYbSzD18XKFvRzDL2RqJwIfFksxaB/LzTLFjZeu9VGtD5I3EpG8
   mVQweD6MRJkUyZQkHm+lDpNdXNObD4igJ3+g6hhF4nNb5M8wONFxNP8gz
   FX3GfHrpa6GPdA3wsQAzQUzyOPcflkYdnr07D56Qoc+Uyk4So+sav7OvR
   3xbXYSS3CM+sBm23pKBthUrR850mP00Lh/bsEbOEM0sq2fp4VO0ddDH2n
   3N8WpcXhW/77y7n/+W/sXONY3xJzfa5Up8Nwzpi22Ay1ehh4qeVTF5SDp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327468228"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="327468228"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:28:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="791167966"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="791167966"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:28:42 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 8/9] migrate_pages: batch flushing TLB
References: <20230206063313.635011-1-ying.huang@intel.com>
        <20230206063313.635011-9-ying.huang@intel.com>
        <E6CE5A79-E1B0-4FCB-94A5-EE268C160410@nvidia.com>
Date:   Wed, 08 Feb 2023 19:27:53 +0800
In-Reply-To: <E6CE5A79-E1B0-4FCB-94A5-EE268C160410@nvidia.com> (Zi Yan's
        message of "Tue, 07 Feb 2023 09:52:28 -0500")
Message-ID: <878rh8gzwm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 6 Feb 2023, at 1:33, Huang Ying wrote:
>
>> The TLB flushing will cost quite some CPU cycles during the folio
>> migration in some situations.  For example, when migrate a folio of a
>> process with multiple active threads that run on multiple CPUs.  After
>> batching the _unmap and _move in migrate_pages(), the TLB flushing can
>> be batched easily with the existing TLB flush batching mechanism.
>> This patch implements that.
>>
>> We use the following test case to test the patch.
>>
>> On a 2-socket Intel server,
>>
>> - Run pmbench memory accessing benchmark
>>
>> - Run `migratepages` to migrate pages of pmbench between node 0 and
>>   node 1 back and forth.
>>
>> With the patch, the TLB flushing IPI reduces 99.1% during the test and
>> the number of pages migrated successfully per second increases 291.7%.
>>
>> NOTE: TLB flushing is batched only for normal folios, not for THP
>> folios.  Because the overhead of TLB flushing for THP folios is much
>> lower than that for normal folios (about 1/512 on x86 platform).
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: haoxin <xhao@linux.alibaba.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> ---
>>  mm/migrate.c |  4 +++-
>>  mm/rmap.c    | 20 +++++++++++++++++---
>>  2 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 9378fa2ad4a5..ca6e2ff02a09 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1230,7 +1230,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>>  		/* Establish migration ptes */
>>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>>  			       !folio_test_ksm(src) && !anon_vma, src);
>> -		try_to_migrate(src, 0);
>> +		try_to_migrate(src, TTU_BATCH_FLUSH);
>>  		page_was_mapped = 1;
>>  	}
>>
>> @@ -1781,6 +1781,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	stats->nr_thp_failed += thp_retry;
>>  	stats->nr_failed_pages += nr_retry_pages;
>>  move:
>
> Maybe a comment:
> /* Flush TLBs for all the unmapped pages */

OK.  Will do that in the next version.

Best Regards,
Huang, Ying

>> +	try_to_unmap_flush();
>> +
>>  	retry = 1;
>>  	for (pass = 0;
>>  	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index b616870a09be..2e125f3e462e 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1976,7 +1976,21 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>  		} else {
>>  			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>>  			/* Nuke the page table entry. */
>> -			pteval = ptep_clear_flush(vma, address, pvmw.pte);
>> +			if (should_defer_flush(mm, flags)) {
>> +				/*
>> +				 * We clear the PTE but do not flush so potentially
>> +				 * a remote CPU could still be writing to the folio.
>> +				 * If the entry was previously clean then the
>> +				 * architecture must guarantee that a clear->dirty
>> +				 * transition on a cached TLB entry is written through
>> +				 * and traps if the PTE is unmapped.
>> +				 */
>> +				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>> +
>> +				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
>> +			} else {
>> +				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>> +			}
>>  		}
>>
>>  		/* Set the dirty flag on the folio now the pte is gone. */
>> @@ -2148,10 +2162,10 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
>>
>>  	/*
>>  	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
>> -	 * TTU_SPLIT_HUGE_PMD and TTU_SYNC flags.
>> +	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
>>  	 */
>>  	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>> -					TTU_SYNC)))
>> +					TTU_SYNC | TTU_BATCH_FLUSH)))
>>  		return;
>>
>>  	if (folio_is_zone_device(folio) &&
>> -- 
>> 2.35.1
>
> Everything else looks good to me. Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> --
> Best Regards,
> Yan, Zi
