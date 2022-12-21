Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C308365370D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiLUTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiLUTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:33:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21D15F0B;
        Wed, 21 Dec 2022 11:33:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4BE1617D0;
        Wed, 21 Dec 2022 19:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A89BC433F0;
        Wed, 21 Dec 2022 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671651206;
        bh=mxWtR5AF/2xVb9DefIyiwGIDf+QeDervBvCWP8vw7JI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Wn2r36BqERhoFIIQg3Y73p5/T2ytRIXLoPumUoZCvBdFcKnR8ur4MZMHJ2NE3kK99
         fRUKtmFI/qLzAbpNCot7j0DqOuKIM/EqPZo860GCcY6oSjAaSjBVhyD3OxtZ+m2IOH
         kPm28gYvLa+e9hZxgp3j4IdUHLrvIYBOAlCaud9T/DLmAy/+ucA472Zu5sxuJtpEie
         EEyTQySL4WZash6J0nEpbZIcQhGUQluA2THhEwf+OAahzCJyB44svZboVjUMYx9VvR
         s0lMPYmMDGqErvo6VjgRSDJTzC3GGwE/rIpVl3HppgDCxoTE1xNfjt3xExttJXPh7D
         7BiRCN73L81/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9DF6F5C0989; Wed, 21 Dec 2022 11:33:25 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:33:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Liu, Yujie" <yujie.liu@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Message-ID: <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <202212181914.f5a305f3-yujie.liu@intel.com>
 <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:21:01AM +0000, Zhang, Qiang1 wrote:
> >Greeting,
> >FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr[rcutorture] due to commit (built with gcc-11):
> >
> >commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug")
> >url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Make-rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
> >base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
> >patch link: https://lore.kernel.org/all/20221130234533.1983769-1-qiang1.zhang@intel.com/
> >patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
> >
> >in testcase: rcutorture
> >version: 
> >with following parameters:
> >
> >	runtime: 300s
> >	test: cpuhotplug
> >	torture_type: tasks-rude
> >
> >test-description: rcutorture is rcutorture kernel module load/unload test.
> >test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> >
> >on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> >
> >caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-progress test 0
> >[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> >[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier_tasks_rude+0x0/0x10() 0
> >[  146.800051][  T583] ------------[ cut here ]------------
> >[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/rcutorture.c:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> >[  146.801075][  T583] Modules linked in: rcutorture torture ipmi_msghandler crc32c_intel serio_raw processor fuse
> >[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd Not tainted 6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a9
> >[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> >[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> >[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 00 83 c4 10 84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 67 83 fe 63 7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f8 2b 45 dc
> >[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 00000000 EDX: 00000000
> >[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f64 ESP: ed9d5f40
> >[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010293
> >[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 000406d0
> >[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> >[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
> >[  146.808384][  T583] Call Trace:
> >[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> >[  146.809348][  T583]  kthread+0xc8/0xf0
> >[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x80 [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> >[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
> >[  146.810734][  T583]  ret_from_fork+0x1c/0x28
> >[  146.811075][  T583] irq event stamp: 205883
> >[  146.811400][  T583] hardirqs last  enabled at (205891): [<c114bb06>] __up_console_sem+0x66/0x80
> >[  146.811960][  T583] hardirqs last disabled at (205898): [<c114baed>] __up_console_sem+0x4d/0x80
> >[  146.812583][  T583] softirqs last  enabled at (205880): [<c1ecb40b>] __do_softirq+0x2bb/0x440
> >[  146.813079][  T583] softirqs last disabled at (205871): [<c10845f0>] call_on_stack+0x40/0x50
> >[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
> >[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 barrier: 3960 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_max_cbs: 50000 cver 1 gps 0
> >[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10: 
> >[  149.453780][  T557] ------------[ cut here ]------------
> >[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
> >[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/rcutorture.c:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]
> 
> 
> This is not a bug.  this is caused by grace period taking too long time, the previous callback
> has not been completed.  from the dmesg, can be found that the cpuhotplug test is being
> performed periodically, this may cause the rude RCU-Tasks  grace period to take more time,
> due to we need to acquire the cpus_read_lock, and the CPU0 always bootup failed, that is to
> say, only one CPU of your system is online at this time.

Onlining of a CPU failing with EIO is a new one on me.  Especially
persistent failure.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >[  149.455687][  T557] Modules linked in: rcutorture torture ipmi_msghandler crc32c_intel serio_raw processor fuse
> >[  149.456490][  T557] CPU: 1 PID: 557 Comm: rcu_torture_wri Tainted: G        W          6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a9
> >[  149.457660][  T557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> >[  149.458484][  T557] EIP: rcu_torture_writer+0x71d/0xc80 [rcutorture]
> >[  149.458990][  T557] Code: 05 00 00 8d 43 f4 39 c6 74 c3 e8 0e a0 0b d2 83 ff 63 0f 87 3d 05 00 00 ff 73 fc 68 88 a0 10 ef 68 f4 9a 10 ef e8 10 01 d2 d2 <0f> 0b a1 30 c6 10 ef 83 c4 0c 85 c0 75 95 b8 01 00 00 00 87 05 30
> >[  149.460472][  T557] EAX: 00000027 EBX: ef10d630 ECX: e49c0f28 EDX: e49c0f24
> >[  149.461022][  T557] ESI: ef10d694 EDI: 0000004f EBP: ece35f8c ESP: ece35f18
> >[  149.461539][  T557] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
> >[  149.462101][  T557] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 000406d0
> >[  149.462642][  T557] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> >[  149.463172][  T557] DR6: fffe0ff0 DR7: 00000400
> >[  149.463526][  T557] Call Trace:
> >[  149.463795][  T557]  ? lockdep_hardirqs_on_prepare+0xa4/0x160
> >[  149.464333][  T557]  ? _raw_spin_unlock_irqrestore+0x45/0x60
> >[  149.464795][  T557]  ? trace_hardirqs_on+0x35/0xe0
> >[  149.465191][  T557]  kthread+0xc8/0xf0
> >[  149.465506][  T557]  ? rcu_torture_pipe_update+0x130/0x130 [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> >[  149.466327][  T557]  ? kthread_complete_and_exit+0x20/0x20
> >[  149.466771][  T557]  ret_from_fork+0x1c/0x28
> >[  149.467136][  T557] irq event stamp: 45753
> >[  149.467457][  T557] hardirqs last  enabled at (45761): [<c114bb06>] __up_console_sem+0x66/0x80
> >[  149.468145][  T557] hardirqs last disabled at (45770): [<c114baed>] __up_console_sem+0x4d/0x80
> >[  149.468803][  T557] softirqs last  enabled at (41056): [<ef1037a0>] rcu_torture_pipe_update+0xe0/0x130 [rcutorture]
> >[  149.469602][  T557] softirqs last disabled at (41054): [<ef10377c>] rcu_torture_pipe_update+0xbc/0x130 [rcutorture]
> >[  149.470401][  T557] ---[ end trace 0000000000000000 ]---
> 
