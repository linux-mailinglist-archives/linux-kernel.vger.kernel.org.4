Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFD6EF1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjDZKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:11:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64D4C3C1F;
        Wed, 26 Apr 2023 03:11:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5874B3;
        Wed, 26 Apr 2023 03:12:37 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8AB3F5A1;
        Wed, 26 Apr 2023 03:11:49 -0700 (PDT)
Message-ID: <6396e5dc-bf53-ce0d-15ea-0a1aedecf691@arm.com>
Date:   Wed, 26 Apr 2023 11:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 21/40] perf parse-events: Wildcard legacy cache events
To:     Ian Rogers <irogers@google.com>
References: <20230426070050.1315519-1-irogers@google.com>
 <20230426070050.1315519-22-irogers@google.com>
Content-Language: en-US
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230426070050.1315519-22-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/04/2023 08:00, Ian Rogers wrote:
> It is inconsistent that "perf stat -e instructions-retired" wildcard
> opens on all PMUs while legacy cache events like "perf stat -e
> L1-dcache-load-miss" do not. A behavior introduced by hybrid is that a
> legacy cache event like L1-dcache-load-miss should wildcard open on
> all hybrid PMUs. A call to is_event_supported is necessary for each
> PMU, a failure of which results in the event not being added. Rather
> than special case that logic, move it into the main legacy cache event
> case and attempt to open legacy cache events on all PMUs.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events-hybrid.c | 33 -------------
>  tools/perf/util/parse-events-hybrid.h |  7 ---
>  tools/perf/util/parse-events.c        | 70 ++++++++++++++-------------
>  tools/perf/util/parse-events.h        |  3 +-
>  tools/perf/util/parse-events.y        |  2 +-
>  5 files changed, 39 insertions(+), 76 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
> index 7c9f9150bad5..d2c0be051d46 100644
> --- a/tools/perf/util/parse-events-hybrid.c
> +++ b/tools/perf/util/parse-events-hybrid.c
> @@ -179,36 +179,3 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
>  	return add_raw_hybrid(parse_state, list, attr, name, metric_id,
>  			      config_terms);
>  }
> -
> -int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
> -				   struct perf_event_attr *attr,
> -				   const char *name,
> -				   const char *metric_id,
> -				   struct list_head *config_terms,
> -				   bool *hybrid,
> -				   struct parse_events_state *parse_state)
> -{
> -	struct perf_pmu *pmu;
> -	int ret;
> -
> -	*hybrid = false;
> -	if (!perf_pmu__has_hybrid())
> -		return 0;
> -
> -	*hybrid = true;
> -	perf_pmu__for_each_hybrid_pmu(pmu) {
> -		LIST_HEAD(terms);
> -
> -		if (pmu_cmp(parse_state, pmu))
> -			continue;
> -
> -		copy_config_terms(&terms, config_terms);
> -		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
> -					  attr, name, metric_id, &terms, pmu);
> -		free_config_terms(&terms);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
> index cbc05fec02a2..bc2966e73897 100644
> --- a/tools/perf/util/parse-events-hybrid.h
> +++ b/tools/perf/util/parse-events-hybrid.h
> @@ -15,11 +15,4 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
>  				     struct list_head *config_terms,
>  				     bool *hybrid);
>  
> -int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
> -				   struct perf_event_attr *attr,
> -				   const char *name, const char *metric_id,
> -				   struct list_head *config_terms,
> -				   bool *hybrid,
> -				   struct parse_events_state *parse_state);
> -
>  #endif /* __PERF_PARSE_EVENTS_HYBRID_H */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9b2d7b6572c2..e007b2bc1ab4 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -471,46 +471,50 @@ static int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u
>  
>  int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  			   struct parse_events_error *err,
> -			   struct list_head *head_config,
> -			   struct parse_events_state *parse_state)
> +			   struct list_head *head_config)
>  {
> -	struct perf_event_attr attr;
> -	LIST_HEAD(config_terms);
> -	const char *config_name, *metric_id;
> -	int ret;
> -	bool hybrid;
> +	struct perf_pmu *pmu = NULL;
> +	bool found_supported = false;
> +	const char *config_name = get_config_name(head_config);
> +	const char *metric_id = get_config_metric_id(head_config);
>  
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		LIST_HEAD(config_terms);
> +		struct perf_event_attr attr;
> +		int ret;
>  
> -	memset(&attr, 0, sizeof(attr));
> -	attr.type = PERF_TYPE_HW_CACHE;
> -	ret = parse_events__decode_legacy_cache(name, /*pmu_type=*/0, &attr.config);
> -	if (ret)
> -		return ret;
> +		/*
> +		 * Skip uncore PMUs for performance. Software PMUs can open
> +		 * PERF_TYPE_HW_CACHE, so skip.
> +		 */
> +		if (pmu->is_uncore || pmu->type == PERF_TYPE_SOFTWARE)
> +			continue;
>  
> -	if (head_config) {
> -		if (config_attr(&attr, head_config, err,
> -				config_term_common))
> -			return -EINVAL;
> +		memset(&attr, 0, sizeof(attr));
> +		attr.type = PERF_TYPE_HW_CACHE;
>  
> -		if (get_config_terms(head_config, &config_terms))
> -			return -ENOMEM;
> -	}
> +		ret = parse_events__decode_legacy_cache(name, pmu->type, &attr.config);
> +		if (ret)
> +			return ret;
>  
> -	config_name = get_config_name(head_config);
> -	metric_id = get_config_metric_id(head_config);
> -	ret = parse_events__add_cache_hybrid(list, idx, &attr,
> -					     config_name ? : name,
> -					     metric_id,
> -					     &config_terms,
> -					     &hybrid, parse_state);
> -	if (hybrid)
> -		goto out_free_terms;
> +		if (!is_event_supported(PERF_TYPE_HW_CACHE, attr.config))
> +			continue;

Hi Ian,

I get a test failure on Arm from this commit. I think it's related to
this check for support that's failing but I'm not sure what the
resolution should be. I also couldn't see why the metrics in
test_soc/cpu/metrics.json aren't run on x86 (assuming they're generic
'test anywhere' type metrics?).

  $ perf test -vvv "parsing of PMU event table metrics with fake"
  ...
  parsing 'dcache_miss_cpi': 'l1d\-loads\-misses / inst_retired.any'
  parsing metric: l1d\-loads\-misses / inst_retired.any
  Attempting to add event pmu 'inst_retired.any' with
'inst_retired.any,' that may result in non-fatal errors
  After aliases, add event pmu 'inst_retired.any' with
'inst_retired.any,' that may result in non-fatal errors
  inst_retired.any -> fake_pmu/inst_retired.any/
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    config                           0x800010000
    disabled                         1
  ------------------------------------------------------------
  sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -2

  check_parse_fake failed
  test child finished with -1
  ---- end ----
  PMU events subtest 4: FAILED!

>  
> -	ret = add_event(list, idx, &attr, config_name ? : name, metric_id,
> -			&config_terms);
> -out_free_terms:
> -	free_config_terms(&config_terms);
> -	return ret;
> +		found_supported = true;
> +
> +		if (head_config) {
> +			if (config_attr(&attr, head_config, err,
> +						config_term_common))
> +				return -EINVAL;
> +
> +			if (get_config_terms(head_config, &config_terms))
> +				return -ENOMEM;
> +		}
> +
> +		ret = add_event(list, idx, &attr, config_name ? : name, metric_id, &config_terms);
> +		free_config_terms(&config_terms);
> +	}
> +	return found_supported ? 0: -EINVAL;
>  }
>  
>  #ifdef HAVE_LIBTRACEEVENT
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 5acb62c2e00a..0c26303f7f63 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -172,8 +172,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
>  			  int tool_event);
>  int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  			   struct parse_events_error *error,
> -			   struct list_head *head_config,
> -			   struct parse_events_state *parse_state);
> +			   struct list_head *head_config);
>  int parse_events_add_breakpoint(struct list_head *list, int *idx,
>  				u64 addr, char *type, u64 len);
>  int parse_events_add_pmu(struct parse_events_state *parse_state,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index f84fa1b132b3..cc7528558845 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -476,7 +476,7 @@ PE_LEGACY_CACHE opt_event_config
>  
>  	list = alloc_list();
>  	ABORT_ON(!list);
> -	err = parse_events_add_cache(list, &parse_state->idx, $1, error, $2, parse_state);
> +	err = parse_events_add_cache(list, &parse_state->idx, $1, error, $2);
>  
>  	parse_events_terms__delete($2);
>  	free($1);
