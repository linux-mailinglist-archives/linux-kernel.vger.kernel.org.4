Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA663E058
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiK3S5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiK3S5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:57:53 -0500
X-Greylist: delayed 1202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 10:57:51 PST
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094327CE7;
        Wed, 30 Nov 2022 10:57:50 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:52666)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p0Rxp-0021FH-I7; Wed, 30 Nov 2022 11:37:45 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:51544 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p0Rxo-00BPJV-7m; Wed, 30 Nov 2022 11:37:45 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
References: <20221125135500.1653800-1-frederic@kernel.org>
        <20221125135500.1653800-4-frederic@kernel.org>
Date:   Wed, 30 Nov 2022 12:37:15 -0600
In-Reply-To: <20221125135500.1653800-4-frederic@kernel.org> (Frederic
        Weisbecker's message of "Fri, 25 Nov 2022 14:55:00 +0100")
Message-ID: <871qpkqof8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1p0Rxo-00BPJV-7m;;;mid=<871qpkqof8.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19kmI+corBFVUk0NhRQbX0604aIH9Z31n8=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Frederic Weisbecker <frederic@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 751 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (1.8%), b_tie_ro: 12 (1.6%), parse: 1.34
        (0.2%), extract_message_metadata: 22 (2.9%), get_uri_detail_list: 3.7
        (0.5%), tests_pri_-1000: 31 (4.1%), tests_pri_-950: 1.54 (0.2%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-200: 1.02 (0.1%),
        tests_pri_-100: 7 (0.9%), tests_pri_-90: 331 (44.2%), check_bayes: 325
        (43.3%), b_tokenize: 9 (1.2%), b_tok_get_all: 9 (1.2%), b_comp_prob:
        3.5 (0.5%), b_tok_touch_all: 298 (39.7%), b_finish: 1.16 (0.2%),
        tests_pri_0: 326 (43.5%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

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
>  kernel/rcu/tasks.h       | 14 ++++++++++++--
>  3 files changed, 31 insertions(+), 2 deletions(-)

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

Two questions.

1) Is there any chance you need the exit_task_rcu_stop() and
   exit_tasks_rcu_start() around schedule in the part of this code that
   calls kernel_wait4.

2) I keep thinking zap_pid_ns_processes() should be changed so that
   after it sends SIGKILL to all of the relevant processes to not wait,
   and instead have wait_consider_task simply not allow the 
   init process of the pid namespace to be reaped.

   Am I right in thinking that such a change were to be made it would
   make remove the deadlock without having to have any special code?

   It is just tricky enough to do that I don't want to discourage your
   simpler change but this looks like a case that makes the pain of
   changing zap_pid_ns_processes worthwhile in the practice.

Eric
