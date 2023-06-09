Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB22B72A30E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjFITZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFITZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:25:57 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9DE2D44
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:25:55 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7778eb7966eso261069339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338754; x=1688930754;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB00ZKNwuQRJiGqm0MY/ERrPWwHPwxZ132FB8GF4TTo=;
        b=Gr7dTCtdvVwMsuf4lnZSiSrppi1LyUTlFNXV9TH9dojC+HP2WdMSZrzcekwwqrgpUm
         m5kiMQSjlUN8O0f8kx3MkXu9vUW152LU/PuYecioLwVFstf0tDdNtEQnX6w/Y923kiM8
         8s54esabgHJhVc5CEsPSBewBjAn3D5QHHZdMzXiIH2SgKoF22sxriPn0Ltcd0IxS5+Tc
         35knYlFFMut532+RIgY6KIfmW9+0CfkzsQngUlpDgIY4oqOw+UofQXp509mOPGqMG6SE
         D9DmOJpXCLrHU3hwBv7b/9EDzO3JJA/DuAqXY5zjdtnTcN97ipr2IkG7ZuQCc6N/8VaG
         OINA==
X-Gm-Message-State: AC+VfDyYDPapFx1W5lzgFvK4s3NKK1GrRBBmaJGGsPKdr0oMbyaM+4S9
        ttln11l1HYAVjn+D3ywOxmv1T938KPJDVumU4ypUImE1lWFm
X-Google-Smtp-Source: ACHHUZ5u/Lm53VJhBCcOrQk0Ms+24oWsNtKY6V/yiPE1TcRhJk0HA5Znoer+cols8f1VyuHtH8MYSTiPDK1Hw+O1G90e4Pw02hkE
MIME-Version: 1.0
X-Received: by 2002:a6b:7f45:0:b0:777:b751:a452 with SMTP id
 m5-20020a6b7f45000000b00777b751a452mr1252873ioq.2.1686338754593; Fri, 09 Jun
 2023 12:25:54 -0700 (PDT)
Date:   Fri, 09 Jun 2023 12:25:54 -0700
In-Reply-To: <000000000000312a0305f7f4ee65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000704d6305fdb75642@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
From:   syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    33f2b5785a2b Merge tag 'drm-fixes-2023-06-09' of git://ano..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1206f143280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1676f51b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129632fd280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a817d99af39d/disk-33f2b578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8916e1d053fc/vmlinux-33f2b578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e53956f3cfd4/bzImage-33f2b578.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com

INFO: task kworker/0:2:901 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc5-syzkaller-00178-g33f2b5785a2b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:26800 pid:901   ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
 usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 hub_port_init+0x14f3/0x3900 drivers/usb/core/hub.c:4874
 hub_port_connect drivers/usb/core/hub.c:5336 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2b89/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor104:5004 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc5-syzkaller-00178-g33f2b5785a2b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor104 state:D stack:26464 pid:5004  ppid:5002   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6804
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa3b/0x1350 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:837 [inline]
 usbdev_release+0x87/0x4b0 drivers/usb/core/devio.c:1094
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 ptrace_notify+0x118/0x140 kernel/signal.c:2371
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x220 kernel/entry/common.c:279
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0xd/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7118e08653
RSP: 002b:00007fff91a87278 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f7118e08653
RDX: 0000000000000007 RSI: 00007fff91a86da0 RDI: 0000000000000003
RBP: 00007fff91a872d0 R08: 0000000000000000 R09: 00007fff91a86cf0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000000000 R14: 00007fff91a872c0 R15: 00007fff91a872b0
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c7984b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c7981b0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6559
5 locks held by kworker/0:2/901:
 #0: ffff888147275d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888147275d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888147275d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff888147275d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff888147275d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff888147275d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc900056c7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffff888142f77190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:837 [inline]
 #2: ffff888142f77190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4e40 drivers/usb/core/hub.c:5739
 #3: ffff8880224434f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3147 [inline]
 #3: ffff8880224434f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5303 [inline]
 #3: ffff8880224434f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #3: ffff8880224434f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #3: ffff8880224434f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x278e/0x4e40 drivers/usb/core/hub.c:5793
 #4: ffff888142f01468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5304 [inline]
 #4: ffff888142f01468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #4: ffff888142f01468 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #4: ffff888142f01468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27c3/0x4e40 drivers/usb/core/hub.c:5793
2 locks held by getty/4753:
 #0: ffff88802c991098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
1 lock held by syz-executor104/5004:
 #0: ffff888142f77190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:837 [inline]
 #0: ffff888142f77190 (&dev->mutex){....}-{3:3}, at: usbdev_release+0x87/0x4b0 drivers/usb/core/devio.c:1094

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.4.0-rc5-syzkaller-00178-g33f2b5785a2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 75 Comm: kworker/u4:4 Not tainted 6.4.0-rc5-syzkaller-00178-g33f2b5785a2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__phys_addr+0xcf/0x140 arch/x86/mm/physaddr.c:32
Code: 08 e8 35 78 4a 00 4c 89 e3 44 89 e9 31 ff 48 d3 eb 48 89 de e8 62 74 4a 00 48 85 db 75 0f e8 18 78 4a 00 4c 89 e0 5b 5d 41 5c <41> 5d c3 e8 09 78 4a 00 0f 0b e8 02 78 4a 00 48 c7 c0 10 80 59 8c
RSP: 0018:ffffc900015b7968 EFLAGS: 00000093
RAX: 0000000012463000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888019abd940 RSI: ffffffff8139ce28 RDI: 0000000000000007
RBP: ffff888012468000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888019abd940
R13: 000000000000002e R14: ffffffff8c8f6940 R15: ffffffff8c8f6900
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005639543b1978 CR3: 0000000012463000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 build_cr3 arch/x86/mm/tlb.c:159 [inline]
 switch_mm_irqs_off+0xc1/0xbb0 arch/x86/mm/tlb.c:529
 unuse_temporary_mm arch/x86/kernel/alternative.c:1516 [inline]
 __text_poke+0x3c5/0x890 arch/x86/kernel/alternative.c:1626
 text_poke arch/x86/kernel/alternative.c:1669 [inline]
 text_poke_bp_batch+0x3af/0x770 arch/x86/kernel/alternative.c:1992
 text_poke_flush arch/x86/kernel/alternative.c:2161 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2158 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2168
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x156/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:836 [inline]
 toggle_allocation_gate+0x143/0x230 mm/kfence/core.c:823
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.090 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
