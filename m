Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D489C5FD8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJMMLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJMMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:11:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A13F53DC;
        Thu, 13 Oct 2022 05:11:03 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp7Zc2SH4z67LJ2;
        Thu, 13 Oct 2022 20:08:08 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 14:11:01 +0200
Received: from [10.126.172.19] (10.126.172.19) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 13:11:00 +0100
Message-ID: <715c8e4a-f3c3-6521-778e-8ba8c2bf659e@huawei.com>
Date:   Thu, 13 Oct 2022 13:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1] perf test: Parse events workaround for dash/minus
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>
References: <20221013011205.3151391-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221013011205.3151391-1-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.172.19]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 02:12, Ian Rogers wrote:
> Skip an event configuration for event names with a dash/minus in them.
> Events with a dash/minus in their name cause parsing issues as legacy
> encoding of events would use a dash/minus as a separator. The parser
> separates events with dashes into prefixes and suffixes and then
> recombines them. Unfortunately if an event has part of its name that
> matches a legacy token then the recombining fails. This is seen for
> branch-brs where branch is a legacy token. branch-brs was introduced
> to sysfs in:
> https://lore.kernel.org/all/20220322221517.2510440-5-eranian@google.com/
> The failure is shown below as well as the workaround to use a config
> where the dash/minus isn't treated specially:
> 
> ```
> $ perf stat -e branch-brs true
> event syntax error: 'branch-brs'
>                             \___ parser error
> 
> $ perf stat -e cpu/branch-brs/ true
> 
>   Performance counter stats for 'true':
> 
>              46,179      cpu/branch-brs/
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/parse-events.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 459afdb256a1..3440dd2616b0 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2237,6 +2237,19 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
>   			pr_debug("Test PMU event failed for '%s'", name);
>   			ret = combine_test_results(ret, test_ret);
>   		

Hi Ian,

}
> +		/*
> +		 * Names containing '-' are recognized as prefixes and suffixes
> +		 * due to '-' being a legacy PMU separator. This fails when the
> +		 * prefix or suffix collides with an existing legacy token. For
> +		 * example, branch-brs has a prefix (branch) that collides with
> +		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
> +		 * isn't expected after this.

OK, so you want to skip anything with '-'. Will we now miss out on 
events which contain a '-' but don't clash with an existing legacy token?

>  As event names in the config
> +		 * slashes are allowed a '-' in the name we check this works
> +		 * above.

Sorry, I can't follow what you mean here. Do you mean that 
"cpu/branch-brs/" works ok and we continue to test it?

> +		 */
> +		if (strchr(ent->d_name, '-'))
> +			continue;

Thanks,
John

> +
>   		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
>   		e.name  = name;
>   		e.check = test__checkevent_pmu_events_mix;

