Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8475EF0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiI2Isp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiI2Isg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:48:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E645AC3B1;
        Thu, 29 Sep 2022 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664441315; x=1695977315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UF7SBK5fl8dfoc9PAQ181e/4kWiETwF7OwgO7tV4u/I=;
  b=imfrlLppFb1GaYmixMmHU17tdcFmaV8aF7fFaw+nWjEl5LWyfoK5gOSf
   iM773myt+pzLwfGEU/ZdSTEqX4+tEx6NKUQ0XIRdubS80HmURJEKklIo/
   q0905wBMHjDy2ZoCzT3rorSkldlqUEJd3clajk+dTNxOehT/sGe/UC+vU
   iFwOZ9+orBwVeB0Hd1d+Xq8kWT8lNzdHr+WQYJTYGwPSMmlwRwFVN1kEq
   qOZ2VU8mbASWvxUDZs77NTT/d++s6xv1d+n3zFM9+X+r+FeabP0dHPLQX
   zxwUhhsR8VN+hoRJNPdN0qqjYfFnw6SJ1tD3Jp3dQo0as9Ll+T0TWqbm1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="281550047"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="281550047"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:48:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867306615"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867306615"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.231]) ([10.238.4.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:48:23 -0700
Message-ID: <e685d636-52cd-b34a-2d10-90c16b2e57cf@linux.intel.com>
Date:   Thu, 29 Sep 2022 16:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 03/22] perf metrics: Don't scale counts going into
 metrics
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220928072204.1613330-1-irogers@google.com>
 <20220928072204.1613330-4-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220928072204.1613330-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2022 3:21 PM, Ian Rogers wrote:
> Counts are scaled prior to going into saved_value, reverse the scaling
> so that metrics don't double scale values.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/stat-shadow.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 9e1eddeff21b..b5cedd37588f 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -865,11 +865,16 @@ static int prepare_metric(struct evsel **metric_events,
>   			if (!v)
>   				break;
>   			stats = &v->stats;
> -			scale = 1.0;
> +			/*
> +			 * If an event was scaled during stat gathering, reverse
> +			 * the scale before computing the metric.
> +			 */
> +			scale = 1.0 / metric_events[i]->scale;
> +
This look likes not work for kernel side events like 
/sys/devices/uncore_imc_*/events/cas_count_read(write).

>   			source_count = evsel__source_count(metric_events[i]);
>   
>   			if (v->metric_other)
> -				metric_total = v->metric_total;
> +				metric_total = v->metric_total * scale;
>   		}
>   		n = strdup(evsel__metric_id(metric_events[i]));
>   		if (!n)

-- 
Zhengjun Xing
