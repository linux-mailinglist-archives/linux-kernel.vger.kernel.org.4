Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9586F4072
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEBJxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 May 2023 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjEBJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:53:02 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2F54C1D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:52:57 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3294c5e1c03so56811125ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 02:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683021177; x=1685613177;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exaz0o1lSln1lUsylPPMvUAA9RmqL0AVBuQ21q+c7Bw=;
        b=M5i5KDzEQT2MKsrzLegMY02cF8lwyQ+LA10IpwZnL3yu/OckRdv1YENbLu7Exr/GQD
         Bu9DHvZhECEa2LC/iPyKRdagUQ/wcRPdCa21aYdg/Fn/rbe3EvqrD6TydhYU24ry4dWy
         MpXiNH8yh/YIxxTjlgOLL/yaXt9USApNhLfL/ve0epPpBWCSzm2hA1ZlnKfKjF+dhyok
         HlsmIK0n+0qdolkJmJBHKiuXe9MGJ/bbYEQGi5Jjp5BFaSqzmW6DP1HT/Ng9iGSSsFkl
         ghREIj7SkYHJbOIquU4q+WkfqRurYzdAVy+J1/LyWxUIQjDEwz9dhFpJ7xJWb0KkZNlz
         AGqg==
X-Gm-Message-State: AC+VfDwZpypvaGSiQJGBzClL/t0fuw+JzNKAS79UMFJxR/cM9BDaBSjA
        qci/HwA3L2PighbKdmHgtzVDxAbgyczMKI+idh/IAPIwGeTL
X-Google-Smtp-Source: ACHHUZ6r2Y0r3qDT7KjNYIkzj/IrFNdiS2X2PheeRfOr8ODMXvScMxfMdPFB2gmC6iA1bNcdoecP+sAbVozoU3Dpmzi+uxL5juiV
MIME-Version: 1.0
X-Received: by 2002:a92:c68f:0:b0:325:e315:f2bc with SMTP id
 o15-20020a92c68f000000b00325e315f2bcmr8508206ilg.3.1683021177094; Tue, 02 May
 2023 02:52:57 -0700 (PDT)
Date:   Tue, 02 May 2023 02:52:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690a0b05fab2e75c@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in gpiod_set_raw_value_commit
From:   syzbot <syzbot+691fcab418631dee8be3@syzkaller.appspotmail.com>
To:     brgl@bgdev.pl, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    865fdb08197e Merge tag 'input-for-v6.4-rc0' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149ab844280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d43eae746231feb3
dashboard link: https://syzkaller.appspot.com/bug?extid=691fcab418631dee8be3
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+691fcab418631dee8be3@syzkaller.appspotmail.com

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
Memory: 1952316K/2097152K available (24576K kernel code, 2364K rwdata, 8404K rodata, 2048K init, 868K bss, 128452K reserved, 16384K cma-reserved, 524288K highmem)
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
Unable to handle kernel paging request at virtual address 831b70d8 when execute
[831b70d8] *pgd=80000080006003, *pmd=4000008300071d(bad)
Internal error: Oops: 8000020e [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at 0x831b70d8
LR is at gpiod_set_raw_value_commit+0x4c/0x168 drivers/gpio/gpiolib.c:3030
pc : [<831b70d8>]    lr : [<80890618>]    psr: 40000113
sp : df85de90  ip : df85dec0  fp : df85debc
r10: 00000000  r9 : 827e16e6  r8 : 00000001
r7 : 831b7040  r6 : 00000001  r5 : 840b67bc  r4 : 00000003
r3 : 831b70d8  r2 : 00000001  r1 : 00000003  r0 : 831b7040
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 8470bd40  DAC: 00000000
Register r0 information: slab kmalloc-512 start 831b7000 pointer offset 64 size 512
Register r1 information: non-paged memory
Register r2 information: non-paged memory
Register r3 information: slab kmalloc-512 start 831b7000 pointer offset 216 size 512
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-192 start 840b6780 pointer offset 60 size 192
Register r6 information: non-paged memory
Register r7 information: slab kmalloc-512 start 831b7000 pointer offset 64 size 512
Register r8 information: non-paged memory
Register r9 information: non-slab/vmalloc memory
Register r10 information: NULL pointer
Register r11 information: non-paged memory
Register r12 information: non-paged memory
Process swapper/1 (pid: 0, stack limit = 0xdf85c000)
Stack: (0xdf85de90 to 0xdf85e000)
de80:                                     00000003 840b67bc 00000001 000000ff
dea0: ddde4798 00000001 827e16e6 00000000 df85decc df85dec0 80890ca8 808905d8
dec0: df85dee4 df85ded0 80891a3c 80890c60 8301daa8 000000ff df85defc df85dee8
dee0: 8107f408 808919f8 8301daa8 000000ff df85df0c df85df00 8107d838 8107f3b8
df00: df85df24 df85df10 8107db84 8107d80c 8301daa8 840ebb94 df85df44 df85df28
df20: 8107ea20 8107db2c 000001fd 8290cee4 00000002 ddde4798 df85df6c df85df48
df40: 8107fde8 8107e9f4 00000001 8260c498 831f4680 8260c4e0 00000000 827e16e6
df60: df85df7c df85df70 80208efc 8107fd44 df85dfc4 df85df80 80293568 80208ef4
df80: 8029e3c8 818015a4 81f860a0 824af2f8 5b935000 0f6c3d28 df85dfc4 00000097
dfa0: 00000001 831f4680 82850464 80003010 412fc0f1 00000000 df85dfd4 df85dfc8
dfc0: 80293af8 802934f8 df85dff4 df85dfd8 80210374 80293ae4 830e0a00 00000000
dfe0: 30c0387d 82850464 00000000 df85dff8 802016f4 80210254 00000000 00000000
Backtrace: 
[<808905cc>] (gpiod_set_raw_value_commit) from [<80890ca8>] (gpiod_set_value_nocheck+0x54/0x58 drivers/gpio/gpiolib.c:3204)
 r10:00000000 r9:827e16e6 r8:00000001 r7:ddde4798 r6:000000ff r5:00000001
 r4:840b67bc r3:00000003
[<80890c54>] (gpiod_set_value_nocheck) from [<80891a3c>] (gpiod_set_value+0x50/0xc0 drivers/gpio/gpiolib.c:3223)
[<808919ec>] (gpiod_set_value) from [<8107f408>] (gpio_led_set+0x5c/0x60 drivers/leds/leds-gpio.c:54)
 r5:000000ff r4:8301daa8
[<8107f3ac>] (gpio_led_set) from [<8107d838>] (__led_set_brightness drivers/leds/led-core.c:47 [inline])
[<8107f3ac>] (gpio_led_set) from [<8107d838>] (led_set_brightness_nopm drivers/leds/led-core.c:271 [inline])
[<8107f3ac>] (gpio_led_set) from [<8107d838>] (led_set_brightness_nosleep+0x38/0x5c drivers/leds/led-core.c:287)
 r5:000000ff r4:8301daa8
[<8107d800>] (led_set_brightness_nosleep) from [<8107db84>] (led_set_brightness+0x64/0x68 drivers/leds/led-core.c:264)
[<8107db20>] (led_set_brightness) from [<8107ea20>] (led_trigger_event drivers/leds/led-triggers.c:390 [inline])
[<8107db20>] (led_set_brightness) from [<8107ea20>] (led_trigger_event+0x38/0x50 drivers/leds/led-triggers.c:380)
 r5:840ebb94 r4:8301daa8
[<8107e9e8>] (led_trigger_event) from [<8107fde8>] (ledtrig_cpu+0xb0/0x100 drivers/leds/trigger/ledtrig-cpu.c:86)
 r7:ddde4798 r6:00000002 r5:8290cee4 r4:000001fd
[<8107fd38>] (ledtrig_cpu) from [<80208efc>] (arch_cpu_idle_exit+0x14/0x18 arch/arm/kernel/process.c:98)
 r9:827e16e6 r8:00000000 r7:8260c4e0 r6:831f4680 r5:8260c498 r4:00000001
[<80208ee8>] (arch_cpu_idle_exit) from [<80293568>] (do_idle+0x7c/0x2f0 kernel/sched/idle.c:284)
[<802934ec>] (do_idle) from [<80293af8>] (cpu_startup_entry+0x20/0x24 kernel/sched/idle.c:379)
 r10:00000000 r9:412fc0f1 r8:80003010 r7:82850464 r6:831f4680 r5:00000001
 r4:00000097
[<80293ad8>] (cpu_startup_entry) from [<80210374>] (secondary_start_kernel+0x12c/0x188 arch/arm/kernel/smp.c:482)
[<80210248>] (secondary_start_kernel) from [<802016f4>] (__enable_mmu+0x0/0xc arch/arm/kernel/head.S:438)
 r7:82850464 r6:30c0387d r5:00000000 r4:830e0a00
Code: 831b710c 831b70d8 80216664 802160d0 (00000000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	831b710c 	tsthi	fp, #12, 2
   4:	831b70d8 	tsthi	fp, #216	; 0xd8
   8:	80216664 	eorhi	r6, r1, r4, ror #12
   c:	802160d0 	ldrdhi	r6, [r1], -r0	; <UNPREDICTABLE>
* 10:	00000000 	andeq	r0, r0, r0 <-- trapping instruction


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
