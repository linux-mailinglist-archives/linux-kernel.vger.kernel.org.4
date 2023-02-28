Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D736A53DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjB1HrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjB1HrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:47:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2899520575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677570421; x=1709106421;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=pnM4Y4PlizLN+YOeRyMrwr9FPZL5461uyfKJ0ALZ82s=;
  b=LAKMrxILGSQa0O07m87hBkw1TWadqrdeH20B9/+m+jpkdW1MzYVbzr7G
   XBGATnPdxa/XG8/j3MzDSxcyUblKAm5CbxGK+kQWzznEjq2qHgegnDOl7
   bC/tN0R/+cy8BLrBVM9n6wxtdiFK71Brq9og8xyO/v+O00zkG9G0M9c2Z
   nuN/ah1DlNcPnAg9oYekEGQ43N+R+bGEmnjhLMYfTniQo5Noaf4MlEmYz
   zb6SFx9PKRqf5DfZ72166v6hqW+pe71UBxl+CyT3BldR7QJIbZrZv5MfL
   e04s8RTqVcdc7CKaazenyuX21kFGkmSLWL62HqJWVqIVYiPNDXlOMbzhO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322324237"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="322324237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 23:46:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="676207925"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="676207925"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 23:46:01 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 3/3] migrate_pages: try migrate in batch asynchronously
 firstly
References: <20230224141145.96814-1-ying.huang@intel.com>
        <20230224141145.96814-4-ying.huang@intel.com>
        <bdc873-3367-9aa7-79c6-91c68fecac41@google.com>
Date:   Tue, 28 Feb 2023 15:45:04 +0800
In-Reply-To: <bdc873-3367-9aa7-79c6-91c68fecac41@google.com> (Hugh Dickins's
        message of "Mon, 27 Feb 2023 22:36:59 -0800 (PST)")
Message-ID: <87cz5ub5dr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Hugh Dickins <hughd@google.com> writes:

> On Fri, 24 Feb 2023, Huang Ying wrote:
>
>> When we have locked more than one folios, we cannot wait the lock or
>> bit (e.g., page lock, buffer head lock, writeback bit) synchronously.
>> Otherwise deadlock may be triggered.  This make it hard to batch the
>> synchronous migration directly.
>> 
>> This patch re-enables batching synchronous migration via trying to
>> migrate in batch asynchronously firstly.  And any folios that are
>> failed to be migrated asynchronously will be migrated synchronously
>> one by one.
>> 
>> Test shows that this can restore the TLB flushing batching performance
>> for synchronous migration effectively.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>
> I'm not sure whether my 48 hours on two machines counts for a
> Tested-by: Hugh Dickins <hughd@google.com>
> or not; but it certainly looks like you've fixed my deadlock.

Thank you very much for testing the series!

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
>>  mm/migrate.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 55 insertions(+), 10 deletions(-)
>
> I was initially disappointed, that this was more complicated than I had
> thought it should be; but came to understand why.  My "change the mode
> to MIGRATE_ASYNC after the first" model would have condemned most of the
> MIGRATE_SYNC batch of pages to be handled as lightly as MIGRATE_ASYNC:
> not good enough, you're right be trying harder here.
>
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 91198b487e49..c17ce5ee8d92 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	return rc;
>>  }
>>  
>> +static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
>> +		free_page_t put_new_page, unsigned long private,
>> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
>> +		struct list_head *split_folios, struct migrate_pages_stats *stats)
>> +{
>> +	int rc, nr_failed = 0;
>> +	LIST_HEAD(folios);
>> +	struct migrate_pages_stats astats;
>> +
>> +	memset(&astats, 0, sizeof(astats));
>> +	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
>> +	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
>> +				 reason, &folios, split_folios, &astats,
>> +				 NR_MAX_MIGRATE_PAGES_RETRY);
>
> I wonder if that and below would better be NR_MAX_MIGRATE_PAGES_RETRY / 2.
>
> Though I've never got down to adjusting that number (and it's not a job
> to be done in this set of patches), those 10 retries sometimes terrify
> me, from a latency point of view.  They can have such different weights:
> in the unmapped case, 10 retries is okay; but when a pinned page is mapped
> into 1000 processes, the thought of all that unmapping and TLB flushing
> and remapping is terrifying.
>
> Since you're retrying below, halve both numbers of retries for now?

Yes.  These are reasonable concerns.

And in the original implementation, we only wait to lock page and wait
the writeback to complete if pass > 2.  This is kind of trying to
migrate asynchronously for 3 times before the real synchronous
migration.  So, should we delete the "force" logic (in
migrate_folio_unmap()), and try to migrate asynchronously for 3 times in
batch before migrating synchronously for 7 times one by one?

>> +	stats->nr_succeeded += astats.nr_succeeded;
>> +	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
>> +	stats->nr_thp_split += astats.nr_thp_split;
>> +	if (rc < 0) {
>> +		stats->nr_failed_pages += astats.nr_failed_pages;
>> +		stats->nr_thp_failed += astats.nr_thp_failed;
>> +		list_splice_tail(&folios, ret_folios);
>> +		return rc;
>> +	}
>> +	stats->nr_thp_failed += astats.nr_thp_split;
>> +	nr_failed += astats.nr_thp_split;
>> +	/*
>> +	 * Fall back to migrate all failed folios one by one synchronously. All
>> +	 * failed folios except split THPs will be retried, so their failure
>> +	 * isn't counted
>> +	 */
>> +	list_splice_tail_init(&folios, from);
>> +	while (!list_empty(from)) {
>> +		list_move(from->next, &folios);
>> +		rc = migrate_pages_batch(&folios, get_new_page, put_new_page,
>> +					 private, mode, reason, ret_folios,
>> +					 split_folios, stats, NR_MAX_MIGRATE_PAGES_RETRY);
>
> NR_MAX_MIGRATE_PAGES_RETRY / 2 ?
>
>> +		list_splice_tail_init(&folios, ret_folios);
>> +		if (rc < 0)
>> +			return rc;
>> +		nr_failed += rc;
>> +	}
>> +
>> +	return nr_failed;
>> +}
>> +
>>  /*
>>   * migrate_pages - migrate the folios specified in a list, to the free folios
>>   *		   supplied as the target for the page migration
>> @@ -1874,7 +1919,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>>  {
>>  	int rc, rc_gather;
>> -	int nr_pages, batch;
>> +	int nr_pages;
>>  	struct folio *folio, *folio2;
>>  	LIST_HEAD(folios);
>>  	LIST_HEAD(ret_folios);
>> @@ -1890,10 +1935,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  	if (rc_gather < 0)
>>  		goto out;
>>  
>> -	if (mode == MIGRATE_ASYNC)
>> -		batch = NR_MAX_BATCHED_MIGRATION;
>> -	else
>> -		batch = 1;
>>  again:
>>  	nr_pages = 0;
>>  	list_for_each_entry_safe(folio, folio2, from, lru) {
>> @@ -1904,16 +1945,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  		}
>>  
>>  		nr_pages += folio_nr_pages(folio);
>> -		if (nr_pages >= batch)
>> +		if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>>  			break;
>>  	}
>> -	if (nr_pages >= batch)
>> +	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>>  		list_cut_before(&folios, from, &folio2->lru);
>>  	else
>>  		list_splice_init(from, &folios);
>> -	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
>> -				 mode, reason, &ret_folios, &split_folios, &stats,
>> -				 NR_MAX_MIGRATE_PAGES_RETRY);
>> +	if (mode == MIGRATE_ASYNC)
>> +		rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
>> +					 mode, reason, &ret_folios, &split_folios, &stats,
>> +					 NR_MAX_MIGRATE_PAGES_RETRY);
>> +	else
>> +		rc = migrate_pages_sync(&folios, get_new_page, put_new_page, private,
>> +					mode, reason, &ret_folios, &split_folios, &stats);
>>  	list_splice_tail_init(&folios, &ret_folios);
>>  	if (rc < 0) {
>>  		rc_gather = rc;
>> -- 
>> 2.39.1

Best Regards,
Huang, Ying
