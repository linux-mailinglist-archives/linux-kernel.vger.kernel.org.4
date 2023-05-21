Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8917E70AFFF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjEUToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEUToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:44:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C657E0;
        Sun, 21 May 2023 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684698239; x=1716234239;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=h61w7xvT2W3XClwNo/URPG1RbsoBvLg4/hlAAzoUdUo=;
  b=KcOnOme731NBDzT4BUKV/F/ZHFT+nHf1Nw6wtfCGKnrDguEGrIo2sKQf
   xwQCr/VGHGoz7d8Hb8YVzpuz2QYV6N+X7qS54nX9eGQQ+CBr8I02qCc9r
   UNj9602ldh6vkIuyqUhc2re/zJW8889668JK86v501fMzn4gHGt0yEkhD
   z1+K+HhStL7Im4J3oe03IcRKeAYbtAi+BoN9QTJMCSLa91wD92K4sA6HG
   0pQOpHdF6ctNCP/SOl7bICPeb1OTyYHW0PdMiuSGkdRiQRHM1VQmfj5Ny
   5r8jpD5i4EsyY0hTk1kltQggkhn2mnWy7dtXWXlLrCMJKJZCdQwBnN09z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="351600478"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="351600478"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 12:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703232220"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="703232220"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2023 12:43:58 -0700
Received: from [10.212.161.251] (kliang2-mobl1.ccr.corp.intel.com [10.212.161.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C38CE580BA0;
        Sun, 21 May 2023 12:43:54 -0700 (PDT)
Message-ID: <67147a30-dd5b-35b5-c63e-a838d56b8220@linux.intel.com>
Date:   Sun, 21 May 2023 15:43:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 17/23] perf pmus: Prefer perf_pmu__scan over
 perf_pmus__for_each_pmu
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
 <20230517145803.559429-18-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517145803.559429-18-irogers@google.com>
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



On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> perf_pmus__for_each_pmu doesn't lazily initialize pmus making its use
> error prone. Just use perf_pmu__scan as this only impacts
> non-performance critical tests.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/bench/pmu-scan.c     |  6 ++----
>  tools/perf/tests/event_groups.c |  7 ++-----
>  tools/perf/tests/parse-events.c | 11 ++++-------
>  tools/perf/util/pmus.h          |  2 --
>  4 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
> index f0f007843bb8..f4a6c37cbe27 100644
> --- a/tools/perf/bench/pmu-scan.c
> +++ b/tools/perf/bench/pmu-scan.c
> @@ -40,13 +40,11 @@ static struct pmu_scan_result *results;
>  
>  static int save_result(void)
>  {
> -	struct perf_pmu *pmu;
> +	struct perf_pmu *pmu = NULL;
>  	struct list_head *list;
>  	struct pmu_scan_result *r;
>  
> -	perf_pmu__scan(NULL);
> -
> -	perf_pmus__for_each_pmu(pmu) {
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>  		r = realloc(results, (nr_pmus + 1) * sizeof(*r));
>  		if (r == NULL)
>  			return -ENOMEM;
> diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
> index 029442b4e9c6..3d9a2b524bba 100644
> --- a/tools/perf/tests/event_groups.c
> +++ b/tools/perf/tests/event_groups.c
> @@ -50,13 +50,10 @@ static int event_open(int type, unsigned long config, int group_fd)
>  
>  static int setup_uncore_event(void)
>  {
> -	struct perf_pmu *pmu;
> +	struct perf_pmu *pmu = NULL;
>  	int i, fd;
>  
> -	if (list_empty(&pmus))
> -		perf_pmu__scan(NULL);
> -
> -	perf_pmus__for_each_pmu(pmu) {
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>  		for (i = 0; i < NR_UNCORE_PMUS; i++) {
>  			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
>  				pr_debug("Using %s for uncore pmu event\n", pmu->name);
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 72a10bed84fd..277607ede060 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -108,11 +108,11 @@ static int test__checkevent_raw(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
>  
>  	perf_evlist__for_each_evsel(&evlist->core, evsel) {
> -		struct perf_pmu *pmu;
> +		struct perf_pmu *pmu = NULL;
>  		bool type_matched = false;
>  
>  		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
> -		perf_pmus__for_each_pmu(pmu) {
> +		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>  			if (pmu->type == evsel->attr.type) {
>  				TEST_ASSERT_VAL("PMU type expected once", !type_matched);
>  				type_matched = true;
> @@ -2243,13 +2243,10 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
>  
>  static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -	struct perf_pmu *pmu;
> +	struct perf_pmu *pmu = NULL;
>  	int ret = TEST_OK;
>  
> -	if (list_empty(&pmus))
> -		perf_pmu__scan(NULL);
> -
> -	perf_pmus__for_each_pmu(pmu) {
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>  		struct stat st;
>  		char path[PATH_MAX];
>  		struct dirent *ent;
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index d475e2960c10..257de10788e8 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -5,8 +5,6 @@
>  extern struct list_head pmus;
>  struct perf_pmu;
>  
> -#define perf_pmus__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)
> -
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>  
>  #endif /* __PMUS_H */
