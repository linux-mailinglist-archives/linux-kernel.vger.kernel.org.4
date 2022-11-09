Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00E4623317
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKITAa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Nov 2022 14:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKITA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:00:29 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55E8193EA;
        Wed,  9 Nov 2022 11:00:27 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id n205so8732986oib.1;
        Wed, 09 Nov 2022 11:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMpsMLyiCgwuPwl0+GxzMfLoA8jDIII47LVKf8n7yz8=;
        b=j6CV5pliJJwPBdqIq8jOy1cmkQzwKmq8fZUrtlU/7SWSuAnfQPQSDF2DEaAvxKmjf5
         T36bHMnMkDraDbceA8PFcN+g7UWBAcZJJ/EiuXioGae2hZ4aiOcEnVB8tOYjqd1aOAim
         lad21SunjRSs9FWOAlV4FQ25amY8Sz7sTM/vnlfF1HE1goW0XGzDIZZe+FczcAOVNhyx
         5m77KaBdOwPv0aC1MCqJ8cpR65TCAva4gGowMnRtIR7ean/gdKtGerDS550d2LQlVkTF
         XzevjYqtbB+YoqWM0dAgyQNtHltXksmBZidu3VnNpj7BtsJNNea/JtYgwmUIJCSBIa1A
         EZIg==
X-Gm-Message-State: ACrzQf3NmGlDnvvrTEhnFtZL/pae3W/m0G6XKXQrR6ApsVrhhts1Njtm
        IHSte8Q2jgpMJzlNSeBc8SVBTo9HK10K+InH+dI=
X-Google-Smtp-Source: AMsMyM4/QC5OTudpw+11FpWjsynsIC/pUi06eH6hsHduFUNI1wqH/RPpSPHP/zs6Nz9mq+91MEIMTe6VwZ79vWAALKE=
X-Received: by 2002:aca:2805:0:b0:359:e340:d53 with SMTP id
 5-20020aca2805000000b00359e3400d53mr31799603oix.209.1668020427039; Wed, 09
 Nov 2022 11:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109174635.859406-1-namhyung@kernel.org> <20221109174635.859406-2-namhyung@kernel.org>
 <Y2vz3zmn/jIFkCKp@kernel.org>
In-Reply-To: <Y2vz3zmn/jIFkCKp@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Nov 2022 11:00:15 -0800
Message-ID: <CAM9d7ciQ1Co89oHc005SCgEfv3zATHQM6ZnHYTTgsF9uXpNLMg@mail.gmail.com>
Subject: Re: [PATCH 01/12] perf test: Add -w/--workload option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Nov 9, 2022 at 10:39 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 09, 2022 at 09:46:24AM -0800, Namhyung Kim escreveu:
> > --- /dev/null
> > +++ b/tools/perf/tests/workloads/noploop.c
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <stdlib.h>
> > +#include <signal.h>
> > +#include <unistd.h>
> > +#include <linux/compiler.h>
> > +#include "../tests.h"
> > +
> > +static volatile int done;
> > +
> > +static void sighandler(int sig __maybe_unused)
> > +{
> > +     done = 1;
> > +}
>
> You forgot to do what was done in:

Oops, right.  Will fix in v2.

Thanks,
Namhyung


>
> 92ea0720ba9cf7f0 perf trace: Use sig_atomic_t to avoid undefined behaviour in a signal handler
> 691768968f2a13eb perf top: Use sig_atomic_t to avoid undefined behaviour in a signal handler
> 01513fdc18f395db perf stat: Use sig_atomic_t to avoid undefined behaviour in a signal handler
> 057929f9d083e80c perf session: Change type to avoid undefined behaviour in a signal handler
> 853596fb71f7c2f7 perf ftrace: Use sig_atomic_t to avoid UB
> 7f3374299f9762ba perf daemon: Use sig_atomic_t to avoid UB
> 8ed28c2b56b78442 perf record: Use sig_atomic_t for signal handlers
> f3c9bd4e16a503cb perf build: Update to C standard to gnu11
>
> To speed up the process here is one of those csets:
>
> ⬢[acme@toolbox perf]$ git show 01513fdc18f395db
> commit 01513fdc18f395dbcc924bc5e9962b12f86f947a
> Author: Ian Rogers <irogers@google.com>
> Date:   Mon Oct 24 11:19:11 2022 -0700
>
>     perf stat: Use sig_atomic_t to avoid undefined behaviour in a signal handler
>
>     Use sig_atomic_t for variables written/accessed in signal
>     handlers. This is undefined behavior as per:
>
>       https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>     Cc: German Gomez <german.gomez@arm.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Stephane Eranian <eranian@google.com>
>     Link: https://lore.kernel.org/r/20221024181913.630986-7-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e52601a54b26d669..d5e1670bca204450 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -173,7 +173,7 @@ static struct target target = {
>
>  #define METRIC_ONLY_LEN 20
>
> -static volatile pid_t          child_pid                       = -1;
> +static volatile sig_atomic_t   child_pid                       = -1;
>  static int                     detailed_run                    =  0;
>  static bool                    transaction_run;
>  static bool                    topdown_run                     = false;
> @@ -208,7 +208,7 @@ struct perf_stat {
>  static struct perf_stat                perf_stat;
>  #define STAT_RECORD            perf_stat.record
>
> -static volatile int done = 0;
> +static volatile sig_atomic_t done = 0;
>
>  static struct perf_stat_config stat_config = {
>         .aggr_mode              = AGGR_GLOBAL,
> @@ -580,7 +580,7 @@ static void disable_counters(void)
>         }
>  }
>
> -static volatile int workload_exec_errno;
> +static volatile sig_atomic_t workload_exec_errno;
>
>  /*
>   * evlist__prepare_workload will send a SIGUSR1
> @@ -1039,7 +1039,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
>         evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
>  }
>
> -static volatile int signr = -1;
> +static volatile sig_atomic_t signr = -1;
>
>  static void skip_signal(int signo)
>  {
> ⬢[acme@toolbox perf]$
>
> > +
> > +static int noploop(int argc, const char **argv)
> > +{
> > +     int sec = 1;
> > +
> > +     if (argc > 0)
> > +             sec = atoi(argv[0]);
> > +
> > +     signal(SIGINT, sighandler);
> > +     signal(SIGALRM, sighandler);
> > +     alarm(sec);
> > +
> > +     while (!done)
> > +             continue;
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_WORKLOAD(noploop);
> > --
> > 2.38.1.431.g37b22c650d-goog
>
> --
>
> - Arnaldo
