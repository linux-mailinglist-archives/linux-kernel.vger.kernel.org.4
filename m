Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141F707B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjERHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjERHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:50:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6B0C2691;
        Thu, 18 May 2023 00:50:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62E9D1FB;
        Thu, 18 May 2023 00:51:10 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB4363F73F;
        Thu, 18 May 2023 00:50:23 -0700 (PDT)
Message-ID: <64f329a9-09a3-aa84-a354-23a919062d09@arm.com>
Date:   Thu, 18 May 2023 08:50:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] perf test attr: Update no event/metric
 expectations
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
References: <20230517225707.2682235-1-irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230517225707.2682235-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2023 23:57, Ian Rogers wrote:
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

Reviewed-by: James Clark <james.clark@arm.com>

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
