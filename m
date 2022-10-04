Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DBF5F42C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJDMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:14:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C413DEA;
        Tue,  4 Oct 2022 05:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00A6FCE106D;
        Tue,  4 Oct 2022 12:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4226C433D6;
        Tue,  4 Oct 2022 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664885654;
        bh=9aQvtsA0yunPbT9ACGKHCp6b9GmT4b2uDIySCi7YjI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVlUVmGLL5spd15E5ejr9S31TuphQWPCUOijTpJSPZcKvRwl/o4eg030uPsxPhxyz
         sXLdGTMMu2BThRN/7OTOkzXQ1MRg1WxgD5k4Mn+ZyMOMIa7ETBrZWPajYSswI1HBJB
         8fsPtJ9Z7Ck5b/KGNVhrTD11VDHloQbM6w9oP8J7CuiNkmQLIkIZAdBcWg24FTT+Fg
         o0bNw+AwVwRo60gxmkni54FJ7EwdaFj99rLAr1s0SBDm0Ir4I92bLr6uL0Xy+ANOy6
         6JDyJ4bQIp4Gmc4r5T1b7bcW5UAmgvGXFxUlq6hN+iJ0GdnNUeCAqYLa3XoslbUQTf
         jRzzIFaNoeAzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 589F24062C; Tue,  4 Oct 2022 09:14:11 -0300 (-03)
Date:   Tue, 4 Oct 2022 09:14:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
Message-ID: <YzwjkwgfAyMZRHpN@kernel.org>
References: <20221003204647.1481128-1-namhyung@kernel.org>
 <20221003204647.1481128-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003204647.1481128-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 03, 2022 at 01:46:44PM -0700, Namhyung Kim escreveu:
> The current code propagate evsel's cpu map settings to evlist when it's
> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> be updated in perf_evlist__set_maps() later.  No need to do it before
> evlist's cpus are set actually.
> 
> In fact it discards this intermediate all_cpus maps at the beginning
> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> an evsel is added after the evlist cpu/thread maps are set.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/evlist.c                  | 11 ++++-------
>  tools/lib/perf/include/internal/evlist.h |  1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 187129652ab6..8ce92070086c 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -67,9 +67,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel;
>  
> -	/* Recomputing all_cpus, so start with a blank slate. */
> -	perf_cpu_map__put(evlist->all_cpus);
> -	evlist->all_cpus = NULL;
> +	evlist->needs_map_propagation = true;
>  
>  	perf_evlist__for_each_evsel(evlist, evsel)
>  		__perf_evlist__propagate_maps(evlist, evsel);
> @@ -81,7 +79,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
>  	evsel->idx = evlist->nr_entries;
>  	list_add_tail(&evsel->node, &evlist->entries);
>  	evlist->nr_entries += 1;
> -	__perf_evlist__propagate_maps(evlist, evsel);
> +
> +	if (evlist->needs_map_propagation)
> +		__perf_evlist__propagate_maps(evlist, evsel);
>  }
>  
>  void perf_evlist__remove(struct perf_evlist *evlist,
> @@ -177,9 +177,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
>  		evlist->threads = perf_thread_map__get(threads);
>  	}
>  
> -	if (!evlist->all_cpus && cpus)
> -		evlist->all_cpus = perf_cpu_map__get(cpus);
> -
>  	perf_evlist__propagate_maps(evlist);

IIRC Adrian suggested this extra thing, but he provided the Reviewed-by
for the previous patch, where this isn't present, Adrian, can you please
confirm this and if this is the case provide your Reviewed-by for this
new version?

Thanks,

- Arnaldo

>  }
>  
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 6f89aec3e608..850f07070036 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -19,6 +19,7 @@ struct perf_evlist {
>  	int			 nr_entries;
>  	int			 nr_groups;
>  	bool			 has_user_cpus;
> +	bool			 needs_map_propagation;
>  	/**
>  	 * The cpus passed from the command line or all online CPUs by
>  	 * default.
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog

-- 

- Arnaldo
