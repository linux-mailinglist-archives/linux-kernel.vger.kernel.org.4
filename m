Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0E708D45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjESBUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjESBUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:20:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B810E3;
        Thu, 18 May 2023 18:19:47 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QMpqV5lH9zsSKs;
        Fri, 19 May 2023 09:17:42 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 09:19:43 +0800
Subject: Re: [PATCH v4 0/4] perf tools: Add printing perf_event_attr `config`
 and `id` symbol in perf_event_attr__fprintf()
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <anshuman.khandual@arm.com>, <jesussanp@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230516065538.83021-1-yangjihong1@huawei.com>
 <3918ec79-29de-97cd-a454-7f681028409f@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <1914633f-4e81-dede-7d28-813928927b37@huawei.com>
Date:   Fri, 19 May 2023 09:19:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3918ec79-29de-97cd-a454-7f681028409f@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/5/16 17:49, Adrian Hunter wrote:
> On 16/05/23 09:55, Yang Jihong wrote:
>> Add printing perf_event_attr `config` and `id` symbol to improve the readability of debugging information.
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
>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
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
>> Yang Jihong (4):
>>    perf trace-event-info: Add tracepoint_id_to_name() helper
>>    perf tools: Extend PRINT_ATTRf to support printing of members with a
>>      value of 0
>>    perf tools: Add printing perf_event_attr type symbol in
>>      perf_event_attr__fprintf()
>>    perf tools: Add printing perf_event_attr config symbol in
>>      perf_event_attr__fprintf()
>>
>>   tools/perf/util/perf_event_attr_fprintf.c | 186 ++++++++++++++++++++--
>>   tools/perf/util/trace-event-info.c        |  11 ++
>>   tools/perf/util/trace-event.h             |   6 +
>>   3 files changed, 194 insertions(+), 9 deletions(-)
>>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
Thanks for review!

Thanks,
Yang
> .
> 
