Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399C263B6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiK2BDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiK2BDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:03:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A433C27CD5;
        Mon, 28 Nov 2022 17:03:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C0561195;
        Tue, 29 Nov 2022 01:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F741C433B5;
        Tue, 29 Nov 2022 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669683792;
        bh=PPaCKThtXBv4RuxYsoVEKUj7Mw6K2389pRooeVtWdsc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lunUszSqnNwu7uaSOvLmx2XPdnMiyw4hyRcfdmIM/QVZpQg2Ht7DHDVPgyStrEMvo
         k8jRYpt4L3TDflGbbCu6R778zzBYwBDmH/fgJOAxEBbvJyoLd60KQ/0/QYQWIvjtXN
         o09TtLiHONmflp3oCYI4kIDYTcEAczOHLP/LmHMBFK2TJByVFhmGJJJck4UZ0KE7eX
         XeaYjk54mQS7+SVXG+c4U/3G7vo8aTZ+hVp1JxQY5lzsM9jIzTKUjadC15AMIAFQeA
         xXwwJv0DpmdKD2HGsNyd+zaqiPd/tusOKRQLOQrSL0Ghs0MTDK/1+u3qhZGZ7eeFrI
         ld+/FwkiM/YyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4828D5C0EBE; Mon, 28 Nov 2022 17:03:12 -0800 (PST)
Date:   Mon, 28 Nov 2022 17:03:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Message-ID: <20221129010312.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221128143428.1703744-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128143428.1703744-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
> RCU-tasks grace period, if __num_online_cpus == 1, will return
> directly, indicates the end of the rude RCU-task grace period.
> suppose the system has two cpus, consider the following scenario:
> 
> 	CPU0                                   CPU1 (going offline)
> 				          migration/1 task:
>                                       cpu_stopper_thread
>                                        -> take_cpu_down
>                                           -> _cpu_disable
> 			                   (dec __num_online_cpus)
>                                           ->cpuhp_invoke_callback
>                                                 preempt_disable
> 						access old_data0
>            task1
>  del old_data0                                  .....
>  synchronize_rcu_tasks_rude()
>  task1 schedule out
>  ....
>  task2 schedule in
>  rcu_tasks_rude_wait_gp()
>      ->__num_online_cpus == 1
>        ->return
>  ....
>  task1 schedule in
>  ->free old_data0
>                                                 preempt_enable
> 
> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
> the CPU1 has not finished offline, stop_machine task(migration/1)
> still running on CPU1, maybe still accessing 'old_data0', but the
> 'old_data0' has freed on CPU0.
> 
> This commit add cpus_read_lock/unlock() protection before accessing
> __num_online_cpus variables, to ensure that the CPU in the offline
> process has been completed offline.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

First, good eyes and good catch!!!

The purpose of that check for num_online_cpus() is not performance
on single-CPU systems, but rather correct operation during early boot.
So a simpler way to make that work is to check for RCU_SCHEDULER_RUNNING,
for example, as follows:

	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING &&
	    num_online_cpus() <= 1)
		return;	// Early boot fastpath for only one CPU.

This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNING
long before it is possible to offline CPUs.

Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eyes,
and it also unnecessarily does the schedule_work_on() the current CPU,
but the code calling synchronize_rcu_tasks_rude() is on high-overhead
code paths, so this overhead is down in the noise.

Until further notice, anyway.

So simplicity is much more important than performance in this code.
So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
unless I am missing something (always possible!).

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4a991311be9b..08e72c6462d8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  {
>  }
>  
> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> +
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> +	int cpu;
> +	struct work_struct *work;
> +
> +	cpus_read_lock();
>  	if (num_online_cpus() <= 1)
> -		return;	// Fastpath for only one CPU.
> +		goto end;// Fastpath for only one CPU.
>  
>  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
> -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +	for_each_online_cpu(cpu) {
> +		work = per_cpu_ptr(&rude_work, cpu);
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(&rude_work, cpu));
> +
> +end:
> +	cpus_read_unlock();
>  }
>  
>  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> -- 
> 2.25.1
> 
