Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA66FEA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEKD7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 23:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKD7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 23:59:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007A422A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:59:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64395e2a715so8070770b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683777577; x=1686369577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZPhmRB/QgilF6BtqR3fnoFYaesNocwH+Pw7ipTZvL8=;
        b=PEnY8AIPKSLfI8DRkcj82vYStjUu/sIqU1ObMx+DhDWdnQQQx7PJfr0wIZfCEpMRtO
         Il/hpp5X6LmKIqLz/H6T3ZfavygAwtNT7i4HXVAC0saeTNiYVlMRYpdkrB57Og0amVFl
         ba+dmauNB5iQKEfZIFibHNYhnJ3dve9OC6ePpTErj+HDq3Sc8xFKy6L7gHC/cBT99Qap
         M0fncR3cCWc+m49cAT5RaWWCPqrDHNuF/7hazDyH3l/8q3zH1aSX/MlMjapPsFz4rf8H
         EWjGfpxpZhGq9Gf5KPcflLgNIVyGddG/J4js1aPBdwt/hDTnluIWnYi6YiG0Hb6jtJ/r
         kIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683777577; x=1686369577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aZPhmRB/QgilF6BtqR3fnoFYaesNocwH+Pw7ipTZvL8=;
        b=i/9SiM+2okn89HaKZLjUaWY9JVBMU4sWvBfM7dh+SYfRBOKkXbLXXe1BIQ4OcmIqzl
         XkZoKO3rOiSXGt/dfTC364DrtbMNQiyXv/yJgrUuWPYuzVLSOjLew/TRug0eDqBS/Fnl
         fLfsqTs8+OCgxU2t3blaw8Nek5r7hNZG1Hkb6YtibP6/zgmbC1MQieIJ6myqK/uHMcB0
         oa8Q8l+ZqzOqs4h+SaXGuVQxTUHogkbhapUZK3OyTUxOggo0qSBhX6rux7wEk+x+YbPc
         50M2O4UmNVPF/KqJUBCshjTLEE8y2Yf/LQ7ADIB4YGljj7NLu2D+wBQ2uWdB+/LWuK62
         1Waw==
X-Gm-Message-State: AC+VfDxzIT29QJw4wZoQ9L45eQCbV1C6vjtjen34uZSzcurzobz4kfMW
        t6qNetAjIWx3Hd/BKQmY14VTow==
X-Google-Smtp-Source: ACHHUZ5IQgN26p1CbcF0mOANY+E3MYNFSBScTyewo6fORIbo1MJcMqC4Kj2wJFM1U3neurPIMmGMAQ==
X-Received: by 2002:a05:6a00:2e94:b0:641:3fa1:bf7f with SMTP id fd20-20020a056a002e9400b006413fa1bf7fmr29348615pfb.20.1683777576690;
        Wed, 10 May 2023 20:59:36 -0700 (PDT)
Received: from [10.86.122.44] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79213000000b00640df8c536csm4441809pfo.12.2023.05.10.20.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 20:59:36 -0700 (PDT)
Message-ID: <ff67121b-1799-f0b8-34cc-97364630253a@bytedance.com>
Date:   Thu, 11 May 2023 11:59:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v2 1/2] sched/core: Fixed missing rq clock
 update before calling set_rq_offline()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230510083450.62334-1-jiahao.os@bytedance.com>
 <20230510083450.62334-2-jiahao.os@bytedance.com>
 <20230510144724.GN4253@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230510144724.GN4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/10 Peter Zijlstra wrote:
> On Wed, May 10, 2023 at 04:34:49PM +0800, Hao Jia wrote:
>> This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled:
> 
> I'm failing to see the relevance to CPU_FREQ...

Sorry to confuse you, here is a more detailed function call graph.


rq_offline_rt()
     __disable_runtime()
        sched_rt_rq_enqueue()
           enqueue_top_rt_rq()
              cpufreq_update_util() <-- depends on CONFIG_CPU_FREQ
                 data->func(data, *rq_clock(rq)*, flags);
                    intel_pstate_update_util() <-- on my machine, I have 
set cpufreq to powersave

Perhaps we need to add the above information to the commit Changelog?


> 
>> ------------[ cut here ]------------
>> rq->clock_update_flags < RQCF_ACT_SKIP
>> WARNING: CPU: 24 PID: 754 at kernel/sched/sched.h:1496
>> enqueue_top_rt_rq+0x139/0x160
>> Call Trace:
>>   <TASK>
>>   ? intel_pstate_update_util+0x3b0/0x3b0
> 
> AFAICT this is __disable_runtime() re-queueing throttled RT tasks
> 
> Your unwind is dodgy, what CONFIG_UNWINDER do you have?

CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set



I try to use another configuration:

# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y

The log is as follows

[  217.332774] ------------[ cut here ]------------
[  217.332780] rq->clock_update_flags < RQCF_ACT_SKIP
[  217.332788] WARNING: CPU: 0 PID: 817 at kernel/sched/sched.h:1496 
enqueue_top_rt_rq+0x135/0x150

[  217.333049] CPU: 0 PID: 817 Comm: kworker/53:1 Kdump: loaded Tainted: 
G S          E      6.4.0-rc1.bm.1-amd64+ #73
[  217.333056] Hardware name: FOXCONN R-5111/GROOT, BIOS IC1B123F 07/16/2020
[  217.333060] Workqueue: events cpuset_hotplug_workfn
[  217.333070] RIP: 0010:enqueue_top_rt_rq+0x135/0x150
[  217.333078] Code: 98 00 00 00 01 00 00 00 eb 83 80 3d d0 b5 69 01 00 
0f 85 3f ff ff ff 48 c7 c7 e0 39 2f 9c c6 05 bc b5 69 01 01 e8 0b 7f fa 
ff <0f> 0b e9 25 ff ff ff e8 7f 74 07 00 44 8b a3 30 08 00 00 e9 54 ff
[  217.333084] RSP: 0018:ffffa7c15b94fac0 EFLAGS: 00010086
[  217.333090] RAX: 0000000000000000 RBX: ffff93ad006ef580 RCX: 
0000000000000003
[  217.333094] RDX: 0000000000000003 RSI: ffffffff9c32eab9 RDI: 
00000000ffffffff
[  217.333097] RBP: ffffa7c15b94fad8 R08: 0000000000000000 R09: 
c0000000ffffbfff
[  217.333101] R10: ffffa7c15b94f9b8 R11: ffffa7c15b94f908 R12: 
ffff934f52166608
[  217.333104] R13: ffffffff9baff3c0 R14: 0000000000000246 R15: 
ffff93ad006ef340
[  217.333107] FS:  0000000000000000(0000) GS:ffff93ad00600000(0000) 
knlGS:0000000000000000
[  217.333112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  217.333115] CR2: 00007f7d2ffa6ba0 CR3: 000000604df16003 CR4: 
00000000007706f0
[  217.333119] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  217.333122] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  217.333125] PKRU: 55555554
[  217.333128] Call Trace:
[  217.333131]  <TASK>
[  217.333136]  rq_offline_rt+0x1b8/0x250
[  217.333146]  set_rq_offline.part.121+0x2d/0x70
[  217.333159]  set_rq_offline+0x18/0x20
[  217.333165]  rq_attach_root+0xcf/0xe0
[  217.333176]  cpu_attach_domain+0x3cb/0x7d0
[  217.333186]  partition_sched_domains_locked+0x2a4/0x3b0
[  217.333197]  rebuild_sched_domains_locked+0x47e/0x800
[  217.333202]  ? preempt_schedule_common+0x37/0x90
[  217.333213]  rebuild_sched_domains+0x1f/0x40
[  217.333218]  cpuset_hotplug_workfn+0x2df/0xd10
[  217.333225]  ? debug_smp_processor_id+0x17/0x20
[  217.333233]  ? _raw_spin_unlock+0x19/0x30
[  217.333242]  ? raw_spin_rq_unlock+0x10/0x30
[  217.333247]  ? finish_task_switch+0x98/0x2f0
[  217.333251]  ? __switch_to+0x12b/0x440
[  217.333261]  ? __switch_to_asm+0x34/0x60
[  217.333270]  ? __schedule+0x600/0x14e0
[  217.333276]  ? __queue_delayed_work+0x8b/0x90
[  217.333285]  ? queue_delayed_work_on+0x3a/0x50
[  217.333291]  process_one_work+0x1c8/0x3e0
[  217.333298]  worker_thread+0x4d/0x390
[  217.333305]  ? rescuer_thread+0x350/0x350
[  217.333311]  kthread+0xfe/0x130
[  217.333316]  ? kthread_complete_and_exit+0x20/0x20
[  217.333321]  ret_from_fork+0x1f/0x30
[  217.333331]  </TASK>
[  217.333333] ---[ end trace 0000000000000000 ]---

Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
CPUs in total.


> 
>>   rq_offline_rt+0x1b7/0x250
>>   set_rq_offline.part.120+0x28/0x60
>>   rq_attach_root+0xc4/0xd0
>>   cpu_attach_domain+0x3dc/0x7f0
>>   ? __schedule+0x65e/0x1310
>>   partition_sched_domains_locked+0x2a5/0x3c0
>>   rebuild_sched_domains_locked+0x477/0x830
>>   ? percpu_rwsem_wait+0x140/0x140
>>   rebuild_sched_domains+0x1b/0x30
>>   cpuset_hotplug_workfn+0x2ca/0xc90
>>   ? balance_push+0x56/0x120
>>   ? _raw_spin_unlock+0x15/0x30
>>   ? finish_task_switch+0x98/0x2f0
>>   ? __switch_to+0x116/0x410
>>   ? __schedule+0x65e/0x1310 ? internal_add_timer+0x42/0x60
>>   ? _raw_spin_unlock_irqrestore+0x23/0x40
>>   ? add_timer_on+0xd5/0x130
>>   process_one_work+0x1bc/0x3d0
>>   worker_thread+0x4c/0x380
>>   ? preempt_count_add+0x56/0xa0
>>   ? rescuer_thread+0x310/0x310
>>   kthread+0xe6/0x110
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>
>> Before calling set_rq_offline() we need to update the rq clock to avoid
>> using the old rq clock, and use rq_lock_irqsave()/rq_unlock_irqrestore()
>> to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore() to
>> ensure that rq->clock_update_flags are cleared before updating the rq
>> clock.
>>
>> Steps to reproduce:
>> 1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
>> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>> 3. cpupower -c all frequency-set -g powersave
>> 4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
>>     system with n CPUs)
>> 5. Offline cpu one by one until the warninng is triggered
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
>> ---
>>   kernel/sched/topology.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 6682535e37c8..b89497696880 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -487,15 +487,17 @@ static void free_rootdomain(struct rcu_head *rcu)
>>   void rq_attach_root(struct rq *rq, struct root_domain *rd)
>>   {
>>   	struct root_domain *old_rd = NULL;
>> -	unsigned long flags;
>> +	struct rq_flags rf;
>>   
>> -	raw_spin_rq_lock_irqsave(rq, flags);
>> +	rq_lock_irqsave(rq, &rf);
>>   
>>   	if (rq->rd) {
>>   		old_rd = rq->rd;
>>   
>> -		if (cpumask_test_cpu(rq->cpu, old_rd->online))
>> +		if (cpumask_test_cpu(rq->cpu, old_rd->online)) {
>> +			update_rq_clock(rq);
>>   			set_rq_offline(rq);
>> +		}
>>   
>>   		cpumask_clear_cpu(rq->cpu, old_rd->span);
>>   
>> @@ -515,7 +517,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>>   	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
>>   		set_rq_online(rq);
>>   
>> -	raw_spin_rq_unlock_irqrestore(rq, flags);
>> +	rq_unlock_irqrestore(rq, &rf);
>>   
>>   	if (old_rd)
>>   		call_rcu(&old_rd->rcu, free_rootdomain);
> 
> The patch itself is good though; just the Changelog has me
> confused.

Sorry for not explaining clearly and confusing you.

Thanks,
Hao
