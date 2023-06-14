Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7520730043
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbjFNNkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjFNNkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:40:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6F173C;
        Wed, 14 Jun 2023 06:40:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f74cda5f1dso4184474e87.3;
        Wed, 14 Jun 2023 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750030; x=1689342030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIVDFho3UzZ1Brrpoz+lXYtGNnByKzWzNr2ZcbD7hI=;
        b=I0jQzMzuVfxMmItYDxd0kqdV/bHAOQD9zqlZEU/sdTIjQHGMAI9UGrFQ87VrtJSTrp
         YZsOtvYD4Fx5QQ17bB+4bBASMTYrdExzsar9BHg6+PZSPAD8JMs96B69Hksq+q/lLIe5
         VggjyDa8x3ow/uqdQ0AMH2WRKt2qn1XmHe/yB4ArD6wB8TI8P1BjFeFHNFB2KwnKnMNm
         Kngeqrd7XwkrGDQkkihRsxGhrpU860n16FLS8Irz8WruE/zYcI+iQ17mLR+qN/3bdF5q
         thFJc6DFboaWLtc1W+1LYAfk2JER5zb3CSPjCgDl5zHS9Kqh7YVoQST0A3bqmAZzgrYx
         8VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750030; x=1689342030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdIVDFho3UzZ1Brrpoz+lXYtGNnByKzWzNr2ZcbD7hI=;
        b=JVubr04AUScbb2zNMYEJ/pExzVZzB6ML1JKk3qNtc0KLX6aIpoChbWgmrt+GGFABms
         y/UqbdsgjRQEDsrQ873bMikaTdiko0ejyDi3DIRxS5u/16NNIFTd7uY+1t1VS9kIS1lV
         FIl2yw1q9ywv+3M9AJQOPS+bAJDTaDhlNd5kPcRXaTw6qKEADF5ioJEtgaVlNUtINNw4
         NtuOJQ0cRYyHJqIdi7Qk1ObahD9yH9wyksJPerV24lqXizZVhsdOSez0iTkY+kBg+9o+
         06oRoiS1/X7meRwxDDwdqh0qDuerl+iOlwk5wCvavQpHkqfTSPcTaMxPijVKxgesIEys
         pVhA==
X-Gm-Message-State: AC+VfDy6xndXfXkYYtm1kCuOcFz+OGHCBSEkXtjuQWYysP9NcEYXtS1m
        MZ5/cNG7rkKjFQMCT8u89fU=
X-Google-Smtp-Source: ACHHUZ5Psu2f9rx3jSw1hcYoYayQDyuN/0/Zx44QKs4j9cvwVwdv1CUpXiYoQ13XHw6VDt9XM8LhuQ==
X-Received: by 2002:a19:661a:0:b0:4dd:9a38:fcc with SMTP id a26-20020a19661a000000b004dd9a380fccmr7713434lfc.63.1686750029538;
        Wed, 14 Jun 2023 06:40:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id qp18-20020a170907207200b009786b73974fsm8069377ejb.145.2023.06.14.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:40:29 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 14 Jun 2023 15:40:26 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
Message-ID: <ZInDSgrOzYSX124p@krava>
References: <20221018020227.85905-1-namhyung@kernel.org>
 <20221018020227.85905-19-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018020227.85905-19-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 07:02:25PM -0700, Namhyung Kim wrote:
> Now aggr counts are ready for use.  Convert the display routines to use
> the aggr counts and update the shadow stat with them.  It doesn't need
> to aggregate counts or collect aliases anymore during the display.  Get
> rid of now unused struct perf_aggr_thread_value.
> 
> Note that there's a difference in the display order among the aggr mode.
> For per-core/die/socket/node aggregation, it shows relevant events in
> the same unit together, whereas global/thread/no aggregation it shows
> the same events for different units together.  So it still uses separate
> codes to display them due to the ordering.
> 
> One more thing to note is that it breaks per-core event display for now.
> The next patch will fix it to have identical output as of now.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

hi,
this one seems to break 'perf stat -r X' not sure why so far..

final counts seems to be accumulated instead of displaying average, like:


with this patch:

	 Performance counter stats for './test_progs -n 103/1' (2 runs):

	       206,815,929      cycles:u                                                             ( +-  0.05% )
	    16,052,747,533      cycles:k                                                             ( +-  0.10% )
	    16,259,643,167      cycles                                                               ( +-  0.10% )

		   1.98093 +- 0.00586 seconds time elapsed  ( +-  0.30% )


without this patch:

	 Performance counter stats for './test_progs -n 103/1' (2 runs):

	       103,300,812      cycles:u                                                             ( +-  0.37% )
	     8,016,856,866      cycles:k                                                             ( +-  0.32% )
	     8,120,200,572      cycles                                                               ( +-  0.32% )

		   1.97272 +- 0.00270 seconds time elapsed  ( +-  0.14% )


any idea? ;-)

thanks,
jirka




> ---
>  tools/perf/util/stat-display.c | 421 ++++-----------------------------
>  tools/perf/util/stat.c         |   5 -
>  tools/perf/util/stat.h         |   9 -
>  3 files changed, 49 insertions(+), 386 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 4113aa86772f..bfae2784609c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_config *config,
>  		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
>  }
>  
> -static int first_shadow_map_idx(struct perf_stat_config *config,
> -				struct evsel *evsel, const struct aggr_cpu_id *id)
> -{
> -	struct perf_cpu_map *cpus = evsel__cpus(evsel);
> -	struct perf_cpu cpu;
> -	int idx;
> -
> -	if (config->aggr_mode == AGGR_NONE)
> -		return perf_cpu_map__idx(cpus, id->cpu);
> -
> -	if (config->aggr_mode == AGGR_THREAD)
> -		return id->thread_idx;
> -
> -	if (!config->aggr_get_id)
> -		return 0;
> -
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
> -
> -		if (aggr_cpu_id__equal(&cpu_id, id))
> -			return idx;
> -	}
> -	return 0;
> -}
> -
>  static void abs_printout(struct perf_stat_config *config,
>  			 struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
>  {
> @@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
>  		     struct evsel *counter, double uval,
>  		     char *prefix, u64 run, u64 ena, double noise,
> -		     struct runtime_stat *st)
> +		     struct runtime_stat *st, int map_idx)
>  {
>  	struct perf_stat_output_ctx out;
>  	struct outstate os = {
> @@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  		print_running(config, run, ena);
>  	}
>  
> -	perf_stat__print_shadow_stats(config, counter, uval,
> -				first_shadow_map_idx(config, counter, &id),
> +	perf_stat__print_shadow_stats(config, counter, uval, map_idx,
>  				&out, &config->metric_events, st);
>  	if (!config->csv_output && !config->metric_only && !config->json_output) {
>  		print_noise(config, counter, noise);
> @@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  	}
>  }
>  
> -static void aggr_update_shadow(struct perf_stat_config *config,
> -			       struct evlist *evlist)
> -{
> -	int idx, s;
> -	struct perf_cpu cpu;
> -	struct aggr_cpu_id s2, id;
> -	u64 val;
> -	struct evsel *counter;
> -	struct perf_cpu_map *cpus;
> -
> -	for (s = 0; s < config->aggr_map->nr; s++) {
> -		id = config->aggr_map->map[s];
> -		evlist__for_each_entry(evlist, counter) {
> -			cpus = evsel__cpus(counter);
> -			val = 0;
> -			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -				s2 = config->aggr_get_id(config, cpu);
> -				if (!aggr_cpu_id__equal(&s2, &id))
> -					continue;
> -				val += perf_counts(counter->counts, idx, 0)->val;
> -			}
> -			perf_stat__update_shadow_stats(counter, val,
> -					first_shadow_map_idx(config, counter, &id),
> -					&rt_stat);
> -		}
> -	}
> -}
> -
>  static void uniquify_event_name(struct evsel *counter)
>  {
>  	char *new_name;
> @@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *counter)
>  	counter->uniquified_name = true;
>  }
>  
> -static void collect_all_aliases(struct perf_stat_config *config, struct evsel *counter,
> -			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> -				       bool first),
> -			    void *data)
> +static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
>  {
> -	struct evlist *evlist = counter->evlist;
> -	struct evsel *alias;
> -
> -	alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
> -	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
> -		/* Merge events with the same name, etc. but on different PMUs. */
> -		if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
> -			alias->scale == counter->scale &&
> -			alias->cgrp == counter->cgrp &&
> -			!strcmp(alias->unit, counter->unit) &&
> -			evsel__is_clock(alias) == evsel__is_clock(counter) &&
> -			strcmp(alias->pmu_name, counter->pmu_name)) {
> -			alias->merged_stat = true;
> -			cb(config, alias, data, false);
> -		}
> -	}
> +	return evsel__is_hybrid(evsel) && !config->hybrid_merge;
>  }
>  
> -static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
> -			 bool check)
> +static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
>  {
> -	if (evsel__is_hybrid(counter)) {
> -		if (check)
> -			return config->hybrid_merge;
> -		else
> -			return !config->hybrid_merge;
> -	}
> -
> -	return false;
> -}
> -
> -static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
> -			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> -				       bool first),
> -			    void *data)
> -{
> -	if (counter->merged_stat)
> -		return false;
> -	cb(config, counter, data, true);
> -	if (config->no_merge || hybrid_merge(counter, config, false))
> +	if (config->no_merge || hybrid_uniquify(counter, config))
>  		uniquify_event_name(counter);
> -	else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
> -		collect_all_aliases(config, counter, cb, data);
> -	return true;
> -}
> -
> -struct aggr_data {
> -	u64 ena, run, val;
> -	struct aggr_cpu_id id;
> -	int nr;
> -	int cpu_map_idx;
> -};
> -
> -static void aggr_cb(struct perf_stat_config *config,
> -		    struct evsel *counter, void *data, bool first)
> -{
> -	struct aggr_data *ad = data;
> -	int idx;
> -	struct perf_cpu cpu;
> -	struct perf_cpu_map *cpus;
> -	struct aggr_cpu_id s2;
> -
> -	cpus = evsel__cpus(counter);
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		struct perf_counts_values *counts;
> -
> -		s2 = config->aggr_get_id(config, cpu);
> -		if (!aggr_cpu_id__equal(&s2, &ad->id))
> -			continue;
> -		if (first)
> -			ad->nr++;
> -		counts = perf_counts(counter->counts, idx, 0);
> -		/*
> -		 * When any result is bad, make them all to give
> -		 * consistent output in interval mode.
> -		 */
> -		if (counts->ena == 0 || counts->run == 0 ||
> -		    counter->counts->scaled == -1) {
> -			ad->ena = 0;
> -			ad->run = 0;
> -			break;
> -		}
> -		ad->val += counts->val;
> -		ad->ena += counts->ena;
> -		ad->run += counts->run;
> -	}
>  }
>  
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>  				   struct evsel *counter, int s,
>  				   char *prefix, bool metric_only,
> -				   bool *first, struct perf_cpu cpu)
> +				   bool *first)
>  {
> -	struct aggr_data ad;
>  	FILE *output = config->output;
>  	u64 ena, run, val;
> -	int nr;
> -	struct aggr_cpu_id id;
>  	double uval;
> +	struct perf_stat_evsel *ps = counter->stats;
> +	struct perf_stat_aggr *aggr = &ps->aggr[s];
> +	struct aggr_cpu_id id = config->aggr_map->map[s];
> +	double avg = aggr->counts.val;
>  
> -	ad.id = id = config->aggr_map->map[s];
> -	ad.val = ad.ena = ad.run = 0;
> -	ad.nr = 0;
> -	if (!collect_data(config, counter, aggr_cb, &ad))
> +	if (counter->supported && aggr->nr == 0)
>  		return;
>  
> -	if (perf_pmu__has_hybrid() && ad.ena == 0)
> -		return;
> +	uniquify_counter(config, counter);
> +
> +	val = aggr->counts.val;
> +	ena = aggr->counts.ena;
> +	run = aggr->counts.run;
>  
> -	nr = ad.nr;
> -	ena = ad.ena;
> -	run = ad.run;
> -	val = ad.val;
>  	if (*first && metric_only) {
>  		*first = false;
> -		aggr_printout(config, counter, id, nr);
> +		aggr_printout(config, counter, id, aggr->nr);
>  	}
>  	if (prefix && !metric_only)
>  		fprintf(output, "%s", prefix);
>  
>  	uval = val * counter->scale;
> -	if (cpu.cpu != -1)
> -		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>  
> -	printout(config, id, nr, counter, uval,
> -		 prefix, run, ena, 1.0, &rt_stat);
> +	printout(config, id, aggr->nr, counter, uval,
> +		 prefix, run, ena, avg, &rt_stat, s);
> +
>  	if (!metric_only)
>  		fputc('\n', output);
>  }
> @@ -869,8 +729,6 @@ static void print_aggr(struct perf_stat_config *config,
>  	if (!config->aggr_map || !config->aggr_get_id)
>  		return;
>  
> -	aggr_update_shadow(config, evlist);
> -
>  	/*
>  	 * With metric_only everything is on a single line.
>  	 * Without each counter has its own line.
> @@ -881,188 +739,36 @@ static void print_aggr(struct perf_stat_config *config,
>  
>  		first = true;
>  		evlist__for_each_entry(evlist, counter) {
> +			if (counter->merged_stat)
> +				continue;
> +
>  			print_counter_aggrdata(config, counter, s,
> -					prefix, metric_only,
> -					&first, (struct perf_cpu){ .cpu = -1 });
> +					       prefix, metric_only,
> +					       &first);
>  		}
>  		if (metric_only)
>  			fputc('\n', output);
>  	}
>  }
>  
> -static int cmp_val(const void *a, const void *b)
> -{
> -	return ((struct perf_aggr_thread_value *)b)->val -
> -		((struct perf_aggr_thread_value *)a)->val;
> -}
> -
> -static struct perf_aggr_thread_value *sort_aggr_thread(
> -					struct evsel *counter,
> -					int *ret,
> -					struct target *_target)
> -{
> -	int nthreads = perf_thread_map__nr(counter->core.threads);
> -	int i = 0;
> -	double uval;
> -	struct perf_aggr_thread_value *buf;
> -
> -	buf = calloc(nthreads, sizeof(struct perf_aggr_thread_value));
> -	if (!buf)
> -		return NULL;
> -
> -	for (int thread = 0; thread < nthreads; thread++) {
> -		int idx;
> -		u64 ena = 0, run = 0, val = 0;
> -
> -		perf_cpu_map__for_each_idx(idx, evsel__cpus(counter)) {
> -			struct perf_counts_values *counts =
> -				perf_counts(counter->counts, idx, thread);
> -
> -			val += counts->val;
> -			ena += counts->ena;
> -			run += counts->run;
> -		}
> -
> -		uval = val * counter->scale;
> -
> -		/*
> -		 * Skip value 0 when enabling --per-thread globally,
> -		 * otherwise too many 0 output.
> -		 */
> -		if (uval == 0.0 && target__has_per_thread(_target))
> -			continue;
> -
> -		buf[i].counter = counter;
> -		buf[i].id = aggr_cpu_id__empty();
> -		buf[i].id.thread_idx = thread;
> -		buf[i].uval = uval;
> -		buf[i].val = val;
> -		buf[i].run = run;
> -		buf[i].ena = ena;
> -		i++;
> -	}
> -
> -	qsort(buf, i, sizeof(struct perf_aggr_thread_value), cmp_val);
> -
> -	if (ret)
> -		*ret = i;
> -
> -	return buf;
> -}
> -
> -static void print_aggr_thread(struct perf_stat_config *config,
> -			      struct target *_target,
> -			      struct evsel *counter, char *prefix)
> -{
> -	FILE *output = config->output;
> -	int thread, sorted_threads;
> -	struct aggr_cpu_id id;
> -	struct perf_aggr_thread_value *buf;
> -
> -	buf = sort_aggr_thread(counter, &sorted_threads, _target);
> -	if (!buf) {
> -		perror("cannot sort aggr thread");
> -		return;
> -	}
> -
> -	for (thread = 0; thread < sorted_threads; thread++) {
> -		if (prefix)
> -			fprintf(output, "%s", prefix);
> -
> -		id = buf[thread].id;
> -		printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -			 prefix, buf[thread].run, buf[thread].ena, 1.0,
> -			 &rt_stat);
> -		fputc('\n', output);
> -	}
> -
> -	free(buf);
> -}
> -
> -struct caggr_data {
> -	double avg, avg_enabled, avg_running;
> -};
> -
> -static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
> -			    struct evsel *counter, void *data,
> -			    bool first __maybe_unused)
> -{
> -	struct caggr_data *cd = data;
> -	struct perf_counts_values *aggr = &counter->counts->aggr;
> -
> -	cd->avg += aggr->val;
> -	cd->avg_enabled += aggr->ena;
> -	cd->avg_running += aggr->run;
> -}
> -
> -/*
> - * Print out the results of a single counter:
> - * aggregated counts in system-wide mode
> - */
> -static void print_counter_aggr(struct perf_stat_config *config,
> -			       struct evsel *counter, char *prefix)
> -{
> -	bool metric_only = config->metric_only;
> -	FILE *output = config->output;
> -	double uval;
> -	struct caggr_data cd = { .avg = 0.0 };
> -
> -	if (!collect_data(config, counter, counter_aggr_cb, &cd))
> -		return;
> -
> -	if (prefix && !metric_only)
> -		fprintf(output, "%s", prefix);
> -
> -	uval = cd.avg * counter->scale;
> -	printout(config, aggr_cpu_id__empty(), 0, counter, uval, prefix, cd.avg_running,
> -		 cd.avg_enabled, cd.avg, &rt_stat);
> -	if (!metric_only)
> -		fprintf(output, "\n");
> -}
> -
> -static void counter_cb(struct perf_stat_config *config __maybe_unused,
> -		       struct evsel *counter, void *data,
> -		       bool first __maybe_unused)
> -{
> -	struct aggr_data *ad = data;
> -
> -	ad->val += perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
> -	ad->ena += perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
> -	ad->run += perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
> -}
> -
> -/*
> - * Print out the results of a single counter:
> - * does not use aggregated count in system-wide
> - */
>  static void print_counter(struct perf_stat_config *config,
>  			  struct evsel *counter, char *prefix)
>  {
> -	FILE *output = config->output;
> -	u64 ena, run, val;
> -	double uval;
> -	int idx;
> -	struct perf_cpu cpu;
> -	struct aggr_cpu_id id;
> -
> -	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
> -		struct aggr_data ad = { .cpu_map_idx = idx };
> -
> -		if (!collect_data(config, counter, counter_cb, &ad))
> -			return;
> -		val = ad.val;
> -		ena = ad.ena;
> -		run = ad.run;
> +	bool metric_only = config->metric_only;
> +	bool first = false;
> +	int s;
>  
> -		if (prefix)
> -			fprintf(output, "%s", prefix);
> +	/* AGGR_THREAD doesn't have config->aggr_get_id */
> +	if (!config->aggr_map)
> +		return;
>  
> -		uval = val * counter->scale;
> -		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> -		printout(config, id, 0, counter, uval, prefix,
> -			 run, ena, 1.0, &rt_stat);
> +	if (counter->merged_stat)
> +		return;
>  
> -		fputc('\n', output);
> +	for (s = 0; s < config->aggr_map->nr; s++) {
> +		print_counter_aggrdata(config, counter, s,
> +				       prefix, metric_only,
> +				       &first);
>  	}
>  }
>  
> @@ -1081,6 +787,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  			u64 ena, run, val;
>  			double uval;
>  			struct aggr_cpu_id id;
> +			struct perf_stat_evsel *ps = counter->stats;
>  			int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
>  
>  			if (counter_idx < 0)
> @@ -1093,13 +800,13 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  				aggr_printout(config, counter, id, 0);
>  				first = false;
>  			}
> -			val = perf_counts(counter->counts, counter_idx, 0)->val;
> -			ena = perf_counts(counter->counts, counter_idx, 0)->ena;
> -			run = perf_counts(counter->counts, counter_idx, 0)->run;
> +			val = ps->aggr[counter_idx].counts.val;
> +			ena = ps->aggr[counter_idx].counts.ena;
> +			run = ps->aggr[counter_idx].counts.run;
>  
>  			uval = val * counter->scale;
>  			printout(config, id, 0, counter, uval, prefix,
> -				 run, ena, 1.0, &rt_stat);
> +				 run, ena, 1.0, &rt_stat, counter_idx);
>  		}
>  		if (!first)
>  			fputc('\n', config->output);
> @@ -1135,8 +842,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>  	};
>  	bool first = true;
>  
> -		if (config->json_output && !config->interval)
> -			fprintf(config->output, "{");
> +	if (config->json_output && !config->interval)
> +		fprintf(config->output, "{");
>  
>  	if (prefix && !config->json_output)
>  		fprintf(config->output, "%s", prefix);
> @@ -1379,31 +1086,6 @@ static void print_footer(struct perf_stat_config *config)
>  			"the same PMU. Try reorganizing the group.\n");
>  }
>  
> -static void print_percore_thread(struct perf_stat_config *config,
> -				 struct evsel *counter, char *prefix)
> -{
> -	int s;
> -	struct aggr_cpu_id s2, id;
> -	struct perf_cpu_map *cpus;
> -	bool first = true;
> -	int idx;
> -	struct perf_cpu cpu;
> -
> -	cpus = evsel__cpus(counter);
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		s2 = config->aggr_get_id(config, cpu);
> -		for (s = 0; s < config->aggr_map->nr; s++) {
> -			id = config->aggr_map->map[s];
> -			if (aggr_cpu_id__equal(&s2, &id))
> -				break;
> -		}
> -
> -		print_counter_aggrdata(config, counter, s,
> -				       prefix, false,
> -				       &first, cpu);
> -	}
> -}
> -
>  static void print_percore(struct perf_stat_config *config,
>  			  struct evsel *counter, char *prefix)
>  {
> @@ -1416,15 +1098,14 @@ static void print_percore(struct perf_stat_config *config,
>  		return;
>  
>  	if (config->percore_show_thread)
> -		return print_percore_thread(config, counter, prefix);
> +		return print_counter(config, counter, prefix);
>  
>  	for (s = 0; s < config->aggr_map->nr; s++) {
>  		if (prefix && metric_only)
>  			fprintf(output, "%s", prefix);
>  
>  		print_counter_aggrdata(config, counter, s,
> -				prefix, metric_only,
> -				&first, (struct perf_cpu){ .cpu = -1 });
> +				       prefix, metric_only, &first);
>  	}
>  
>  	if (metric_only)
> @@ -1469,17 +1150,13 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  		print_aggr(config, evlist, prefix);
>  		break;
>  	case AGGR_THREAD:
> -		evlist__for_each_entry(evlist, counter) {
> -			print_aggr_thread(config, _target, counter, prefix);
> -		}
> -		break;
>  	case AGGR_GLOBAL:
>  		if (config->iostat_run)
>  			iostat_print_counters(evlist, config, ts, prefix = buf,
> -					      print_counter_aggr);
> +					      print_counter);
>  		else {
>  			evlist__for_each_entry(evlist, counter) {
> -				print_counter_aggr(config, counter, prefix);
> +				print_counter(config, counter, prefix);
>  			}
>  			if (metric_only)
>  				fputc('\n', config->output);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index c0955a0427ab..0316557adce9 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -565,11 +565,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>  			evsel__name(counter), count[0], count[1], count[2]);
>  	}
>  
> -	/*
> -	 * Save the full runtime - to allow normalization during printout:
> -	 */
> -	perf_stat__update_shadow_stats(counter, *count, 0, &rt_stat);
> -
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 3d413ba8c68a..382a1ab92ce1 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -224,15 +224,6 @@ static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rus
>  struct evsel;
>  struct evlist;
>  
> -struct perf_aggr_thread_value {
> -	struct evsel *counter;
> -	struct aggr_cpu_id id;
> -	double uval;
> -	u64 val;
> -	u64 run;
> -	u64 ena;
> -};
> -
>  bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
>  
>  #define perf_stat_evsel__is(evsel, id) \
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
