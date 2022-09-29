Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240445EEFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiI2ICH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiI2IB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:01:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFB27DDC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:00:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d42so1110819lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=19OBThiEKGVdRs9KRgAtb/vZY5LBN6wCEfDZsliQWoM=;
        b=ilIBYMZDeMkOPu/ENhMS3x3i/ZJhCPph0AcW6RdSKieRJ/RhKYbRJyEYAv2f3C1zNS
         ikdMpSBK/8iyH1UlBEeMIw8nuSN4WuTve3Y8ZujykdWbeShOOIrubfYq1WxVmDhT146I
         XmKW1f5q/HFsvmbowojiuXSaabv891SyNvh2iOWd2/1O+vbYkaCz8TlfI3cfUBFgU2w0
         clOpH3K0MMybTp/5DFrMwFUKoAMr6o317cCtmeRSHqKqzTGq0u1jheH7rB5yqUQ80VDn
         7xspFz2DPoYd2GoTI6Z/t1fNql+nukqaEwHQorD32CMpdQQ2BQXJwfW8bYp4Ns0h2ghC
         AokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=19OBThiEKGVdRs9KRgAtb/vZY5LBN6wCEfDZsliQWoM=;
        b=eTsxJwqg9eUsCeDBqg0ts05M1lVvMpCA3/ePklVZXh+JJbi0a1YowUYVGuPklYt6tP
         PkY9ziYHN9vBYTEnmE8di1WGsa3LRQFG/KqmvpAPs19CmuLldaY5Iowk7r5kcnzmvVTo
         jshCss9CMx+NF+vnqGh8daaBArSitNo4dDAMlBb95/dsmZeEZwLqnJnYaHeQOzLH7Pyz
         z1Q21aB2oNUv7GN5ZC6HNhH9v393Z8L+WAXxLzxmaleW584uMNYV6Xas1W4MaR0pJbiQ
         TbUY/QPF4n5CLqBLFJOG90ztI15HpoNE1kEoJUtQllGUxPS6TuO4mCKfMjMDV0EeZfsB
         veEQ==
X-Gm-Message-State: ACrzQf0kZ6yESAi0ZpbsF5TZTKQKAum9nqnekNtjL6zr8eSZjPSJKojk
        YlPzMbQhiRjMNxwSFrL2scjuRACQr7Sl95aYHSHGvg==
X-Google-Smtp-Source: AMsMyM4+aMdJQjWdK6Bl2V7AF2U2ISz/+jTH4G1laiHIGjb6MmhprO5N+5dgenMdzD2lJAaO5X1nX2GgOvu0ZcHlA18=
X-Received: by 2002:a19:ad03:0:b0:4a0:56ab:7148 with SMTP id
 t3-20020a19ad03000000b004a056ab7148mr908064lfc.430.1664438452031; Thu, 29 Sep
 2022 01:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
In-Reply-To: <20220915165407.1776363-1-yu.c.chen@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Sep 2022 10:00:40 +0200
Message-ID: <CAKfTPtD3L4437htX__mCNBZJ+fv4MEdnNhCG2kBoQYhVESB_fg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sept 2022 at 18:54, Chen Yu <yu.c.chen@intel.com> wrote:
>
> [Background]
> At LPC 2022 Real-time and Scheduling Micro Conference we presented
> the cross CPU wakeup issue. This patch is a text version of the
> talk, and hopefully we can clarify the problem and appreciate for any
> feedback.
>
> [re-send due to the previous one did not reach LKML, sorry
>  for any inconvenience.]
>
> [Problem Statement]
> For a workload that is doing frequent context switches, the throughput
> scales well until the number of instances reaches a peak point. After
> that peak point, the throughput drops significantly if the number of
> instances continues to increase.
>
> The will-it-scale context_switch1 test case exposes the issue. The
> test platform has 112 CPUs per LLC domain. The will-it-scale launches
> 1, 8, 16 ... 112 instances respectively. Each instance is composed
> of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> pipe_read() and pipe_write(). No task is bound to any CPU.
> We found that, once the number of instances is higher than
> 56(112 tasks in total, every CPU has 1 task), the throughput
> drops accordingly if the instance number continues to increase:
>
>           ^
> throughput|
>           |                 X
>           |               X   X X
>           |             X         X X
>           |           X               X
>           |         X                   X
>           |       X
>           |     X
>           |   X
>           | X
>           |
>           +-----------------.------------------->
>                             56
>                                  number of instances
>
> [Symptom analysis]
> Both perf profile and lockstat have shown that, the bottleneck
> is the runqueue spinlock. Take perf profile for example:
>
> nr_instance          rq lock percentage
> 1                    1.22%
> 8                    1.17%
> 16                   1.20%
> 24                   1.22%
> 32                   1.46%
> 40                   1.61%
> 48                   1.63%
> 56                   1.65%
> --------------------------
> 64                   3.77%      |
> 72                   5.90%      | increase
> 80                   7.95%      |
> 88                   9.98%      v
> 96                   11.81%
> 104                  13.54%
> 112                  15.13%
>
> And the rq lock bottleneck is composed of two paths(perf profile):
>
> (path1):
> raw_spin_rq_lock_nested.constprop.0;
> try_to_wake_up;
> default_wake_function;
> autoremove_wake_function;
> __wake_up_common;
> __wake_up_common_lock;
> __wake_up_sync_key;
> pipe_write;
> new_sync_write;
> vfs_write;
> ksys_write;
> __x64_sys_write;
> do_syscall_64;
> entry_SYSCALL_64_after_hwframe;write
>
> (path2):
> raw_spin_rq_lock_nested.constprop.0;
> __sched_text_start;
> schedule_idle;
> do_idle;
> cpu_startup_entry;
> start_secondary;
> secondary_startup_64_no_verify
>
> The idle percentage is around 30% when there are 112 instances:
> %Cpu0  :  2.7 us, 66.7 sy,  0.0 ni, 30.7 id
>
> As a comparison, if we set CPU affinity to these workloads,
> which stops them from migrating among CPUs, the idle percentage
> drops to nearly 0%, and the throughput increases by about 300%.
> This indicates that there is room for optimization.
>
> A possible scenario to describe the lock contention:
> task A tries to wakeup task B on CPU1, then task A grabs the
> runqueue lock of CPU1. If CPU1 is about to quit idle, it needs
> to grab its own lock which has been taken by someone else. Then
> CPU1 takes more time to quit which hurts the performance.
>
> TTWU_QUEUE could mitigate the cross CPU runqueue lock contention.
> Since commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU
> on wakelist if wakee cpu is idle"), TTWU_QUEUE offloads the work from
> the waker and leverages the idle CPU to queue the wakee. However, a long
> idle duration is still observed. The idle task spends quite some time
> on sched_ttwu_pending() before it switches out. This long idle
> duration would mislead SIS_UTIL, then SIS_UTIL suggests the waker scan
> for more CPUs. The time spent searching for an idle CPU would make
> wakee waiting for more time, which in turn leads to more idle time.
> The NEWLY_IDLE balance fails to pull tasks to the idle CPU, which
> might be caused by no runnable wakee being found.
>
> [Proposal]
> If a system is busy, and if the workloads are doing frequent context
> switches, it might not be a good idea to spread the wakee on different
> CPUs. Instead, consider the task running time and enhance wake affine
> might be applicable.
>
> This idea has been suggested by Rik at LPC 2019 when discussing
> the latency nice. He asked the following question: if P1 is a small-time
> slice task on CPU, can we put the waking task P2 on the CPU and wait for
> P1 to release the CPU, without wasting time to search for an idle CPU?
> At LPC 2021 Vincent Guittot has proposed:
> 1. If the wakee is a long-running task, should we skip the short idle CPU?
> 2. If the wakee is a short-running task, can we put it onto a lightly loaded
>    local CPU?

When I said that, I had in mind to use the task utilization (util_avg
or util_est) which reflects the recent behavior of the task but not to
compute an average duration

>
> Current proposal is a variant of 2:
> If the target CPU is running a short-time slice task, and the wakee
> is also a short-time slice task, the target CPU could be chosen as the
> candidate when the system is busy.
>
> The definition of a short-time slice task is: The average running time
> of the task during each run is no more than sysctl_sched_min_granularity.
> If a task switches in and then voluntarily relinquishes the CPU
> quickly, it is regarded as a short-running task. Choosing
> sysctl_sched_min_granularity because it is the minimal slice if there
> are too many runnable tasks.
>
> Reuse the nr_idle_scan of SIS_UTIL to decide if the system is busy.
> If yes, then a compromised "idle" CPU might be acceptable.
>
> The reason is that, if the waker is a short running task, it might
> relinquish the CPU soon, the wakee has the chance to be scheduled.
> On the other hand, if the wakee is also a short-running task, the
> impact it brings to the target CPU is small. If the system is
> already busy, maybe we could lower the bar to find an idle CPU.
> The effect is, the wake affine is enhanced.
>
> [Benchmark results]
> The baseline is 6.0-rc4.
>
> The throughput of will-it-scale.context_switch1 has been increased by
> 331.13% with this patch applied.
>
> netperf
> =======
> case                    load            baseline(std%)  compare%( std%)
> TCP_RR                  28 threads       1.00 (  0.57)   +0.29 (  0.59)
> TCP_RR                  56 threads       1.00 (  0.49)   +0.43 (  0.43)
> TCP_RR                  84 threads       1.00 (  0.34)   +0.24 (  0.34)
> TCP_RR                  112 threads      1.00 (  0.26)   +1.57 (  0.20)
> TCP_RR                  140 threads      1.00 (  0.20)  +178.05 (  8.83)
> TCP_RR                  168 threads      1.00 ( 10.14)   +0.87 ( 10.03)
> TCP_RR                  196 threads      1.00 ( 13.51)   +0.90 ( 11.84)
> TCP_RR                  224 threads      1.00 (  7.12)   +0.66 (  8.28)
> UDP_RR                  28 threads       1.00 (  0.96)   -0.10 (  0.97)
> UDP_RR                  56 threads       1.00 ( 10.93)   +0.24 (  0.82)
> UDP_RR                  84 threads       1.00 (  8.99)   +0.40 (  0.71)
> UDP_RR                  112 threads      1.00 (  0.15)   +0.72 (  7.77)
> UDP_RR                  140 threads      1.00 ( 11.11)  +135.81 ( 13.86)
> UDP_RR                  168 threads      1.00 ( 12.58)  +147.63 ( 12.72)
> UDP_RR                  196 threads      1.00 ( 19.47)   -0.34 ( 16.14)
> UDP_RR                  224 threads      1.00 ( 12.88)   -0.35 ( 12.73)
>
> hackbench
> =========
> case                    load            baseline(std%)  compare%( std%)
> process-pipe            1 group          1.00 (  1.02)   +0.14 (  0.62)
> process-pipe            2 groups         1.00 (  0.73)   +0.29 (  0.51)
> process-pipe            4 groups         1.00 (  0.16)   +0.24 (  0.31)
> process-pipe            8 groups         1.00 (  0.06)  +11.56 (  0.11)
> process-sockets         1 group          1.00 (  1.59)   +0.06 (  0.77)
> process-sockets         2 groups         1.00 (  1.13)   -1.86 (  1.31)
> process-sockets         4 groups         1.00 (  0.14)   +1.76 (  0.29)
> process-sockets         8 groups         1.00 (  0.27)   +2.73 (  0.10)
> threads-pipe            1 group          1.00 (  0.43)   +0.83 (  2.20)
> threads-pipe            2 groups         1.00 (  0.52)   +1.03 (  0.55)
> threads-pipe            4 groups         1.00 (  0.44)   -0.08 (  0.31)
> threads-pipe            8 groups         1.00 (  0.04)  +11.86 (  0.05)
> threads-sockets         1 groups         1.00 (  1.89)   +3.51 (  0.57)
> threads-sockets         2 groups         1.00 (  0.04)   -1.12 (  0.69)
> threads-sockets         4 groups         1.00 (  0.14)   +1.77 (  0.18)
> threads-sockets         8 groups         1.00 (  0.03)   +2.75 (  0.03)
>
> tbench
> ======
> case                    load            baseline(std%)  compare%( std%)
> loopback                28 threads       1.00 (  0.08)   +0.51 (  0.25)
> loopback                56 threads       1.00 (  0.15)   -0.89 (  0.16)
> loopback                84 threads       1.00 (  0.03)   +0.35 (  0.07)
> loopback                112 threads      1.00 (  0.06)   +2.84 (  0.01)
> loopback                140 threads      1.00 (  0.07)   +0.69 (  0.11)
> loopback                168 threads      1.00 (  0.09)   +0.14 (  0.18)
> loopback                196 threads      1.00 (  0.04)   -0.18 (  0.20)
> loopback                224 threads      1.00 (  0.25)   -0.37 (  0.03)
>
> Other benchmarks are under testing.
>
> This patch is more about enhancing the wake affine, rather than improving
> the SIS efficiency, so Mel's SIS statistic patch was not deployed for now.
>
> [Limitations]
> When the number of CPUs suggested by SIS_UTIL is lower than 60% of the LLC
> CPUs, the LLC domain is regarded as relatively busy. However, the 60% is
> somewhat hacky, because it indicates that the util_avg% is around 50%,
> a half busy LLC. I don't have other lightweight/accurate method in mind to
> check if the LLC domain is busy or not.
>
> [Misc]
> At LPC we received useful suggestions. The first one is that we should look at
> the time from the task is woken up, to the time the task goes back to sleep.
> I assume this is aligned with what is proposed here - we consider the average
> running time, rather than the total running time. The second one is that we
> should consider the long-running task. And this is under investigation.
>
> Besides, Prateek has mentioned that the SIS_UTIL is unable to deal with
> burst workload.  Because there is a delay to reflect the instantaneous
> utilization and SIS_UTIL expects the workload to be stable. If the system
> is idle most of the time, but suddenly the workloads burst, the SIS_UTIL
> overscans. The current patch might mitigate this symptom somehow, as burst
> workload is usually regarded as a short-running task.
>
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 914096c5b1ae..7519ab5b911c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6020,6 +6020,19 @@ static int wake_wide(struct task_struct *p)
>         return 1;
>  }
>
> +/*
> + * If a task switches in and then voluntarily relinquishes the
> + * CPU quickly, it is regarded as a short running task.
> + * sysctl_sched_min_granularity is chosen as the threshold,
> + * as this value is the minimal slice if there are too many
> + * runnable tasks, see __sched_period().
> + */
> +static int is_short_task(struct task_struct *p)
> +{
> +       return (p->se.sum_exec_runtime <=
> +               (p->nvcsw * sysctl_sched_min_granularity));

you assume that the task behavior will never change during is whole life time

> +}
> +
>  /*
>   * The purpose of wake_affine() is to quickly determine on which CPU we can run
>   * soonest. For the purpose of speed we only consider the waking and previous
> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>         if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>                 return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>
> -       if (sync && cpu_rq(this_cpu)->nr_running == 1)
> +       if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
> +           is_short_task(cpu_curr(this_cpu)))
>                 return this_cpu;
>
>         if (available_idle_cpu(prev_cpu))
> @@ -6434,6 +6448,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                         /* overloaded LLC is unlikely to have idle cpu/core */
>                         if (nr == 1)
>                                 return -1;
> +
> +                       /*
> +                        * If nr is smaller than 60% of llc_weight, it
> +                        * indicates that the util_avg% is higher than 50%.
> +                        * This is calculated by SIS_UTIL in
> +                        * update_idle_cpu_scan(). The 50% util_avg indicates
> +                        * a half-busy LLC domain. System busier than this
> +                        * level could lower its bar to choose a compromised
> +                        * "idle" CPU. If the waker on target CPU is a short
> +                        * task and the wakee is also a short task, pick
> +                        * target directly.
> +                        */
> +                       if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
> +                           is_short_task(p) && is_short_task(cpu_curr(target)))
> +                               return target;
>                 }
>         }
>
> --
> 2.25.1
>
