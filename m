Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D965CB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbjADBmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbjADBmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:42:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09928BF42
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672796531; x=1704332531;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=3FWdbGNJ00seTicTD9h7GyRV6nTIv2Ka0HqJ4nF8V0I=;
  b=Ano/4Zc9aom6Eg4G6+cSwKfGCgs15yiFddyrESEGtULvFnEVoA1sAz2h
   yXMwiXh53bahTuxQ+5XZE8ygfmYqaFnG8T+i2LUDhEKqIwpGWVuO+pnqh
   itc6Mgz1XuQW5SDumBLt4+UqUkStx5+OwcDSWb++R9PbHfdEbPvYb6Y3u
   kTWu4elXBdjrlUEtaHS+0cVUIQxPHnO6EOR+IdOSw7QvyivwUHjcK5cVx
   A3VN22MocF6TC9zhWbtmaZ+ePFshqbX8x8DcWWc8b8WaPhQsR49pYCAIX
   BnkaAEbuFxPleBKOl0SeRMnsYWyHj9C4r/x1RnaWGqUHZjjcG0KmFZ1JF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302179909"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302179909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:42:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="656956601"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="656956601"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:42:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 8/8] migrate_pages: batch flushing TLB
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-9-ying.huang@intel.com>
        <D8F02562-AA7E-4868-BE58-F1144728A352@nvidia.com>
Date:   Wed, 04 Jan 2023 09:41:14 +0800
In-Reply-To: <D8F02562-AA7E-4868-BE58-F1144728A352@nvidia.com> (Zi Yan's
        message of "Tue, 03 Jan 2023 14:19:23 -0500")
Message-ID: <87o7rfm5z9.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 26 Dec 2022, at 19:28, Huang Ying wrote:
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
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: haoxin <xhao@linux.alibaba.com>
>> ---
>>  mm/migrate.c |  4 +++-
>>  mm/rmap.c    | 20 +++++++++++++++++---
>>  2 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 70a40b8fee1f..d7413164e748 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1215,7 +1215,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>>  		/* Establish migration ptes */
>>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>>  			       !folio_test_ksm(src) && !anon_vma, src);
>> -		try_to_migrate(src, 0);
>> +		try_to_migrate(src, TTU_BATCH_FLUSH);
>>  		page_was_mapped = 1;
>>  	}
>>
>> @@ -1732,6 +1732,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	stats->nr_thp_failed += thp_retry;
>>  	stats->nr_failed_pages += nr_retry_pages;
>>  move:
>> +	try_to_unmap_flush();
>> +
>>  	retry = 1;
>>  	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>>  		retry = 0;
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
>
> This is only for PTE mapped pages, right? We also need something similar
> in set_pmd_migration_entry() in mm/huge_memory.c for PMD-mapped THPs.
> Oh, since you limit NR_MAX_BATCHED_MIGRATION to HPAGE_PMD_NR and count
> nr_pages with folio_nr_pages(), THPs will only be migrated one by one.
> This is not obvious from the cover letter.
>
> Are you planning to support batched THP migration? If not, it might be
> better to update cover letter to be explicit about it and add comments
> in migrate_pages(). It would be nice to also note that we need to
> increase NR_MAX_BATCHED_MIGRATION beyond HPAGE_PMD_NR and make similar
> changes in set_pmd_migration_entry() to get batched THP migration support.

For now, I have no plan to support batching THP migration.  Because the
overhead of THP TLB shootdown is only 1/512 of that of the 4KB normal
page.  I will add some words in patch description for that.

Best Regards,
Huang, Ying

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
