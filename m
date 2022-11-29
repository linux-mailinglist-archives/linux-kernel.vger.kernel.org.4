Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC263C321
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiK2OuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiK2Otx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:49:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C2FCA;
        Tue, 29 Nov 2022 06:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8339061769;
        Tue, 29 Nov 2022 14:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6380C433C1;
        Tue, 29 Nov 2022 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669733314;
        bh=fCPTOuDQLVzzoeN7L8h0yP7y2/WG+kDgXWk9SkG16OE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WJS5xOLAJ8HrucLZMjrHmPPhEKfC05q6EnqK2V0A7jtDrml2YZf6wzEfYyXhqXVrY
         vd2YBRqRwxOFXQxvqLQgFiimWjiY3yZ+OVG95mf5ZaAOLhDxGtilpQXNAWkSS5Cyxg
         QA3Bv4XYigIqr/nHZdAkaKjy4i+n0fzF/L9wdpOn2LNd9quZNGMXeR/LsNd51rX3Pt
         u8cSi3vfheMcdsbCFdftOsCDAEU2tYxfSxgdjW6x0D1Op+cGvrL6Th7WZX9CnUiOzg
         6nxtWheYL2nCEeiZqUXTtMm4nHky7iCtbe5eMMbXhMQosMh8qnCF2IL2IEQdOLPYTN
         1c8rmqzZbtmcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69D105C03A4; Tue, 29 Nov 2022 06:48:34 -0800 (PST)
Date:   Tue, 29 Nov 2022 06:48:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu-tasks: Fix race against exiting pid_ns
Message-ID: <20221129144834.GW4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221129002240.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <20221129095500.GA1706373@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129095500.GA1706373@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:55:00AM +0100, Frederic Weisbecker wrote:
> On Mon, Nov 28, 2022 at 04:22:40PM -0800, Paul E. McKenney wrote:
> > On Fri, Nov 25, 2022 at 02:54:57PM +0100, Frederic Weisbecker wrote:
> > > Pengfei Xu has reported a deadlock involving calls to unshare(),
> > > perf_event_open() and clone3() calls. It requires CAP_SYS_ADMIN
> > > to reproduce (at least I don't see a way for a non privilege process to
> > > reproduce).
> > > 
> > > See this thread for details: https://lore.kernel.org/all/Y3sOgrOmMQqPMItu@xpf.sh.intel.com/
> > > And this document for the collaborative analysis with Boqun, Paul and Neeraj:
> > > https://docs.google.com/document/d/1hJxgiZ5TMZ4YJkdJPLAkRvq7sYQ-A7svgA8no6i-v8k
> > > 
> > > The two first patches are small improvements. The fix is in the last patch.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > 	rcu/dev
> > > 
> > > HEAD: 45ef5a0a4be4e0db9eadcc86e8f346d34c62e744
> > 
> > Hearing no objections, queued for further review and testing.
> > 
> > And thank you very much!  That race between synchronize_rcu_tasks() and
> > zap_pid_ns_processes() certainly was more than a bit on the non-trivial
> > side.  Good show!!!
> 
> Thanks!
> 
> Also please replace the last patch with the following to fix
> a !CONFIG_RCU_TASKS issue:

Like this?  ;-)

a0c355bbdfee ("squash! rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()")

							Thanx, Paul

> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Thu, 24 Nov 2022 18:15:46 +0100
> Subject: [PATCH] rcu-tasks: Fix synchronize_rcu_tasks() VS
>  zap_pid_ns_processes()
> 
> RCU Tasks and PID-namespace unshare can interact in do_exit() in a
> complicated circular dependency:
> 
> 1) TASK A calls unshare(CLONE_NEWPID), this creates a new PID namespace
>    that every subsequent child of TASK A will belong to. But TASK A
>    doesn't itself belong to that new PID namespace.
> 
> 2) TASK A forks() and creates TASK B. TASK A stays attached to its PID
>    namespace (let's say PID_NS1) and TASK B is the first task belonging
>    to the new PID namespace created by unshare()  (let's call it PID_NS2).
> 
> 3) Since TASK B is the first task attached to PID_NS2, it becomes the
>    PID_NS2 child reaper.
> 
> 4) TASK A forks() again and creates TASK C which get attached to PID_NS2.
>    Note how TASK C has TASK A as a parent (belonging to PID_NS1) but has
>    TASK B (belonging to PID_NS2) as a pid_namespace child_reaper.
> 
> 5) TASK B exits and since it is the child reaper for PID_NS2, it has to
>    kill all other tasks attached to PID_NS2, and wait for all of them to
>    die before getting reaped itself (zap_pid_ns_process()).
> 
> 6) TASK A calls synchronize_rcu_tasks() which leads to
>    synchronize_srcu(&tasks_rcu_exit_srcu).
> 
> 7) TASK B is waiting for TASK C to get reaped. But TASK B is under a
>    tasks_rcu_exit_srcu SRCU critical section (exit_notify() is between
>    exit_tasks_rcu_start() and exit_tasks_rcu_finish()), blocking TASK A.
> 
> 8) TASK C exits and since TASK A is its parent, it waits for it to reap
>    TASK C, but it can't because TASK A waits for TASK B that waits for
>    TASK C.
> 
> Pid_namespace semantics can hardly be changed at this point. But the
> coverage of tasks_rcu_exit_srcu can be reduced instead.
> 
> The current task is assumed not to be concurrently reapable at this
> stage of exit_notify() and therefore tasks_rcu_exit_srcu can be
> temporarily relaxed without breaking its constraints, providing a way
> out of the deadlock scenario.
> 
> Fixes: 3f95aa81d265 ("rcu: Make TASKS_RCU handle tasks that are almost done exiting")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Eric W . Biederman <ebiederm@xmission.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/rcupdate.h |  2 ++
>  kernel/pid_namespace.c   | 17 +++++++++++++++++
>  kernel/rcu/tasks.h       | 15 +++++++++++++--
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 89b3036746d2..a19d91d5461c 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -238,6 +238,7 @@ void synchronize_rcu_tasks_rude(void);
>  
>  #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
>  void exit_tasks_rcu_start(void);
> +void exit_tasks_rcu_stop(void);
>  void exit_tasks_rcu_finish(void);
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>  #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
> @@ -246,6 +247,7 @@ void exit_tasks_rcu_finish(void);
>  #define call_rcu_tasks call_rcu
>  #define synchronize_rcu_tasks synchronize_rcu
>  static inline void exit_tasks_rcu_start(void) { }
> +static inline void exit_tasks_rcu_stop(void) { }
>  static inline void exit_tasks_rcu_finish(void) { }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>  
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index f4f8cb0435b4..fc21c5d5fd5d 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -244,7 +244,24 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		if (pid_ns->pid_allocated == init_pids)
>  			break;
> +		/*
> +		 * Release tasks_rcu_exit_srcu to avoid following deadlock:
> +		 *
> +		 * 1) TASK A unshare(CLONE_NEWPID)
> +		 * 2) TASK A fork() twice -> TASK B (child reaper for new ns)
> +		 *    and TASK C
> +		 * 3) TASK B exits, kills TASK C, waits for TASK A to reap it
> +		 * 4) TASK A calls synchronize_rcu_tasks()
> +		 *                   -> synchronize_srcu(tasks_rcu_exit_srcu)
> +		 * 5) *DEADLOCK*
> +		 *
> +		 * It is considered safe to release tasks_rcu_exit_srcu here
> +		 * because we assume the current task can not be concurrently
> +		 * reaped at this point.
> +		 */
> +		exit_tasks_rcu_stop();
>  		schedule();
> +		exit_tasks_rcu_start();
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 9a8114114b48..4dda8e6e5707 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1016,16 +1016,27 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
>   * task is exiting and may be removed from the tasklist. See
>   * corresponding synchronize_srcu() for further details.
>   */
> -void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
>  {
>  	struct task_struct *t = current;
>  
>  	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
> -	exit_tasks_rcu_finish_trace(t);
> +}
> +
> +/*
> + * Contribute to protect against tasklist scan blind spot while the
> + * task is exiting and may be removed from the tasklist. See
> + * corresponding synchronize_srcu() for further details.
> + */
> +void exit_tasks_rcu_finish(void)
> +{
> +	exit_tasks_rcu_stop();
> +	exit_tasks_rcu_finish_trace(current);
>  }
>  
>  #else /* #ifdef CONFIG_TASKS_RCU */
>  void exit_tasks_rcu_start(void) { }
> +void exit_tasks_rcu_stop(void) { }
>  void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU */
>  
> -- 
> 2.25.1
> 
