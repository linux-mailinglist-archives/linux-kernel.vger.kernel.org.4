Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27636F591A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjECNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjECNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:33:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C406269D
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MgztlV5GDAw7CQPYwfM1JV9+N0Q3jYGEkU7JjEaWD7o=; b=Et38c53tboECWXrDn2IKsxUKaw
        vPEdwngsKDy3WMuNUxlrdiddDYgxZXNNgFmp7gCxu9pMTsgG6Md+8HxqOFlx0rNg7+DT7YhoVo7R2
        0uRzupgBhNRvC5BYiXWsQaCyul4+zyyRxPF2CUul9aqqJyISFa4skmPbh+0dTZsHWAdimm2BymR47
        uBNLx3q1MPF/Ftp3dYvVyDlO5Qq1pbt9EwiHquOF1KUKYk1HBJvne23M8a1iATCcDj/096zKK8Q05
        /iZQEoFycFvAkWIhNpcWHbn/0fvMXHSsQiFtx+/PzBexXNrTbTW6Bhvk6KJnIU0fdVCy3cczW63ci
        BpXt1mHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puCbH-009Zf1-T5; Wed, 03 May 2023 13:32:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19EED300635;
        Wed,  3 May 2023 15:32:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D01A2304AF5B2; Wed,  3 May 2023 15:32:53 +0200 (CEST)
Date:   Wed, 3 May 2023 15:32:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        rostedt@goodmis.org, surenb@google.com,
        syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org,
        vschneid@redhat.com
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
Message-ID: <20230503133253.GA1689514@hirez.programming.kicks-ass.net>
References: <000000000000281ae805faa4844e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000281ae805faa4844e@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 09:43:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1113550c280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc65ccad523b604
> dashboard link: https://syzkaller.appspot.com/bug?extid=0827f43974813b74e6db
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com
> 
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
> Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
> percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
> Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
> Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
> Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> Built 1 zonelists, mobility grouping on.  Total pages: 520868
> allocated 2097152 bytes of page_ext
> mem auto-init: stack:off, heap alloc:on, heap free:off
> software IO TLB: area num 2.
> software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB)
> Memory: 1952320K/2097152K available (24576K kernel code, 2362K rwdata, 8400K rodata, 2048K init, 867K bss, 128448K reserved, 16384K cma-reserved, 524288K highmem)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> trace event string verifier disabled
> rcu: Preemptible hierarchical RCU implementation.
> rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
> rcu: 	RCU callback double-/use-after-free debug is enabled.
> 	All grace periods are expedited (rcu_expedited).
> 	Trampoline variant of Tasks RCU enabled.
> 	Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> GIC physical location is 0x2c001000
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
> arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
> sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
> Switching to timer-based delay loop, resolution 16ns
> Console: colour dummy device 80x30
> Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
> pid_max: default: 32768 minimum: 301
> LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,integrity
> landlock: Up and running.
> Yama: becoming mindful.
> TOMOYO Linux initialized
> SELinux:  Initializing.
> LSM support for eBPF active
> stackdepot: allocating hash table of 131072 entries via kvcalloc
> Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> CPU: Testing write buffer coherency: ok
> CPU0: Spectre BHB: enabling loop workaround for all CPUs
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c when read
> [0000001c] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at psi_task_switch+0x1e0/0x204 kernel/sched/psi.c:940
> LR is at psi_task_switch+0x190/0x204 kernel/sched/psi.c:932

Johannes, your commit 71dbdde7914d ("sched/psi: Remove NR_ONCPU task
accounting") was the last to touch psi.c:640. Any ideas?

> pc : [<802a3c58>]    lr : [<802a3c08>]    psr: a0000193
> sp : 82601e70  ip : 5b923000  fp : 82601ebc
> r10: 8261ae40  r9 : 00000001  r8 : 00000002
> r7 : 1b5aa6f1  r6 : 00000000  r5 : 8260c964  r4 : 00000000
> r3 : 826f6748  r2 : 8309d13c  r1 : 00000000  r0 : 00000000
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> Register r0 information:
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address 00802158 when read
> [00802158] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 206 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> pc : [<80479e58>]    lr : [<81800154>]    psr: 20000193
> sp : 82601cd8  ip : 82601cc0  fp : 82601cec
> r10: 8261ae40  r9 : 8261c9a4  r8 : 8284f41c
> r7 : 60000193  r6 : 00000001  r5 : 00000000  r4 : 00802160
> r3 : f0830b42  r2 : 00001ef5  r1 : 00000000  r0 : 00000001
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
