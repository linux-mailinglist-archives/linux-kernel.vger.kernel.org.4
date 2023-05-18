Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A297081FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjERNBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjERNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:01:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D6170B;
        Thu, 18 May 2023 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684414898; x=1715950898;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+tvhKy/zIG1ndmH5buYN+NzMl9DNzbKLc3DGpPJ6+W8=;
  b=FrkuKEIRi8Jh8aW+1WHUDUJuw7K5q8wv0ZP+Hs7sIGf+ddOCqkk9/n54
   I8q8agQGkMHCDNng/fso3vuzSIZNDEMugSonWKU0/27eR2hJYpkOdKB7e
   Rl8Rk0KDmIs/y8EGIZBl3s1Tk6v/jSt5u3XATJh2oM61YmCAoP6K4Qm6a
   JFcHb3R6Qgttk1VFqDypGzgrUDFZfIHtu/YF1hbFNa+oZzhRngfmNWEpv
   0gtKOytGdnrfzHhMLRAvUD2gQM2tfRTsNgrPonnsaU6knWxPPJrdcEvLQ
   xYKUm42Aq5o3Leb5kkhWpg60xiki3IozFzI4xWHZh4vNmhU/D5oOuRYB8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415484221"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="415484221"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 06:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876421191"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="876421191"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:01:27 -0700
Received: from [10.209.99.208] (kliang2-mobl1.ccr.corp.intel.com [10.209.99.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 13A005808EF;
        Thu, 18 May 2023 06:01:25 -0700 (PDT)
Message-ID: <a81f6a1a-8897-dc0e-13d2-05a82c318a46@linux.intel.com>
Date:   Thu, 18 May 2023 09:01:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 1/2] perf test attr: Update no event/metric
 expectations
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517225707.2682235-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517225707.2682235-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 6:57 p.m., Ian Rogers wrote:
> Previously hard coded events/metrics were used, update for the use of
> the TopdownL1 json metric group.
> 
> Fixes: 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/attr/base-stat            |   2 +-
>  tools/perf/tests/attr/test-stat-default    |  80 ++++++++-----
>  tools/perf/tests/attr/test-stat-detailed-1 |  95 +++++++++------
>  tools/perf/tests/attr/test-stat-detailed-2 | 119 +++++++++++--------
>  tools/perf/tests/attr/test-stat-detailed-3 | 127 ++++++++++++---------
>  5 files changed, 249 insertions(+), 174 deletions(-)
> 
> diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
> index a21fb65bc012..fccd8ec4d1b0 100644
> --- a/tools/perf/tests/attr/base-stat
> +++ b/tools/perf/tests/attr/base-stat
> @@ -16,7 +16,7 @@ pinned=0
>  exclusive=0
>  exclude_user=0
>  exclude_kernel=0|1
> -exclude_hv=0
> +exclude_hv=0|1
>  exclude_idle=0
>  mmap=0
>  comm=0
> diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
> index d8ea6a88163f..a1e2da0a9a6d 100644
> --- a/tools/perf/tests/attr/test-stat-default
> +++ b/tools/perf/tests/attr/test-stat-default
> @@ -40,7 +40,6 @@ fd=6
>  type=0
>  config=7
>  optional=1
> -
>  # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
>  [event7:base-stat]
>  fd=7
> @@ -89,79 +88,98 @@ enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event13:base-stat]
>  fd=13
>  group_fd=11
>  type=4
> -config=33024
> +config=33280
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event14:base-stat]
>  fd=14
>  group_fd=11
>  type=4
> -config=33280
> +config=33536
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event15:base-stat]
>  fd=15
>  group_fd=11
>  type=4
> -config=33536
> +config=33024
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event16:base-stat]
>  fd=16
> -group_fd=11
>  type=4
> -config=33792
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=4109
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>  [event17:base-stat]
>  fd=17
> -group_fd=11
>  type=4
> -config=34048
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=17039629
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event18:base-stat]
>  fd=18
> -group_fd=11
>  type=4
> -config=34304
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=60
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event19:base-stat]
>  fd=19
> -group_fd=11
>  type=4
> -config=34560
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=2097421
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +[event20:base-stat]
> +fd=20
> +type=4
> +config=316
> +optional=1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event21:base-stat]
> +fd=21
> +type=4
> +config=412
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event22:base-stat]
> +fd=22
> +type=4
> +config=572
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS


Most of the newly added events are non-architectural events. The event
name and the encoding could be changed later. I don't think it's a good
idea to hard code them in the test. Could we read the TopdownL1 metrics,
get a event list at runtime, and then only test those events?

Thanks,
Kan

> +[event23:base-stat]
> +fd=23
> +type=4
> +config=706
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event24:base-stat]
> +fd=24
> +type=4
> +config=270
>  optional=1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
> index b656ab93c5bf..1c52cb05c900 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-1
> +++ b/tools/perf/tests/attr/test-stat-detailed-1
> @@ -90,89 +90,108 @@ enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event13:base-stat]
>  fd=13
>  group_fd=11
>  type=4
> -config=33024
> +config=33280
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event14:base-stat]
>  fd=14
>  group_fd=11
>  type=4
> -config=33280
> +config=33536
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event15:base-stat]
>  fd=15
>  group_fd=11
>  type=4
> -config=33536
> +config=33024
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event16:base-stat]
>  fd=16
> -group_fd=11
>  type=4
> -config=33792
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=4109
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>  [event17:base-stat]
>  fd=17
> -group_fd=11
>  type=4
> -config=34048
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=17039629
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event18:base-stat]
>  fd=18
> -group_fd=11
>  type=4
> -config=34304
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=60
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event19:base-stat]
>  fd=19
> -group_fd=11
>  type=4
> -config=34560
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=2097421
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +[event20:base-stat]
> +fd=20
> +type=4
> +config=316
> +optional=1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event21:base-stat]
> +fd=21
> +type=4
> +config=412
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event22:base-stat]
> +fd=22
> +type=4
> +config=572
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event23:base-stat]
> +fd=23
> +type=4
> +config=706
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event24:base-stat]
> +fd=24
> +type=4
> +config=270
>  optional=1
>  
>  # PERF_TYPE_HW_CACHE /
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event20:base-stat]
> -fd=20
> +[event25:base-stat]
> +fd=25
>  type=3
>  config=0
>  optional=1
> @@ -181,8 +200,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event21:base-stat]
> -fd=21
> +[event26:base-stat]
> +fd=26
>  type=3
>  config=65536
>  optional=1
> @@ -191,8 +210,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event22:base-stat]
> -fd=22
> +[event27:base-stat]
> +fd=27
>  type=3
>  config=2
>  optional=1
> @@ -201,8 +220,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event23:base-stat]
> -fd=23
> +[event28:base-stat]
> +fd=28
>  type=3
>  config=65538
>  optional=1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
> index 97625090a1c4..7e961d24a885 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-2
> +++ b/tools/perf/tests/attr/test-stat-detailed-2
> @@ -90,89 +90,108 @@ enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event13:base-stat]
>  fd=13
>  group_fd=11
>  type=4
> -config=33024
> +config=33280
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event14:base-stat]
>  fd=14
>  group_fd=11
>  type=4
> -config=33280
> +config=33536
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event15:base-stat]
>  fd=15
>  group_fd=11
>  type=4
> -config=33536
> +config=33024
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event16:base-stat]
>  fd=16
> -group_fd=11
>  type=4
> -config=33792
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=4109
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>  [event17:base-stat]
>  fd=17
> -group_fd=11
>  type=4
> -config=34048
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=17039629
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event18:base-stat]
>  fd=18
> -group_fd=11
>  type=4
> -config=34304
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=60
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event19:base-stat]
>  fd=19
> -group_fd=11
>  type=4
> -config=34560
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=2097421
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +[event20:base-stat]
> +fd=20
> +type=4
> +config=316
> +optional=1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event21:base-stat]
> +fd=21
> +type=4
> +config=412
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event22:base-stat]
> +fd=22
> +type=4
> +config=572
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event23:base-stat]
> +fd=23
> +type=4
> +config=706
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event24:base-stat]
> +fd=24
> +type=4
> +config=270
>  optional=1
>  
>  # PERF_TYPE_HW_CACHE /
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event20:base-stat]
> -fd=20
> +[event25:base-stat]
> +fd=25
>  type=3
>  config=0
>  optional=1
> @@ -181,8 +200,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event21:base-stat]
> -fd=21
> +[event26:base-stat]
> +fd=26
>  type=3
>  config=65536
>  optional=1
> @@ -191,8 +210,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event22:base-stat]
> -fd=22
> +[event27:base-stat]
> +fd=27
>  type=3
>  config=2
>  optional=1
> @@ -201,8 +220,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event23:base-stat]
> -fd=23
> +[event28:base-stat]
> +fd=28
>  type=3
>  config=65538
>  optional=1
> @@ -211,8 +230,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event24:base-stat]
> -fd=24
> +[event29:base-stat]
> +fd=29
>  type=3
>  config=1
>  optional=1
> @@ -221,8 +240,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event25:base-stat]
> -fd=25
> +[event30:base-stat]
> +fd=30
>  type=3
>  config=65537
>  optional=1
> @@ -231,8 +250,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event26:base-stat]
> -fd=26
> +[event31:base-stat]
> +fd=31
>  type=3
>  config=3
>  optional=1
> @@ -241,8 +260,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event27:base-stat]
> -fd=27
> +[event32:base-stat]
> +fd=32
>  type=3
>  config=65539
>  optional=1
> @@ -251,8 +270,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event28:base-stat]
> -fd=28
> +[event33:base-stat]
> +fd=33
>  type=3
>  config=4
>  optional=1
> @@ -261,8 +280,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event29:base-stat]
> -fd=29
> +[event34:base-stat]
> +fd=34
>  type=3
>  config=65540
>  optional=1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
> index d555042e3fbf..e50535f45977 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-3
> +++ b/tools/perf/tests/attr/test-stat-detailed-3
> @@ -90,89 +90,108 @@ enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event13:base-stat]
>  fd=13
>  group_fd=11
>  type=4
> -config=33024
> +config=33280
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event14:base-stat]
>  fd=14
>  group_fd=11
>  type=4
> -config=33280
> +config=33536
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event15:base-stat]
>  fd=15
>  group_fd=11
>  type=4
> -config=33536
> +config=33024
>  disabled=0
>  enable_on_exec=0
>  read_format=15
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event16:base-stat]
>  fd=16
> -group_fd=11
>  type=4
> -config=33792
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=4109
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>  [event17:base-stat]
>  fd=17
> -group_fd=11
>  type=4
> -config=34048
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=17039629
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event18:base-stat]
>  fd=18
> -group_fd=11
>  type=4
> -config=34304
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=60
>  optional=1
>  
> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event19:base-stat]
>  fd=19
> -group_fd=11
>  type=4
> -config=34560
> -disabled=0
> -enable_on_exec=0
> -read_format=15
> +config=2097421
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +[event20:base-stat]
> +fd=20
> +type=4
> +config=316
> +optional=1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event21:base-stat]
> +fd=21
> +type=4
> +config=412
> +optional=1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event22:base-stat]
> +fd=22
> +type=4
> +config=572
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event23:base-stat]
> +fd=23
> +type=4
> +config=706
> +optional=1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event24:base-stat]
> +fd=24
> +type=4
> +config=270
>  optional=1
>  
>  # PERF_TYPE_HW_CACHE /
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event20:base-stat]
> -fd=20
> +[event25:base-stat]
> +fd=25
>  type=3
>  config=0
>  optional=1
> @@ -181,8 +200,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event21:base-stat]
> -fd=21
> +[event26:base-stat]
> +fd=26
>  type=3
>  config=65536
>  optional=1
> @@ -191,8 +210,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event22:base-stat]
> -fd=22
> +[event27:base-stat]
> +fd=27
>  type=3
>  config=2
>  optional=1
> @@ -201,8 +220,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event23:base-stat]
> -fd=23
> +[event28:base-stat]
> +fd=28
>  type=3
>  config=65538
>  optional=1
> @@ -211,8 +230,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event24:base-stat]
> -fd=24
> +[event29:base-stat]
> +fd=29
>  type=3
>  config=1
>  optional=1
> @@ -221,8 +240,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event25:base-stat]
> -fd=25
> +[event30:base-stat]
> +fd=30
>  type=3
>  config=65537
>  optional=1
> @@ -231,8 +250,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event26:base-stat]
> -fd=26
> +[event31:base-stat]
> +fd=31
>  type=3
>  config=3
>  optional=1
> @@ -241,8 +260,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event27:base-stat]
> -fd=27
> +[event32:base-stat]
> +fd=32
>  type=3
>  config=65539
>  optional=1
> @@ -251,8 +270,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event28:base-stat]
> -fd=28
> +[event33:base-stat]
> +fd=33
>  type=3
>  config=4
>  optional=1
> @@ -261,8 +280,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event29:base-stat]
> -fd=29
> +[event34:base-stat]
> +fd=34
>  type=3
>  config=65540
>  optional=1
> @@ -271,8 +290,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event30:base-stat]
> -fd=30
> +[event35:base-stat]
> +fd=35
>  type=3
>  config=512
>  optional=1
> @@ -281,8 +300,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event31:base-stat]
> -fd=31
> +[event36:base-stat]
> +fd=36
>  type=3
>  config=66048
>  optional=1
