Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549C5690034
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBIGHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBIGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:07:20 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD83E0AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:07:15 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id q12-20020a6b8e0c000000b0071d8eef7c67so690843iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 22:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HCjXYfu43QgaAdO6bl8QaUVIzuCoE77Ts2+v/GPzK8=;
        b=tHugBsVsmSfNLYxFPVJsnEj7BmCOeL6ANR4AZJlnEdPo9PZ5mT/PkCR9ccTClXfanu
         a5g0Z75QiFz1AYKw8SMCwe6oumFbh1BCBCTbO7AOzMvc4E0HNvvJfksHWel25Yd5pCIc
         euFC2VChuuzMYPoZOUcD/Yz1BfNiOMBgSxP5gSgnUol7gxvMtgT4tg1b2ohFKzpLwf7c
         DAVKXgyQJiKYHZBjjcKVjTPKU0ydFWpFyhyeUIV8CfhOFS/BsfNIFfu7KVWEMmVE2ih3
         wFVqqUTZtfwFcdW4mxmnY+uFXuqU7V5AnV5WrET6bF1lrwRgt2XiP1LPpqax4qGRmvzp
         jYKQ==
X-Gm-Message-State: AO0yUKXLzEhWSZYBotf2Ix+px7dNrJ0qnJeOudZyIdl7z8RW2gqqIYGZ
        3da7QLdjA1Ry/GVwPDR7fRicQhQjSIACcj+IdKGBMAD2pLnq
X-Google-Smtp-Source: AK7set/e+/RFE5eloitpTnzb/WMHrsZin2UiF2UYGTAxWS4uzGbrjPvSmB8M6HDcsZpjdTh4En06x5uq95f7bGzM4NC+29+qroSC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:bc2:b0:3b6:3d10:3336 with SMTP id
 g2-20020a0566380bc200b003b63d103336mr6280398jad.85.1675922835248; Wed, 08 Feb
 2023 22:07:15 -0800 (PST)
Date:   Wed, 08 Feb 2023 22:07:15 -0800
In-Reply-To: <20230209010659.2012-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000441ff805f43e31ec@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
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
INFO: rcu detected stall in ext4_file_write_iter

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=10829, q=65 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294957416-4294946914), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g10829 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5793 Comm: syz-executor.0 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1691 [inline]
RIP: 0010:__hrtimer_run_queues+0x237/0x1200 kernel/time/hrtimer.c:1759
Code: 74 08 3c 03 0f 8e 5b 0f 00 00 48 8b 44 24 70 4c 89 f7 c7 80 20 0a 00 00 01 00 00 00 48 8b 44 24 28 ff d0 48 c7 c2 00 f2 40 8c <89> 44 24 5c 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00
RSP: 0018:ffffc900001e0de0 EFLAGS: 00000082
RAX: 0000000000000001 RBX: ffffffff8e7519c0 RCX: 0000000000000000
RDX: ffffffff8c40f200 RSI: ffffffff81757b84 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880b992b968
R13: ffff8880b992b980 R14: ffff88802a5a0828 R15: ffff8880b992b800
FS:  00007f24a25b3700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f24a1915829 CR3: 000000001fee8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1821
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
 __sysvec_apic_timer_interrupt+0x180/0x660 arch/x86/kernel/apic/apic.c:1113
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:copy_page_from_iter_atomic+0xb13/0x1180 lib/iov_iter.c:821
Code: 03 44 01 e3 42 80 3c 28 00 0f 85 1b 06 00 00 4c 8d 45 08 89 d8 c1 eb 0c 89 de 4c 89 c2 25 ff 0f 00 00 48 c1 e6 06 48 03 75 00 <48> c1 ea 03 48 b9 00 00 00 00 00 16 00 00 42 0f b6 14 2a 48 01 ce
RSP: 0018:ffffc9000647f448 EFLAGS: 00000282
RAX: 00000000000006c0 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88807a22a408 RSI: ffffea0001943640 RDI: ffff88807a22a40c
RBP: ffff88807a22a400 R08: ffff88807a22a408 R09: 0000000000000002
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000020
 generic_perform_write+0x2ca/0x570 mm/filemap.c:3778
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
RIP: 0033:0x7f24a188c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f24a25b3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f24a19abf80 RCX: 00007f24a188c0c9
RDX: 00000000200001c0 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f24a18e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000200a198 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc18815df R14: 00007f24a25b3300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
jts hrtimer tick_sched_timer+0x0/0x120 kernel/time/tick-sched.c:212 runs more than 20 ticks
WARNING: CPU: 0 PID: 5791 at kernel/time/hrtimer.c:1693 __run_hrtimer kernel/time/hrtimer.c:1693 [inline]
WARNING: CPU: 0 PID: 5791 at kernel/time/hrtimer.c:1693 __hrtimer_run_queues+0xf76/0x1200 kernel/time/hrtimer.c:1759
Modules linked in:
CPU: 0 PID: 5791 Comm: syz-executor.1 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1693 [inline]
RIP: 0010:__hrtimer_run_queues+0xf76/0x1200 kernel/time/hrtimer.c:1759
Code: 96 10 00 e9 1e f3 ff ff bd 01 00 00 00 e8 72 9a 10 00 48 8b 74 24 28 48 c7 c7 c0 d5 4e 8a c6 05 5e e1 eb 0c 01 e8 3a 2b d8 ff <0f> 0b e8 53 9a 10 00 31 ff 89 ee e8 5a 96 10 00 40 84 ed 0f 84 e3
RSP: 0018:ffffc90000007de0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff8e7519c0 RCX: 0000000000000000
RDX: ffff88807d998000 RSI: ffffffff814c0217 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880b982b968
R13: ffff8880b982b880 R14: ffff8880b982c120 R15: ffff8880b982b800
FS:  00007fee9873f700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fee97b15829 CR3: 0000000017dc5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1821
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
 __sysvec_apic_timer_interrupt+0x180/0x660 arch/x86/kernel/apic/apic.c:1113
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:deref_stack_reg arch/x86/kernel/unwind_orc.c:379 [inline]
RIP: 0010:unwind_next_frame+0xa9b/0x1f60 arch/x86/kernel/unwind_orc.c:558
Code: 89 ef 48 89 4c 24 30 4c 89 de 4c 89 44 24 28 4c 89 5c 24 20 e8 a6 f3 ff ff 4d 8d 4d 34 84 c0 0f 84 07 f9 ff ff 4c 8b 5c 24 20 <48> 89 ee 48 ba 00 00 00 00 00 fc ff df 48 c1 ee 03 4c 89 df e8 8c
RSP: 0018:ffffc900064ef588 EFLAGS: 00000202
RAX: ffffc900064f0001 RBX: 0000000000000001 RCX: 0000000000000001
RDX: ffffc900064efd01 RSI: ffffc900064efd80 RDI: ffffc900064ef608
RBP: ffffc900064ef640 R08: ffffffff8f09573c R09: ffffc900064ef62c
R10: 0000000000000001 R11: ffffc900064efd80 R12: ffffc900064ef62d
R13: ffffc900064ef5f8 R14: ffffc900064efd88 R15: ffffffff8f095740
 arch_stack_walk+0x81/0xf0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x90/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x5a/0xd0 mm/slab_common.c:980
 kmalloc_array include/linux/slab.h:636 [inline]
 kcalloc include/linux/slab.h:667 [inline]
 iter_file_splice_write+0x16c/0xc90 fs/splice.c:625
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
RIP: 0033:0x7fee97a8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee9873f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fee97babf80 RCX: 00007fee97a8c0c9
RDX: 00000000200001c0 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007fee97ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000200a198 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffebfc242ff R14: 00007fee9873f300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1666c52f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1097b5a3480000

