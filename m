Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B867FC37
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjA2Brx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjA2Bru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:47:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB81CAC5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:47:46 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P4Dhn752wzfYkR;
        Sun, 29 Jan 2023 09:47:37 +0800 (CST)
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 09:47:43 +0800
Message-ID: <c27bb73a-9dde-94c1-f2fe-92a71ff268b2@huawei.com>
Date:   Sun, 29 Jan 2023 09:47:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH -v3 2/9] migrate_pages: separate hugetlb folios migration
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
References: <20230116063057.653862-1-ying.huang@intel.com>
 <20230116063057.653862-3-ying.huang@intel.com>
 <c1f1e516-308b-3ec1-72b4-018d42def2d0@huawei.com>
 <87edrech21.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <87edrech21.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/29 8:36, Huang, Ying 写道:
> Chen Wandun <chenwandun@huawei.com> writes:
>
>> On 2023/1/16 14:30, Huang Ying wrote:
>>> This is a preparation patch to batch the folio unmapping and moving
>>> for the non-hugetlb folios.  Based on that we can batch the TLB
>>> shootdown during the folio migration and make it possible to use some
>>> hardware accelerator for the folio copying.
>>>
>>> In this patch the hugetlb folios and non-hugetlb folios migration is
>>> separated in migrate_pages() to make it easy to change the non-hugetlb
>>> folios migration implementation.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Bharata B Rao <bharata@amd.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: haoxin <xhao@linux.alibaba.com>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> ---
>>>    mm/migrate.c | 141 +++++++++++++++++++++++++++++++++++++++++++--------
>>>    1 file changed, 119 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index ef388a9e4747..be7f37523463 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1396,6 +1396,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>>    	return rc;
>>>    }
>>>    +#define NR_MAX_MIGRATE_PAGES_RETRY	10
>>> +
>>>    struct migrate_pages_stats {
>>>    	int nr_succeeded;	/* Normal and large folios migrated successfully, in
>>>    				   units of base pages */
>>> @@ -1406,6 +1408,95 @@ struct migrate_pages_stats {
>>>    	int nr_thp_split;	/* THP split before migrating */
>>>    };
>>>    +/*
>>> + * Returns the number of hugetlb folios that were not migrated, or an error code
>>> + * after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no hugetlb folios are movable
>>> + * any more because the list has become empty or no retryable hugetlb folios
>>> + * exist any more. It is caller's responsibility to call putback_movable_pages()
>>> + * only if ret != 0.
>>> + */
>>> +static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
>>> +			    free_page_t put_new_page, unsigned long private,
>>> +			    enum migrate_mode mode, int reason,
>>> +			    struct migrate_pages_stats *stats,
>>> +			    struct list_head *ret_folios)
>>> +{
>>> +	int retry = 1;
>>> +	int nr_failed = 0;
>>> +	int nr_retry_pages = 0;
>>> +	int pass = 0;
>>> +	struct folio *folio, *folio2;
>>> +	int rc, nr_pages;
>>> +
>>> +	for (pass = 0; pass < NR_MAX_MIGRATE_PAGES_RETRY && retry; pass++) {
>>> +		retry = 0;
>>> +		nr_retry_pages = 0;
>>> +
>>> +		list_for_each_entry_safe(folio, folio2, from, lru) {
>>> +			if (!folio_test_hugetlb(folio))
>>> +				continue;
>>> +
>>> +			nr_pages = folio_nr_pages(folio);
>>> +
>>> +			cond_resched();
>>> +
>>> +			rc = unmap_and_move_huge_page(get_new_page,
>>> +						      put_new_page, private,
>>> +						      &folio->page, pass > 2, mode,
>>> +						      reason, ret_folios);
>>> +			/*
>>> +			 * The rules are:
>>> +			 *	Success: hugetlb folio will be put back
>>> +			 *	-EAGAIN: stay on the from list
>>> +			 *	-ENOMEM: stay on the from list
>>> +			 *	-ENOSYS: stay on the from list
>>> +			 *	Other errno: put on ret_folios list
>>> +			 */
>>> +			switch(rc) {
>>> +			case -ENOSYS:
>>> +				/* Hugetlb migration is unsupported */
>>> +				nr_failed++;
>>> +				stats->nr_failed_pages += nr_pages;
>>> +				list_move_tail(&folio->lru, ret_folios);
>>> +				break;
>>> +			case -ENOMEM:
>>> +				/*
>>> +				 * When memory is low, don't bother to try to migrate
>>> +				 * other folios, just exit.
>>> +				 */
>>> +				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>>> +				return -ENOMEM;
>>> +			case -EAGAIN:
>>> +				retry++;
>>> +				nr_retry_pages += nr_pages;
>>> +				break;
>>> +			case MIGRATEPAGE_SUCCESS:
>>> +				stats->nr_succeeded += nr_pages;
>>> +				break;
>>> +			default:
>>> +				/*
>>> +				 * Permanent failure (-EBUSY, etc.):
>>> +				 * unlike -EAGAIN case, the failed folio is
>>> +				 * removed from migration folio list and not
>>> +				 * retried in the next outer loop.
>>> +				 */
>>> +				nr_failed++;
>>> +				stats->nr_failed_pages += nr_pages;
>>> +				break;
>>> +			}
>>> +		}
>>> +	}
>>> +	/*
>>> +	 * nr_failed is number of hugetlb folios failed to be migrated.  After
>>> +	 * NR_MAX_MIGRATE_PAGES_RETRY attempts, give up and count retried hugetlb
>>> +	 * folios as failed.
>>> +	 */
>>> +	nr_failed += retry;
>>> +	stats->nr_failed_pages += nr_retry_pages;
>>> +
>>> +	return nr_failed;
>>> +}
>>> +
>>>    /*
>>>     * migrate_pages - migrate the folios specified in a list, to the free folios
>>>     *		   supplied as the target for the page migration
>>> @@ -1422,10 +1513,10 @@ struct migrate_pages_stats {
>>>     * @ret_succeeded:	Set to the number of folios migrated successfully if
>>>     *			the caller passes a non-NULL pointer.
>>>     *
>>> - * The function returns after 10 attempts or if no folios are movable any more
>>> - * because the list has become empty or no retryable folios exist any more.
>>> - * It is caller's responsibility to call putback_movable_pages() to return folios
>>> - * to the LRU or free list only if ret != 0.
>>> + * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
>>> + * are movable any more because the list has become empty or no retryable folios
>>> + * exist any more. It is caller's responsibility to call putback_movable_pages()
>>> + * only if ret != 0.
>>>     *
>>>     * Returns the number of {normal folio, large folio, hugetlb} that were not
>>>     * migrated, or an error code. The number of large folio splits will be
>>> @@ -1439,7 +1530,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>    	int retry = 1;
>>>    	int large_retry = 1;
>>>    	int thp_retry = 1;
>>> -	int nr_failed = 0;
>>> +	int nr_failed;
>>>    	int nr_retry_pages = 0;
>>>    	int nr_large_failed = 0;
>>>    	int pass = 0;
>>> @@ -1456,38 +1547,45 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>    	trace_mm_migrate_pages_start(mode, reason);
>>>      	memset(&stats, 0, sizeof(stats));
>>> +	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
>>> +			      &stats, &ret_folios);
>>> +	if (rc < 0)
>>> +		goto out;
>> How about continue migrate small page for -ENOMEM case? maybe
>> there are still
>> free small pages.
> Sounds reasonable to me.  How about do that on top of this series?  Do
> you have interest to do that?
Happy to do that, thanks for you reply.

Best Regards,
Wandun
>
> Best Regards,
> Huang, Ying
>
> .

