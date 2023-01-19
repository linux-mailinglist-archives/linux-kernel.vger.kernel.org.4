Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5EE674C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjATF24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjATF23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10773D09A;
        Thu, 19 Jan 2023 21:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EE66B8261C;
        Thu, 19 Jan 2023 16:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C8C433EF;
        Thu, 19 Jan 2023 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674147540;
        bh=1emhlmUjevrFlbe0JDra+yCoAjMDC5PSBtg2a3xQ8EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6RRFFJWQrVl9Jvt8ou4twZY9IUP6zLH/nlfXWr/Vj89DtQbzJqMNVpFBSIrYjYo6
         wcqaNtXiXWPK2FaAikkZs1wM/NF4MGTP5gVtGD014MDvkb3y9qWfeZEMbPcX7dx6U0
         vGDPnc2AKG+abZFmrgSDw2Tw7edNl3xmJ56GvZ2QqWTSNfvpTonfnOSiGcZuZVMg1m
         1GMw4rdeA2k7U7aHxanpiPGxNfgrAP5GYNbDGdUXLj+Ne0mcKB37QQiu68jer0iGCP
         twMu06rQ+7+UeeTaNWMW6euUdD/zpO/DuSQG3m1Zq1kvC2qcFwPKlR5v0LfJti265C
         0BduxswnesIXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48892405BE; Thu, 19 Jan 2023 13:58:56 -0300 (-03)
Date:   Thu, 19 Jan 2023 13:58:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org, sgoutham@marvell.com,
        gcherian@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] perf cs_etm: Basic support for virtual/kernel
 timestamps
Message-ID: <Y8l20EOD6vtvJw83@kernel.org>
References: <20230119154308.3815108-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119154308.3815108-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 19, 2023 at 03:42:59PM +0000, James Clark escreveu:
> Changes since v3:
> 
>   * Scale time estimates by INSTR_PER_NS, rather than assuming 1
>     instruction = 1ns
>   * Add a new commit that fixes some issues around timestamps going
>     backwards
>   * Use nanoseconds inside cs-etm-decoder.c, rather than storing the
>     raw time values and converting when a sample is synthesized. This
>     simplifies some of the code like estimating the first timestamp.

I would check this myself, but since Suzuki had some review comments and
you may consider a v5, please check this:

Cover: ./v4_20230119_james_clark_perf_cs_etm_basic_support_for_virtual_kernel_timestamps.cover
 Link: https://lore.kernel.org/r/20230119154308.3815108-1-james.clark@arm.com
       git checkout -b v4_20230119_james_clark_arm_com 69b41ac87e4a664de78a395ff97166f0b2943210
       git am ./v4_20230119_james_clark_perf_cs_etm_basic_support_for_virtual_kernel_timestamps.mbx
[acme@quaco perf]$        git am ./v4_20230119_james_clark_perf_cs_etm_basic_support_for_virtual_kernel_timestamps.mbx
Applying: perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
error: patch failed: tools/perf/util/pmu.c:1993
error: tools/perf/util/pmu.c: patch does not apply
error: patch failed: tools/perf/util/pmu.h:259
error: tools/perf/util/pmu.h: patch does not apply
Patch failed at 0001 perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[acme@quaco perf]$

Probably a conflict with one of these:

[acme@quaco perf]$ git log --oneline -5 tools/perf/util/pmu.c
acef233b7ca749fd perf pmu: Add #slots literal support for arm64
336b92da1aa4228a perf tool: Move pmus list variable to a new file
49bd97c28b7e7f01 perf tools: Use dedicated non-atomic clear/set bit helpers
e5c6109f4813246a perf list: Reorganize to use callbacks to allow honouring command line options
eb2d4514a5971444 perf pmu: Restructure print_pmu_events() to avoid memory allocations
[acme@quaco perf]$

Update to my perf/core branch or even tmp.perf/core which is newer but
still needs the full set of container build tests.

Thanks,

- Arnaldo
   
> ===========================
> Changes since v2:
> 
>   * Remove const to non-const change and copy strings where needed
>     instead.
>   * Use sizeof() instead of PATH_MAX
>   * Append "will not be set accurately." to new error message
>   * Remove unneeded stat() call
>   * Rebase on perf/core
>   
> ==========================
> 
> Changes since v1:
> 
>   * Add 3 refactor commits for sysfs reading around pmu.c as suggested
>     by Arnaldo here [1]
>   * The dependency on [2] has now reached mainline so is no longer
>     blocking
>   * Rebase on perf/core
>   
> [1]: https://lore.kernel.org/all/YnqVqq5QW%2Fb14oPZ@kernel.org/
> [2]: https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/
> 
> German Gomez (4):
>   perf pmu: Add function to check if a pmu file exists
>   perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
>   perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
>   perf cs_etm: Set the time field in the synthetic samples
> 
> James Clark (4):
>   perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
>   perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
>   perf: Remove remaining duplication of bus/event_source/devices/...
>   perf: cs-etm: Ensure that Coresight timestamps don't go backwards
> 
>  tools/perf/arch/arm/util/auxtrace.c           |   5 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  91 ++++++++-
>  tools/perf/arch/x86/util/pmu.c                |  12 +-
>  tools/perf/util/cputopo.c                     |   9 +-
>  tools/perf/util/cs-etm-base.c                 |  34 +++-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  68 +++++--
>  tools/perf/util/cs-etm.c                      |  95 +++++++++-
>  tools/perf/util/cs-etm.h                      |  16 +-
>  tools/perf/util/pmu-hybrid.c                  |  27 +--
>  tools/perf/util/pmu.c                         | 177 +++++++-----------
>  tools/perf/util/pmu.h                         |  10 +-
>  11 files changed, 349 insertions(+), 195 deletions(-)
> 
> 
> base-commit: 69b41ac87e4a664de78a395ff97166f0b2943210
> prerequisite-patch-id: 9722bf86e3e6d16d177ff9a1411992a795a7dcbd
> prerequisite-patch-id: b05dbef439c2ea8465f3321532257b0ca29f21f9
> prerequisite-patch-id: 92680a4781cbcf010fcb007e6ea030f59e9eaefc
> prerequisite-patch-id: 8e3a73a04e4b89b503377b5fac1d89d551159393
> prerequisite-patch-id: 09980d8fedcdaa70b220a7802428109f48448a58
> prerequisite-patch-id: 711843c93d5d6bdf4d73e024949950f4e4de9e1a
> -- 
> 2.25.1

-- 

- Arnaldo
