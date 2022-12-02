Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E3640EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiLBTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:51:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C756EE940;
        Fri,  2 Dec 2022 11:51:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ADB2B82289;
        Fri,  2 Dec 2022 19:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9085C433C1;
        Fri,  2 Dec 2022 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670010694;
        bh=PQS0Q2kaYS8KTdeCxBPO7GTuok90UY+nMD7Df6BbxSw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iH2tqD+ohbVJ97TeS+2MVKc19wUB79WFx9vYrUe6WMz/BDcsNfpKNP+3m3etXmGQM
         r/iYwMVaAS9bWtBguP33HzQO3EH8mUhVhUbsnraU2urN5M9kLpha/m3Qpzb44cuqE9
         MBHZACOcxXlDOCpEsc1YRhpc0vBREyr8dsSmG3M/OodZDYeJTwAEXf7ND1TBytw1vP
         +LrnDVzzXu3S1uUI5G34BuguoV3tjBWXIBxlJIUEnlTzVLwwA0PefNq8Qn7R6Rw0nj
         P1ZG98344IzON0E/khsfwHXoivRGvqqHAjJhhYHLz5SPfTMcO1PuyvDVdaYn7scMpi
         STpLpbJ9xc1vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 591575C095D; Fri,  2 Dec 2022 11:51:34 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:51:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
Message-ID: <20221202195134.GA4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qpkqof8.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:37:15PM -0600, Eric W. Biederman wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > RCU Tasks and PID-namespace unshare can interact in do_exit() in a
> > complicated circular dependency:
> >
> > 1) TASK A calls unshare(CLONE_NEWPID), this creates a new PID namespace
> >    that every subsequent child of TASK A will belong to. But TASK A
> >    doesn't itself belong to that new PID namespace.
> >
> > 2) TASK A forks() and creates TASK B. TASK A stays attached to its PID
> >    namespace (let's say PID_NS1) and TASK B is the first task belonging
> >    to the new PID namespace created by unshare()  (let's call it PID_NS2).
> >
> > 3) Since TASK B is the first task attached to PID_NS2, it becomes the
> >    PID_NS2 child reaper.
> >
> > 4) TASK A forks() again and creates TASK C which get attached to PID_NS2.
> >    Note how TASK C has TASK A as a parent (belonging to PID_NS1) but has
> >    TASK B (belonging to PID_NS2) as a pid_namespace child_reaper.
> >
> > 5) TASK B exits and since it is the child reaper for PID_NS2, it has to
> >    kill all other tasks attached to PID_NS2, and wait for all of them to
> >    die before getting reaped itself (zap_pid_ns_process()).
> >
> > 6) TASK A calls synchronize_rcu_tasks() which leads to
> >    synchronize_srcu(&tasks_rcu_exit_srcu).
> >
> > 7) TASK B is waiting for TASK C to get reaped. But TASK B is under a
> >    tasks_rcu_exit_srcu SRCU critical section (exit_notify() is between
> >    exit_tasks_rcu_start() and exit_tasks_rcu_finish()), blocking TASK A.
> >
> > 8) TASK C exits and since TASK A is its parent, it waits for it to reap
> >    TASK C, but it can't because TASK A waits for TASK B that waits for
> >    TASK C.
> >
> > Pid_namespace semantics can hardly be changed at this point. But the
> > coverage of tasks_rcu_exit_srcu can be reduced instead.
> >
> > The current task is assumed not to be concurrently reapable at this
> > stage of exit_notify() and therefore tasks_rcu_exit_srcu can be
> > temporarily relaxed without breaking its constraints, providing a way
> > out of the deadlock scenario.
> >
> > Fixes: 3f95aa81d265 ("rcu: Make TASKS_RCU handle tasks that are almost done exiting")
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Eric W . Biederman <ebiederm@xmission.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  include/linux/rcupdate.h |  2 ++
> >  kernel/pid_namespace.c   | 17 +++++++++++++++++
> >  kernel/rcu/tasks.h       | 14 ++++++++++++--
> >  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index f4f8cb0435b4..fc21c5d5fd5d 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -244,7 +244,24 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> >  		set_current_state(TASK_INTERRUPTIBLE);
> >  		if (pid_ns->pid_allocated == init_pids)
> >  			break;
> > +		/*
> > +		 * Release tasks_rcu_exit_srcu to avoid following deadlock:
> > +		 *
> > +		 * 1) TASK A unshare(CLONE_NEWPID)
> > +		 * 2) TASK A fork() twice -> TASK B (child reaper for new ns)
> > +		 *    and TASK C
> > +		 * 3) TASK B exits, kills TASK C, waits for TASK A to reap it
> > +		 * 4) TASK A calls synchronize_rcu_tasks()
> > +		 *                   -> synchronize_srcu(tasks_rcu_exit_srcu)
> > +		 * 5) *DEADLOCK*
> > +		 *
> > +		 * It is considered safe to release tasks_rcu_exit_srcu here
> > +		 * because we assume the current task can not be concurrently
> > +		 * reaped at this point.
> > +		 */
> > +		exit_tasks_rcu_stop();
> >  		schedule();
> > +		exit_tasks_rcu_start();
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> 
> Two questions.
> 
> 1) Is there any chance you need the exit_task_rcu_stop() and
>    exit_tasks_rcu_start() around schedule in the part of this code that
>    calls kernel_wait4.

Quite possibly, but I must defer to Frederic on this one.

> 2) I keep thinking zap_pid_ns_processes() should be changed so that
>    after it sends SIGKILL to all of the relevant processes to not wait,
>    and instead have wait_consider_task simply not allow the 
>    init process of the pid namespace to be reaped.
> 
>    Am I right in thinking that such a change were to be made it would
>    make remove the deadlock without having to have any special code?
> 
>    It is just tricky enough to do that I don't want to discourage your
>    simpler change but this looks like a case that makes the pain of
>    changing zap_pid_ns_processes worthwhile in the practice.

I would dearly love for there to be a fix that allowed the RCU-related
code to go back to what it was originally.  But there is apparently some
concern that users might be relying on the current sleep-while-exiting
semantics.  :-/

							Thanx, Paul
