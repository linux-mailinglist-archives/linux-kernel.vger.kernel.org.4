Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A44630877
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiKSBcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiKSBcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:32:32 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F01165B5;
        Fri, 18 Nov 2022 16:37:27 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id c7so5026217iof.13;
        Fri, 18 Nov 2022 16:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad8ss5RArgJrnDOHAbd/xNyjFS/cmNN++MlpW3Otizs=;
        b=7psNjB2s1KkgYyAIO9wTHYEYwbs/Ey1udOKj1qWdf61TANw6vqLQVsbOThtrEPyuXb
         yyDvec79M2HgrQIptIa9qnJ7HJ7w7ags796GyLV31iusvxbmC1IPHCuBm0zT3iLG7DoC
         BVhFfgngOa5P6dSlHIKyeFOyRYXMGwhRW4wPvS/uOhWEJj7qL5DEO0XbR9uMuS8xbhv0
         6Lje8X82/OhZdvqU0oQO1z/peI2GwAmOKnphuo26thIddT/Q5Ww6TIF7BQegFJCmU35/
         sx1KNjvoZR+wECcDcW7XfKI1/2OUtNrUoAK/Hf7tSnajwWjXOh28yfaaPzc3UGE5f6Nh
         moFA==
X-Gm-Message-State: ANoB5pkvPE7bE+ttF8RXWG1csogfNfD8CdHfDfPf18D/ce7+jGYfAsR1
        t2yutYqP59M6xCY8GRSd5bDKPo6RwAaCqoKVM1c=
X-Google-Smtp-Source: AA0mqf6NDIA+DsMokyUak4hcn7R7kTEFghM/Vszq+LniGklSHw86Y0jfBlmP2jBUoFPfa74XxhdB/Y+RX02/NylH0lA=
X-Received: by 2002:a02:a399:0:b0:363:a2f8:5223 with SMTP id
 y25-20020a02a399000000b00363a2f85223mr4001619jak.282.1668818246166; Fri, 18
 Nov 2022 16:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20221117224952.358639-1-irogers@google.com> <20221117224952.358639-2-irogers@google.com>
 <Y3dQxVNwGmQMWPP0@hirez.programming.kicks-ass.net> <Y3eejjLjChlGC96I@kernel.org>
 <20221118103302.7ea12016@gandalf.local.home> <Y3ez+y/k1dIip5hH@kernel.org>
In-Reply-To: <Y3ez+y/k1dIip5hH@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Nov 2022 16:37:12 -0800
Message-ID: <CAM9d7chHHuULqNS-YWj=LU=Q0E10zjMe5=HTnBREa4=YmQGPpA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf build: Require libtraceevent from the system
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 18, 2022 at 8:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Nov 18, 2022 at 10:33:02AM -0500, Steven Rostedt escreveu:
> > On Fri, 18 Nov 2022 12:02:38 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > > yeah, this probably should work like with other libraries, don't stop
> > > the build, just don't build features that depend on libtraceevent,
> > > warning the user that features foo, bar and baz won't be available.
>
> > > For people working with just hardware, software, cache events, no
> > > problem.
>
> > How are software events parsed?
>
> Not parsed, fixed:

I believe Steve meant tracepoints :)

>
> root@roc-rk3399-pc:~# perf list sw
>
> List of pre-defined events (to be used in -e or -M):
>
>   alignment-faults                                   [Software event]
>   bpf-output                                         [Software event]
>   cgroup-switches                                    [Software event]
>   context-switches OR cs                             [Software event]
>   cpu-clock                                          [Software event]
>   cpu-migrations OR migrations                       [Software event]
>   dummy                                              [Software event]
>   emulation-faults                                   [Software event]
>   major-faults                                       [Software event]
>   minor-faults                                       [Software event]
>   page-faults OR faults                              [Software event]
>   task-clock                                         [Software event]
>
>   duration_time                                      [Tool event]
>   user_time                                          [Tool event]
>   system_time                                        [Tool event]
>
> root@roc-rk3399-pc:~#
>
>
> In addition to:
>
> root@roc-rk3399-pc:~# perf list hw
>
> List of pre-defined events (to be used in -e or -M):
>
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   bus-cycles                                         [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
>
> root@roc-rk3399-pc:~#
>
> And:
>
> root@roc-rk3399-pc:~# perf list cache
>
> List of pre-defined events (to be used in -e or -M):
>
>   L1-dcache-load-misses                              [Hardware cache event]
>   L1-dcache-loads                                    [Hardware cache event]
>   L1-dcache-prefetch-misses                          [Hardware cache event]
>   L1-dcache-store-misses                             [Hardware cache event]
>   L1-dcache-stores                                   [Hardware cache event]
>   L1-icache-load-misses                              [Hardware cache event]
>   L1-icache-loads                                    [Hardware cache event]
>   branch-load-misses                                 [Hardware cache event]
>   branch-loads                                       [Hardware cache event]
>   dTLB-load-misses                                   [Hardware cache event]
>   dTLB-store-misses                                  [Hardware cache event]
>   iTLB-load-misses                                   [Hardware cache event]
>   node-loads                                         [Hardware cache event]
>   node-stores                                        [Hardware cache event]
>
> root@roc-rk3399-pc:~#
>
> Without something like libtraceevent 'perf probe', 'perf trace' wouldn't
> work as of now, as it currently use libtraceevent to parse whats in
> tracefs.

Right, many other tools would be impacted like 'perf lock', 'perf sched', ...

>
> So for some people, just interested in profiling the above hw, sw and
> cache events, libtraceevent isn't strictly required and may even be
> desirable to reduce the number of library dependencies.
>
> So its a valid feature to allow perf to be built without libtraceevent,
> i.e. not something needed for the above scenarios.

Right, we could remove unsupported commands from the build or
refuse to run them with a warning.

Thanks,
Namhyung

>
> With libbpf and BTF tracefs isn't also strictly needed, as we already
> have to link with it and things like 'perf trace' want to use libbpf's
> btf pretty printing stuff, we can use BTF to enumerate events, iterate
> thru its fields, offsets, types, etc:
>
> root@roc-rk3399-pc:~# pahole --sizes | grep trace_event_raw_sched
> trace_event_raw_sched_kthread_stop      28      0
> trace_event_raw_sched_kthread_stop_ret  12      0
> trace_event_raw_sched_kthread_work_queue_work   32      0
> trace_event_raw_sched_kthread_work_execute_start        24      0
> trace_event_raw_sched_kthread_work_execute_end  24      0
> trace_event_raw_sched_wakeup_template   36      0
> trace_event_raw_sched_switch    64      0
> trace_event_raw_sched_migrate_task      40      0
> trace_event_raw_sched_process_template  32      0
> trace_event_raw_sched_process_wait      32      0
> trace_event_raw_sched_process_fork      48      0
> trace_event_raw_sched_process_exec      20      0
> trace_event_raw_sched_stat_runtime      48      1
> trace_event_raw_sched_pi_setprio        36      0
> trace_event_raw_sched_move_numa 36      0
> trace_event_raw_sched_numa_pair_template        48      0
> trace_event_raw_sched_wake_idle_without_ipi     12      0
> root@roc-rk3399-pc:~#
>
> root@roc-rk3399-pc:~# pahole trace_event_raw_sched_switch
> struct trace_event_raw_sched_switch {
>         struct trace_entry         ent;                  /*     0     8 */
>         char                       prev_comm[16];        /*     8    16 */
>         pid_t                      prev_pid;             /*    24     4 */
>         int                        prev_prio;            /*    28     4 */
>         long int                   prev_state;           /*    32     8 */
>         char                       next_comm[16];        /*    40    16 */
>         pid_t                      next_pid;             /*    56     4 */
>         int                        next_prio;            /*    60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         char                       __data[];             /*    64     0 */
>
>         /* size: 64, cachelines: 1, members: 9 */
> };
> root@roc-rk3399-pc:~#
>
> - Arnaldo
