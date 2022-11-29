Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21CA63C90D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiK2UON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbiK2UOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:14:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828DA45096;
        Tue, 29 Nov 2022 12:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669752848; x=1701288848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OR/jFlZjPptXY8eBFs+xobMqolGE6m2lVFnp7v0DM70=;
  b=LnsTc6DAT+WGiHEeVDLykSkxl96P+cRgQ+qnp6mb59yHiWOljdp0vuFM
   WnihGLxlXykdyxhlDQ+W/kXVgxB3McorN/2+sHHKihYmeiSsRAd/SJCuC
   JkWxBEh9GqsKjBxmnBxB0quuRJi0f5hn5bYrLRQh/JWrWKa98cTjs5Xod
   9mybRkAB9YBiAT18isCLYouPaUhZBh/o0VMRCR9vKtJOPGz6ewuOVotUz
   m0+wjjLHIhyoAmEbPXRHHMur6G5n4VjJNEl8TJdCpWTyjfYWb87e8VYzY
   3ZYFKzRXzBNmS8oTdwcCkFXP4Gaw8MVZC7/q+xUuwuvdmc9Acbhcknnpo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379505242"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379505242"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 12:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="621609399"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="621609399"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2022 12:14:01 -0800
Received: from [10.252.213.107] (kliang2-mobl1.ccr.corp.intel.com [10.252.213.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BB8C458090D;
        Tue, 29 Nov 2022 12:13:58 -0800 (PST)
Message-ID: <0dd566ab-38fd-2204-f59c-e74b2244828b@linux.intel.com>
Date:   Tue, 29 Nov 2022 15:13:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     irogers@google.com, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
References: <20221129111946.409-1-ravi.bangoria@amd.com>
 <20221129111946.409-3-ravi.bangoria@amd.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221129111946.409-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-11-29 6:19 a.m., Ravi Bangoria wrote:
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. One of the limitation is, perf
> doesn't allow creating a group of events from different hw pmus.
> Write a simple test to create various combinations of hw, sw and
> uncore pmu events and verify group creation succeeds or fails as
> expected.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/event_groups.c | 109 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  4 files changed, 112 insertions(+)
>  create mode 100644 tools/perf/tests/event_groups.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 11b69023011b..658b5052c24d 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -67,6 +67,7 @@ perf-y += expand-cgroup.o
>  perf-y += perf-time-to-tsc.o
>  perf-y += dlfilter-test.o
>  perf-y += sigtrap.o
> +perf-y += event_groups.o
>  
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>  	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 4c6ae59a4dfd..ddd8262bfa26 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__perf_time_to_tsc,
>  	&suite__dlfilter,
>  	&suite__sigtrap,
> +	&suite__event_groups,
>  	NULL,
>  };
>  
> diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
> new file mode 100644
> index 000000000000..4002b467cc8f
> --- /dev/null
> +++ b/tools/perf/tests/event_groups.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "linux/perf_event.h"
> +#include "tests.h"
> +#include "debug.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +#include "header.h"
> +#include "../perf-sys.h"
> +
> +static int event_open(int type, unsigned long config, int group_fd)
> +{
> +	struct perf_event_attr attr;
> +
> +	memset(&attr, 0, sizeof(struct perf_event_attr));
> +	attr.type = type;
> +	attr.size = sizeof(struct perf_event_attr);
> +	attr.config = config;
> +	/*
> +	 * When creating an event group, typically the group leader is
> +	 * initialized with disabled set to 1 and any child events are
> +	 * initialized with disabled set to 0. Despite disabled being 0,
> +	 * the child events will not start until the group leader is
> +	 * enabled.
> +	 */
> +	attr.disabled = group_fd == -1 ? 1 : 0;
> +
> +	return sys_perf_event_open(&attr, -1, 0, group_fd, 0);
> +}
> +
> +/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
> +static int type[] = {0, 1, -1};
> +static unsigned long config[] = {0, 3, 0};
> +
> +static int setup_uncore_event(void)
> +{
> +	struct perf_pmu *pmu;
> +
> +	if (list_empty(&pmus))
> +		perf_pmu__scan(NULL);
> +
> +	perf_pmus__for_each_pmu(pmu) {
> +		if (pmu->is_uncore) {

Always using the first uncore PMU may trigger false alarm on some Intel
platforms. For example, Intel has free running uncore PMUs (e.g.,
uncore_imc_free_running_0), which only supports special event encoding
0xff. The config 0 must fails.
You may want to add the below check to ignore the free running uncore PMUs.
                        if (strstr(pmu->name, "free_running"))
                                continue;


Also, some uncore PMUs only support two counters. But the test assumes
that the number of counters > 2. You may want to limit the size of the
group for 2 for a pure uncore group.


Thanks,
Kan

> +			pr_debug("Using %s for uncore pmu event\n", pmu->name);
> +			type[2] = pmu->type;
> +			return 0;
> +		}
> +	}
> +	return -1;
> +}
> +
> +static int run_test(int i, int j, int k)
> +{
> +	int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
> +	int group_fd, sibling_fd1, sibling_fd2;
> +
> +	group_fd = event_open(type[i], config[i], -1);
> +	if (group_fd == -1)
> +		return -1;
> +
> +	sibling_fd1 = event_open(type[j], config[j], group_fd);
> +	if (sibling_fd1 == -1) {
> +		close(group_fd);
> +		return erroneous ? 0 : -1;
> +	}
> +
> +	sibling_fd2 = event_open(type[k], config[k], group_fd);
> +	if (sibling_fd2 == -1) {
> +		close(sibling_fd1);
> +		close(group_fd);
> +		return erroneous ? 0 : -1;
> +	}
> +
> +	close(sibling_fd2);
> +	close(sibling_fd1);
> +	close(group_fd);
> +	return erroneous ? -1 : 0;
> +}
> +
> +static int test__event_groups(struct test_suite *text __maybe_unused, int subtest __maybe_unused)
> +{
> +	int i, j, k;
> +	int ret;
> +	int r;
> +
> +	ret = setup_uncore_event();
> +	if (ret || type[2] == -1)
> +		return TEST_SKIP;
> +
> +	ret = TEST_OK;
> +	for (i = 0; i < 3; i++) {
> +		for (j = 0; j < 3; j++) {
> +			for (k = 0; k < 3; k++) {
> +				r = run_test(i, j, k);
> +				if (r)
> +					ret = TEST_FAIL;
> +
> +				pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
> +					 type[i], config[i], type[j], config[j],
> +					 type[k], config[k], r ? "Fail" : "Pass");
> +			}
> +		}
> +	}
> +	return ret;
> +}
> +
> +DEFINE_SUITE("Event groups", event_groups);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index e15f24cfc909..fb4b5ad4dd0f 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -147,6 +147,7 @@ DECLARE_SUITE(expand_cgroup_events);
>  DECLARE_SUITE(perf_time_to_tsc);
>  DECLARE_SUITE(dlfilter);
>  DECLARE_SUITE(sigtrap);
> +DECLARE_SUITE(event_groups);
>  
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints using the
