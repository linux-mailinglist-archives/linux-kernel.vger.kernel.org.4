Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A65702793
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjEOIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEOIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:52:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8EA1BE;
        Mon, 15 May 2023 01:52:08 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKY3N0MpWzsRxV;
        Mon, 15 May 2023 16:50:08 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 16:52:05 +0800
Subject: Re: [PATCH v2 4/4] perf tools: Add printing perf_event_attr config
 symbol in perf_event_attr__fprintf()
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <anshuman.khandual@arm.com>, <jesussanp@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230511075154.240163-1-yangjihong1@huawei.com>
 <20230511075154.240163-5-yangjihong1@huawei.com>
 <aa9f1c70-eb6c-8c09-8af6-f1a0a4b60831@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <d598ec43-5729-33a4-0b2a-976459803bac@huawei.com>
Date:   Mon, 15 May 2023 16:52:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aa9f1c70-eb6c-8c09-8af6-f1a0a4b60831@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/5/12 18:34, Adrian Hunter wrote:
> On 11/05/23 10:51, Yang Jihong wrote:
>> When printing perf_event_attr, always display perf_event_attr config and its symbol
>> to improve the readability of debugging information.
>>
>> Before:
>>
>>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>>    <SNIP>
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      size                             136
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1
>>      size                             136
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             2
>>      size                             136
>>      config                           0x143
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             3
>>      size                             136
>>      config                           0x10005
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             4
>>      size                             136
>>      config                           0x101
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             5
>>      size                             136
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      bp_type                          3
>>      { bp_len, config2 }              0x4
>>    ------------------------------------------------------------
>>    <SNIP>
>>
>> After:
>>
>>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>>    <SNIP>
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             0 (PERF_TYPE_HARDWARE)
>>      size                             136
>>      config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1 (PERF_TYPE_SOFTWARE)
>>      size                             136
>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             2 (PERF_TYPE_TRACEPOINT)
>>      size                             136
>>      config                           0x143 (sched:sched_switch)
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             3 (PERF_TYPE_HW_CACHE)
>>      size                             136
>>      config                           0x10005 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_BPU)
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             4 (PERF_TYPE_RAW)
>>      size                             136
>>      config                           0x101
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             5 (PERF_TYPE_BREAKPOINT)
>>      size                             136
>>      config                           0
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      bp_type                          3
>>      { bp_len, config2 }              0x4
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1 (PERF_TYPE_SOFTWARE)
>>      size                             136
>>      config                           9 (PERF_COUNT_SW_DUMMY)
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID
>>      inherit                          1
>>      mmap                             1
>>      comm                             1
>>      freq                             1
>>      task                             1
>>      sample_id_all                    1
>>      mmap2                            1
>>      comm_exec                        1
>>      ksymbol                          1
>>      bpf_event                        1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
>>    <SNIP>
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/util/perf_event_attr_fprintf.c | 159 +++++++++++++++++++++-
>>   1 file changed, 158 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>> index cd0905d8cb7a..7730f0d7c28a 100644
>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>> @@ -7,6 +7,11 @@
>>   #include <linux/perf_event.h>
>>   #include "util/evsel_fprintf.h"
>>   
>> +#ifdef HAVE_LIBTRACEEVENT
>> +#include <stdlib.h> // for free
> 
> stdlib has too much ordinary stuff for the "// for free" comment
> to be interesting, and it is very unlikely to be updated if another
> dependency on stdlib were added.
> 
>> +#include "trace-event.h"
>> +#endif
> 
> No where else is "#ifdef HAVE_LIBTRACEEVENT" put around
> "#include "trace-event.h"
> 
OK, will remove "// for free" and "#ifdef HAVE_LIBTRACEEVENT" in v3.
>> +
>>   struct bit_names {
>>   	int bit;
>>   	const char *name;
>> @@ -86,6 +91,85 @@ static const char *stringify_perf_type_id(u64 value)
>>   		return NULL;
>>   	}
>>   }
>> +
>> +static const char *stringify_perf_hw_id(u64 value)
>> +{
>> +	/* sync with enum perf_hw_id in perf_event.h */
> 
> As with patch 3, this comment and same ones below could be left out
OK, will remove in v3.
> 
>> +	switch (value) {
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CPU_CYCLES)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_INSTRUCTIONS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_REFERENCES)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_MISSES)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BRANCH_MISSES)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BUS_CYCLES)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_STALLED_CYCLES_FRONTEND)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_STALLED_CYCLES_BACKEND)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_REF_CPU_CYCLES)
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +
>> +static const char *stringify_perf_hw_cache_id(u64 value)
>> +{
>> +	/* sync with enum perf_hw_cache_id in perf_event.h */
>> +	switch (value) {
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_L1D)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_L1I)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_LL)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_DTLB)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_ITLB)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_BPU)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_NODE)
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +
>> +static const char *stringify_perf_hw_cache_op_id(u64 value)
>> +{
>> +	/* sync with enum perf_hw_cache_op_id in perf_event.h */
>> +	switch (value) {
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_READ)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_WRITE)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_PREFETCH)
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +
>> +static const char *stringify_perf_hw_cache_op_result_id(u64 value)
>> +{
>> +	/* sync with enum perf_hw_cache_op_result_id in perf_event.h */
>> +	switch (value) {
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_RESULT_ACCESS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_RESULT_MISS)
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +
>> +static const char *stringify_perf_sw_id(u64 value)
>> +{
>> +	/* sync with enum perf_sw_ids in perf_event.h */
>> +	switch (value) {
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CPU_CLOCK)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_TASK_CLOCK)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CONTEXT_SWITCHES)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CPU_MIGRATIONS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS_MIN)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS_MAJ)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_ALIGNMENT_FAULTS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_EMULATION_FAULTS)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_DUMMY)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_BPF_OUTPUT)
>> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CGROUP_SWITCHES)
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>>   #undef ENUM_ID_TO_STR_CASE
>>   
>>   static void __p_type_id(char *buf, size_t size, u64 value)
>> @@ -98,6 +182,78 @@ static void __p_type_id(char *buf, size_t size, u64 value)
>>   		snprintf(buf, size, "%"PRIu64" (%s)", value, str);
>>   }
>>   
>> +static void __p_config_hw_id(char *buf, size_t size, u64 value)
>> +{
>> +	const char *str = stringify_perf_hw_id(value);
>> +
>> +	if (str == NULL)
>> +		snprintf(buf, size, "%"PRIx64, value);
>> +	else
>> +		snprintf(buf, size, "%"PRIx64" (%s)", value, str);
> 
> This could use the print_id() or equivalent helper mentioned in patch 3
OK, will fix in v3.
> 
>> +}
>> +
>> +static void __p_config_sw_id(char *buf, size_t size, u64 value)
>> +{
>> +	const char *str = stringify_perf_sw_id(value);
>> +
>> +	if (str == NULL)
>> +		snprintf(buf, size, "%"PRIx64, value);
>> +	else
>> +		snprintf(buf, size, "%"PRIx64" (%s)", value, str);
> 
> Ditto
OK, ditto
> 
>> +}
>> +
>> +static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
>> +{
>> +	const char *hw_cache_str = stringify_perf_hw_cache_id(value & 0xff);
>> +	const char *hw_cache_op_str =
>> +		stringify_perf_hw_cache_op_id((value & 0xff00) >> 8);
>> +	const char *hw_cache_op_result_str =
>> +		stringify_perf_hw_cache_op_result_id((value & 0xff0000) >> 16);
>> +
>> +	if (hw_cache_str == NULL || hw_cache_op_str == NULL ||
>> +	    hw_cache_op_result_str == NULL) {
>> +		snprintf(buf, size, "%#"PRIx64, value);
>> +	} else {
>> +		snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", value,
>> +			 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
>> +	}
>> +}
>> +
>> +#ifdef HAVE_LIBTRACEEVENT
>> +static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
>> +{
>> +	char *str = tracepoint_id_to_name(value);
>> +
>> +	if (str != NULL) {
>> +		snprintf(buf, size, "%#"PRIx64" (%s)", value, str);
>> +		free(str);
>> +	} else {
>> +		snprintf(buf, size, "%#"PRIx64, value);
>> +	}
> 
> Ditto

> 
> Note, can just call free() on 'str' whether or not it is NULL.
>
OK, ditto

Thanks for such a detailed suggestion.

Thanks,
Yang
