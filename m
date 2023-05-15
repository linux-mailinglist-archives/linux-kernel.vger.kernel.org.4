Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13E7027AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbjEOI5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEOI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:57:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC6EB;
        Mon, 15 May 2023 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684141016; x=1715677016;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=WMNzPu+/H7RTssbzDtuwFETCJ18bJJGUdLHqc7+VFqY=;
  b=bY260y1L9K8bAWXw+5alQQVKCWk2B1B6pD0MPqcvS5L1bLNwdEHqb5r5
   nAYasZjrLmGE3PJD/OaCW50BRsp5+gOUC6O42mnwskvFx0g3U32L5Erem
   n+DkznWsPWCxgj3CvIIA1AXRm8IrrFX+v31huG0//hIgwGt831zyIyWrZ
   /Fm6CUYkkIAYYVHZJn0kH9GhaW3Oq/+ww0npgSHfwDBcXydcztIF447dN
   4/nGFqUvGS1hPvJqUF280p3kZtNM43mNsEL7oQW3hMGeL1vq3r9dPq0+7
   ug1HLfvC8o+b3i9T4MMLWWzmnSl9vgE73re8yiigYTWzWvXlIanjnwK++
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="335688107"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="335688107"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 01:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="700893121"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="700893121"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.69])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 01:56:51 -0700
Message-ID: <249004ff-43b1-e25d-c8d8-9f19ce4c4aa9@intel.com>
Date:   Mon, 15 May 2023 11:56:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] perf tools: Add printing perf_event_attr type
 symbol in perf_event_attr__fprintf()
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, anshuman.khandual@arm.com,
        jesussanp@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511075154.240163-1-yangjihong1@huawei.com>
 <20230511075154.240163-4-yangjihong1@huawei.com>
 <0be18c9a-ab56-021f-5c51-8b066ead2e1c@intel.com>
 <ca0f27b5-bf0a-6ae3-a05c-84a456b02fcf@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ca0f27b5-bf0a-6ae3-a05c-84a456b02fcf@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/23 11:48, Yang Jihong wrote:
> Hello,
> 
> On 2023/5/12 18:34, Adrian Hunter wrote:
>> On 11/05/23 10:51, Yang Jihong wrote:
>>> When printing perf_event_attr, always display perf_event_attr type and its symbol
>>> to improve the readability of debugging information.
>>>
>>> Before:
>>>
>>>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>>>    <SNIP>
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             2
>>>      size                             136
>>>      config                           0x143
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             3
>>>      size                             136
>>>      config                           0x10005
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             4
>>>      size                             136
>>>      config                           0x101
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             5
>>>      size                             136
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>      bp_type                          3
>>>      { bp_len, config2 }              0x4
>>>    ------------------------------------------------------------
>>>    <SNIP>
>>>
>>> After:
>>>
>>>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>>>    <SNIP>
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             0 (PERF_TYPE_HARDWARE)
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>      size                             136
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             2 (PERF_TYPE_TRACEPOINT)
>>>      size                             136
>>>      config                           0x143
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             3 (PERF_TYPE_HW_CACHE)
>>>      size                             136
>>>      config                           0x10005
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             4 (PERF_TYPE_RAW)
>>>      size                             136
>>>      config                           0x101
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             5 (PERF_TYPE_BREAKPOINT)
>>>      size                             136
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>      read_format                      ID
>>>      disabled                         1
>>>      inherit                          1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>      bp_type                          3
>>>      { bp_len, config2 }              0x4
>>>    ------------------------------------------------------------
>>>    <SNIP>
>>>
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>> ---
>>>   tools/perf/util/perf_event_attr_fprintf.c | 30 ++++++++++++++++++++++-
>>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>>> index 433029c6afc5..cd0905d8cb7a 100644
>>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>>> @@ -71,6 +71,33 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>>>       __p_bits(buf, size, value, bits);
>>>   }
>>>   +#define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
>>> +static const char *stringify_perf_type_id(u64 value)
>>> +{
>>> +    /* sync with enum perf_type_id in perf_event.h */
>>
>> Everything in this file syncs with perf_event.h, so the comment
>> does not seem very useful.
> OK, will fix in v3.
>>
>>> +    switch (value) {
>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_HW_CACHE)
>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_RAW)
>>> +    ENUM_ID_TO_STR_CASE(PERF_TYPE_BREAKPOINT)
>>> +    default:
>>> +        return NULL;
>>> +    }
>>> +}
>>> +#undef ENUM_ID_TO_STR_CASE
>>> +
>>> +static void __p_type_id(char *buf, size_t size, u64 value)
>>> +{
>>> +    const char *str = stringify_perf_type_id(value);
>>> +
>>> +    if (str == NULL)
>>> +        snprintf(buf, size, "%"PRIu64, value);
>>> +    else
>>> +        snprintf(buf, size, "%"PRIu64" (%s)", value, str);
>>
>> These 4 lines end up getting used again about 3 times in the next
>> patch, so might as well be a separate function e.g.
>>
>>     print_id(buf, size, value, stringify_perf_type_id(value));
>>
>> where:
>>
>> static void print_id(char *buf, size_t size, u64 value, const char *str)
>> {
>>     if (str == NULL)
>>         snprintf(buf, size, "%"PRIu64, value);
>>     else
>>         snprintf(buf, size, "%"PRIu64" (%s)", value, str);
>> }
>>
> OK, will add print_id() helper in v3.
> If print_id() helper is also used to print config id, is printed in the decimal format. In the past, it is printed in the hexadecimal format，
> there may be some changes here.
> 
> Before:
>   config                           0x143
> 
> After:
>   config                           323 (sched:sched_switch)

Right I didn't notice the difference.  Best keep print_id() just for the hex cases.

> 
>>> +}
>>> +
>>>   #define BUF_SIZE        1024
>>>     #define p_hex(val)        snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
>>> @@ -79,6 +106,7 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>>>   #define p_sample_type(val)    __p_sample_type(buf, BUF_SIZE, val)
>>>   #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
>>>   #define p_read_format(val)    __p_read_format(buf, BUF_SIZE, val)
>>> +#define p_type_id(val)        __p_type_id(buf, BUF_SIZE, val)
>>>     #define PRINT_ATTRn(_n, _f, _p, _a)            \
>>>   do {                            \
>>> @@ -96,7 +124,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>>>       char buf[BUF_SIZE];
>>>       int ret = 0;
>>>   -    PRINT_ATTRf(type, p_unsigned);
>>> +    PRINT_ATTRn("type", type, p_type_id, true);
>>>       PRINT_ATTRf(size, p_unsigned);
>>>       PRINT_ATTRf(config, p_hex);
>>>       PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
>>
>> .
>>

