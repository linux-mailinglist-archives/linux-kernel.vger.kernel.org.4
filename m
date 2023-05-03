Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057BF6F5C07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjECQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjECQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:30:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB67294
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:29:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-74de7182043so245333985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683131399; x=1685723399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoUQlCBwx+Zf/wjyYn1j/TJc4IiTO40VRjEHQBUDsf8=;
        b=ZTKJXjoIS0WBFE8cdpGaP+88Sbjl911ret5Dj8aD/J4N5OxmHiZZVQnG6wVAsHKzgq
         bXGtcsDwIEiiOSH8dy7sP29xys4k2zMrrStRALKm6sRC11LLSAOSPi3K7ag/L+/eQPUu
         MGb4vC/5QYbIzPDq3pdUfsYKQ3PlusU+unWCZBwO47GfFA3hMh4T8GIuJK5iE3mPCkE3
         ev7qiqkkE6EWgkUOzY5FspoHeBQGVdwRzOkgrM0bBNBdkVeOqhGGx9OMgbaVPhppGGzS
         CCQyO26ojHUuraS6pNeCiRPECo0g9QMBoPWMaLb9puPrY7QDyQnPc5wXtsIrtLtJ/SIf
         7p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131399; x=1685723399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoUQlCBwx+Zf/wjyYn1j/TJc4IiTO40VRjEHQBUDsf8=;
        b=I52CLkJjB/Vvvx0Q31nhGUNKVv/iypDPPQ94P+DEQGbNgoB3sz49pNxpIHX4QGjooT
         WyP9c0NjVae8FTKcRu8TG13eLAf3OykS5ObKsbM+EMmYrUJGRwz9vlCBfErncnh6KpBe
         l01TZcCkH4hOa9PoQeu0XVCEYfPSOc4YCPDI8FO/HdmgLiwxPRuZDjvQPgT4p4xEOQ4u
         XNTXG+K35eHKx5pTOc2ecLFEmu+tf2iwgFQdOFYqCdxvk+QTmm41f1RgvzSp5hjClPiH
         zF9m4YWbxzjQlWcBbH/VNFCSzHK54TQJc1KT9s0MFhZuo0yL2/FKyfc7O0szuctUkjpc
         owcA==
X-Gm-Message-State: AC+VfDzDb2WshO9HzXJXPXKto6m5FBlUPaEmwFqy4xdRAs9g5Ks2aMEy
        rFl9GicXp+7zEmF6yZOB/uOodw==
X-Google-Smtp-Source: ACHHUZ6Eujqq68yTj6MQ9ZrzBVTSxm+dMdJUGtKekPj6TJ+t+DEwYs3LR7e0JVdZOKeWck8FTZV4Eg==
X-Received: by 2002:a05:6214:407:b0:616:76c3:1223 with SMTP id z7-20020a056214040700b0061676c31223mr11931627qvx.38.1683131398837;
        Wed, 03 May 2023 09:29:58 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf50d000000b005dd8b9345besm10707895qvm.86.2023.05.03.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:29:58 -0700 (PDT)
Date:   Wed, 3 May 2023 12:29:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        surenb@google.com, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
Message-ID: <20230503162957.GE193380@cmpxchg.org>
References: <000000000000281ae805faa4844e@google.com>
 <20230503133253.GA1689514@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503133253.GA1689514@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 03:32:53PM +0200, Peter Zijlstra wrote:
> On Mon, May 01, 2023 at 09:43:02AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1113550c280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc65ccad523b604
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0827f43974813b74e6db
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com
> > 
> > Movable zone start for each node
> > Early memory node ranges
> >   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
> > Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
> > percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
> > Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
> > Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
> > Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
> > Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> > Built 1 zonelists, mobility grouping on.  Total pages: 520868
> > allocated 2097152 bytes of page_ext
> > mem auto-init: stack:off, heap alloc:on, heap free:off
> > software IO TLB: area num 2.
> > software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB)
> > Memory: 1952320K/2097152K available (24576K kernel code, 2362K rwdata, 8400K rodata, 2048K init, 867K bss, 128448K reserved, 16384K cma-reserved, 524288K highmem)
> > SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> > trace event string verifier disabled
> > rcu: Preemptible hierarchical RCU implementation.
> > rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
> > rcu: 	RCU callback double-/use-after-free debug is enabled.
> > 	All grace periods are expedited (rcu_expedited).
> > 	Trampoline variant of Tasks RCU enabled.
> > 	Tracing variant of Tasks RCU enabled.
> > rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> > rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> > NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> > GIC physical location is 0x2c001000
> > rcu: srcu_init: Setting srcu_struct sizes based on contention.
> > sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> > clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
> > arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> > clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
> > sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
> > Switching to timer-based delay loop, resolution 16ns
> > Console: colour dummy device 80x30
> > Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
> > pid_max: default: 32768 minimum: 301
> > LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,integrity
> > landlock: Up and running.
> > Yama: becoming mindful.
> > TOMOYO Linux initialized
> > SELinux:  Initializing.
> > LSM support for eBPF active
> > stackdepot: allocating hash table of 131072 entries via kvcalloc
> > Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> > Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
> > CPU: Testing write buffer coherency: ok
> > CPU0: Spectre BHB: enabling loop workaround for all CPUs
> > CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 0000001c when read
> > [0000001c] *pgd=80000080004003, *pmd=00000000
> > Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at psi_task_switch+0x1e0/0x204 kernel/sched/psi.c:940
> > LR is at psi_task_switch+0x190/0x204 kernel/sched/psi.c:932
> 
> Johannes, your commit 71dbdde7914d ("sched/psi: Remove NR_ONCPU task
> accounting") was the last to touch psi.c:640. Any ideas?

PC is at :940, which is the group->pcpu->state_mask derefs. It's a bit
hard to say without the Code line, but 0x1c looks like the group->pcpu
offset on 32 bit, so presumably group is NULL.

Is this reproducible with 6.1? And 6.0?

Looking through git, the most recent change to how the group is looked
up is in 6.1, dc86aba751e2 ("sched/psi: Cache parent psi_group to
speed up group iteration"). It does this:

-static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+static inline struct psi_group *task_psi_group(struct task_struct *task)
 {
-       if (*iter == &psi_system)
-               return NULL;
-
 #ifdef CONFIG_CGROUPS
-       if (static_branch_likely(&psi_cgroups_enabled)) {
-               struct cgroup *cgroup = NULL;
-
-               if (!*iter)
-                       cgroup = task->cgroups->dfl_cgrp;
-               else
-                       cgroup = cgroup_parent(*iter);
-
-               if (cgroup && cgroup_parent(cgroup)) {
-                       *iter = cgroup;
-                       return cgroup_psi(cgroup);
-               }
-       }
+       if (static_branch_likely(&psi_cgroups_enabled))
+               return cgroup_psi(task_dfl_cgroup(task));
 #endif
-       *iter = &psi_system;
        return &psi_system;
 }

Notably, it got rid of the if (cgroup) and now calls cgroup_psi()
unconditionally.

If this is easily reproducible, does the following fix it?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e072f6b31bf3..21268e67ae34 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -881,8 +881,11 @@ static void psi_group_change(struct psi_group *group, int cpu,
 static inline struct psi_group *task_psi_group(struct task_struct *task)
 {
 #ifdef CONFIG_CGROUPS
-       if (static_branch_likely(&psi_cgroups_enabled))
-               return cgroup_psi(task_dfl_cgroup(task));
+       if (static_branch_likely(&psi_cgroups_enabled)) {
+               struct cgroup *cgroup = task_dfl_cgroup(task);
+
+               if (cgroup)
+                       return cgroup_psi(cgroup);
 #endif
        return &psi_system;
 }

[remaining email quoted below for Chengming]

> > pc : [<802a3c58>]    lr : [<802a3c08>]    psr: a0000193
> > sp : 82601e70  ip : 5b923000  fp : 82601ebc
> > r10: 8261ae40  r9 : 00000001  r8 : 00000002
> > r7 : 1b5aa6f1  r6 : 00000000  r5 : 8260c964  r4 : 00000000
> > r3 : 826f6748  r2 : 8309d13c  r1 : 00000000  r0 : 00000000
> > Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > Control: 30c5387d  Table: 80003000  DAC: fffffffd
> > Register r0 information:
> > 8<--- cut here ---
> > Unable to handle kernel paging request at virtual address 00802158 when read
> > [00802158] *pgd=80000080004003, *pmd=00000000
> > Internal error: Oops: 206 [#2] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> > PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> > PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> > PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> > LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> > LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> > pc : [<80479e58>]    lr : [<81800154>]    psr: 20000193
> > sp : 82601cd8  ip : 82601cc0  fp : 82601cec
> > r10: 8261ae40  r9 : 8261c9a4  r8 : 8284f41c
> > r7 : 60000193  r6 : 00000001  r5 : 00000000  r4 : 00802160
> > r3 : f0830b42  r2 : 00001ef5  r1 : 00000000  r0 : 00000001
> > Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > Control: 30c5387d  Table: 80003000  DAC: fffffffd
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
