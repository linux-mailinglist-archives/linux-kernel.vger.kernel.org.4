Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88070A662
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjETI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:26:56 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D6CA1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:26:54 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-334d63a10e9so29643215ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684571214; x=1687163214;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WppKdVHb+BXgDrTsl2rVn6ZlsxAH7I5KSj2MszaB5hw=;
        b=WraeWip3hAys2mGxYN/uHL2T0NJ5gP3lV9kEX/YpJs1frOcr9u6rR/DNQkXdeENBCh
         lsdKE3lDoqdhH8rlW+qW5Utceu8Fqh6EiD6pxUzIWvw6/IcJHv0LLqrp1kVUAE7gzLob
         bBxBx+LwH9tYJnl9/0Ez5gXIu3rZhsKiLn9O0B6LpuBm6wwavHE6zr97RBljXY+tw2eI
         IDatwuw19lT6iXhLCSqM1Ybfqkd+Oz0XUdI1YLCgbjsr3QLf3SffLRKAsXLhEmUwlblU
         kbu1jZc00t3Ug6iZSXQBN2lnZUbogvVgeTBypvCkh1IqTvrBV+mfcrElCjnmBPDuFUAu
         74rQ==
X-Gm-Message-State: AC+VfDyx66URPxK0wTsFKTc7kA8Q9DUVIyaTVI7mEGaL1UEMnAZvyfmY
        Wqt+D5lh1wQh6TVSrjQ/nHCz3Awf+Lolb+g0wpVIfYBLMs3e
X-Google-Smtp-Source: ACHHUZ4X5qSWY8agcJ3IC8+h5pEWxvsM3gq8X8tzCaQZOp1VGN05kWmMlEGhnWMHMbV7+/EiHv8n+KD4abC+HmCIVzJDYh8kP5C9
MIME-Version: 1.0
X-Received: by 2002:a92:c80a:0:b0:335:908b:8fc with SMTP id
 v10-20020a92c80a000000b00335908b08fcmr2257093iln.1.1684571213982; Sat, 20 May
 2023 01:26:53 -0700 (PDT)
Date:   Sat, 20 May 2023 01:26:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cef3a005fc1bcc80@google.com>
Subject: [syzbot] [kernel?] possible deadlock in scheduler_tick (2)
From:   syzbot <syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com>
To:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1332a029280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dc1cdd68141cdc3
dashboard link: https://syzkaller.appspot.com/bug?extid=ece2915262061d6e0ac1
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9e1748cceea/disk-f1fcbaa1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6dea99343621/vmlinux-f1fcbaa1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5a93f86012d/Image-f1fcbaa1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc2-syzkaller-gf1fcbaa18b28 #0 Not tainted
------------------------------------------------------
klogd/5578 is trying to acquire lock:
ffff0001fea76c40
 (&pgdat->kcompactd_wait){-...}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:137 [inline]
 (&pgdat->kcompactd_wait){-...}-{2:2}, at: __wake_up+0xec/0x1a8 kernel/sched/wait.c:160

but task is already holding lock:
ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1653 [inline]
ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: scheduler_tick+0xa4/0x52c kernel/sched/core.c:5616

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x6c kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2c/0x44 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x7c/0x23c kernel/sched/fair.c:12095
       sched_cgroup_fork+0x38c/0x464 kernel/sched/core.c:4777
       copy_process+0x24fc/0x3514 kernel/fork.c:2618
       kernel_clone+0x1d8/0x8ac kernel/fork.c:2918
       user_mode_thread+0x110/0x178 kernel/fork.c:2996
       rest_init+0x2c/0x2f4 init/main.c:700
       start_kernel+0x0/0x55c init/main.c:834
       start_kernel+0x3f0/0x55c init/main.c:1088
       __primary_switched+0xb8/0xc0 arch/arm64/kernel/head.S:523

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       try_to_wake_up+0xb0/0xd9c kernel/sched/core.c:4191
       default_wake_function+0x4c/0x60 kernel/sched/core.c:6993
       autoremove_wake_function+0x24/0xf8 kernel/sched/wait.c:419
       __wake_up_common+0x23c/0x3bc kernel/sched/wait.c:107
       __wake_up_common_lock kernel/sched/wait.c:138 [inline]
       __wake_up+0x10c/0x1a8 kernel/sched/wait.c:160
       wakeup_kcompactd+0x254/0x310 mm/compaction.c:2942
       balance_pgdat+0x1880/0x1c34 mm/vmscan.c:7540
       kswapd+0x7d0/0x10fc mm/vmscan.c:7737
       kthread+0x288/0x310 kernel/kthread.c:379
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870

-> #0 (&pgdat->kcompactd_wait){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x3310/0x75f0 kernel/locking/lockdep.c:5074
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5691
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:137 [inline]
       __wake_up+0xec/0x1a8 kernel/sched/wait.c:160
       wakeup_kcompactd+0x254/0x310 mm/compaction.c:2942
       wakeup_kswapd+0x350/0x8c8 mm/vmscan.c:7791
       wake_all_kswapds+0x13c/0x23c mm/page_alloc.c:4028
       __alloc_pages_slowpath+0x378/0x1edc mm/page_alloc.c:4296
       __alloc_pages+0x3bc/0x698 mm/page_alloc.c:4781
       alloc_pages+0x4bc/0x7c0
       __stack_depot_save+0x4ac/0x678 lib/stackdepot.c:410
       kasan_save_stack+0x54/0x6c mm/kasan/common.c:46
       __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:491
       kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:496
       task_work_add+0x94/0x3c0 kernel/task_work.c:48
       task_tick_mm_cid kernel/sched/core.c:11940 [inline]
       scheduler_tick+0x2d0/0x52c kernel/sched/core.c:5626
       update_process_times+0x198/0x1f4 kernel/time/timer.c:2076
       tick_sched_handle kernel/time/tick-sched.c:243 [inline]
       tick_sched_timer+0x330/0x4e8 kernel/time/tick-sched.c:1481
       __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
       __hrtimer_run_queues+0x458/0xca0 kernel/time/hrtimer.c:1749
       hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1811
       timer_handler drivers/clocksource/arm_arch_timer.c:656 [inline]
       arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:667
       handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:930
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq_desc kernel/irq/irqdesc.c:651 [inline]
       generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:707
       __gic_handle_irq drivers/irqchip/irq-gic-v3.c:728 [inline]
       __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:779 [inline]
       gic_handle_irq+0x70/0x1e4 drivers/irqchip/irq-gic-v3.c:823
       call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:899
       do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:274
       __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
       el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
       el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
       el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:587
       __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:33 [inline]
       arch_local_irq_enable arch/arm64/include/asm/irqflags.h:55 [inline]
       __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
       _raw_spin_unlock_irq+0x34/0x80 kernel/locking/spinlock.c:202
       spin_unlock_irq include/linux/spinlock.h:400 [inline]
       __filemap_add_folio+0x6f8/0x11b4 mm/filemap.c:914
       filemap_add_folio+0x10c/0x298 mm/filemap.c:939
       page_cache_ra_unbounded+0x1c0/0x58c mm/readahead.c:251
       do_page_cache_ra mm/readahead.c:300 [inline]
       page_cache_ra_order+0x7fc/0x994 mm/readahead.c:560
       do_sync_mmap_readahead+0x3a4/0x844
       filemap_fault+0x5bc/0x1154 mm/filemap.c:3279
       __do_fault+0x11c/0x3d8 mm/memory.c:4176
       do_read_fault mm/memory.c:4530 [inline]
       do_fault mm/memory.c:4659 [inline]
       do_pte_missing mm/memory.c:3647 [inline]
       handle_pte_fault mm/memory.c:4947 [inline]
       __handle_mm_fault mm/memory.c:5089 [inline]
       handle_mm_fault+0x32cc/0x48ec mm/memory.c:5243
       __do_page_fault arch/arm64/mm/fault.c:512 [inline]
       do_page_fault+0x81c/0xcbc arch/arm64/mm/fault.c:645
       do_translation_fault+0x94/0xc8 arch/arm64/mm/fault.c:731
       do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:867
       el0_ia+0x90/0x214 arch/arm64/kernel/entry-common.c:533
       el0t_64_sync_handler+0xb4/0xf0 arch/arm64/kernel/entry-common.c:661
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

Chain exists of:
  &pgdat->kcompactd_wait --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(&pgdat->kcompactd_wait);

 *** DEADLOCK ***

2 locks held by klogd/5578:
 #0: ffff0000c18ae9a0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:830 [inline]
 #0: ffff0000c18ae9a0 (mapping.invalidate_lock){++++}-{3:3}, at: page_cache_ra_unbounded+0xc8/0x58c mm/readahead.c:226
 #1: ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:558 [inline]
 #1: ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
 #1: ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1653 [inline]
 #1: ffff0001b425bb18 (&rq->__lock){-.-.}-{2:2}, at: scheduler_tick+0xa4/0x52c kernel/sched/core.c:5616

stack backtrace:
CPU: 1 PID: 5578 Comm: klogd Not tainted 6.4.0-rc2-syzkaller-gf1fcbaa18b28 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2066
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x3310/0x75f0 kernel/locking/lockdep.c:5074
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5691
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 __wake_up_common_lock kernel/sched/wait.c:137 [inline]
 __wake_up+0xec/0x1a8 kernel/sched/wait.c:160
 wakeup_kcompactd+0x254/0x310 mm/compaction.c:2942
 wakeup_kswapd+0x350/0x8c8 mm/vmscan.c:7791
 wake_all_kswapds+0x13c/0x23c mm/page_alloc.c:4028
 __alloc_pages_slowpath+0x378/0x1edc mm/page_alloc.c:4296
 __alloc_pages+0x3bc/0x698 mm/page_alloc.c:4781
 alloc_pages+0x4bc/0x7c0
 __stack_depot_save+0x4ac/0x678 lib/stackdepot.c:410
 kasan_save_stack+0x54/0x6c mm/kasan/common.c:46
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:491
 kasan_record_aux_stack+0x14/0x20 mm/kasan/generic.c:496
 task_work_add+0x94/0x3c0 kernel/task_work.c:48
 task_tick_mm_cid kernel/sched/core.c:11940 [inline]
 scheduler_tick+0x2d0/0x52c kernel/sched/core.c:5626
 update_process_times+0x198/0x1f4 kernel/time/timer.c:2076
 tick_sched_handle kernel/time/tick-sched.c:243 [inline]
 tick_sched_timer+0x330/0x4e8 kernel/time/tick-sched.c:1481
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x458/0xca0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1811
 timer_handler drivers/clocksource/arm_arch_timer.c:656 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:667
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:930
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:651 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:707
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:728 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:779 [inline]
 gic_handle_irq+0x70/0x1e4 drivers/irqchip/irq-gic-v3.c:823
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:899
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:274
 __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:587
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:33 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:55 [inline]
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irq+0x34/0x80 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:400 [inline]
 __filemap_add_folio+0x6f8/0x11b4 mm/filemap.c:914
 filemap_add_folio+0x10c/0x298 mm/filemap.c:939
 page_cache_ra_unbounded+0x1c0/0x58c mm/readahead.c:251
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x7fc/0x994 mm/readahead.c:560
 do_sync_mmap_readahead+0x3a4/0x844
 filemap_fault+0x5bc/0x1154 mm/filemap.c:3279
 __do_fault+0x11c/0x3d8 mm/memory.c:4176
 do_read_fault mm/memory.c:4530 [inline]
 do_fault mm/memory.c:4659 [inline]
 do_pte_missing mm/memory.c:3647 [inline]
 handle_pte_fault mm/memory.c:4947 [inline]
 __handle_mm_fault mm/memory.c:5089 [inline]
 handle_mm_fault+0x32cc/0x48ec mm/memory.c:5243
 __do_page_fault arch/arm64/mm/fault.c:512 [inline]
 do_page_fault+0x81c/0xcbc arch/arm64/mm/fault.c:645
 do_translation_fault+0x94/0xc8 arch/arm64/mm/fault.c:731
 do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:867
 el0_ia+0x90/0x214 arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0xb4/0xf0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


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
