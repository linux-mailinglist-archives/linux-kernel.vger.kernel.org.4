Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477A71844B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjEaOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjEaOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:09:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8753A8B;
        Wed, 31 May 2023 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685541915; x=1717077915;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9oj9OVIZrrio0hUJYCC5uHeMR+W81584CZSMzTBezJM=;
  b=ObYxJR0/gtnYbE1kI9pGK0wQ4njNalJxexThDBHUN5iW9vwy/NjhDbXv
   7a75aV2TQIvh+RQ7zTm2qHhRVnJ8UwEJFTra2B++hYdkmD61IfXlEWUrI
   dsax+rFvYDgwC+av6mpIRC5CnXwPkriUfFmS48EPIuq4KrOAH+8UkIRAi
   6SOW/AvAXlz/57dSEHZHLiTwq7T/i+f/dJ19Tb9UeSvW+NIhnl+cPS2sy
   ooZdlqKUGAQS2DSEvx08pzzSqQ15xPRb5BBBu8Z1qyfOSIhmRk8Gksrfn
   xENFFIj59GovjnDRsI6ygkQ2e46WrM5IG9OC6wRLVYEglX8p2c2LLdTxw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421013116"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="421013116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 07:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="819319322"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="819319322"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2023 07:03:31 -0700
Received: from [10.251.1.76] (kliang2-mobl1.ccr.corp.intel.com [10.251.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5207E580D1F;
        Wed, 31 May 2023 07:03:29 -0700 (PDT)
Message-ID: <e9528b08-4d35-b01f-f3e7-861d92224f9c@linux.intel.com>
Date:   Wed, 31 May 2023 10:03:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] perf parse-events: Wildcard most "numeric" events
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20230530232730.155084-1-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230530232730.155084-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-30 7:27 p.m., Ian Rogers wrote:
> Numeric events are either raw events or those with ABI defined numbers
> matched by the lexer. All raw events that don't specify a PMU type
> should wildcard match on hybrid systems. So "cycles" should match each
> PMU type with an extended type, not just PERF_TYPE_HARDWARE.
> 
> Change wildcard matching to add the event if wildcard PMU scanning
> fails, there will be no extended type but this best matches previous
> behavior.
> 
> Only set the extended type when the event type supports it and when
> perf_pmus__supports_extended_type is true. This new function returns
> true if >1 core PMU and avoids potential errors on older kernels.
> 
> Try to always pass a PMU for parse_events_add_numeric, update
> evsel__compute_group_pmu_name as software events will have a PMU and
> pmu_name rather than NULL. This makes homogeneous and heterogeneous
> PMU events more similar.
> 
> Set a parse events error if a hardware term's PMU lookup fails to
> provide extra diagnostics.

I think the patch tries to fix two issues on hybrid.
- Perf fails to create hardware events for each core PMU when the PMU
type is not specified.
- When splitting a group with multiple PMUs, SW events should be created
for each new sub-groups.

It works well for the first issue:
Before

# perf_old stat -e cycles ./hybrid.sh

 Performance counter stats for './hybrid.sh':

       420,833,619      cycles

       1.219129587 seconds time elapsed

With the patch

# perf stat -e cycles ./hybrid.sh

 Performance counter stats for './hybrid.sh':

       420,691,729      cpu_core/cycles/
       613,038,584      cpu_atom/cycles/
                       (98.47%)

       1.219057759 seconds time elapsed


For the second issue, the new behavior doesn't seem correct for me.

Before

./perf_old stat -e '{data_read,faults}' --no-merge -a sleep 1
WARNING: events were regrouped to match PMUs
WARNING: grouped events cpus do not match.
Events with CPUs not matching the leader will be removed from the group.
  anon group { data_read, faults }

 Performance counter stats for 'system wide':

             70.05 MiB  data_read [uncore_imc_free_running_0]
             55.82 MiB  data_read [uncore_imc_free_running_1]
                77      faults

       1.004216885 seconds time elapsed


With the patch

# ./perf stat -e '{data_read,faults}' --no-merge -a sleep 1
WARNING: events were regrouped to match PMUs
WARNING: grouped events cpus do not match.
Events with CPUs not matching the leader will be removed from the group.
  anon group { data_read, faults, faults }

 Performance counter stats for 'system wide':

             53.51 MiB  data_read [uncore_imc_free_running_0]
             39.04 MiB  data_read [uncore_imc_free_running_1]
                76      cpu_core/faults/
                 2      cpu_atom/faults/


The faults is a SW event, but with a core PMU prefix. I think it's wrong.

According to the -vvv information, the faults doesn't seem be regrouped
with any uncore events.

perf_event_attr:
  type                             1
  size                             136
  config                           0x2
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 5
------------------------------------------------------------

For the second issue, can we make the behavior unchanged for now?



BTW: It seems the current perf-tools-next branch has another regression
for the JSON event. The inst_retired.any should be available for both
atom and core. I believe I tried the below commands several days ago.
But it does't work now. I will check when the regression was introduced.

# ./perf stat -e inst_retired.any ./hybrid.sh

 Performance counter stats for './hybrid.sh':

     3,261,510,386      cpu_core/inst_retired.any/
                       (99.07%)

       1.218858763 seconds time elapsed


Thanks,
Kan

> 
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Fixes: 8bc75f699c14 ("perf parse-events: Support wildcards on raw events")
> Signed-off-by: Ian Rogers <irogers@google.com>> ---
>  tools/perf/util/parse-events.c | 71 +++++++++++++++++++++-------------
>  tools/perf/util/parse-events.y |  4 +-
>  tools/perf/util/pmus.c         |  5 +++
>  tools/perf/util/pmus.h         |  1 +
>  4 files changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 7f047ac11168..58c9f34bcd95 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -372,7 +372,7 @@ static int config_attr(struct perf_event_attr *attr,
>   *                                     contain hyphens and the longest name
>   *                                     should always be selected.
>   */
> -int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config)
> +int parse_events__decode_legacy_cache(const char *name, int extended_pmu_type, __u64 *config)
>  {
>  	int len, cache_type = -1, cache_op = -1, cache_result = -1;
>  	const char *name_end = &name[strlen(name) + 1];
> @@ -423,8 +423,9 @@ int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *con
>  	if (cache_result == -1)
>  		cache_result = PERF_COUNT_HW_CACHE_RESULT_ACCESS;
>  
> -	*config = ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT) |
> -		cache_type | (cache_op << 8) | (cache_result << 16);
> +	*config = cache_type | (cache_op << 8) | (cache_result << 16);
> +	if (perf_pmus__supports_extended_type())
> +		*config |= (__u64)extended_pmu_type << PERF_PMU_TYPE_SHIFT;
>  	return 0;
>  }
>  
> @@ -1204,11 +1205,17 @@ static int config_term_pmu(struct perf_event_attr *attr,
>  		const struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
>  
>  		if (!pmu) {
> -			pr_debug("Failed to find PMU for type %d", attr->type);
> +			char *err_str;
> +
> +			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
> +				parse_events_error__handle(err, term->err_term,
> +							   err_str, /*help=*/NULL);
>  			return -EINVAL;
>  		}
>  		attr->type = PERF_TYPE_HARDWARE;
> -		attr->config = ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT) | term->val.num;
> +		attr->config = term->val.num;
> +		if (perf_pmus__supports_extended_type())
> +			attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
>  		return 0;
>  	}
>  	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
> @@ -1435,8 +1442,8 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
>  
>  static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>  				struct list_head *list,
> -				struct perf_pmu *pmu, u32 type, u64 config,
> -				struct list_head *head_config)
> +				struct perf_pmu *pmu, u32 type, u32 extended_type,
> +				u64 config, struct list_head *head_config)
>  {
>  	struct perf_event_attr attr;
>  	LIST_HEAD(config_terms);
> @@ -1446,6 +1453,10 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
>  	memset(&attr, 0, sizeof(attr));
>  	attr.type = type;
>  	attr.config = config;
> +	if (extended_type && (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)) {
> +		assert(perf_pmus__supports_extended_type());
> +		attr.config |= (u64)extended_type << PERF_PMU_TYPE_SHIFT;
> +	};
>  
>  	if (head_config) {
>  		if (config_attr(&attr, head_config, parse_state->error,
> @@ -1474,24 +1485,26 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  	struct perf_pmu *pmu = NULL;
>  	bool found_supported = false;
>  
> -	if (!wildcard)
> -		return __parse_events_add_numeric(parse_state, list, /*pmu=*/NULL,
> -						  type, config, head_config);
> -
>  	/* Wildcards on numeric values are only supported by core PMUs. */
> -	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> -		int ret;
> +	if (wildcard && perf_pmus__supports_extended_type()) {
> +		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +			int ret;
>  
> -		if (parse_events__filter_pmu(parse_state, pmu))
> -			continue;
> +			found_supported = true;
> +			if (parse_events__filter_pmu(parse_state, pmu))
> +				continue;
>  
> -		found_supported = true;
> -		ret = __parse_events_add_numeric(parse_state, list, pmu, pmu->type,
> -						 config, head_config);
> -		if (ret)
> -			return ret;
> +			ret = __parse_events_add_numeric(parse_state, list, pmu,
> +							 type, pmu->type,
> +							 config, head_config);
> +			if (ret)
> +				return ret;
> +		}
> +		if (found_supported)
> +			return 0;
>  	}
> -	return found_supported ? 0 : -EINVAL;
> +	return __parse_events_add_numeric(parse_state, list, perf_pmus__find_by_type(type),
> +					type, /*extended_type=*/0, config, head_config);
>  }
>  
>  int parse_events_add_tool(struct parse_events_state *parse_state,
> @@ -1989,7 +2002,10 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
>  {
>  	struct evsel *leader = evsel__leader(evsel);
>  	struct evsel *pos;
> -	const char *group_pmu_name = evsel->pmu_name ?: "cpu";
> +	const char *group_pmu_name = "cpu";
> +
> +	if (evsel->core.attr.type != PERF_TYPE_SOFTWARE && evsel->pmu_name)
> +		group_pmu_name = evsel->pmu_name;
>  
>  	/*
>  	 * Software events may be in a group with other uncore PMU events. Use
> @@ -2002,14 +2018,17 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
>  	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
>  		/*
>  		 * Starting with the leader, find the first event with a named
> -		 * PMU. for_each_group_(member|evsel) isn't used as the list
> -		 * isn't yet sorted putting evsel's in the same group together.
> +		 * non-software PMU. for_each_group_(member|evsel) isn't used as
> +		 * the list isn't yet sorted putting evsel's in the same group
> +		 * together.
>  		 */
> -		if (leader->pmu_name) {
> +		if (leader->pmu_name && leader->core.attr.type != PERF_TYPE_SOFTWARE) {
>  			group_pmu_name = leader->pmu_name;
>  		} else if (leader->core.nr_members > 1) {
>  			list_for_each_entry(pos, head, core.node) {
> -				if (evsel__leader(pos) == leader && pos->pmu_name) {
> +				if (evsel__leader(pos) == leader &&
> +				    pos->core.attr.type != PERF_TYPE_SOFTWARE &&
> +				    pos->pmu_name) {
>  					group_pmu_name = pos->pmu_name;
>  					break;
>  				}
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index abd6ab460e12..48c21314cf6b 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -449,7 +449,7 @@ value_sym '/' event_config '/'
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_numeric(_parse_state, list, type, config, $3,
> -				       /*wildcard=*/false);
> +				       /*wildcard=*/true);
>  	parse_events_terms__delete($3);
>  	if (err) {
>  		free_list_evsel(list);
> @@ -468,7 +468,7 @@ value_sym sep_slash_slash_dc
>  	ABORT_ON(!list);
>  	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
>  					  /*head_config=*/NULL,
> -					  /*wildcard=*/false));
> +					  /*wildcard=*/true));
>  	$$ = list;
>  }
>  |
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 53f11f6ce878..e1d0a93147e5 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -477,6 +477,11 @@ int perf_pmus__num_core_pmus(void)
>  	return count;
>  }
>  
> +bool perf_pmus__supports_extended_type(void)
> +{
> +	return perf_pmus__num_core_pmus() > 1;
> +}
> +
>  struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
>  {
>  	struct perf_pmu *pmu = evsel->pmu;
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 1e710720aec7..d02ffea5d3a4 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -19,5 +19,6 @@ int perf_pmus__num_mem_pmus(void);
>  void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
>  bool perf_pmus__have_event(const char *pname, const char *name);
>  int perf_pmus__num_core_pmus(void);
> +bool perf_pmus__supports_extended_type(void);
>  
>  #endif /* __PMUS_H */
