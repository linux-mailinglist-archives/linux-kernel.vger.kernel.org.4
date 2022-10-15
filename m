Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF65FFA0F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJOM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 08:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJOM4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 08:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8E3F1D0;
        Sat, 15 Oct 2022 05:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B9B60CF6;
        Sat, 15 Oct 2022 12:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C386C433D6;
        Sat, 15 Oct 2022 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665838557;
        bh=CA0sWBZQtjf7j93I0ZdrDhIFP5M5AEYv12MwTAWor3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOkhaqDCm+ouyx3PZ1JlkqZSACY6i1PbYgl7jc6D1EmrGS1zfydbL/vwRKywia8BH
         W63710fuFlOi17aV/kuQ7U/6VMxCzKS12keCjh4LaC/gmj04nmgjHiiiHNmuDqsJnF
         RTQdj3l6sPtzDSyBBE2gEiIzF9kcWMHXC9+YyIT+cb17eey19sR3GB2/YfTY31eqyy
         1irM/TsG8u7QX3Tv9YCzoILiNBdvWRLPwfGgWPnuRi85I0i7q/VI+CYbw6tFcy1kgH
         hP4ttU22Vmq2uCLjOdlfxgZrXC8Vs/BLf1X3BtrrP4L1WnVbCAAMmO1UW8ZC8U5w7T
         eNkObM/bwK+cg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C4C3403B6; Sat, 15 Oct 2022 09:55:55 -0300 (-03)
Date:   Sat, 15 Oct 2022 09:55:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH 01/19] perf tools: Save evsel->pmu in parse_events()
Message-ID: <Y0qt2/bAncQQGvrj@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
 <20221014061550.463644-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014061550.463644-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 13, 2022 at 11:15:32PM -0700, Namhyung Kim escreveu:
> Now evsel has a pmu pointer, let's save the info and use it like in
> evsel__find_pmu().

This one made 'perf test metricgroups' to fail, I removed it and that
test passes. Can you please double check?

I have all the other patches in my local perf/core branch and I'm
prepping up a pull req with those included to Linus, holler if you
disagree.

- Arnaldo
 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c        | 1 +
>  tools/perf/util/parse-events.c | 1 +
>  tools/perf/util/pmu.c          | 4 ++++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 76605fde3507..196f8e4859d7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -467,6 +467,7 @@ struct evsel *evsel__clone(struct evsel *orig)
>  	evsel->collect_stat = orig->collect_stat;
>  	evsel->weak_group = orig->weak_group;
>  	evsel->use_config_name = orig->use_config_name;
> +	evsel->pmu = orig->pmu;
>  
>  	if (evsel__copy_config_terms(evsel, orig) < 0)
>  		goto out_err;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 437389dacf48..9e704841273d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -263,6 +263,7 @@ __add_event(struct list_head *list, int *idx,
>  	evsel->core.own_cpus = perf_cpu_map__get(cpus);
>  	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
>  	evsel->auto_merge_stats = auto_merge_stats;
> +	evsel->pmu = pmu;
>  
>  	if (name)
>  		evsel->name = strdup(name);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 74a2cafb4e8d..15bf5943083a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1048,11 +1048,15 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
>  {
>  	struct perf_pmu *pmu = NULL;
>  
> +	if (evsel->pmu)
> +		return evsel->pmu;
> +
>  	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>  		if (pmu->type == evsel->core.attr.type)
>  			break;
>  	}
>  
> +	evsel->pmu = pmu;
>  	return pmu;
>  }
>  
> -- 
> 2.38.0.413.g74048e4d9e-goog

-- 

- Arnaldo
