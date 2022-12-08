Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B732B646C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLHKUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:20:40 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B854342
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:20:38 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id n8-20020a6b4108000000b006de520dc5c9so455203ioa.19
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZgyOJFt4a/hq7dvcwj5dQss66jbQNMqBg0yyyfms1E=;
        b=8NOJNEdL98AkEtxvqVGoqMN4CTgE7Ys+OhH2VsrmXKA5wCyqt9QcZXMIeQKF18RWAK
         x0qxzuOO+uS7a0bJsqUlZz+QM2sQWQthkghYg+/XjDiqB0i2RZASwEZrRCWvHV8vP+VB
         K1oyTCA6SKogtIjuf/1GBih4lwKxVOnASrNFrjSvlhC+oKfVpBc49b3+WPCwm+7lUsEw
         QcirUUZb6KlQYYP/qMOhd9fEsQrz10v7RosmBPkrX59BNovbBf2G2ezXT/mvsKxSbw/Z
         gD5WeFYMghbSZ5p2ZUWpe+FkJIwVAs28THiuo079lDyNhUGYRTxCxmUA6tQ/JeED6Cyf
         k7kA==
X-Gm-Message-State: ANoB5pkklJz3DIOgdj6j1Zieydes93215O/xT3gRZwJJ/DOdAB9uzqbo
        8NZ0QEKwqg4AItI9pY3V5h4mT1Mrn9scjdNQ3QjkE3sWEOIo
X-Google-Smtp-Source: AA0mqf49PdXRfW/3ZSkffkZcQhKMnWM7crWhxzWMxw2EHi+YdFAfnx3mSmd34XUlnCPGvRy3Lt0Y+hF2BSzMvQp85HxIBpndt0j3
MIME-Version: 1.0
X-Received: by 2002:a02:a696:0:b0:363:3937:d400 with SMTP id
 j22-20020a02a696000000b003633937d400mr45350921jam.309.1670494838061; Thu, 08
 Dec 2022 02:20:38 -0800 (PST)
Date:   Thu, 08 Dec 2022 02:20:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c070d05ef4e6390@google.com>
Subject: [syzbot] BUG: soft lockup in raw_release
From:   syzbot <syzbot+a423b9f133129c59074f@syzkaller.appspotmail.com>
To:     ben-linux@fluff.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        rdunlap@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        suravee.suthikulpanit@amd.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    00988f70a076 Merge tag 'usb-serial-6.0-rc8' of https://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1481f4c8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e30614d9e005c5
dashboard link: https://syzkaller.appspot.com/bug?extid=a423b9f133129c59074f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c72c6e0f8f46/disk-00988f70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1055dd064236/vmlinux-00988f70.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a423b9f133129c59074f@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 143s! [syz-executor.1:6679]
Modules linked in:
irq event stamp: 77514
hardirqs last  enabled at (77513): [<ffffffff811134bd>] kvm_wait arch/x86/kernel/kvm.c:1066 [inline]
hardirqs last  enabled at (77513): [<ffffffff811134bd>] kvm_wait+0x8d/0x100 arch/x86/kernel/kvm.c:1048
hardirqs last disabled at (77514): [<ffffffff85f4269b>] sysvec_apic_timer_interrupt+0xb/0xc0 arch/x86/kernel/apic/apic.c:1106
softirqs last  enabled at (69722): [<ffffffff8116a4f3>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (69722): [<ffffffff8116a4f3>] __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650
softirqs last disabled at (69601): [<ffffffff8116a4f3>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (69601): [<ffffffff8116a4f3>] __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650
CPU: 1 PID: 6679 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:kvm_wait+0x98/0x100 arch/x86/kernel/kvm.c:1070
Code: fa 83 e2 07 38 d0 7f 04 84 c0 75 63 0f b6 07 40 38 c6 74 35 48 83 c4 10 c3 c3 e8 03 44 3b 00 66 90 0f 00 2d ba 52 34 05 fb f4 <48> 83 c4 10 c3 89 74 24 0c 48 89 3c 24 e8 d6 42 3b 00 8b 74 24 0c
RSP: 0018:ffffc9000f23fa50 EFLAGS: 00000246

RAX: 0000000000012ec9 RBX: 0000000000000000 RCX: 1ffffffff16100de
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff87c05ca0 R08: 0000000000000001 R09: ffffffff8b07b6cf
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: fffffbfff0f80b94 R14: 0000000000000001 R15: ffff8881f6938880
FS:  00007fc597af7700(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5984a50b0 CR3: 000000010ca08000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pv_wait arch/x86/include/asm/paravirt.h:603 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8c7/0xb50 kernel/locking/qspinlock.c:511
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:349 [inline]
 kernfs_put.part.0+0x269/0x540 fs/kernfs/dir.c:544
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:521
 __kernfs_remove+0x7a6/0xb50 fs/kernfs/dir.c:1407
 kernfs_remove_by_name_ns+0xa8/0x110 fs/kernfs/dir.c:1589
 sysfs_remove_file include/linux/sysfs.h:629 [inline]
 driver_remove_file drivers/base/driver.c:198 [inline]
 driver_remove_file+0x46/0x60 drivers/base/driver.c:194
 remove_bind_files drivers/base/bus.c:548 [inline]
 bus_remove_driver+0x22a/0x300 drivers/base/bus.c:672
 driver_unregister+0x73/0xb0 drivers/base/driver.c:274
 usb_gadget_unregister_driver+0x48/0x70 drivers/usb/gadget/udc/core.c:1592
 raw_release+0x18b/0x290 drivers/usb/gadget/legacy/raw_gadget.c:413
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x1f7/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc59833437b

================================
WARNING: inconsistent lock state
6.0.0-rc7-syzkaller #0 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
syz-executor.1/6679 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffffffff87b85858 (
vmap_area_lock){?.+.}-{2:2}
, at: spin_lock include/linux/spinlock.h:349 [inline]
, at: find_vmap_area+0x1c/0x130 mm/vmalloc.c:1836
{HARDIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5666 [inline]
  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:349 [inline]
  alloc_vmap_area+0xa0b/0x1d50 mm/vmalloc.c:1617
  __get_vm_area_node+0x142/0x3f0 mm/vmalloc.c:2484
  get_vm_area_caller+0x43/0x50 mm/vmalloc.c:2537
  __ioremap_caller.constprop.0+0x292/0x600 arch/x86/mm/ioremap.c:280
  acpi_os_ioremap include/acpi/acpi_io.h:13 [inline]
  acpi_map drivers/acpi/osl.c:296 [inline]
  acpi_os_map_iomem+0x463/0x550 drivers/acpi/osl.c:355
  acpi_tb_acquire_table+0xd8/0x209 drivers/acpi/acpica/tbdata.c:142
  acpi_tb_validate_table drivers/acpi/acpica/tbdata.c:317 [inline]
  acpi_tb_validate_table+0x50/0x8c drivers/acpi/acpica/tbdata.c:308
  acpi_tb_verify_temp_table+0x84/0x674 drivers/acpi/acpica/tbdata.c:504
  acpi_reallocate_root_table+0x374/0x3e0 drivers/acpi/acpica/tbxface.c:180
  acpi_early_init+0x13a/0x438 drivers/acpi/bus.c:1214
  start_kernel+0x3cf/0x48f init/main.c:1099
  secondary_startup_64_no_verify+0xce/0xdb
irq event stamp: 77514
hardirqs last  enabled at (77513): [<ffffffff811134bd>] kvm_wait arch/x86/kernel/kvm.c:1066 [inline]
hardirqs last  enabled at (77513): [<ffffffff811134bd>] kvm_wait+0x8d/0x100 arch/x86/kernel/kvm.c:1048
hardirqs last disabled at (77514): [<ffffffff85f4269b>] sysvec_apic_timer_interrupt+0xb/0xc0 arch/x86/kernel/apic/apic.c:1106
softirqs last  enabled at (69722): [<ffffffff8116a4f3>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (69722): [<ffffffff8116a4f3>] __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650
softirqs last disabled at (69601): [<ffffffff8116a4f3>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (69601): [<ffffffff8116a4f3>] __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(vmap_area_lock
);
  <Interrupt>
    lock(
vmap_area_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.1/6679:
 #0: ffff888100067948
 (&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_drain fs/kernfs/dir.c:494 [inline]
, at: __kernfs_remove+0x5ff/0xb50 fs/kernfs/dir.c:1386
 #1: ffffffff87c05cb8
 (kernfs_idr_lock
){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
){+.+.}-{2:2}, at: kernfs_put.part.0+0x269/0x540 fs/kernfs/dir.c:544

stack backtrace:
CPU: 1 PID: 6679 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3961 [inline]
 valid_state kernel/locking/lockdep.c:3973 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
 mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
 mark_lock kernel/locking/lockdep.c:4596 [inline]
 mark_usage kernel/locking/lockdep.c:4524 [inline]
 __lock_acquire+0x14a2/0x56d0 kernel/locking/lockdep.c:5007
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 find_vmap_area+0x1c/0x130 mm/vmalloc.c:1836
 check_heap_object mm/usercopy.c:176 [inline]
 __check_object_size mm/usercopy.c:250 [inline]
 __check_object_size+0x1f8/0x700 mm/usercopy.c:212
 check_object_size include/linux/thread_info.h:199 [inline]
 __copy_from_user_inatomic include/linux/uaccess.h:62 [inline]
 copy_from_user_nmi arch/x86/lib/usercopy.c:47 [inline]
 copy_from_user_nmi+0xcb/0x130 arch/x86/lib/usercopy.c:31
 copy_code arch/x86/kernel/dumpstack.c:91 [inline]
 show_opcodes+0x59/0xb0 arch/x86/kernel/dumpstack.c:121
 show_iret_regs+0xd/0x33 arch/x86/kernel/dumpstack.c:149
 __show_regs+0x1e/0x60 arch/x86/kernel/process_64.c:74
 show_trace_log_lvl+0x25b/0x2ba arch/x86/kernel/dumpstack.c:292
 watchdog_timer_fn+0x464/0x5c0 kernel/watchdog.c:433
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1112
 sysvec_apic_timer_interrupt+0x89/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:kvm_wait+0x98/0x100 arch/x86/kernel/kvm.c:1070
Code: fa 83 e2 07 38 d0 7f 04 84 c0 75 63 0f b6 07 40 38 c6 74 35 48 83 c4 10 c3 c3 e8 03 44 3b 00 66 90 0f 00 2d ba 52 34 05 fb f4 <48> 83 c4 10 c3 89 74 24 0c 48 89 3c 24 e8 d6 42 3b 00 8b 74 24 0c
RSP: 0018:ffffc9000f23fa50 EFLAGS: 00000246

RAX: 0000000000012ec9 RBX: 0000000000000000 RCX: 1ffffffff16100de
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff87c05ca0 R08: 0000000000000001 R09: ffffffff8b07b6cf
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: fffffbfff0f80b94 R14: 0000000000000001 R15: ffff8881f6938880
 pv_wait arch/x86/include/asm/paravirt.h:603 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8c7/0xb50 kernel/locking/qspinlock.c:511
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:349 [inline]
 kernfs_put.part.0+0x269/0x540 fs/kernfs/dir.c:544
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:521
 __kernfs_remove+0x7a6/0xb50 fs/kernfs/dir.c:1407
 kernfs_remove_by_name_ns+0xa8/0x110 fs/kernfs/dir.c:1589
 sysfs_remove_file include/linux/sysfs.h:629 [inline]
 driver_remove_file drivers/base/driver.c:198 [inline]
 driver_remove_file+0x46/0x60 drivers/base/driver.c:194
 remove_bind_files drivers/base/bus.c:548 [inline]
 bus_remove_driver+0x22a/0x300 drivers/base/bus.c:672
 driver_unregister+0x73/0xb0 drivers/base/driver.c:274
 usb_gadget_unregister_driver+0x48/0x70 drivers/usb/gadget/udc/core.c:1592
 raw_release+0x18b/0x290 drivers/usb/gadget/legacy/raw_gadget.c:413
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x1f7/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc59833437b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fc597af7120 EFLAGS: 00000293
 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007fc5984a3f80 RCX: 00007fc59833437b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fc5983dd580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffe89b0622f R14: 00007fc597af7300 R15: 0000000000022000
 </TASK>
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fc597af7120 EFLAGS: 00000293
 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007fc5984a3f80 RCX: 00007fc59833437b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fc5983dd580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffe89b0622f R14: 00007fc597af7300 R15: 0000000000022000
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
igorplugusb 2-1:0.0: Error: urb status = -32
NMI backtrace for cpu 0
CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: usb_hub_wq hub_event
RIP: 0010:put_dec_trunc8+0x3e/0x370 lib/vsprintf.c:229
Code: 00 00 00 e8 f4 fc 1e ff 83 fb 63 0f 86 d8 01 00 00 e8 26 00 1f ff 41 89 dc 4d 69 e4 29 5c 8f 02 49 c1 ec 20 41 6b c4 64 29 c3 <48> 83 fb 63 0f 87 cb 02 00 00 48 8d bc 1b e0 85 64 86 48 b8 00 00
RSP: 0018:ffffc90000006fb0 EFLAGS: 00000002
RAX: 0000000000000190 RBX: 0000000000000015 RCX: ffffc90000c01000
RDX: 0000000000040000 RSI: ffffffff82270baa RDI: 0000000000000005
RBP: ffffc90000007070 R08: 0000000000000005 R09: 0000000000000063
R10: 00000000000001a5 R11: 0000000000000001 R12: 0000000000000004
R13: 0000000000000000 R14: ffffc900800073d7 R15: ffffc900000073d9
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04d16f5fc0 CR3: 000000013871d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 number+0x9e4/0xae0 lib/vsprintf.c:508
 vsnprintf+0xf07/0x14f0 lib/vsprintf.c:2848
 sprintf+0xc0/0x100 lib/vsprintf.c:2986
 print_time kernel/printk/printk.c:1277 [inline]
 info_print_prefix+0x248/0x340 kernel/printk/printk.c:1303
 record_print_text+0x14d/0x3e0 kernel/printk/printk.c:1352
 console_emit_next_record.constprop.0+0x6bf/0x840 kernel/printk/printk.c:2715
 console_flush_all kernel/printk/printk.c:2794 [inline]
 console_unlock+0x37a/0x5a0 kernel/printk/printk.c:2861
 vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
 dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4736
 dev_printk_emit+0xba/0xf1 drivers/base/core.c:4747
 __dev_printk+0xcf/0xf5 drivers/base/core.c:4759
 _dev_warn+0xd7/0x109 drivers/base/core.c:4803
 igorplugusb_callback.cold+0x3c/0x2af drivers/media/rc/igorplugusb.c:115
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1671
 usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x11ff/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1c0/0x9a9 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x113/0x170 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:idr_alloc_u32+0x2/0x2d0 lib/idr.c:35
Code: c4 e8 72 cf 20 ff e9 0a ff ff ff e8 68 cf 20 ff e9 13 ff ff ff e8 5e f1 ce 03 cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 <41> 56 45 89 c6 41 55 49 bd 00 00 00 00 00 fc ff df 41 54 55 48 89
RSP: 0018:ffffc9000007f470 EFLAGS: 00000246
RAX: 0000000000040000 RBX: ffff888100067810 RCX: 000000007fffffff
RDX: ffffc9000007f4b8 RSI: ffff888138a10488 RDI: ffff888100067810
RBP: ffffc9000007f4b8 R08: 0000000000000a20 R09: 0000000000011040
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888100067864 R14: 0000000000011040 R15: 000000007fffffff
 idr_alloc_cyclic+0x102/0x230 lib/idr.c:125
 __kernfs_new_node+0x117/0x8b0 fs/kernfs/dir.c:599
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:655
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:1050
 sysfs_add_file_mode_ns+0x20f/0x3f0 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x322/0xb10 fs/sysfs/group.c:148
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:188
 internal_create_groups fs/sysfs/group.c:184 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:214
 device_add_groups drivers/base/core.c:2572 [inline]
 device_add_attrs drivers/base/core.c:2731 [inline]
 device_add+0x83e/0x1e90 drivers/base/core.c:3468
 usb_create_ep_devs+0x15c/0x2a0 drivers/usb/core/endpoint.c:169
 usb_new_device.cold+0xc9b/0x10ad drivers/usb/core/hub.c:2601
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x26c7/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
