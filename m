Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23E6F0D89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjD0VAy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 17:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0VAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:00:53 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52C91FCF;
        Thu, 27 Apr 2023 14:00:51 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso15938328276.1;
        Thu, 27 Apr 2023 14:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629251; x=1685221251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kvYxpjeLPo7WDMrzQZYkWfCYagia5wd3uIpVtMajJE=;
        b=Ll03KH4f0DkA/YO7rDLoRaA4RvqAc8oVh/i8sYiSQXgNa0kAyPxCouxU7/wR/aI6f7
         7qrXV+V9x/igzMdeV1fCzsLIN4PeCRxsHfrcau26fgL7NpWNOTeOOPUrS1ZDB2S9arJD
         lynlBkkkznfiMzqJMaFnGAvvqrm4G+4BdGsTLBPLD8Y5NuCkX0SZGoXQijCVVP2soFpZ
         zgexOXE9REaypbDqVAT6cmrNVSNXu3UKsULHFkUnbwZGTfM4mYrs1cjj9iXni8ls0+Lq
         e6+vQ48G8Q67bhoIP4ridw0FJOjlPmemr/ouJLDV7l27hGYpvE8mMoUmTWkKVr72krqK
         /xaA==
X-Gm-Message-State: AC+VfDwHKi5KLJuKPjGjBTgIN+3jjUiMcS8AvP4DIl3afvq3PVH+lT59
        6/Xx23/pZX1OQiv+v2a2qQsn6tQMZh6LJ/B7uh1UiMST
X-Google-Smtp-Source: ACHHUZ5kVD5gERQXzSBOXyhV079FHn4ViQgX/oMFP1P3ERlbBzWOrMhQB7zIgrJtOzwXz9iUymQ9fW5GpLWs63mD2Bk=
X-Received: by 2002:a25:ad12:0:b0:b99:4af6:185d with SMTP id
 y18-20020a25ad12000000b00b994af6185dmr2138029ybi.6.1682629250755; Thu, 27 Apr
 2023 14:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-2-irogers@google.com>
 <77dd1ab3-9c94-c04a-24de-f8c192a6c8d2@linux.intel.com> <CAP-5=fVBFjnmCuzSud=oGj6nGCs7haMkALGS+ZGJEyD4dSYqTA@mail.gmail.com>
In-Reply-To: <CAP-5=fVBFjnmCuzSud=oGj6nGCs7haMkALGS+ZGJEyD4dSYqTA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 27 Apr 2023 14:00:39 -0700
Message-ID: <CAM9d7chavGHmtKiVkAo7fpUm=B3r3xNYgW__6dZe9D+3nmy7dA@mail.gmail.com>
Subject: Re: [PATCH v1 01/40] perf stat: Introduce skippable evsels
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 27, 2023 at 1:21 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Apr 27, 2023 at 11:54 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> > > Perf stat with no arguments will use default events and metrics. These
> > > events may fail to open even with kernel and hypervisor disabled. When
> > > these fail then the permissions error appears even though they were
> > > implicitly selected. This is particularly a problem with the automatic
> > > selection of the TopdownL1 metric group on certain architectures like
> > > Skylake:
> > >
> > > ```
> > > $ perf stat true
> > > Error:
> > > Access to performance monitoring and observability operations is limited.
> > > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > > access to performance monitoring and observability operations for processes
> > > without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> > > More information can be found at 'Perf events and tool security' document:
> > > https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> > > perf_event_paranoid setting is 2:
> > >   -1: Allow use of (almost) all events by all users
> > >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> > >> = 0: Disallow raw and ftrace function tracepoint access
> > >> = 1: Disallow CPU event access
> > >> = 2: Disallow kernel profiling
> > > To make the adjusted perf_event_paranoid setting permanent preserve it
> > > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > > ```
> > >
> > > This patch adds skippable evsels that when they fail to open won't
> > > fail and won't appear in output. The TopdownL1 events, from the metric
> > > group, are marked as skippable. This turns the failure above to:
> > >
> > > ```
> > > $ perf stat true
> > >
> > >  Performance counter stats for 'true':
> > >
> > >               1.26 msec task-clock:u                     #    0.328 CPUs utilized
> > >                  0      context-switches:u               #    0.000 /sec
> > >                  0      cpu-migrations:u                 #    0.000 /sec
> > >                 49      page-faults:u                    #   38.930 K/sec
> > >            176,449      cycles:u                         #    0.140 GHz                         (48.99%)
> > >            122,905      instructions:u                   #    0.70  insn per cycle
> > >             28,264      branches:u                       #   22.456 M/sec
> > >              2,405      branch-misses:u                  #    8.51% of all branches
> > >
> > >        0.003834565 seconds time elapsed
> > >
> > >        0.000000000 seconds user
> > >        0.004130000 seconds sys
> > > ```
> >
> > If the same command runs with root permission, a different output will
> > be displayed as below:
> >
> > $ sudo ./perf stat sleep 1
> >
> >  Performance counter stats for 'sleep 1':
> >
> >               0.97 msec task-clock                       #    0.001 CPUs
> > utilized
> >                  1      context-switches                 #    1.030 K/sec
> >                  0      cpu-migrations                   #    0.000 /sec
> >                 67      page-faults                      #   69.043 K/sec
> >          1,135,552      cycles                           #    1.170 GHz
> >                        (50.51%)
> >          1,126,446      instructions                     #    0.99  insn
> > per cycle
> >            252,904      branches                         #  260.615 M/sec
> >              7,297      branch-misses                    #    2.89% of
> > all branches
> >             22,518      CPU_CLK_UNHALTED.REF_XCLK        #   23.205
> > M/sec
> >             56,994      INT_MISC.RECOVERY_CYCLES_ANY     #   58.732 M/sec
> >
> > The last two events are useless.
>
> You missed the system wide (-a) flag.
>
> Thanks,
> Ian
>
> > It's not reliable to rely on perf_event_open()/kernel to tell whether
> > an event is available or skippable. Kernel wouldn't check a specific event.
> >
> > The patch works for the non-root mode is just because the event requires
> > root permission. It's rejected by the kernel because of lacking
> > permission. But if the same command runs with root privileges, the trash
> > events are printed as above.
> >
> > I think a better way is to check the HW capability and decided whether
> > to append the TopdownL1 metrics.
> >
> > https://lore.kernel.org/lkml/20230427182906.3411695-1-kan.liang@linux.intel.com/

Maybe we can also check if the event is actually enabled like
checking the enabled_time.  Then skip the skippable and not
enabled ones.

Thanks,
Namhyung
