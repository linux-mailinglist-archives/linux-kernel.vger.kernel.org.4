Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2080B6B3754
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCJH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCJH32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:29:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FABED682;
        Thu,  9 Mar 2023 23:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678433366; x=1709969366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3acrxVcXEZ7RFojJ4IdzqShvIY6+neDDulnIrxE90lc=;
  b=XHb6kADXnbL9JFkYOGtj5I8wjHSXrJDnmqs7xLI2+NmlnhkQG6fBuGmB
   QkBAeKd71qj0rpMtt1eNJRczo5mJtwCmJmzWxOtVwOG/t8pfN+vYZm+W0
   UYaPr7V/gpr2wZiSabpuZzH0Kg6Aj6Oh+XrtnWIlyMBxmWBi4thDGS5Vv
   aGlNBhkqD4JTIUVAG2lSh7f3uF8RlawmrselyZnNh4JMT4ftLXl5oHC6H
   De5+8YEbkIb0+Z8KSj/V6vJpKrpFTvlQk5TEQnF1xZX75t7BHipFEBTbt
   MP4rEDQ4pmEVuV+2BVfbAKK2fQHTrs/Y55Vao5I+Ad8s7u7tsm5DcRbht
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="422935731"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="422935731"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:29:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923562634"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923562634"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:29:20 -0800
Message-ID: <fd1f74e0-718c-5745-c224-5f4cee2ac2b2@intel.com>
Date:   Fri, 10 Mar 2023 09:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 11/11] perf parse-events: Warn when events are
 regrouped
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20230308225912.1960990-1-irogers@google.com>
 <20230308225912.1960990-12-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230308225912.1960990-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/03/23 00:59, Ian Rogers wrote:
> Use if an event is reordered or the number of groups increases to
> signal that regrouping has happened and warn about it. Disable the
> warning in the case wild card PMU names are used and for metrics.

The new warning seems to happen no matter what the order
in some cases e.g.

$ perf record -e branch-misses//u -e cycles:u  -- uname
WARNING: events were regrouped to match PMUs
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.004 MB perf.data (11 samples) ]

$ perf record -e cycles:u -e branch-misses//u -- uname
WARNING: events were regrouped to match PMUs
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.005 MB perf.data (16 samples) ]

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/parse-events.c |  2 +-
>  tools/perf/tests/pmu-events.c   |  2 +-
>  tools/perf/util/metricgroup.c   |  3 ++-
>  tools/perf/util/parse-events.c  | 28 ++++++++++++++++++++--------
>  tools/perf/util/parse-events.h  |  7 ++++---
>  tools/perf/util/parse-events.y  |  1 +
>  6 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index ffa6f0a90741..b1c2f0a20306 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2103,7 +2103,7 @@ static int test_event_fake_pmu(const char *str)
>  
>  	parse_events_error__init(&err);
>  	perf_pmu__test_parse_init();
> -	ret = __parse_events(evlist, str, &err, &perf_pmu__fake);
> +	ret = __parse_events(evlist, str, &err, &perf_pmu__fake, /*warn_if_reordered=*/true);
>  	if (ret) {
>  		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
>  			 str, ret, err.str);
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 6ccd413b5983..7f8e86452527 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -785,7 +785,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
>  		 */
>  		perf_pmu__test_parse_init();
>  	}
> -	ret = __parse_events(evlist, dup, error, fake_pmu);
> +	ret = __parse_events(evlist, dup, error, fake_pmu, /*warn_if_reordered=*/true);
>  	free(dup);
>  
>  	evlist__delete(evlist);
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index de6dd527a2ba..5783f4c2d1ef 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1441,7 +1441,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
>  	}
>  	pr_debug("Parsing metric events '%s'\n", events.buf);
>  	parse_events_error__init(&parse_error);
> -	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
> +	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu,
> +			     /*warn_if_reordered=*/false);
>  	if (ret) {
>  		parse_events_error__print(&parse_error, events.buf);
>  		goto err_out;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9ec3c1dc81e0..4bb28c32b511 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2157,11 +2157,13 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
>  	return arch_evlist__cmp(lhs, rhs);
>  }
>  
> -static void parse_events__sort_events_and_fix_groups(struct list_head *list)
> +static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
>  {
>  	int idx = -1;
>  	struct evsel *pos, *cur_leader = NULL;
>  	struct perf_evsel *cur_leaders_grp = NULL;
> +	bool idx_changed = false;
> +	int orig_num_leaders = 0, num_leaders = 0;
>  
>  	/*
>  	 * Compute index to insert ungrouped events at. Place them where the
> @@ -2170,11 +2172,11 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
>  	list_for_each_entry(pos, list, core.node) {
>  		const struct evsel *pos_leader = evsel__leader(pos);
>  
> -		if (pos != pos_leader || pos->core.nr_members > 1)
> -			continue;
> +		if (pos == pos_leader)
> +			orig_num_leaders++;
>  
> -		idx = pos->core.idx;
> -		break;
> +		if (idx == -1 && pos == pos_leader && pos->core.nr_members < 2)
> +			idx = pos->core.idx;
>  	}
>  
>  	/* Sort events. */
> @@ -2192,6 +2194,8 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		bool force_grouped = arch_evsel__must_be_in_group(pos);
>  
>  		/* Reset index and nr_members. */
> +		if (pos->core.idx != idx)
> +			idx_changed = true;
>  		pos->core.idx = idx++;
>  		pos->core.nr_members = 0;
>  
> @@ -2225,12 +2229,18 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		}
>  	}
>  	list_for_each_entry(pos, list, core.node) {
> -		pos->core.leader->nr_members++;
> +		struct evsel *pos_leader = evsel__leader(pos);
> +
> +		if (pos == pos_leader)
> +			num_leaders++;
> +		pos_leader->core.nr_members++;
>  	}
> +	return idx_changed || num_leaders != orig_num_leaders;
>  }
>  
>  int __parse_events(struct evlist *evlist, const char *str,
> -		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
> +		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
> +		   bool warn_if_reordered)
>  {
>  	struct parse_events_state parse_state = {
>  		.list	  = LIST_HEAD_INIT(parse_state.list),
> @@ -2250,7 +2260,9 @@ int __parse_events(struct evlist *evlist, const char *str,
>  		return -1;
>  	}
>  
> -	parse_events__sort_events_and_fix_groups(&parse_state.list);
> +	if (parse_events__sort_events_and_fix_groups(&parse_state.list) &&
> +	    warn_if_reordered && !parse_state.wild_card_pmus)
> +		pr_warning("WARNING: events were regrouped to match PMUs\n");
>  
>  	/*
>  	 * Add list to the evlist even with errors to allow callers to clean up.
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 767ad1729228..46204c1a7916 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -26,13 +26,13 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
>  int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
>  __attribute__((nonnull(1, 2, 3)))
>  int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
> -		   struct perf_pmu *fake_pmu);
> +		   struct perf_pmu *fake_pmu, bool warn_if_reordered);
>  
> -__attribute__((nonnull))
> +__attribute__((nonnull(1, 2, 3)))
>  static inline int parse_events(struct evlist *evlist, const char *str,
>  			       struct parse_events_error *err)
>  {
> -	return __parse_events(evlist, str, err, NULL);
> +	return __parse_events(evlist, str, err, /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
>  }
>  
>  int parse_event(struct evlist *evlist, const char *str);
> @@ -128,6 +128,7 @@ struct parse_events_state {
>  	int			   stoken;
>  	struct perf_pmu		  *fake_pmu;
>  	char			  *hybrid_pmu_name;
> +	bool			   wild_card_pmus;
>  };
>  
>  void parse_events__shrink_config_terms(void);
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 3a04602d2982..4488443e506e 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -323,6 +323,7 @@ event_pmu_name opt_pmu_config
>  				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms,
>  							  /*auto_merge_stats=*/true)) {
>  					ok++;
> +					parse_state->wild_card_pmus = true;
>  				}
>  				parse_events_terms__delete(terms);
>  			}

