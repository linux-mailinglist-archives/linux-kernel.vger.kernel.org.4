Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41F704C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjEPLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjEPLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:13:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81961A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QLD4d0XttzsSDh;
        Tue, 16 May 2023 19:08:33 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 19:10:31 +0800
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
 <4968738b-940a-1207-0cea-3aea52c6e33e@huawei.com>
 <xhsmh7cvgnbdf.mognet@vschneid.remote.csb>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <12a7c650-bc44-bd5a-1506-67260ab8e21e@huawei.com>
Date:   Tue, 16 May 2023 19:10:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <xhsmh7cvgnbdf.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 2023/3/16 20:12, Valentin Schneider wrote:
> On 16/03/23 17:13, Yicong Yang wrote:
>> Hi Valentin,
>>
>> On 2023/3/15 23:34, Valentin Schneider wrote:
>>> That cpumask check should cover migration_disabled tasks, unless they
>>> haven't gone through migrate_disable_switch() yet
>>> (p->migration_disabled == 1, but the cpus_ptr hasn't been touched yet).
>>>
>>> Now, if that's the case, the task has to be src_rq's current (since it
>>> hasn't switched out), which means can_migrate_task() should exit via:
>>>
>>>         if (task_on_cpu(env->src_rq, p)) {
>>>                 schedstat_inc(p->stats.nr_failed_migrations_running);
>>>                 return 0;
>>>         }
>>>
>>> and thus not try to detach_task(). With that in mind, I don't get how your
>>> splat can happen, nor how the change change can help (a remote task p could
>>> execute migrate_disable() concurrently with can_migrate_task(p)).
>>>
>>
>> I see, for migrate disabled tasks, if !p->on_cpu the migration can be avoid by
>> the cpus_ptr check and if p->on_cpu migration can be avoid by the task_on_cpu()
>> check. So this patch won't help.
>>
> 
> Right.
> 
>>> I'm a bit confused here, detach_tasks() happens entirely with src_rq
>>> rq_lock held, so there shouldn't be any surprises.
>>>
>>
>> Since it's a arm64 machine, could the WARN_ON_ONCE() test be false positive?
>> I mean the update of p->migration_disabled is not observed by the balance
>> CPU and trigger this warning incorrectly.
>>
> 
> Since the balance CPU holds the src_rq's rq_lock for the entire duration of
> detach_tasks(), the actual value of p->migration_disabled shouldn't matter.
> 
> Either p has been scheduled out while being migration_disabled, in which
> case its ->cpus_ptr has been updated, or p is still running, in which case
> can_migrate_task() should return false (p->on_cpu). But from your report,
> we're somehow not seeing one of these.
> 
>>> Can you share any extra context? E.g. exact HEAD of your tree, maybe the
>>> migrate_disable task in question if you have that info.
>>>
>>
>> We met this on our internal version based on 6.1-rc4, the scheduler is not
>> patched. We also saw this in previous version like 6.0. This patch is applied
>> since 6.2 so we haven't seen this recently, but as you point out this patch doesn't
>> solve the problem.
> 
> Could you try to reproduce this on an unpatched upstream kernel?
> 

Sorry for the late reply. Yes it can be reproduced on the upstream kernel (tested below on
6.4-rc1). Since it happens occasionally with the normal setup, I wrote a test kthread
with migration enable/disable periodically:

static int workload_func(void *data)
{
	cpumask_var_t cpumask;
	int i;

	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
		return -ENOMEM;

	for (i = 0; i < 8; i++)
		cpumask_set_cpu(i, cpumask);

	set_cpus_allowed_ptr(current, cpumask);
	free_cpumask_var(cpumask);	

	while (!kthread_should_stop()) {
		migrate_disable();
		mdelay(1000);
		cond_resched();
		migrate_enable();
		mdelay(1000);
	}

	return -1;
}

Launching this and bind another workload to the same CPU it's currently running like
`taskset -c $workload_cpu stress-ng -c 1` will trigger the issue. In fact, the problem
is not because of the migration disable mechanism which works well, but because the
balancing policy after found all the tasks on the source CPU are pinned. With below
debug print added:

@@ -8527,6 +8527,20 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
        if (kthread_is_per_cpu(p))
                return 0;

+       if (is_migration_disabled(p)) {
+               if (!p->on_cpu && cpumask_test_cpu(env->dst_cpu, p->cpus_ptr))
+                       pr_err("dst_cpu %d on_cpu %d cpus_ptr %*pbl cpus_mask %*pbl",
+                               env->dst_cpu, p->on_cpu, cpumask_pr_args(p->cpus_ptr),
+                               cpumask_pr_args(&p->cpus_mask));
+       }
+
        if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
                int cpu;

I got below output:

[  686.135619] dst_cpu 1 on_cpu 0 cpus_ptr 1 cpus_mask 0-7
[  686.148809] ------------[ cut here ]------------
[  686.169505] WARNING: CPU: 64 PID: 0 at kernel/sched/core.c:3210 set_task_cpu+0x190/0x250
[  686.186537] Modules linked in: kthread_workload(O) bluetooth rfkill xt_CHECKSUM iptable_mangle xt_conntrack ipt_REJECT nf_reject_ipv4 ip6table_filter ip6_tables iptable_filter ib_isert iscsi_target_mod ib_ipoib ib_umad rpcrdma ib_iser libiscsi scsi_transport_iscsi crct10dif_ce hns_roce_hw_v2 arm_spe_pmu sbsa_gwdt sm4_generic sm4 xts ecb hisi_hpre hisi_uncore_l3c_pmu hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_trng_v2 rng_core hisi_uncore_pmu spi_dw_mmio hisi_zip hisi_sec2 hisi_qm uacce hclge hns3 hnae3 hisi_sas_v3_hw hisi_sas_main libsas [last unloaded: kthread_workload(O)]
[  686.293937] CPU: 64 PID: 0 Comm: swapper/64 Tainted: G           O       6.4.0-rc1-migration-race-debug+ #24
[  686.314616] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B211.01 11/10/2021
[  686.333285] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  686.347930] pc : set_task_cpu+0x190/0x250
[...]

It shows that we're going to balance the task to its current CPU (CPU 1) rather than
the balancer CPU (CPU 64). It's because we're going to find a new dst_cpu if the task
on the src_cpu is pinned, and the new_dst_cpu happens to be the task's current CPU.

So the right way to solve this maybe avoid selecting the src_cpu as the new_dst_cpu and
below patch works to solve this issue.

@@ -8550,7 +8564,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)

                /* Prevent to re-select dst_cpu via env's CPUs: */
                for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
-                       if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
+                       if (cpumask_test_cpu(cpu, p->cpus_ptr) && cpu != env->src_cpu) {
                                env->flags |= LBF_DST_PINNED;
                                env->new_dst_cpu = cpu;
                                break;

Thanks,
Yicong

