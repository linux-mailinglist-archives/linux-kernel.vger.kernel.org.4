Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C85EBB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiI0HGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI0HGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:06:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DC26113;
        Tue, 27 Sep 2022 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664262409; x=1695798409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aU7ZmPFpMvOZO9aZbJWV7cyRwyIHAiDg2p8jcvSemII=;
  b=ghRZ7I9PJpxcOW/6Yke9hUQ4KVOeiwQXcuxdxlqVQRi/7s2VWqZaS8l1
   DFq2+rJpY404PzCDsKJPnKAmVoB3E6Jak/Cb4zpz2M7qtGZ+fGLyn3ZoQ
   3pXCJzNXX/SQoYHuXJGjSkhEi6HWBEXv+RnB0g/8CjD3EdFgwfayLC0PL
   IyfUO2bOfoFa8SFRgRfWW+a8D3M5CoGCJmnNFCuGbNde/zek9M9/daPJt
   fyGx+yl+lC0jEtyTnvyXM7CiZOdUOTPIzSt98bWlEiVTAmwCsBgP+YOUH
   feQrd/YELkR8cLX2632dWkdc5aNNFqpXp9MeWYfFv5MoGIp5NA5MIL7du
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281611891"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="281611891"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:06:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623654582"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="623654582"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:06:47 -0700
Message-ID: <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com>
Date:   Tue, 27 Sep 2022 10:06:42 +0300
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
References: <20220924165737.956428-1-namhyung@kernel.org>
 <20220924165737.956428-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220924165737.956428-3-namhyung@kernel.org>
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
> The current code propagate evsel's cpu map settings to evlist when it's
> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> be updated in perf_evlist__set_maps() later.  No need to do it before
> evlist's cpus are set actually.
> 
> Actually we discarded this intermediate all_cpus maps at the beginning
> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> an evsel is added after the evlist cpu maps are set.

That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
added to the evlist.  It can also remove an evsel from the evlist.

There might be other cases like that, but that was just one that stuck
out.

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/evlist.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 187129652ab6..cc070c3a134d 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -67,10 +67,6 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel;
>  
> -	/* Recomputing all_cpus, so start with a blank slate. */
> -	perf_cpu_map__put(evlist->all_cpus);
> -	evlist->all_cpus = NULL;
> -
>  	perf_evlist__for_each_evsel(evlist, evsel)
>  		__perf_evlist__propagate_maps(evlist, evsel);
>  }
> @@ -81,7 +77,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
>  	evsel->idx = evlist->nr_entries;
>  	list_add_tail(&evsel->node, &evlist->entries);
>  	evlist->nr_entries += 1;
> -	__perf_evlist__propagate_maps(evlist, evsel);
> +
> +	if (evlist->all_cpus)
> +		__perf_evlist__propagate_maps(evlist, evsel);
>  }
>  
>  void perf_evlist__remove(struct perf_evlist *evlist,

