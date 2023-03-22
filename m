Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527776C4434
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCVHgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCVHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:36:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3475C9C4;
        Wed, 22 Mar 2023 00:36:25 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PhKvd3Gpbz17KpN;
        Wed, 22 Mar 2023 15:33:17 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 15:36:23 +0800
Subject: Re: [PATCH RESEND v3] perf/core: Fix hardlockup failure caused by
 perf throttle
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <eranian@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230227023508.102230-1-yangjihong1@huawei.com>
 <12782722-103e-88a9-df3e-6815b4734bc3@huawei.com>
Message-ID: <37d019af-191c-9955-2417-b7cfa5e5efa3@huawei.com>
Date:   Wed, 22 Mar 2023 15:36:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <12782722-103e-88a9-df3e-6815b4734bc3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

PING.

This patch has not been responded.
Please take time to check whether the fix solution is OK.
Look forward to reviewing the patch. Thanks :)

Thanks,
Yang.

On 2023/3/6 9:14, Yang Jihong wrote:
> Hello,
> 
> PING.
> 
> Thanks,
> Yang.
> 
> On 2023/2/27 10:35, Yang Jihong wrote:
>> commit e050e3f0a71bf ("perf: Fix broken interrupt rate throttling")
>> introduces a change in throttling threshold judgment. Before this,
>> compare hwc->interrupts and max_samples_per_tick, then increase
>> hwc->interrupts by 1, but this commit reverses order of these two
>> behaviors, causing the semantics of max_samples_per_tick to change.
>> In literal sense of "max_samples_per_tick", if hwc->interrupts ==
>> max_samples_per_tick, it should not be throttled, therefore, the judgment
>> condition should be changed to "hwc->interrupts > max_samples_per_tick".
>>
>> In fact, this may cause the hardlockup to fail, The minimum value of
>> max_samples_per_tick may be 1, in this case, the return value of
>> __perf_event_account_interrupt function is 1.
>> As a result, nmi_watchdog gets throttled, which would stop PMU (Use x86
>> architecture as an example, see x86_pmu_handle_irq).
>>
>> Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>
>> Changes since v2:
>>    - Add fixed commit.
>>
>> Changes since v1:
>>    - Modify commit title.
>>
>>   kernel/events/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f79fd8b87f75..0540a8653906 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -9434,7 +9434,7 @@ __perf_event_account_interrupt(struct perf_event 
>> *event, int throttle)
>>       } else {
>>           hwc->interrupts++;
>>           if (unlikely(throttle
>> -                 && hwc->interrupts >= max_samples_per_tick)) {
>> +                 && hwc->interrupts > max_samples_per_tick)) {
>>               __this_cpu_inc(perf_throttled_count);
>>               tick_dep_set_cpu(smp_processor_id(), 
>> TICK_DEP_BIT_PERF_EVENTS);
>>               hwc->interrupts = MAX_INTERRUPTS;
>>
> 
> .
