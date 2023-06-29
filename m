Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4398741DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF2BmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjF2BmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:42:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0F26B6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:42:01 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qs1Pb1pk1zTkxm;
        Thu, 29 Jun 2023 09:41:07 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 09:41:59 +0800
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     <vschneid@redhat.com>, Phil Auld <pauld@redhat.com>,
        <vdonnefort@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
 <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <875y774wvp.ffs@tglx>
 <CAKfTPtAzTy4KPrBNRA4cMeTonxn5EKLEAg0b9iH5ecJkAMEStw@mail.gmail.com>
 <87pm5f2qm2.ffs@tglx>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <155adb21-be6e-533c-02f8-600a1e9138f8@huawei.com>
Date:   Thu, 29 Jun 2023 09:41:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87pm5f2qm2.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/29 6:01, Thomas Gleixner wrote:
> On Wed, Jun 28 2023 at 14:35, Vincent Guittot wrote:
>> On Wed, 28 Jun 2023 at 14:03, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> No, because this is fundamentally wrong.
>>>
>>> If the CPU is on the way out, then the scheduler hotplug machinery
>>> has to handle the period timer so that the problem Xiongfeng analyzed
>>> does not happen in the first place.
>>
>> But the hrtimer was enqueued before it starts to offline the cpu
> 
> It does not really matter when it was enqueued. The important point is
> that it was enqueued on that outgoing CPU for whatever reason.
> 
>> Then, hrtimers_dead_cpu should take care of migrating the hrtimer out
>> of the outgoing cpu but :
>> - it must run on another target cpu to migrate the hrtimer.
>> - it runs in the context of the caller which can be throttled.
> 
> Sure. I completely understand the problem. The hrtimer hotplug callback
> does not run because the task is stuck and waits for the timer to
> expire. Circular dependency.
> 
>>> sched_cpu_wait_empty() would be the obvious place to cleanup armed CFS
>>> timers, but let me look into whether we can migrate hrtimers early in
>>> general.
>>
>> but for that we must check if the timer is enqueued on the outgoing
>> cpu and we then need to choose a target cpu.
> 
> You're right. I somehow assumed that cfs knows where it queued stuff,
> but obviously it does not.
> 
> I think we can avoid all that by simply taking that user space task out
> of the picture completely, which avoids debating whether there are other
> possible weird conditions to consider alltogether.
> 
> Something like the untested below should just work.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1490,6 +1490,13 @@ static int cpu_down(unsigned int cpu, en
>  	return err;
>  }
>  
> +static long __cpu_device_down(void *arg)
> +{
> +	struct device *dev = arg;
> +
> +	return cpu_down(dev->id, CPUHP_OFFLINE);
> +}
> +
>  /**
>   * cpu_device_down - Bring down a cpu device
>   * @dev: Pointer to the cpu device to offline
> @@ -1502,7 +1509,12 @@ static int cpu_down(unsigned int cpu, en
>   */
>  int cpu_device_down(struct device *dev)
>  {
> -	return cpu_down(dev->id, CPUHP_OFFLINE);
> +	unsigned int cpu = cpumask_any_but(cpu_online_mask, dev->id);
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EBUSY;
> +
> +	return work_on_cpu(cpu, __cpu_device_down, dev);
>  }
>  
>  int remove_cpu(unsigned int cpu)
> .
> 

Test with the following kernel modification which helps reproduce the issue. The
hang task does not happen any more. Thanks a lot.

Thanks,
Xiongfeng

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -110,6 +110,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>

+#include <linux/delay.h>
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -199,6 +201,9 @@ static int free_vm_stack_cache(unsigned int cpu)
        struct vm_struct **cached_vm_stacks = per_cpu_ptr(cached_stacks, cpu);
        int i;

+       mdelay(2000);
+       cond_resched();
+
        for (i = 0; i < NR_CACHED_STACKS; i++) {
                struct vm_struct *vm_stack = cached_vm_stacks[i];

