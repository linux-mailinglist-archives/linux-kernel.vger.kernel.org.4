Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED86ED117
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDXPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:14:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0788110D3;
        Mon, 24 Apr 2023 08:14:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 508F74B3;
        Mon, 24 Apr 2023 08:15:26 -0700 (PDT)
Received: from [10.57.56.16] (unknown [10.57.56.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26C53F64C;
        Mon, 24 Apr 2023 08:14:39 -0700 (PDT)
Message-ID: <8acae291-2c3f-6010-de66-d4e54781d21f@arm.com>
Date:   Mon, 24 Apr 2023 16:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] perf: cs-etm: Fix timeless decode mode detection
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com
Cc:     denik@google.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230424134748.228137-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 14:47, James Clark wrote:
> In this context, timeless refers to the trace data rather than the perf
> event data. But when detecting whether there are timestamps in the trace
> data or not, the presence of a timestamp flag on any perf event is used.
> 
> Since commit f42c0ce573df ("perf record: Always get text_poke events
> with --kcore option") timestamps were added to a tracking event when
> --kcore is used which breaks this detection mechanism. Fix it by
> detecting if trace timestamps exist by looking at the ETM config flags.
> This would have always been a more accurate way of doing it anyway.
> 
> This fixes the following error message when using --kcore with
> Coresight:
> 
>    $ perf record --kcore -e cs_etm// --per-thread
>    $ perf report
>    The perf.data/data data has no samples!
> 
> Fixes: f42c0ce573df ("perf record: Always get text_poke events with --kcore option")
> Reported-by: Yang Shi <shy828301@gmail.com>
> Link: https://lore.kernel.org/lkml/CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com/
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 30 ++++++++++++++++++------------
>   1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8dd81ddd9e4e..50593289d53c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2684,26 +2684,29 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>   	return 0;
>   }
>   
> -static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
> +static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)

minor nit: "setup" sound more like prepare to do what is required to
do a timeless decoding, while we are doing more like, check if we
have to do a timeless decoding. So may be:

cs_etm_check_timeless_decoding() ?

>   {
>   	struct evsel *evsel;
>   	struct evlist *evlist = etm->session->evlist;
> -	bool timeless_decoding = true;
>   
>   	/* Override timeless mode with user input from --itrace=Z */
> -	if (etm->synth_opts.timeless_decoding)
> -		return true;
> +	if (etm->synth_opts.timeless_decoding) {
> +		etm->timeless_decoding = true;
> +		return 0;
> +	}
>   
>   	/*
> -	 * Circle through the list of event and complain if we find one
> -	 * with the time bit set.
> +	 * Find the cs_etm evsel and look at what its timestamp setting was
>   	 */
> -	evlist__for_each_entry(evlist, evsel) {
> -		if ((evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
> -			timeless_decoding = false;
> -	}
> +	evlist__for_each_entry(evlist, evsel)

minor nit: please retain the braces

> +		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
> +			etm->timeless_decoding =
> +				!(evsel->core.attr.config & BIT(ETM_OPT_TS));


> +			return 0;
> +		}

Otherwise, looks good to me

Suzuki


