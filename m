Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF165E544
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjAEFw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAEFwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:52:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2993D9EC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672897972; x=1704433972;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=3EXkT2fNQRTFG2OT2VWG5ftzhhu7iIfPyf2Gk/i3nmc=;
  b=IuyCgEBYo2Vg4Lqsl0Zh31bZATVhXlCAQMKc03qHX+U92GA3rKUMthX4
   rNKKIgROFNBGoeBcYRpF/uuc7aHA4kVhckp4FwIdriR2OxDM9W+oeJGCD
   hGPoIMNbc7wUdZmD2sveYEVfFNhuBwfmCyZeHnI6RDRoxS7OHN8Ok1ef/
   dGRU32nkdu+VGzbNlbF0Oi8C1ae3j5PKKowGSXq8J5dYHgDYlCsVTAUSY
   oUXuZM9Y0a8i1fZXZnYgy/Jxk7sW7QM8SRNi56nfTbnCGAU6ISlbWGxOb
   DwNDR+J6ONAYFfytk3RosXKRI7+4VqM7CGQgi1iXbjZpHBGPOGAK31QEO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320830750"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="320830750"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:52:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655435332"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="655435332"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:52:47 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Bharata B Rao" <bharata@amd.com>, haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-3-ying.huang@intel.com>
        <87pmbttxmj.fsf@nvidia.com>
Date:   Thu, 05 Jan 2023 13:51:54 +0800
In-Reply-To: <87pmbttxmj.fsf@nvidia.com> (Alistair Popple's message of "Thu,
        05 Jan 2023 15:13:25 +1100")
Message-ID: <87pmbtedfp.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Alistair Popple <apopple@nvidia.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
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
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: haoxin <xhao@linux.alibaba.com>
>> ---
>>  mm/migrate.c | 114 ++++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 99 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ec9263a33d38..bdbe73fe2eb7 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1404,6 +1404,87 @@ struct migrate_pages_stats {
>>  	int nr_thp_split;
>>  };
>>  
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
>> +	int rc = 0, nr_pages;
>> +
>> +	for (pass = 0; pass < 10 && retry; pass++) {
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
>> +				nr_failed++;
>
> This currently isn't relevant for -ENOMEM and I think it would be
> clearer if it was dropped.

OK.

>> +				stats->nr_failed_pages += nr_pages;
>
> Makes sense not to continue migration with low memory, but shouldn't we
> add the remaining unmigrated hugetlb folios to stats->nr_failed_pages as
> well? Ie. don't we still have to continue the iteration to to find and
> account for these?

I think nr_failed_pages only counts tried pages.  IIUC, it's the
original behavior and behavior for non-hugetlb pages too.

>> +				goto out;
>
> Given this is the only use of the out label, and that there is a special
> case for -ENOMEM there anyway I think it would be clearer to return
> directly.

Sounds good.  Will do that in next version.

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
>> +out:
>> +	nr_failed += retry;
>> +	stats->nr_failed_pages += nr_retry_pages;
>> +	if (rc != -ENOMEM)
>> +		rc = nr_failed;
>> +
>> +	return rc;
>> +}
>> +
>>  /*
>>   * migrate_pages - migrate the folios specified in a list, to the free folios
>>   *		   supplied as the target for the page migration
>> @@ -1437,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	int retry = 1;
>>  	int large_retry = 1;
>>  	int thp_retry = 1;
>> -	int nr_failed = 0;
>> +	int nr_failed;
>>  	int nr_retry_pages = 0;
>>  	int nr_large_failed = 0;
>>  	int pass = 0;
>> @@ -1454,6 +1535,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	trace_mm_migrate_pages_start(mode, reason);
>>  
>>  	memset(&stats, 0, sizeof(stats));
>> +	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
>> +			      &stats, &ret_folios);
>> +	if (rc < 0)
>> +		goto out;
>> +	nr_failed = rc;
>> +
>>  split_folio_migration:
>>  	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>>  		retry = 0;
>> @@ -1462,30 +1549,28 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  		nr_retry_pages = 0;
>>  
>>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>> +			if (folio_test_hugetlb(folio)) {
>
> How do we hit this case? Shouldn't migrate_hugetlbs() have already moved
> any hugetlb folios off the from list?

Retried hugetlb folios will be kept in from list.

>> +				list_move_tail(&folio->lru, &ret_folios);
>> +				continue;
>> +			}
>> +
>>  			/*
>>  			 * Large folio statistics is based on the source large
>>  			 * folio. Capture required information that might get
>>  			 * lost during migration.
>>  			 */
>> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
>> +			is_large = folio_test_large(folio);
>>  			is_thp = is_large && folio_test_pmd_mappable(folio);
>>  			nr_pages = folio_nr_pages(folio);
>> +
>>  			cond_resched();
>>  
>> -			if (folio_test_hugetlb(folio))
>> -				rc = unmap_and_move_huge_page(get_new_page,
>> -						put_new_page, private,
>> -						&folio->page, pass > 2, mode,
>> -						reason,
>> -						&ret_folios);
>> -			else
>> -				rc = unmap_and_move(get_new_page, put_new_page,
>> -						private, folio, pass > 2, mode,
>> -						reason, &ret_folios);
>> +			rc = unmap_and_move(get_new_page, put_new_page,
>> +					    private, folio, pass > 2, mode,
>> +					    reason, &ret_folios);
>>  			/*
>>  			 * The rules are:
>> -			 *	Success: non hugetlb folio will be freed, hugetlb
>> -			 *		 folio will be put back
>> +			 *	Success: folio will be freed
>>  			 *	-EAGAIN: stay on the from list
>>  			 *	-ENOMEM: stay on the from list
>>  			 *	-ENOSYS: stay on the from list
>> @@ -1512,7 +1597,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  						stats.nr_thp_split += is_thp;
>>  						break;
>>  					}
>> -				/* Hugetlb migration is unsupported */
>>  				} else if (!no_split_folio_counting) {
>>  					nr_failed++;
>>  				}

Best Regards,
Huang, Ying
