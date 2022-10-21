Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F99606C78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJUA3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJUA33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:29:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8126E3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666312164; x=1697848164;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=v2dE9M9t9yvuMjl71gpN7mNk/imF/OKQN0QqVm+fcfU=;
  b=CpSALBkhEaaKNz8ysEYEk5gqgWt9SEUo3QMoXOlRiijdYPer3ZfWUm/Z
   9UAJeDRCaU6IWosbV65taqw53KlLDAheGMNy6jPd+nLHaYmygVU2BgpAV
   xIt5C5I/BhRYUBsy62VQNlQcnleBKKlYNs4ilj1VF3U7aiu8jkeJw2/0B
   FBvTuzCW/9SNmnmLs7OUyJb+/pjO+rdbO3ToHNKkohQ1LpLdOEk4JXw7n
   xBs19rMskNSdGfGzH8BIq0DLKhrjX4PVhTtOuVvAQ1DNZolH8goXXtqW6
   TsupY5cCwINJzHVnJexK4tHSXUWolJZQ2WN4SZ472GPM95dezMQt5CLeR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305610428"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305610428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:29:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693349171"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="693349171"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:29:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
        <shy828301@gmail.com>, <jingshan@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: gup: Re-pin pages in case of trying several
 times to migrate
References: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
        <87r0z2nc6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b2b44837-045a-a5ac-319e-216f6b2491bb@linux.alibaba.com>
        <87o7u6soip.fsf@nvidia.com>
Date:   Fri, 21 Oct 2022 08:28:43 +0800
In-Reply-To: <87o7u6soip.fsf@nvidia.com> (Alistair Popple's message of "Thu,
        20 Oct 2022 22:43:39 +1100")
Message-ID: <87edv2m344.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>
>> On 10/20/2022 4:15 PM, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> The migrate_pages() will return the number of {normal page, THP, hugetlb}
>>>> that were not migrated, or an error code. That means it can still return
>>>> the number of failure count, though the pages have been migrated
>>>> successfully with several times re-try.
>>> If my understanding were correct, if pages are migrated successfully
>>> after several times re-tries, the return value will be 0.  There's one
>>> possibility for migrate_pages() to return non-zero but all pages are
>>> migrated.  That is, when THP is split and all subpages are migrated
>>> successfully.
>>
>> Yeah, that's the case I tested. Thanks for pointing out. I'll re-write my
>> incorrect commit message next time.
>
> This is confusing to me. So users of move_page() will see an
> unsuccessful migration even when all subpages were migrated? Seems like
> we should fix the return code of migrate_pages() for this case where all
> subpages were successfully migrated.
>
>>>
>>>> So we should not use the return value of migrate_pages() to determin
>>>> if there are pages are failed to migrate. Instead we can validate the
>>>> 'movable_page_list' to see if there are pages remained in the list,
>>>> which are failed to migrate. That can mitigate the failure of longterm
>>>> pinning.
>>> Another choice is to use a special return value for split THP + success
>>> migration.  But I'm fine to use list_empty(return_pages).
>>
>> OK. Using list_empty(return_pages) looks more simple.
>>
>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>   mm/gup.c | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index 5182aba..bd8cfcd 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -1914,9 +1914,10 @@ static int migrate_longterm_unpinnable_pages(
>>>>   			.gfp_mask = GFP_USER | __GFP_NOWARN,
>>>>   		};
>>>>   -		if (migrate_pages(movable_page_list, alloc_migration_target,
>>>> -				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
>>>> -				  MR_LONGTERM_PIN, NULL)) {
>>>> +		ret = migrate_pages(movable_page_list, alloc_migration_target,
>>>> +				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
>>>> +				    MR_LONGTERM_PIN, NULL);
>>>> +		if (ret < 0 || !list_empty(movable_page_list)) {
>>> It seems that !list_empty() is sufficient here.
>>
>> OK. Drop the 'ret < 0'
>>
>>>>   			ret = -ENOMEM;
>>> Why change the error code?  I don't think it's a good idea to do that.
>>
>> The GUP need a -errno for failure or partial success when migration, and we can
>> not return the number of pages failed to migrate. So returning -ENOMEM seems
>> suitable for both cases?
>
> Seem reasonable to me. migrate_pages() might return -EAGAIN which would
> cause everything to be re-pinned and tried again which is not what you
> want here. See the comment at the start of
> check_and_migrate_movable_pages().

Yes.  You are right.  The error code of migrate_pages() isn't good for
caller here.

Best Regards,
Huang, Ying
