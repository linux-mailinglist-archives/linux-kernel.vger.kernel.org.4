Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE86E70D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjDSBrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSBrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:47:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346327AB9;
        Tue, 18 Apr 2023 18:47:08 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q1NpW3cNNzSswL;
        Wed, 19 Apr 2023 09:42:59 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 09:47:05 +0800
Subject: Re: [PATCH] perf/core: Fix perf_sample_data not properly initialized
 for different swevents in perf_tp_event()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230412095240.181516-1-yangjihong1@huawei.com>
 <20230417114512.GK83892@hirez.programming.kicks-ass.net>
 <15805714-27c0-b8ff-143a-8f768704a673@huawei.com>
 <20230418102545.GX4253@hirez.programming.kicks-ass.net>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e01e3e5c-0a48-2394-ac59-2c0541fa181a@huawei.com>
Date:   Wed, 19 Apr 2023 09:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230418102545.GX4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/4/18 18:25, Peter Zijlstra wrote:
> On Tue, Apr 18, 2023 at 09:35:23AM +0800, Yang Jihong wrote:
> 
>>> I'm thinking perhaps those flags that update ->dyn_size are the problem?
>>> At the same time, Should you not also then clear dyn_size?
> 
>> Yes, according to the code, dyn_size should also be cleared.
>> Maybe we need to change it to the following, which would be more
>> appropriate?
>>
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -10144,14 +10144,14 @@ void perf_tp_event(u16 event_type, u64 count, void
>> *record, int entry_size,
>>                  },
>>          };
>>
>> -       perf_sample_data_init(&data, 0, 0);
>> -       perf_sample_save_raw_data(&data, &raw);
>> -
>>          perf_trace_buf_update(record, event_type);
>>
>>          hlist_for_each_entry_rcu(event, head, hlist_entry) {
>> -               if (perf_tp_event_match(event, &data, regs))
>> +               if (perf_tp_event_match(event, &data, regs)) {
>> +                       perf_sample_data_init(&data, 0, 0);
>> +                       perf_sample_save_raw_data(&data, &raw);
>>                          perf_swevent_event(event, count, &data, regs);
>> +               }
>>          }
> 
> That is certainly the safe option. I just went through the list and
> while there's certainly a number of options we'll recompute for naught,
> most of them are indeed either dyn_size or event specific :/
> 
> So yeah, please send the above as v2.
> 
OK, will send v2 according to above fix solution.

Thanks,
Yang.
