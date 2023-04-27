Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865C16F0CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjD0UIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbjD0UIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:08:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3761359D;
        Thu, 27 Apr 2023 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682626101; x=1714162101;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6RNOiOLxUgmR5lRPnykiNi9TDJ7c0tPX7x1Po6A2slY=;
  b=DtVQ7gDFuhyrQ1eHEBcskko5BsT5EEw4BVtjExYsuYoild4SRy4xtJKQ
   k2nNG/Br9S9Q/IxVv7tZzElImCiLJFC26FI10GhyCYSJfsyclShTw/rTB
   YVrK6VS8WPJMe12UhYlMRX+Zk2YdlB/S5b/3nyaGLwFn0eLHXx0eFUq/J
   B2xam1Enk83nqroI/KOjdg6CHq2c6RwAsDn6rLqIYnyG3NXqoGy/tmgZK
   XtZLDCGynWdkQvf/zQEOkpko+le6yEeaI1K7XrN4UtvX7P4Z6GbNG3t1s
   1LwbsSUwL5QG4zHvKJ5U2dwxSW5cf/OH1DDsu6BKbEwTwaHCIIM116vmm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331844868"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="331844868"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 13:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024257335"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024257335"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 13:08:20 -0700
Received: from [10.209.41.222] (kliang2-mobl1.ccr.corp.intel.com [10.209.41.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8E793580CD0;
        Thu, 27 Apr 2023 13:08:16 -0700 (PDT)
Message-ID: <5ec89b32-4713-1c28-7dbb-5146de744afa@linux.intel.com>
Date:   Thu, 27 Apr 2023 16:08:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 16/40] perf test: Validate events with hyphens in
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
 <20230426070050.1315519-17-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426070050.1315519-17-irogers@google.com>
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
> Rewritten event parsing can handle event names that contain components
> of legacy events.


Run the test on Cascade Lake and Alder Lake. It looks good.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/parse-events.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 6eadb8a47dbf..cb976765b8b0 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2198,18 +2198,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
>  			ret = combine_test_results(ret, TEST_SKIP);
>  			continue;
>  		}
> -		/*
> -		 * Names containing '-' are recognized as prefixes and suffixes
> -		 * due to '-' being a legacy PMU separator. This fails when the
> -		 * prefix or suffix collides with an existing legacy token. For
> -		 * example, branch-brs has a prefix (branch) that collides with
> -		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
> -		 * isn't expected after this. As event names in the config
> -		 * slashes are allowed a '-' in the name we check this works
> -		 * above.
> -		 */
> -		if (strchr(ent->d_name, '-'))
> -			continue;
>  
>  		dir = opendir(path);
>  		if (!dir) {
