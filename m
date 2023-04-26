Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A26EEE71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjDZGir convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbjDZGip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:38:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67897A9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:38:44 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760d7046e89so1068670139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682491123; x=1685083123;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE7OycQUlG0tVy79xGjrI932c1y8C0+9h6kD2l7mlLg=;
        b=UzAjxvzaBphUotf39ykAJedFJ0FXVNiSr76Kub90GxAlKxKQGrYJmIJFNY9NXXN+2E
         TVPacXC6BVsh4KxKNrnWtacaT9Ztm2dKQCdhsZD8iZUtbIXTqf+1bdi0MAEtQcaVMw+B
         omXUHoWZTl0HvSssZxNKSF7u0PhusTjMR4KPgqrG5ny1DUjgSs0Y4UOZIExWbw5ly9FY
         Ka5L7uoXoj2+PL6hF73dhyL5hNUwk04Zq+WN5wEc370bbr9xP0tXku9LFi2Vug5yhyxc
         uopfX2FdY99iLXV3NPg7yllg0Cltovd7RGSCaRMzB92efy3LyBq1Tvie49VFRQhpCdWo
         6l4g==
X-Gm-Message-State: AAQBX9deUwwKm2buLEDCd2lUqnLR1zYRmaJnIXHy0Y1wrvcGylMX5FnY
        8TmEzBPfeAdpUoJHk81SbXjM8Koa1YxAx6MM83MKZKsBkZ/K
X-Google-Smtp-Source: AKy350bmiIcTLW83RppC9tiy8/lxBj2IPGXjgT/o578mCNJPdk6eDSRGMznFkZuJOm9FNNtCf8fxMJPd6VO0lk8FBm10wszBloSf
MIME-Version: 1.0
X-Received: by 2002:a5d:8855:0:b0:760:ecb4:a77c with SMTP id
 t21-20020a5d8855000000b00760ecb4a77cmr8376893ios.2.1682491123780; Tue, 25 Apr
 2023 23:38:43 -0700 (PDT)
Date:   Tue, 25 Apr 2023 23:38:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c553e805fa377df8@google.com>
Subject: [syzbot] upstream boot error: Internal error in __dabt_svc
From:   syzbot <syzbot+9e79a8560c1bfbab7a47@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0cfd8703e7da Merge tag 'pm-6.4-rc1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171209d7c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c5db63fc076f807
dashboard link: https://syzkaller.appspot.com/bug?extid=9e79a8560c1bfbab7a47
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e79a8560c1bfbab7a47@syzkaller.appspotmail.com

Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
percpu: Embedded 18 pages/cpu s44168 r8192 d21368 u73728
Built 1 zonelists, mobility grouping on.  Total pages: 520868
Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
allocated 2097152 bytes of page_ext
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000d9a49000-0x00000000dda49000] (64MB)
Memory: 1954384K/2097152K available (22528K kernel code, 2354K rwdata, 8344K rodata, 2048K init, 865K bss, 126384K reserved, 16384K cma-reserved, 524288K highmem)
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
Insufficient stack space to handle exception!
Task stack:     [0xdf85c000..0xdf85e000]
IRQ stack:      [0xdf804000..0xdf806000]
Overflow stack: [0x828ae000..0x828af000]
Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __dabt_svc+0x14/0x60 arch/arm/kernel/entry-armv.S:210
LR is at call_with_stack+0x1c/0x20 arch/arm/lib/call_with_stack.S:40
pc : [<80200a74>]    lr : [<817864ec>]    psr: 00000193
sp : df804020  ip : df806000  fp : df85df14
r10: 825dfae1  r9 : 828f3980  r8 : 00000000
r7 : df85df4c  r6 : ffffffff  r5 : 20000113  r4 : 817d2898
r3 : df000000  r2 : 817d12b8  r1 : df85df18  r0 : 8264d250
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 80003000  DAC: 00000000
Register r0 information:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
[000001ff] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2571 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8046b3b0>]    lr : [<817dcf14>]    psr: 20000193
sp : 828aeef8  ip : 828aeee0  fp : 828aef0c
r10: 828f3980  r9 : 8241c964  r8 : 8264d41c
r7 : 60000193  r6 : 00000001  r5 : 8264e000  r4 : 00000207
r3 : 80216bd4  r2 : 00001f03  r1 : 00000000  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 80003000  DAC: 00000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
