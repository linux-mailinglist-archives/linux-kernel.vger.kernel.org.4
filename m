Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46367579F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjATOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjATOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:43:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19E35561BB;
        Fri, 20 Jan 2023 06:43:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B80621515;
        Fri, 20 Jan 2023 06:43:10 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1EE63F67D;
        Fri, 20 Jan 2023 06:42:25 -0800 (PST)
Message-ID: <f68ca299-858c-a3a3-a0f9-5743dd32912c@arm.com>
Date:   Fri, 20 Jan 2023 14:42:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/8] perf cs_etm: Basic support for virtual/kernel
 timestamps
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230120143702.4035046-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230120143702.4035046-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 14:36, James Clark wrote:
> Changes since v4:
> 
>    * Rebase onto perf/core
>    * Convert new perf_pmu__cpu_slots_per_cycle() function to use
>      new helper functions
>    
> ===========================
> Changes since v3:
> 
>    * Scale time estimates by INSTR_PER_NS, rather than assuming 1
>      instruction = 1ns
>    * Add a new commit that fixes some issues around timestamps going
>      backwards
>    * Use nanoseconds inside cs-etm-decoder.c, rather than storing the
>      raw time values and converting when a sample is synthesized. This
>      simplifies some of the code like estimating the first timestamp.
>    
> ===========================
> Changes since v2:
> 
>    * Remove const to non-const change and copy strings where needed
>      instead.
>    * Use sizeof() instead of PATH_MAX
>    * Append "will not be set accurately." to new error message
>    * Remove unneeded stat() call
>    * Rebase on perf/core
>    
> ==========================
> 
> Changes since v1:
> 
>    * Add 3 refactor commits for sysfs reading around pmu.c as suggested
>      by Arnaldo here [1]
>    * The dependency on [2] has now reached mainline so is no longer
>      blocking
>    * Rebase on perf/core
>    
> [1]: https://lore.kernel.org/all/YnqVqq5QW%2Fb14oPZ@kernel.org/
> [2]: https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/
> 
> German Gomez (4):
>    perf pmu: Add function to check if a pmu file exists
>    perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
>    perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
>    perf cs_etm: Set the time field in the synthetic samples
> 
> James Clark (4):
>    perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
>    perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
>    perf: Remove remaining duplication of bus/event_source/devices/...
>    perf: cs-etm: Ensure that Coresight timestamps don't go backwards
> 
>   tools/perf/arch/arm/util/auxtrace.c           |   5 +-
>   tools/perf/arch/arm/util/cs-etm.c             |  91 ++++++++-
>   tools/perf/arch/arm64/util/pmu.c              |   4 +-
>   tools/perf/arch/x86/util/pmu.c                |  12 +-
>   tools/perf/util/cputopo.c                     |   9 +-
>   tools/perf/util/cs-etm-base.c                 |  34 +++-
>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  68 +++++--
>   tools/perf/util/cs-etm.c                      |  95 +++++++++-
>   tools/perf/util/cs-etm.h                      |  16 +-
>   tools/perf/util/pmu-hybrid.c                  |  27 +--
>   tools/perf/util/pmu.c                         | 177 +++++++-----------
>   tools/perf/util/pmu.h                         |  10 +-
>   12 files changed, 351 insertions(+), 197 deletions(-)

For the series,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> 
> 
> base-commit: 1962ab6f6e0b39e4216206205bda14aff87705f3
> prerequisite-patch-id: 9722bf86e3e6d16d177ff9a1411992a795a7dcbd
> prerequisite-patch-id: b05dbef439c2ea8465f3321532257b0ca29f21f9
> prerequisite-patch-id: 92680a4781cbcf010fcb007e6ea030f59e9eaefc
> prerequisite-patch-id: 8e3a73a04e4b89b503377b5fac1d89d551159393
> prerequisite-patch-id: 09980d8fedcdaa70b220a7802428109f48448a58

