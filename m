Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15363F4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiLAQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiLAQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:12:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BCD1D31D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:12:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5E72B1FD66;
        Thu,  1 Dec 2022 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669911165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6k3fJBXZzAlIahGng2dT6k/IYnjOEJLnM/G+zSQpEk=;
        b=Vsl0DI6/m4isJ6dyBZYp+JkMAcUHdCXZSmhqntsLF8BuB78bKCYFFkNeAftKJN5Vwldcpf
        VcMcD3VmwxDbU3pSOIJT4FXBelP/PhsSAYlzCrksQmTQlhl2IlnMxCjzah68yfMRpqlDDt
        vkP2r8+/QEyd3HCn79KKAATE4dHxDRg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D1B72C141;
        Thu,  1 Dec 2022 16:12:44 +0000 (UTC)
Date:   Thu, 1 Dec 2022 17:12:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Liu, Yujie" <yujie.liu@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next:master] [printk] 8bdbdd7f43:
 BUG:scheduling_while_atomic
Message-ID: <Y4jSfGxkP3HoOU75@alley>
References: <202211302358.ef0db537-yujie.liu@intel.com>
 <PH0PR11MB58800C1C971387611633DA7EDA149@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58800C1C971387611633DA7EDA149@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-12-01 05:27:13, Zhang, Qiang1 wrote:
> Greeting,
> 
> FYI, we noticed BUG:scheduling_while_atomic due to commit (built with clang-14):
> 
> commit: 8bdbdd7f43cd74c7faca6add8a62d541503ae21d ("printk: Prepare for SRCU console list protection")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [    8.561823][    T0] BUG: scheduling while atomic: swapper/0/0x00000002
> [    8.569154][    T0] no locks held by swapper/0.
> [    8.571934][    T0] Modules linked in:
> [    8.573001][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
> [    8.576740][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    8.579942][    T0] Call Trace:
> [    8.581143][    T0]  <TASK>
> [ 8.582054][ T0] dump_stack_lvl (??:?) 
> [ 8.583312][ T0] ? netdev_notice (??:?) 
> [ 8.584753][ T0] ? lockdep_print_held_locks (lockdep.c:?) 
> [ 8.586563][ T0] __schedule_bug (core.c:?) 
> [ 8.588171][ T0] ? trace_sched_switch (core.c:?) 
> [ 8.589753][ T0] ? save_trace (lockdep.c:?) 
> [ 8.591135][ T0] schedule_debug (core.c:?) 
> [ 8.592582][ T0] __schedule (core.c:?) 
> [ 8.593902][ T0] ? __sched_text_start (core.c:?) 
> [ 8.595356][ T0] ? add_chain_block (lockdep.c:?) 
> [ 8.596847][ T0] ? find_held_lock (lockdep.c:?) 
> [ 8.598368][ T0] schedule (??:?) 
> [ 8.599564][ T0] schedule_timeout (??:?) 
> [ 8.600937][ T0] ? console_conditional_schedule (??:?) 
> [ 8.602773][ T0] do_wait_for_common (build_utility.c:?) 
> [ 8.604522][ T0] ? console_conditional_schedule (??:?) 
> [ 8.606462][ T0] ? bit_wait_io_timeout (build_utility.c:?) 
> [ 8.608196][ T0] ? _raw_spin_lock_irq (??:?) 
> [ 8.609935][ T0] ? lockdep_hardirqs_on (??:?) 
> [ 8.611646][ T0] wait_for_completion (??:?) 
> [ 8.613253][ T0] synchronize_srcu (??:?) 

Hmm, I do not understand it. It seems that this is called
in normal context. There was console_unlock() right
before synchronize_srcu(). It means that we took
semaphore in the same context.

Also all the calls above looks correct. wait_for_completion()
seems to be called in normal context as well.

Best Regards,
Petr

> [ 8.614825][ T0] ? srcu_gp_start_if_needed (??:?) 
> [ 8.616664][ T0] ? rcu_read_lock_any_held (??:?) 
> [ 8.618281][ T0] ? console_trylock_spinning (??:?) 
> [ 8.620181][ T0] unregister_console (??:?) 
> [ 8.621875][ T0] register_console (??:?) 
> [ 8.623401][ T0] ? serial8250_isa_init_ports (8250_core.c:?) 
> [ 8.625281][ T0] ? parse_options (super.c:?) 
> [ 8.626887][ T0] univ8250_console_init (8250_core.c:?) 
> [ 8.628583][ T0] console_init (??:?) 
> [ 8.630025][ T0] start_kernel (??:?) 
> [ 8.631558][ T0] secondary_startup_64_no_verify (??:?) 
> [    8.633502][    T0]  </TASK>
> [    8.634624][    T0] ------------[ cut here ]------------
> [    8.636289][    T0] releasing a pinned lock
> [ 8.638693][ T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5352 lock_release (??:?) 
> [    8.641591][    T0] Modules linked in:
> [    8.642864][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
> [    8.646469][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [ 8.649578][ T0] RIP: 0010:lock_release (??:?) 
> [ 8.651243][ T0] Code: 00 00 e9 0f fe ff ff 48 83 05 06 f6 ff 06 01 e8 91 4e 2d 03 e9 67 fe ff ff 48 c7 c7 20 8c cf 84 e8 90 3f ec ff 48 8b 54 24 08 <0f> 0b 48 83 05 a9 f6 ff 06 01 e9 66 fc ff ff e8 67 c9 99 01 85 c0
> All code
> ========
>    0:	00 00                	add    %al,(%rax)
>    2:	e9 0f fe ff ff       	jmpq   0xfffffffffffffe16
>    7:	48 83 05 06 f6 ff 06 	addq   $0x1,0x6fff606(%rip)        # 0x6fff615
>    e:	01 
>    f:	e8 91 4e 2d 03       	callq  0x32d4ea5
>   14:	e9 67 fe ff ff       	jmpq   0xfffffffffffffe80
>   19:	48 c7 c7 20 8c cf 84 	mov    $0xffffffff84cf8c20,%rdi
>   20:	e8 90 3f ec ff       	callq  0xffffffffffec3fb5
>   25:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	48 83 05 a9 f6 ff 06 	addq   $0x1,0x6fff6a9(%rip)        # 0x6fff6dd
>   33:	01 
>   34:	e9 66 fc ff ff       	jmpq   0xfffffffffffffc9f
>   39:	e8 67 c9 99 01       	callq  0x199c9a5
>   3e:	85 c0                	test   %eax,%eax
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	48 83 05 a9 f6 ff 06 	addq   $0x1,0x6fff6a9(%rip)        # 0x6fff6b3
>    9:	01 
>    a:	e9 66 fc ff ff       	jmpq   0xfffffffffffffc75
>    f:	e8 67 c9 99 01       	callq  0x199c97b
>   14:	85 c0                	test   %eax,%eax
> [    8.656638][    T0] RSP: 0000:ffffffff862077c0 EFLAGS: 00010086
> [    8.658249][    T0] RAX: 0000000000000017 RBX: ffffffff86244244 RCX: ffffffff8631a420
> [    8.660383][    T0] RDX: ffffffff86244218 RSI: 0000000000000008 RDI: 0000000000000001
> [    8.662798][    T0] RBP: ffffffff862078e0 R08: dffffc0000000000 R09: 00000000035545d9
> [    8.665205][    T0] R10: dffff7fff0c40e7a R11: 0000000000000001 R12: ffffffff862fcf58
> [    8.667420][    T0] R13: 1ffffffff0c40f06 R14: ffffffff86244220 R15: dffffc0000000000
> [    8.669824][    T0] FS:  0000000000000000(0000) GS:ffffffff862ab000(0000) knlGS:0000000000000000
> [    8.672552][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.674557][    T0] CR2: ffff88843ffff000 CR3: 0000000006235000 CR4: 00000000000406b0
> [    8.677082][    T0] Call Trace:
> [    8.678220][    T0]  <TASK>
> [ 8.679230][ T0] ? __lock_acquire (??:?) 
> [ 8.680709][ T0] ? kvm_sched_clock_read (kvmclock.c:?) 
> [ 8.682309][ T0] ? sched_clock_cpu (??:?) 
> [ 8.683854][ T0] ? kvm_sched_clock_read (kvmclock.c:?) 
> [ 8.685268][ T0] _raw_spin_unlock (??:?) 
> [ 8.686730][ T0] dequeue_task_idle (build_policy.c:?) 
> [ 8.688259][ T0] ? set_next_task_idle (build_policy.c:?) 
> [ 8.689822][ T0] ? update_rq_clock (??:?) 
> [ 8.691387][ T0] __schedule (core.c:?) 
> [ 8.692782][ T0] ? __sched_text_start (core.c:?) 
> [ 8.694287][ T0] ? add_chain_block (lockdep.c:?) 
> [ 8.695869][ T0] ? find_held_lock (lockdep.c:?) 
> [ 8.697314][ T0] schedule (??:?) 
> [ 8.698529][ T0] schedule_timeout (??:?) 
> [ 8.701929][ T0] ? console_conditional_schedule (??:?) 
> [ 8.703826][ T0] do_wait_for_common (build_utility.c:?) 
> [ 8.705395][ T0] ? console_conditional_schedule (??:?) 
> [ 8.707189][ T0] ? bit_wait_io_timeout (build_utility.c:?) 
> [ 8.708779][ T0] ? _raw_spin_lock_irq (??:?) 
> [ 8.710371][ T0] ? lockdep_hardirqs_on (??:?) 
> [ 8.711982][ T0] wait_for_completion (??:?) 
> [ 8.713487][ T0] synchronize_srcu (??:?) 
> [ 8.715020][ T0] ? srcu_gp_start_if_needed (??:?) 
> [ 8.716772][ T0] ? rcu_read_lock_any_held (??:?) 
> [ 8.718477][ T0] ? console_trylock_spinning (??:?) 
> [ 8.720179][ T0] unregister_console (??:?) 
> [ 8.721644][ T0] register_console (??:?) 
> [ 8.728846][ T0] ? serial8250_isa_init_ports (8250_core.c:?) 
> [ 8.730692][ T0] ? parse_options (super.c:?) 
> [ 8.732180][ T0] univ8250_console_init (8250_core.c:?) 
> [ 8.733762][ T0] console_init (??:?) 
> [ 8.735096][ T0] start_kernel (??:?) 
> [ 8.736425][ T0] secondary_startup_64_no_verify (??:?) 
> [    8.738088][    T0]  </TASK>
> [    8.739057][    T0] irq event stamp: 494
> [ 8.740376][ T0] hardirqs last enabled at (493): dump_stack_lvl (??:?) 
> [ 8.743081][ T0] hardirqs last disabled at (494): __schedule (core.c:?) 
> [ 8.745797][ T0] softirqs last enabled at (0): 0x0 
> [ 8.747882][ T0] softirqs last disabled at (0): 0x0 
> [    8.749889][    T0] ---[ end trace 0000000000000000 ]---
> [    8.751520][    T0] bad: scheduling from the idle thread!
> [    8.753351][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
> [    8.757566][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    8.760783][    T0] Call Trace:
> [    8.761970][    T0]  <TASK>
> [ 8.763067][ T0] dump_stack_lvl (??:?) 
> [ 8.764611][ T0] ? netdev_notice (??:?) 
> [ 8.766213][ T0] ? lockdep_hardirqs_on_prepare (??:?) 
> [ 8.768214][ T0] ? print_irqtrace_events (??:?) 
> [ 8.769911][ T0] ? kvm_sched_clock_read (kvmclock.c:?) 
> [ 8.771550][ T0] dequeue_task_idle (build_policy.c:?) 
> [ 8.773087][ T0] ? set_next_task_idle (build_policy.c:?) 
> [ 8.774647][ T0] ? update_rq_clock (??:?) 
> [ 8.776280][ T0] __schedule (core.c:?) 
> [ 8.777729][ T0] ? __sched_text_start (core.c:?) 
> [ 8.779238][ T0] ? add_chain_block (lockdep.c:?) 
> [ 8.780922][ T0] ? find_held_lock (lockdep.c:?) 
> [ 8.782560][ T0] schedule (??:?) 
> [ 8.783988][ T0] schedule_timeout (??:?) 
> [ 8.785515][ T0] ? console_conditional_schedule (??:?) 
> [ 8.787500][ T0] do_wait_for_common (build_utility.c:?) 
> [ 8.789162][ T0] ? console_conditional_schedule (??:?) 
> [ 8.790997][ T0] ? bit_wait_io_timeout (build_utility.c:?) 
> [ 8.792567][ T0] ? _raw_spin_lock_irq (??:?) 
> [ 8.794292][ T0] ? lockdep_hardirqs_on (??:?) 
> [ 8.796008][ T0] wait_for_completion (??:?) 
> [ 8.797520][ T0] synchronize_srcu (??:?) 
> [ 8.799001][ T0] ? srcu_gp_start_if_needed (??:?) 
> [ 8.800696][ T0] ? rcu_read_lock_any_held (??:?) 
> [ 8.802508][ T0] ? console_trylock_spinning (??:?) 
> [ 8.804316][ T0] unregister_console (??:?) 
> [ 8.805810][ T0] register_console (??:?) 
> [ 8.807364][ T0] ? serial8250_isa_init_ports (8250_core.c:?) 
> [ 8.811167][ T0] ? parse_options (super.c:?) 
> [ 8.812693][ T0] univ8250_console_init (8250_core.c:?) 
> [ 8.814269][ T0] console_init (??:?) 
> [ 8.815765][ T0] start_kernel (??:?) 
> [ 8.817296][ T0] secondary_startup_64_no_verify (??:?) 
> [    8.819246][    T0]  </TASK>
> 
> 
> 
> Through the config file, it can be found that the following options are enabled
> 
> CONFIG_TINY_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TINY_SRCU=y
> 
> This problem should have been fixed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0bf43fcbf8ebbf84a2b1b8770eaefcdb4a99afd6
> 
> commit dbc6ca150842650d513705f26e3e6b7a4e182ce9
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Wed Nov 9 15:36:38 2022 +0800
> 
>     srcu: Make Tiny synchronize_srcu() check for readers
> 
>     This commit adds lockdep checks for illegal use of synchronize_srcu()
>     within same-type SRCU read-side critical sections and within normal
>     RCU read-side critical sections.  It also makes synchronize_srcu()
>     be a no-op during early boot.
> 
>     These changes bring Tiny synchronize_srcu() into line with both Tree
>     synchronize_srcu() and Tiny synchronize_rcu().
> 
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> 
> Thanks
> Zqiang
> 
> 
> 
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202211302358.ef0db537-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-6.1.0-rc1-00015-g8bdbdd7f43cd .config
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
