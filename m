Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B255EBB21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiI0HIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiI0HH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:07:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3DA4B9C;
        Tue, 27 Sep 2022 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664262475; x=1695798475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xsti2hypkMw1LA950JoOfgFLDko16IbEca7VEJd2gy4=;
  b=lfRU2ANJXjQ3EopvBSl3VGYh44G3p6MUEoZae53xqicGksP9v53Dykfz
   BSXI86ssv3Hpx0goYKk7cqMODsJ3bQ/lLFM5R56xLYB8Fh17dkfxRwkwu
   1LACfOj38H/h7zCiVTyP5ZKm3wonOEiBdW6hgaa4Y0jccXVpbCUFIO0tG
   K1C/XsLDAtv/L5ZGIqYEWF7+0pXgLOXKEFM+sI2g1e7gTBYzJYwSp7SXt
   HzonqunCxsM590GMXerOJTH05FqfNert+8AiH3ClY1Xfbel5grKnAQg/c
   8ESenpjRqzbuPAz9ZFlhx73kAcdJkLOieQg8/qkvnbazN8RGiqRqs8Xd/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302722253"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="302722253"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:07:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623654901"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="623654901"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:07:50 -0700
Message-ID: <0db456af-afec-4e0d-0f59-5a0f6f5b3781@intel.com>
Date:   Tue, 27 Sep 2022 10:07:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] perf tools: Add evlist__add_sched_switch()
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
 <20220924165737.956428-5-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220924165737.956428-5-namhyung@kernel.org>
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
> Add a help to create a system-wide sched_switch event.  One merit is
> that it sets the system-wide bit before adding it to evlist so that
> the libperf can handle the cpu and thread maps correctly.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 15 +++++----------
>  tools/perf/tests/switch-tracking.c  | 15 +++++----------
>  tools/perf/util/evlist.c            | 17 +++++++++++++++++
>  tools/perf/util/evlist.h            |  1 +
>  4 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 13933020a79e..793b35f2221a 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -11,6 +11,7 @@
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
>  #include <linux/zalloc.h>
> +#include <linux/err.h>
>  #include <cpuid.h>
>  
>  #include "../../../util/session.h"
> @@ -426,20 +427,14 @@ static int intel_pt_track_switches(struct evlist *evlist)
>  	if (!evlist__can_select_event(evlist, sched_switch))
>  		return -EPERM;
>  
> -	err = parse_event(evlist, sched_switch);
> -	if (err) {
> -		pr_debug2("%s: failed to parse %s, error %d\n",
> +	evsel = evlist__add_sched_switch(evlist, true);
> +	if (IS_ERR(evsel)) {
> +		err = PTR_ERR(evsel);
> +		pr_debug2("%s: failed to create %s, error = %d\n",
>  			  __func__, sched_switch, err);
>  		return err;
>  	}
>  
> -	evsel = evlist__last(evlist);
> -
> -	evsel__set_sample_bit(evsel, CPU);
> -	evsel__set_sample_bit(evsel, TIME);
> -
> -	evsel->core.system_wide = true;
> -	evsel->no_aux_samples = true;
>  	evsel->immediate = true;
>  
>  	return 0;
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 2d46af9ef935..87f565c7f650 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -6,6 +6,7 @@
>  #include <time.h>
>  #include <stdlib.h>
>  #include <linux/zalloc.h>
> +#include <linux/err.h>
>  #include <perf/cpumap.h>
>  #include <perf/evlist.h>
>  #include <perf/mmap.h>
> @@ -398,19 +399,13 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
>  		goto out;
>  	}
>  
> -	err = parse_event(evlist, sched_switch);
> -	if (err) {
> -		pr_debug("Failed to parse event %s\n", sched_switch);
> +	switch_evsel = evlist__add_sched_switch(evlist, true);
> +	if (IS_ERR(switch_evsel)) {
> +		err = PTR_ERR(switch_evsel);
> +		pr_debug("Failed to create event %s\n", sched_switch);
>  		goto out_err;
>  	}
>  
> -	switch_evsel = evlist__last(evlist);
> -
> -	evsel__set_sample_bit(switch_evsel, CPU);
> -	evsel__set_sample_bit(switch_evsel, TIME);
> -
> -	switch_evsel->core.system_wide = true;
> -	switch_evsel->no_aux_samples = true;
>  	switch_evsel->immediate = true;
>  
>  	/* Test moving an event to the front */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index dcf57b271ff1..6612b00949e7 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -288,6 +288,23 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>  	return evsel;
>  }
>  
> +struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
> +{
> +	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
> +
> +	if (IS_ERR(evsel))
> +		return evsel;
> +
> +	evsel__set_sample_bit(evsel, CPU);
> +	evsel__set_sample_bit(evsel, TIME);
> +
> +	evsel->core.system_wide = system_wide;
> +	evsel->no_aux_samples = true;
> +
> +	evlist__add(evlist, evsel);
> +	return evsel;
> +};
> +
>  int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
>  {
>  	struct evsel *evsel, *n;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 9d967fe3953a..16734c6756b3 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -127,6 +127,7 @@ static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
>  {
>  	return evlist__add_aux_dummy(evlist, true);
>  }
> +struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide);
>  
>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>  			 evsel__sb_cb_t cb, void *data);

