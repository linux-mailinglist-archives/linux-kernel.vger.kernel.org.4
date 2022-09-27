Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B15EBB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiI0HH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiI0HHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:07:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B101A4B9C;
        Tue, 27 Sep 2022 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664262443; x=1695798443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rlNDwSLWx3f4lmu4j5q0PFgkWlZ6Anv+79t3Xcf6qRI=;
  b=OH46WMHJOjxyPEiAcWWOh6927kKgaLjx2J3mGvjjv/LQw4URfRAH0Kci
   x2qAOM7UYOBog9JS/5qcezzZZEBwbyCAa6VkiUhuZe1jViD1jgEQPiwZn
   /HzNVKslW5ytmcpu9ZeHA/wWOt/FfrxOLWJlfEAfxZAlQe0JmpGrbMrWG
   WZYahT1PNhLpkhRtdnvcvRcEZjY9E5JNwfWmYWQpYIOnZPmrSatLg8wIo
   ydEY3GK3vOXPHA0zWwUGX8LUsmeIK6flj8lfDZj9TzA5zWYjd9iRYoYhW
   kCq9ETk2kSAPGesw4QRPOvI1GAKTtStHWgGqOQf6YR+HlttCjTtv/FXF3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="299961064"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="299961064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:07:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623654739"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="623654739"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:07:20 -0700
Message-ID: <810a3f64-d2c9-62b0-33df-81ff57de6a3b@intel.com>
Date:   Tue, 27 Sep 2022 10:07:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] perf tools: Get rid of evlist__add_on_all_cpus()
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
 <20220924165737.956428-4-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220924165737.956428-4-namhyung@kernel.org>
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
> The cpu and thread maps are properly handled in libperf now.  No need to
> do it in the perf tools anymore.  Let's remove the logic.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/evlist.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index fcfe5bcc0bcf..dcf57b271ff1 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -268,28 +268,6 @@ int evlist__add_dummy(struct evlist *evlist)
>  	return 0;
>  }
>  
> -static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
> -{
> -	evsel->core.system_wide = true;
> -
> -	/*
> -	 * All CPUs.
> -	 *
> -	 * Note perf_event_open() does not accept CPUs that are not online, so
> -	 * in fact this CPU list will include only all online CPUs.
> -	 */
> -	perf_cpu_map__put(evsel->core.own_cpus);
> -	evsel->core.own_cpus = perf_cpu_map__new(NULL);
> -	perf_cpu_map__put(evsel->core.cpus);
> -	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> -
> -	/* No threads */
> -	perf_thread_map__put(evsel->core.threads);
> -	evsel->core.threads = perf_thread_map__new_dummy();
> -
> -	evlist__add(evlist, evsel);
> -}
> -
>  struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>  {
>  	struct evsel *evsel = evlist__dummy_event(evlist);
> @@ -302,14 +280,11 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>  	evsel->core.attr.exclude_hv = 1;
>  	evsel->core.attr.freq = 0;
>  	evsel->core.attr.sample_period = 1;
> +	evsel->core.system_wide = system_wide;
>  	evsel->no_aux_samples = true;
>  	evsel->name = strdup("dummy:u");
>  
> -	if (system_wide)
> -		evlist__add_on_all_cpus(evlist, evsel);
> -	else
> -		evlist__add(evlist, evsel);
> -
> +	evlist__add(evlist, evsel);
>  	return evsel;
>  }
>  

