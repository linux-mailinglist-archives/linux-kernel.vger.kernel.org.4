Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F025EBB24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiI0HJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiI0HJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:09:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A021C5595;
        Tue, 27 Sep 2022 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664262573; x=1695798573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hfOuLUmJESa9TndPikP9Oj/5VtYTzryYL4S2klro3to=;
  b=LjM5rqVv8lFEMPedf0jC9Xa+PVE8JERuUfTMYLFO/LqucPXyFjg64evL
   Dl063Wl305O2FbAkkNfcsGDReY7cC2VJKR9OLImYb+KCSDsBXeqloRTuT
   K/Seb53mv4d1fLGjdW0wncwBqbd2LyOYOgWEu2tx2HpFvuHnDuwOhQ/HK
   T4ZjJJczPdKlaxua5ZtwtASCQCLQJC9+qSAFyNY7pJY6oKP8Naw0ticp6
   emO9XOrZvKvuTxPVusFRXkiKUDuar+cz06V1Pay4BX29DcEUqaim8oDDx
   nDpOnx15oAwToJNTl/3lUbQdFRkDsVj3PXqN6c3Y7tnOZOTDNcct4yUbS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="299961400"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="299961400"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:09:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="866463287"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="866463287"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:09:30 -0700
Message-ID: <2260a908-47c0-705c-3d87-099b7d6fa9fd@intel.com>
Date:   Tue, 27 Sep 2022 10:09:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] perf tools: Remove special handling of system-wide
 evsel
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
 <20220924165737.956428-6-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220924165737.956428-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/22 19:57, Namhyung Kim wrote:
> For system-wide evsels, the thread map should be dummy - i.e. it has a
> single entry of -1.  But the code guarantees such a thread map, so no
> need to handle it specially.
> 
> No functional change intended.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/lib/perf/evsel.c      |  3 ---
>  tools/perf/builtin-script.c |  3 ---
>  tools/perf/util/evsel.c     | 12 ++----------
>  tools/perf/util/stat.c      |  3 ---
>  4 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 8ce5bbd09666..8b51b008a81f 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -515,9 +515,6 @@ int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
>  	if (ncpus == 0 || nthreads == 0)
>  		return 0;
>  
> -	if (evsel->system_wide)
> -		nthreads = 1;
> -
>  	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
>  	if (evsel->sample_id == NULL)
>  		return -ENOMEM;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 886f53cfa257..7fa467ed91dc 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2243,9 +2243,6 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
>  	struct perf_cpu cpu;
>  	static int header_printed;
>  
> -	if (counter->core.system_wide)
> -		nthreads = 1;
> -
>  	if (!header_printed) {
>  		printf("%3s %8s %15s %15s %15s %15s %s\n",
>  		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5776bfa70f11..e319bb17d10d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1813,7 +1813,7 @@ static struct perf_thread_map *empty_thread_map;
>  static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads)
>  {
> -	int nthreads;
> +	int nthreads = perf_thread_map__nr(threads);
>  
>  	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
>  	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
> @@ -1839,11 +1839,6 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		threads = empty_thread_map;
>  	}
>  
> -	if (evsel->core.system_wide)
> -		nthreads = 1;
> -	else
> -		nthreads = threads->nr;
> -
>  	if (evsel->core.fd == NULL &&
>  	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
>  		return -ENOMEM;
> @@ -2061,10 +2056,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	if (threads == NULL)
>  		threads = empty_thread_map;
>  
> -	if (evsel->core.system_wide)
> -		nthreads = 1;
> -	else
> -		nthreads = threads->nr;
> +	nthreads = perf_thread_map__nr(threads);
>  
>  	if (evsel->cgrp)
>  		pid = evsel->cgrp->fd;
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index ce5e9e372fc4..cef943377ad7 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -420,9 +420,6 @@ static int process_counter_maps(struct perf_stat_config *config,
>  	int ncpus = evsel__nr_cpus(counter);
>  	int idx, thread;
>  
> -	if (counter->core.system_wide)
> -		nthreads = 1;
> -
>  	for (thread = 0; thread < nthreads; thread++) {
>  		for (idx = 0; idx < ncpus; idx++) {
>  			if (process_counter_values(config, counter, idx, thread,

