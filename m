Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD670214B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjEOBzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEOBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:55:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9F170E
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684115747; x=1715651747;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=v1CZsr9uUVuMpoTTd7cKj2dNWhpse1KMOCdKLzbB9ww=;
  b=C0yF69s6P/SdlMkQTpmEgdSkL5zWdDayYCjEPBKdkX/xY1bsThtY16jA
   RKXt1MUh3ov6AiHmkjs7k4WGoGl1FUQ+1mYIE1RY03wBhh6OJObnCtAyK
   87LnnGKSr1oMvWhn51f1EPfJJKovu1clgq2b59h/AEfzPpT0+8OWRCHi2
   pJ1O/GQPiR0QREKkBoXbBHsBgF65GakQaLFwrL/4KAcXpMAeAFRgPM7ax
   DL/n7ozqbZax/D5cX8ZNlu1rFsmf1pY+sGHT/HttT/fM2Uk83UCTzYD1H
   j525b2CfabnSFpLs/B8uWU0IxccP7b/CqiNKYaZsARGUsFRgJgP3ZENxD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="379245141"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="379245141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 18:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="733688885"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="733688885"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 18:55:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH -V2] migrate_pages_batch: simplify retrying and failure
 counting of large folios
References: <20230510031829.11513-1-ying.huang@intel.com>
        <871qjoblqg.fsf@nvidia.com>
Date:   Mon, 15 May 2023 09:54:34 +0800
In-Reply-To: <871qjoblqg.fsf@nvidia.com> (Alistair Popple's message of "Wed,
        10 May 2023 19:04:13 +1000")
Message-ID: <87ilcu8ilh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alistair,

Alistair Popple <apopple@nvidia.com> writes:

> Looks good. Please add my reviewed by from v1 as well:
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Sorry, I just found your email in my junk email folder.  It appears that
there are some bugs in my email system.  I will be more careful in the
future and try to find a way to fix my email system.

Thanks Andrew to help add your reviewed-by in his merged version.

Best Regards,
Huang, Ying

> Huang Ying <ying.huang@intel.com> writes:
>
>> After recent changes to the retrying and failure counting in
>> migrate_pages_batch(), it was found that it's unnecessary to count
>> retrying and failure for normal, large, and THP folios separately.
>> Because we don't use retrying and failure number of large folios
>> directly.  So, in this patch, we simplified retrying and failure
>> counting of large folios via counting retrying and failure of normal
>> and large folios together.  This results in the reduced line number.
>>
>> Previously, in migrate_pages_batch we need to track whether the source
>> folio is large/THP before splitting.  So is_large is used to cache
>> folio_test_large() result.  Now, we don't need that variable any more
>> because we don't count retrying and failure of large folios (only
>> counting that of THP folios).  So, in this patch, is_large is removed
>> to simplify the code.
>>
>> This is just code cleanup, no functionality changes are expected.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> ---
>>  mm/migrate.c | 110 ++++++++++++++++-----------------------------------
>>  1 file changed, 35 insertions(+), 75 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 01cac26a3127..2ac927a82bbc 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1614,13 +1614,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  		int nr_pass)
>>  {
>>  	int retry = 1;
>> -	int large_retry = 1;
>>  	int thp_retry = 1;
>>  	int nr_failed = 0;
>>  	int nr_retry_pages = 0;
>> -	int nr_large_failed = 0;
>>  	int pass = 0;
>> -	bool is_large = false;
>>  	bool is_thp = false;
>>  	struct folio *folio, *folio2, *dst = NULL, *dst2;
>>  	int rc, rc_saved = 0, nr_pages;
>> @@ -1631,20 +1628,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
>>  			!list_empty(from) && !list_is_singular(from));
>>  
>> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
>> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>>  		retry = 0;
>> -		large_retry = 0;
>>  		thp_retry = 0;
>>  		nr_retry_pages = 0;
>>  
>>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>> -			/*
>> -			 * Large folio statistics is based on the source large
>> -			 * folio. Capture required information that might get
>> -			 * lost during migration.
>> -			 */
>> -			is_large = folio_test_large(folio);
>> -			is_thp = is_large && folio_test_pmd_mappable(folio);
>> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>>  			nr_pages = folio_nr_pages(folio);
>>  
>>  			cond_resched();
>> @@ -1660,7 +1650,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  			 * list is processed.
>>  			 */
>>  			if (!thp_migration_supported() && is_thp) {
>> -				nr_large_failed++;
>> +				nr_failed++;
>>  				stats->nr_thp_failed++;
>>  				if (!try_split_folio(folio, split_folios)) {
>>  					stats->nr_thp_split++;
>> @@ -1688,38 +1678,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  				 * When memory is low, don't bother to try to migrate
>>  				 * other folios, move unmapped folios, then exit.
>>  				 */
>> -				if (is_large) {
>> -					nr_large_failed++;
>> -					stats->nr_thp_failed += is_thp;
>> -					/* Large folio NUMA faulting doesn't split to retry. */
>> -					if (!nosplit) {
>> -						int ret = try_split_folio(folio, split_folios);
>> +				nr_failed++;
>> +				stats->nr_thp_failed += is_thp;
>> +				/* Large folio NUMA faulting doesn't split to retry. */
>> +				if (folio_test_large(folio) && !nosplit) {
>> +					int ret = try_split_folio(folio, split_folios);
>>  
>> -						if (!ret) {
>> -							stats->nr_thp_split += is_thp;
>> -							break;
>> -						} else if (reason == MR_LONGTERM_PIN &&
>> -							   ret == -EAGAIN) {
>> -							/*
>> -							 * Try again to split large folio to
>> -							 * mitigate the failure of longterm pinning.
>> -							 */
>> -							large_retry++;
>> -							thp_retry += is_thp;
>> -							nr_retry_pages += nr_pages;
>> -							/* Undo duplicated failure counting. */
>> -							nr_large_failed--;
>> -							stats->nr_thp_failed -= is_thp;
>> -							break;
>> -						}
>> +					if (!ret) {
>> +						stats->nr_thp_split += is_thp;
>> +						break;
>> +					} else if (reason == MR_LONGTERM_PIN &&
>> +						   ret == -EAGAIN) {
>> +						/*
>> +						 * Try again to split large folio to
>> +						 * mitigate the failure of longterm pinning.
>> +						 */
>> +						retry++;
>> +						thp_retry += is_thp;
>> +						nr_retry_pages += nr_pages;
>> +						/* Undo duplicated failure counting. */
>> +						nr_failed--;
>> +						stats->nr_thp_failed -= is_thp;
>> +						break;
>>  					}
>> -				} else {
>> -					nr_failed++;
>>  				}
>>  
>>  				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>>  				/* nr_failed isn't updated for not used */
>> -				nr_large_failed += large_retry;
>>  				stats->nr_thp_failed += thp_retry;
>>  				rc_saved = rc;
>>  				if (list_empty(&unmap_folios))
>> @@ -1727,12 +1712,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  				else
>>  					goto move;
>>  			case -EAGAIN:
>> -				if (is_large) {
>> -					large_retry++;
>> -					thp_retry += is_thp;
>> -				} else {
>> -					retry++;
>> -				}
>> +				retry++;
>> +				thp_retry += is_thp;
>>  				nr_retry_pages += nr_pages;
>>  				break;
>>  			case MIGRATEPAGE_SUCCESS:
>> @@ -1750,20 +1731,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  				 * removed from migration folio list and not
>>  				 * retried in the next outer loop.
>>  				 */
>> -				if (is_large) {
>> -					nr_large_failed++;
>> -					stats->nr_thp_failed += is_thp;
>> -				} else {
>> -					nr_failed++;
>> -				}
>> -
>> +				nr_failed++;
>> +				stats->nr_thp_failed += is_thp;
>>  				stats->nr_failed_pages += nr_pages;
>>  				break;
>>  			}
>>  		}
>>  	}
>>  	nr_failed += retry;
>> -	nr_large_failed += large_retry;
>>  	stats->nr_thp_failed += thp_retry;
>>  	stats->nr_failed_pages += nr_retry_pages;
>>  move:
>> @@ -1771,17 +1746,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	try_to_unmap_flush();
>>  
>>  	retry = 1;
>> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
>> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>>  		retry = 0;
>> -		large_retry = 0;
>>  		thp_retry = 0;
>>  		nr_retry_pages = 0;
>>  
>>  		dst = list_first_entry(&dst_folios, struct folio, lru);
>>  		dst2 = list_next_entry(dst, lru);
>>  		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>> -			is_large = folio_test_large(folio);
>> -			is_thp = is_large && folio_test_pmd_mappable(folio);
>> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>>  			nr_pages = folio_nr_pages(folio);
>>  
>>  			cond_resched();
>> @@ -1797,12 +1770,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  			 */
>>  			switch(rc) {
>>  			case -EAGAIN:
>> -				if (is_large) {
>> -					large_retry++;
>> -					thp_retry += is_thp;
>> -				} else {
>> -					retry++;
>> -				}
>> +				retry++;
>> +				thp_retry += is_thp;
>>  				nr_retry_pages += nr_pages;
>>  				break;
>>  			case MIGRATEPAGE_SUCCESS:
>> @@ -1810,13 +1779,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  				stats->nr_thp_succeeded += is_thp;
>>  				break;
>>  			default:
>> -				if (is_large) {
>> -					nr_large_failed++;
>> -					stats->nr_thp_failed += is_thp;
>> -				} else {
>> -					nr_failed++;
>> -				}
>> -
>> +				nr_failed++;
>> +				stats->nr_thp_failed += is_thp;
>>  				stats->nr_failed_pages += nr_pages;
>>  				break;
>>  			}
>> @@ -1825,14 +1789,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  		}
>>  	}
>>  	nr_failed += retry;
>> -	nr_large_failed += large_retry;
>>  	stats->nr_thp_failed += thp_retry;
>>  	stats->nr_failed_pages += nr_retry_pages;
>>  
>> -	if (rc_saved)
>> -		rc = rc_saved;
>> -	else
>> -		rc = nr_failed + nr_large_failed;
>> +	rc = rc_saved ? : nr_failed;
>>  out:
>>  	/* Cleanup remaining folios */
>>  	dst = list_first_entry(&dst_folios, struct folio, lru);
