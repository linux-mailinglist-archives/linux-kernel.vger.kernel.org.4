Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2070B000
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjEUTrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEUTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:47:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FEDE;
        Sun, 21 May 2023 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684698453; x=1716234453;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2RHq3IOZHzRgH3n4XcG/RpKIxsFuCFKWZjvqJaygek8=;
  b=MugLwyvkt1pUJ2ieJ6Vum5dS1pSm9mLgOsNMX88P9nKTR5MVZuOf1EJi
   j2ZtKfhOLXKQiZJ5HSqOy8gCrtcACoHSOYgP3NW+K/qv6ptgKmNfpXlWN
   1y23MLLLqX4RrhPWC1uLYZYqNwejvVgGxb+FrKqrmA0ADa7792KosbZQd
   SYUrJG8JKVrjv1S7nPhxO0x4V2JrEXC0+xcmD35/fn0sdKb5+BQ7crN2p
   FRZnBF6EoV3Mk6Fo25KwvCdAwRxyrUoYfVOOdKzYDocPvnUuT4mJX1LOX
   YOvpeCaFdUIdR8NRaPlViB2J/aqnZ+zYsX73D3x2RDfyD/BqDIZej0N+B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337344912"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="337344912"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 12:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="827466087"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="827466087"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 21 May 2023 12:47:06 -0700
Received: from [10.212.161.251] (kliang2-mobl1.ccr.corp.intel.com [10.212.161.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8C3A0580ABD;
        Sun, 21 May 2023 12:47:03 -0700 (PDT)
Message-ID: <f9a04171-7f72-671b-2640-5dcdf8bc560e@linux.intel.com>
Date:   Sun, 21 May 2023 15:47:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 18/23] perf x86 mem: minor refactor to
 is_mem_loads_aux_event
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230517145803.559429-1-irogers@google.com>
 <20230517145803.559429-19-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517145803.559429-19-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> Find the PMU and then the event off of it.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/arch/x86/util/mem-events.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index f683ac702247..02d65e446f46 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -55,13 +55,13 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
>  
>  bool is_mem_loads_aux_event(struct evsel *leader)
>  {
> -	if (perf_pmu__find("cpu")) {
> -		if (!pmu_have_event("cpu", "mem-loads-aux"))
> -			return false;
> -	} else if (perf_pmu__find("cpu_core")) {
> -		if (!pmu_have_event("cpu_core", "mem-loads-aux"))
> -			return false;
> -	}
> +	struct perf_pmu *pmu = perf_pmu__find("cpu");
> +
> +	if (!pmu)
> +		pmu = perf_pmu__find("cpu_core");
> +
> +	if (pmu && !pmu_have_event(pmu->name, "mem-loads-aux"))
> +		return false;
>  
>  	return leader->core.attr.config == MEM_LOADS_AUX;
>  }
