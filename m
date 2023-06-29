Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06D741D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjF2B0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF2B0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:26:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037F10CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:26:15 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qs13N1ZGhzTlWJ;
        Thu, 29 Jun 2023 09:25:20 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 09:26:12 +0800
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>, <vdonnefort@google.com>,
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
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <a0c76a11-9c18-6473-b0be-fd5ffa864599@huawei.com>
Date:   Thu, 29 Jun 2023 09:26:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/6/28 0:46, Vincent Guittot wrote:
> On Mon, 26 Jun 2023 at 10:23, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>
>> Hi,
>>
>> Kindly ping~
>> Could you please take a look at this issue and the below temporary fix ?
>>
>> Thanks,
>> Xiongfeng
>>
>> On 2023/6/12 20:49, Xiongfeng Wang wrote:
>>>
>>>
>>> On 2023/6/9 22:55, Thomas Gleixner wrote:
>>>> On Fri, Jun 09 2023 at 19:24, Xiongfeng Wang wrote:
>>>>
>>>> Cc+ scheduler people, leave context intact
>>>>
>>>>> Hello,
>>>>>  When I do some low power tests, the following hung task is printed.
>>>>>
>>>>>   Call trace:
>>>>>    __switch_to+0xd4/0x160
>>>>>    __schedule+0x38c/0x8c4
>>>>>    __cond_resched+0x24/0x50
>>>>>    unmap_kernel_range_noflush+0x210/0x240
>>>>>    kretprobe_trampoline+0x0/0xc8
>>>>>    __vunmap+0x70/0x31c
>>>>>    __vfree+0x34/0x8c
>>>>>    vfree+0x40/0x58
>>>>>    free_vm_stack_cache+0x44/0x74
>>>>>    cpuhp_invoke_callback+0xc4/0x71c
>>>>>    _cpu_down+0x108/0x284
>>>>>    kretprobe_trampoline+0x0/0xc8
>>>>>    suspend_enter+0xd8/0x8ec
>>>>>    suspend_devices_and_enter+0x1f0/0x360
>>>>>    pm_suspend.part.1+0x428/0x53c
>>>>>    pm_suspend+0x3c/0xa0
>>>>>    devdrv_suspend_proc+0x148/0x248 [drv_devmng]
>>>>>    devdrv_manager_set_power_state+0x140/0x680 [drv_devmng]
>>>>>    devdrv_manager_ioctl+0xcc/0x210 [drv_devmng]
>>>>>    drv_ascend_intf_ioctl+0x84/0x248 [drv_davinci_intf]
>>>>>    __arm64_sys_ioctl+0xb4/0xf0
>>>>>    el0_svc_common.constprop.0+0x140/0x374
>>>>>    do_el0_svc+0x80/0xa0
>>>>>    el0_svc+0x1c/0x28
>>>>>    el0_sync_handler+0x90/0xf0
>>>>>    el0_sync+0x168/0x180
>>>>>
>>>>> After some analysis, I found it is caused by the following race condition.
>>>>>
>>>>> 1. A task running on CPU1 is throttled for cfs bandwidth. CPU1 starts the
>>>>> hrtimer cfs_bandwidth 'period_timer' and enqueue the hrtimer on CPU1's rbtree.
>>>>> 2. Then the task is migrated to CPU2 and starts to offline CPU1. CPU1 starts
>>>>> CPUHP AP steps, and then the hrtimer 'period_timer' expires and re-enqueued on CPU1.
>>>>> 3. CPU1 runs to take_cpu_down() and disable irq. After CPU1 finished CPUHP AP
>>>>> steps, CPU2 starts the rest CPUHP step.
>>>>> 4. When CPU2 runs to free_vm_stack_cache(), it is sched out in __vunmap()
>>>>> because it run out of CPU quota. start_cfs_bandwidth() does not restart the
>>>>> hrtimer because 'cfs_b->period_active' is set.
>>>>> 5. The task waits the hrtimer 'period_timer' to expire to wake itself up, but
>>>>> CPU1 has disabled irq and the hrtimer won't expire until it is migrated to CPU2
>>>>> in hrtimers_dead_cpu(). But the task is blocked and cannot proceed to
>>>>> hrtimers_dead_cpu() step. So the task hungs.
>>>>>
>>>>>     CPU1                                                     CPU2
>>>>> Task set cfs_quota
>>>>> start hrtimer cfs_bandwidth 'period_timer'
>>>>>                                             start to offline CPU1
>>>>> CPU1 start CPUHP AP step
>>>>> ...
>>>>> 'period_timer' expired and re-enqueued on CPU1
>>>>> ...
>>>>> disable irq in take_cpu_down()
>>>>> ...
>>>>>                                             CPU2 start the rest CPUHP steps
>>>>>                                             ...
>>>>>                                           sched out in free_vm_stack_cache()
>>>>>                                             wait for 'period_timer' expires
>>>>>
>>>>>
>>>>> Appreciate it a lot if anyone can give some suggestion on how fix this problem !
>>>>>
>>>>> Thanks,
>>>>> Xiongfeng
>>>> .
>>>>
>>>
>>> Test script:
>>> taskset -cp 1 $$
>>> mkdir /sys/fs/cgroup/cpu/test
>>> echo $$ > /sys/fs/cgroup/cpu/test/tasks
>>> echo 80000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>>> echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_period_us
>>> taskset -cp 2 $$
>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>
>>>
>>> Tests show that the following modification can solve the problem of above test
>>> scripts. But I am not sure if there exists some other issues.
>>>
>>> diff --cc kernel/sched/fair.c
>>> index d9d6519fae01,bd6624353608..000000000000
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@@ -5411,10 -5411,16 +5411,15 @@@ void start_cfs_bandwidth(struct cfs_ban
>>>   {
>>>         lockdep_assert_held(&cfs_b->lock);
>>>
>>> -       if (cfs_b->period_active)
>>> +       if (cfs_b->period_active) {
>>> +               struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
>>> +               int cpu = clock_base->cpu_base->cpu;
>>> +               if (!cpu_active(cpu) && cpu != smp_processor_id())
>>> +                       hrtimer_start_expires(&cfs_b->period_timer,
>>> HRTIMER_MODE_ABS_PINNED);
>>>                 return;
>>> +       }
> 
> I have been able to reproduce your problem and run your fix on top. I
> still wonder if there is a

Sorry, I forgot to provide the kernel modification to help reproduce the issue.
At first, the issue can only be reproduced on the product environment with
product stress testcase. After firguring out the reason, I add the following
modification. It make sure the process ran out cfs quota and can be sched out in
free_vm_stack_cache. Although the real schedule point is in __vunmap(), this can
also show the issue exists.

diff --git a/kernel/fork.c b/kernel/fork.c
index 0fb86b65ae60..3b2d83fb407a 100644
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

Thanks,
Xiongfeng

> Could we have a helper from hrtimer to get the cpu of the clock_base ?
> 
> 
>>>
>>>         cfs_b->period_active = 1;
>>>  -
>>>         hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>>         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>>>   }
>>>
>>> Thanks,
>>> Xiongfeng
>>>
>>> .
>>>
> .
> 
