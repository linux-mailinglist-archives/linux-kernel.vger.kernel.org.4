Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881E74E536
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGKDUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGKDUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:20:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13610BC;
        Mon, 10 Jul 2023 20:20:10 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R0Qyt26dzztR9l;
        Tue, 11 Jul 2023 11:17:10 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 11:20:07 +0800
Subject: Re: [PATCH 1/2] rcu: Delete a redundant check in
 rcu_check_gp_kthread_starvation()
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-2-thunder.leizhen@huawei.com>
 <f36c93ac-b735-4771-a4b5-4be80c431593@paulmck-laptop>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4c8e0ea4-9dee-7915-e2eb-206ba50b79f2@huawei.com>
Date:   Tue, 11 Jul 2023 11:20:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f36c93ac-b735-4771-a4b5-4be80c431593@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
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



On 2023/7/11 3:03, Paul E. McKenney wrote:
> On Wed, Jul 05, 2023 at 03:30:19PM +0800, Zhen Lei wrote:
>> The above condition "if (gpk)" already ensures that gp_kthread is created,
>> so the local variable 'cpu' cannot be negative here.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/rcu/tree_stall.h | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index b10b8349bb2a48b..dcfaa3d5db2cbc7 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -537,13 +537,11 @@ static void rcu_check_gp_kthread_starvation(void)
>>  			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
>>  			pr_err("RCU grace-period kthread stack dump:\n");
>>  			sched_show_task(gpk);
>> -			if (cpu >= 0) {
> 
> I am not quite this trusting of the relation between the relationship
> between the existence of the grace-period khread and its CPU number
> being in range.  Let's please start with something like this:
> 
> 			if (!WARN_ON_ONCE(cpu < 0)) {
> 
> Please note that this is not just me.  See for example the use of the
> cpumask_check() function, albeit the opposite concern.

git grep -wn "\->cpu" kernel/ include/
kernel/kthread.c:583:   to_kthread(p)->cpu = cpu;				//kthread_create_on_cpu()
kernel/sched/sched.h:2024:      WRITE_ONCE(task_thread_info(p)->cpu, cpu);	//__set_task_cpu()
include/linux/sched.h:2250:     return READ_ONCE(task_thread_info(p)->cpu);	//task_cpu()

git grep -wn "\.cpu" kernel/ include/						//There is no task related, the search result is omitted.

Therefore, there is only one path "set_task_cpu()-->__set_task_cpu()" that can dynamically
change the value of task_cpu(p). In fact, this guarantee has been made in set_task_cpu().
set_task_cpu
	WARN_ON_ONCE(!cpu_online(new_cpu));
	__set_task_cpu(p, new_cpu);

In addition, task_struct has member 'on_rq'. Therefore, when a task leaves the scheduling
queue, setting the member 'cpu' to an invalid value will be thankless.

Sorry, these two patches was posted too quickly, and I'm still regretting that I should have
attached this to the commit description these days.


> 
>> -				if (cpu_is_offline(cpu)) {
>> -					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
>> -				} else  {
>> -					pr_err("Stack dump where RCU GP kthread last ran:\n");
>> -					dump_cpu_task(cpu);
>> -				}
>> +			if (cpu_is_offline(cpu)) {
>> +				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
>> +			} else  {
>> +				pr_err("Stack dump where RCU GP kthread last ran:\n");
>> +				dump_cpu_task(cpu);
>>  			}
>>  			wake_up_process(gpk);
>>  		}
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
