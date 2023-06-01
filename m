Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B9719F44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjFAOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjFAOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:10:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B3418C;
        Thu,  1 Jun 2023 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685628618; x=1717164618;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2Jpl4eeMSoSEkZ4Th8BbacNT4nNu8tN7QxDUgpUODPw=;
  b=EnDA12LVswOghKD2S7z9escl0CKob7y3Yl5k1vtFvd5QEOOX8FcEdDXM
   zwolbGWl+4H1IiehEqHJbgFG/Pl+JjHdXZQrpPRbZmlSCZ0madYf5Ei4l
   1kP7DM2uQl8yTg+Du+Ic15NbgLxxw9+pmCEIwBmmYn7bLc1OboZ2oH4Ps
   10P1/IMchnqh2/SwNG1ma0BymYrsYM5jIv61EnEsU77QXc8EbNK3KYqrJ
   6xzXzzhJDeIYYkHXYf+SLeO/JNlVdihSpcM0pRbF8j1qIdEny19Cz1ZQr
   qlK6y6Vd/N83regDDQFHTE4m2RqmX9PpCKLDzpFWj4AWdxp7qolT1d798
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340180064"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="340180064"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="954077444"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="954077444"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 06:52:52 -0700
Received: from [10.212.129.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.129.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 526BB58088B;
        Thu,  1 Jun 2023 06:52:50 -0700 (PDT)
Message-ID: <805fb940-bb0f-5a76-516b-daf88f74022b@linux.intel.com>
Date:   Thu, 1 Jun 2023 09:52:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/4] perf parse-events: Wildcard most "numeric" events
Content-Language: en-US
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
References: <20230601082954.754318-1-irogers@google.com>
 <20230601082954.754318-4-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230601082954.754318-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-01 4:29 a.m., Ian Rogers wrote:
> Numeric events are either raw events or those with ABI defined numbers
> matched by the lexer. PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events
> should wildcard match on hybrid systems. So "cycles" should match each
> PMU type with an extended type, not just PERF_TYPE_HARDWARE.
> 
> Change wildcard matching to add the event even if wildcard PMU
> scanning fails, there will be no extended type but this best matches
> previous behavior.
> 
> Only set the extended type when the event type supports it and when
> perf_pmus__supports_extended_type is true. This new function returns
> true if >1 core PMU and avoids potential errors on older kernels.
> 
> Modify evsel__compute_group_pmu_name using a helper
> perf_pmu__is_software to determine when grouping should occur. Try to
> use PMUs, and evsel__find_pmu, as being more dependable than
> evsel->pmu_name.

Besides, now we have annotation for the software event. Nice change!

Before,

 # ./perf_old stat -e 'data_read,task-clock' --no-merge -a sleep 1

 Performance counter stats for 'system wide':

             47.76 MiB  data_read [uncore_imc_free_running_1] #    1.487
/sec
             62.18 MiB  data_read [uncore_imc_free_running_0] #    1.935
/sec
         32,126.54 msec task-clock                       #   31.993 CPUs
utilized

       1.004167354 seconds time elapsed


Now,

 # ./perf stat -e 'data_read,task-clock' --no-merge -a sleep 1

 Performance counter stats for 'system wide':

             43.28 MiB  data_read [uncore_imc_free_running_1] #    1.347
/sec
             57.74 MiB  data_read [uncore_imc_free_running_0] #    1.797
/sec
         32,129.62 msec task-clock [software]            #   31.999 CPUs
utilized

       1.004094315 seconds time elapsed


Thanks,
Kan
> 
> Set a parse events error if a hardware term's PMU lookup fails, to
> provide extra diagnostics.
> 
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Fixes: 8bc75f699c14 ("perf parse-events: Support wildcards on raw events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 104 +++++++++++++++++++++++----------
>  tools/perf/util/parse-events.y |  10 ++--
>  tools/perf/util/pmu.c          |  16 +++++
>  tools/perf/util/pmu.h          |   5 ++
>  tools/perf/util/pmus.c         |   5 ++
>  tools/perf/util/pmus.h         |   1 +
>  6 files changed, 106 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 7f047ac11168..26979a47f4ac 100644
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
> @@ -1989,8 +2002,22 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
>  {
>  	struct evsel *leader = evsel__leader(evsel);
>  	struct evsel *pos;
> -	const char *group_pmu_name = evsel->pmu_name ?: "cpu";
> +	const char *group_pmu_name;
> +	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>  
> +	if (!pmu) {
> +		/*
> +		 * For PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE types the PMU
> +		 * is a core PMU, but in heterogeneous systems this is
> +		 * unknown. For now pick the first core PMU.
> +		 */
> +		pmu = perf_pmus__scan_core(NULL);
> +	}
> +	if (!pmu) {
> +		pr_debug("No PMU found for '%s'", evsel__name(evsel));
> +		return -EINVAL;
> +	}
> +	group_pmu_name = pmu->name;
>  	/*
>  	 * Software events may be in a group with other uncore PMU events. Use
>  	 * the pmu_name of the first non-software event to avoid breaking the
> @@ -1999,24 +2026,41 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
>  	 * Aux event leaders, like intel_pt, expect a group with events from
>  	 * other PMUs, so substitute the AUX event's PMU in this case.
>  	 */
> -	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
> +	if (perf_pmu__is_software(pmu) || evsel__is_aux_event(leader)) {
> +		struct perf_pmu *leader_pmu = evsel__find_pmu(leader);
> +
> +		if (!leader_pmu) {
> +			/* As with determining pmu above. */
> +			leader_pmu = perf_pmus__scan_core(NULL);
> +		}
>  		/*
>  		 * Starting with the leader, find the first event with a named
> -		 * PMU. for_each_group_(member|evsel) isn't used as the list
> -		 * isn't yet sorted putting evsel's in the same group together.
> +		 * non-software PMU. for_each_group_(member|evsel) isn't used as
> +		 * the list isn't yet sorted putting evsel's in the same group
> +		 * together.
>  		 */
> -		if (leader->pmu_name) {
> -			group_pmu_name = leader->pmu_name;
> +		if (leader_pmu && !perf_pmu__is_software(leader_pmu)) {
> +			group_pmu_name = leader_pmu->name;
>  		} else if (leader->core.nr_members > 1) {
>  			list_for_each_entry(pos, head, core.node) {
> -				if (evsel__leader(pos) == leader && pos->pmu_name) {
> -					group_pmu_name = pos->pmu_name;
> +				struct perf_pmu *pos_pmu;
> +
> +				if (pos == leader || evsel__leader(pos) != leader)
> +					continue;
> +				pos_pmu = evsel__find_pmu(pos);
> +				if (!pos_pmu) {
> +					/* As with determining pmu above. */
> +					pos_pmu = perf_pmus__scan_core(NULL);
> +				}
> +				if (pos_pmu && !perf_pmu__is_software(pos_pmu)) {
> +					group_pmu_name = pos_pmu->name;
>  					break;
>  				}
>  			}
>  		}
>  	}
> -	evsel->group_pmu_name = strdup(group_pmu_name);
> +	/* Assign the actual name taking care that the fake PMU lacks a name. */
> +	evsel->group_pmu_name = strdup(group_pmu_name ?: "fake");
>  	return evsel->group_pmu_name ? 0 : -ENOMEM;
>  }
>  
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index abd6ab460e12..f96afb0edd0c 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -445,11 +445,11 @@ value_sym '/' event_config '/'
>  	int type = $1 >> 16;
>  	int config = $1 & 255;
>  	int err;
> +	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
>  
>  	list = alloc_list();
>  	ABORT_ON(!list);
> -	err = parse_events_add_numeric(_parse_state, list, type, config, $3,
> -				       /*wildcard=*/false);
> +	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
>  	parse_events_terms__delete($3);
>  	if (err) {
>  		free_list_evsel(list);
> @@ -463,12 +463,12 @@ value_sym sep_slash_slash_dc
>  	struct list_head *list;
>  	int type = $1 >> 16;
>  	int config = $1 & 255;
> +	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
>  
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
> -					  /*head_config=*/NULL,
> -					  /*wildcard=*/false));
> +					  /*head_config=*/NULL, wildcard));
>  	$$ = list;
>  }
>  |
> @@ -635,7 +635,7 @@ PE_RAW opt_event_config
>  	ABORT_ON(errno);
>  	free($1);
>  	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, num, $2,
> -				       /*wildcard=*/true);
> +				       /*wildcard=*/false);
>  	parse_events_terms__delete($2);
>  	if (err) {
>  		free(list);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 36e163f38368..1dd44b2f73f3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1438,6 +1438,22 @@ bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
>  	return false;
>  }
>  
> +bool perf_pmu__is_software(const struct perf_pmu *pmu)
> +{
> +	if (pmu->is_core || pmu->is_uncore || pmu->auxtrace)
> +		return false;
> +	switch (pmu->type) {
> +	case PERF_TYPE_HARDWARE:	return false;
> +	case PERF_TYPE_SOFTWARE:	return true;
> +	case PERF_TYPE_TRACEPOINT:	return true;
> +	case PERF_TYPE_HW_CACHE:	return false;
> +	case PERF_TYPE_RAW:		return false;
> +	case PERF_TYPE_BREAKPOINT:	return true;
> +	default: break;
> +	}
> +	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
> +}
> +
>  FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
>  {
>  	char path[PATH_MAX];
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 287f593b15c7..13a9a893e665 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -224,6 +224,11 @@ bool is_pmu_core(const char *name);
>  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
>  bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
>  bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
> +/**
> + * perf_pmu_is_software - is the PMU a software PMU as in it uses the
> + *                        perf_sw_context in the kernel?
> + */
> +bool perf_pmu__is_software(const struct perf_pmu *pmu);
>  
>  FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
>  FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name);
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
