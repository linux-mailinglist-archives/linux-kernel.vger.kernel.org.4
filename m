Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CE6BCA82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCPJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCPJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:14:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17B3136FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:14:30 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PchQ56JyKzrTDb;
        Thu, 16 Mar 2023 17:13:33 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 17:13:54 +0800
CC:     <yangyicong@hisilicon.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, <wangjie125@huawei.com>
Subject: Re: [PATCH] sched/fair: Don't balance migration disabled tasks
To:     Valentin Schneider <vschneid@redhat.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
References: <20230313065759.39698-1-yangyicong@huawei.com>
 <xhsmhilf2m3k4.mognet@vschneid.remote.csb>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <4968738b-940a-1207-0cea-3aea52c6e33e@huawei.com>
Date:   Thu, 16 Mar 2023 17:13:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <xhsmhilf2m3k4.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 2023/3/15 23:34, Valentin Schneider wrote:
> On 13/03/23 14:57, Yicong Yang wrote:
>>  kernel/sched/fair.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7a1b1f855b96..8fe767362d22 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8433,6 +8433,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>       if (kthread_is_per_cpu(p))
>>               return 0;
>>
>> +	/* Migration disabled tasks need to be kept on their running CPU. */
>> +	if (is_migration_disabled(p))
>> +		return 0;
>> +
>>       if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>>               int cpu;
> 
> That cpumask check should cover migration_disabled tasks, unless they
> haven't gone through migrate_disable_switch() yet
> (p->migration_disabled == 1, but the cpus_ptr hasn't been touched yet).
> 
> Now, if that's the case, the task has to be src_rq's current (since it
> hasn't switched out), which means can_migrate_task() should exit via:
> 
>         if (task_on_cpu(env->src_rq, p)) {
>                 schedstat_inc(p->stats.nr_failed_migrations_running);
>                 return 0;
>         }
> 
> and thus not try to detach_task(). With that in mind, I don't get how your
> splat can happen, nor how the change change can help (a remote task p could
> execute migrate_disable() concurrently with can_migrate_task(p)).
> 

I see, for migrate disabled tasks, if !p->on_cpu the migration can be avoid by
the cpus_ptr check and if p->on_cpu migration can be avoid by the task_on_cpu()
check. So this patch won't help.

> I'm a bit confused here, detach_tasks() happens entirely with src_rq
> rq_lock held, so there shouldn't be any surprises.
> 

Since it's a arm64 machine, could the WARN_ON_ONCE() test be false positive?
I mean the update of p->migration_disabled is not observed by the balance
CPU and trigger this warning incorrectly.

> Can you share any extra context? E.g. exact HEAD of your tree, maybe the
> migrate_disable task in question if you have that info.
> 

We met this on our internal version based on 6.1-rc4, the scheduler is not
patched. We also saw this in previous version like 6.0. This patch is applied
since 6.2 so we haven't seen this recently, but as you point out this patch doesn't
solve the problem. The questioned tasks are some systemd services(udevd, etc)
and I assume the migration disable is caused by seccomp:

seccomp()
	...
	bpf_prog_run_pin_on_cpu()
		migrate_disable()
		...
		migrate_enable()

Thanks,
Yicong
