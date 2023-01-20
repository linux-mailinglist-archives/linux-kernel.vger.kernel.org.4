Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCA675136
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjATJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:33:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F211E84
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:33:31 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nytv71skZzJs92;
        Fri, 20 Jan 2023 17:08:03 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 17:09:28 +0800
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Barry Song <21cnbao@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task is
 running during wake up
To:     Chen Yu <yu.c.chen@intel.com>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <5910589f-fe3e-5999-5821-7b2b8021e74b@huawei.com>
 <Y8lrnvLzGGJmlPor@chenyu5-mobl1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d3d04f60-e3d7-9abb-4cfa-57790b359dd9@huawei.com>
Date:   Fri, 20 Jan 2023 17:09:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Y8lrnvLzGGJmlPor@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 0:11, Chen Yu wrote:
> Hi Yicong,
> On 2023-01-17 at 10:53:25 +0800, Yicong Yang wrote:
>> Hi Chen Yu,
>>
>> On 2022/12/16 14:08, Chen Yu wrote:
>>> The main purpose of this change is to avoid too many cross CPU
>>> wake up when it is unnecessary. The frequent cross CPU wake up
>>> brings significant damage to some workloads, especially on high
>>> core count systems.
>>>
>>> This patch set inhibits the cross CPU wake-up by placing the wakee
>>> on waking CPU or previous CPU, if both the waker and wakee are
>>> short-duration tasks.
>>>
>>> The first patch is to introduce the definition of a short-duration
>>> task. The second patch leverages the first patch to choose a local
>>> or previous CPU for wakee.
>>>
>>
>> Tested with tbench and netperf locally and MySQL remotely. Unluckily
>> cannot reproduce the improvement and see some regression.
> Thank you for the test.
>> Detailed information below. The tests are done based on 6.2-rc1 on a 2x64 CPUs
>> Kunpeng 920 server with 4 nodes and no SMT, CONFIG_SCHED_CLUSTER
>> enabled.
>>
>> For tbench and netperf tested on single node and two nodes on one socket.
>>
> Does this platform have 2 sockets, each socket has 2 Numa nodes, each node
> is attached to 32 CPUs, and the benchmarks are bound to the first sockets?
> And may I know how many CPUs there are in one LLC? Is it also 32?

you're right, exactly. There're 32 CPUs sharing one LLC.

>> Further looked into 64 threads since it regress most and mainly looked on the
>> server(mysqld) side. In this case most loads will be on node 0 and partly
>> on node 1. With SIS_SHORT the utilization on node 0 keeps almost the same
>> but utilization on node 1 remains nearly half comparing to baseline. That
>> may partly answers why the performance decreases.
>>
> OK, I see. So it seems that the Numa sched domain load balance does not spread
> tasks fast enough while SIS_SHORT is waking task on the same node frequently.
> But I thought select_idle_sibling() would wake up the tasks
> on the same node(LLC) anyway, why SIS_SHORT inhibits the load balance more?

Wakeup will happen much more frequently than load balance in this case and I don't
think load balance can handle it in time. In the fast path of wakeup we care little
about the load. SIS_SHORT may aggravate it since we're likely to put 2 short tasks
on one single CPU.

>> mpstat 60s, non-idle%
>> 	vanilla	sis_short	
>> node 0	94.25	91.67	-2.73%
>> node 1	46.41	30.03	-35.29%
>>
>> Previously there's argument that sync wakeup from interrupts maybe incorrectly
> I see. Do you mean, wakeup from interrupt might cause tasks stacking on the same
> CPU, because the interrupt is delivered to the same CPU? I thought userspace
> irq load balance would spread the interrupt? Or do you mean others?

Nop. I'm using HiSilicon HNS3 network card which has 32 queues and 33 interrupts
spread evenly on 32 CPUs, not on one single CPU. I considering a case that the p1
on cpu0 and p2 on cpu32, interrupt happens on cpu0 and tries to wakeup p1, since
p1 and p2 are both short tasks and then p2 will likely to wake and wait on cpu0.
p1 is not the actual waker and has not finished yet and this will increase the wait
time and also load on cpu0. Previously we may wake on the LLC of cpu0 and try
to find an idle CPU, with SIS_SHORT we'll just wake on cpu0.

Does it make sense to allow the SIS_SHORT wakeup only from the task context? I'll
have a try on this.

Some previous patch arguing interrupt wakeup from Barry and Libo:
[1] https://lkml.org/lkml/2021/11/5/234
[2] https://lore.kernel.org/lkml/20220711224704.1672831-1-libo.chen@oracle.com/

>> and SIS_SHORT seems to consolidate that and tie more tasks on the interrupt node.
>>
>> SIS_SHORT will likely to make short tasks wakeup locally but seems to increase the
>> wait time in this case. schedstat for CPUs on node 0 shows:
>>
> Agree. 
>>                         vanilla               sis_short
>> time elapsed            60.201085s            60.200395s
>> [cpu Average, counts/sec]
>> #0 cpu zeros            0.0                   0.0
>> #1 sched_yied()         0.03                  0.12
>> #2 zeros                0.0                   0.0
>> #3 schedule()           409415.36             340304.86
>> #4 sched->idle()        125616.92             91078.52
>> #5 try_to_wake_up()     317404.25             280896.88
>> #6 try_to_wakeup(local) 115451.87             140567.68
>> #7 run time             26071494674.87        26164834556.84
>> #8 wait time            3861592891.75         7361228637.54 (+ 90.63%)
>> #9 timeslices,          283747.1              249182.34
>>
>> Since it's a 128 CPU machine the min_granularity is 3000000ns which means a short
>> task running within 375000ns. Most mysql worker threads' se.dur_avg is around
>> 110000ns and will be regarded as short tasks.
>>
>> To exclude the influence of Patch 1 (which we'll always record the dur_avg and related
>> informations), tested 64 threads case with SIS_SHORT enabled or not through debugfs
>> control and seems Patch 2 mainly dominate the results.
>>
>> 		NO_SIS_SHORT	SIS_SHORT	
>> TPS		17446.54	16464.83	-5.63%
>> QPS		279144.61	263437.21	-5.63%
>> avg lat		3.67		3.89		-5.99%
>> 95th lat	5.09		5.37		-5.50%
>>
>> Please let me know if you need more information.
>>
> Very useful information, I'm thinking of taking nr_llc into consideration to
> adjust the threshold of short task, so on system with smaller llc we do
> not inhibit the idle CPU scan too much.
> 

That sounds reasonable to me to link the SIS_SHORT threshold to CPU scale like
what min_granule does.

Thanks,
Yicong

> thanks,
> Chenyu
>> Thanks.
>>
>>> Changes since v3:
>>> 1. Honglei and Josh have concern that the threshold of short
>>>    task duration could be too long. Decreased the threshold from
>>>    sysctl_sched_min_granularity to (sysctl_sched_min_granularity / 8),
>>>    and the '8' comes from get_update_sysctl_factor().
>>> 2. Export p->se.dur_avg to /proc/{pid}/sched per Yicong's suggestion.
>>> 3. Move the calculation of average duration from put_prev_task_fair()
>>>    to dequeue_task_fair(). Because there is an issue in v3 that,
>>>    put_prev_task_fair() will not be invoked by pick_next_task_fair()
>>>    in fast path, thus the dur_avg could not be updated timely.
>>> 4. Fix the comment in PATCH 2/2, that "WRITE_ONCE(CPU1->ttwu_pending, 1);"
>>>    on CPU0 is earlier than CPU1 getting "ttwu_list->p0", per Tianchen.
>>> 5. Move the scan for CPU with short duration task from select_idle_cpu()
>>>    to select_idle_siblings(), because there is no CPU scan involved, per
>>>    Yicong.
>>>
>>> Changes since v2:
>>>
>>> 1. Peter suggested comparing the duration of waker and the cost to
>>>    scan for an idle CPU: If the cost is higher than the task duration,
>>>    do not waste time finding an idle CPU, choose the local or previous
>>>    CPU directly. A prototype was created based on this suggestion.
>>>    However, according to the test result, this prototype does not inhibit
>>>    the cross CPU wakeup and did not bring improvement. Because the cost
>>>    to find an idle CPU is small in the problematic scenario. The root
>>>    cause of the problem is a race condition between scanning for an idle
>>>    CPU and task enqueue(please refer to the commit log in PATCH 2/2).
>>>    So v3 does not change the core logic of v2, with some refinement based
>>>    on Peter's suggestion.
>>>
>>> 2. Simplify the logic to record the task duration per Peter and Abel's suggestion.
>>>
>>> This change brings overall improvement on some microbenchmarks, both on
>>> Intel and AMD platforms.
>>>
>>> v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
>>> v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
>>> v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/
>>>
>>> Chen Yu (2):
>>>   sched/fair: Introduce short duration task check
>>>   sched/fair: Choose the CPU where short task is running during wake up
>>>
>>>  include/linux/sched.h   |  3 +++
>>>  kernel/sched/core.c     |  2 ++
>>>  kernel/sched/debug.c    |  1 +
>>>  kernel/sched/fair.c     | 32 ++++++++++++++++++++++++++++++++
>>>  kernel/sched/features.h |  1 +
>>>  5 files changed, 39 insertions(+)
>>>
> 
> .
> 
