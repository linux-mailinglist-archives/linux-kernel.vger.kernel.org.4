Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E06FED0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjEKHmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjEKHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:42:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F110FD;
        Thu, 11 May 2023 00:42:10 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QH3dt28HSzpSyK;
        Thu, 11 May 2023 15:37:54 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:42:06 +0800
Subject: Re: [PATCH 3/4] perf tools: Add printing perf_event_attr->type symbol
 in perf_event_attr__fprintf()
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <anshuman.khandual@arm.com>, <jesussanp@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230419122912.73746-1-yangjihong1@huawei.com>
 <20230419122912.73746-4-yangjihong1@huawei.com>
 <09511964-dea6-f078-b24c-fef6b05f5b79@intel.com>
 <5267232a-05a4-393b-b68e-da6a4f46d5e8@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <bcf24f41-8be1-75f4-aafa-d47dccc15500@huawei.com>
Date:   Thu, 11 May 2023 15:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5267232a-05a4-393b-b68e-da6a4f46d5e8@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/5/10 23:51, Adrian Hunter wrote:
> On 10/05/23 11:32, Adrian Hunter wrote:
>> On 19/04/23 15:29, Yang Jihong wrote:
>>> When printing perf_event_attr, always display attr->type and its symbol
>>> to improve the readability of debugging information.
>>>
>>> Before:
>>>
>>>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
>>>    <SNIP>
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             2
>>>      size                             136
>>>      config                           0x131
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             3
>>>      size                             136
>>>      config                           0x10005
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             4
>>>      size                             136
>>>      config                           0x101
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>>>    <SNIP>
>>>
>>> After:
>>>
>>>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
>>>    <SNIP>
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             0 (PERF_TYPE_HARDWARE)
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             2 (PERF_TYPE_TRACEPOINT)
>>>      size                             136
>>>      config                           0x131
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             3 (PERF_TYPE_HW_CACHE)
>>>      size                             136
>>>      config                           0x10005
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             4 (PERF_TYPE_RAW)
>>>      size                             136
>>>      config                           0x101
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>>>    <SNIP>
>>>
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>> ---
>>>   tools/perf/util/perf_event_attr_fprintf.c | 24 ++++++++++++++++++++++-
>>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>>> index 433029c6afc5..d9d70126d505 100644
>>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>>> @@ -71,6 +71,27 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>>>   	__p_bits(buf, size, value, bits);
>>>   }
>>>   
>>> +static void __p_type_id(char *buf, size_t size, u64 value)
>>> +{
>>> +	/* sync with enum perf_type_id in perf_event.h */
>>> +	switch (value) {
>>> +#define PRINT_ENUM_PERF_TYPE_ID_CASE(x)					\
>>> +	case x:								\
>>> +		snprintf(buf, size, "%"PRIu64" (%s)", value, #x);	\
>>> +		return;
>>> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_HARDWARE)
>>> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_SOFTWARE)
>>> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_TRACEPOINT)
>>> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_HW_CACHE)
>>> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_RAW)
>>> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_BREAKPOINT)
>>> +#undef PRINT_ENUM_PERF_TYPE_ID_CASE
>>
>> These are ABI constants so maybe simpler:
>>
>> 	const char *fixed_types[] = {"HARDWARE", "SOFTWARE", "TRACEPOINT",
>> 				     "HW_CACHE", "RAW", "BREAKPOINT"};
>>
>> 	if (value < ARRAY_SIZE(fixed_types)) {
>> 		snprintf(buf, size, "%"PRIu64" (PERF_TYPE_%s)",
>> 			 value, fixed_types[value]);
>> 	} else {
>> 		snprintf(buf, size, "%"PRIu64, value);
>> 	}
> 
> Although it is really the repeated snprintf that seems unnecessary
> so maybe use a switch but just to get the stringified name.
> 
Ok, will use switch/case to get stringified name for type and id in v2.

Thanks,
Yang
