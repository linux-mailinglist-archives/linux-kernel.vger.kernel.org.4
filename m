Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE363D783
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiK3OEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiK3OEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:04:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 757CF286FE;
        Wed, 30 Nov 2022 06:04:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03BC4D6E;
        Wed, 30 Nov 2022 06:04:48 -0800 (PST)
Received: from [10.57.6.100] (unknown [10.57.6.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 301163F73D;
        Wed, 30 Nov 2022 06:04:38 -0800 (PST)
Message-ID: <75bba88a-0516-a6a2-d4e6-8cedabadf413@arm.com>
Date:   Wed, 30 Nov 2022 14:04:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Wu <wusamuel@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110195732.1382314-1-wusamuel@google.com>
 <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
 <880b7332-562c-4934-4e92-493b112568c9@arm.com>
 <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
 <CAJZ5v0iNjPAAn0-uygpJe0ya_LW7pfF4C8OHd+8EMLg+Ws=02Q@mail.gmail.com>
 <97af1300-541d-a79c-404c-92886f10b220@arm.com>
 <CAKfTPtAPniqQyDzh=Yu8Z9R9+H2PzBKkHT0SJgHZiUOdNdw3Mg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtAPniqQyDzh=Yu8Z9R9+H2PzBKkHT0SJgHZiUOdNdw3Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 11/30/22 10:42, Vincent Guittot wrote:
> Hi All
> 
> Just for the log and because it took me a while to figure out the root
> cause of the problem: This patch also creates a regression for
> snapdragon845 based systems and probably on any QC chipsets that use a
> LUT to update the OPP table at boot. The behavior is the same as
> described by Sam with a staled value in sugov_policy.max field.

Thanks for sharing this info and apologies that you spent cycles
on it.

I have checked that whole setup code (capacity + cpufreq policy and
governor). It looks like to have a proper capacity of CPUs, we need
to wait till the last policy is created. It's due to the arch_topology.c
mechanism which is only triggered after all CPUs' got the policy.
Unfortunately, this leads to a chicken & egg situation for this
schedutil setup of max capacity.

I have experimented with this code, which triggers an update in
the schedutil, when all CPUs got the policy and sugov gov
(with trace_printk() to mach the output below)

-------------------------8<-----------------------------------------
diff --git a/kernel/sched/cpufreq_schedutil.c 
b/kernel/sched/cpufreq_schedutil.c
index 9161d1136d01..f1913a857218 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -59,6 +59,7 @@ struct sugov_cpu {
  };

  static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
+static cpumask_var_t cpus_to_visit;

  /************************ Governor internals ***********************/

@@ -783,6 +784,22 @@ static int sugov_start(struct cpufreq_policy *policy)

                 cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, 
uu);
         }
+
+       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
+
+       if (cpumask_empty(cpus_to_visit)) {
+               trace_printk("schedutil the visit cpu mask is empty now\n");
+               for_each_possible_cpu(cpu) {
+                       struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
+                       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+
+                       sg_policy->max = arch_scale_cpu_capacity(cpu);
+
+                       trace_printk("SCHEDUTIL: NEW  CPU%u 
cpu_capacity=%lu\n",
+                               cpu, sg_policy->max);
+               }
+       }
+
         return 0;
  }

@@ -800,6 +817,8 @@ static void sugov_stop(struct cpufreq_policy *policy)
                 irq_work_sync(&sg_policy->irq_work);
                 kthread_cancel_work_sync(&sg_policy->work);
         }
+
+       cpumask_or(cpus_to_visit, cpus_to_visit, policy->related_cpus);
  }

  static void sugov_limits(struct cpufreq_policy *policy)
@@ -829,6 +848,11 @@ struct cpufreq_governor schedutil_gov = {
  #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
  struct cpufreq_governor *cpufreq_default_governor(void)
  {
+       if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
+               return NULL;
+
+       cpumask_copy(cpus_to_visit, cpu_possible_mask);
+
         return &schedutil_gov;
  }
  #endif

---------------------------------->8---------------------------------


That simple approach fixes the issue. I have also tested it with
governor change a few times and setting back the schedutil.

-------------------------------------------
    kworker/u12:1-48      [004] .....     2.208847: sugov_start: 
schedutil the visit cpu mask is empty now
    kworker/u12:1-48      [004] .....     2.208854: sugov_start: 
SCHEDUTIL: NEW  CPU0 cpu_capacity=381
    kworker/u12:1-48      [004] .....     2.208857: sugov_start: 
SCHEDUTIL: NEW  CPU1 cpu_capacity=381
    kworker/u12:1-48      [004] .....     2.208860: sugov_start: 
SCHEDUTIL: NEW  CPU2 cpu_capacity=381
    kworker/u12:1-48      [004] .....     2.208862: sugov_start: 
SCHEDUTIL: NEW  CPU3 cpu_capacity=381
    kworker/u12:1-48      [004] .....     2.208864: sugov_start: 
SCHEDUTIL: NEW  CPU4 cpu_capacity=1024
    kworker/u12:1-48      [004] .....     2.208866: sugov_start: 
SCHEDUTIL: NEW  CPU5 cpu_capacity=1024
             bash-615     [005] .....    35.317113: sugov_start: 
schedutil the visit cpu mask is empty now
             bash-615     [005] .....    35.317120: sugov_start: 
SCHEDUTIL: NEW  CPU0 cpu_capacity=381
             bash-615     [005] .....    35.317123: sugov_start: 
SCHEDUTIL: NEW  CPU1 cpu_capacity=381
             bash-615     [005] .....    35.317125: sugov_start: 
SCHEDUTIL: NEW  CPU2 cpu_capacity=381
             bash-615     [005] .....    35.317127: sugov_start: 
SCHEDUTIL: NEW  CPU3 cpu_capacity=381
             bash-615     [005] .....    35.317129: sugov_start: 
SCHEDUTIL: NEW  CPU4 cpu_capacity=1024
             bash-615     [005] .....    35.317131: sugov_start: 
SCHEDUTIL: NEW  CPU5 cpu_capacity=1024
             bash-623     [003] .....    57.633328: sugov_start: 
schedutil the visit cpu mask is empty now
             bash-623     [003] .....    57.633336: sugov_start: 
SCHEDUTIL: NEW  CPU0 cpu_capacity=381
             bash-623     [003] .....    57.633339: sugov_start: 
SCHEDUTIL: NEW  CPU1 cpu_capacity=381
             bash-623     [003] .....    57.633340: sugov_start: 
SCHEDUTIL: NEW  CPU2 cpu_capacity=381
             bash-623     [003] .....    57.633342: sugov_start: 
SCHEDUTIL: NEW  CPU3 cpu_capacity=381
             bash-623     [003] .....    57.633343: sugov_start: 
SCHEDUTIL: NEW  CPU4 cpu_capacity=1024
             bash-623     [003] .....    57.633344: sugov_start: 
SCHEDUTIL: NEW  CPU5 cpu_capacity=1024
----------------------------------------------------

It should work.

Regards,
Lukasz
