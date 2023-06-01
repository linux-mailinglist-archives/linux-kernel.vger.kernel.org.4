Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A971E719EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjFANwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFANwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:52:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D319D;
        Thu,  1 Jun 2023 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627530; x=1717163530;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CuACTIe8A0TwoGkPomhkNyZGUJBANVSuy0fG6EihahM=;
  b=mBXNqss80vUQK0zKqv8r06RgAKFVwAVGiG7XzS1bVcOt3S0Mf17t5dkS
   YS7F6EdSvw/AcmOyWwjB9ArMA2AVMiejmK6KeIar2cbab/khsemgboCCS
   wO1FSKhDN18Z3AWpcI4sbk6ED3zyPXiwzdEUqHxddS2I/NNdKwUh+//2J
   IZsOMQvc+DMaEXn+eO8cMKs+6rI9y1lpjP06ma8K4voKpFGE2St1KqPGx
   XYif3UfuzRU9iSx4Alw+qTlL2nCoNUEs+PMwD7pzX30TWpbFSnedlcbRn
   Fscb7qpmuXwy7kprZr+JR8z48L6NYXeD+dNO106f0BLZ2EMGRRx4gxWRX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441922533"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441922533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819794663"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819794663"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2023 06:52:09 -0700
Received: from [10.212.129.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.129.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CEB6958088B;
        Thu,  1 Jun 2023 06:52:07 -0700 (PDT)
Message-ID: <7b23aee2-9fec-e07c-4ca1-076a061c558b@linux.intel.com>
Date:   Thu, 1 Jun 2023 09:52:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/4] perf pmu: Correct perf_pmu__auto_merge_stats
 affecting hybrid
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20230601082954.754318-1-irogers@google.com>
 <20230601082954.754318-2-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230601082954.754318-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-01 4:29 a.m., Ian Rogers wrote:
> Flip the return value correcting a bug.

The bug is that perf fails to create a normal core event on each hybrid
PMU even if the event is available on all hybrid PMUs.

Without the patch,

 # ./perf_old stat -e inst_retired.any -a sleep 1

 Performance counter stats for 'system wide':

        21,760,495      cpu_core/inst_retired.any/

       1.004010591 seconds time elapsed

With the patch,

 # ./perf stat -e inst_retired.any -a sleep 1

 Performance counter stats for 'system wide':

        19,874,833      cpu_core/inst_retired.any/
         3,102,256      cpu_atom/inst_retired.any/

       1.004081307 seconds time elapsed

I think we need to fold the above to the description.

Thanks,
Kan
> 
> Fixes: 6b9da2607030 ("perf pmu: Remove is_pmu_hybrid")
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0520aa9fe991..36e163f38368 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1424,7 +1424,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
>  
>  bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
>  {
> -	return pmu->is_core && perf_pmus__num_core_pmus() > 1;
> +	return pmu->is_core && perf_pmus__num_core_pmus() == 1;
>  }
>  
>  bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
