Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3515E57E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIVBQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiIVBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:16:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFFAB1B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663809339; x=1695345339;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=7JGgeiKPZDSphe46TEdkWdM/ODuTtoo1WqFDi/uvOlw=;
  b=Lf14jrjkmm8HfzjYKRhJUdInsFk1MRU04TOE8YCAskNKsbNK4TolnylD
   aq9JZLSS5HjHoSHMNjz6JYJLaP7+wSj+p64I/hukgv5wwvg54vW/KDoPn
   Mo8wVIK2afeBjL8xT85Vs8a4kygw2o9dqhfPUCeHetUAY+TmWkRKi5VbB
   JtS1WNsCi4t1Gjl5QX4ucu/V9icwCVHKv5vCqPd0eoGkLsGWoz75tnine
   p/7XVtcmzKcI/Rr/5KAvUgQSKEjjWpYQXz4dq/CVCSd2MsbUwBdymEDpe
   ZVcRH2zhBKeE6wdqatnz0SbPsLq7hOfR+TnZYAu7fYczJ7pFz3H0xNpJG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364144338"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="364144338"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:14:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="794895421"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:14:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [RFC 1/6] mm/migrate_pages: separate huge page and normal pages
 migration
References: <20220921060616.73086-1-ying.huang@intel.com>
        <20220921060616.73086-2-ying.huang@intel.com>
        <7192F7C6-CA9F-4184-832F-673D2ED5061D@nvidia.com>
Date:   Thu, 22 Sep 2022 09:14:17 +0800
In-Reply-To: <7192F7C6-CA9F-4184-832F-673D2ED5061D@nvidia.com> (Zi Yan's
        message of "Wed, 21 Sep 2022 11:55:41 -0400")
Message-ID: <87mtasky6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Hi, Zi,

Thank you for comments!

Zi Yan <ziy@nvidia.com> writes:

> On 21 Sep 2022, at 2:06, Huang Ying wrote:
>
>> This is a preparation patch to batch the page unmapping and moving for
>> the normal pages and THPs.  Based on that we can batch the TLB
>> shootdown during the page migration and make it possible to use some
>> hardware accelerator for the page copying.
>>
>> In this patch the huge page (PageHuge()) and normal page and THP
>> migration is separated in migrate_pages() to make it easy to change
>> the normal page and THP migration implementation.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> ---
>>  mm/migrate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 64 insertions(+), 9 deletions(-)
>
> Maybe it would be better to have two subroutines for hugetlb migration
> and normal page migration respectively. migrate_pages() becomes very
> large at this point.

Yes.  migrate_pages() becomes even larger with this patchset.  I will
consider more about how to deal with that.  I will try the method in
your comments in [3/6] for that too.

Best Regards,
Huang, Ying

>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 571d8c9fd5bc..117134f1c6dc 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1414,6 +1414,66 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>
>>  	trace_mm_migrate_pages_start(mode, reason);
>>
>> +	for (pass = 0; pass < 10 && retry; pass++) {
>> +		retry = 0;
>> +
>> +		list_for_each_entry_safe(page, page2, from, lru) {
>> +			nr_subpages = compound_nr(page);
>> +			cond_resched();
>> +
>> +			if (!PageHuge(page))
>> +				continue;
>> +
>> +			rc = unmap_and_move_huge_page(get_new_page,
>> +						put_new_page, private, page,
>> +						pass > 2, mode, reason,
>> +						&ret_pages);
>> +			/*
>> +			 * The rules are:
>> +			 *	Success: hugetlb page will be put back
>> +			 *	-EAGAIN: stay on the from list
>> +			 *	-ENOMEM: stay on the from list
>> +			 *	-ENOSYS: stay on the from list
>> +			 *	Other errno: put on ret_pages list then splice to
>> +			 *		     from list
>> +			 */
>> +			switch(rc) {
>> +			case -ENOSYS:
>> +				/* Hugetlb migration is unsupported */
>> +				nr_failed++;
>> +				nr_failed_pages += nr_subpages;
>> +				list_move_tail(&page->lru, &ret_pages);
>> +				break;
>> +			case -ENOMEM:
>> +				/*
>> +				 * When memory is low, don't bother to try to migrate
>> +				 * other pages, just exit.
>> +				 */
>> +				nr_failed++;
>> +				nr_failed_pages += nr_subpages + nr_retry_pages;
>> +				goto out;
>> +			case -EAGAIN:
>> +				retry++;
>> +				nr_retry_pages += nr_subpages;
>> +				break;
>> +			case MIGRATEPAGE_SUCCESS:
>> +				nr_succeeded += nr_subpages;
>> +				break;
>> +			default:
>> +				/*
>> +				 * Permanent failure (-EBUSY, etc.):
>> +				 * unlike -EAGAIN case, the failed page is
>> +				 * removed from migration page list and not
>> +				 * retried in the next outer loop.
>> +				 */
>> +				nr_failed++;
>> +				nr_failed_pages += nr_subpages;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	nr_failed += retry;
>> +	retry = 1;
>>  thp_subpage_migration:
>>  	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>>  		retry = 0;
>> @@ -1431,18 +1491,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  			cond_resched();
>>
>>  			if (PageHuge(page))
>> -				rc = unmap_and_move_huge_page(get_new_page,
>> -						put_new_page, private, page,
>> -						pass > 2, mode, reason,
>> -						&ret_pages);
>> -			else
>> -				rc = unmap_and_move(get_new_page, put_new_page,
>> +				continue;
>> +
>> +			rc = unmap_and_move(get_new_page, put_new_page,
>>  						private, page, pass > 2, mode,
>>  						reason, &ret_pages);
>>  			/*
>>  			 * The rules are:
>> -			 *	Success: non hugetlb page will be freed, hugetlb
>> -			 *		 page will be put back
>> +			 *	Success: page will be freed
>>  			 *	-EAGAIN: stay on the from list
>>  			 *	-ENOMEM: stay on the from list
>>  			 *	-ENOSYS: stay on the from list
>> @@ -1468,7 +1524,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  						nr_thp_split++;
>>  						break;
>>  					}
>> -				/* Hugetlb migration is unsupported */
>>  				} else if (!no_subpage_counting) {
>>  					nr_failed++;
>>  				}
>> -- 
>> 2.35.1
>
>
> --
> Best Regards,
> Yan, Zi
