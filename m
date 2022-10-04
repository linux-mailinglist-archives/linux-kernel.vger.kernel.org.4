Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F25F3C70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJDFVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJDFVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:21:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E648C8C;
        Mon,  3 Oct 2022 22:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664860866; x=1696396866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T6cn1OaDpD1I/vxer2YmvL68cBuWqEI8h8w3+Ai7p64=;
  b=DqM/+YlYk2Zd61TWmlDpIOQ7R/WQ7TFbi1EzQSTeEywX8oLoajkMK71V
   x5TziyI4AfYAm9EPjHqqWCrjRyvhNHOccYdFdw8WYMWFUMKo1QLesMPET
   +I20maFV6qblZcN+/cTHmpSTdB7+hT/WVxM+xZTm0CmefSiBEd1SqDO7p
   hFdw7f9GhisAvxDWbgc6xVXr323rIRakXWyTQ2KoDPPqB3JCnh9Tf6Jlc
   MPcgk4WKi+H2MTzAo5ybA7WY0CFSa3VQwbqZp0lF/Avp1dm/Uzm1+wX6q
   xopceT2NDHzOSjDK8uAWRw+XMyGXBMUFZQYKoyw40rzhTuKFf4kdUNKtD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300432536"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="300432536"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 22:21:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="574909091"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="574909091"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 22:21:02 -0700
Message-ID: <d93a2a3e-25dd-a67f-be01-409970241295@intel.com>
Date:   Tue, 4 Oct 2022 08:20:58 +0300
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
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

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

