Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF57713185
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjE0BcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjE0BcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299DC3;
        Fri, 26 May 2023 18:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C8FB654DB;
        Sat, 27 May 2023 01:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103B1C433D2;
        Sat, 27 May 2023 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685151135;
        bh=UWaVRWh97QkaKEW+3Y55uies+J/z/xLzCy793JnQzLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayFWnoKZQfFcHXHqX2xr3q6x1Kk9cRXYQN468s3bNVp/yn5Ytmx1rGfKv2ZoFHrdo
         7XasElUlyzsv7vLbnax0sJ4srG2cTei178XGz1d1/RC0RqQuU/6nLnVIcICV6SLjoA
         NSNMnf1Ue522UoF1RVlDYdkDGPNRG28nsCuzfP+vob3ZA6XqvwuvZLeS3u6/Cfgdsg
         KtVhmSt3Yx6X9yjH7xmuxk7l2v76dEFINH+PQ1VduQW8DSpLdZZlh2/Ihpiq2GJIbM
         SMSbENaedwJ7YzAn2qJNHQb0jLoUUjUSS2fp0a7OJRQTCogP/BAbXjCTnDbntejMFO
         hEw1lWYNaurYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99129403B5; Fri, 26 May 2023 22:32:12 -0300 (-03)
Date:   Fri, 26 May 2023 22:32:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
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
Subject: Re: [PATCH v4 03/35] perf cpumap: Add equal function
Message-ID: <ZHFdnEpNMKq7EbWh@kernel.org>
References: <20230526215410.2435674-1-irogers@google.com>
 <20230526215410.2435674-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526215410.2435674-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 26, 2023 at 02:53:38PM -0700, Ian Rogers escreveu:
> Equality is a useful property to compare after merging and
> intersecting maps.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/lib/perf/cpumap.c              | 21 ++++++++++++++++
>  tools/lib/perf/include/perf/cpumap.h |  2 ++
>  tools/perf/tests/cpumap.c            | 37 ++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index d4f3a1a12522..48595a3ad69c 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -321,6 +321,27 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
>  	return perf_cpu_map__idx(cpus, cpu) != -1;
>  }
>  
> +bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_map *rhs)
> +{
> +	int nr;
> +
> +	if (lhs == rhs)
> +		return true;
> +
> +	if (!lhs || !rhs)
> +		return false;
> +
> +	nr = perf_cpu_map__nr(lhs);
> +	if (nr != perf_cpu_map__nr(rhs))
> +		return false;
> +
> +	for (int idx = 0; idx < nr; idx++) {
> +		if (RC_CHK_ACCESS(lhs)->map[idx].cpu != RC_CHK_ACCESS(rhs)->map[idx].cpu)
> +			return false;

Don't we have an accessor to avoid this RC_CHK_ACCESS()-> access?

> +	}
> +	return true;
> +}
> +
>  struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
>  {
>  	struct perf_cpu result = {
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 0466c4216fbb..d0ae9552f8e2 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -28,6 +28,8 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
>  LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
>  LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
>  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
> +LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
> +				     const struct perf_cpu_map *rhs);
>  
>  #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
>  	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 83805690c209..7730fc2ab40b 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -211,11 +211,48 @@ static int test__cpu_map_intersect(struct test_suite *test __maybe_unused,
>  	return ret;
>  }
>  
> +static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	struct perf_cpu_map *any = perf_cpu_map__dummy_new();
> +	struct perf_cpu_map *one = perf_cpu_map__new("1");
> +	struct perf_cpu_map *two = perf_cpu_map__new("2");
> +	struct perf_cpu_map *empty = perf_cpu_map__intersect(one, two);
> +	struct perf_cpu_map *pair = perf_cpu_map__new("1-2");
> +	struct perf_cpu_map *tmp;
> +	struct perf_cpu_map *maps[] = {empty, any, one, two, pair};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(maps); i++) {
> +		/* Maps equal themself. */
> +		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(maps[i], maps[i]));
> +		for (size_t j = 0; j < ARRAY_SIZE(maps); j++) {
> +			/* Maps dont't equal each other. */
> +			if (i == j)
> +				continue;
> +			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(maps[i], maps[j]));
> +		}
> +	}
> +
> +	/* Maps equal made maps. */
> +	tmp = perf_cpu_map__merge(perf_cpu_map__get(one), two);
> +	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, tmp));
> +	perf_cpu_map__put(tmp);
> +
> +	tmp = perf_cpu_map__intersect(pair, one);
> +	TEST_ASSERT_VAL("one", perf_cpu_map__equal(one, tmp));
> +	perf_cpu_map__put(tmp);
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(maps); i++)
> +		perf_cpu_map__put(maps[i]);
> +
> +	return TEST_OK;
> +}
> +
>  static struct test_case tests__cpu_map[] = {
>  	TEST_CASE("Synthesize cpu map", cpu_map_synthesize),
>  	TEST_CASE("Print cpu map", cpu_map_print),
>  	TEST_CASE("Merge cpu map", cpu_map_merge),
>  	TEST_CASE("Intersect cpu map", cpu_map_intersect),
> +	TEST_CASE("Equal cpu map", cpu_map_equal),
>  	{	.name = NULL, }
>  };
>  
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
