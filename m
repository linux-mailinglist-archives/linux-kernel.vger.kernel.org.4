Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C170DD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjEWNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:00:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475CFF;
        Tue, 23 May 2023 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684846857; x=1716382857;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GMDcbG2KLo4bbXiyCuTToxMYhWdKKH1VcsNvMNyhlLU=;
  b=QaDFGUOqNQWOqbMZdJ2tAWBbiGT8qM+B96ckZUUOvIY7a/4DYHgXiJrk
   UD+520hN4G+0WyGJlnSuLnzHpMMpQdrmPhE6u/+78GK4rGChEOm4EmCOB
   ox+BX0L5IcIAhVXtY99ZNciHcH7tp52Ebf/d1l0PB00QJDFw0Rxf3Nupq
   LC277dLdMFNvhDPUgawBbtgvDMHZgVhcjl+lFs3i6tyMqmGETGsrxq2xy
   aNFJKCk44kx2OuPif9KLnpAe78Q89fcFUCctsbrT41PAvVSVT0XTHuQ82
   iNGD5sQXv8h9qruIpdKh6hzR/shrOmAwY4xb9q9A9qN7ASURbHl04jPUl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416686679"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="416686679"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="654357740"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="654357740"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:00:50 -0700
Message-ID: <0dc8fa26-248d-61eb-b224-4353443ddd6b@intel.com>
Date:   Tue, 23 May 2023 16:00:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] perf evsel: evsel__group_pmu_name fixes
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523044446.1020769-1-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230523044446.1020769-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 07:44, Ian Rogers wrote:
> Previously the evsel__group_pmu_name would iterate the evsel's group,
> however, the list of evsels aren't yet sorted and so the loop may
> terminate prematurely. It is also not desirable to iterate the list of
> evsels during list_sort as the list may be broken. Precompute the
> group_pmu_name for the evsel before sorting, as part of the
> computation and only if necessary, iterate the whole list looking for
> group members so that being sorted isn't necessary.
> 
> Move the group pmu name computation to parse-events.c given the closer
> dependency on the behavior of
> parse_events__sort_events_and_fix_groups.
> 
> Fixes: 7abf0bccaaec ("perf evsel: Add function to compute group PMU name")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c        | 31 +++++-----------------
>  tools/perf/util/evsel.h        |  2 +-
>  tools/perf/util/parse-events.c | 47 ++++++++++++++++++++++++++++++----
>  3 files changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2f5910b31fa9..3247773f9e24 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
>  	evsel->per_pkg_mask  = NULL;
>  	evsel->collect_stat  = false;
>  	evsel->pmu_name      = NULL;
> +	evsel->group_pmu_name = NULL;
>  	evsel->skippable     = false;
>  }
>  
> @@ -431,6 +432,11 @@ struct evsel *evsel__clone(struct evsel *orig)
>  		if (evsel->pmu_name == NULL)
>  			goto out_err;
>  	}
> +	if (orig->group_pmu_name) {
> +		evsel->group_pmu_name = strdup(orig->group_pmu_name);
> +		if (evsel->group_pmu_name == NULL)
> +			goto out_err;
> +	}
>  	if (orig->filter) {
>  		evsel->filter = strdup(orig->filter);
>  		if (evsel->filter == NULL)
> @@ -827,30 +833,6 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
>  	return !strcmp(evsel__name(evsel), name);
>  }
>  
> -const char *evsel__group_pmu_name(const struct evsel *evsel)
> -{
> -	struct evsel *leader = evsel__leader(evsel);
> -	struct evsel *pos;
> -
> -	/*
> -	 * Software events may be in a group with other uncore PMU events. Use
> -	 * the pmu_name of the first non-software event to avoid breaking the
> -	 * software event out of the group.
> -	 *
> -	 * Aux event leaders, like intel_pt, expect a group with events from
> -	 * other PMUs, so substitute the AUX event's PMU in this case.
> -	 */
> -	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
> -		/* Starting with the leader, find the first event with a named PMU. */
> -		for_each_group_evsel(pos, leader) {
> -			if (pos->pmu_name)
> -				return pos->pmu_name;
> -		}
> -	}
> -
> -	return evsel->pmu_name ?: "cpu";
> -}
> -
>  const char *evsel__metric_id(const struct evsel *evsel)
>  {
>  	if (evsel->metric_id)
> @@ -1536,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
>  	zfree(&evsel->pmu_name);
> +	zfree(&evsel->group_pmu_name);
>  	zfree(&evsel->unit);
>  	zfree(&evsel->metric_id);
>  	evsel__zero_per_pkg(evsel);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index df8928745fc6..820771a649b2 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -72,6 +72,7 @@ struct evsel {
>  		char			*name;
>  		char			*group_name;
>  		const char		*pmu_name;
> +		const char		*group_pmu_name;

Since it seems to be only used when sorting, do we really
need this on struct evsel?

>  #ifdef HAVE_LIBTRACEEVENT
>  		struct tep_event	*tp_format;
>  #endif
> @@ -289,7 +290,6 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
>  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
>  const char *evsel__name(struct evsel *evsel);
>  bool evsel__name_is(struct evsel *evsel, const char *name);
> -const char *evsel__group_pmu_name(const struct evsel *evsel);
>  const char *evsel__metric_id(const struct evsel *evsel);
>  
>  static inline bool evsel__is_tool(const struct evsel *evsel)
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 34ba840ae19a..210e6f713c6f 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2125,6 +2125,41 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>  	return ret;
>  }
>  
> +static void evsel__compute_group_pmu_name(struct evsel *evsel,
> +					  const struct list_head *head)
> +{
> +	struct evsel *leader = evsel__leader(evsel);
> +	struct evsel *pos;
> +
> +	/*
> +	 * Software events may be in a group with other uncore PMU events. Use
> +	 * the pmu_name of the first non-software event to avoid breaking the
> +	 * software event out of the group.
> +	 *
> +	 * Aux event leaders, like intel_pt, expect a group with events from
> +	 * other PMUs, so substitute the AUX event's PMU in this case.
> +	 */
> +	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
> +		/*
> +		 * Starting with the leader, find the first event with a named
> +		 * PMU. for_each_group_(member|evsel) isn't used as the list
> +		 * isn't yet sorted putting evsel's in the same group together.
> +		 */
> +		if (leader->pmu_name) {
> +			evsel->group_pmu_name = strdup(leader->pmu_name);
> +			return;
> +		}
> +		list_for_each_entry(pos, head, core.node) {
> +			if (evsel__leader(pos) == leader && pos->pmu_name) {
> +				evsel->group_pmu_name = strdup(pos->pmu_name);
> +				return;
> +			}
> +		}
> +	}
> +
> +	evsel->group_pmu_name = strdup(evsel->pmu_name ?: "cpu");
> +}
> +
>  __weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  {
>  	/* Order by insertion index. */
> @@ -2160,8 +2195,8 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
>  
>  	/* Group by PMU if there is a group. Groups can't span PMUs. */
>  	if (lhs_has_group && rhs_has_group) {
> -		lhs_pmu_name = evsel__group_pmu_name(lhs);
> -		rhs_pmu_name = evsel__group_pmu_name(rhs);
> +		lhs_pmu_name = lhs->group_pmu_name;
> +		rhs_pmu_name = rhs->group_pmu_name;
>  		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
>  		if (ret)
>  			return ret;
> @@ -2186,6 +2221,8 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
>  	list_for_each_entry(pos, list, core.node) {
>  		const struct evsel *pos_leader = evsel__leader(pos);
>  
> +		evsel__compute_group_pmu_name(pos, list);

Perhaps check for failing to allocate the string?

But alternatively, allocate an array for pointers to the
group pmu names.  Then they don't needed to be strdup'ed,
or stored on evsel.  Would have to count the number of evsel
first though.

	group_pmu_names = calloc(nr_evsel, sizeof(const char *));

	group_pmu_names[pos->core.idx] = evsel__group_pmu_name(pos);

> +
>  		if (pos == pos_leader)
>  			orig_num_leaders++;
>  
> @@ -2210,7 +2247,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
>  	idx = 0;
>  	list_for_each_entry(pos, list, core.node) {
>  		const struct evsel *pos_leader = evsel__leader(pos);
> -		const char *pos_pmu_name = evsel__group_pmu_name(pos);
> +		const char *pos_pmu_name = pos->group_pmu_name;
>  		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
>  		bool force_grouped = arch_evsel__must_be_in_group(pos);
>  
> @@ -2227,7 +2264,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		if (!cur_leader)
>  			cur_leader = pos;
>  
> -		cur_leader_pmu_name = evsel__group_pmu_name(cur_leader);
> +		cur_leader_pmu_name = cur_leader->group_pmu_name;
>  		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
>  		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
>  			/* Event is for a different group/PMU than last. */
> @@ -2239,7 +2276,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
>  			 */
>  			cur_leaders_grp = pos->core.leader;
>  		}
> -		pos_leader_pmu_name = evsel__group_pmu_name(pos_leader);
> +		pos_leader_pmu_name = pos_leader->group_pmu_name;
>  		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
>  			/*
>  			 * Event's PMU differs from its leader's. Groups can't

By the way, do we really need unsorted_idx?

For example what about this for evlist__cmp():

static int evlist__cmp(void *state __maybe_unused, const struct list_head *l, const struct list_head *r)
{
	const struct evsel *lhs = container_of(l, struct evsel, core.node);
	const struct evsel *rhs = container_of(r, struct evsel, core.node);
	int lhs_leader_idx = lhs->core.leader->idx;
	int rhs_leader_idx = rhs->core.leader->idx;
	int ret;

	if (lhs_leader_idx != rhs_leader_idx)
		return lhs_leader_idx - rhs_leader_idx;

	ret = strcmp(evsel__group_pmu_name(lhs), evsel__group_pmu_name(rhs));
	if (ret)
		return ret;

	/* Architecture specific sorting. */
	return arch_evlist__cmp(lhs, rhs);
}

