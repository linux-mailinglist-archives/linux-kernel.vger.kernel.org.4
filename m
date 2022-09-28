Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655795EDF27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiI1Otr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiI1Oti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DCFDDBA;
        Wed, 28 Sep 2022 07:49:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DD823A;
        Wed, 28 Sep 2022 07:49:38 -0700 (PDT)
Received: from [10.57.0.129] (unknown [10.57.0.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8703F73D;
        Wed, 28 Sep 2022 07:49:29 -0700 (PDT)
Message-ID: <470e79ec-201b-6081-d31c-f5a9dee7a9ae@arm.com>
Date:   Wed, 28 Sep 2022 15:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] perf stat: Use thread map index for shadow stat
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
 <20220926200757.1161448-5-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220926200757.1161448-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2022 21:07, Namhyung Kim wrote:
> When AGGR_THREAD is active, it aggregates the values for each thread.
> Previously it used cpu map index which is invalid for AGGR_THREAD so
> it had to use separate runtime stats with index 0.
> 
> But it can just use the rt_stat with thread_map_index.  Rename the
> first_shadow_map_idx() and make it return the thread index.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 20 +++++++++-----------
>  tools/perf/util/stat.c         |  8 ++------
>  2 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: James Clark <james.clark@arm.com>
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 234491f43c36..570e2c04d47d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -442,7 +442,7 @@ static void print_metric_header(struct perf_stat_config *config,
>  		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
>  }
>  
> -static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
> +static int first_shadow_map_idx(struct perf_stat_config *config,
>  				struct evsel *evsel, const struct aggr_cpu_id *id)
>  {
>  	struct perf_cpu_map *cpus = evsel__cpus(evsel);
> @@ -452,6 +452,9 @@ static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
>  	if (config->aggr_mode == AGGR_NONE)
>  		return perf_cpu_map__idx(cpus, id->cpu);
>  
> +	if (config->aggr_mode == AGGR_THREAD)
> +		return id->thread;
> +
>  	if (!config->aggr_get_id)
>  		return 0;
>  
> @@ -646,7 +649,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  	}
>  
>  	perf_stat__print_shadow_stats(config, counter, uval,
> -				first_shadow_cpu_map_idx(config, counter, &id),
> +				first_shadow_map_idx(config, counter, &id),
>  				&out, &config->metric_events, st);
>  	if (!config->csv_output && !config->metric_only && !config->json_output) {
>  		print_noise(config, counter, noise);
> @@ -676,7 +679,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
>  				val += perf_counts(counter->counts, idx, 0)->val;
>  			}
>  			perf_stat__update_shadow_stats(counter, val,
> -					first_shadow_cpu_map_idx(config, counter, &id),
> +					first_shadow_map_idx(config, counter, &id),
>  					&rt_stat);
>  		}
>  	}
> @@ -979,14 +982,9 @@ static void print_aggr_thread(struct perf_stat_config *config,
>  			fprintf(output, "%s", prefix);
>  
>  		id = buf[thread].id;
> -		if (config->stats)
> -			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -				 prefix, buf[thread].run, buf[thread].ena, 1.0,
> -				 &config->stats[id.thread]);
> -		else
> -			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -				 prefix, buf[thread].run, buf[thread].ena, 1.0,
> -				 &rt_stat);
> +		printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> +			 prefix, buf[thread].run, buf[thread].ena, 1.0,
> +			 &rt_stat);
>  		fputc('\n', output);
>  	}
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index e1d3152ce664..21137c9d5259 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -389,12 +389,8 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>  		}
>  
>  		if (config->aggr_mode == AGGR_THREAD) {
> -			if (config->stats)
> -				perf_stat__update_shadow_stats(evsel,
> -					count->val, 0, &config->stats[thread]);
> -			else
> -				perf_stat__update_shadow_stats(evsel,
> -					count->val, 0, &rt_stat);
> +			perf_stat__update_shadow_stats(evsel, count->val,
> +						       thread, &rt_stat);
>  		}
>  		break;
>  	case AGGR_GLOBAL:
