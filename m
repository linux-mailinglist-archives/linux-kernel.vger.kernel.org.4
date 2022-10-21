Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF78E606E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJUCwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:52:08 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D81956CB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:52:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VShO9Hv_1666320722;
Received: from 30.97.48.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VShO9Hv_1666320722)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 10:52:04 +0800
Message-ID: <0855246a-8425-2aca-1d67-305d6866ed17@linux.alibaba.com>
Date:   Fri, 21 Oct 2022 10:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] mm: gup: Re-pin pages in case of trying several times
 to migrate
To:     Alistair Popple <apopple@nvidia.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, shy828301@gmail.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
 <87r0z2nc6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b2b44837-045a-a5ac-319e-216f6b2491bb@linux.alibaba.com>
 <87o7u6soip.fsf@nvidia.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87o7u6soip.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2022 7:43 PM, Alistair Popple wrote:
> 
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

Yes.

> we should fix the return code of migrate_pages() for this case where all
> subpages were successfully migrated.

After more investigation, some other callers will also check the return 
value to see of all pages are migrated successfully. So yes, I will 
change the return value in migrate_pages() to fix this issue for all 
callers like you and Ying suggested. Thanks.

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
>>>>    mm/gup.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index 5182aba..bd8cfcd 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -1914,9 +1914,10 @@ static int migrate_longterm_unpinnable_pages(
>>>>    			.gfp_mask = GFP_USER | __GFP_NOWARN,
>>>>    		};
>>>>    -		if (migrate_pages(movable_page_list, alloc_migration_target,
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
>>>>    			ret = -ENOMEM;
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
