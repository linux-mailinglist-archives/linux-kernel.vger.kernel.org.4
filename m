Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5182A73D487
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjFYV25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFYV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB320184
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8A460C36
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 21:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10584C433C0;
        Sun, 25 Jun 2023 21:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687728530;
        bh=BjAXt7lVRG7oSKjU8qT2iD9gl7lRkKASMvQIvQlSRMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nM86wVSMK0dos+KJHDfshDhbsBilDAd2mVAPA6ByHVTqe/U938sOIvU/WSyIEz4Pg
         o4XA0QhMz0JOSyZIHav2Md/GyHmh2Y59Hpwr1YdLDEKNzestqUEnJf0bDpOibMAS5X
         uUtSswc5k87KIHckjKPurOGzStQh48Ti71MIv7K2q4ACIKMqmjSJp7rk12RCHImws5
         1rYPrIICHkipW41L9XhYHlE7RgtskgVZfnIO7rNdwt/Sj0cvWpX6QeWjg1aBcgEsvV
         dVD6CjcycZLLB45pC2DT0qiy3ebSph3o0ZmoeOllUyCiyPPPad57jqpV4Hgy+tk7F/
         GiiMgeoQN1zbA==
Date:   Sun, 25 Jun 2023 23:28:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: introduce sched_core_idle_cpu()
Message-ID: <ZJixj2RJrp8A8POz@localhost.localdomain>
References: <1687631295-126383-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687631295-126383-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Jun 25, 2023 at 02:28:15AM +0800, Cruz Zhao a écrit :
> As core scheduling introduced, a new state of idle is defined as
> force idle, running idle task but nr_running greater than zero.
> 
> If a cpu is in force idle state, idle_cpu() will return zero. This
> result makes sense in certain scenarios, e.g., load balance. but
> this will cause error in other scenarios, e.g., tick_irq_exit()
> will not change ts->idle_active back to 1 because idle_cpu() returns
> 0 when force idle.
> 
> To solve this problem, we introduce sched_core_idle_cpu(), which
> returns 1 when force idle. We audit all users of idle_cpu(), and
> change idle_cpu() into sched_core_idle_cpu() in the following
> functions:
>   - showacpu()
>   - rcu_is_rcuc_kthread_starving()
>   - tick_irq_exit()
> 
> v1-->v2: replace idle_cpu() with sched_core_idle_cpu() in function
> showacpu() and rcu_is_rcuc_kthread_starving()
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  drivers/tty/sysrq.c     |  2 +-
>  include/linux/sched.h   |  2 ++
>  kernel/rcu/tree_stall.h |  2 +-
>  kernel/sched/core.c     | 13 +++++++++++++
>  kernel/softirq.c        |  2 +-
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index b6e70c5cfa17..8a6586800385 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -232,7 +232,7 @@ static void showacpu(void *dummy)
>  	unsigned long flags;
>  
>  	/* Idle CPUs have no interesting backtrace. */
> -	if (idle_cpu(smp_processor_id())) {
> +	if (sched_core_idle_cpu(smp_processor_id())) {
>  		pr_info("CPU%d: backtrace skipped as idling\n", smp_processor_id());

Actually perhaps an idle injection's backtrace is worth dumping. I guess
it might accidentally produce lockups and it's worth knowing the source then.

Though I don't have a strong opinion on that...

>  		return;
>  	}
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a..6169faf30ecd 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -418,7 +418,7 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
>  		return false;
>  
>  	cpu = task_cpu(rcuc);
> -	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> +	if (cpu_is_offline(cpu) || sched_core_idle_cpu(cpu))

An idle injection could possibly starve the RCU boost kthread, and then it's
worth knowing about it. I would suggest keeping idle_cpu() here.

>  		return false;
>  
>  	j = jiffies - READ_ONCE(rdp->rcuc_activity);
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..98b98991ce45 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -630,7 +630,7 @@ static inline void tick_irq_exit(void)
>  	int cpu = smp_processor_id();
>  
>  	/* Make sure that timer wheel updates are propagated */
> -	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> +	if ((sched_core_idle_cpu(cpu) && !need_resched()) ||  tick_nohz_full_cpu(cpu)) {

That one looks good.

Thanks!
