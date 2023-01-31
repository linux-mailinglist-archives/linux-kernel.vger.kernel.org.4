Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9226E682091
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjAaAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAaAUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:20:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642051BDB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:20:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o36so3201470wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2R1l1KXTlxkQctxviZUMK4F3c6Tvmoj5mf7jL+CtvU=;
        b=NAbmcHp+f6xb0uSPCIo+giObrAGk+u1HBiEVrIRWb8FT419xy1KandTI+f1KOqZJ6R
         i8aRRLOYFU09YnyT656Nu2yWu/r0T0CWU6bcAUK3x8wZlQzzcgqWnuqnHV27n2vEYP0a
         +D+nrxDwtNSfpkKxtyKBu3E8iELWmn5QIpal6NH3m4ZuUrKWqTj7rHzlcIVQckUAK+QZ
         8UvDnRIlAAITxCV8GVduhjsdic7ijJDAAoG4j3EOQdmqq8tCA/mv+kMIvoqgeIbQn7aH
         UrqkrWTazFUWNObU84Lae/5R16eMyAIj+NIAbkXFfGJFg+/IlXJcsX8AOl9HoFDf6B8c
         AkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2R1l1KXTlxkQctxviZUMK4F3c6Tvmoj5mf7jL+CtvU=;
        b=0XLyS7oiofW0P0sDdsEgLhBMTZlY8g4pM1D5XTn/Q13CWj0Nv19/+q7P1YR5NHx+jE
         6WxucUOpdgU1fwz+9M12AnAIXBZgq5j1J+MtrdIeL3/7dPhcfL3b6pGyzQ/aC8uKPoQW
         hWHDlv9c2HrH34xD/KJmFHZ21h7kbLoaWc9EL8esXgleI8E74l391JstWmTFgTeWBAix
         nhdYjVY3TgoNQZNO6tnUxDecsC/1MiTnLi953oGHgRBG7NIu9GI94BVGsMSRwYCja9Sh
         ov+MHPc/4tr5gwcypz8SeEiOYQ1ZVdEVZ9XKi7hkikdrz8pFvAvtgTf1GfQewENGw192
         V40g==
X-Gm-Message-State: AO0yUKWiv8MUVGegbgmdwl8rYJRZHhne6ok6+CDH97T2MEyTU2zqMoyK
        Ep3S22TGkCQ+KIfjY+JBpm25qgKwGMGzxKaO8QHUxg==
X-Google-Smtp-Source: AK7set/qHndENu2j5t79klwLaNXaVzscFDLQRGiB36tpdqdbf4AIKN9yOI4Nje8L9ys/mxzUfRR1cz8Xwimz2BC3NjI=
X-Received: by 2002:a1c:2b07:0:b0:3dc:19fc:3059 with SMTP id
 r7-20020a1c2b07000000b003dc19fc3059mr1484779wmr.188.1675124438577; Mon, 30
 Jan 2023 16:20:38 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
 <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
 <CA+icZUUOZoLOFiBcYkccWPSusk9G_Rhf3DOZYWat-K+VfWFHQw@mail.gmail.com> <c6605d52-b9e1-e8d3-ed29-562146f64eea@arm.com>
In-Reply-To: <c6605d52-b9e1-e8d3-ed29-562146f64eea@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 30 Jan 2023 16:20:26 -0800
Message-ID: <CAP-5=fWcb8m9vkfqSC9H2Gqi2dBjbPuGb2F27Fq-ejmR25foQw@mail.gmail.com>
Subject: Re: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "Xing, Zhengjun" <zhengjun.xing@intel.com>, sedat.dilek@gmail.com
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        llvm@lists.linux.dev, Ben Hutchings <benh@debian.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 2:04 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 30/01/2023 02:24, Sedat Dilek wrote:
> > ?
> >
> > On Mon, Jan 30, 2023 at 12:21 AM Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Sun, Jan 29, 2023 at 1:59 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>
> >>> [ CC LLVM linux folks + Ben from Debian kernel team ]
> >>>
> >>> Hi,
> >>>
> >>> I am playing with LLVM version 16.0.0-rc1 which was released yesterday and PERF.
> >>>
> >>> After building my selfmade LLVM toolchain, I built perf and run some
> >>> perf tests here on my Intel SandyBridge CPU (details see below).
> >>>
> >>> perf all metrics test: FAILED!
> >>>
> >>> ...with both Debian's perf version 6.1.7 and my selfmade version 6.2-rc5.
> >>>
> >>> Just noticed:
> >>>
> >>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> >>> BPF maps, etc
> >>>
> >>> Run the below tests with `sudo` - made this go away - still FAILED.
> >>>
> >>> But maybe I am missing to activate some sysfs/debug or whatever other stuff?
> >>
> >> Hi Sedat,
> >>
> >> things have been improving wrt metrics and so this failure may have
> >> just been because of the addition of a previously missing metric. The
> >> rlimit thing shouldn't affect things but maybe file descriptors?
> >> Looking at the test output the issue is:
> >>
> >> ```
> >> Metric 'tma_dram_bound' not printed in:
> >> # Running 'internals/synthesize' benchmark:
> >> Computing performance of single threaded perf event synthesis by
> >> synthesizing events on the perf process itself:
> >>   Average synthesis took: 207.680 usec (+- 0.176 usec)
> >>   Average num. events: 30.000 (+- 0.000)
> >>   Average time per event 6.923 usec
> >>   Average data synthesis took: 217.833 usec (+- 0.202 usec)
> >>   Average num. events: 161.000 (+- 0.000)
> >>   Average time per event 1.353 usec
> >>
> >>  Performance counter stats for 'perf bench internals synthesize':
> >>
> >>      <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
> >>                          (0,00%)
> >>      <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
> >>                          (0,00%)
> >>      <not counted>      CPU_CLK_UNHALTED.THREAD
> >>                          (0,00%)
> >>      <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
> >>                             (0,00%)
> >> ```
> >>
> >> So the test was checking to see whether the tma_dram_bound metric
> >> could be computed on your Sandybridge and it failed. The event counts
> >> below show that every event came back "<not counted>" which is usually
> >> indicative of a permissions problem - it is also not surprising given
> >> this that the metric wasn't computed. You could try repeating the
> >> command the test is trying with something like "perf stat -M
> >> tma_dram_bound -a sleep 1", but running as root should have resolved
> >> that issue. Does that give you enough to keep exploring?
> >>
> >
> > Hi Ian,
> >
> > Thanks for your feedback!
> >
> > I booted into my Debian kernel - just to see what happens.
> >
> > # cat /proc/version
> > Linux version 6.1.0-2-amd64 (debian-kernel@lists.debian.org) (gcc-12
> > (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1
> > SMP PREEMPT_DYNAMIC Debian 6.1.7-1 (2023-01-18)
> >
> > All things run as root...
> >
> > # echo 0 | tee /proc/sys/kernel/kptr_restrict
> > /proc/sys/kernel/perf_event_paranoid
> > 0
> >
> > # /usr/bin/perf test 10 92 98 99 100 101
> > 10: PMU events                                                      :
> > 10.1: PMU event table sanity                                        : Ok
> > 10.2: PMU event map aliases                                         : Ok
> > 10.3: Parsing of PMU event table metrics                            : Ok
> > 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> > 92: perf record tests                                               : Ok
> > 98: perf stat tests                                                 : Ok
> > 99: perf all metricgroups test                                      : Ok
> > 100: perf all metrics test                                           : FAILED!
> > 101: perf all PMU test                                               : Ok
> >
> > # perf stat -M tma_dram_bound -a sleep 1
> >
> > Performance counter stats for 'system wide':
> >
> >     <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
> >                   (0,00%)
> >     <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
> >                      (0,00%)
> >     <not counted>      CPU_CLK_UNHALTED.THREAD
> >               (0,00%)
> >     <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
> >                         (0,00%)
> >
>
> Hi Sedat,
>
> I also had this failure and did a git bisect, but it led me to the
> conclusion that it is a stale build issue rather than a regression.
>
> There was a recent commit that renamed/removed some json PMU files which
> the build system can't cope with. I think the tests end up iterating
> over a different set of event names than were generated by the build system.
>
> If you do a clean build the issue should go away. I don't know if there
> is anything more we can do to stop this from happening.
>
> James

So I think this is a kernel bug triggering a perf tool bug. The kernel
bug can be worked around in the perf tool. I only had an Ivybridge to
test with (hence slightly different events) but what I see is both
tma_dram_bound and tma_l3_bound using the same 4 events. I could work
around the "<not counted>" by adding the --metric-no-group flag:

```
$ perf stat -M tma_l3_bound --metric-no-group -a sleep 1

Performance counter stats for 'system wide':

          400,404      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #      4.3 %
tma_l3_bound             (74.99%)
      128,937,891      CYCLE_ACTIVITY.STALLS_L2_PENDING
                        (87.46%)
          167,459      MEM_LOAD_UOPS_RETIRED.LLC_MISS
                        (74.99%)
      759,574,967      CPU_CLK_UNHALTED.THREAD
                        (87.47%)

      1.001526438 seconds time elapsed

$ perf stat -M tma_dram_bound -a --metric-no-group sleep 1

Performance counter stats for 'system wide':

          259,954      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #     15.2 %
tma_dram_bound           (74.99%)
      118,807,043      CYCLE_ACTIVITY.STALLS_L2_PENDING
                        (87.46%)
          111,699      MEM_LOAD_UOPS_RETIRED.LLC_MISS
                        (74.95%)
      587,571,060      CPU_CLK_UNHALTED.THREAD
                        (87.45%)

      1.001518093 seconds time elapsed
```

The issue is that perf metrics use weak groups of events. A weak group
is the same as a group of events initially. We want to use groups of
events with metrics so that all the counters are scheduled in and out
at the same time, and not multiplexed independently. Imagine measuring
IPC but the counts for instructions and cycles are measured at
different periods, the resultant IPC value would be unlikely to be
accurate. If perf_event_open fails then the perf tool retries the
events without the group. If I try just 3 of the events in a weak
group then the failure can be seen:

```
$ perf stat -e "{MEM_LOAD_UOPS_RETIRED.LLC_HIT,MEM_LOAD_UOPS_RETIRED.LLC_MISS,CYCLE_ACTIVITY.STALLS_L2_PENDING}:W"
-a sleep 1

Performance counter stats for 'system wide':

    <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
                        (0.00%)
    <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_MISS
                        (0.00%)
    <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
                        (0.00%)

      1.001458485 seconds time elapsed
```

The kernel should have failed the perf_event_open on opening the third
event and then measured without the group, which it can do with
multiplexing as in the following:

```
$ perf stat -e "MEM_LOAD_UOPS_RETIRED.LLC_HIT,MEM_LOAD_UOPS_RETIRED.LLC_MISS,CYCLE_ACTIVITY.STALLS_L2_PENDING"
-a sleep 1

Performance counter stats for 'system wide':

        1,239,397      MEM_LOAD_UOPS_RETIRED.LLC_HIT
                        (79.06%)
          174,826      MEM_LOAD_UOPS_RETIRED.LLC_MISS
                        (64.60%)
      124,026,024      CYCLE_ACTIVITY.STALLS_L2_PENDING
                        (81.16%)

      1.001483434 seconds time elapsed
```

When the --metric-no-group flag is given to perf then it doesn't
produce the initial weak group, which works around the bug of the
kernel not failing on the 3rd perf_event_open. I've added Kan and
Zhengjun to the e-mail as they work on the Intel kernel PMU code.

There's a question about what we should do in the perf test about
this? I have a few solutions:

1) try metric tests again with the --metric-no-group flag and don't
fail the test if this succeeds. This allows kernel bugs to hide, so
I'm not a huge fan.

2) add a new metric flag/constraint to say not to group, this way the
metric will automatically apply the "--metric-no-group" flag. It is a
bit of work to wire this up but this kind of failure is common enough
in PMUs that it is probably worthwhile. We also need to add the flag
to metrics and I'm not sure how to get a good list of the metrics that
currently fail and require it. This is okay but error prone.

3) fix the kernel bug and let the perf test fail until an adequate
kernel is installed. Probably the best option.

Thanks,
Ian

> >       1,002148600 seconds time elapsed
> >
> > Hmm... looking at... Metric 'tma_l3_bound' ...
> >
> > Running...
> >
> > # perf stat --verbose -M tma_l3_bound -a sleep 1
> > Using CPUID GenuineIntel-6-2A-7
> > metric expr (MEM_LOAD_UOPS_RETIRED.LLC_HIT /
> > (MEM_LOAD_UOPS_RETIRED.LLC_HIT + 7 *
> > MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) *
> > CYCLE_ACTIVITY.STALLS_L2_PENDING / CLKS for tma_l3_bound
> > metric expr CPU_CLK_UNHALTED.THREAD for CLKS
> >
> > found event MEM_LOAD_UOPS_RETIRED.LLC_HIT
> > found event CYCLE_ACTIVITY.STALLS_L2_PENDING
> > found event CPU_CLK_UNHALTED.THREAD
> > found event MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
> >
> > Parsing metric events
> > '{MEM_LOAD_UOPS_RETIRED.LLC_HIT/metric-id=MEM_LOAD_UOPS_RETIRED.LLC_HIT/,CYCLE_ACTIVITY.STALLS_L2_PENDING/metric-id=CYCLE_ACTIVITY.STALLS_L2_PEND
> > ING/,CPU_CLK_UNHALTED.THREAD/metric-id=CPU_CLK_UNHALTED.THREAD/,MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS/metric-id=MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS/}:W'
> > MEM_LOAD_UOPS_RETIRED.LLC_HIT -> cpu/event=0xd1,period=0xc365,umask=0x4/
> > CYCLE_ACTIVITY.STALLS_L2_PENDING ->
> > cpu/event=0xa3,cmask=0x5,period=0x1e8483,umask=0x5/
> > CPU_CLK_UNHALTED.THREAD -> cpu/event=0x3c,period=0x1e8483/
> > MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS -> cpu/event=0xd4,period=0x186a7,umask=0x2/
> >
> > Control descriptor is not initialized
> >
> > MEM_LOAD_UOPS_RETIRED.LLC_HIT: 0 4007421228 0
> > CYCLE_ACTIVITY.STALLS_L2_PENDING: 0 4007421228 0
> > CPU_CLK_UNHALTED.THREAD: 0 4007421228 0
> > MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS: 0 4007421228 0
> >
> > Performance counter stats for 'system wide':
> >
> >     <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
> >                   (0,00%)
> >     <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
> >                      (0,00%)
> >     <not counted>      CPU_CLK_UNHALTED.THREAD
> >               (0,00%)
> >     <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
> >                         (0,00%)
> >
> >       1,002310013 seconds time elapsed
> >
> > So those events/metric-ids resulting in "<not counted>" are all found.
> >
> > What means "Control descriptor is not initialized"?
> >
> > To summarize:
> >
> > Those two tests in "100: perf all metrics test" FAILED:
> >
> > 1. tma_dram_bound
> > 2. tma_l3_bound
> >
> > Best regards,
> > -Sedat-
> >
> >> Thanks,
> >> Ian
> >>
> >>> Last perf version which was OK:
> >>>
> >>> ~/bin/perf -v
> >>> perf version 6.0.0
> >>>
> >>> echo "linux-perf: Adjust limited access to performance monitoring and
> >>> observability operations"
> >>> echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> >>> /proc/sys/kernel/perf_event_paranoid
> >>> 0
> >>>
> >>> ~/bin/perf test 10 86 92 93 94 95
> >>> 10: PMU events                                                      :
> >>> 10.1: PMU event table sanity                                        : Ok
> >>> 10.2: PMU event map aliases                                         : Ok
> >>> 10.3: Parsing of PMU event table metrics                            : Ok
> >>> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >>> 86: perf record tests                                               : Ok
> >>> 92: perf stat tests                                                 : Ok
> >>> 93: perf all metricgroups test                                      : Ok
> >>> 94: perf all metrics test                                           : Ok
> >>> 95: perf all PMU test                                               : Ok
> >>>
> >>> echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
> >>> /proc/sys/kernel/perf_event_paranoid
> >>> echo "linux-perf: Reset limited access to performance monitoring and
> >>> observability operations"
> >>>
> >>> If you need further information, please let me know.
> >>>
> >>> Thanks.
> >>>
> >>> Regards,
> >>> -Sedat-
> >>>
> >>> P.S. Instructions
> >>>
> >>> [ REPRODUCER ]
> >>>
> >>> LLVM_MVER="16"
> >>>
> >>> # Debian LLVM
> >>> ##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
> >>> # Selfmade LLVM
> >>> LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
> >>> if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
> >>>    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> >>> fi
> >>>
> >>> PYTHON_VER="3.11"
> >>> MAKE="make"
> >>> MAKE_OPTS="V=1 -j1 HOSTCC=clang-$LLVM_MVER HOSTLD=ld.lld
> >>> HOSTAR=llvm-ar CC=clang-$LLVM_MVER LD=ld.lld AR=llvm-ar
> >>> STRIP=llvm-strip"
> >>>
> >>> echo "LLVM MVER ........ $LLVM_MVER"
> >>> echo "Path settings .... $PATH"
> >>> echo "Python version ... $PYTHON_VER"
> >>> echo "make line ........ $MAKE $MAKE_OPTS"
> >>>
> >>> LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
> >>>
> >>> LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
> >>> PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
> >>> ../make-log_perf-install_bin_python${PYTHON_VER}_llvm${LLVM_MVER}.txt
> >>>
> >>>
> >>> [ TESTS ]
> >>>
> >>> [ TESTS - START ]
> >>>
> >>> echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> >>> /proc/sys/kernel/perf_event_paranoid
> >>>
> >>> [ TESTS - DEBIAN ]
> >>>
> >>> /usr/bin/perf -v
> >>> perf version 6.1.7
> >>>
> >>> /usr/bin/perf test 10 92 98 99 100 101
> >>>
> >>>  10: PMU events                                                      :
> >>>  10.1: PMU event table sanity                                        : Ok
> >>>  10.2: PMU event map aliases                                         : Ok
> >>>  10.3: Parsing of PMU event table metrics                            : Ok
> >>>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >>>  92: perf record tests                                               : Ok
> >>>  98: perf stat tests                                                 : Ok
> >>>  99: perf all metricgroups test                                      : Ok
> >>> 100: perf all metrics test                                           : FAILED!
> >>> 101: perf all PMU test                                               : Ok
> >>>
> >>> [ TESTS - DILEKS ]
> >>>
> >>> ~/bin/perf -v
> >>> perf version 6.2.0-rc5
> >>>
> >>> ~/bin/perf test 7 87 93 94 95 96
> >>>
> >>>   7: PMU events                                                      :
> >>>   7.1: PMU event table sanity                                        : Ok
> >>>   7.2: PMU event map aliases                                         : Ok
> >>>   7.3: Parsing of PMU event table metrics                            : Ok
> >>>   7.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >>>  87: perf record tests                                               : Ok
> >>>  93: perf stat tests                                                 : Ok
> >>>  94: perf all metricgroups test                                      : Ok
> >>>  95: perf all metrics test                                           : FAILED!
> >>>  96: perf all PMU test                                               : Ok
> >>>
> >>> [ TESTS - FAILED ]
> >>>
> >>> /usr/bin/perf test --verbose 100 2>&1 | tee
> >>> perf-test-verbose-100-perf-all-metrics-test_debian-perf-6-1-7.txt
> >>>
> >>> ~/bin/perf test --verbose 95 2>&1 | tee
> >>> perf-test-verbose-95-perf-all-metrics-test_dileks-perf-6-2-rc5.txt
> >>>
> >>> [ TESTS - STOP ]
> >>>
> >>> echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
> >>> /proc/sys/kernel/perf_event_paranoid
> >>>
> >>> - EOT -
