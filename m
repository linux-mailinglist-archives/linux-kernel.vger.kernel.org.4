Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1E6F339D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjEAQnH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 May 2023 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEAQnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:43:05 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B8E58
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:43:03 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7638744ba8cso163804139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959382; x=1685551382;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEenIJauIMAGY3HMHxVT/vunQXlXGIGzHQZFgMgclkk=;
        b=KE9yI4Yc53q9ZQtTyFMpaxPP7TiUDpfEbN4cUX/JnMGX+dQvSc8hcl5Cg9DFZQ395g
         lxjHXwNcbbWEXVPK/WE9OE/u7EphgeeJYD8pD4XL1IQ14STcPCyMSXYmnP+vSvye7baY
         HzcsjLoZNYDEuijc58QW8n43BnUHtDdc/0rgHIf0VCRzgFVsuzt+x07sBFTOekKJ/pqi
         /1P5q6/OC2uYWZsO3TjKmScDDQD1oazAD0gm5mQz73+RWPHwuFmQO9ivNmzQTcbsunot
         g+zl+KeFT4pzqmStaS53aithwqnxqoH+iuuZsb9jynIbrjhji/dV+DRJhpL0nNS8vnld
         x0rQ==
X-Gm-Message-State: AC+VfDwaBhdu97035yB1cRUKdbK+/7h4BA0dLq5hAAn9R0klJPkdUgYE
        N6+XlUCl+CWllgcExuv0dLraT2zd8/hITFazZo7fza87hTp6
X-Google-Smtp-Source: ACHHUZ5H+dQBRnG2cj6yfaeLSBfEVq8IGIIdryufsZLEH9rMB1lEW1ftKVAmzsP4UDb6jGNIKS6eCryKKlolY6Jo0LYVDWve0bj+
MIME-Version: 1.0
X-Received: by 2002:a02:6f0d:0:b0:40f:9859:1fa3 with SMTP id
 x13-20020a026f0d000000b0040f98591fa3mr5959455jab.2.1682959382353; Mon, 01 May
 2023 09:43:02 -0700 (PDT)
Date:   Mon, 01 May 2023 09:43:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000281ae805faa4844e@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
From:   syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>
To:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, surenb@google.com,
        syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1113550c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc65ccad523b604
dashboard link: https://syzkaller.appspot.com/bug?extid=0827f43974813b74e6db
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com

Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000ffffffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 520868
allocated 2097152 bytes of page_ext
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB)
Memory: 1952320K/2097152K available (24576K kernel code, 2362K rwdata, 8400K rodata, 2048K init, 867K bss, 128448K reserved, 16384K cma-reserved, 524288K highmem)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
trace event string verifier disabled
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug is enabled.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
GIC physical location is 0x2c001000
rcu: srcu_init: Setting srcu_struct sizes based on contention.
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
arch_timer: cp15 timer(s) running at 62.50MHz (virt).
clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
Switching to timer-based delay loop, resolution 16ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,integrity
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
SELinux:  Initializing.
LSM support for eBPF active
stackdepot: allocating hash table of 131072 entries via kvcalloc
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre BHB: enabling loop workaround for all CPUs
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000001c when read
[0000001c] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at psi_task_switch+0x1e0/0x204 kernel/sched/psi.c:940
LR is at psi_task_switch+0x190/0x204 kernel/sched/psi.c:932
pc : [<802a3c58>]    lr : [<802a3c08>]    psr: a0000193
sp : 82601e70  ip : 5b923000  fp : 82601ebc
r10: 8261ae40  r9 : 00000001  r8 : 00000002
r7 : 1b5aa6f1  r6 : 00000000  r5 : 8260c964  r4 : 00000000
r3 : 826f6748  r2 : 8309d13c  r1 : 00000000  r0 : 00000000
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 80003000  DAC: fffffffd
Register r0 information:
8<--- cut here ---
Unable to handle kernel paging request at virtual address 00802158 when read
[00802158] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2623 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<80479e58>]    lr : [<81800154>]    psr: 20000193
sp : 82601cd8  ip : 82601cc0  fp : 82601cec
r10: 8261ae40  r9 : 8261c9a4  r8 : 8284f41c
r7 : 60000193  r6 : 00000001  r5 : 00000000  r4 : 00802160
r3 : f0830b42  r2 : 00001ef5  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 80003000  DAC: fffffffd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
