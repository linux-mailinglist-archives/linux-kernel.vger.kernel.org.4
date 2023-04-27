Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F96F0CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjD0UNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjD0UNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:13:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677F46A5;
        Thu, 27 Apr 2023 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682626366; x=1714162366;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gkgzXX7acwSBnuJ9bdx4m5R1AVWdzJYvB7t1tP5cDvg=;
  b=ga9laUOlFSTypI2r0ajwWoZ+EaBwaKXXSB2V3UVcMeYZAnNQyqaU/m6/
   fOQYMojH1iImLK4ynzJrJkKVEBZNf2WxMFZjMeYkLJT1Mk2rQeuCZXFMH
   vdvXkCx4tUrI20tFxM2O6+AYnoI6OZxXNhydhP1kgrqCeevg5P1NkSTcJ
   od4ulSSSm3+E0ChPNJRtCGYhyk0jP6TQBs4iudGXkuqdYdPrKUo4GSwxR
   ywHLFk/+Z4q7cRl08eddgjC8V7uVUWnrWV0RflQ+XHgo28uvPKmqN6hEo
   gjTaCkJlK4yCuOScwR6HcVGzweSdDOJP/XR+kGlJ1f1ygilJQEdDZEm5E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410619736"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410619736"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 13:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="671906819"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="671906819"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2023 13:12:45 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 76609580377;
        Thu, 27 Apr 2023 13:12:41 -0700 (PDT)
Message-ID: <e0532c12-e682-a72c-baa0-11b208a639e4@linux.intel.com>
Date:   Thu, 27 Apr 2023 16:12:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 17/40] perf evsel: Modify group pmu name for software
 events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426070050.1315519-1-irogers@google.com>
 <20230426070050.1315519-18-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-18-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> If we have a group of {cycles,faults} then we need the faults software
> event to appear to be on the same PMU as cycles so that we don't split
> the group in parse_events__sort_events_and_fix_groups. This case is
> relatively easy as cycles is the leader and will have a PMU name. In
> the reverse case, {faults,cycles} we still need faults to appear to
> have the PMU name of cycles but the old behavior is just to return
> "cpu". For hybrid this fails as cycles will be on "cpu_core" or
> "cpu_atom", causing faults to be split into a different group.
> 
> Change the behavior for software events so that the whole group is
> searched for the named PMU.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/evsel.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1cd04b5998d2..63522322e118 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -829,23 +829,26 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
>  
>  const char *evsel__group_pmu_name(const struct evsel *evsel)
>  {
> -	const struct evsel *leader;
> +	struct evsel *leader, *pos;
>  
>  	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
>  	if (evsel->pmu_name)
>  		return evsel->pmu_name;
>  	/*
>  	 * Software events may be in a group with other uncore PMU events. Use
> -	 * the pmu_name of the group leader to avoid breaking the software event
> -	 * out of the group.
> +	 * the pmu_name of the first non-software event to avoid breaking the
> +	 * software event out of the group.
>  	 *
>  	 * Aux event leaders, like intel_pt, expect a group with events from
>  	 * other PMUs, so substitute the AUX event's PMU in this case.
>  	 */
>  	leader  = evsel__leader(evsel);
> -	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
> -	    leader->pmu_name) {
> -		return leader->pmu_name;
> +	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
> +		/* Starting with the leader, find the first event with a named PMU. */
> +		for_each_group_evsel(pos, leader) {
> +			if (pos->pmu_name)
> +				return pos->pmu_name;
> +		}
>  	}
>  
>  	return "cpu";
