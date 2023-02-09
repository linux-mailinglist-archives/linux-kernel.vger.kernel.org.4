Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06068FED5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBIEa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjBIEaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:30:46 -0500
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CADF3F2AE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:30:09 -0800 (PST)
Received: by mail-io1-xd46.google.com with SMTP id k5-20020a6bf705000000b0070483a64c60so514344iog.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 20:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvwnVQ+OsTvO/R4s7QHo3J3Y+IsgRrC0rLTHXRjAvIE=;
        b=cmvsdR4fHnQtytylJbZszW5nZHpTgRHVk4a7pnjYkDFp4U9zTjwwUMCp4ebI+tsgdq
         UhEtFA1y453taPttlsK4OlUfCMxONPwbrvsotkwd6pYBhKK404swxHTtd2rr1+LLa+Mw
         onKPpO3wB1yawftfzFYCCzblIX6zTFlWnty7HsjBt6k+wbCXnaNbbcrjyZn4kuvAREDp
         1GgWF94/gmel92LYwPIIaDqsvt8dNGL4r8mwRL2tBW5Vidz+kEpkTYY7iF6FiAi+HufS
         XVWQGVY/cv/J4JXENKz06GMZH3fQWmJXiSwdz53KOYEf7UO/BE/GE4L0dWO4goIQF0Jj
         RRaQ==
X-Gm-Message-State: AO0yUKWxyjBP8r4Zj2JAAkDu4NXUouxyi09lWvlvboytpLfb1F0OtzqO
        PkmCyB8gdFCqGb4uy+IxU15SYnIeOhF97wpaDRbis2aERJZjdSo=
X-Google-Smtp-Source: AK7set+oeDrxd4GzIaxkIRRkqeNUsielY0Xsb2Vxvx2EuvE1bdyY+lsqTz77lldVZywpvBnzPOwdHD5bVC1RJHS33ttYOC3UGhMf
MIME-Version: 1.0
X-Received: by 2002:a6b:6407:0:b0:71b:3f4f:95f9 with SMTP id
 t7-20020a6b6407000000b0071b3f4f95f9mr5368985iog.30.1675916681161; Wed, 08 Feb
 2023 20:24:41 -0800 (PST)
Date:   Wed, 08 Feb 2023 20:24:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074335b05f43cc203@google.com>
Subject: [syzbot] [reiserfs?] BUG: corrupted list in percpu_counter_destroy
From:   syzbot <syzbot+6b1a2e744e37db9f50b3@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b014c5480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=6b1a2e744e37db9f50b3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127247a5480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cd186d480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fbee878c2283/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b1a2e744e37db9f50b3@syzkaller.appspotmail.com

sshd[5074]: segfault at 200000001 ip 0000000200000001 sp 00007ffed2745410 error 14 in sshd[563ab7bc0000+b000] likely on CPU 0 (core 0, socket 0)
Code: Unable to access opcode bytes at 0x1ffffffd7.
list_del corruption. prev->next should be ffff88807a4b71e8, but was 0000000200000001. (prev=ffff8880761b16c8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:59!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5074 Comm: sshd Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__list_del_entry_valid+0x11f/0x1b0 lib/list_debug.c:59
Code: 07 a7 8a e8 f3 09 4b fd 0f 0b 48 89 ca 48 c7 c7 e0 07 a7 8a e8 e2 09 4b fd 0f 0b 4c 89 c2 48 c7 c7 40 08 a7 8a e8 d1 09 4b fd <0f> 0b 48 89 d1 48 c7 c7 c0 08 a7 8a 4c 89 c2 e8 bd 09 4b fd 0f 0b
RSP: 0018:ffffc90003bbfaf8 EFLAGS: 00010086

RAX: 000000000000006d RBX: ffff88807a4b71a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8168dfbc RDI: 0000000000000005
RBP: ffff88807a4b71a0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: 0000000000000292
R13: ffff88807a4b71e8 R14: ffff88807a4b71f0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000040048 CR3: 0000000027e6d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 percpu_counter_destroy.part.0+0x4f/0x200 lib/percpu_counter.c:198
 percpu_counter_destroy+0x3c/0x50 lib/percpu_counter.c:191
 __mmdrop+0x294/0x470 kernel/fork.c:800
 mmdrop include/linux/sched/mm.h:50 [inline]
 __mmput+0x3fd/0x4c0 kernel/fork.c:1220
 mmput+0x60/0x70 kernel/fork.c:1231
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9d7/0x2b60 kernel/exit.c:856
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 get_signal+0x2321/0x25b0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 exc_page_fault+0xc0/0x170 arch/x86/mm/fault.c:1557
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x200000001
Code: Unable to access opcode bytes at 0x1ffffffd7.
RSP: 002b:00007ffed2745410 EFLAGS: 00010202

RAX: 00000000ffffffff RBX: 0000000200000001 RCX: 00007fec0d6ead83
RDX: fffffffffffffea0 RSI: 0000563ab9bf6f40 RDI: 000000000000000a
RBP: 0000000000040048 R08: 00007ffed27453d0 R09: 00007ffed27453e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000001 R14: 00007ffed2745458 R15: 00007ffed27454d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid+0x11f/0x1b0 lib/list_debug.c:59
Code: 07 a7 8a e8 f3 09 4b fd 0f 0b 48 89 ca 48 c7 c7 e0 07 a7 8a e8 e2 09 4b fd 0f 0b 4c 89 c2 48 c7 c7 40 08 a7 8a e8 d1 09 4b fd <0f> 0b 48 89 d1 48 c7 c7 c0 08 a7 8a 4c 89 c2 e8 bd 09 4b fd 0f 0b
RSP: 0018:ffffc90003bbfaf8 EFLAGS: 00010086

RAX: 000000000000006d RBX: ffff88807a4b71a0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8168dfbc RDI: 0000000000000005
RBP: ffff88807a4b71a0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: 0000000000000292
R13: ffff88807a4b71e8 R14: ffff88807a4b71f0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000040048 CR3: 0000000027e6d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
