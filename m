Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834F16F6060
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjECU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjECU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:58:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57893C1;
        Wed,  3 May 2023 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683147496; x=1714683496;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CcaDTugvRfhusAoscbKmMZGi4FnJFP59RjgnVGlSYcY=;
  b=SrhkSLhKnrvb5GPOh26Qz8YPalc+Ss+Q96RyDdZR81vtHofSlkSFnIF6
   jmR/JxREtigo3CSmC/e45FHuogEBF6col2lahp99MbnrtjLvjFYu9+gw5
   SUCJZGz2Jc6e7PzQVThoUTFjxyfT3YA3PHOXp9Sp/FL3cJmr4TX1SlGu2
   CB6TV2HSmhsso+UbXQ+pDyZa0HST9y2XXYsBqf4Fke+/h31+IogYf2FXh
   gWvKrLjpZ/5zhdIWl+jru54LU5JKEXrxR3OqldtPS7i+dFqKWYSdoGMmf
   K0ItclX6a6kP1NymdNOvrnUroQfa4E13chFRSeE2VvywMCQcf5ozvw8Ne
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="347588288"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="347588288"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 13:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="786251992"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="786251992"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2023 13:58:07 -0700
Received: from [10.209.46.175] (kliang2-mobl1.ccr.corp.intel.com [10.209.46.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C29AD580B0E;
        Wed,  3 May 2023 13:58:03 -0700 (PDT)
Message-ID: <f656fc55-b3f5-9ac7-426f-d87ae2dc99da@linux.intel.com>
Date:   Wed, 3 May 2023 16:58:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 04/44] perf parse-events: Don't reorder ungrouped
 events by pmu
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
References: <20230502223851.2234828-1-irogers@google.com>
 <20230502223851.2234828-5-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230502223851.2234828-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> The pmu_group_name by default returns "cpu" which on non-hybrid/ARM
> means that ungrouped software, and hardware events are all going to
> sort by the original insertion index. However, on hybrid and ARM
> wildcard expansion may mean the PMU name is set and events will be
> unnecessarily reordered - triggering the reordering warning.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/parse-events.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index d71019dcd614..34ba840ae19a 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2140,25 +2140,32 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
>  	int *leader_idx = state;
>  	int lhs_leader_idx = *leader_idx, rhs_leader_idx = *leader_idx, ret;
>  	const char *lhs_pmu_name, *rhs_pmu_name;
> +	bool lhs_has_group = false, rhs_has_group = false;
>  
>  	/*
>  	 * First sort by grouping/leader. Read the leader idx only if the evsel
>  	 * is part of a group, as -1 indicates no group.
>  	 */
> -	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1)
> +	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
> +		lhs_has_group = true;
>  		lhs_leader_idx = lhs_core->leader->idx;
> -	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1)
> +	}
> +	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
> +		rhs_has_group = true;
>  		rhs_leader_idx = rhs_core->leader->idx;
> +	}
>  
>  	if (lhs_leader_idx != rhs_leader_idx)
>  		return lhs_leader_idx - rhs_leader_idx;
>  
> -	/* Group by PMU. Groups can't span PMUs. */
> -	lhs_pmu_name = evsel__group_pmu_name(lhs);
> -	rhs_pmu_name = evsel__group_pmu_name(rhs);
> -	ret = strcmp(lhs_pmu_name, rhs_pmu_name);
> -	if (ret)
> -		return ret;
> +	/* Group by PMU if there is a group. Groups can't span PMUs. */
> +	if (lhs_has_group && rhs_has_group) {
> +		lhs_pmu_name = evsel__group_pmu_name(lhs);
> +		rhs_pmu_name = evsel__group_pmu_name(rhs);
> +		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* Architecture specific sorting. */
>  	return arch_evlist__cmp(lhs, rhs);
