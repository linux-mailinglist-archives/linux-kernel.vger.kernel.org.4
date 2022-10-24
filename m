Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA2609AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJXGzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:55:40 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F750066
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:55:39 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id u2-20020a056e021a4200b002f9ecfa353cso8317305ilv.20
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuHNia7p7N3sqvLTsp09LHkZ63PUJaGMh6REVrvmcmU=;
        b=D1sMd3ptJsSj/3diWguven/8W3KWCC+DloCmadQDi6tvEeKzRafu7A8Ag6o6WFAcev
         rjB+Moqah34ItQIbT7f5vCZgWy2KbmONK4b6t66MXU7NvIUzekex1s5cDd8ALipWohxo
         jimk3JYJqO6U3aV5dj5E5l5VuokcwWeak7o14ISgnleis7uk/fQKDEkuyeAeFuMYg/7x
         AQEEyC7rOeAs+dnpWIMctXqHwbxostGDfkR4Jw8o3BnLkKr5pLb/xIeDgXWqMGVVB4wr
         gDSJHw47/4N09vkc6EWLHesmUdNYbEee+v8Fd+BpbM50MID1fhSdI6S1USncxGQ01zzP
         WPVQ==
X-Gm-Message-State: ACrzQf3cH1l3umUa9gqTsyYRiCZu9CNjIGAelOvaO8beLpJZgTdHcVeP
        J6e44h/2ugk1S5zT2a3IyjzrZiqPjH9yFNwZPIr2tbYMWp3D
X-Google-Smtp-Source: AMsMyM40Nt77JAlX8tx8pDq5dh92Vk07e/yfq/X3M4fg1AvlWbsq5hN4XQ4NoiqzG9e/vUMvhoIpMjw1mlwcF+jeDYdRGcWUXa0p
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e0d:b0:6a3:74ab:f114 with SMTP id
 o13-20020a0566022e0d00b006a374abf114mr18690237iow.200.1666594538788; Sun, 23
 Oct 2022 23:55:38 -0700 (PDT)
Date:   Sun, 23 Oct 2022 23:55:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007820af05ebc2477a@google.com>
Subject: [syzbot] inconsistent lock state in try_to_wake_up
From:   syzbot <syzbot+9d232b8025fff95ea41e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=127ad626880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=9d232b8025fff95ea41e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d232b8025fff95ea41e@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/1/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff00011a938948 (kn->active#5){+.?.}-{0:0}, at: try_to_wake_up+0x5c/0x514 kernel/sched/core.c:4082
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
  kernfs_drain fs/kernfs/dir.c:478 [inline]
  __kernfs_remove+0x514/0x7d8 fs/kernfs/dir.c:1386
  kernfs_remove_by_name_ns+0x68/0xb8 fs/kernfs/dir.c:1589
  kernfs_remove_by_name include/linux/kernfs.h:615 [inline]
  remove_files fs/sysfs/group.c:28 [inline]
  sysfs_remove_group+0x68/0x160 fs/sysfs/group.c:288
  sysfs_remove_groups+0x3c/0x78 fs/sysfs/group.c:312
  driver_remove_groups+0x28/0x38 drivers/base/driver.c:211
  bus_remove_driver+0x7c/0x110 drivers/base/bus.c:673
  driver_unregister+0x3c/0x6c drivers/base/driver.c:274
  pci_unregister_driver+0x28/0xc4 drivers/pci/pci-driver.c:1452
  ipmi_si_pci_shutdown+0x2c/0x40 drivers/char/ipmi/ipmi_si_pci.c:159
  cleanup_ipmi_si+0x2c/0x10c drivers/char/ipmi/ipmi_si_intf.c:2272
  init_ipmi_si+0x2bc/0x2d0 drivers/char/ipmi/ipmi_si_intf.c:2146
  do_one_initcall+0x118/0x22c init/main.c:1296
  do_initcall_level+0xac/0xe4 init/main.c:1369
  do_initcalls+0x58/0xa8 init/main.c:1385
  do_basic_setup+0x20/0x2c init/main.c:1404
  kernel_init_freeable+0xb8/0x148 init/main.c:1623
  kernel_init+0x24/0x290 init/main.c:1512
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 2262087
hardirqs last  enabled at (2262086): [<ffff80000bfc8a34>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (2262086): [<ffff80000bfc8a34>] _raw_spin_unlock_irq+0x3c/0x70 kernel/locking/spinlock.c:202
hardirqs last disabled at (2262087): [<ffff80000bfc87f0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (2262087): [<ffff80000bfc87f0>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (2262028): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (2262083): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(kn->active#5);
  <Interrupt>
    lock(kn->active#5);

 *** DEADLOCK ***

1 lock held by swapper/1/0:
 #0: ffff80000800be20 ((&sci->sc_timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #0: ffff80000800be20 ((&sci->sc_timer)){+.-.}-{0:0}, at: call_timer_fn+0x54/0x144 kernel/time/timer.c:1464

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_usage_bug+0x39c/0x3cc kernel/locking/lockdep.c:3961
 mark_lock_irq+0x4a8/0x4b4
 mark_lock+0x154/0x1b4 kernel/locking/lockdep.c:4632
 __lock_acquire+0x5a0/0x30a4 kernel/locking/lockdep.c:5007
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
 try_to_wake_up+0x5c/0x514 kernel/sched/core.c:4082
 wake_up_process+0x18/0x24 kernel/sched/core.c:4314
 nilfs_construction_timeout+0x20/0x30 fs/nilfs2/segment.c:2403
 call_timer_fn+0x90/0x144 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers+0x280/0x374 kernel/time/timer.c:1790
 run_timer_softirq+0x34/0x5c kernel/time/timer.c:1803
 _stext+0x168/0x37c
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:84
 invoke_softirq+0x70/0xbc kernel/softirq.c:452
 __irq_exit_rcu+0xf0/0x140 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x40 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
 el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:485
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:490
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 arch_local_irq_enable+0xc/0x18 arch/arm64/include/asm/irqflags.h:35
 default_idle_call+0x48/0xb8 kernel/sched/idle.c:109
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x108/0x2d8 kernel/sched/idle.c:303
 cpu_startup_entry+0x24/0x28 kernel/sched/idle.c:400
 secondary_start_kernel+0x154/0x17c arch/arm64/kernel/smp.c:265
 __secondary_switched+0xb0/0xb4 arch/arm64/kernel/head.S:618


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
