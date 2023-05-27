Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34AB7131D5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjE0CCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjE0CCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:02:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD9FB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:02:40 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QSlLQ1mj8z18LhY;
        Sat, 27 May 2023 09:58:06 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 10:02:38 +0800
Message-ID: <81956ca8-8228-1210-c855-e652e2f263dc@huawei.com>
Date:   Sat, 27 May 2023 10:02:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [syzbot] [damon?] divide error in damon_set_attrs
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
CC:     syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <syzkaller-bugs@googlegroups.com>
References: <20230527014635.7380-1-sj@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230527014635.7380-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/27 9:46, SeongJae Park wrote:
> Hi Kefeng,
> 
> On Sat, 27 May 2023 09:15:01 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> [...]
>>>
>>> Nice and effective fix!  Nevertheless, I think aggregation interval smaller
>>> than sample interval is just a wrong input.  How about adding the check in
>>> damon_set_attrs()'s already existing attributes validation, like below?
>>
>> Yes, move the check into damon_set_attrs() is better
> 
> Thank you for this kind comment!
> 
>> , and it seems that
>> we could move all the check into it, and drop the old_attrs check in
>> damon_update_monitoring_results(), what's you option?
>>
>>
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index d9ef62047bf5..1647f7f1f708 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -523,12 +523,6 @@ static void damon_update_monitoring_results(struct
>> damon_ctx *ctx,
>>           struct damon_target *t;
>>           struct damon_region *r;
>>
>> -       /* if any interval is zero, simply forgive conversion */
>> -       if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
>> -                       !new_attrs->sample_interval ||
>> -                       !new_attrs->aggr_interval)
>> -               return;
>> -
>>           damon_for_each_target(t, ctx)
>>                   damon_for_each_region(r, t)
>>                           damon_update_monitoring_result(
>> @@ -551,6 +545,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct
>> damon_attrs *attrs)
>>                   return -EINVAL;
>>           if (attrs->min_nr_regions > attrs->max_nr_regions)
>>                   return -EINVAL;
>> +       if (attrs->sample_interval > attrs->aggr_interval)
>> +               return -EINVAL;
>> +       if (!attrs->sample_interval || !attrs->aggr_interval)
>> +               return -EINVAL;
> 
> In my humble opinion, the validation for monitoring results and for general
> monitoring could be different.  For example, zero aggreation/sampling intervals
> might make sense for fixed granularity working set size monitoring.  Hence, I'd
> prefer keeping those checks in the damon_update_monitoring_results().


ok, will keep that, I check the damon_set_attrs() called by 
lru_sort/reclaim monitor and sysfs/dbgfs, the above changes should be 
ok, maybe missing something, the working set size monitoring is not 
public for now?

> 
> 
> Thanks,
> SJ
> 
> [...]
