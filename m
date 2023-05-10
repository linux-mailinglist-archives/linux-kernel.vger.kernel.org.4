Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E256FD981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjEJIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjEJIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:33:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B73A98;
        Wed, 10 May 2023 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683707559; x=1715243559;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Zt3Xjklu96TrqmRv4Waovk0XQkK4uNLi7C8DbknCiCU=;
  b=lkWiesqHF197Y+2xdIDagFSFF3yh9WnhdM8qTjpx1r08IORmb7neE+Z3
   0f+8LArS0AJqMMbH+nvO6IEEGwgUUE2WQbUhdstI0JcPnA6G8CQykegTi
   o6qsIem+8t+Xzv3E6eLzewvE54HU3xJSJet6PNkPd9yQCYZ01icOrs7KI
   aRru4NjR0wVZ8qBZZl+xRbzqm4wCmeFgRF9tjT8QEXmPGrDRk+jtRETQO
   iHHSFxD9NdjntG2dGZQxt/PjV4Roo2cyExc8M/ZH5XQWO/ZXXwzVitgEq
   Nwc77LqhFcQzIYEVb2dxkh7T0Zx/6xZJuN5jNZQAmLDlJXz1KeAYT8+0W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="330523722"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="330523722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 01:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="676765690"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="676765690"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.254])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 01:32:07 -0700
Message-ID: <09511964-dea6-f078-b24c-fef6b05f5b79@intel.com>
Date:   Wed, 10 May 2023 11:32:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] perf tools: Add printing perf_event_attr->type symbol
 in perf_event_attr__fprintf()
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, anshuman.khandual@arm.com,
        jesussanp@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419122912.73746-1-yangjihong1@huawei.com>
 <20230419122912.73746-4-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230419122912.73746-4-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/23 15:29, Yang Jihong wrote:
> When printing perf_event_attr, always display attr->type and its symbol
> to improve the readability of debugging information.
> 
> Before:
> 
>   # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             2
>     size                             136
>     config                           0x131
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>   <SNIP>
> 
> After:
> 
>   # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
>   <SNIP>
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
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
>     type                             1 (PERF_TYPE_SOFTWARE)
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             2 (PERF_TYPE_TRACEPOINT)
>     size                             136
>     config                           0x131
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             3 (PERF_TYPE_HW_CACHE)
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
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
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
>   <SNIP>
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/perf_event_attr_fprintf.c | 24 ++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 433029c6afc5..d9d70126d505 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -71,6 +71,27 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>  	__p_bits(buf, size, value, bits);
>  }
>  
> +static void __p_type_id(char *buf, size_t size, u64 value)
> +{
> +	/* sync with enum perf_type_id in perf_event.h */
> +	switch (value) {
> +#define PRINT_ENUM_PERF_TYPE_ID_CASE(x)					\
> +	case x:								\
> +		snprintf(buf, size, "%"PRIu64" (%s)", value, #x);	\
> +		return;
> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_HARDWARE)
> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_SOFTWARE)
> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_TRACEPOINT)
> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_HW_CACHE)
> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_RAW)
> +	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_BREAKPOINT)
> +#undef PRINT_ENUM_PERF_TYPE_ID_CASE

These are ABI constants so maybe simpler:

	const char *fixed_types[] = {"HARDWARE", "SOFTWARE", "TRACEPOINT",
				     "HW_CACHE", "RAW", "BREAKPOINT"};

	if (value < ARRAY_SIZE(fixed_types)) {
		snprintf(buf, size, "%"PRIu64" (PERF_TYPE_%s)",
			 value, fixed_types[value]);
	} else {
		snprintf(buf, size, "%"PRIu64, value);
	}

> +	default:
> +		snprintf(buf, size, "%"PRIu64, value);
> +		return;
> +	}
> +}
> +
>  #define BUF_SIZE		1024
>  
>  #define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
> @@ -79,6 +100,7 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>  #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
>  #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
>  #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
> +#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
>  
>  #define PRINT_ATTRn(_n, _f, _p, _a)			\
>  do {							\
> @@ -96,7 +118,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	char buf[BUF_SIZE];
>  	int ret = 0;
>  
> -	PRINT_ATTRf(type, p_unsigned);
> +	PRINT_ATTRn("type", type, p_type_id, true);
>  	PRINT_ATTRf(size, p_unsigned);
>  	PRINT_ATTRf(config, p_hex);
>  	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);

