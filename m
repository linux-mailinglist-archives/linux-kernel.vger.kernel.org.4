Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83B7045B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjEPHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjEPHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:01:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372DD1;
        Tue, 16 May 2023 00:01:04 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QL6Xl6WQ4zsRgd;
        Tue, 16 May 2023 14:59:03 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 15:01:01 +0800
Subject: Re: [PATCH v2 3/4] perf tools: Add printing perf_event_attr type
 symbol in perf_event_attr__fprintf()
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <anshuman.khandual@arm.com>, <jesussanp@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230511075154.240163-1-yangjihong1@huawei.com>
 <20230511075154.240163-4-yangjihong1@huawei.com>
 <0be18c9a-ab56-021f-5c51-8b066ead2e1c@intel.com>
 <ca0f27b5-bf0a-6ae3-a05c-84a456b02fcf@huawei.com>
 <249004ff-43b1-e25d-c8d8-9f19ce4c4aa9@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <c2d48f25-c77b-ee61-fc00-1c0c915c48b8@huawei.com>
Date:   Tue, 16 May 2023 15:01:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <249004ff-43b1-e25d-c8d8-9f19ce4c4aa9@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/5/15 16:56, Adrian Hunter wrote:
> On 15/05/23 11:48, Yang Jihong wrote:
>> Hello,
>>
>> On 2023/5/12 18:34, Adrian Hunter wrote:
>>> On 11/05/23 10:51, Yang Jihong wrote:
>>>> When printing perf_event_attr, always display perf_event_attr type and its symbol
>>>> to improve the readability of debugging information.
>>>>
>>>> Before:
>>>>
>>>>     # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>>>>     <SNIP>
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       size                             136
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             1
>>>>       size                             136
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             2
>>>>       size                             136
>>>>       config                           0x143
>>>>       { sample_period, sample_freq }   1
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             3
>>>>       size                             136
>>>>       config                           0x10005
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             4
>>>>       size                             136
>>>>       config                           0x101
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             5
>>>>       size                             136
>>>>       { sample_period, sample_freq }   1
>>>>       sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>       bp_type                          3
>>>>       { bp_len, config2 }              0x4
>>>>     ------------------------------------------------------------
>>>>     <SNIP>
>>>>
>>>> After:
>>>>
>>>>     # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>>>>     <SNIP>
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             0 (PERF_TYPE_HARDWARE)
>>>>       size                             136
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             1 (PERF_TYPE_SOFTWARE)
>>>>       size                             136
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             2 (PERF_TYPE_TRACEPOINT)
>>>>       size                             136
>>>>       config                           0x143
>>>>       { sample_period, sample_freq }   1
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             3 (PERF_TYPE_HW_CACHE)
>>>>       size                             136
>>>>       config                           0x10005
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             4 (PERF_TYPE_RAW)
>>>>       size                             136
>>>>       config                           0x101
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             5 (PERF_TYPE_BREAKPOINT)
>>>>       size                             136
>>>>       { sample_period, sample_freq }   1
>>>>       sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>>       read_format                      ID
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>       bp_type                          3
>>>>       { bp_len, config2 }              0x4
>>>>     ------------------------------------------------------------
>>>>     <SNIP>
>>>>
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>> ---
>>>>    tools/perf/util/perf_event_attr_fprintf.c | 30 ++++++++++++++++++++++-
>>>>    1 file changed, 29 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>>>> index 433029c6afc5..cd0905d8cb7a 100644
>>>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>>>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>>>> @@ -71,6 +71,33 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>>>>        __p_bits(buf, size, value, bits);
>>>>    }
>>>>    +#define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
>>>> +static const char *stringify_perf_type_id(u64 value)
>>>> +{
>>>> +    /* sync with enum perf_type_id in perf_event.h */
>>>
>>> Everything in this file syncs with perf_event.h, so the comment
>>> does not seem very useful.
>> OK, will fix in v3.
>>>
>>>> +    switch (value) {
>>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
>>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
>>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
>>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_HW_CACHE)
>>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_RAW)
>>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_BREAKPOINT)
>>>> +    default:
>>>> +        return NULL;
>>>> +    }
>>>> +}
>>>> +#undef ENUM_ID_TO_STR_CASE
>>>> +
>>>> +static void __p_type_id(char *buf, size_t size, u64 value)
>>>> +{
>>>> +    const char *str = stringify_perf_type_id(value);
>>>> +
>>>> +    if (str == NULL)
>>>> +        snprintf(buf, size, "%"PRIu64, value);
>>>> +    else
>>>> +        snprintf(buf, size, "%"PRIu64" (%s)", value, str);
>>>
>>> These 4 lines end up getting used again about 3 times in the next
>>> patch, so might as well be a separate function e.g.
>>>
>>>      print_id(buf, size, value, stringify_perf_type_id(value));
>>>
>>> where:
>>>
>>> static void print_id(char *buf, size_t size, u64 value, const char *str)
>>> {
>>>      if (str == NULL)
>>>          snprintf(buf, size, "%"PRIu64, value);
>>>      else
>>>          snprintf(buf, size, "%"PRIu64" (%s)", value, str);
>>> }
>>>
>> OK, will add print_id() helper in v3.
>> If print_id() helper is also used to print config id, is printed in the decimal format. In the past, it is printed in the hexadecimal format，
>> there may be some changes here.
>>
>> Before:
>>    config                           0x143
>>
>> After:
>>    config                           323 (sched:sched_switch)
> 
> Right I didn't notice the difference.  Best keep print_id() just for the hex cases.
> 
v4 has been sent, print_id() helper is changed to a macro function to 
support printing of both 'hex' and 'unsigned' formats.
Please see if it's OK.

Thanks,
Yang
