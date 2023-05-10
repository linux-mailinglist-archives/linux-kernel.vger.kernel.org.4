Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE66FD816
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjEJHWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjEJHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:22:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60C26BF;
        Wed, 10 May 2023 00:22:33 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QGRK96qjgzpWKT;
        Wed, 10 May 2023 15:21:17 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 15:22:30 +0800
Subject: Re: [PATCH 0/4] perf tools: Add printing perf_event_attr `config` and
 `id` symbol in perf_event_attr__fprintf()
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230419122912.73746-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <4f1e2c1f-8bfc-49a7-2989-55a55057e725@huawei.com>
Date:   Wed, 10 May 2023 15:22:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230419122912.73746-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

PING.

Thanks,
Yang.

On 2023/4/19 20:29, Yang Jihong wrote:
> Add printing perf_event_attr `config` and `id` symbol to improve the readability of debugging information.
> 
> Before:
> 
>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
>    <SNIP>
>    ------------------------------------------------------------
>    perf_event_attr:
>      size                             136
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             1
>      size                             136
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             2
>      size                             136
>      config                           0x131
>      { sample_period, sample_freq }   1
>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             3
>      size                             136
>      config                           0x10005
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             4
>      size                             136
>      config                           0x101
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>    <SNIP>
> 
> After:
> 
>    # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
>    <SNIP>
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             0 (PERF_TYPE_HARDWARE)
>      size                             136
>      config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             1 (PERF_TYPE_SOFTWARE)
>      size                             136
>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             2 (PERF_TYPE_TRACEPOINT)
>      size                             136
>      config                           0x131 (sched:sched_switch)
>      { sample_period, sample_freq }   1
>      sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             3 (PERF_TYPE_HW_CACHE)
>      size                             136
>      config                           0x10005 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_BPU)
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             4 (PERF_TYPE_RAW)
>      size                             136
>      config                           0x101
>      { sample_period, sample_freq }   4000
>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>      read_format                      ID
>      disabled                         1
>      inherit                          1
>      freq                             1
>      sample_id_all                    1
>      exclude_guest                    1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>    <SNIP>
> 
> Yang Jihong (4):
>    perf trace-event-info: Add tracepoint_id_to_name() helper
>    perf tools: Extend PRINT_ATTRf to support printing of members with a
>      value of 0
>    perf tools: Add printing perf_event_attr->type symbol in
>      perf_event_attr__fprintf()
>    perf tools: Add printing perf_event_attr->config symbol in
>      perf_event_attr__fprintf()
> 
>   tools/perf/util/perf_event_attr_fprintf.c | 169 ++++++++++++++++++++--
>   tools/perf/util/trace-event-info.c        |  13 ++
>   tools/perf/util/trace-event.h             |   6 +
>   3 files changed, 179 insertions(+), 9 deletions(-)
> 
