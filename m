Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E716F0CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjD0TjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244200AbjD0TjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:39:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1E213A;
        Thu, 27 Apr 2023 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624344; x=1714160344;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gAZ1EG7SDVbzwqKuwmJG1508A0ja1sgvVPDk5S/JuME=;
  b=TRfaxdLNvcanfpUmv6a39yyac3kIoLKsWT4vwibl86M5swFDxHcJcWmB
   tiToxRPqENkWdcEqkAVrXoYcaLe6f9EIbvwDZHP0StOE6uTLXqIdNZT/G
   zXzDqmliKaKLpzBBuJ1qqqTVbknwj1gDuwc6fot7fCxsn6O0BxIf8ApVg
   HqyMiQIQhbRsGzcZwGnEO1pZt+i8zYo/4bXNci0IVD5rbIPRGKRBUK99m
   2HD/XFT3VlBAtjVnsWY7PMScWZTviTrm/AT2erYIzDUM18mpx5PTXynLV
   2ki1ckEgr2HULSeU5L4RW/rW47UImfa5DXO6JyoX3WwZ9eztH7NuVtreM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410609764"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410609764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725063041"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="725063041"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2023 12:39:02 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CD829580377;
        Thu, 27 Apr 2023 12:38:58 -0700 (PDT)
Message-ID: <05b7b1cf-0b77-0e0f-8d02-1c26016fa7d8@linux.intel.com>
Date:   Thu, 27 Apr 2023 15:38:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 08/40] perf test: Test more sysfs events
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
 <20230426070050.1315519-9-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-9-irogers@google.com>
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
> Parse events for all PMUs, and not just cpu, in test "Parsing of all
> PMU events from sysfs".
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Run the test on Cascade Lake and Alder Lake. It looks good.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/tests/parse-events.c | 103 +++++++++++++++++---------------
>  1 file changed, 55 insertions(+), 48 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 8068cfd89b84..385bbbc4a409 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -7,6 +7,7 @@
>  #include "debug.h"
>  #include "pmu.h"
>  #include "pmu-hybrid.h"
> +#include "pmus.h"
>  #include <dirent.h>
>  #include <errno.h>
>  #include "fncache.h"
> @@ -2225,49 +2226,24 @@ static int test_pmu(void)
>  
>  static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -	struct stat st;
> -	char path[PATH_MAX];
> -	struct dirent *ent;
> -	DIR *dir;
> -	int ret;
> -
> -	if (!test_pmu())
> -		return TEST_SKIP;
> -
> -	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
> -		 sysfs__mountpoint());
> -
> -	ret = stat(path, &st);
> -	if (ret) {
> -		pr_debug("omitting PMU cpu events tests: %s\n", path);
> -		return TEST_OK;
> -	}
> +	struct perf_pmu *pmu;
> +	int ret = TEST_OK;
>  
> -	dir = opendir(path);
> -	if (!dir) {
> -		pr_debug("can't open pmu event dir: %s\n", path);
> -		return TEST_FAIL;
> -	}
> +	perf_pmus__for_each_pmu(pmu) {
> +		struct stat st;
> +		char path[PATH_MAX];
> +		struct dirent *ent;
> +		DIR *dir;
> +		int err;
>  
> -	ret = TEST_OK;
> -	while ((ent = readdir(dir))) {
> -		struct evlist_test e = { .name = NULL, };
> -		char name[2 * NAME_MAX + 1 + 12 + 3];
> -		int test_ret;
> +		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
> +			sysfs__mountpoint(), pmu->name);
>  
> -		/* Names containing . are special and cannot be used directly */
> -		if (strchr(ent->d_name, '.'))
> +		err = stat(path, &st);
> +		if (err) {
> +			pr_debug("skipping PMU %s events tests: %s\n", pmu->name, path);
> +			ret = combine_test_results(ret, TEST_SKIP);
>  			continue;
> -
> -		snprintf(name, sizeof(name), "cpu/event=%s/u", ent->d_name);
> -
> -		e.name  = name;
> -		e.check = test__checkevent_pmu_events;
> -
> -		test_ret = test_event(&e);
> -		if (test_ret != TEST_OK) {
> -			pr_debug("Test PMU event failed for '%s'", name);
> -			ret = combine_test_results(ret, test_ret);
>  		}
>  		/*
>  		 * Names containing '-' are recognized as prefixes and suffixes
> @@ -2282,17 +2258,48 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
>  		if (strchr(ent->d_name, '-'))
>  			continue;
>  
> -		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
> -		e.name  = name;
> -		e.check = test__checkevent_pmu_events_mix;
> -		test_ret = test_event(&e);
> -		if (test_ret != TEST_OK) {
> -			pr_debug("Test PMU event failed for '%s'", name);
> -			ret = combine_test_results(ret, test_ret);
> +		dir = opendir(path);
> +		if (!dir) {
> +			pr_debug("can't open pmu event dir: %s\n", path);
> +			ret = combine_test_results(ret, TEST_SKIP);
> +			continue;
>  		}
> -	}
>  
> -	closedir(dir);
> +		while ((ent = readdir(dir))) {
> +			struct evlist_test e = { .name = NULL, };
> +			char name[2 * NAME_MAX + 1 + 12 + 3];
> +			int test_ret;
> +
> +			/* Names containing . are special and cannot be used directly */
> +			if (strchr(ent->d_name, '.'))
> +				continue;
> +
> +			snprintf(name, sizeof(name), "%s/event=%s/u", pmu->name, ent->d_name);
> +
> +			e.name  = name;
> +			e.check = test__checkevent_pmu_events;
> +
> +			test_ret = test_event(&e);
> +			if (test_ret != TEST_OK) {
> +				pr_debug("Test PMU event failed for '%s'", name);
> +				ret = combine_test_results(ret, test_ret);
> +			}
> +
> +			if (!is_pmu_core(pmu->name))
> +				continue;
> +
> +			snprintf(name, sizeof(name), "%s:u,%s/event=%s/u", ent->d_name, pmu->name, ent->d_name);
> +			e.name  = name;
> +			e.check = test__checkevent_pmu_events_mix;
> +			test_ret = test_event(&e);
> +			if (test_ret != TEST_OK) {
> +				pr_debug("Test PMU event failed for '%s'", name);
> +				ret = combine_test_results(ret, test_ret);
> +			}
> +		}
> +
> +		closedir(dir);
> +	}
>  	return ret;
>  }
>  
