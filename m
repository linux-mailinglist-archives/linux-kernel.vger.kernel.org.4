Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85146A84A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCBOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCBOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:52:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07ACD319;
        Thu,  2 Mar 2023 06:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D8E615D5;
        Thu,  2 Mar 2023 14:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919FAC433EF;
        Thu,  2 Mar 2023 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677768671;
        bh=fCYVVBqTTJpewNqGooLPvuVMlOKvkIdHdIOl75ocAfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOVOCUW+Fx7IxXvN2smyhS5TVdxFQQnAwTK42aG5btD8RYGWel7NIWF+LrD+qbHzO
         9WpjhFxMkrvPEKjEn78kQNeK22w0AN5Vaa+mZyl9jg9bvI40LdsJMAGt92+GNYu/OA
         9t3iZf8rMCukzFP4pBTuiCBZZZztqyUhDl3FIpKp0EmpwvE4llEDfNg+AGsbIWXDUd
         HDwOX92uOseKQRSqXsDhYy4hGDEGcRhkOXpnz1+vmCL4AMPX4bELiHkMZF85vq7A5N
         ySCzwdU/qnG+w6IVXSl67zSqJ1gXaVDH/83ruo0AxArUuq6+QdPLUrYVVTCY3/YYTv
         juBWKEShrVerw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A47B4049F; Thu,  2 Mar 2023 11:51:09 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:51:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 09/10] perf parse-events: Sort and group parsed events
Message-ID: <ZAC33ftkLnW4X/P5@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-10-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-10-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:10PM -0800, Ian Rogers escreveu:
> This change is intended to be a no-op for most current cases, the
> default sort order is the order the events were parsed. Where it
> varies is in how groups are handled. Previously an uncore and core
> event that are grouped would most often cause the group to be removed:

And shouldn't that continue to be the case? I.e. the user asks for
events to be in a group, but that can't be performed, so the tool fails
and states that those events can't be in a group, looks sensible, no?

Perhaps the tool should continue to fail but provide an alternative
command line where multiple groups are specified, the user gets educated
and uses that instead? Probably the logic would be similar to what you
seem to be doing here?

- Arnaldo

> 
> ```
> $ perf stat -e '{instructions,uncore_imc_free_running_0/data_total/}' -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { instructions, uncore_imc_free_running_0/data_total/ }
> ...
> ```
> 
> However, when wildcards are used the events should be re-sorted and
> re-grouped in parse_events__set_leader, but this currently fails for
> simple examples:
> 
> ```
> $ perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_running/data_write/}' -a sleep 1

Next time can you state what is the system where this can be tested?
Saves a bit of time looking for where to test this.
 
>  Performance counter stats for 'system wide':
> 
>      <not counted> MiB  uncore_imc_free_running/data_read/
>      <not counted> MiB  uncore_imc_free_running/data_write/
> 
>        1.000996992 seconds time elapsed
> ```
> 
> A futher failure mode, fixed in this patch, is to force topdown events

further

> into a group.
> 
> This change moves sorting the evsels in the evlist after parsing. It
> requires parsing to set up groups. First the evsels are sorted
> respecting the existing groupings and parse order, but also reordering
> to ensure evsels of the same PMU and group appear together. So that
> software and aux events respect groups, their pmu_name is taken from
> the group leader. The sorting is done with list_sort removing a memory
> allocation.
> 
> After sorting a pass is done to correct the group leaders and for
> topdown events ensuring they have a group leader.
> 
> This fixes the problems seen before:
> 
> ```
> $ perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_running/data_write/}' -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>             727.42 MiB  uncore_imc_free_running/data_read/
>              81.84 MiB  uncore_imc_free_running/data_write/
> 
>        1.000948615 seconds time elapsed
> ```
> 
> As well as making groups not fail for cases like:
> 
> ```
> $ perf stat -e '{imc_free_running_0/data_total/,imc_free_running_1/data_total/}' -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>             256.47 MiB  imc_free_running_0/data_total/
>             256.48 MiB  imc_free_running_1/data_total/
> 
>        1.001165442 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c |  39 ++---
>  tools/perf/util/evlist.h          |   2 +-
>  tools/perf/util/parse-events.c    | 240 +++++++++++++++---------------
>  tools/perf/util/parse-events.h    |   3 +-
>  tools/perf/util/parse-events.y    |   4 +-
>  5 files changed, 136 insertions(+), 152 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 8a7ae4162563..d4193479a364 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -65,29 +65,22 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>  	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
>  }
>  
> -struct evsel *arch_evlist__leader(struct list_head *list)
> +int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  {
> -	struct evsel *evsel, *first, *slots = NULL;
> -	bool has_topdown = false;
> -
> -	first = list_first_entry(list, struct evsel, core.node);
> -
> -	if (!topdown_sys_has_perf_metrics())
> -		return first;
> -
> -	/* If there is a slots event and a topdown event then the slots event comes first. */
> -	__evlist__for_each_entry(list, evsel) {
> -		if (evsel->pmu_name && !strncmp(evsel->pmu_name, "cpu", 3) && evsel->name) {
> -			if (strcasestr(evsel->name, "slots")) {
> -				slots = evsel;
> -				if (slots == first)
> -					return first;
> -			}
> -			if (strcasestr(evsel->name, "topdown"))
> -				has_topdown = true;
> -			if (slots && has_topdown)
> -				return slots;
> -		}
> +	if (topdown_sys_has_perf_metrics() &&
> +	    (!lhs->pmu_name || !strncmp(lhs->pmu_name, "cpu", 3))) {
> +		/* Ensure the topdown slots comes first. */
> +		if (strcasestr(lhs->name, "slots"))
> +			return -1;
> +		if (strcasestr(rhs->name, "slots"))
> +			return 1;
> +		/* Followed by topdown events. */
> +		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
> +			return -1;
> +		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
> +			return 1;
>  	}
> -	return first;
> +
> +	/* Default ordering by insertion index. */
> +	return lhs->core.idx - rhs->core.idx;
>  }
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 01fa9d592c5a..d89d8f92802b 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -119,7 +119,7 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>  #define evlist__add_default_attrs(evlist, array) \
>  	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>  
> -struct evsel *arch_evlist__leader(struct list_head *list);
> +int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
>  
>  int evlist__add_dummy(struct evlist *evlist);
>  struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 1be454697d57..d6eb0a54dd2d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/hw_breakpoint.h>
>  #include <linux/err.h>
> +#include <linux/list_sort.h>
>  #include <linux/zalloc.h>
>  #include <dirent.h>
>  #include <errno.h>
> @@ -1655,125 +1656,7 @@ int parse_events__modifier_group(struct list_head *list,
>  	return parse_events__modifier_event(list, event_mod, true);
>  }
>  
> -/*
> - * Check if the two uncore PMUs are from the same uncore block
> - * The format of the uncore PMU name is uncore_#blockname_#pmuidx
> - */
> -static bool is_same_uncore_block(const char *pmu_name_a, const char *pmu_name_b)
> -{
> -	char *end_a, *end_b;
> -
> -	end_a = strrchr(pmu_name_a, '_');
> -	end_b = strrchr(pmu_name_b, '_');
> -
> -	if (!end_a || !end_b)
> -		return false;
> -
> -	if ((end_a - pmu_name_a) != (end_b - pmu_name_b))
> -		return false;
> -
> -	return (strncmp(pmu_name_a, pmu_name_b, end_a - pmu_name_a) == 0);
> -}
> -
> -static int
> -parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
> -					   struct parse_events_state *parse_state)
> -{
> -	struct evsel *evsel, *leader;
> -	uintptr_t *leaders;
> -	bool is_leader = true;
> -	int i, nr_pmu = 0, total_members, ret = 0;
> -
> -	leader = list_first_entry(list, struct evsel, core.node);
> -	evsel = list_last_entry(list, struct evsel, core.node);
> -	total_members = evsel->core.idx - leader->core.idx + 1;
> -
> -	leaders = calloc(total_members, sizeof(uintptr_t));
> -	if (WARN_ON(!leaders))
> -		return 0;
> -
> -	/*
> -	 * Going through the whole group and doing sanity check.
> -	 * All members must use alias, and be from the same uncore block.
> -	 * Also, storing the leader events in an array.
> -	 */
> -	__evlist__for_each_entry(list, evsel) {
> -
> -		/* Only split the uncore group which members use alias */
> -		if (!evsel->use_uncore_alias)
> -			goto out;
> -
> -		/* The events must be from the same uncore block */
> -		if (!is_same_uncore_block(leader->pmu_name, evsel->pmu_name))
> -			goto out;
> -
> -		if (!is_leader)
> -			continue;
> -		/*
> -		 * If the event's PMU name starts to repeat, it must be a new
> -		 * event. That can be used to distinguish the leader from
> -		 * other members, even they have the same event name.
> -		 */
> -		if ((leader != evsel) &&
> -		    !strcmp(leader->pmu_name, evsel->pmu_name)) {
> -			is_leader = false;
> -			continue;
> -		}
> -
> -		/* Store the leader event for each PMU */
> -		leaders[nr_pmu++] = (uintptr_t) evsel;
> -	}
> -
> -	/* only one event alias */
> -	if (nr_pmu == total_members) {
> -		parse_state->nr_groups--;
> -		goto handled;
> -	}
> -
> -	/*
> -	 * An uncore event alias is a joint name which means the same event
> -	 * runs on all PMUs of a block.
> -	 * Perf doesn't support mixed events from different PMUs in the same
> -	 * group. The big group has to be split into multiple small groups
> -	 * which only include the events from the same PMU.
> -	 *
> -	 * Here the uncore event aliases must be from the same uncore block.
> -	 * The number of PMUs must be same for each alias. The number of new
> -	 * small groups equals to the number of PMUs.
> -	 * Setting the leader event for corresponding members in each group.
> -	 */
> -	i = 0;
> -	__evlist__for_each_entry(list, evsel) {
> -		if (i >= nr_pmu)
> -			i = 0;
> -		evsel__set_leader(evsel, (struct evsel *) leaders[i++]);
> -	}
> -
> -	/* The number of members and group name are same for each group */
> -	for (i = 0; i < nr_pmu; i++) {
> -		evsel = (struct evsel *) leaders[i];
> -		evsel->core.nr_members = total_members / nr_pmu;
> -		evsel->group_name = name ? strdup(name) : NULL;
> -	}
> -
> -	/* Take the new small groups into account */
> -	parse_state->nr_groups += nr_pmu - 1;
> -
> -handled:
> -	ret = 1;
> -	free(name);
> -out:
> -	free(leaders);
> -	return ret;
> -}
> -
> -__weak struct evsel *arch_evlist__leader(struct list_head *list)
> -{
> -	return list_first_entry(list, struct evsel, core.node);
> -}
> -
> -void parse_events__set_leader(char *name, struct list_head *list,
> -			      struct parse_events_state *parse_state)
> +void parse_events__set_leader(char *name, struct list_head *list)
>  {
>  	struct evsel *leader;
>  
> @@ -1782,13 +1665,9 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  		return;
>  	}
>  
> -	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
> -		return;
> -
> -	leader = arch_evlist__leader(list);
> +	leader = list_first_entry(list, struct evsel, core.node);
>  	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name;
> -	list_move(&leader->core.node, list);
>  }
>  
>  /* list_event is assumed to point to malloc'ed memory */
> @@ -2245,6 +2124,117 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>  	return ret;
>  }
>  
> +__weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> +{
> +	/* Order by insertion index. */
> +	return lhs->core.idx - rhs->core.idx;
> +}
> +
> +static int evlist__cmp(void *state, const struct list_head *l, const struct list_head *r)
> +{
> +	const struct perf_evsel *lhs_core = container_of(l, struct perf_evsel, node);
> +	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
> +	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
> +	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
> +	int *leader_idx = state;
> +	int lhs_leader_idx = *leader_idx, rhs_leader_idx = *leader_idx, ret;
> +	const char *lhs_pmu_name, *rhs_pmu_name;
> +
> +	/*
> +	 * First sort by grouping/leader. Read the leader idx only if the evsel
> +	 * is part of a group, as -1 indicates no group.
> +	 */
> +	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1)
> +		lhs_leader_idx = lhs_core->leader->idx;
> +	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1)
> +		rhs_leader_idx = rhs_core->leader->idx;
> +
> +	if (lhs_leader_idx != rhs_leader_idx)
> +		return lhs_leader_idx - rhs_leader_idx;
> +
> +	/* Group by PMU. Groups can't span PMUs. */
> +	lhs_pmu_name = evsel__pmu_name(lhs);
> +	rhs_pmu_name = evsel__pmu_name(rhs);
> +	ret = strcmp(lhs_pmu_name, rhs_pmu_name);
> +	if (ret)
> +		return ret;
> +
> +	/* Architecture specific sorting. */
> +	return arch_evlist__cmp(lhs, rhs);
> +}
> +
> +static void parse_events__sort_events_and_fix_groups(struct list_head *list)
> +{
> +	int idx = -1;
> +	struct evsel *pos, *cur_leader = NULL;
> +	struct perf_evsel *cur_leaders_grp = NULL;
> +
> +	/*
> +	 * Compute index to insert ungrouped events at. Place them where the
> +	 * first ungrouped event appears.
> +	 */
> +	list_for_each_entry(pos, list, core.node) {
> +		const struct evsel *pos_leader = evsel__leader(pos);
> +
> +		if (pos != pos_leader || pos->core.nr_members > 1)
> +			continue;
> +
> +		idx = pos->core.idx;
> +		break;
> +	}
> +
> +	/* Sort events. */
> +	list_sort(&idx, list, evlist__cmp);
> +
> +	/*
> +	 * Recompute groups, splitting for PMUs and adding groups for events
> +	 * that require them.
> +	 */
> +	idx = 0;
> +	list_for_each_entry(pos, list, core.node) {
> +		const struct evsel *pos_leader = evsel__leader(pos);
> +		const char *pos_pmu_name = evsel__pmu_name(pos);
> +		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
> +		bool force_grouped = arch_evsel__must_be_in_group(pos);
> +
> +		/* Reset index and nr_members. */
> +		pos->core.idx = idx++;
> +		pos->core.nr_members = 0;
> +
> +		/*
> +		 * Set the group leader respecting the given groupings and that
> +		 * groups can't span PMUs.
> +		 */
> +		if (!cur_leader)
> +			cur_leader = pos;
> +
> +		cur_leader_pmu_name = evsel__pmu_name(cur_leader);
> +		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
> +		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
> +			/* Event is for a different group/PMU than last. */
> +			cur_leader = pos;
> +			/*
> +			 * Remember the leader's group before it is overwritten,
> +			 * so that later events match as being in the same
> +			 * group.
> +			 */
> +			cur_leaders_grp = pos->core.leader;
> +		}
> +		pos_leader_pmu_name = evsel__pmu_name(pos_leader);
> +		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
> +			/*
> +			 * Event's PMU differs from its leader's. Groups can't
> +			 * span PMUs, so update leader from the group/PMU
> +			 * tracker.
> +			 */
> +			evsel__set_leader(pos, cur_leader);
> +		}
> +	}
> +	list_for_each_entry(pos, list, core.node) {
> +		pos->core.leader->nr_members++;
> +	}
> +}
> +
>  int __parse_events(struct evlist *evlist, const char *str,
>  		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
>  {
> @@ -2266,6 +2256,8 @@ int __parse_events(struct evlist *evlist, const char *str,
>  		return -1;
>  	}
>  
> +	parse_events__sort_events_and_fix_groups(&parse_state.list);
> +
>  	/*
>  	 * Add list to the evlist even with errors to allow callers to clean up.
>  	 */
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 428e72eaafcc..22fc11b0bd59 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -200,8 +200,7 @@ int parse_events_copy_term_list(struct list_head *old,
>  
>  enum perf_pmu_event_symbol_type
>  perf_pmu__parse_check(const char *name);
> -void parse_events__set_leader(char *name, struct list_head *list,
> -			      struct parse_events_state *parse_state);
> +void parse_events__set_leader(char *name, struct list_head *list);
>  void parse_events_update_lists(struct list_head *list_event,
>  			       struct list_head *list_all);
>  void parse_events_evlist_error(struct parse_events_state *parse_state,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 541b8dde2063..90d12f2bc8be 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -203,7 +203,7 @@ PE_NAME '{' events '}'
>  
>  	inc_group_count(list, _parse_state);
>  	/* Takes ownership of $1. */
> -	parse_events__set_leader($1, list, _parse_state);
> +	parse_events__set_leader($1, list);
>  	$$ = list;
>  }
>  |
> @@ -212,7 +212,7 @@ PE_NAME '{' events '}'
>  	struct list_head *list = $2;
>  
>  	inc_group_count(list, _parse_state);
> -	parse_events__set_leader(NULL, list, _parse_state);
> +	parse_events__set_leader(NULL, list);
>  	$$ = list;
>  }
>  
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
