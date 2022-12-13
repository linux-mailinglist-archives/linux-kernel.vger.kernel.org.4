Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADC64BB41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiLMRmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiLMRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:42:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97ECB13F25;
        Tue, 13 Dec 2022 09:42:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3B182F4;
        Tue, 13 Dec 2022 09:43:25 -0800 (PST)
Received: from [10.57.9.1] (unknown [10.57.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39A93F73B;
        Tue, 13 Dec 2022 09:42:42 -0800 (PST)
Message-ID: <19bd3f60-63ea-4ccc-b5a2-6507276c8f0d@arm.com>
Date:   Tue, 13 Dec 2022 17:42:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221212184317.sntxy3h6k44oz4mo@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

I thought I could help with this issue.

On 12/12/22 18:43, Qais Yousef wrote:
> On 12/09/22 17:47, Vincent Guittot wrote:
> 
> [...]
> 
>>>>>> This patch loops on all cpufreq policy in sched softirq, how can this
>>>>>> be sane ? and not only in eas mode but also in the default asymmetric
>>>>>
>>>>> Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
>>>>> in the wake up path in feec()?
>>>>
>>>> feec() should be considered as an exception not as the default rule.
>>>> Thing like above which loops for_each on external subsystem should be
>>>> prevented and the fact that feec loops all PDs doesn't means that we
>>>> can put that everywhere else
>>>
>>> Fair enough. But really understanding the root cause behind this limitation
>>> will be very helpful. I don't have the same appreciation of why this is
>>> a problem, and shedding more light will help me to think more about it in the
>>> future.
>>>
>>
>> Take the example of 1k cores with per cpu policy. Do you really think a
>> for_each_cpufreq_policy would be reasonable ?
> 
> Hmm I don't think such an HMP system makes sense to ever exist.
> 
> That system has to be a multi-socket system and I doubt inversion detection is
> something of value.
> 
> Point taken anyway. Let's find another way to do this.
> 

Another way might be to use the 'update' code path, which sets this
information source, for the thermal pressure. That code path isn't as
hot as this in the task scheduler. Furthermore, we would also
have time and handle properly CPU hotplug callbacks there.

So something like this, I have in mind:

------------------------------8<-----------------------------
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7d6e6657ffa..7f372a93e21b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -16,6 +16,7 @@
  #include <linux/sched/topology.h>
  #include <linux/cpuset.h>
  #include <linux/cpumask.h>
+#include <linux/mutex.h>
  #include <linux/init.h>
  #include <linux/rcupdate.h>
  #include <linux/sched.h>
@@ -153,6 +154,33 @@ void topology_set_freq_scale(const struct cpumask 
*cpus, unsigned long cur_freq,
  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
  EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);

+static struct cpumask highest_capacity_mask;

+static struct cpumask highest_capacity_mask;
+static unsigned int max_possible_capacity;
+static DEFINE_MUTEX(max_capacity_lock);
+
+static void max_capacity_update(const struct cpumask *cpus,
+                               unsigned long capacity)
+{
+       mutex_lock(&max_capacity_lock);
+
+       if (max_possible_capacity < capacity) {
+               max_possible_capacity = capacity;
+
+               cpumask_clear(&highest_capacity_mask);
+
+               cpumask_or(&highest_capacity_mask,
+                          &highest_capacity_mask, cpus);
+       }
+
+       mutex_unlock(&max_capacity_lock);
+}
+
+bool topology_test_max_cpu_capacity(unsigned int cpu)
+{
+       return cpumask_test_cpu(cpu, &highest_capacity_mask);
+}
+EXPORT_SYMBOL_GPL(topology_test_max_cpu_capacity);
+
  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
  {
         per_cpu(cpu_scale, cpu) = capacity;
@@ -203,6 +231,8 @@ void topology_update_thermal_pressure(const struct 
cpumask *cpus,

         for_each_cpu(cpu, cpus)
                 WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+
+       max_capacity_update(cpus, capacity);
  }
  EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);


--------------------------->8--------------------------------

We could use the RCU if there is a potential to read racy date
while the updater modifies the mask in the meantime. Mutex is to
serialize the thermal writers which might be kicked for two
policies at the same time.

If you like I can develop and test such code in the arch_topology.c

Regards,
Lukasz
