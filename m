Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ECC5B3ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiIISaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIISaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:30:07 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6ED4F667;
        Fri,  9 Sep 2022 11:30:03 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id c39-20020a05683034a700b006540d515722so1605885otu.5;
        Fri, 09 Sep 2022 11:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ilSfsHuauaBaX7YxuMRWUeTBHI+PdUdFPCrzpUDbHMY=;
        b=cy9gszyn/rYHzNSs4P7exOIuFXdG4JA8NBcAlk2Cm1BbBe7+um0/n7+GKgbXBx47vv
         2GVBfkJMbsgsoqiuUfISCBcd7yzzhjFDOhEYzNP6bQHHqI3y7+lFUN84U3bpshUM+dTU
         n6Q29jzRpcMWSX58Q6+oN0lR6Ng8bySVonUHBFCmUQUJ5oGmJJxlwWLBGk4ca2HUjC8A
         iisXTUSauYa0MVsy3nv9fXPluee3H6yEEH/Wlwk2kbqgujIDhs+Gd2QT9cwNPkDnkMjA
         VHPrLCwdYHOzPqMeTnMc3LKmjdGFFxYU1kfViAWBv4DBtQbDtD9F6QojckJOBMZ+eO6A
         TROQ==
X-Gm-Message-State: ACgBeo0OMbUCKbI0VYXvFDVwiAbINJUTXjo+Hzzea2hjzIi97krIqxWr
        w/c31yIkZKSbowh4VkXENwqlu5UCtbCth/vKTvU=
X-Google-Smtp-Source: AA6agR5p3LgCV7mS2TJog8tMWIY2dbAGHYewjtjKJ4n1pSVRVxk52zv2tKxs71TkwfUkEtLZehQsHbk8TxRTRxivyyU=
X-Received: by 2002:a9d:2f48:0:b0:655:bba3:2e1a with SMTP id
 h66-20020a9d2f48000000b00655bba32e1amr434229otb.124.1662748202258; Fri, 09
 Sep 2022 11:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com> <20220831174926.579643-5-irogers@google.com>
 <CAM9d7cgRb6_jFXCfoZZ+=K5WSH42hj4U2ZH-i-4oZTMKw+LAiA@mail.gmail.com> <CAP-5=fXVE+vLB2GN9pkvfj4jLa2Bdg6LY24yFtZ+ix5bP9QGpQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXVE+vLB2GN9pkvfj4jLa2Bdg6LY24yFtZ+ix5bP9QGpQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 9 Sep 2022 11:29:51 -0700
Message-ID: <CAM9d7chqT957GZ0SyroU7Yt5T+y-iJxixAqqwmBqLNLeq-wWCQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] perf topology: Add core_wide
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 11:56 AM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Sep 1, 2022 at 11:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Aug 31, 2022 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > It is possible to optimize metrics when all SMT threads (CPUs) on a
> > > core are measuring events in system wide mode. For example, TMA
> > > metrics defines CORE_CLKS for Sandybrdige as:
> > >
> > > if SMT is disabled:
> > >   CPU_CLK_UNHALTED.THREAD
> > > if SMT is enabled and recording on all SMT threads:
> > >   CPU_CLK_UNHALTED.THREAD_ANY / 2
> > > if SMT is enabled and not recording on all SMT threads:
> > >   (CPU_CLK_UNHALTED.THREAD/2)*
> > >   (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
> > >
> > > That is two more events are necessary when not gathering counts on all
> > > SMT threads. To distinguish all SMT threads on a core vs system wide
> > > (all CPUs) call the new property core wide.  Add a core wide test that
> > > determines the property from user requested CPUs, the topology and
> > > system wide. System wide is required as other processes running on a
> > > SMT thread will change the counts.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > [SNIP]
> > > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > > index ce90c4ee4138..994e9e418227 100644
> > > --- a/tools/perf/util/smt.c
> > > +++ b/tools/perf/util/smt.c
> > > @@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
> > >         cached = true;
> > >         return cached_result;
> > >  }
> > > +
> > > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > > +              const struct cpu_topology *topology)
> > > +{
> > > +       /* If not everything running on a core is being recorded then we can't use core_wide. */
> > > +       if (!system_wide)
> > > +               return false;
> >
> > I'm not sure if it's correct.  Wouldn't it be ok if it runs on all
> > threads in a core
> > even if system wide is off?  I thought that's what the below code checks.
> >
> > In fact I thought the opposite logic like
> >
> >     if (system_wide)
> >         return true;
> >
> > But it seems the code allows to have cpu_list in the system wide mode.
> > Then it also needs to check the user requested cpus being NULL.
> > (IMHO system_wide should be cleared when it has a cpu list...)
> >
> >     if (system_wide && !user_requested_cpu_list)
> >         return true;
> >
> > And if we have a target pointer, we could add this too.
> >
> >     if (!target__has_cpu(target))
> >         return false;
> >
> > Thanks,
> > Namhyung
>
> Thanks Namhyung,
>
> It may be correct or may not be without the system wide flag, and so I
> want to be conservative and say we need the flag. Let me provide more
> detail with an example:

Ok.

>
> I'm going to assume we want to measure how many slots there were for
> an SMT thread. In the "Count Domain" of TMA metrics before Icelake
> slots is a core wide metric, meaning that you are measuring >1 hyper
> thread. As we are measuring >1 hyper thread and we don't control the
> scheduling of the other hyperthread, the only valid mode is system
> wide on all CPUs, or all CPUs on a core (aka core wide in this patch
> set). However, the slots count domain information also says "Slots -
> ICL onwards or EBS_Mode before ICL" meaning the count domain is valid
> for an SMT thread. If I look at SkylakeX currently we have two
> metrics:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json?h=perf/core#n167
>
>     {
>        "BriefDescription": "Total issue-pipeline slots (per-Physical
> Core till ICL; per-Logical Processor ICL onward)",
>        "MetricExpr": "4 * CPU_CLK_UNHALTED.THREAD",
>        "MetricGroup": "TmaL1",
>        "MetricName": "SLOTS"
>    },
>    {
>        "BriefDescription": "Total issue-pipeline slots (per-Physical
> Core till ICL; per-Logical Processor ICL onward)",
>        "MetricExpr": "4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
> CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
>        "MetricGroup": "TmaL1_SMT",
>        "MetricName": "SLOTS_SMT"
>    },
>
> The SLOTS metrics is going to compute a valid value if hyperthreading
> is disabled, in other metrics you will see
> (CPU_CLK_UNHALTED.THREAD_ANY / 2) where THREAD.ANY and THREAD are the
> same event encoding. The reason for the divide by 2 is to adjust the
> count down so that when we add the other hyperthreads count we get the
> core wide value in the aggregation - the perf event on the 2nd hyper
> thread isn't necessary, but that's a separate problem. SLOTS_SMT is
> funny so let's dig into it:
> The 4 is the pipeline width.
> CPU_CLK_UNHALTED.THREAD is defined as, "Counts the number of core
> cycles while the thread is not in a halt state.."
> The divide by 2 is because of 2 hyperthreads.
> The 1 is because we assume that half the slots are going to be given
> to our hyperthread.
> The CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK
> will give a ratio for how many cycles our SMT thread was the only one
> running, and so we got those slots from the other hyperthread.
>
> With #core_wide we can have a single SLOTS metric of (new lines and //
> comments for clarity):
>
> // If we're #core_wide with SMT and we know the work on both
> hyperthreads are being measured for all processes then use a single
> counter
> (4 * CPU_CLK_UNHALTED.THREAD_ANY / 2
>   if #core_wide else
> // We're not core wide so we need thread counters to adjust the slots
> metric based on the time this SMT thread is active
>   4 * ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
> CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )
> ) if #smt_on
> // No hyper threading can just use the core wide counter
> else 4 * CPU_CLK_UNHALTED.THREAD
>
> As this metric is a foundation for many others then there is a great
> deal of use for it and the current pre-Icelake computation is
> generally only valid if on the command line you happen to have
> specified a core wide set up - which is error prone.

Thanks for the explanation.  I understand why we need core_wide
for accurate metrics.  My concern was just to have a clear
relationship between system-wide mode and user requested cpu list.

But I think it should be a separate thread, let me work on cpu map
cleanups as we discussed earlier in:

https://lore.kernel.org/r/20220506122601.367589-23-adrian.hunter@intel.com/

Thanks,
Namhyung
