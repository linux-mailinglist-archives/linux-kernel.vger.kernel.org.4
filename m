Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D765E5B48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIVGXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiIVGW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:22:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D73A032D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663827777; x=1695363777;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=B2IMj1wxNxIezrIrTzyNldqwKTyK+xDNyJjvLLABEzE=;
  b=gNCpgVH73vDOTm8NvH1lEcnikECZsrTRnoM71n6j3Iklhc1FRheP97lL
   BdgSoasAlJ8VS/gSTU/Bk+4kCxffRWo4S6UhmwmcnJtqT1XKcq1Ovo8yE
   OJyayqF5L9qDc6PGrKYYz9qcS2XvrKsW55Cp0yjihEmVRNeDCb0E/gN0o
   zwq5pohb+o4kHbMBytKOdAxGIOUVFQs1z1ba6e/hUhjHm1WvjlyMlP0ck
   ZZig8Vlcp/uU1PxnphtqgW5Ti/96j9lma7WajM7gFasJzBoJvKt4IxFg5
   HVRJc9eg6ss1VggNTp19ic4vvMgTc1U3EChpkPkKAccm/YPl/F9vWCY8x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279933343"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="279933343"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 23:22:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="948467107"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 23:22:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 1/6] mm/migrate_pages: separate huge page and normal pages
 migration
References: <20220921060616.73086-1-ying.huang@intel.com>
        <20220921060616.73086-2-ying.huang@intel.com>
        <0a41c051-7d7e-cb1b-8273-192252e74b94@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 14:22:49 +0800
In-Reply-To: <0a41c051-7d7e-cb1b-8273-192252e74b94@linux.alibaba.com> (Baolin
        Wang's message of "Thu, 22 Sep 2022 14:03:55 +0800")
Message-ID: <87pmfoj5c6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 9/21/2022 2:06 PM, Huang Ying wrote:
>> This is a preparation patch to batch the page unmapping and moving for
>> the normal pages and THPs.  Based on that we can batch the TLB
>> shootdown during the page migration and make it possible to use some
>> hardware accelerator for the page copying.
>> In this patch the huge page (PageHuge()) and normal page and THP
>> migration is separated in migrate_pages() to make it easy to change
>> the normal page and THP migration implementation.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> ---
>>   mm/migrate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 64 insertions(+), 9 deletions(-)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 571d8c9fd5bc..117134f1c6dc 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1414,6 +1414,66 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>     	trace_mm_migrate_pages_start(mode, reason);
>>   +	for (pass = 0; pass < 10 && retry; pass++) {
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
>
> Seems we should also record the nr_retry_pages? since the second loop
> will reset the nr_retry_pages.
>
> nr_failed_pages += nr_retry_pages;

Good catch!  Will do that in the next version.

> Besides, I also agree with Zi Yan's comment to simplify this larger
> function.

Yes.  I think so too.

Best Regards,
Huang, Ying
