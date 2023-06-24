Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BB73C679
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 05:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjFXDRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 23:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFXDQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 23:16:59 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52940E47
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 20:16:57 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7775a282e25so77144339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 20:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576616; x=1690168616;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k65zINyUz9GkzIfZNmLbjtYyNeo+GXwEgSmlVobXADY=;
        b=gLgx0mZFQ+SXO69jxNCG4hA0GVkbdynyxNjiMXfbAsuwsZ5FFRINXhGljPpvUZez9j
         pW/2IibNhwQ5+ef1kEPy9qqNf/Q+bbD5II7p7PSiRo8NhpEm50zaMrue+KEctQZ6RVoc
         91JJPm3Z6NYNAqjGPH7dJpGD5MzzxlLmGK3VoJPAuDkM8QbBm5IwwPgtWx/UXZI/K8pa
         kYFpaOH5do7pIM3qHl22cRwhLk/9P2GsGToncKPB5DlraN1Zp4Fzcpt/t0RCzrhnkekT
         EK/ZHebQbB+s5jUpKHxwGQ8+dij8FpNLg9IF7u1XQ48tLx2tWcoJcn3io1vOE2iRXDm+
         Cgjg==
X-Gm-Message-State: AC+VfDz21QGGPGgyZnrF9ejV23VUEI6Qp5415uGGGwpsm0u2uk1Y5YYT
        42Nq/JD7IKx2Io4S36oixWHUpS7ePIkHQ9dOCUZs3aMAJl6F
X-Google-Smtp-Source: ACHHUZ5Oe1gRuTSgev790sJM1V7hB6XmjlxQQOe+yIH0qUyb4vV4L4B+BBQMEukZH8XNqm04rhFEsyu1P0hQx+vF4AqD6Pd03sLE
MIME-Version: 1.0
X-Received: by 2002:a6b:db17:0:b0:763:5f92:afc3 with SMTP id
 t23-20020a6bdb17000000b007635f92afc3mr8066870ioc.0.1687576616574; Fri, 23 Jun
 2023 20:16:56 -0700 (PDT)
Date:   Fri, 23 Jun 2023 20:16:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c329d505fed78c74@google.com>
Subject: [syzbot] [input?] INFO: task hung in uhid_char_release
From:   syzbot <syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, david.rheinsberg@gmail.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ec12f3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152875ef280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1629f75b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95bcbee03439/disk-f7efed9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fd295caa4de/vmlinux-f7efed9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69c038a34b5f/bzImage-f7efed9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com

INFO: task syz-executor188:5032 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor188 state:D
 stack:27424 pid:5032  ppid:5028   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0x1d15/0x5790 kernel/sched/core.c:6709
 schedule+0xde/0x1a0 kernel/sched/core.c:6785
 schedule_timeout+0x276/0x2b0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ce/0x5c0 kernel/sched/completion.c:106
 __flush_work+0x595/0xb60 kernel/workqueue.c:3383
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3470
 uhid_dev_destroy drivers/hid/uhid.c:585 [inline]
 uhid_char_release+0xca/0x210 drivers/hid/uhid.c:663
 __fput+0x289/0xac0 fs/file_table.c:378
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xadc/0x2a30 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa196a81b19
RSP: 002b:00007ffc33991898 EFLAGS: 00000246
 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa196af5330 RCX: 00007fa196a81b19
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 00007ffc33991360 R11: 0000000000000246 R12: 00007fa196af5330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
INFO: task syz-executor188:5038 blocked for more than 145 seconds.
      Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor188 state:D
 stack:28176 pid:5038  ppid:5036   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0x1d15/0x5790 kernel/sched/core.c:6709
 schedule+0xde/0x1a0 kernel/sched/core.c:6785
 schedule_timeout+0x276/0x2b0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ce/0x5c0 kernel/sched/completion.c:106
 __flush_work+0x595/0xb60 kernel/workqueue.c:3383
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3470
 uhid_dev_destroy drivers/hid/uhid.c:585 [inline]
 uhid_char_release+0xca/0x210 drivers/hid/uhid.c:663
 __fput+0x289/0xac0 fs/file_table.c:378
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xadc/0x2a30 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa196a81b19
RSP: 002b:00007ffc33991898 EFLAGS: 00000246
 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa196af5330 RCX: 00007fa196a81b19
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 00007ffc33991360 R11: 0000000000000246 R12: 00007fa196af5330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
INFO: task syz-executor188:5042 blocked for more than 147 seconds.
      Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor188 state:D stack:27136 pid:5042  ppid:5037   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0x1d15/0x5790 kernel/sched/core.c:6709
 schedule+0xde/0x1a0 kernel/sched/core.c:6785
 schedule_timeout+0x276/0x2b0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ce/0x5c0 kernel/sched/completion.c:106
 __flush_work+0x595/0xb60 kernel/workqueue.c:3383
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3470
 uhid_dev_destroy drivers/hid/uhid.c:585 [inline]
 uhid_char_release+0xca/0x210 drivers/hid/uhid.c:663
 __fput+0x289/0xac0 fs/file_table.c:378
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xadc/0x2a30 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa196a81b19
RSP: 002b:00007ffc33991898 EFLAGS: 00000246
 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa196af5330 RCX: 00007fa196a81b19
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 00007ffc33991360 R11: 0000000000000246 R12: 00007fa196af5330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
INFO: task syz-executor188:5046 blocked for more than 150 seconds.
      Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor188 state:D stack:28048 pid:5046  ppid:5029   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0x1d15/0x5790 kernel/sched/core.c:6709
 schedule+0xde/0x1a0 kernel/sched/core.c:6785
 schedule_timeout+0x276/0x2b0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ce/0x5c0 kernel/sched/completion.c:106
 __flush_work+0x595/0xb60 kernel/workqueue.c:3383
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3470
 uhid_dev_destroy drivers/hid/uhid.c:585 [inline]
 uhid_char_release+0xca/0x210 drivers/hid/uhid.c:663
 __fput+0x289/0xac0 fs/file_table.c:378
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xadc/0x2a30 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa196a81b19
RSP: 002b:00007ffc33991898 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa196af5330 RCX: 00007fa196a81b19
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 00007ffc33991360 R11: 0000000000000246 R12: 00007fa196af5330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/7:
1 lock held by rcu_tasks_kthre/13:
 #0: 
ffffffff8c9a1ab0
 (
rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xe60 kernel/rcu/tasks.h:568
1 lock held by rcu_tasks_trace/14:
 #0: 
ffffffff8c9a1770
 (
rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}
, at: rcu_tasks_one_gp+0x31/0xe60 kernel/rcu/tasks.h:568
3 locks held by kworker/1:0/22:
1 lock held by khungtaskd/28:
 #0: ffffffff8c9a26c0 (rcu_read_lock
){....}-{1:2}
, at: debug_show_all_locks+0x51/0x390 kernel/locking/lockdep.c:6615
3 locks held by kworker/1:2/776:
3 locks held by kworker/0:2/919:
3 locks held by kworker/0:3/3948:
2 locks held by getty/4779:
 #0: 
ffff88814a6b7098


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
