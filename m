Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091D670B01B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEUUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 16:07:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DBEDE;
        Sun, 21 May 2023 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684699622; x=1716235622;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HwsbC2jKcQli9wh7b3iVXWoPZB7P/2qtGKKljalL3m8=;
  b=LawMnPawMcn5ZGJaZVgegVvcQKujjPBwx5EgL+Ef54HGyj50n+pi6MMo
   iADtxm/+q75x9Xv2Hoe0SJUvH0g2wsL+4R75EX14/Lxt/Qk4aO/K2VcZw
   hk0noCdfU1Ru1RFo1N4OVtZ6LGuAyU5YhogOsiAK3S+q/KP8SGO9Lvfrp
   OOLufFvP/hdArHm84ffHSmth7NnPJ/ap/KRQRwOJ6m/avE2VMZIm60Ypp
   AN37B0JI0bSzsDeOuFcz0heQ+UBQVhXkiOl1F4BolsGZidJSm27oqfqr6
   sOaIHLED+T/SOT2HfGi1SGTCI0ZXsxdEEmA4Yw+5HjbjE34jG6kk0LRLA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="439117224"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="439117224"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 13:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="949809290"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="949809290"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 May 2023 13:03:05 -0700
Received: from [10.212.161.251] (kliang2-mobl1.ccr.corp.intel.com [10.212.161.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8572C580BA0;
        Sun, 21 May 2023 13:02:58 -0700 (PDT)
Message-ID: <efd8389a-aef1-96de-273a-ebac565cb852@linux.intel.com>
Date:   Sun, 21 May 2023 16:02:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 20/23] perf pmus: Split pmus list into core and uncore
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
 <20230517145803.559429-21-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517145803.559429-21-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 10:58 a.m., Ian Rogers wrote:
> Split the pmus list into core and uncore. This will later allow for
> the core and uncore pmus to be populated separately.

I think the "uncore pmus" here means the other non-core PMUs, right? If
so, I think the "uncore pmus" is misleading, since we have a dedicated
uncore driver/PMU. Maybe we can use "other pmus" instead.

Thanks,
Kan
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 2fb28e583366..dd029a810147 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -12,13 +12,19 @@
>  #include "pmu.h"
>  #include "print-events.h"
>  
> -static LIST_HEAD(pmus);
> +static LIST_HEAD(core_pmus);
> +static LIST_HEAD(uncore_pmus);
>  
>  void perf_pmus__destroy(void)
>  {
>  	struct perf_pmu *pmu, *tmp;
>  
> -	list_for_each_entry_safe(pmu, tmp, &pmus, list) {
> +	list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
> +		list_del(&pmu->list);
> +
> +		perf_pmu__delete(pmu);
> +	}
> +	list_for_each_entry_safe(pmu, tmp, &uncore_pmus, list) {
>  		list_del(&pmu->list);
>  
>  		perf_pmu__delete(pmu);
> @@ -29,7 +35,12 @@ static struct perf_pmu *pmu_find(const char *name)
>  {
>  	struct perf_pmu *pmu;
>  
> -	list_for_each_entry(pmu, &pmus, list) {
> +	list_for_each_entry(pmu, &core_pmus, list) {
> +		if (!strcmp(pmu->name, name) ||
> +		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
> +			return pmu;
> +	}
> +	list_for_each_entry(pmu, &uncore_pmus, list) {
>  		if (!strcmp(pmu->name, name) ||
>  		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>  			return pmu;
> @@ -53,7 +64,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
>  		return pmu;
>  
>  	dirfd = perf_pmu__event_source_devices_fd();
> -	pmu = perf_pmu__lookup(&pmus, dirfd, name);
> +	pmu = perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore_pmus, dirfd, name);
>  	close(dirfd);
>  
>  	return pmu;
> @@ -72,7 +83,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>  	if (pmu)
>  		return pmu;
>  
> -	return perf_pmu__lookup(&pmus, dirfd, name);
> +	return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore_pmus, dirfd, name);
>  }
>  
>  /* Add all pmus in sysfs to pmu list: */
> @@ -93,7 +104,7 @@ static void pmu_read_sysfs(void)
>  	while ((dent = readdir(dir))) {
>  		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
>  			continue;
> -		/* add to static LIST_HEAD(pmus): */
> +		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(uncore_pmus): */
>  		perf_pmu__find2(fd, dent->d_name);
>  	}
>  
> @@ -104,24 +115,37 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
>  {
>  	struct perf_pmu *pmu;
>  
> -	list_for_each_entry(pmu, &pmus, list)
> +	list_for_each_entry(pmu, &core_pmus, list) {
>  		if (pmu->type == type)
>  			return pmu;
> -
> +	}
> +	list_for_each_entry(pmu, &uncore_pmus, list) {
> +		if (pmu->type == type)
> +			return pmu;
> +	}
>  	return NULL;
>  }
>  
> +/*
> + * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
> + * next pmu. Returns NULL on end.
> + */
>  struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
>  {
> -	/*
> -	 * pmu iterator: If pmu is NULL, we start at the begin,
> -	 * otherwise return the next pmu. Returns NULL on end.
> -	 */
> +	bool use_core_pmus = !pmu || pmu->is_core;
> +
>  	if (!pmu) {
>  		pmu_read_sysfs();
> -		pmu = list_prepare_entry(pmu, &pmus, list);
> +		pmu = list_prepare_entry(pmu, &core_pmus, list);
> +	}
> +	if (use_core_pmus) {
> +		list_for_each_entry_continue(pmu, &core_pmus, list)
> +			return pmu;
> +
> +		pmu = NULL;
> +		pmu = list_prepare_entry(pmu, &uncore_pmus, list);
>  	}
> -	list_for_each_entry_continue(pmu, &pmus, list)
> +	list_for_each_entry_continue(pmu, &uncore_pmus, list)
>  		return pmu;
>  	return NULL;
>  }
