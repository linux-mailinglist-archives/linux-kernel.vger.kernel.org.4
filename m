Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFE6DCD68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDJWWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDJWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3F1BD;
        Mon, 10 Apr 2023 15:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 833B161FB6;
        Mon, 10 Apr 2023 22:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B788AC433D2;
        Mon, 10 Apr 2023 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681165359;
        bh=rtUVIdUmOlFbg2j0AGyb3oC88URwtQrM2BOEnncFZRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8j2+6xxt6xNVvSVZHH9yOdbhDyVUvnDesEPgT7YMFrh+qsQ1rA9qpg5tjvIoMI4U
         z2Yww6dkgXoS+wR1quJDreiaXyYYGlhS/mvjCIjGUp/3pHle4ffdAEqeATnvoJakO0
         WJ6DDWUzMJ0y+dGPTpJKAX8JbYFYETOWCzr/IdtFGrAu2O6wf0gT6M2dtLoAtqxIT9
         sfh7/53Sh2MY+l4u0AcUyZpCgkV7lg92Gom/J2g7/4J5ufp5X7DD/e8WmxzKiZdKn2
         unzWW334RXcEW9lOHUa18wi8Mm5jo4tK/5UMidifgkGmQjsw1tMlCCW8ZXuRA1vrdV
         NZEmOq2/cJmRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 644B940009; Mon, 10 Apr 2023 19:22:36 -0300 (-03)
Date:   Mon, 10 Apr 2023 19:22:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 0/6] Refactor definitions out of perf.h
Message-ID: <ZDSMLJPsZlaLYnBN@kernel.org>
References: <20230410162511.3055900-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410162511.3055900-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 10, 2023 at 09:25:05AM -0700, Ian Rogers escreveu:
> Move definitions and declarations for greater consistency.
> 
> The original motivation was, when fuzzing something like parse-events,
> having the main function in perf.c alongside global variables like
> input_name means that input_name must be redeclared with the fuzzer
> function's main. However, as the fuzzer is using the tools/perf code
> as a library this causes backward linking reference that the linker
> may warn about.
> 
> v2. Remove references from commit messages about linking, as Adrian
>     points out we could solve that problem with #ifdefs.

Thanks, applied.

- Arnaldo

 
> Ian Rogers (6):
>   perf ui: Move window resize signal functions
>   perf usage: Move usage strings
>   perf header: Move perf_version_string declaration
>   perf version: Use regular verbose flag
>   perf util: Move input_name to util
>   perf util: Move perf_guest/host declarations
> 
>  tools/perf/builtin-annotate.c     |  2 +-
>  tools/perf/builtin-buildid-list.c |  2 +-
>  tools/perf/builtin-c2c.c          |  2 +-
>  tools/perf/builtin-data.c         |  2 +-
>  tools/perf/builtin-diff.c         |  2 +-
>  tools/perf/builtin-evlist.c       |  2 +-
>  tools/perf/builtin-help.c         |  1 +
>  tools/perf/builtin-kmem.c         |  2 +-
>  tools/perf/builtin-kvm.c          |  1 +
>  tools/perf/builtin-kwork.c        |  2 +-
>  tools/perf/builtin-mem.c          |  2 +-
>  tools/perf/builtin-sched.c        |  2 +-
>  tools/perf/builtin-stat.c         |  2 +-
>  tools/perf/builtin-timechart.c    |  2 +-
>  tools/perf/builtin-version.c      |  7 +++----
>  tools/perf/builtin.h              |  3 ---
>  tools/perf/perf.c                 | 27 +--------------------------
>  tools/perf/perf.h                 |  9 ---------
>  tools/perf/ui/browsers/hists.c    |  2 +-
>  tools/perf/ui/hist.c              |  2 +-
>  tools/perf/ui/setup.c             | 19 +++++++++++++++++++
>  tools/perf/ui/tui/setup.c         |  1 -
>  tools/perf/ui/ui.h                |  3 +++
>  tools/perf/util/cs-etm.c          |  1 +
>  tools/perf/util/event.c           |  2 +-
>  tools/perf/util/evlist.c          |  1 +
>  tools/perf/util/header.h          |  2 ++
>  tools/perf/util/parse-events.c    |  2 +-
>  tools/perf/util/session.c         |  2 +-
>  tools/perf/util/top.c             |  2 +-
>  tools/perf/util/usage.c           |  6 ++++++
>  tools/perf/util/util.c            |  2 ++
>  tools/perf/util/util.h            |  8 ++++++++
>  33 files changed, 66 insertions(+), 61 deletions(-)
> 
> -- 
> 2.40.0.577.gac1e443424-goog
> 

-- 

- Arnaldo
