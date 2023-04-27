Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBE6F0CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjD0UCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0UCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:02:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960F2D74;
        Thu, 27 Apr 2023 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682625737; x=1714161737;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cj+IzPjwDDjU0dEpBGzoC7xu4ot/pyj5P09xXcocUfs=;
  b=YjhsGScNmGxGVc7TaZL7EPR1D9iViimzD1lGckgQ4tHZ6nN4ojecEJH2
   tJmC3OlV441hyBkckG29NwqbMdMYgLmpn9VUiqBz4Iw3+0mfnyb/f6j7+
   48sJESFK1IY0GlPn/TwbdmpplrUrMvR4c5mihPYhw5VeFaBM9fPDd0K2n
   0y8RYX8cE40Nw9a5FKhh8WALQb8TId4QzOUSBvAcbuqvCgsH5VL2FqTIn
   1734QV3Pbrwnf12AqJAyMKvRy9Z9abiG7098J6WljbJvEmQ/31IlThkj8
   wmFY8H29Y9wBw5fyF7rm5qyO1cITBP/uvUNSf7SSYnU5bwu8E+iUBqfCb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331842814"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="331842814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 13:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024254941"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024254941"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 13:00:53 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 91DB3580377;
        Thu, 27 Apr 2023 13:00:49 -0700 (PDT)
Message-ID: <329abaf5-8c21-c7a9-30e4-fec2a3c38e3c@linux.intel.com>
Date:   Thu, 27 Apr 2023 16:00:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 13/40] perf parse-events: Set attr.type to PMU type
 early
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
 <20230426070050.1315519-14-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> Set attr.type to PMU type early so that later terms can override the
> value. Setting the value in perf_pmu__config means that earlier steps,
> like config_term_pmu, can override the value.
>

Looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Signed-off-by: Ian Rogers <irogers@google.com> ---
>  tools/perf/util/parse-events.c | 2 +-
>  tools/perf/util/pmu.c          | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index d71019dcd614..4ba01577618e 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1492,9 +1492,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	} else {
>  		memset(&attr, 0, sizeof(attr));
>  	}
> +	attr.type = pmu->type;
>  
>  	if (!head_config) {
> -		attr.type = pmu->type;
>  		evsel = __add_event(list, &parse_state->idx, &attr,
>  				    /*init_attr=*/true, /*name=*/NULL,
>  				    /*metric_id=*/NULL, pmu,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ad209c88a124..cb33d869f1ed 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1398,7 +1398,6 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
>  {
>  	bool zero = !!pmu->default_config;
>  
> -	attr->type = pmu->type;
>  	return perf_pmu__config_terms(pmu->name, &pmu->format, attr,
>  				      head_terms, zero, err);
>  }
