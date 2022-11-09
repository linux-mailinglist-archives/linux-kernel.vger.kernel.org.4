Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8576232A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKISjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKISje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:39:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B88F036;
        Wed,  9 Nov 2022 10:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59008CE203D;
        Wed,  9 Nov 2022 18:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566DBC433C1;
        Wed,  9 Nov 2022 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668019169;
        bh=x5qfkaG5fxVeMtc8oX2r3oqRUsY7UDpuJlVf9WMSon0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUq4EYFW4hNjZTKKDIeSQ0Gzot//MCx3xvgDfFvlszbEUBPhXCVOGR8sRk83pOiJk
         NtGHxYpedk7vyO0ZQz6tCwy201GSsakls8hQALwoE6krM72K3rqZRTnyTNRxKYAfMI
         l4X+GD/rh2Ypf8FcpKn9LHylAEo9Od5UiQkuxldYJBOzLpDPI+FIaTq0kjMWwn0WGu
         848in63hkBSWQ4IpiEV4GKwo3Pi5ugKoD5G4KVlBl+n3o+ug/0RkM2mmQzuEHTp+Sw
         5ls0zLeceitVu0WUbgwopEr57k+/oa02VmQsbo+Mf2jDCN7pXnbbJV7gxnMV/Ccxup
         1ZGluG8aFqlBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22B6E4034E; Wed,  9 Nov 2022 15:39:27 -0300 (-03)
Date:   Wed, 9 Nov 2022 15:39:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 01/12] perf test: Add -w/--workload option
Message-ID: <Y2vz3zmn/jIFkCKp@kernel.org>
References: <20221109174635.859406-1-namhyung@kernel.org>
 <20221109174635.859406-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109174635.859406-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 09, 2022 at 09:46:24AM -0800, Namhyung Kim escreveu:
> --- /dev/null
> +++ b/tools/perf/tests/workloads/noploop.c
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +static volatile int done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}

You forgot to do what was done in:

92ea0720ba9cf7f0 perf trace: Use sig_atomic_t to avoid undefined behaviour in a signal handler
691768968f2a13eb perf top: Use sig_atomic_t to avoid undefined behaviour in a signal handler
01513fdc18f395db perf stat: Use sig_atomic_t to avoid undefined behaviour in a signal handler
057929f9d083e80c perf session: Change type to avoid undefined behaviour in a signal handler
853596fb71f7c2f7 perf ftrace: Use sig_atomic_t to avoid UB
7f3374299f9762ba perf daemon: Use sig_atomic_t to avoid UB
8ed28c2b56b78442 perf record: Use sig_atomic_t for signal handlers
f3c9bd4e16a503cb perf build: Update to C standard to gnu11

To speed up the process here is one of those csets:

⬢[acme@toolbox perf]$ git show 01513fdc18f395db
commit 01513fdc18f395dbcc924bc5e9962b12f86f947a
Author: Ian Rogers <irogers@google.com>
Date:   Mon Oct 24 11:19:11 2022 -0700

    perf stat: Use sig_atomic_t to avoid undefined behaviour in a signal handler

    Use sig_atomic_t for variables written/accessed in signal
    handlers. This is undefined behavior as per:

      https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

    Signed-off-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
    Cc: German Gomez <german.gomez@arm.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Link: https://lore.kernel.org/r/20221024181913.630986-7-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e52601a54b26d669..d5e1670bca204450 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -173,7 +173,7 @@ static struct target target = {

 #define METRIC_ONLY_LEN 20

-static volatile pid_t          child_pid                       = -1;
+static volatile sig_atomic_t   child_pid                       = -1;
 static int                     detailed_run                    =  0;
 static bool                    transaction_run;
 static bool                    topdown_run                     = false;
@@ -208,7 +208,7 @@ struct perf_stat {
 static struct perf_stat                perf_stat;
 #define STAT_RECORD            perf_stat.record

-static volatile int done = 0;
+static volatile sig_atomic_t done = 0;

 static struct perf_stat_config stat_config = {
        .aggr_mode              = AGGR_GLOBAL,
@@ -580,7 +580,7 @@ static void disable_counters(void)
        }
 }

-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;

 /*
  * evlist__prepare_workload will send a SIGUSR1
@@ -1039,7 +1039,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
        evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }

-static volatile int signr = -1;
+static volatile sig_atomic_t signr = -1;

 static void skip_signal(int signo)
 {
⬢[acme@toolbox perf]$

> +
> +static int noploop(int argc, const char **argv)
> +{
> +	int sec = 1;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	while (!done)
> +		continue;
> +
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(noploop);
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
