Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C8663716
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjAJCKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjAJCKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:10:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD781DF3E;
        Mon,  9 Jan 2023 18:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32302B810D5;
        Tue, 10 Jan 2023 02:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC1C433D2;
        Tue, 10 Jan 2023 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673316612;
        bh=ovyxKUkQ3clgarHbwUAF8m2af6/VKIgZEdJSlb4lKa0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rwNNkCM57Gq1vbSp1qtKSgRAUPDbvL/r8MlU6mBIelq/pDk62r8v3HYwt/+eJ2hLm
         vaSQqgjqfmWmPtujbYpm0pvkc7iKuUFv4x1ESYo1J6tb4uhPo3TA186QupeG4L1Lsx
         cgjS4k4rii+/SvIHjd3wLG1A8YHFIqEyehw+YwKvBB+3Xl8mt40QymNtyD/ZOXKhxR
         CEvZyis4t1Vk6j5bpnzoxqZ1ZW7N3NxceYYbC8I8c/8r+EzWGc7yfmn+R2W9+8MmYi
         vjS7aES5PxrT+c7sFKDnZcP0gnzuSCXz63LGp/uU54lDai+M8/6wOUYTENXdWcJIeS
         ZdJP0YncilEgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B20F5C0A1A; Mon,  9 Jan 2023 18:10:12 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:10:12 -0800
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
Message-ID: <20230110021012.GI4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <202212181914.f5a305f3-yujie.liu@intel.com>
 <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588092AB6A014F30420D697CDAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230105182220.GF4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880273B1F5A6FF2CB782051DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880273B1F5A6FF2CB782051DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:48:56AM +0000, Zhang, Qiang1 wrote:
> 
> On Thu, Dec 22, 2022 at 09:35:06AM +0000, Zhang, Qiang1 wrote:
> > >On Mon, Dec 19, 2022 at 02:21:01AM +0000, Zhang, Qiang1 wrote:
> > > >Greeting,
> > > >FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr[rcutorture] due to commit (built with gcc-11):
> > > >
> > > >commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug")
> > > >url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Make-rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
> > > >base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
> > > >patch link: https://lore.kernel.org/all/20221130234533.1983769-1-qiang1.zhang@intel.com/
> > > >patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
> > > >
> > > >in testcase: rcutorture
> > > >version: 
> > > >with following parameters:
> > > >
> > > >	runtime: 300s
> > > >	test: cpuhotplug
> > > >	torture_type: tasks-rude
> > > >
> > > >test-description: rcutorture is rcutorture kernel module load/unload test.
> > > >test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > > >
> > > >on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > >
> > > >caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > >
> > > >
> > > >[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-progress test 0
> > > >[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> > > >[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier_tasks_rude+0x0/0x10() 0
> > > >[  146.800051][  T583] ------------[ cut here ]------------
> > > >[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/rcutorture.c:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> > > >[  146.801075][  T583] Modules linked in: rcutorture torture ipmi_msghandler crc32c_intel serio_raw processor fuse
> > > >[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd Not tainted 6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a9
> > > >[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > > >[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> > > >[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 00 83 c4 10 84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 67 83 fe 63 7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f8 2b 45 dc
> > > >[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 00000000 EDX: 00000000
> > > >[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f64 ESP: ed9d5f40
> > > >[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010293
> > > >[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 000406d0
> > > >[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > >[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
> > > >[  146.808384][  T583] Call Trace:
> > > >[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > >[  146.809348][  T583]  kthread+0xc8/0xf0
> > > >[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x80 [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > >[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
> > > >[  146.810734][  T583]  ret_from_fork+0x1c/0x28
> > > >[  146.811075][  T583] irq event stamp: 205883
> > > >[  146.811400][  T583] hardirqs last  enabled at (205891): [<c114bb06>] __up_console_sem+0x66/0x80
> > > >[  146.811960][  T583] hardirqs last disabled at (205898): [<c114baed>] __up_console_sem+0x4d/0x80
> > > >[  146.812583][  T583] softirqs last  enabled at (205880): [<c1ecb40b>] __do_softirq+0x2bb/0x440
> > > >[  146.813079][  T583] softirqs last disabled at (205871): [<c10845f0>] call_on_stack+0x40/0x50
> > > >[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
> > > >[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 barrier: 3960 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_max_cbs: 50000 cver 1 gps 0
> > > >[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10: 
> > > >[  149.453780][  T557] ------------[ cut here ]------------
> > > >[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
> > > >[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/rcutorture.c:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]
> > > 
> > > 
> > > This is not a bug.  this is caused by grace period taking too long time, the previous callback
> > > has not been completed.  from the dmesg, can be found that the cpuhotplug test is being
> > > performed periodically, this may cause the rude RCU-Tasks  grace period to take more time,
> > > due to we need to acquire the cpus_read_lock, and the CPU0 always bootup failed, that is to
> > > say, only one CPU of your system is online at this time.
> > >
> > >Onlining of a CPU failing with EIO is a new one on me.  Especially
> > >persistent failure.
> > 
> > I use the kernel configuration file in the attachment and  base on:
> > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
> > 
> > use "echo 1 > /sys/devices/system/cpu/cpu0/online" can reproduce this problem,
> > the CPU0 always fails to go online.  
> > 
> > Debug found CPU0 is always not set in cpu_initialized_mask.
> > causes the do_boot_cpu() to return -1.
> > 
> > do_boot_cpu()
> >      wakeup_cpu_via_init_nmi();
> >      if (!boot_error) {
> >                 /*
> >                  * Wait 10s total for first sign of life from AP
> >                  */
> >                 boot_error = -1;
> >                 timeout = jiffies + 10*HZ;
> >                 while (time_before(jiffies, timeout)) {
> >                         if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
> >                                 /*
> >                                  * Tell AP to proceed with initialization
> >                                  */
> >                                 cpumask_set_cpu(cpu, cpu_callout_mask);
> >                                 boot_error = 0;
> >                                 break;
> >                         }
> >                         schedule();
> >                 }
> >         }
> > 
> > This looks related to this modification e1c467e69040c("x86, hotplug: 
> > Wake up CPU0 via NMI instead of INIT, SIPI, SIPI ").
> > 
> > 
> > The following modification can make CPU0 go online successfully(This
> > is just a test, not sure if there are other effects).
> >
> >
> >Thank you for tracking this down!!!
> >
> >Huh.  CPU 0 is normally the boot CPU.  Back in the day, it could not
> >be offlined.  Given that your testing indicates that CPU 0 can now be
> >taken offline, maybe this "if" statement is a holdover that someone
> >forgot to remove?
> >
> >But I must defer to those who know a lot more about this level of
> >x86 code than I do.
> 
> I found relevant modification information, maybe it will be of some help
> 
> commit e1c467e69040c3be68959332959c07fb3d818e87
> Author: Fenghua Yu <fenghua.yu@intel.com>
> Date:   Wed Nov 14 04:36:53 2012 -0800
> 
>     x86, hotplug: Wake up CPU0 via NMI instead of INIT, SIPI, SIPI
> 
>     Instead of waiting for STARTUP after INITs, BSP will execute the BIOS boot-strap
>     code which is not a desired behavior for waking up BSP. To avoid the boot-strap
>     code, wake up CPU0 by NMI instead.
> 
>     This works to wake up soft offlined CPU0 only. If CPU0 is hard offlined (i.e.
>     physically hot removed and then hot added), NMI won't wake it up. We'll change
>     this code in the future to wake up hard offlined CPU0 if real platform and
>     request are available.
> 
>     AP is still waken up as before by INIT, SIPI, SIPI sequence.
> 
>     Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>     Link: http://lkml.kernel.org/r/1352896613-25957-1-git-send-email-fenghua.yu@intel.com
>     Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>

Interesting!

When I run rcutorture on x86 (under qemu/KVM), it refuses to attempt to
offline CPU 0.  The reason is that cpu_is_hotpluggable(0) returns false.

If I comment out that check, I get this:

	rcu-torture:torture_onoff task: offline 0 failed: errno -1

A bit of digging turned up the CONFIG_BOOTPARAM_HOTPLUG_CPU0 Kconfig
option.  Setting that causes CPU 0 to be offlined.

I clearly need to add this to one of the scenarios.  I arbitrarily
chose TREE01, but please let me know if some other scenario or
group of scenarios would be better.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 3f3ea0287f69..26ee9cdf639e 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1013,10 +1013,10 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
> >         /*
> >          * Wake up AP by INIT, INIT, STARTUP sequence.
> >          */
> > -       if (cpu) {
> > +//     if (cpu) {
> >                 boot_error = wakeup_secondary_cpu_via_init(apicid, start_ip);
> >                 goto out;
> > -       }
> > +//     }
> > 
> >         /*
> >          * Wake up BSP by nmi.
> > 
> > 
> > Thanks
> > Zqiang
> > 
> > >
> > >							Thanx, Paul
> > >
> > > Thanks
> > > Zqiang
> > > 
> > > >[  149.455687][  T557] Modules linked in: rcutorture torture ipmi_msghandler crc32c_intel serio_raw processor fuse
> > > >[  149.456490][  T557] CPU: 1 PID: 557 Comm: rcu_torture_wri Tainted: G        W          6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733dde4a9
> > > >[  149.457660][  T557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > > >[  149.458484][  T557] EIP: rcu_torture_writer+0x71d/0xc80 [rcutorture]
> > > >[  149.458990][  T557] Code: 05 00 00 8d 43 f4 39 c6 74 c3 e8 0e a0 0b d2 83 ff 63 0f 87 3d 05 00 00 ff 73 fc 68 88 a0 10 ef 68 f4 9a 10 ef e8 10 01 d2 d2 <0f> 0b a1 30 c6 10 ef 83 c4 0c 85 c0 75 95 b8 01 00 00 00 87 05 30
> > > >[  149.460472][  T557] EAX: 00000027 EBX: ef10d630 ECX: e49c0f28 EDX: e49c0f24
> > > >[  149.461022][  T557] ESI: ef10d694 EDI: 0000004f EBP: ece35f8c ESP: ece35f18
> > > >[  149.461539][  T557] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010292
> > > >[  149.462101][  T557] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 CR4: 000406d0
> > > >[  149.462642][  T557] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > >[  149.463172][  T557] DR6: fffe0ff0 DR7: 00000400
> > > >[  149.463526][  T557] Call Trace:
> > > >[  149.463795][  T557]  ? lockdep_hardirqs_on_prepare+0xa4/0x160
> > > >[  149.464333][  T557]  ? _raw_spin_unlock_irqrestore+0x45/0x60
> > > >[  149.464795][  T557]  ? trace_hardirqs_on+0x35/0xe0
> > > >[  149.465191][  T557]  kthread+0xc8/0xf0
> > > >[  149.465506][  T557]  ? rcu_torture_pipe_update+0x130/0x130 [rcutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > >[  149.466327][  T557]  ? kthread_complete_and_exit+0x20/0x20
> > > >[  149.466771][  T557]  ret_from_fork+0x1c/0x28
> > > >[  149.467136][  T557] irq event stamp: 45753
> > > >[  149.467457][  T557] hardirqs last  enabled at (45761): [<c114bb06>] __up_console_sem+0x66/0x80
> > > >[  149.468145][  T557] hardirqs last disabled at (45770): [<c114baed>] __up_console_sem+0x4d/0x80
> > > >[  149.468803][  T557] softirqs last  enabled at (41056): [<ef1037a0>] rcu_torture_pipe_update+0xe0/0x130 [rcutorture]
> > > >[  149.469602][  T557] softirqs last disabled at (41054): [<ef10377c>] rcu_torture_pipe_update+0xbc/0x130 [rcutorture]
> > > >[  149.470401][  T557] ---[ end trace 0000000000000000 ]---
> > > 
