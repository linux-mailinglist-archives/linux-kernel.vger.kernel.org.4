Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5DF665199
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjAKCRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAKCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:16:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7F0CF2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673403396; x=1704939396;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=j0qLwbFlLqZ4rZRMTGUjGc7UB3n+UMvYcWq80priuAI=;
  b=L7BTsaMq5B/tT11fqqzvTrV95+6uel53zAWYEbS+n5TofCzgsv/SDXnb
   Js4xIjKDV9+KDl+M8bbBnmdjdkKnA5eTISBC3TER3eICu9oTrGPp+ZeOn
   QJL4ey0twFXSfG0ALYSuv4b6AedFkCSQk89rDkrSBNaTlZg71VL1Vse/N
   7ebck2VQEJcU/tV2DdzIQnhpCyHLDqLuJHJxHIas7qa+yuJSYNUJdZNyu
   f4RPK54lby4bfXi45B2Xpa7QPsjJC3rlw30W2fhx0+4ZRxV6rdz1sTUTJ
   3V//5dndNaRn2WaiHgWcuOFqsot5kBJsjE55WC1Wkb049k5T2TVF4QlA+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311121293"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="311121293"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 18:16:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657270453"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="657270453"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 18:16:32 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 1/9] migrate_pages: organize stats with struct
 migrate_pages_stats
References: <20230110075327.590514-1-ying.huang@intel.com>
        <20230110075327.590514-2-ying.huang@intel.com>
        <9d27d10c-ba9a-045d-c170-fa3c4d6ea416@linux.alibaba.com>
Date:   Wed, 11 Jan 2023 10:15:40 +0800
In-Reply-To: <9d27d10c-ba9a-045d-c170-fa3c4d6ea416@linux.alibaba.com> (Baolin
        Wang's message of "Tue, 10 Jan 2023 18:03:09 +0800")
Message-ID: <87a62p4y0j.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 1/10/2023 3:53 PM, Huang Ying wrote:
>> Define struct migrate_pages_stats to organize the various statistics
>> in migrate_pages().  This makes it easier to collect and consume the
>> statistics in multiple functions.  This will be needed in the
>> following patches in the series.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: haoxin <xhao@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 60 +++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 34 insertions(+), 26 deletions(-)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a4d3fc65085f..d21de40861a0 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1396,6 +1396,16 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>   	return rc;
>>   }
>>   +struct migrate_pages_stats {
>> +	int nr_succeeded;	/* Normal pages and THP migrated successfully, in units
>> +				   of base pages */
>> +	int nr_failed_pages;	/* Normal pages and THP failed to be migrated, in units
>> +				   of base pages.  Untried pages aren't counted */
>
> I think above 2 fields also contain the number of hugetlb
> pages. Otherwise looks good to me.

Yes.  Good catch, will update the patch.

> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks!

Best Regards,
Huang, Ying

>
>> +	int nr_thp_succeeded;	/* THP migrated successfully */
>> +	int nr_thp_failed;	/* THP failed to be migrated */
>> +	int nr_thp_split;	/* THP split before migrating */
>> +};
>> +
>>   /*
>>    * migrate_pages - migrate the folios specified in a list, to the free folios
>>    *		   supplied as the target for the page migration
>> @@ -1430,13 +1440,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	int large_retry = 1;
>>   	int thp_retry = 1;
>>   	int nr_failed = 0;
>> -	int nr_failed_pages = 0;
>>   	int nr_retry_pages = 0;
>> -	int nr_succeeded = 0;
>> -	int nr_thp_succeeded = 0;
>>   	int nr_large_failed = 0;
>> -	int nr_thp_failed = 0;
>> -	int nr_thp_split = 0;
>>   	int pass = 0;
>>   	bool is_large = false;
>>   	bool is_thp = false;
>> @@ -1446,9 +1451,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	LIST_HEAD(split_folios);
>>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
>>   	bool no_split_folio_counting = false;
>> +	struct migrate_pages_stats stats;
>>     	trace_mm_migrate_pages_start(mode, reason);
>>   +	memset(&stats, 0, sizeof(stats));
>>   split_folio_migration:
>>   	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>>   		retry = 0;
>> @@ -1502,9 +1509,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				/* Large folio migration is unsupported */
>>   				if (is_large) {
>>   					nr_large_failed++;
>> -					nr_thp_failed += is_thp;
>> +					stats.nr_thp_failed += is_thp;
>>   					if (!try_split_folio(folio, &split_folios)) {
>> -						nr_thp_split += is_thp;
>> +						stats.nr_thp_split += is_thp;
>>   						break;
>>   					}
>>   				/* Hugetlb migration is unsupported */
>> @@ -1512,7 +1519,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   					nr_failed++;
>>   				}
>>   -				nr_failed_pages += nr_pages;
>> +				stats.nr_failed_pages += nr_pages;
>>   				list_move_tail(&folio->lru, &ret_folios);
>>   				break;
>>   			case -ENOMEM:
>> @@ -1522,13 +1529,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				 */
>>   				if (is_large) {
>>   					nr_large_failed++;
>> -					nr_thp_failed += is_thp;
>> +					stats.nr_thp_failed += is_thp;
>>   					/* Large folio NUMA faulting doesn't split to retry. */
>>   					if (!nosplit) {
>>   						int ret = try_split_folio(folio, &split_folios);
>>     						if (!ret) {
>> -							nr_thp_split += is_thp;
>> +							stats.nr_thp_split += is_thp;
>>   							break;
>>   						} else if (reason == MR_LONGTERM_PIN &&
>>   							   ret == -EAGAIN) {
>> @@ -1546,7 +1553,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   					nr_failed++;
>>   				}
>>   -				nr_failed_pages += nr_pages +
>> nr_retry_pages;
>> +				stats.nr_failed_pages += nr_pages + nr_retry_pages;
>>   				/*
>>   				 * There might be some split folios of fail-to-migrate large
>>   				 * folios left in split_folios list. Move them back to migration
>> @@ -1556,7 +1563,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				list_splice_init(&split_folios, from);
>>   				/* nr_failed isn't updated for not used */
>>   				nr_large_failed += large_retry;
>> -				nr_thp_failed += thp_retry;
>> +				stats.nr_thp_failed += thp_retry;
>>   				goto out;
>>   			case -EAGAIN:
>>   				if (is_large) {
>> @@ -1568,8 +1575,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				nr_retry_pages += nr_pages;
>>   				break;
>>   			case MIGRATEPAGE_SUCCESS:
>> -				nr_succeeded += nr_pages;
>> -				nr_thp_succeeded += is_thp;
>> +				stats.nr_succeeded += nr_pages;
>> +				stats.nr_thp_succeeded += is_thp;
>>   				break;
>>   			default:
>>   				/*
>> @@ -1580,20 +1587,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				 */
>>   				if (is_large) {
>>   					nr_large_failed++;
>> -					nr_thp_failed += is_thp;
>> +					stats.nr_thp_failed += is_thp;
>>   				} else if (!no_split_folio_counting) {
>>   					nr_failed++;
>>   				}
>>   -				nr_failed_pages += nr_pages;
>> +				stats.nr_failed_pages += nr_pages;
>>   				break;
>>   			}
>>   		}
>>   	}
>>   	nr_failed += retry;
>>   	nr_large_failed += large_retry;
>> -	nr_thp_failed += thp_retry;
>> -	nr_failed_pages += nr_retry_pages;
>> +	stats.nr_thp_failed += thp_retry;
>> +	stats.nr_failed_pages += nr_retry_pages;
>>   	/*
>>   	 * Try to migrate split folios of fail-to-migrate large folios, no
>>   	 * nr_failed counting in this round, since all split folios of a
>> @@ -1626,16 +1633,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	if (list_empty(from))
>>   		rc = 0;
>>   -	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
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
>>     	if (ret_succeeded)
>> -		*ret_succeeded = nr_succeeded;
>> +		*ret_succeeded = stats.nr_succeeded;
>>     	return rc;
>>   }
