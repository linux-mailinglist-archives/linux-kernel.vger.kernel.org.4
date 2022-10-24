Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F566097E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJXBjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJXBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:39:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C42BD4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:39:28 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mwd2y40B0zJn9C;
        Mon, 24 Oct 2022 09:36:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:39:21 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:39:20 +0800
Message-ID: <e803ec8e-a20a-949c-88b0-aee250f98208@huawei.com>
Date:   Mon, 24 Oct 2022 09:39:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] mm: memory-failure: make action_result() return int
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
 <20221021084611.53765-3-wangkefeng.wang@huawei.com>
 <20221023235633.GC4024629@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221023235633.GC4024629@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/24 7:56, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Oct 21, 2022 at 04:46:11PM +0800, Kefeng Wang wrote:
>> Check mf_result in action_result(), only return 0 when MF_RECOVERED,
>> or return -EBUSY, which will simplify code a bit.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Thanks for the cleanup, Kefeng.
> I basically agree with the change. I have one comment below ...
>
>> ---
>>   mm/memory-failure.c | 42 ++++++++++++++++--------------------------
>>   1 file changed, 16 insertions(+), 26 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ca0199d0f79d..3f469e2da047 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1182,14 +1182,16 @@ static struct page_state error_states[] = {
>>    * "Dirty/Clean" indication is not 100% accurate due to the possibility of
>>    * setting PG_dirty outside page lock. See also comment above set_page_dirty().
>>    */
>> -static void action_result(unsigned long pfn, enum mf_action_page_type type,
>> -			  enum mf_result result)
>> +static int action_result(unsigned long pfn, enum mf_action_page_type type,
>> +			 enum mf_result result)
>>   {
>>   	trace_memory_failure_event(pfn, type, result);
>>   
>>   	num_poisoned_pages_inc();
>>   	pr_err("%#lx: recovery action for %s: %s\n",
>>   		pfn, action_page_types[type], action_name[result]);
>> +
>> +	return result == MF_RECOVERED ? 0 : -EBUSY;
> I think that MF_DELAYED may be considered as success (returning 0), then
> page_action() can be cleaned up a little more (like below?)
Yes, MF_DELAYED should be considered as success,
>
>      static int page_action(struct page_state *ps, struct page *p,
>                              unsigned long pfn)
>      {
>              int result;
>      
>              /* page p should be unlocked after returning from ps->action().  */
>              result = ps->action(ps, p);
>      
>              /* Could do more checks here if page looks ok */
>              /*
>               * Could adjust zone counters here to correct for the missing page.
>               */
>      
>              return action_result(pfn, ps->type, result);
>      }
>
> Existing direct callers (I mean action_result() called from other than
> page_action()) are never called with result==MF_DELAYED, so this change
> should not affect them.
I will refresh this patch, thanks.
> Does it make sense for you?
>
> Thanks,
> Naoya Horiguchi
