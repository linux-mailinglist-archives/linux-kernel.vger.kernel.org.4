Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64F67FBF7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 01:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjA2AiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 19:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2AiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 19:38:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA554C22
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 16:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674952678; x=1706488678;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gK6yNJ0vHyVa4Kuqj72bhs0k5Sg+88tKiBNGsNOF2MA=;
  b=XSxWQuZvZQ9EZZ38v6Nwpbo/2vn9MJ9/qZd0Mv+hLpVKz2XUWntsz3F6
   7J/drBWlPIqTj26YCS9+sgx3eySzWuH0/It+0pa6WJv50MtvBiPB3pPgO
   AT/d4v1C6se7/iBtfRrOmSOS4J9IvZd2agP8+K/eZlRwSPfRjHOVhORFj
   A7XEMMgFXZ/kVeXHli7WM8p0V1r+R7F/JiN88CUHxuGtkWP095wE7CHEF
   FOsDUycE9KsYuU5wpBg5iUtD2GixYtcmf0ifm8TjeDJowepZ3Of5v8W6Y
   F1Yf6douyQKC9t3pzztpTXrXSQJ31fq4ESc4m9IZXNKLKUv2VL1kNiEz7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="310970639"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="310970639"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 16:37:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="837565513"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="837565513"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 16:37:53 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH -v3 2/9] migrate_pages: separate hugetlb folios migration
References: <20230116063057.653862-1-ying.huang@intel.com>
        <20230116063057.653862-3-ying.huang@intel.com>
        <c1f1e516-308b-3ec1-72b4-018d42def2d0@huawei.com>
Date:   Sun, 29 Jan 2023 08:36:54 +0800
In-Reply-To: <c1f1e516-308b-3ec1-72b4-018d42def2d0@huawei.com> (Chen Wandun's
        message of "Sat, 28 Jan 2023 17:29:30 +0800")
Message-ID: <87edrech21.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Wandun <chenwandun@huawei.com> writes:

> On 2023/1/16 14:30, Huang Ying wrote:
>> This is a preparation patch to batch the folio unmapping and moving
>> for the non-hugetlb folios.  Based on that we can batch the TLB
>> shootdown during the folio migration and make it possible to use some
>> hardware accelerator for the folio copying.
>>
>> In this patch the hugetlb folios and non-hugetlb folios migration is
>> separated in migrate_pages() to make it easy to change the non-hugetlb
>> folios migration implementation.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: haoxin <xhao@linux.alibaba.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> ---
>>   mm/migrate.c | 141 +++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 119 insertions(+), 22 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ef388a9e4747..be7f37523463 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1396,6 +1396,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>   	return rc;
>>   }
>>   +#define NR_MAX_MIGRATE_PAGES_RETRY	10
>> +
>>   struct migrate_pages_stats {
>>   	int nr_succeeded;	/* Normal and large folios migrated successfully, in
>>   				   units of base pages */
>> @@ -1406,6 +1408,95 @@ struct migrate_pages_stats {
>>   	int nr_thp_split;	/* THP split before migrating */
>>   };
>>   +/*
>> + * Returns the number of hugetlb folios that were not migrated, or an error code
>> + * after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no hugetlb folios are movable
>> + * any more because the list has become empty or no retryable hugetlb folios
>> + * exist any more. It is caller's responsibility to call putback_movable_pages()
>> + * only if ret != 0.
>> + */
>> +static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
>> +			    free_page_t put_new_page, unsigned long private,
>> +			    enum migrate_mode mode, int reason,
>> +			    struct migrate_pages_stats *stats,
>> +			    struct list_head *ret_folios)
>> +{
>> +	int retry = 1;
>> +	int nr_failed = 0;
>> +	int nr_retry_pages = 0;
>> +	int pass = 0;
>> +	struct folio *folio, *folio2;
>> +	int rc, nr_pages;
>> +
>> +	for (pass = 0; pass < NR_MAX_MIGRATE_PAGES_RETRY && retry; pass++) {
>> +		retry = 0;
>> +		nr_retry_pages = 0;
>> +
>> +		list_for_each_entry_safe(folio, folio2, from, lru) {
>> +			if (!folio_test_hugetlb(folio))
>> +				continue;
>> +
>> +			nr_pages = folio_nr_pages(folio);
>> +
>> +			cond_resched();
>> +
>> +			rc = unmap_and_move_huge_page(get_new_page,
>> +						      put_new_page, private,
>> +						      &folio->page, pass > 2, mode,
>> +						      reason, ret_folios);
>> +			/*
>> +			 * The rules are:
>> +			 *	Success: hugetlb folio will be put back
>> +			 *	-EAGAIN: stay on the from list
>> +			 *	-ENOMEM: stay on the from list
>> +			 *	-ENOSYS: stay on the from list
>> +			 *	Other errno: put on ret_folios list
>> +			 */
>> +			switch(rc) {
>> +			case -ENOSYS:
>> +				/* Hugetlb migration is unsupported */
>> +				nr_failed++;
>> +				stats->nr_failed_pages += nr_pages;
>> +				list_move_tail(&folio->lru, ret_folios);
>> +				break;
>> +			case -ENOMEM:
>> +				/*
>> +				 * When memory is low, don't bother to try to migrate
>> +				 * other folios, just exit.
>> +				 */
>> +				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>> +				return -ENOMEM;
>> +			case -EAGAIN:
>> +				retry++;
>> +				nr_retry_pages += nr_pages;
>> +				break;
>> +			case MIGRATEPAGE_SUCCESS:
>> +				stats->nr_succeeded += nr_pages;
>> +				break;
>> +			default:
>> +				/*
>> +				 * Permanent failure (-EBUSY, etc.):
>> +				 * unlike -EAGAIN case, the failed folio is
>> +				 * removed from migration folio list and not
>> +				 * retried in the next outer loop.
>> +				 */
>> +				nr_failed++;
>> +				stats->nr_failed_pages += nr_pages;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	/*
>> +	 * nr_failed is number of hugetlb folios failed to be migrated.  After
>> +	 * NR_MAX_MIGRATE_PAGES_RETRY attempts, give up and count retried hugetlb
>> +	 * folios as failed.
>> +	 */
>> +	nr_failed += retry;
>> +	stats->nr_failed_pages += nr_retry_pages;
>> +
>> +	return nr_failed;
>> +}
>> +
>>   /*
>>    * migrate_pages - migrate the folios specified in a list, to the free folios
>>    *		   supplied as the target for the page migration
>> @@ -1422,10 +1513,10 @@ struct migrate_pages_stats {
>>    * @ret_succeeded:	Set to the number of folios migrated successfully if
>>    *			the caller passes a non-NULL pointer.
>>    *
>> - * The function returns after 10 attempts or if no folios are movable any more
>> - * because the list has become empty or no retryable folios exist any more.
>> - * It is caller's responsibility to call putback_movable_pages() to return folios
>> - * to the LRU or free list only if ret != 0.
>> + * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
>> + * are movable any more because the list has become empty or no retryable folios
>> + * exist any more. It is caller's responsibility to call putback_movable_pages()
>> + * only if ret != 0.
>>    *
>>    * Returns the number of {normal folio, large folio, hugetlb} that were not
>>    * migrated, or an error code. The number of large folio splits will be
>> @@ -1439,7 +1530,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	int retry = 1;
>>   	int large_retry = 1;
>>   	int thp_retry = 1;
>> -	int nr_failed = 0;
>> +	int nr_failed;
>>   	int nr_retry_pages = 0;
>>   	int nr_large_failed = 0;
>>   	int pass = 0;
>> @@ -1456,38 +1547,45 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	trace_mm_migrate_pages_start(mode, reason);
>>     	memset(&stats, 0, sizeof(stats));
>> +	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
>> +			      &stats, &ret_folios);
>> +	if (rc < 0)
>> +		goto out;
> How about continue migrate small page for -ENOMEM case? maybe
> there are still
> free small pages.

Sounds reasonable to me.  How about do that on top of this series?  Do
you have interest to do that?

Best Regards,
Huang, Ying
