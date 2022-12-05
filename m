Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86049642196
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiLECgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLECge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:36:34 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06076F599
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:36:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0VWMH9k6_1670207785;
Received: from 30.97.49.7(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VWMH9k6_1670207785)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 10:36:27 +0800
Message-ID: <a71a227a-5f1b-8ebc-bfde-0babf267b7d9@linux.alibaba.com>
Date:   Mon, 5 Dec 2022 10:36:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <cover.1669862147.git.yu.c.chen@intel.com>
 <0fefba11f59c083256eabff0fbb6c82b9d3bfdf9.1669862147.git.yu.c.chen@intel.com>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <0fefba11f59c083256eabff0fbb6c82b9d3bfdf9.1669862147.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen.

On 2022/12/1 16:44, Chen Yu wrote:
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
> It is found that, once the number of instances is higher than
> 56(112 tasks in total, every CPU has 1 task), the throughput
> drops accordingly if the instance number continues to increase:
> 
>            ^
> throughput|
>            |                 X
>            |               X   X X
>            |             X         X X
>            |           X               X
>            |         X                   X
>            |       X
>            |     X
>            |   X
>            | X
>            |
>            +-----------------.------------------->
>                              56
>                                   number of instances
> 
> [Symptom analysis]
> 
> The performance downgrading was caused by a high system idle
> percentage(around 20% ~ 30%). The CPUs waste a lot of time in
> idle and do nothing. As a comparison, if set CPU affinity to
> these workloads and stops them from migrating among CPUs,
> the idle percentage drops to nearly 0%, and the throughput
> increases by about 300%. This indicates room for optimization.
> 
> The reason for the high idle percentage is different before/after
> commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU
> on wakelist if wakee cpu is idle").
> 
> [Before the commit]
> The bottleneck is the runqueue spinlock.
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
> And top 2 rq lock hot paths:
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
> task A tries to wake up task B on CPU1, then task A grabs the
> runqueue lock of CPU1. If CPU1 is about to quit idle, it needs
> to grab its lock which has been taken by someone else. Then
> CPU1 takes more time to quit which hurts the performance.
> 
> [After the commit]
> The cause is the race condition between select_task_rq() and
> the task enqueue.
> 
> Suppose there are nr_cpus pairs of ping-pong scheduling
> tasks. For example, p0' and p0 are ping-pong scheduling,
> so do p1' <=> p1, and p2'<=> p2. None of these tasks are
> bound to any CPUs. The problem can be summarized as:
> more than 1 wakers are stacked on 1 CPU, which slows down
> waking up their wakees:
> 
> CPU0					CPU1				CPU2
> 
> p0'					p1' => idle			p2'
> 
> try_to_wake_up(p0)							try_to_wake_up(p2);
> CPU1 = select_task_rq(p0);						CPU1 = select_task_rq(p2);
> ttwu_queue(p0, CPU1);							ttwu_queue(p2, CPU1);
>    __ttwu_queue_wakelist(p0, CPU1); =>	ttwu_list->p0
> 					quiting cpuidle_idle_call()
> 
> 					ttwu_list->p2->p0	<=	  __ttwu_queue_wakelist(p2, CPU1);
> 
>      WRITE_ONCE(CPU1->ttwu_pending, 1);					    WRITE_ONCE(CPU1->ttwu_pending, 1);
> 
> p0' => idle
> 					sched_ttwu_pending()
> 					  enqueue_task(p2 and p0)
> 
> 					idle => p2
> 
> 					...
> 					p2 time slice expires
> 					...
> 									!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> 								<===	!!! p2 delays the wake up of p0' !!!
> 									!!! causes long idle on CPU0     !!!
> 					p2 => p0			!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> 					p0 wakes up p0'
> 
> idle => p0'
> 
> 
> 
> Since there are many waker/wakee pairs in the system, the chain reaction
> causes many CPUs to be victims. These idle CPUs wait for their waker to
> be scheduled.
> 
> Actually Tiancheng has mentioned above issue here[2].
> 

First I want to say that this issue (race condition between selecting idle cpu 
and enqueuing task) always exists before or after the commit f3dd3f674555. And I 
know this is a big issue so in [2] I only try to fix a small part of it. Of 
course I'm glad to see you trying solving this issue too :-)

There may be a bit wrong in your comment about the order. 
"WRITE_ONCE(CPU1->ttwu_pending, 1);" on CPU0 is earlier than CPU1 getting 
"ttwu_list->p0", right?

Thanks.
