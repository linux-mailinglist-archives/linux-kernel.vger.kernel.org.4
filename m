Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDE85F2830
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJCFgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJCFgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:36:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37287326E0;
        Sun,  2 Oct 2022 22:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664775376; x=1696311376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GwdFCl6Z65D1yRmGZz1bLaAtfV0gX8s0YvhEwHsJxh4=;
  b=QpwB5XXrZkWebC7a+FB3uit3NJjdzidqqSmnKYl4BhV5+5KoU+iV1PeA
   CYFvaeBWvTJDTEFHzolAc5MGVHfMtj2ivBs81SR+HOYGbfqhCFhvHCyxV
   Eb258aLbEARCGefXsTOzfA1JcJuKQh1/N/mJyf5ZAqlgKVdATCMCS3M7O
   otugKumpTTiRgdSWCKwy3MS1YV04rVzMJdTVwIFREPNvlTa2tzPEkwLP/
   j3/cNhQmXgi6vyUQIMpHTs4IIbZV1Wic2K/eUD2RL4R2dhRe6rUxKryOI
   JckbrDym2eh3t772ywMhbnngRcW3KY/kSmXPUFKUU0qDFg4nCHm1XIJwd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="282263457"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="282263457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 22:36:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="654228032"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="654228032"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 22:36:12 -0700
Message-ID: <cf352fd8-39dd-6b56-176a-61701be57f89@intel.com>
Date:   Mon, 3 Oct 2022 08:36:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
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
References: <20220930172714.711616-1-namhyung@kernel.org>
 <20220930172714.711616-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220930172714.711616-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/22 20:27, Namhyung Kim wrote:
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
>  tools/lib/perf/evlist.c                  | 8 ++++----
>  tools/lib/perf/include/internal/evlist.h | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 187129652ab6..c5f65b89d77a 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -67,9 +67,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel;
>  
> -	/* Recomputing all_cpus, so start with a blank slate. */
> -	perf_cpu_map__put(evlist->all_cpus);
> -	evlist->all_cpus = NULL;

If you remove this, then you also need to remove the setting in
perf_evlist__set_maps, so that we still start with a blank slate.
i.e.

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 8ec5b9f344e0..4aeffcbc11d1 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -174,9 +174,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
-	if (!evlist->all_cpus && cpus)
-		evlist->all_cpus = perf_cpu_map__get(cpus);
-
 	perf_evlist__propagate_maps(evlist);
 }
 

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

