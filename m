Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A43609BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJXIBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJXIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:01:41 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E22058073
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:01:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VSulATT_1666598491;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSulATT_1666598491)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 16:01:32 +0800
Message-ID: <f2cc7bb4-f296-766e-16b5-0d70498669eb@linux.alibaba.com>
Date:   Mon, 24 Oct 2022 16:01:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        ziy@nvidia.com, shy828301@gmail.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
 <87pmeiq6qc.fsf@nvidia.com>
 <4fcb9065-0d0c-7bd3-d4f9-5830792cce60@linux.alibaba.com>
 <87lep5r7t9.fsf@nvidia.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87lep5r7t9.fsf@nvidia.com>
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



On 10/24/2022 3:24 PM, Alistair Popple wrote:
> 
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 10/24/2022 10:36 AM, Alistair Popple wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> When THP migration, if THPs are split and all subpages are migrated successfully
>>>> , the migrate_pages() will still return the number of THP that were not migrated.
>>>> That will confuse the callers of migrate_pages(), for example, which will make
>>>> the longterm pinning failed though all pages are migrated successfully.
>>>>
>>>> Thus we should return 0 to indicate all pages are migrated in this case.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>> Changes from v1:
>>>> - Fix the return value of migrate_pages() instead of fixing the
>>>>     callers' validation.
>>>> ---
>>>>    mm/migrate.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 8e5eb6e..1da0dbc 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1582,6 +1582,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    	 */
>>>>    	list_splice(&ret_pages, from);
>>>>
>>>> +	/*
>>>> +	 * Return 0 in case all subpages of fail-to-migrate THPs are
>>>> +	 * migrated successfully.
>>>> +	 */
>>>> +	if (nr_thp_split && list_empty(from))
>>>> +		rc = 0;
>>> Why do you need to check nr_thp_split? Wouldn't list_empty(from) == True
>>
>> Only in the case of THP split, we can meet this abnormal case. So if no THP
>> split, just return the original 'rc' instead of validating the list, since the
>> 'nr_thp_split' validation is cheaper than the list_empty() validation IMHO.
> 
> Is it really that much cheaper? We're already retrying migrations
> multiple times, etc. so surely the difference here would be marginal at
> best, and IMHO the code would be much clearer if we always set rc = 0
> when list_empty(from) = True.

Yeah, the difference is marginal and I have no strong preference. OK, 
will drop the 'nr_thp_split' in next version. Thanks.

>>> imply success? And if it doesn't imply success wouldn't it be possible
>>> to end up with nr_thp_split && list_empty(from) whilst still having
>>> pages that failed to migrate?
>>> The list management and return code logic from unmap_and_move() has
>>> gotten pretty difficult to follow and could do with some rework IMHO.
>>
>> Yes, Huang Ying has sent a RFC patchset[1] doing some code refactor, which seems
>> a good start.
> 
> Thanks for pointing that out, I looked at it a while back but missed the
> clean ups. I was kind of waiting for the non-RFC version before taking
> another closer look.
> 
>> [1] https://lore.kernel.org/all/20220921060616.73086-1-ying.huang@intel.com/
