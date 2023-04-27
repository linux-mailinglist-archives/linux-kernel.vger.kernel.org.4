Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B566F0C66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbjD0TMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjD0TMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:12:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F06114;
        Thu, 27 Apr 2023 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622735; x=1714158735;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pnW5qMLh79Dl32TPLXe6aP7KhsJKvNpI6UV1iCK3VYQ=;
  b=jYC5V37d9Bw8T6jrIKoknlDS/HtdKzUvaeL8PPtXqn9uIm4LjeeNmdi8
   pIdbhIND6GYnGC+TYlkmGqtNYapyjVRG9IhJ0wR6oE/eSs44j8yGPwfk5
   +oJTf7JE7nZJ27PnqksTxe/l6fHMWknhzudOl14Fpep9KfKDbBbDb9Zos
   0qp+5+ipKbY5Wv3hNTTPYO7L7oT/99TvjzqDZFsGJxg7SnsNvK8NrxpHW
   +syZyJa1SwGs2UgrD+yqdJI1ocv08PyvH5/uwt3GRwDdhSH6Zbyx6fWzu
   8lUf+B923ZXRsco/pwQkYVRE/XqXULl448PDQ+cIGPc2xLBJtOduVq9iF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336540560"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336540560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="688540380"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="688540380"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 27 Apr 2023 12:11:54 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 74010580377;
        Thu, 27 Apr 2023 12:11:50 -0700 (PDT)
Message-ID: <15ca8bed-db47-182e-1ae3-33e273027776@linux.intel.com>
Date:   Thu, 27 Apr 2023 15:11:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 07/40] perf stat: Avoid segv on counter->name
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
 <20230426070050.1315519-8-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-8-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> Switch to use evsel__name that doesn't return NULL for hardware and
> similar events.

This one should be backport to 6.4. It helps to fix the Segmentation
fault with default mode.
https://lore.kernel.org/lkml/2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com/


> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 6b46bbb3d322..71dd6cb83918 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter)
>  	int ret = 0;
>  
>  	if (counter->uniquified_name || counter->use_config_name ||
> -	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> +	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
>  					   strlen(counter->pmu_name)))
>  		return;
>  
