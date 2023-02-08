Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75A068ED26
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBHKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjBHKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:37:50 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6A474CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:37:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso12712760ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVGHhE2THnATfkab42pNWUHuycYTWZMcUywUCZ4LBr8=;
        b=f0jxu7tT+XCIxPKnQFhIsJneua0kPJqxp4tacPn+kel9umm840gbs4WVyW4HxRLfvl
         qQZG+qiwvXmwqtBDi6TQTGnNvQS4pC8yfN8oD75WvX441k/gYTpSdO5QxxAMG56BXhot
         kbueAeawpxPoDizfVwBSfAbuF8KgqDwS/ghTEephZr1KWcFPm3tKvXwVAhjwR06gxUXC
         3i2LJCEMh80kQZxo3tUqQbujfoYIzCwbszo1m7qXSiGw4Hhcw4cbIlftkKZoO1HZGXNm
         xq47tovwCMFz0JFrvCXSjr9dKNlusWqrAWbExwQwZ1HVNWpcFVB6Y1v8XcW2Urv8TMh+
         d8pw==
X-Gm-Message-State: AO0yUKXFBgDxkGdZJQTm2l1pluYHnLadXAck6TH8AAT38WrQJoRyIOkt
        YaAPIRKin/c3RvrN5QKK3NGPbA9X1qgiyrNpAzWu5suWSvyg
X-Google-Smtp-Source: AK7set8cjbunI+/Q0zPzpl8i04XZI8i7r93LJ/UBWBFNdJ8beYxpvMAYXwpFXA2cK1Ut/FyJ8EmPjGG1zLXk++cdyodfN50qASoU
MIME-Version: 1.0
X-Received: by 2002:a92:7608:0:b0:313:bfa3:84f5 with SMTP id
 r8-20020a927608000000b00313bfa384f5mr3778151ilc.122.1675852658688; Wed, 08
 Feb 2023 02:37:38 -0800 (PST)
Date:   Wed, 08 Feb 2023 02:37:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ac93505f42dda96@google.com>
Subject: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
To:     jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17005023480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c6175480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ef5ad9480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=5605, q=143 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294955582-4294945080), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g5605 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28680 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5301 [inline]
 __schedule+0x245a/0x5a60 kernel/sched/core.c:6619
 schedule+0xde/0x1a0 kernel/sched/core.c:6695
 schedule_timeout+0x14e/0x2b0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x190/0x910 kernel/rcu/tree.c:1609
 rcu_gp_kthread+0x23a/0x360 kernel/rcu/tree.c:1808
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5108 Comm: syz-executor192 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x0/0x20 kernel/kcov.c:289
Code: 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 8b 0c 24 48 89 f2 48 89 fe bf 06 00 00 00 e9 f8 fe ff ff 0f 1f 84 00 00 00 00 00 <f3> 0f 1e fa 48 8b 0c 24 40 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9
RSP: 0018:ffffc90000007dd8 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81757653
RDX: fffffbfff1cea2eb RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000000 R12: 0000002a9fc7f679
R13: 0000000000000001 R14: ffffffff91cb6e28 R15: ffff8880775e6f60
FS:  0000555557516300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f88861130 CR3: 0000000072b77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 trace_alarmtimer_fired include/trace/events/alarmtimer.h:73 [inline]
 alarmtimer_fired+0x327/0x670 kernel/time/alarmtimer.c:220
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x600/0xcf0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
 __sysvec_apic_timer_interrupt+0x180/0x660 arch/x86/kernel/apic/apic.c:1113
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_is_held_type+0x103/0x140 kernel/locking/lockdep.c:5767
Code: 00 00 b8 ff ff ff ff 65 0f c1 05 48 c8 ef 75 83 f8 01 75 29 9c 58 f6 c4 02 75 3d 48 f7 04 24 00 02 00 00 74 01 fb 48 83 c4 08 <44> 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 45 31 ed eb b9 0f 0b 48
RSP: 0018:ffffc90003d0f3c8 EFLAGS: 00000282
RAX: 0000000000000046 RBX: 0000000000000002 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c794680 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880773d8000
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8880773d8a60
 lock_is_held include/linux/lockdep.h:288 [inline]
 rcu_read_lock_sched_held+0x3e/0x70 kernel/rcu/update.c:125
 trace_block_dirty_buffer include/trace/events/block.h:58 [inline]
 mark_buffer_dirty+0x445/0x570 fs/buffer.c:1126
 __block_commit_write.constprop.0.isra.0+0x19d/0x330 fs/buffer.c:2108
 block_write_end+0x53/0x220 fs/buffer.c:2187
 generic_write_end+0x8d/0x440 fs/buffer.c:2201
 ext4_da_write_end+0x1f5/0xa50 fs/ext4/inode.c:3174
 generic_perform_write+0x316/0x570 mm/filemap.c:3781
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bf/0x1710 fs/ext4/file.c:700
 call_write_iter include/linux/fs.h:1851 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x14d/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8f887f06a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccec967c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000062 RCX: 00007f8f887f06a9
RDX: 00000000200001c0 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffccec967f0 R09: 00007ffccec967f0
R10: 000000000200a198 R11: 0000000000000246 R12: 00007ffccec967ec
R13: 00007ffccec96820 R14: 00007ffccec96800 R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.925 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
