Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED06A67AA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCAGgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAGgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:36:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A826CD1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677652612; x=1709188612;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Tqy9ig0ZuyGUVp5wW1wDnwmPDyoBIKAs7BKfzerQq9c=;
  b=BshhGNhtGxgXJbFCGPRU4IUzBLjzE/+aU1XT++jUuA+GTTmMM/m3TfZB
   I0ZQod/RuH9iRvIjkca7FJCgreapbdV07FU46v8LeiNb6ZbsUnI3tTJmI
   SMJY1C3JLlBJrWcGrU4W9vcyn7eHFMaoUHa1rcAn3dr65gmerOeOyzSYK
   EPZ+ZdKkcppLKrIdcGtk5rBaUYt2nTSOp/NqfyDRWAwFJWMll4ncgytkz
   TWXUqHdimShBlx1VXS3a5NhypAmUAn79OVQPDr3quXu1U0KJPzIV03Y0x
   t6PJqf90NXHCAAZD2SbLMnkp1BdytPI9deCGkB721cEkrWMdF72Cv6+eo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="334371710"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="334371710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 22:36:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="848531971"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="848531971"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 22:36:47 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 2/3] migrate_pages: move split folios processing out of
 migrate_pages_batch()
References: <20230224141145.96814-1-ying.huang@intel.com>
        <20230224141145.96814-3-ying.huang@intel.com>
        <e820f68a-d1c7-c552-b924-56d97fb0b927@linux.alibaba.com>
Date:   Wed, 01 Mar 2023 14:35:50 +0800
In-Reply-To: <e820f68a-d1c7-c552-b924-56d97fb0b927@linux.alibaba.com> (Baolin
        Wang's message of "Wed, 1 Mar 2023 10:23:43 +0800")
Message-ID: <87v8jl9dx5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2/24/2023 10:11 PM, Huang Ying wrote:
>> To simplify the code logic and reduce the line number.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: "Xu, Pengfei" <pengfei.xu@intel.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Stefan Roesch <shr@devkernel.io>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Xin Hao <xhao@linux.alibaba.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/migrate.c | 76 ++++++++++++++++++----------------------------------
>>   1 file changed, 26 insertions(+), 50 deletions(-)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 7ac37dbbf307..91198b487e49 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1605,9 +1605,10 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
>>   static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   		free_page_t put_new_page, unsigned long private,
>>   		enum migrate_mode mode, int reason, struct list_head *ret_folios,
>> -		struct migrate_pages_stats *stats)
>> +		struct list_head *split_folios, struct migrate_pages_stats *stats,
>> +		int nr_pass)
>>   {
>> -	int retry;
>> +	int retry = 1;
>>   	int large_retry = 1;
>>   	int thp_retry = 1;
>>   	int nr_failed = 0;
>> @@ -1617,19 +1618,12 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   	bool is_large = false;
>>   	bool is_thp = false;
>>   	struct folio *folio, *folio2, *dst = NULL, *dst2;
>> -	int rc, rc_saved, nr_pages;
>> -	LIST_HEAD(split_folios);
>> +	int rc, rc_saved = 0, nr_pages;
>>   	LIST_HEAD(unmap_folios);
>>   	LIST_HEAD(dst_folios);
>>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
>> -	bool no_split_folio_counting = false;
>>   -retry:
>> -	rc_saved = 0;
>> -	retry = 1;
>> -	for (pass = 0;
>> -	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
>> -	     pass++) {
>> +	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
>>   		retry = 0;
>>   		large_retry = 0;
>>   		thp_retry = 0;
>> @@ -1660,7 +1654,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   			if (!thp_migration_supported() && is_thp) {
>>   				nr_large_failed++;
>>   				stats->nr_thp_failed++;
>> -				if (!try_split_folio(folio, &split_folios)) {
>> +				if (!try_split_folio(folio, split_folios)) {
>>   					stats->nr_thp_split++;
>>   					continue;
>>   				}
>> @@ -1692,7 +1686,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   					stats->nr_thp_failed += is_thp;
>>   					/* Large folio NUMA faulting doesn't split to retry. */
>>   					if (!nosplit) {
>> -						int ret = try_split_folio(folio, &split_folios);
>> +						int ret = try_split_folio(folio, split_folios);
>>     						if (!ret) {
>>   							stats->nr_thp_split += is_thp;
>> @@ -1709,18 +1703,11 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   							break;
>>   						}
>>   					}
>> -				} else if (!no_split_folio_counting) {
>> +				} else {
>>   					nr_failed++;
>>   				}
>>     				stats->nr_failed_pages += nr_pages +
>> nr_retry_pages;
>> -				/*
>> -				 * There might be some split folios of fail-to-migrate large
>> -				 * folios left in split_folios list. Move them to ret_folios
>> -				 * list so that they could be put back to the right list by
>> -				 * the caller otherwise the folio refcnt will be leaked.
>> -				 */
>> -				list_splice_init(&split_folios, ret_folios);
>>   				/* nr_failed isn't updated for not used */
>>   				nr_large_failed += large_retry;
>>   				stats->nr_thp_failed += thp_retry;
>> @@ -1733,7 +1720,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   				if (is_large) {
>>   					large_retry++;
>>   					thp_retry += is_thp;
>> -				} else if (!no_split_folio_counting) {
>> +				} else {
>>   					retry++;
>>   				}
>>   				nr_retry_pages += nr_pages;
>> @@ -1756,7 +1743,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   				if (is_large) {
>>   					nr_large_failed++;
>>   					stats->nr_thp_failed += is_thp;
>> -				} else if (!no_split_folio_counting) {
>> +				} else {
>>   					nr_failed++;
>>   				}
>>   @@ -1774,9 +1761,7 @@ static int migrate_pages_batch(struct
>> list_head *from, new_page_t get_new_page,
>>   	try_to_unmap_flush();
>>     	retry = 1;
>> -	for (pass = 0;
>> -	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
>> -	     pass++) {
>> +	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
>>   		retry = 0;
>>   		large_retry = 0;
>>   		thp_retry = 0;
>> @@ -1805,7 +1790,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   				if (is_large) {
>>   					large_retry++;
>>   					thp_retry += is_thp;
>> -				} else if (!no_split_folio_counting) {
>> +				} else {
>>   					retry++;
>>   				}
>>   				nr_retry_pages += nr_pages;
>> @@ -1818,7 +1803,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>   				if (is_large) {
>>   					nr_large_failed++;
>>   					stats->nr_thp_failed += is_thp;
>> -				} else if (!no_split_folio_counting) {
>> +				} else {
>>   					nr_failed++;
>>   				}
>>   @@ -1855,27 +1840,6 @@ static int migrate_pages_batch(struct
>> list_head *from, new_page_t get_new_page,
>>   		dst2 = list_next_entry(dst, lru);
>>   	}
>>   -	/*
>> -	 * Try to migrate split folios of fail-to-migrate large folios, no
>> -	 * nr_failed counting in this round, since all split folios of a
>> -	 * large folio is counted as 1 failure in the first round.
>> -	 */
>> -	if (rc >= 0 && !list_empty(&split_folios)) {
>> -		/*
>> -		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
>> -		 * retries) to ret_folios to avoid migrating them again.
>> -		 */
>> -		list_splice_init(from, ret_folios);
>> -		list_splice_init(&split_folios, from);
>> -		/*
>> -		 * Force async mode to avoid to wait lock or bit when we have
>> -		 * locked more than one folios.
>> -		 */
>> -		mode = MIGRATE_ASYNC;
>> -		no_split_folio_counting = true;
>> -		goto retry;
>> -	}
>> -
>>   	return rc;
>>   }
>>   @@ -1914,6 +1878,7 @@ int migrate_pages(struct list_head *from,
>> new_page_t get_new_page,
>>   	struct folio *folio, *folio2;
>>   	LIST_HEAD(folios);
>>   	LIST_HEAD(ret_folios);
>> +	LIST_HEAD(split_folios);
>>   	struct migrate_pages_stats stats;
>>     	trace_mm_migrate_pages_start(mode, reason);
>> @@ -1947,12 +1912,23 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	else
>>   		list_splice_init(from, &folios);
>>   	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
>> -				 mode, reason, &ret_folios, &stats);
>> +				 mode, reason, &ret_folios, &split_folios, &stats,
>> +				 NR_MAX_MIGRATE_PAGES_RETRY);
>>   	list_splice_tail_init(&folios, &ret_folios);
>>   	if (rc < 0) {
>>   		rc_gather = rc;
>> +		list_splice_tail(&split_folios, &ret_folios);
>
> Can we still keep the original comments? Which can help to understand
> the case, at least for me:)
>  /*
>   * There might be some split folios of fail-to-migrate large
>   * folios left in split_folios list. Move them to ret_folios
>   * list so that they could be put back to the right list by
>   * the caller otherwise the folio refcnt will be leaked.
>   */

Previously, the cleanup code is buried in a corner of a much more
complex code path.  So the comments are necessary.  Now, it is an
explicit and simple code path.  And, the rule is clear, every folio list
needs to be cleaned up before return: folios, split_folios, then
ret_folios.  And we have done this here and there in the series.

>>   		goto out;
>>   	}
>> +	if (!list_empty(&split_folios)) {
>> +		/*
>> +		 * Failure isn't counted since all split folios of a large folio
>> +		 * is counted as 1 failure already.
>> +		 */
>> +		migrate_pages_batch(&split_folios, get_new_page, put_new_page, private,
>> +				    MIGRATE_ASYNC, reason, &ret_folios, NULL, &stats, 1);
>
> Better to copy the original comments to explain why force to
> MIGRATE_ASYNC mode for split folios.

Yes.  It's a good idea to explain that.  And now the rule to call
migrate_pages_batch() has been changed.  If mode != MIGRATE_ASYNC, the
length of "from" must be <= 1.  I will add a VM_WARN_ON() for that at
the beginning of migrate_pages_batch().  And I would rather to add the
comments to the header of migrate_pages().  Other callers of the
function needs to follow that rule too.

> Thanks for the simplification, and please feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thank you very much for review!

Best Regards,
Huang, Ying
