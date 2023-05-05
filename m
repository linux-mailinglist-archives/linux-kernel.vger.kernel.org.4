Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03BB6F7A22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEEAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEAqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:46:39 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114212496
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 17:46:38 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3318baf6a8bso7709635ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 17:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683247598; x=1685839598;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ly3upXfOU87n1WNn5SnM/n/ljeXykq3eZ0P49YkeHA=;
        b=eNq0pc6ZimxWcVSkV5G5KhJSQzGM+ouoXwtB8ZBDEk2XQQwGbH1rMYEH+Z6T0/ZhAf
         xYd9KUpYvotKuv8aFkLkH4rbl/MDnFwzWzC0hZOwnt+yzH6oM+t9T9mt3XVkGK88VNOo
         IoJQkOguYW3E8LfNFxNb2mKWAgjhsV4ykfMC5KFXOdUshjuSs7Oqx7ftVg/eiQsncjBm
         g4puiX4LMjsiaDib6Beme3LVivlJ/VmBnkaZiZ6WxCQaMdr/CGdgQotsMUSMNU0lu9Bk
         jFaKoEWPilpGnNejPrQr6Y3zQLL8AN+14nKUjcntyCQSd8y/6hsfsvOS7jeCfTAJu1x5
         bBwQ==
X-Gm-Message-State: AC+VfDwljoJDQRSMAxOx4FKrne0jnHH9CoVSXX2U/SwcaowvR+NAFL1a
        lUZW8FEtz/KyKqC1UauPcYPUbMzEg2IIrZ3mY3tOd+zvd+Ag
X-Google-Smtp-Source: ACHHUZ4rX8LakkEVY8CwAhVqYmUZ+vsQ1lnzwngg1B2uiw0HIrDX6ECZjkdqWktxZ9vk5J+qp5nmas9L2SvNtMEhRRBo6vaFE5zk
MIME-Version: 1.0
X-Received: by 2002:a92:d782:0:b0:32b:a8bd:50f7 with SMTP id
 d2-20020a92d782000000b0032ba8bd50f7mr430501iln.2.1683247597978; Thu, 04 May
 2023 17:46:37 -0700 (PDT)
Date:   Thu, 04 May 2023 17:46:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000258e5e05fae79fc1@google.com>
Subject: [syzbot] [mm?] kernel BUG in page_table_check_clear
From:   syzbot <syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@soleen.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    825a0714d2b3 Merge tag 'efi-next-for-v6.4' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c10d5fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37e26f1fda939e72
dashboard link: https://syzkaller.appspot.com/bug?extid=fcf1a817ceb50935ce99
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ad4054280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f5f594280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31a9dc70b22e/disk-825a0714.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a216970773c6/vmlinux-825a0714.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3da9c8621c64/bzImage-825a0714.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:83!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5684 Comm: syz-executor989 Not tainted 6.3.0-syzkaller-11733-g825a0714d2b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:page_table_check_clear.part.0+0x323/0x380 mm/page_table_check.c:83
Code: ff 89 de e8 3f 62 a2 ff 85 db 0f 89 7c fe ff ff e8 12 66 a2 ff 0f 0b e8 0b 66 a2 ff 0f 0b e8 04 66 a2 ff 0f 0b e8 fd 65 a2 ff <0f> 0b e8 f6 65 a2 ff 0f 0b 48 c7 c7 00 f7 e6 91 e8 f8 2c f5 ff e9
RSP: 0018:ffffc900044ff838 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888013cb7010 RCX: 0000000000000000
RDX: ffff888029f25940 RSI: ffffffff81e1f843 RDI: 0000000000000005
RBP: ffff888013cb6fd0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000077cb5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_table_check_clear include/linux/mmzone.h:2003 [inline]
 __page_table_check_pte_clear+0x265/0x2b0 mm/page_table_check.c:155
 page_table_check_pte_clear include/linux/page_table_check.h:55 [inline]
 ptep_get_and_clear_full arch/x86/include/asm/pgtable.h:1086 [inline]
 zap_pte_range mm/memory.c:1413 [inline]
 zap_pmd_range mm/memory.c:1563 [inline]
 zap_pud_range mm/memory.c:1592 [inline]
 zap_p4d_range mm/memory.c:1613 [inline]
 unmap_page_range+0x2aa6/0x38e0 mm/memory.c:1634
 unmap_single_vma+0x19a/0x2b0 mm/memory.c:1680
 unmap_vmas+0x234/0x380 mm/memory.c:1719
 exit_mmap+0x190/0x930 mm/mmap.c:3111
 __mmput+0x128/0x4c0 kernel/fork.c:1350
 mmput+0x60/0x70 kernel/fork.c:1372
 exit_mm kernel/exit.c:564 [inline]
 do_exit+0x9d7/0x2960 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0c2f233679
Code: Unable to access opcode bytes at 0x7f0c2f23364f.
RSP: 002b:00007ffc87dd3aa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f0c2f2a83f0 RCX: 00007f0c2f233679
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 00007f0c2f2a83f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:page_table_check_clear.part.0+0x323/0x380 mm/page_table_check.c:83
Code: ff 89 de e8 3f 62 a2 ff 85 db 0f 89 7c fe ff ff e8 12 66 a2 ff 0f 0b e8 0b 66 a2 ff 0f 0b e8 04 66 a2 ff 0f 0b e8 fd 65 a2 ff <0f> 0b e8 f6 65 a2 ff 0f 0b 48 c7 c7 00 f7 e6 91 e8 f8 2c f5 ff e9
RSP: 0018:ffffc900044ff838 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888013cb7010 RCX: 0000000000000000
RDX: ffff888029f25940 RSI: ffffffff81e1f843 RDI: 0000000000000005
RBP: ffff888013cb6fd0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000077cb5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
