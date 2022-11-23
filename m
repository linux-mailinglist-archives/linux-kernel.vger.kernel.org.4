Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4E6361F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiKWOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiKWOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:38:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6CE1F62B;
        Wed, 23 Nov 2022 06:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D916B8205D;
        Wed, 23 Nov 2022 14:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498CAC433C1;
        Wed, 23 Nov 2022 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214281;
        bh=DHdFXSKtZ+h0ShqK6NSzY3nVLisD1LxX3VpZknCiL8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtaG+XPyeMXqZfsyxUDuqS0XRT8Fq7/xgVbdsbW9prjHKH9yfH77O7+grJJEon+ND
         diC9HUqrOx/47Hikvg0bSu2RzxTcwPwv2TAJ84ZBfFiaqEuurGSZIJvG60PlkY0heJ
         C4FxFEOAsEUiwv23kRjZMNo01JOV3x57yYfucd3kIfKQhVAr8M4rljaGs2b2fF96NF
         Ura2EaHfx0R9j/NT0w9COCh9unO8E76Y22s3qdjgX0eMzmFPYkbyf0Pnv2/V48UeXd
         ktGFEGQVwSN/IjOygGHkeQmvjvsRzp02FykL6C/ENPK1QovoP10+MNbctICJHnF0nZ
         KdElVR5+4p1Zw==
Date:   Wed, 23 Nov 2022 15:37:58 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com,
        rcu@vger.kernel.org
Subject: PID_NS unshare VS synchronize_rcu_tasks() (was: Re: [Syzkaller &
 bisect] There is task hung in "synchronize_rcu" in v6.1-rc5 kernel)
Message-ID: <20221123143758.GA1387380@lothringen>
References: <Y3sOgrOmMQqPMItu@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3sOgrOmMQqPMItu@xpf.sh.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 01:37:06PM +0800, Pengfei Xu wrote:
> Hi Frederic Weisbecker and kernel developers,
> 
> Greeting!
> There is task hung in "synchronize_rcu" in v6.1-rc5 kernel.
> 
> Bisected the issue on Raptor and server(No atom small core, big core only),
> both platforms bisected results show that:
> first bad commit is c597bfddc9e9e8a63817252b67c3ca0e544ace26:
> "sched: Provide Kconfig support for default dynamic preempt mode"
> 
> [  300.097166] INFO: task rcu_tasks_kthre:11 blocked for more than 147 seconds.
> [  300.097455]       Not tainted 6.1.0-rc5-094226ad94f4 #1
> [  300.097641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.097922] task:rcu_tasks_kthre state:D stack:0     pid:11    ppid:2      flags:0x00004000
> [  300.098230] Call Trace:
> [  300.098325]  <TASK>
> [  300.098410]  __schedule+0x2de/0x8f0
> [  300.098562]  schedule+0x5b/0xe0
> [  300.098693]  schedule_timeout+0x3f1/0x4b0
> [  300.098849]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [  300.099032]  ? queue_delayed_work_on+0x82/0xc0
> [  300.099206]  wait_for_completion+0x81/0x140
> [  300.099373]  __synchronize_srcu.part.23+0x83/0xb0
> [  300.099558]  ? __bpf_trace_rcu_stall_warning+0x20/0x20
> [  300.099757]  synchronize_srcu+0xd6/0x100
> [  300.099913]  rcu_tasks_postscan+0x19/0x20
> [  300.100070]  rcu_tasks_wait_gp+0x108/0x290
> [  300.100230]  ? _raw_spin_unlock+0x1d/0x40
> [  300.100389]  rcu_tasks_one_gp+0x27f/0x370
> [  300.100546]  ? rcu_tasks_postscan+0x20/0x20
> [  300.100709]  rcu_tasks_kthread+0x37/0x50
> [  300.100863]  kthread+0x14d/0x190
> [  300.100998]  ? kthread_complete_and_exit+0x40/0x40
> [  300.101199]  ret_from_fork+0x1f/0x30
> [  300.101347]  </TASK>

Thanks for reporting this. Fortunately I managed to reproduce and debug.
It took me a few days to understand the complicated circular dependency
involved.

So here is a summary:

1) TASK A calls unshare(CLONE_NEWPID), this creates a new PID namespace
   that every subsequent child of TASK A will belong to. But TASK A doesn't
   itself belong to that new PID namespace.

2) TASK A forks() and creates TASK B (it is a new threadgroup so it is a
   thread group leader). TASK A stays attached to its PID namespace (let's say PID_NS1)
   and TASK B is the first task belonging to the new PID namespace created by
   unshare()  (let's call it PID_NS2).

3) Since TASK B is the first task attached to PID_NS2, it becomes the PID_NS2
   child reaper.

4) TASK A forks() again and creates TASK C which get attached to PID_NS2.
   Note how TASK C has TASK A as a parent (belonging to PID_NS1) but has
   TASK B (belonging to PID_NS2) as a pid_namespace child_reaper.

3) TASK B exits and since it is the child reaper for PID_NS2, it has to
   kill all other tasks attached to PID_NS2, and wait for all of them to die
   before reaping itself (zap_pid_ns_process()). Note it seems to make a
   misleading assumption here, trusting that all tasks in PID_NS2 either
   get reaped by a parent belonging to the same namespace or by TASK B.
   And it is confident that since it deactivated SIGCHLD handler, all
   the remaining tasks ultimately autoreap. And it waits for that to happen.
   However TASK C escapes that rule because it will get reaped by its parent
   TASK A belonging to PID_NS1.

4) TASK A calls synchronize_rcu_tasks() which leads to
   synchronize_srcu(&tasks_rcu_exit_srcu).

5) TASK B is waiting for TASK C to get reaped (wrongly assuming it autoreaps)
   But TASK B is under a tasks_rcu_exit_srcu SRCU critical section
   (exit_notify() is between exit_tasks_rcu_start() and
   exit_tasks_rcu_finish()), blocking TASK A

6) TASK C exits and since TASK A is its parent, it waits for it to reap TASK C,
   but it can't because TASK A waits for TASK B that waits for TASK C.

So there is a circular dependency:

_ TASK A waits for TASK B to get out of tasks_rcu_exit_srcu SRCU critical
section
_ TASK B waits for TASK C to get reaped
_ TASK C waits for TASK A to reap it.

I have no idea how to solve the situation without violating the pid_namespace
rules and unshare() semantics (although I wish unshare(CLONE_NEWPID) had a less
error prone behaviour with allowing creating more than one task belonging to the
same namespace).

So probably having an SRCU read side critical section within exit_notify() is
not a good idea, is there a solution to work around that for rcu tasks?

Thanks.
