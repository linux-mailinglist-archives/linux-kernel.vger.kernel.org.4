Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013CA7049AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjEPJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjEPJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:49:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AA2D62;
        Tue, 16 May 2023 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684230575; x=1715766575;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fKe6/XFXBGkwreXb/HN9jPkMOxfd3eRoCAjzTqBc/Vc=;
  b=lj4MiDB2v+HuUrGcM7Lw/adiovSCEYPFt8Fg1xyDAn8s+SZjlJCjiB32
   lb27F3xiejsXwg0NLb7ZsrWVjwZ9hWshpNeQkse64zfNtUTNxCdkmSD7Z
   0env/aY0kORtr7mvoJ1VCyOcD6P+Wxu+30zR7965IUFJIUEQZBbo4IEK/
   T5Q7oWABApS92CFs2W7pdkWdS6O89UCIFdi/fZsMGuNaYpBvmM3ghchf7
   Y22ZMthDOFV2xLox9wW+tbYKT/ciamZkhiQprVLyqAHX3wmnNR1I9YYUP
   a0+jXiKwmnEEwfxm5EXqIjVypJAT1V6TfFueA6muVpOlNIWF8IQX2d5Lp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417091368"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417091368"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 02:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="825511964"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="825511964"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.202])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 02:49:31 -0700
Message-ID: <3918ec79-29de-97cd-a454-7f681028409f@intel.com>
Date:   Tue, 16 May 2023 12:49:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/4] perf tools: Add printing perf_event_attr `config`
 and `id` symbol in perf_event_attr__fprintf()
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, anshuman.khandual@arm.com,
        jesussanp@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516065538.83021-1-yangjihong1@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230516065538.83021-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/23 09:55, Yang Jihong wrote:
> Add printing perf_event_attr `config` and `id` symbol to improve the readability of debugging information.
> 
> Before:
> 
>   # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>   <SNIP>
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             2
>     size                             136
>     config                           0x143
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             3
>     size                             136
>     config                           0x10005
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             136
>     config                           0x101
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             5
>     size                             136
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>     bp_type                          3
>     { bp_len, config2 }              0x4
>   ------------------------------------------------------------
>   <SNIP>
> 
> After:
> 
>   # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
>   <SNIP>
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     size                             136
>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             2 (PERF_TYPE_TRACEPOINT)
>     size                             136
>     config                           0x143 (sched:sched_switch)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             3 (PERF_TYPE_HW_CACHE)
>     size                             136
>     config                           0x10005 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_BPU)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4 (PERF_TYPE_RAW)
>     size                             136
>     config                           0x101
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             5 (PERF_TYPE_BREAKPOINT)
>     size                             136
>     config                           0
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>     bp_type                          3
>     { bp_len, config2 }              0x4
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
>   <SNIP>
> 
> Yang Jihong (4):
>   perf trace-event-info: Add tracepoint_id_to_name() helper
>   perf tools: Extend PRINT_ATTRf to support printing of members with a
>     value of 0
>   perf tools: Add printing perf_event_attr type symbol in
>     perf_event_attr__fprintf()
>   perf tools: Add printing perf_event_attr config symbol in
>     perf_event_attr__fprintf()
> 
>  tools/perf/util/perf_event_attr_fprintf.c | 186 ++++++++++++++++++++--
>  tools/perf/util/trace-event-info.c        |  11 ++
>  tools/perf/util/trace-event.h             |   6 +
>  3 files changed, 194 insertions(+), 9 deletions(-)
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


