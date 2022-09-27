Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D55EBB06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiI0G4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiI0G4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:56:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA478E0C0;
        Mon, 26 Sep 2022 23:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664261774; x=1695797774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AH5cjA0jQ5jKl5Q4FlnwNzJnVwRRVmrZofqtl8jsi9Y=;
  b=C2/MP8HstnYt1Afkx2Hb9ItS0lSD0ImUclSgeDP8HCj8JaaYANs6j7v4
   e9bzY6hzfGwetKYopjY+VfZdhPE0MwyJts/2Wz2uXuGBfOH8GUh6fHIkI
   b6yN6Xjokob7iOZX9XvfI/6qpBd1HIC2n7wP5cJmIzfrla/TdQ2mvkdAN
   NER5FtxWTNr7vIJhwB84zWuiQJPSA9oe8Tnsl0c7Euyxh/q5CfJgx5P14
   tnRKinQfXAXOghhvm3VamDX+T+osTFIYiVwVr7sPlMO+zLE1V9ov0KGEc
   AuIlaUhFOqZ4TTL9n4mLiYJpycacZ4+i8gLakprWYvS6V/83ESBrvUNiD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="363078127"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="363078127"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 23:56:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="599072685"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="599072685"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 23:56:10 -0700
Message-ID: <e9f85e23-3544-5bbd-4579-cd994a12b3a2@intel.com>
Date:   Tue, 27 Sep 2022 09:56:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] libperf: Populate system-wide evsel maps
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
 <20220924165737.956428-2-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220924165737.956428-2-namhyung@kernel.org>
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
> Setting proper cpu and thread maps for system wide evsels regardless of
> user requested cpu in __perf_evlist__propagate_maps().  Those evsels
> need to be active on all cpus always.  Do it in the libperf so that we
> can guarantee it has proper maps.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/lib/perf/evlist.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6b1bafe267a4..187129652ab6 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -40,11 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  	 * We already have cpus for evsel (via PMU sysfs) so
>  	 * keep it, if there's no target cpu list defined.
>  	 */
> -	if (!evsel->own_cpus ||
> -	    (!evsel->system_wide && evlist->has_user_cpus) ||
> -	    (!evsel->system_wide &&
> -	     !evsel->requires_cpu &&
> -	     perf_cpu_map__empty(evlist->user_requested_cpus))) {
> +	if (evsel->system_wide) {
> +		perf_cpu_map__put(evsel->cpus);
> +		evsel->cpus = perf_cpu_map__new(NULL);
> +	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
> +		   (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
>  		perf_cpu_map__put(evsel->cpus);
>  		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>  	} else if (evsel->cpus != evsel->own_cpus) {
> @@ -52,7 +52,10 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>  	}
>  
> -	if (!evsel->system_wide) {
> +	if (evsel->system_wide) {
> +		perf_thread_map__put(evsel->threads);
> +		evsel->threads = perf_thread_map__new_dummy();
> +	} else {
>  		perf_thread_map__put(evsel->threads);
>  		evsel->threads = perf_thread_map__get(evlist->threads);
>  	}

