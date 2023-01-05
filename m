Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E875465E546
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAEFyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAEFyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:54:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD13D9EC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672898047; x=1704434047;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VmEZjSfJDXSrUyUEeB9nOlbhCCZ3NoNLGnwj9XiAsqY=;
  b=BJ4tr215oNus406X3+cuMgPlkJfNPNJDlm8fwDVs+AwoZHyj1u1jE2Ie
   x+WeJGfcYTVwjDSzEt92V0UmwUEOyM66NDEy3f2ZTEY98pE20K1BjSOBW
   OtyNPVe3e6OTsrOJ1zBYBw9lmSWwV7wIgVDCRqEMFNIHeXKtCgd6S2+vo
   NLoH1lW9pSmESIIhtlCKeB36/fArw65uKUG7gUkJMLzpvvE871eEFDF7H
   Tyc93TpvU/xLHoDfTO7uGpOi5r2BpEBrlrrY7VtOoEDfOewm3eCeEh0zV
   9xMDHihi4ue8vWL23soK0f7ZUG9gE2jHBkY5tKxDvOWmC+Nt2yL9ZlAWX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349342772"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="349342772"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:54:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657381594"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="657381594"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:54:04 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Bharata B Rao" <bharata@amd.com>, haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 1/8] migrate_pages: organize stats with struct
 migrate_pages_stats
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-2-ying.huang@intel.com>
        <87y1qhu0to.fsf@nvidia.com>
Date:   Thu, 05 Jan 2023 13:53:11 +0800
In-Reply-To: <87y1qhu0to.fsf@nvidia.com> (Alistair Popple's message of "Thu,
        05 Jan 2023 14:02:12 +1100")
Message-ID: <87lemheddk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
>> Define struct migrate_pages_stats to organize the various statistics
>> in migrate_pages().  This makes it easier to collect and consume the
>> statistics in multiple functions.  This will be needed in the
>> following patches in the series.
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
>>  mm/migrate.c | 58 +++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 32 insertions(+), 26 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a4d3fc65085f..ec9263a33d38 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1396,6 +1396,14 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>  	return rc;
>>  }
>>  
>> +struct migrate_pages_stats {
>> +	int nr_succeeded;
>> +	int nr_failed_pages;
>> +	int nr_thp_succeeded;
>> +	int nr_thp_failed;
>> +	int nr_thp_split;
>
> I think some brief comments in the code for what each stat is tracking
> and their relationship to each other would be helpful (ie. does
> nr_succeeded include thp subpages, etc). Or at least a reference to
> where this is documented (ie. page_migration.rst) as I recall there has
> been some confusion in the past that has lead to bugs.

OK, will do that in the next version.

> Otherwise the patch looks good so:
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks!

Best Regards,
Huang, Ying

>> +};
>> +
>>  /*
>>   * migrate_pages - migrate the folios specified in a list, to the free folios
>>   *		   supplied as the target for the page migration
>> @@ -1430,13 +1438,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	int large_retry = 1;
>>  	int thp_retry = 1;
>>  	int nr_failed = 0;
>> -	int nr_failed_pages = 0;
>>  	int nr_retry_pages = 0;
>> -	int nr_succeeded = 0;
>> -	int nr_thp_succeeded = 0;
>>  	int nr_large_failed = 0;
>> -	int nr_thp_failed = 0;
>> -	int nr_thp_split = 0;
>>  	int pass = 0;
>>  	bool is_large = false;
>>  	bool is_thp = false;
>> @@ -1446,9 +1449,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	LIST_HEAD(split_folios);
>>  	bool nosplit = (reason == MR_NUMA_MISPLACED);
>>  	bool no_split_folio_counting = false;
>> +	struct migrate_pages_stats stats;
>>  
>>  	trace_mm_migrate_pages_start(mode, reason);
>>  
>> +	memset(&stats, 0, sizeof(stats));
>>  split_folio_migration:
>>  	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>>  		retry = 0;
>> @@ -1502,9 +1507,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				/* Large folio migration is unsupported */
>>  				if (is_large) {
>>  					nr_large_failed++;
>> -					nr_thp_failed += is_thp;
>> +					stats.nr_thp_failed += is_thp;
>>  					if (!try_split_folio(folio, &split_folios)) {
>> -						nr_thp_split += is_thp;
>> +						stats.nr_thp_split += is_thp;
>>  						break;
>>  					}
>>  				/* Hugetlb migration is unsupported */
>> @@ -1512,7 +1517,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  					nr_failed++;
>>  				}
>>  
>> -				nr_failed_pages += nr_pages;
>> +				stats.nr_failed_pages += nr_pages;
>>  				list_move_tail(&folio->lru, &ret_folios);
>>  				break;
>>  			case -ENOMEM:
>> @@ -1522,13 +1527,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				 */
>>  				if (is_large) {
>>  					nr_large_failed++;
>> -					nr_thp_failed += is_thp;
>> +					stats.nr_thp_failed += is_thp;
>>  					/* Large folio NUMA faulting doesn't split to retry. */
>>  					if (!nosplit) {
>>  						int ret = try_split_folio(folio, &split_folios);
>>  
>>  						if (!ret) {
>> -							nr_thp_split += is_thp;
>> +							stats.nr_thp_split += is_thp;
>>  							break;
>>  						} else if (reason == MR_LONGTERM_PIN &&
>>  							   ret == -EAGAIN) {
>> @@ -1546,7 +1551,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  					nr_failed++;
>>  				}
>>  
>> -				nr_failed_pages += nr_pages + nr_retry_pages;
>> +				stats.nr_failed_pages += nr_pages + nr_retry_pages;
>>  				/*
>>  				 * There might be some split folios of fail-to-migrate large
>>  				 * folios left in split_folios list. Move them back to migration
>> @@ -1556,7 +1561,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				list_splice_init(&split_folios, from);
>>  				/* nr_failed isn't updated for not used */
>>  				nr_large_failed += large_retry;
>> -				nr_thp_failed += thp_retry;
>> +				stats.nr_thp_failed += thp_retry;
>>  				goto out;
>>  			case -EAGAIN:
>>  				if (is_large) {
>> @@ -1568,8 +1573,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				nr_retry_pages += nr_pages;
>>  				break;
>>  			case MIGRATEPAGE_SUCCESS:
>> -				nr_succeeded += nr_pages;
>> -				nr_thp_succeeded += is_thp;
>> +				stats.nr_succeeded += nr_pages;
>> +				stats.nr_thp_succeeded += is_thp;
>>  				break;
>>  			default:
>>  				/*
>> @@ -1580,20 +1585,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				 */
>>  				if (is_large) {
>>  					nr_large_failed++;
>> -					nr_thp_failed += is_thp;
>> +					stats.nr_thp_failed += is_thp;
>>  				} else if (!no_split_folio_counting) {
>>  					nr_failed++;
>>  				}
>>  
>> -				nr_failed_pages += nr_pages;
>> +				stats.nr_failed_pages += nr_pages;
>>  				break;
>>  			}
>>  		}
>>  	}
>>  	nr_failed += retry;
>>  	nr_large_failed += large_retry;
>> -	nr_thp_failed += thp_retry;
>> -	nr_failed_pages += nr_retry_pages;
>> +	stats.nr_thp_failed += thp_retry;
>> +	stats.nr_failed_pages += nr_retry_pages;
>>  	/*
>>  	 * Try to migrate split folios of fail-to-migrate large folios, no
>>  	 * nr_failed counting in this round, since all split folios of a
>> @@ -1626,16 +1631,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	if (list_empty(from))
>>  		rc = 0;
>>  
>> -	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>> -	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>> -	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>> -	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>> -	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
>> -			       nr_thp_failed, nr_thp_split, mode, reason);
>> +	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
>> +	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
>> +	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
>> +	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
>> +	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
>> +	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
>> +			       stats.nr_thp_succeeded, stats.nr_thp_failed,
>> +			       stats.nr_thp_split, mode, reason);
>>  
>>  	if (ret_succeeded)
>> -		*ret_succeeded = nr_succeeded;
>> +		*ret_succeeded = stats.nr_succeeded;
>>  
>>  	return rc;
>>  }
