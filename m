Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBE6DC2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDJDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDJDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:13:56 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C23C29
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 20:13:54 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id fg17so399689qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 20:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681096434; x=1683688434;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ2FHd/rEo60DgWoL+ZQRVqvlWFMITowmXmMK605RI0=;
        b=QpPaltWv9o7Z1z17c7ya7tmBPOEox/Zu2u6oEBjZhvJS+OWp+TASYizy+leJ3/SqHV
         ojbSKmnpRbrP4b8f36dw2gZECcMLWIsZ3y0HEXUESlDZr1qt3kKJD+Lhv7/JIXccaI6T
         EWdNXh+FJdfL3H5Rq/zvkYxQrLyUBkCCjhb/N75SsQl2TluNLYwOSfgnsIgsgi2KPaRX
         EgHCCt+rQxW6uPoICbJ0B/9X/wypZz/oAT+gRfrRIsqZYaMyEXDdNv3H+XzWacAYjRsL
         BhjxZ52q6Z71z6dEZxzJs5lZ/KE7s1IRYwN6k6DTN5NPGySoSRUi+3vcPBjYJNB0qjc9
         zFyw==
X-Gm-Message-State: AAQBX9d+x3HOPbwj4efOro0V+OX0Bz0RUTb1NNbSGxj/+E656Jzhv9xN
        Pjq1y9juKwrsaY2tXATVErs=
X-Google-Smtp-Source: AKy350boHHpdWnHK1vPTlWIVFVaG4LExeaKwDwozaDbyXnHq8LW+LwCZtoVSzBC2xRg75UZiPPuSXw==
X-Received: by 2002:a05:622a:191:b0:3e6:9e18:73ed with SMTP id s17-20020a05622a019100b003e69e1873edmr7025923qtw.26.1681096433708;
        Sun, 09 Apr 2023 20:13:53 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b51f])
        by smtp.gmail.com with ESMTPSA id b18-20020ac86bd2000000b003bfc355c3a6sm685891qtt.80.2023.04.09.20.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 20:13:53 -0700 (PDT)
Date:   Sun, 9 Apr 2023 22:13:50 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        clm@meta.com, tj@kernel.org, djk@meta.com
Subject: Re: [PATCH 00/17] sched: EEVDF using latency-nice
Message-ID: <20230410031350.GA49280@maniforge>
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328092622.062917921@infradead.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:26:22AM +0200, Peter Zijlstra wrote:
> Hi!
> 
> Latest version of the EEVDF [1] patches.
> 
> Many changes since last time; most notably it now fully replaces CFS and uses
> lag based placement for migrations. Smaller changes include:
> 
>  - uses scale_load_down() for avg_vruntime; I measured the max delta to be ~44
>    bits on a system/cgroup based kernel build.
>  - fixed a bunch of reweight / cgroup placement issues
>  - adaptive placement strategy for smaller slices
>  - rename se->lag to se->vlag
> 
> There's a bunch of RFC patches at the end and one DEBUG patch. Of those, the
> PLACE_BONUS patch is a mixed bag of pain. A number of benchmarks regress
> because EEVDF is actually fair and gives a 100% parent vs a 50% child a 67%/33%
> split (stress-futex, stress-nanosleep, starve, etc..) instead of a 50%/50%
> split that sleeper bonus achieves. Mostly I think these benchmarks are somewhat
> artificial/daft but who knows.
> 
> The PLACE_BONUS thing horribly messes up things like hackbench and latency-nice
> because it places things too far to the left in the tree. Basically it messes
> with the whole 'when', by placing a task back in history you're putting a
> burden on the now to accomodate catching up. More tinkering required.
> 
> But over-all the thing seems to be fairly usable and could do with more
> extensive testing.

Hi Peter,

I used the EEVDF scheduler to run workloads on one of Meta's largest
services (our main HHVM web server), and I wanted to share my
observations with you.

The TL;DR is that, unfortunately, it appears as though EEVDF regresses
these workloads rather substantially. Running with "vanilla" EEVDF (i.e.
on this patch set up to [0], with no changes to latency nice for any
task) compared to vanilla CFS results in the following outcomes to our
major KPIs for servicing web requests:

- .5 - 2.5% drop in throughput
- 1 - 5% increase in p95 latencies
- 1.75 - 6% increase in p99 latencies
- .5 - 4% drop in 50th percentile throughput

[0]: https://lore.kernel.org/lkml/20230328110354.562078801@infradead.org/

Decreasing latency nice for our critical web workers unfortunately did
not help either. For example, here are the numbers for a latency nice
value of -10:

- .8 - 2.5% drop in throughput
- 2 - 4% increase in p95 latencies
- 1 - 4.5% increase in p99 latencies
- 0 - 4.5% increase in 50th percentile throughput

Other latency nice values resulted in similar metrics. Some metrics may
get slightly better, and others slightly worse, but the end result was
always a relatively significant regression from vanilla CFS. Throughout
the rest of this write up, the remaining figures quoted will be from
vanilla EEVDF runs (modulo some numbers towards the end of this writeup
which describe the outcome of increasing the default base slice with
sysctl_sched_base_slice).

With that out the way, let me outline some of the reasons for these
regressions:

1. Improved runqueue delays, but costly faults and involuntary context
   switches

EEVDF substantially increased the number of context switches on the
system, by 15 - 35%. On its own, this doesn't necessarily imply a
problem. For example, we observed that EEVDF resulted in a 20 - 40%
reduction in the time that tasks were spent waiting on the runqueue
before being placed on a CPU.

There were, however, other metrics which were less encouraging. We
observed a 400 - 550% increase in involuntary context switches (which
are also presumably a reason for the improved runqueue delays), as well
as a 10 - 70% increase in major page faults per minute. Along these
lines, we also saw an erratic but often sigificant decrease in CPU
utilization.

It's hard to say exactly what kinds of issues such faults / involuntary
context context switches could introduce, but it does seem clear that in
general, less time is being spent doing useful work, and more time is
spent thrashing on resources between tasks.

2. Front-end CPU pipeline bottlenecks

Like many (any?) other JIT engines / compilers, HHVM tends to be heavily
front-end bound in the CPU pipeline, and have very poor IPC
(Instructions Per Cycle). For HHVM, this is due to high branch resteers,
poor icache / iTLB locality, and poor uop caching / decoding (many uops
are being serviced through the MITE instead of the DSB). While using
BOLT [1] to improve the layout of the HHVM binary does help to minimize
these costs, they're still the main bottleneck for the application.

[1]: https://github.com/llvm/llvm-project/blob/main/bolt/docs/OptimizingClang.md

An implication of this is that any time a task runs on a CPU after one
of these web worker tasks, it is essentially guaranteed to have poor
front-end locality, and their IPCs will similarly suffer. In other
words, more context switches generally means fewer instructions being
run across the whole system. When profiling vanilla CFS vs. vanilla
EEVDF (that is, with no changes to latency nice for any task), we found
that it resulted in a 1 - 2% drop in IPC across the whole system.

Note that simply partitioning the system by cpuset won't necessarily
work either, as CPU utilization will drop even further, and we want to
keep the system as busy as possible. There's another internal patch set
we have (which we're planning to try and upstream soon) where waking
tasks are placed in a global shared "wakequeue", which is then always
pulled from in newidle_balance(). The discrepancy in performance between
CFS and EEVDF is even worse in this case, with throughput dropping by 2
- 4%, p95 tail latencies increasing by 3 - 5%, and p99 tail latencies
increasing by 6 - 11%.

3. Low latency + long slice are not mutually exclusive for us

An interesting quality of web workloads running JIT engines is that they
require both low-latency, and long slices on the CPU. The reason we need
the tasks to be low latency is they're on the critical path for
servicing web requests (for most of their runtime, at least), and the
reasons we need them to have long slices are enumerated above -- they
thrash the icache / DSB / iTLB, more aggressive context switching causes
us to thrash on paging from disk, and in general, these tasks are on the
critical path for servicing web requests and we want to encourage them
to run to completion.

This causes EEVDF to perform poorly for workloads with these
characteristics. If we decrease latency nice for our web workers then
they'll have lower latency, but only because their slices are smaller.
This in turn causes the increase in context switches, which causes the
thrashing described above.

Worth noting -- I did try and increase the default base slice length by
setting sysctl_sched_base_slice to 35ms, and these were the results:

With EEVDF slice 35ms and latency_nice 0
----------------------------------------
- .5 - 2.25% drop in throughput
- 2.5 - 4.5% increase in p95 latencies
- 2.5 - 5.25% increase in p99 latencies
- Context switch per minute increase: 9.5 - 12.4%
- Involuntary context switch increase: ~320 - 330%
- Major fault delta: -3.6% to 37.6%
- IPC decrease .5 - .9%

With EEVDF slice 35ms and latency_nice -8 for web workers
---------------------------------------------------------
- .5 - 2.5% drop in throughput
- 1.7 - 4.75% increase in p95 latencies
- 2.5 - 5% increase in p99 latencies
- Context switch per minute increase: 10.5 - 15%
- Involuntary context switch increase: ~327 - 350%
- Major fault delta: -1% to 45%
- IPC decrease .4 - 1.1%

I was expecting the increase in context switches and involuntary context
switches to be lower what than they ended up being with the increased
default slice length. Regardless, it still seems to tell a relatively
consistent story with the numbers from above. The improvement in IPC is
expected, though also less improved than I was anticipating (presumably
due to the still-high context switch rate). There were also fewer major
faults per minute compared to runs with a shorter default slice.

Note that even if increasing the slice length did cause fewer context
switches and major faults, I still expect that it would hurt throughput
and latency for HHVM given that when latency-nicer tasks are eventually
given the CPU, the web workers will have to wait around for longer than
we'd like for those tasks to burn through their longer slices.

In summary, I must admit that this patch set makes me a bit nervous.
Speaking for Meta at least, the patch set in its current form exceeds
the performance regressions (generally < .5% at the very most) that
we're able to tolerate in production. More broadly, it will certainly
cause us to have to carefully consider how it affects our model for
server capacity.

Thanks,
David
