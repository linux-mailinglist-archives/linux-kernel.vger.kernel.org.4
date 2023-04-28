Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84216F19B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbjD1Nfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjD1Nfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:35:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4CE3C0D;
        Fri, 28 Apr 2023 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682688934; x=1714224934;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/x1b4lRMxJepKaa87d2JNFyd/YiYDqTCEvj8tGgxT00=;
  b=g7ad+NwH5DgRN/A/L+Gkedn6QYuHlhWxs5YaiWN758KnNhJRTzkCfbBY
   QaWL3/OVc1JdG9qsIIhjg/jzzxziyYj6pBwBlqY3mDFHk6HpLVvTy+tVt
   L7eAxQmSLNaAf8AEnHTQj02FbSFZyZ2rlCU/oJyhheDX+0A58isYuuW9A
   ww55yZmfQstjuEtWXike67cTJUyb1PxQIfHaNtfzJ2f7wtOa82W8MgmmB
   1iyhYi23LIjLDVkLqAPc9DLC1BD71aVslaJDUr6TBWP9G46QNmdnspUV8
   XIJFrKGX6q3UWfka+4ghGQBCAP+Yrp4Gp/+y4IzsZQiMTU/0YrMEqQu29
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="336808497"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="336808497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 06:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="688823269"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="688823269"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2023 06:35:33 -0700
Received: from [10.212.155.101] (kliang2-mobl1.ccr.corp.intel.com [10.212.155.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4C15E580C99;
        Fri, 28 Apr 2023 06:35:29 -0700 (PDT)
Message-ID: <a273c794-8378-d090-c65f-1eb2758dff50@linux.intel.com>
Date:   Fri, 28 Apr 2023 09:35:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 20/43] perf test: Move x86 hybrid tests to arch/x86
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
References: <20230428073809.1803624-1-irogers@google.com>
 <20230428073809.1803624-21-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230428073809.1803624-21-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-28 3:37 a.m., Ian Rogers wrote:
> The tests use x86 hybrid specific PMUs.

This one still has problems.

https://lore.kernel.org/lkml/4fbbe5bf-2f7d-8aa3-62b1-72829f75e009@linux.intel.com/

Thanks,
Kan
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/include/arch-tests.h |   1 +
>  tools/perf/arch/x86/tests/Build          |   1 +
>  tools/perf/arch/x86/tests/arch-tests.c   |  10 +
>  tools/perf/arch/x86/tests/hybrid.c       | 277 +++++++++++++++++++++++
>  tools/perf/tests/parse-events.c          | 181 ---------------
>  5 files changed, 289 insertions(+), 181 deletions(-)
>  create mode 100644 tools/perf/arch/x86/tests/hybrid.c
> 
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> index 902e9ea9b99e..33d39c1d3e64 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -11,6 +11,7 @@ int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
>  int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
>  int test__bp_modify(struct test_suite *test, int subtest);
>  int test__x86_sample_parsing(struct test_suite *test, int subtest);
> +int test__hybrid(struct test_suite *test, int subtest);
>  
>  extern struct test_suite *arch_tests[];
>  
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 6f4e8636c3bf..08cc8b9c931e 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -3,5 +3,6 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  
>  perf-y += arch-tests.o
>  perf-y += sample-parsing.o
> +perf-y += hybrid.o
>  perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
>  perf-$(CONFIG_X86_64) += bp-modify.o
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> index aae6ea0fe52b..147ad0638bbb 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -22,6 +22,15 @@ struct test_suite suite__intel_pt = {
>  DEFINE_SUITE("x86 bp modify", bp_modify);
>  #endif
>  DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
> +static struct test_case hybrid_tests[] = {
> +	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
> +	{ .name = NULL, }
> +};
> +
> +struct test_suite suite__hybrid = {
> +	.desc = "x86 hybrid",
> +	.test_cases = hybrid_tests,
> +};
>  
>  struct test_suite *arch_tests[] = {
>  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> @@ -35,5 +44,6 @@ struct test_suite *arch_tests[] = {
>  	&suite__bp_modify,
>  #endif
>  	&suite__x86_sample_parsing,
> +	&suite__hybrid,
>  	NULL,
>  };
> diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
> new file mode 100644
> index 000000000000..0f99cfd116ee
> --- /dev/null
> +++ b/tools/perf/arch/x86/tests/hybrid.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arch-tests.h"
> +#include "debug.h"
> +#include "evlist.h"
> +#include "evsel.h"
> +#include "pmu-hybrid.h"
> +#include "tests/tests.h"
> +
> +static bool test_config(const struct evsel *evsel, __u64 expected_config)
> +{
> +	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
> +}
> +
> +static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
> +{
> +	struct evsel *evsel = evlist__first(evlist);
> +
> +	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_hw_group_event(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *leader;
> +
> +	evsel = leader = evlist__first(evlist);
> +	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *leader;
> +
> +	evsel = leader = evlist__first(evlist);
> +	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *leader;
> +
> +	evsel = leader = evlist__first(evlist);
> +	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_group_modifier1(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *leader;
> +
> +	evsel = leader = evlist__first(evlist);
> +	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> +
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
> +	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> +	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> +	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_raw1(struct evlist *evlist)
> +{
> +	struct evsel *evsel = evlist__first(evlist);
> +
> +	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
> +		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> +		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> +		return TEST_OK;
> +	}
> +
> +	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> +
> +	/* The type of second event is randome value */
> +	evsel = evsel__next(evsel);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_raw2(struct evlist *evlist)
> +{
> +	struct evsel *evsel = evlist__first(evlist);
> +
> +	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> +	return TEST_OK;
> +}
> +
> +static int test__hybrid_cache_event(struct evlist *evlist)
> +{
> +	struct evsel *evsel = evlist__first(evlist);
> +
> +	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
> +	return TEST_OK;
> +}
> +
> +static int test__checkevent_pmu(struct evlist *evlist)
> +{
> +
> +	struct evsel *evsel = evlist__first(evlist);
> +
> +	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> +	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> +	TEST_ASSERT_VAL("wrong config",    10 == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
> +	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
> +	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
> +	/*
> +	 * The period value gets configured within evlist__config,
> +	 * while this test executes only parse events method.
> +	 */
> +	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
> +
> +	return TEST_OK;
> +}
> +
> +struct evlist_test {
> +	const char *name;
> +	bool (*valid)(void);
> +	int (*check)(struct evlist *evlist);
> +};
> +
> +static const struct evlist_test test__hybrid_events[] = {
> +	{
> +		.name  = "cpu_core/cpu-cycles/",
> +		.check = test__hybrid_hw_event_with_pmu,
> +		/* 0 */
> +	},
> +	{
> +		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
> +		.check = test__hybrid_hw_group_event,
> +		/* 1 */
> +	},
> +	{
> +		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
> +		.check = test__hybrid_sw_hw_group_event,
> +		/* 2 */
> +	},
> +	{
> +		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
> +		.check = test__hybrid_hw_sw_group_event,
> +		/* 3 */
> +	},
> +	{
> +		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
> +		.check = test__hybrid_group_modifier1,
> +		/* 4 */
> +	},
> +	{
> +		.name  = "r1a",
> +		.check = test__hybrid_raw1,
> +		/* 5 */
> +	},
> +	{
> +		.name  = "cpu_core/r1a/",
> +		.check = test__hybrid_raw2,
> +		/* 6 */
> +	},
> +	{
> +		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
> +		.check = test__checkevent_pmu,
> +		/* 7 */
> +	},
> +	{
> +		.name  = "cpu_core/LLC-loads/",
> +		.check = test__hybrid_cache_event,
> +		/* 8 */
> +	},
> +};
> +
> +static int test_event(const struct evlist_test *e)
> +{
> +	struct parse_events_error err;
> +	struct evlist *evlist;
> +	int ret;
> +
> +	if (e->valid && !e->valid()) {
> +		pr_debug("... SKIP\n");
> +		return TEST_OK;
> +	}
> +
> +	evlist = evlist__new();
> +	if (evlist == NULL) {
> +		pr_err("Failed allocation");
> +		return TEST_FAIL;
> +	}
> +	parse_events_error__init(&err);
> +	ret = parse_events(evlist, e->name, &err);
> +	if (ret) {
> +		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
> +			 e->name, ret, err.str);
> +		parse_events_error__print(&err, e->name);
> +		ret = TEST_FAIL;
> +		if (strstr(err.str, "can't access trace events"))
> +			ret = TEST_SKIP;
> +	} else {
> +		ret = e->check(evlist);
> +	}
> +	parse_events_error__exit(&err);
> +	evlist__delete(evlist);
> +
> +	return ret;
> +}
> +
> +static int combine_test_results(int existing, int latest)
> +{
> +	if (existing == TEST_FAIL)
> +		return TEST_FAIL;
> +	if (existing == TEST_SKIP)
> +		return latest == TEST_OK ? TEST_SKIP : latest;
> +	return latest;
> +}
> +
> +static int test_events(const struct evlist_test *events, int cnt)
> +{
> +	int ret = TEST_OK;
> +
> +	for (int i = 0; i < cnt; i++) {
> +		const struct evlist_test *e = &events[i];
> +		int test_ret;
> +
> +		pr_debug("running test %d '%s'\n", i, e->name);
> +		test_ret = test_event(e);
> +		if (test_ret != TEST_OK) {
> +			pr_debug("Event test failure: test %d '%s'", i, e->name);
> +			ret = combine_test_results(ret, test_ret);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	if (!perf_pmu__has_hybrid())
> +		return TEST_SKIP;
> +
> +	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
> +}
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index f0e9f9288f2b..3bf07b7e37b1 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -6,7 +6,6 @@
>  #include "tests.h"
>  #include "debug.h"
>  #include "pmu.h"
> -#include "pmu-hybrid.h"
>  #include "pmus.h"
>  #include <dirent.h>
>  #include <errno.h>
> @@ -1509,127 +1508,6 @@ static int test__all_tracepoints(struct evlist *evlist)
>  }
>  #endif /* HAVE_LIBTRACEVENT */
>  
> -static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
> -{
> -	struct evsel *evsel = evlist__first(evlist);
> -
> -	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_hw_group_event(struct evlist *evlist)
> -{
> -	struct evsel *evsel, *leader;
> -
> -	evsel = leader = evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -
> -	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
> -{
> -	struct evsel *evsel, *leader;
> -
> -	evsel = leader = evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -
> -	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
> -{
> -	struct evsel *evsel, *leader;
> -
> -	evsel = leader = evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -
> -	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_group_modifier1(struct evlist *evlist)
> -{
> -	struct evsel *evsel, *leader;
> -
> -	evsel = leader = evlist__first(evlist);
> -	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> -
> -	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
> -	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> -	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_raw1(struct evlist *evlist)
> -{
> -	struct evsel *evsel = evlist__first(evlist);
> -
> -	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
> -		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> -		return TEST_OK;
> -	}
> -
> -	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> -
> -	/* The type of second event is randome value */
> -	evsel = evsel__next(evsel);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_raw2(struct evlist *evlist)
> -{
> -	struct evsel *evsel = evlist__first(evlist);
> -
> -	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
> -	return TEST_OK;
> -}
> -
> -static int test__hybrid_cache_event(struct evlist *evlist)
> -{
> -	struct evsel *evsel = evlist__first(evlist);
> -
> -	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
> -	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
> -	return TEST_OK;
> -}
> -
>  struct evlist_test {
>  	const char *name;
>  	bool (*valid)(void);
> @@ -1997,54 +1875,6 @@ static const struct terms_test test__terms[] = {
>  	},
>  };
>  
> -static const struct evlist_test test__hybrid_events[] = {
> -	{
> -		.name  = "cpu_core/cpu-cycles/",
> -		.check = test__hybrid_hw_event_with_pmu,
> -		/* 0 */
> -	},
> -	{
> -		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
> -		.check = test__hybrid_hw_group_event,
> -		/* 1 */
> -	},
> -	{
> -		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
> -		.check = test__hybrid_sw_hw_group_event,
> -		/* 2 */
> -	},
> -	{
> -		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
> -		.check = test__hybrid_hw_sw_group_event,
> -		/* 3 */
> -	},
> -	{
> -		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
> -		.check = test__hybrid_group_modifier1,
> -		/* 4 */
> -	},
> -	{
> -		.name  = "r1a",
> -		.check = test__hybrid_raw1,
> -		/* 5 */
> -	},
> -	{
> -		.name  = "cpu_core/r1a/",
> -		.check = test__hybrid_raw2,
> -		/* 6 */
> -	},
> -	{
> -		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
> -		.check = test__checkevent_pmu,
> -		/* 7 */
> -	},
> -	{
> -		.name  = "cpu_core/LLC-loads/",
> -		.check = test__hybrid_cache_event,
> -		/* 8 */
> -	},
> -};
> -
>  static int test_event(const struct evlist_test *e)
>  {
>  	struct parse_events_error err;
> @@ -2321,14 +2151,6 @@ static bool test_alias(char **event, char **alias)
>  	return false;
>  }
>  
> -static int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> -{
> -	if (!perf_pmu__has_hybrid())
> -		return TEST_SKIP;
> -
> -	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
> -}
> -
>  static int test__checkevent_pmu_events_alias(struct evlist *evlist)
>  {
>  	struct evsel *evsel1 = evlist__first(evlist);
> @@ -2392,9 +2214,6 @@ static struct test_case tests__parse_events[] = {
>  	TEST_CASE_REASON("Test event parsing",
>  			 events2,
>  			 "permissions"),
> -	TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
> -			 hybrid,
> -			"not hybrid"),
>  	TEST_CASE_REASON("Parsing of all PMU events from sysfs",
>  			 pmu_events,
>  			 "permissions"),
