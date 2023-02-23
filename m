Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3249C6A0E72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBWRNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBWRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:13:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8EC3D925;
        Thu, 23 Feb 2023 09:13:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FA0DB81A06;
        Thu, 23 Feb 2023 17:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CD0C433D2;
        Thu, 23 Feb 2023 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172405;
        bh=GKDMeLBGH+pATpMgOWTJhcMWeeCf4ZIAnDuYRYViDpI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sS/hCxSTeo3O2rvfioNr4r0DKMTK1+Dxh9pkdzWP/eeKf5magLkP6dtsLVV3TIZJp
         rnV99aBX14j2oFDt4MuNn4b3Bzv6J82SjBNeoSg2kAGbrlXgUd4hLNmtIYaoDvc7rV
         KjhQiIEnQrdwblVYZ1uuhQLJ8Py2sMsu6vF4DaqlNW6oLSnLnRz8+djvi8rhtVO6ra
         NQtUaWlxV3pz7c4w8hJHbDuJCrJAHsQfCNH5yYJQ6D6qCiEaozs6X0lTLIpuA23fTg
         ujwejH+I9vwgB1JPIqpVZKQ3MTY6tis2ckmPvngkWT6LQ9G1nvmlii54LSTnU/Ltxp
         SuXDpS6E6A1Yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B82935C0DBB; Thu, 23 Feb 2023 09:13:24 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:13:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Message-ID: <20230223171324.GB2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y/eP4h/chB8J0rAj@google.com>
 <258C736B-5957-4874-9CD8-BBC1E321A092@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <258C736B-5957-4874-9CD8-BBC1E321A092@joelfernandes.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 11:57:54AM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 23, 2023, at 11:10 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > ﻿On Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
> >>> From: Zqiang <qiang1.zhang@intel.com>
> >>> Sent: Thursday, February 23, 2023 2:30 PM
> >>> To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> >>> joel@joelfernandes.org
> >>> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> >>> Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> >>> call_rcu_tasks_generic()
> >>> 
> >>> According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> >>> call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeup
> >>> using irq_work_queue() is because if the caller of
> >>> call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built with
> >>> CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will be hold in
> >>> wake_up(), so the lockdep splats will happen. but now using
> >>> rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> >>> rcuwait_wake_up() no spinlock will be acquired, so this commit remove using
> >>> 
> >>> There are still spinlock-acquisition and spinlock-release invocations within the call path from rcuwait_wake_up().
> >>> 
> >>> rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> >>> 
> >>>   raw_spin_lock_irqsave()
> >>>   ...
> >>>   raw_spin_unlock_irqrestore
> >> 
> >> Yes, but this is raw_spinlock acquisition and release(note: spinlock will convert to
> >> sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
> >> 
> >> acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
> > 
> > Is this really safe in the long run though? I seem to remember there are
> > weird locking dependencies if RCU is used from within the scheduler [1].
> > 
> > I prefer to keep it as irq_work_queue() unless you are seeing some benefit.
> > Generally, there has to be a 'win' or other justification for adding more
> > risk.
> 
> On second thought, you are deleting a decent number of lines.
> 
> What do others think?
> 
> I will take a closer look later, I am interested in researching the new lock dependency this adds.

One place to start is rcu_read_unlock_trace_special(), keeping firmly
in mind that rcu_read_unlock_trace() is intended to be invoked from a
great many places.

							Thanx, Paul

>  - Joel
> 
> > 
> > thanks,
> > 
> > - Joel
> > [1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-schedlocks.html
> > 
> >>> irq_work_queue(), invoke rcuwait_wake_up() directly in
> >>> call_rcu_tasks_generic().
> >>> 
> >>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >>> ---
> >>> kernel/rcu/tasks.h | 16 +---------------
> >>> 1 file changed, 1 insertion(+), 15 deletions(-)
> >>> 
> >>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> >>> baf7ec178155..757b8c6da1ad 100644
> >>> --- a/kernel/rcu/tasks.h
> >>> +++ b/kernel/rcu/tasks.h
> >>> @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
> >>>    unsigned long rtp_jiffies;
> >>>    unsigned long rtp_n_lock_retries;
> >>>    struct work_struct rtp_work;
> >>> -    struct irq_work rtp_irq_work;
> >>>    struct rcu_head barrier_q_head;
> >>>    struct list_head rtp_blkd_tasks;
> >>>    int cpu;
> >>> @@ -112,12 +111,9 @@ struct rcu_tasks {
> >>>    char *kname;
> >>> };
> >>> 
> >>> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> >>> -
> >>> #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
> >>>            \
> >>> static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {
> >>>            \
> >>>    .lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
> >>> __percpu.cbs_pcpu_lock),        \
> >>> -    .rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
> >>>            \
> >>> };
> >>>        \
> >>> static struct rcu_tasks rt_name =
> >>>        \
> >>> {
> >>>        \
> >>> @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
> >>>    pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
> >>> data_race(rtp->percpu_enqueue_shift), data_race(rtp-
> >>>> percpu_enqueue_lim));
> >>> }
> >>> 
> >>> -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
> >>> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
> >>> -    struct rcu_tasks *rtp;
> >>> -    struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct
> >>> rcu_tasks_percpu, rtp_irq_work);
> >>> -
> >>> -    rtp = rtpcp->rtpp;
> >>> -    rcuwait_wake_up(&rtp->cbs_wait);
> >>> -}
> >>> -
> >>> // Enqueue a callback for the specified flavor of Tasks RCU.
> >>> static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >>>                   struct rcu_tasks *rtp)
> >>> @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
> >>> *rhp, rcu_callback_t func,
> >>>    rcu_read_unlock();
> >>>    /* We can't create the thread unless interrupts are enabled. */
> >>>    if (needwake && READ_ONCE(rtp->kthread_ptr))
> >>> -        irq_work_queue(&rtpcp->rtp_irq_work);
> >>> +        rcuwait_wake_up(&rtp->cbs_wait);
> >>> }
> >>> 
> >>> // RCU callback function for rcu_barrier_tasks_generic().
> >>> --
> >>> 2.25.1
> >> 
