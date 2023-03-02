Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F86A79A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCBCrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCBCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:47:33 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBDE521E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:47:25 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id x6-20020a920606000000b0031784489cbeso3933895ilg.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 18:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivjGERqeaWjyJbr/EdEWZ1/I3o9xm4m4MHLrUHfLGPg=;
        b=5SxChT2USdCnmOW5fzX3U46rsEFfFKQEh3BNC2whFQd2KQY8UrH0vPiSX60cDvoHjE
         5+duFMbj6s4Bs2Zlu0Gs6IQGy/SDK7fPkqwGcqKsHpCRwGCCgjEchPzqnGGA7LTH6if1
         O1Ep+sM7BP5TnZ3ewgD6QYs8ptkF1+2KNUY0hdt2qRKrwH9ZKq/YOIg8tVVlffIFYNLg
         fxTVyhLLP6vUyPp/MjMsp/W1AZanWiedn+sX7+V+i5TrlJzKa+kzQ/lQi98TKV6kelh/
         WHEWyt8sAWmXU62HHdh2VHZ0JaCR/JyIZloal+8hmcS/38j+i/7LXj2hAmyZbvnYRgm8
         liCQ==
X-Gm-Message-State: AO0yUKU+u80l5iwOba5Px3oEHu7FpHRLtRClRLL6O0J3L0DzKgeX/on3
        rRA4NA+PXGeLjkrrjxv+N08UyB+zn+b66qFgYo5HL3q7ROAm
X-Google-Smtp-Source: AK7set94wfYiHWEKajgiQ6peqBLl33VYBIz41Vb/L9iTQE3urs9uBZpFvF5hsmOCsXY92WmrzJglu75JszaQwIioMns2uyC/O5ea
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1111:b0:317:6eac:97e1 with SMTP id
 u17-20020a056e02111100b003176eac97e1mr341126ilk.0.1677725245045; Wed, 01 Mar
 2023 18:47:25 -0800 (PST)
Date:   Wed, 01 Mar 2023 18:47:25 -0800
In-Reply-To: <20230302022933.2400-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043043305f5e1d9b8@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in write_cache_pages (2)
From:   syzbot <syzbot+0adf31ecbba886ab504f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in exit_mm

INFO: task syz-executor.5:5830 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27184 pid:5830  ppid:5547   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common+0x61/0x2c0 kernel/locking/rwsem.c:1250
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 exit_mm+0xd3/0x310 kernel/exit.c:539
 do_exit+0x612/0x2290 kernel/exit.c:856
 do_group_exit+0x206/0x2c0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f490de8c0f9
RSP: 002b:00007ffff62d3228 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f490de8c0f9
RDX: 00007f490de3dfab RSI: ffffffffffffffb8 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffff62d3310
 </TASK>
INFO: task syz-executor.5:5831 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:24840 pid:5831  ppid:5547   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 io_schedule+0x8c/0x100 kernel/sched/core.c:8884
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1301
 folio_lock include/linux/pagemap.h:952 [inline]
 write_cache_pages+0x58f/0x1450 mm/page-writeback.c:2440
 mpage_writepages+0x107/0x1d0 fs/mpage.c:653
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:390
 __filemap_fdatawrite_range mm/filemap.c:423 [inline]
 file_write_and_wait_range+0x20f/0x300 mm/filemap.c:781
 __generic_file_fsync+0x72/0x190 fs/libfs.c:1132
 fat_file_fsync+0x7e/0x190 fs/fat/file.c:191
 generic_write_sync include/linux/fs.h:2452 [inline]
 generic_file_write_iter+0x2a1/0x310 mm/filemap.c:4090
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7b2/0xbb0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f490de8c0f9
RSP: 002b:00007f490ebd7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f490dfabf80 RCX: 00007f490de8c0f9
RDX: 000000000208e24b RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f490dee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffff62d2fef R14: 00007f490ebd7300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.5:5841 blocked for more than 144 seconds.
      Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26096 pid:5841  ppid:5547   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 io_schedule+0x8c/0x100 kernel/sched/core.c:8884
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1301
 folio_wait_writeback+0xec/0x1f0 mm/page-writeback.c:3127
 migrate_folio_unmap mm/migrate.c:1196 [inline]
 migrate_pages_batch mm/migrate.c:1690 [inline]
 migrate_pages+0x2b2f/0x64e0 mm/migrate.c:1978
 do_mbind mm/mempolicy.c:1338 [inline]
 kernel_mbind mm/mempolicy.c:1485 [inline]
 __do_sys_mbind mm/mempolicy.c:1559 [inline]
 __se_sys_mbind+0x75a/0x9c0 mm/mempolicy.c:1555
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f490de8c0f9
RSP: 002b:00007f490ebb6168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f490dfac050 RCX: 00007f490de8c0f9
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00007f490dee7ae9 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffff62d2fef R14: 00007f490ebb6300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:5848 blocked for more than 144 seconds.
      Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:24632 pid:5848  ppid:5545   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 io_schedule+0x8c/0x100 kernel/sched/core.c:8884
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1301
 folio_lock include/linux/pagemap.h:952 [inline]
 write_cache_pages+0x58f/0x1450 mm/page-writeback.c:2440
 mpage_writepages+0x107/0x1d0 fs/mpage.c:653
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:390
 __filemap_fdatawrite_range mm/filemap.c:423 [inline]
 file_write_and_wait_range+0x20f/0x300 mm/filemap.c:781
 __generic_file_fsync+0x72/0x190 fs/libfs.c:1132
 fat_file_fsync+0x7e/0x190 fs/fat/file.c:191
 generic_write_sync include/linux/fs.h:2452 [inline]
 generic_file_write_iter+0x2a1/0x310 mm/filemap.c:4090
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7b2/0xbb0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa254a8c0f9
RSP: 002b:00007fa255899168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa254babf80 RCX: 00007fa254a8c0f9
RDX: 000000000208e24b RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007fa254ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe513c259f R14: 00007fa255899300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:5857 blocked for more than 144 seconds.
      Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:25992 pid:5857  ppid:5545   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 io_schedule+0x8c/0x100 kernel/sched/core.c:8884
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1301
 folio_wait_writeback+0xec/0x1f0 mm/page-writeback.c:3127
 migrate_folio_unmap mm/migrate.c:1196 [inline]
 migrate_pages_batch mm/migrate.c:1690 [inline]
 migrate_pages+0x2b2f/0x64e0 mm/migrate.c:1978
 do_mbind mm/mempolicy.c:1338 [inline]
 kernel_mbind mm/mempolicy.c:1485 [inline]
 __do_sys_mbind mm/mempolicy.c:1559 [inline]
 __se_sys_mbind+0x75a/0x9c0 mm/mempolicy.c:1555
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa254a8c0f9
RSP: 002b:00007fa255878168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fa254bac050 RCX: 00007fa254a8c0f9
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000000020001000
RBP: 00007fa254ae7ae9 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe513c259f R14: 00007fa255878300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d127cf0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d1284f0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffffffff8d127b20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by kworker/u4:3/46:
 #0: ffff888144ba4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x77f/0x13a0
 #1: ffffc90000b77d20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7c6/0x13a0 kernel/workqueue.c:2365
 #2: ffff8880769fa0e0 (&type->s_umount_key#51){++++}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:414
3 locks held by kworker/u4:5/1021:
 #0: ffff888144ba4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x77f/0x13a0
 #1: ffffc9000523fd20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7c6/0x13a0 kernel/workqueue.c:2365
 #2: ffff88805ba400e0 (&type->s_umount_key#51){++++}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:414
3 locks held by kworker/u4:6/3088:
 #0: ffff888144ba4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x77f/0x13a0
 #1: ffffc9000d11fd20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7c6/0x13a0 kernel/workqueue.c:2365
 #2: ffff8880781e00e0 (&type->s_umount_key#51){++++}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:414
2 locks held by getty/4746:
 #0: ffff88814b328098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015802f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ab/0x1db0 drivers/tty/n_tty.c:2177
3 locks held by kworker/u4:7/5713:
 #0: ffff888144ba4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x77f/0x13a0
 #1: ffffc9000596fd20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7c6/0x13a0 kernel/workqueue.c:2365
 #2: ffff88805d4ee0e0 (&type->s_umount_key#51){++++}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:414
1 lock held by syz-executor.5/5830:
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: exit_mm+0xd3/0x310 kernel/exit.c:539
2 locks held by syz-executor.5/5831:
 #0: ffff88802a81d768 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff8880781e0460 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
1 lock held by syz-executor.5/5841:
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind mm/mempolicy.c:1312 [inline]
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: kernel_mbind mm/mempolicy.c:1485 [inline]
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_mbind mm/mempolicy.c:1559 [inline]
 #0: ffff88801246d298 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_mbind+0x47d/0x9c0 mm/mempolicy.c:1555
1 lock held by syz-executor.4/5846:
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mm+0xd3/0x310 kernel/exit.c:539
2 locks held by syz-executor.4/5848:
 #0: ffff88807cd1e368 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff8880769fa460 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
1 lock held by syz-executor.4/5857:
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind mm/mempolicy.c:1312 [inline]
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: kernel_mbind mm/mempolicy.c:1485 [inline]
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_mbind mm/mempolicy.c:1559 [inline]
 #0: ffff88801246db98 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_mbind+0x47d/0x9c0 mm/mempolicy.c:1555
1 lock held by syz-executor.3/6449:
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mm+0xd3/0x310 kernel/exit.c:539
2 locks held by syz-executor.3/6451:
 #0: ffff88801ea74868 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff88805d4ee460 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
1 lock held by syz-executor.3/6458:
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind mm/mempolicy.c:1312 [inline]
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: kernel_mbind mm/mempolicy.c:1485 [inline]
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_mbind mm/mempolicy.c:1559 [inline]
 #0: ffff888029eb2e98 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_mbind+0x47d/0x9c0 mm/mempolicy.c:1555
3 locks held by kworker/u4:8/6462:
 #0: ffff888144ba4138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x77f/0x13a0
 #1: ffffc9000aee7d20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7c6/0x13a0 kernel/workqueue.c:2365
 #2: ffff88805ba2a0e0 (&type->s_umount_key#51){++++}-{3:3}, at: trylock_super+0x1f/0xf0 fs/super.c:414
1 lock held by syz-executor.1/6471:
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mm+0xd3/0x310 kernel/exit.c:539
2 locks held by syz-executor.1/6473:
 #0: ffff88801eaa7268 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff88805ba40460 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
1 lock held by syz-executor.1/6477:
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind mm/mempolicy.c:1312 [inline]
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: kernel_mbind mm/mempolicy.c:1485 [inline]
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_mbind mm/mempolicy.c:1559 [inline]
 #0: ffff88802bdd2e98 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_mbind+0x47d/0x9c0 mm/mempolicy.c:1555
1 lock held by syz-executor.0/6472:
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mm+0xd3/0x310 kernel/exit.c:539
2 locks held by syz-executor.0/6474:
 #0: ffff88801eaa7768 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff88805ba2a460 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
1 lock held by syz-executor.0/6480:
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind mm/mempolicy.c:1312 [inline]
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: kernel_mbind mm/mempolicy.c:1485 [inline]
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_mbind mm/mempolicy.c:1559 [inline]
 #0: ffff88802bdd5b98 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_mbind+0x47d/0x9c0 mm/mempolicy.c:1555
1 lock held by syz-executor.2/7013:
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mm+0xd3/0x310 kernel/exit.c:539
2 locks held by syz-executor.2/7016:
 #0: ffff88801c4b2368 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff88807d1c6460 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
1 lock held by syz-executor.2/7024:
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind mm/mempolicy.c:1312 [inline]
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: kernel_mbind mm/mempolicy.c:1485 [inline]
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_mbind mm/mempolicy.c:1559 [inline]
 #0: ffff888076231c98 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_mbind+0x47d/0x9c0 mm/mempolicy.c:1555

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e5/0x560 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x1b4/0x410 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0x1024/0x1070 kernel/hung_task.c:379
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.2.0-syzkaller-10827-g489fa31ea873-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Workqueue: phy19 ieee80211_iface_work
RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:207 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:239 [inline]
RIP: 0010:_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
RIP: 0010:ieee80211_iface_work+0xb7/0xd00 net/mac80211/iface.c:1624
Code: d0 1c 00 00 48 89 df be 08 00 00 00 e8 a2 25 b0 f7 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 cc 23 b0 f7 48 8b 1b <48> 89 de 48 83 e6 01 31 ff e8 3b ae 59 f7 48 83 e3 01 75 32 48 8d
RSP: 0018:ffffc90000107be0 EFLAGS: 00000246
RAX: 1ffff1100bae6556 RBX: 0000000000000000 RCX: ffffffff8a33025e
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88805d732ab0
RBP: ffff88805d730de0 R08: dffffc0000000000 R09: ffffed100bae6557
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff88802c759820 R14: dffffc0000000000 R15: ffff8880124c1000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558b53bc5150 CR3: 000000000cf30000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x915/0x13a0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         489fa31e Merge branch 'work.misc' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=165dd5d2c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbfa7a73c540248d
dashboard link: https://syzkaller.appspot.com/bug?extid=0adf31ecbba886ab504f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117a8da8c80000

