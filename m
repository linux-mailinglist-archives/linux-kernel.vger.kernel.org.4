Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822C7005B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjELKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbjELKet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:34:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322AD124B8;
        Fri, 12 May 2023 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683887658; x=1715423658;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZU/MmfGodK1m2NfiqWv3lm7ziPRtmRmhkxTgL6YBjT8=;
  b=HTTtWlvMJcdqzPyEg9+se3gsqG1NENr5RmzLna9YZCvLAy5Tz8RjeluS
   BNEAjiK5LQDXUFRO4q7ALjYlqJN06eSa+wsqkAASzTQDHsGmVNN1g0O0v
   DfUZEfV9hkF+lTfZg5NlMeO/A8MPxf1BKjLO3Gi1Mh68aJxtIoCF1eyAM
   jkH5ro3FmOvr/NcbYl0K9kBXYcPtZuZF9LbgjcMbNN4wq/zjupE0KcWF2
   EE9zIok0FCOnKM0O0q0aXiuDy/OXHs+Bydu7IAdVZPkPaMj3TIUD3arAa
   oCNI9oH/uM88fNVeiuZGE56UorgrhdTsf9OBbPXhx8g8b5sMWnQBnZQOg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335278772"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335278772"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="765136418"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765136418"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:34:10 -0700
Message-ID: <0be18c9a-ab56-021f-5c51-8b066ead2e1c@intel.com>
Date:   Fri, 12 May 2023 13:34:06 +0300
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230511075154.240163-4-yangjihong1@huawei.com>
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
> When printing perf_event_attr, always display perf_event_attr type and its symbol
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
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/perf_event_attr_fprintf.c | 30 ++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 433029c6afc5..cd0905d8cb7a 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -71,6 +71,33 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>  	__p_bits(buf, size, value, bits);
>  }
>  
> +#define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
> +static const char *stringify_perf_type_id(u64 value)
> +{
> +	/* sync with enum perf_type_id in perf_event.h */

Everything in this file syncs with perf_event.h, so the comment
does not seem very useful.

> +	switch (value) {
> +	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
> +	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
> +	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
> +	ENUM_ID_TO_STR_CASE(PERF_TYPE_HW_CACHE)
> +	ENUM_ID_TO_STR_CASE(PERF_TYPE_RAW)
> +	ENUM_ID_TO_STR_CASE(PERF_TYPE_BREAKPOINT)
> +	default:
> +		return NULL;
> +	}
> +}
> +#undef ENUM_ID_TO_STR_CASE
> +
> +static void __p_type_id(char *buf, size_t size, u64 value)
> +{
> +	const char *str = stringify_perf_type_id(value);
> +
> +	if (str == NULL)
> +		snprintf(buf, size, "%"PRIu64, value);
> +	else
> +		snprintf(buf, size, "%"PRIu64" (%s)", value, str);

These 4 lines end up getting used again about 3 times in the next
patch, so might as well be a separate function e.g.

	print_id(buf, size, value, stringify_perf_type_id(value));

where:

static void print_id(char *buf, size_t size, u64 value, const char *str)
{
	if (str == NULL)
		snprintf(buf, size, "%"PRIu64, value);
	else
		snprintf(buf, size, "%"PRIu64" (%s)", value, str);
}

> +}
> +
>  #define BUF_SIZE		1024
>  
>  #define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
> @@ -79,6 +106,7 @@ static void __p_read_format(char *buf, size_t size, u64 value)
>  #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
>  #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
>  #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
> +#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
>  
>  #define PRINT_ATTRn(_n, _f, _p, _a)			\
>  do {							\
> @@ -96,7 +124,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	char buf[BUF_SIZE];
>  	int ret = 0;
>  
> -	PRINT_ATTRf(type, p_unsigned);
> +	PRINT_ATTRn("type", type, p_type_id, true);
>  	PRINT_ATTRf(size, p_unsigned);
>  	PRINT_ATTRf(config, p_hex);
>  	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);

