Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496357005B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjELKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbjELKfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:35:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A1132AE;
        Fri, 12 May 2023 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683887688; x=1715423688;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+VorvQYumJr02q1cfZdLDRODEaPJsIyB8mSkRa7jy0s=;
  b=fcvMDvabQrXZ1dlb5g0/W2cNmpWgG+BHzD+i1nJdJLMZK98lVFKosWAy
   153ezFWktIotJZ3mpOxdGuJK91E/hUFWo/Vh6oxnEV49hQ113QXiNFUBt
   48UFhho+i6xvra80m47CUwzAGlSGZyZ+u9TPUF1yhMJjx0prwNlidx7vo
   AiqFGTp0fHyH9GhZjL31mZwncSoo7jXuYa/2UEzsoNUBLDBAWvrZ0pnW5
   aVyl2nXSGLLiYm5ArZ/rvqdY2cSyPPEemOUWXn7l8dWFbP26MIt7BOoTb
   iL6AQtuSjhUpkdtnkrBr5QT7OrRoddHeIKZSoKUnAcJt2r1vKZuSVwTru
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335278839"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335278839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="765136575"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765136575"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:34:42 -0700
Message-ID: <aa9f1c70-eb6c-8c09-8af6-f1a0a4b60831@intel.com>
Date:   Fri, 12 May 2023 13:34:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] perf tools: Add printing perf_event_attr config
 symbol in perf_event_attr__fprintf()
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, anshuman.khandual@arm.com,
        jesussanp@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511075154.240163-1-yangjihong1@huawei.com>
 <20230511075154.240163-5-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230511075154.240163-5-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/23 10:51, Yang Jihong wrote:
> When printing perf_event_attr, always display perf_event_attr config and its symbol
> to improve the readability of debugging information.
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
>     config                           9 (PERF_COUNT_SW_DUMMY)
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
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/perf_event_attr_fprintf.c | 159 +++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index cd0905d8cb7a..7730f0d7c28a 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -7,6 +7,11 @@
>  #include <linux/perf_event.h>
>  #include "util/evsel_fprintf.h"
>  
> +#ifdef HAVE_LIBTRACEEVENT
> +#include <stdlib.h> // for free

stdlib has too much ordinary stuff for the "// for free" comment
to be interesting, and it is very unlikely to be updated if another
dependency on stdlib were added.

> +#include "trace-event.h"
> +#endif

No where else is "#ifdef HAVE_LIBTRACEEVENT" put around
"#include "trace-event.h"

> +
>  struct bit_names {
>  	int bit;
>  	const char *name;
> @@ -86,6 +91,85 @@ static const char *stringify_perf_type_id(u64 value)
>  		return NULL;
>  	}
>  }
> +
> +static const char *stringify_perf_hw_id(u64 value)
> +{
> +	/* sync with enum perf_hw_id in perf_event.h */

As with patch 3, this comment and same ones below could be left out

> +	switch (value) {
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CPU_CYCLES)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_INSTRUCTIONS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_REFERENCES)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_MISSES)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BRANCH_MISSES)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BUS_CYCLES)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_STALLED_CYCLES_FRONTEND)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_STALLED_CYCLES_BACKEND)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_REF_CPU_CYCLES)
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static const char *stringify_perf_hw_cache_id(u64 value)
> +{
> +	/* sync with enum perf_hw_cache_id in perf_event.h */
> +	switch (value) {
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_L1D)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_L1I)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_LL)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_DTLB)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_ITLB)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_BPU)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_NODE)
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static const char *stringify_perf_hw_cache_op_id(u64 value)
> +{
> +	/* sync with enum perf_hw_cache_op_id in perf_event.h */
> +	switch (value) {
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_READ)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_WRITE)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_PREFETCH)
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static const char *stringify_perf_hw_cache_op_result_id(u64 value)
> +{
> +	/* sync with enum perf_hw_cache_op_result_id in perf_event.h */
> +	switch (value) {
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_RESULT_ACCESS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_RESULT_MISS)
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static const char *stringify_perf_sw_id(u64 value)
> +{
> +	/* sync with enum perf_sw_ids in perf_event.h */
> +	switch (value) {
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CPU_CLOCK)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_TASK_CLOCK)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CONTEXT_SWITCHES)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CPU_MIGRATIONS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS_MIN)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS_MAJ)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_ALIGNMENT_FAULTS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_EMULATION_FAULTS)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_DUMMY)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_BPF_OUTPUT)
> +	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CGROUP_SWITCHES)
> +	default:
> +		return NULL;
> +	}
> +}
>  #undef ENUM_ID_TO_STR_CASE
>  
>  static void __p_type_id(char *buf, size_t size, u64 value)
> @@ -98,6 +182,78 @@ static void __p_type_id(char *buf, size_t size, u64 value)
>  		snprintf(buf, size, "%"PRIu64" (%s)", value, str);
>  }
>  
> +static void __p_config_hw_id(char *buf, size_t size, u64 value)
> +{
> +	const char *str = stringify_perf_hw_id(value);
> +
> +	if (str == NULL)
> +		snprintf(buf, size, "%"PRIx64, value);
> +	else
> +		snprintf(buf, size, "%"PRIx64" (%s)", value, str);

This could use the print_id() or equivalent helper mentioned in patch 3

> +}
> +
> +static void __p_config_sw_id(char *buf, size_t size, u64 value)
> +{
> +	const char *str = stringify_perf_sw_id(value);
> +
> +	if (str == NULL)
> +		snprintf(buf, size, "%"PRIx64, value);
> +	else
> +		snprintf(buf, size, "%"PRIx64" (%s)", value, str);

Ditto

> +}
> +
> +static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
> +{
> +	const char *hw_cache_str = stringify_perf_hw_cache_id(value & 0xff);
> +	const char *hw_cache_op_str =
> +		stringify_perf_hw_cache_op_id((value & 0xff00) >> 8);
> +	const char *hw_cache_op_result_str =
> +		stringify_perf_hw_cache_op_result_id((value & 0xff0000) >> 16);
> +
> +	if (hw_cache_str == NULL || hw_cache_op_str == NULL ||
> +	    hw_cache_op_result_str == NULL) {
> +		snprintf(buf, size, "%#"PRIx64, value);
> +	} else {
> +		snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", value,
> +			 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
> +	}
> +}
> +
> +#ifdef HAVE_LIBTRACEEVENT
> +static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
> +{
> +	char *str = tracepoint_id_to_name(value);
> +
> +	if (str != NULL) {
> +		snprintf(buf, size, "%#"PRIx64" (%s)", value, str);
> +		free(str);
> +	} else {
> +		snprintf(buf, size, "%#"PRIx64, value);
> +	}

Ditto

Note, can just call free() on 'str' whether or not it is NULL.

> +}
> +#endif
> +
> +static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
> +{
> +	switch (type) {
> +	case PERF_TYPE_HARDWARE:
> +		return __p_config_hw_id(buf, size, value);
> +	case PERF_TYPE_SOFTWARE:
> +		return __p_config_sw_id(buf, size, value);
> +	case PERF_TYPE_HW_CACHE:
> +		return __p_config_hw_cache_id(buf, size, value);
> +	case PERF_TYPE_TRACEPOINT:
> +#ifdef HAVE_LIBTRACEEVENT
> +		return __p_config_tracepoint_id(buf, size, value);
> +#endif
> +	case PERF_TYPE_RAW:
> +	case PERF_TYPE_BREAKPOINT:
> +	default:
> +		snprintf(buf, size, "%#"PRIx64, value);
> +		return;
> +	}
> +}
> +
>  #define BUF_SIZE		1024
>  
>  #define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
> @@ -107,6 +263,7 @@ static void __p_type_id(char *buf, size_t size, u64 value)
>  #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
>  #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
>  #define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
> +#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
>  
>  #define PRINT_ATTRn(_n, _f, _p, _a)			\
>  do {							\
> @@ -126,7 +283,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  
>  	PRINT_ATTRn("type", type, p_type_id, true);
>  	PRINT_ATTRf(size, p_unsigned);
> -	PRINT_ATTRf(config, p_hex);
> +	PRINT_ATTRn("config", config, p_config_id, true);
>  	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
>  	PRINT_ATTRf(sample_type, p_sample_type);
>  	PRINT_ATTRf(read_format, p_read_format);

