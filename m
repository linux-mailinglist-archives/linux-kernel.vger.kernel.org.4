Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9226CBEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjC1MJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjC1MJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:09:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E5B5270A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:09:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3612FC14;
        Tue, 28 Mar 2023 05:10:28 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B533F6C4;
        Tue, 28 Mar 2023 05:09:41 -0700 (PDT)
Message-ID: <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
Date:   Tue, 28 Mar 2023 14:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20230327053955.GA570404@ziqianlu-desk2>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230327053955.GA570404@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 07:39, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> 
>     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
>      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> 
> While cpus of the other node normally sees a lower cycle percent:
> 
>      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
>      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side.
> 
> The reason why only cpus of one node has bigger overhead is: task_group
> is allocated on demand from a slab and whichever cpu happens to do the
> allocation, the allocated tg will be located on that node and accessing
> to tg->load_avg will have a lower cost for cpus on the same node and
> a higer cost for cpus of the remote node.
> 
> Tim Chen told me that PeterZ once mentioned a way to solve a similar
> problem by making a counter per node so do the same for tg->load_avg.
> After this change, the worst number I saw during a 5 minutes run from
> both nodes are:
> 
>      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
>      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> 
> Another observation of this workload is: it has a lot of wakeup time
> task migrations and that is the reason why update_load_avg() and
> update_cfs_group() shows noticeable cost. Running this workload in N
> instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> task migrations on wake up time are greatly reduced and the overhead from
> the two above mentioned functions also dropped a lot. It's not clear to
> me why running in multiple instances can reduce task migrations on
> wakeup path yet.
> 
> Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

I'm so far not seeing this issue on my Arm64 server.

$ numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
44 45 46 47
node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67
68 69 70 71
node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
92 93 94 95
node distances:
node   0   1   2   3
  0:  10  12  20  22
  1:  12  10  22  24
  2:  20  22  10  12
  3:  22  24  12  10

sysbench --table-size=100000 --tables=24 --threads=96 ...
/usr/share/sysbench/oltp_read_write.lua run

perf report | grep kernel | head

9.12%  sysbench  [kernel.vmlinux]        [k] _raw_spin_unlock_irqrestore
5.26%  sysbench  [kernel.vmlinux]        [k] finish_task_switch
1.56%  sysbench  [kernel.vmlinux]        [k] __do_softirq
1.22%  sysbench  [kernel.vmlinux]        [k] arch_local_irq_restore
1.12%  sysbench  [kernel.vmlinux]        [k] __arch_copy_to_user
1.12%  sysbench  [kernel.vmlinux]        [k] el0_svc_common.constprop.1
0.95%  sysbench  [kernel.vmlinux]        [k] __fget_light
0.94%  sysbench  [kernel.vmlinux]        [k] rwsem_spin_on_owner
0.85%  sysbench  [kernel.vmlinux]        [k] tcp_ack
0.56%  sysbench  [kernel.vmlinux]        [k] do_sys_poll

Is your postgres/sysbench running in a cgroup with cpu controller
attached? Mine isn't.

Maybe I'm doing something else differently?

