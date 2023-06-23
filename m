Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8839273BA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFWOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:36:46 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2227E1724
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:36:45 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-342345934a8so4500175ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531004; x=1690123004;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZBDt3VSlZMCbOtP38Q983YuZEFJ3hM8P/mKOfrYCJQ=;
        b=B4fXemzTsBQX1vMQiYH/YcdDtcmLSKRBv904UPJrSaS4hiZjPu5p28BOl3MuKBoUkB
         i0Jumey+12jJ2FjbUTEeo7kCOfDPjPPgrfO+BrN/W83qX1swyxtiC67gxv0bXVazfCtu
         wUnPu13IOZqogLduihvZNSwCxiYV+1L4OPWm506/lZMcpCTBVZafeMu9zp2O/IhWstkA
         UKNQArjxUthkZkH5CTHo2BPPYnu7K4QM3zRjcMHUNu3eW6r1oTotlEYIbx1ST7W+pnfC
         BF90LR61BF2w0sIEWT609rz8K6nmZkRoFAIk8aH9Jg7V7S0FErFxJVgPd6NT4Ss1P6zf
         iVPQ==
X-Gm-Message-State: AC+VfDyEPcLGw0L32gACn7AYMPhlFob5Y1cbX6fYlWK0X4wkDBuhMcel
        7/XDwsOanHbcyb+cHsJccimuFZB8z8PKctpuGazHaxzkZogl
X-Google-Smtp-Source: ACHHUZ6GklxOJotBu/I9XgXKouxBmNr5XKHhpiiyUqdj5d+Oca3tSFdoNTo6XTtaZWv52Xj0JFqOxlKXfXS54jOBaNoWfEGOZHc+
MIME-Version: 1.0
X-Received: by 2002:a92:c0c8:0:b0:33e:6d38:8f7b with SMTP id
 t8-20020a92c0c8000000b0033e6d388f7bmr8359179ilf.1.1687531004374; Fri, 23 Jun
 2023 07:36:44 -0700 (PDT)
Date:   Fri, 23 Jun 2023 07:36:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010353a05fecceea0@google.com>
Subject: [syzbot] [net?] WARNING in inet_sock_destruct (4)
From:   syzbot <syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, jacob.e.keller@intel.com, jiri@nvidia.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160cc82f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160aacb7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c115d3280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c09bcd4ec365/disk-45a3e24f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03549b639718/vmlinux-45a3e24f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91f203e5f63e/bzImage-45a3e24f.xz

The issue was bisected to:

commit 565b4824c39fa335cba2028a09d7beb7112f3c9a
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Mon Feb 6 09:41:51 2023 +0000

    devlink: change port event netdev notifier from per-net to global

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110a1a5b280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130a1a5b280000
console output: https://syzkaller.appspot.com/x/log.txt?x=150a1a5b280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
Fixes: 565b4824c39f ("devlink: change port event netdev notifier from per-net to global")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5025 at net/ipv4/af_inet.c:154 inet_sock_destruct+0x6df/0x8a0 net/ipv4/af_inet.c:154
Modules linked in:
CPU: 0 PID: 5025 Comm: syz-executor250 Not tainted 6.4.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:inet_sock_destruct+0x6df/0x8a0 net/ipv4/af_inet.c:154
Code: ff e8 c5 9f e0 f8 0f 0b e9 07 fe ff ff e8 b9 9f e0 f8 0f 0b e9 3f fe ff ff e8 ad 9f e0 f8 0f 0b e9 95 fd ff ff e8 a1 9f e0 f8 <0f> 0b e9 9f fe ff ff e8 d5 6a 33 f9 e9 7a fc ff ff 4c 89 e7 e8 08
RSP: 0018:ffffc90000007de8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000fffff000 RCX: 0000000000000100
RDX: ffff8880792f8000 RSI: ffffffff88a3a73f RDI: 0000000000000005
RBP: ffff88814aa99980 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffff000 R11: 0000000000094001 R12: ffff88814aa999a8
R13: ffff88814aa99bf4 R14: ffffc90000007ed8 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f579b4f6ec8 CR3: 000000000c571000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __sk_destruct+0x4d/0x770 net/core/sock.c:2130
 rcu_do_batch kernel/rcu/tree.c:2115 [inline]
 rcu_core+0x806/0x1ad0 kernel/rcu/tree.c:2377
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:write_comp_data+0x3c/0x90 kernel/kcov.c:236
Code: 01 00 00 49 89 f8 65 48 8b 14 25 c0 bb 03 00 a9 00 01 ff 00 74 0e 85 f6 74 59 8b 82 0c 16 00 00 85 c0 74 4f 8b 82 e8 15 00 00 <83> f8 03 75 44 48 8b 82 f0 15 00 00 8b 92 ec 15 00 00 48 8b 38 48
RSP: 0018:ffffc90003a7fbf8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90003a7b020 RCX: ffffffff814d76d1
RDX: ffff8880792f8000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: ffff8880792f8000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000094001 R12: 0000000000000000
R13: ffffc90003a78000 R14: dffffc0000000000 R15: ffff8880792f85f8
 stack_not_used include/linux/sched/task_stack.h:107 [inline]
 check_stack_usage kernel/exit.c:776 [inline]
 do_exit+0x17f1/0x29b0 kernel/exit.c:918
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x2318/0x25b0 kernel/signal.c:2876
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f579b4a1d39
Code: Unable to access opcode bytes at 0x7f579b4a1d0f.
RSP: 002b:00007f579b431308 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f579b52a4d8 RCX: 00007f579b4a1d39
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f579b52a4d8
RBP: 00007f579b52a4d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f579b4f72c0
R13: 00007f579b52a4dc R14: 00007f579b431400 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	01 00                	add    %eax,(%rax)
   2:	00 49 89             	add    %cl,-0x77(%rcx)
   5:	f8                   	clc
   6:	65 48 8b 14 25 c0 bb 	mov    %gs:0x3bbc0,%rdx
   d:	03 00
   f:	a9 00 01 ff 00       	test   $0xff0100,%eax
  14:	74 0e                	je     0x24
  16:	85 f6                	test   %esi,%esi
  18:	74 59                	je     0x73
  1a:	8b 82 0c 16 00 00    	mov    0x160c(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 4f                	je     0x73
  24:	8b 82 e8 15 00 00    	mov    0x15e8(%rdx),%eax
* 2a:	83 f8 03             	cmp    $0x3,%eax <-- trapping instruction
  2d:	75 44                	jne    0x73
  2f:	48 8b 82 f0 15 00 00 	mov    0x15f0(%rdx),%rax
  36:	8b 92 ec 15 00 00    	mov    0x15ec(%rdx),%edx
  3c:	48 8b 38             	mov    (%rax),%rdi
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
