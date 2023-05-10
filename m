Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD96FE058
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbjEJOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjEJOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:33:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE57DE
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2fv+XSaz2klf5yi1nMJnm9s4azEAUlzVE9S/K7jdU4s=; b=qxm/PKZYn1ZNCxawWzA0ewtB7J
        sedgrnoLcdTW5qldlxY4W0YpRfYrXaJFYZayXqPMtlrd94rCiomseTG3y2hQrf+vrPH2fz+lY+DIB
        IR5ssm3o2c2W4drIB8BwOwu1Nd+bSA62waLUqM3WUhCPNXV/0pUUlN/OUkY1kfI3axXrUuY3QrZgy
        4+3nfQaWs6bE3+jh53no8luZxzKr/OxRIlqgNdS2Q3tQpioqnTZ/sgQb2l9ovRS3kR2Kduufo7j32
        roKRLztG+rFH0slEJWS1Mif0IpDUReKQ7tIJv/eY9kHYEfIPKADNwRuy1OvgAIHXp3lJx0+FSYaqB
        Ni/Rw5Ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwks2-00GMHz-F6; Wed, 10 May 2023 14:32:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3B6B3000D5;
        Wed, 10 May 2023 16:32:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A7DC202EECBF; Wed, 10 May 2023 16:32:44 +0200 (CEST)
Date:   Wed, 10 May 2023 16:32:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/core: Avoid double calling update_rq_clock()
Message-ID: <20230510143244.GM4253@hirez.programming.kicks-ass.net>
References: <20230510083450.62334-1-jiahao.os@bytedance.com>
 <20230510083450.62334-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510083450.62334-3-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:34:50PM +0800, Hao Jia wrote:
> There are some double rq clock update warnings are triggered.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  __balance_push_cpu_stop+0x146/0x180
>  ? migration_cpu_stop+0x2a0/0x2a0
>  cpu_stopper_thread+0xa3/0x140
>  smpboot_thread_fn+0x14f/0x210
>  ? sort_range+0x20/0x20
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
> 
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  __cfsb_csd_unthrottle+0xe0/0x100
>  __flush_smp_call_function_queue+0xaf/0x1d0
>  flush_smp_call_function_queue+0x49/0x90
>  do_idle+0x17c/0x270
>  cpu_startup_entry+0x19/0x20
>  start_secondary+0xfa/0x120
>  secondary_startup_64_no_verify+0xce/0xdb
> 
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  rq_offline_fair+0x89/0x90
>  set_rq_offline.part.118+0x28/0x60
>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0xf0
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x291/0x410
>  ? __schedule+0x65e/0x1310
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x92/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
> 
> For the __balance_push_cpu_stop() case, we remove update_rq_clock() from
> the __migrate_task() function to avoid double updating the rq clock.
> And in order to avoid missing rq clock update, add update_rq_clock()
> call before migration_cpu_stop() calls __migrate_task().
> 
> For the unthrottle_cfs_rq() case, we use rq_clock_start_loop_update() to
> prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq().
> 
> Note that the rq clock has been updated before the set_rq_offline()
> function runs, so we don't need to call update_rq_clock() in
> unthrottle_offline_cfs_rqs().

This reads like 3 separate issues -- in which case this ought to be 3
separate patches.


> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..9c712f29e5a4 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1536,6 +1536,27 @@ static inline void rq_clock_skip_update(struct rq *rq)
>  	rq->clock_update_flags |= RQCF_REQ_SKIP;
>  }
>  
> +/*
> + * During cpu offlining and rq wide unthrottling, we can trigger
> + * an update_rq_clock() for several cfs and rt runqueues (Typically
> + * when using list_for_each_entry_*)
> + * rq_clock_start_loop_update() can be called after updating the clock
> + * once and before iterating over the list to prevent multiple update.
> + * After the iterative traversal, we need to call rq_clock_stop_loop_update()
> + * to restore rq->clock_update_flags.
         ^^^^^^^
> + */
> +static inline void rq_clock_start_loop_update(struct rq *rq)
> +{
> +	lockdep_assert_rq_held(rq);
> +	rq->clock_update_flags |= RQCF_ACT_SKIP;
> +}
> +
> +static inline void rq_clock_stop_loop_update(struct rq *rq)
> +{
> +	lockdep_assert_rq_held(rq);
> +	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
> +}

This does not restore the flag, it clears the flag.
