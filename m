Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1AC70AF05
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjEUQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEUQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:20:04 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44987CD
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 09:20:02 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7603d830533so155273739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684686001; x=1687278001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKti4Lzlj/MIB8/k7a3P6fC53vRz976q8EbCwu7eYKY=;
        b=kOk5uiRNGoYrK5K74Q0cEYGV7GP1sLlSsvVd57NGAs3krw/PSfJCREpvtl2rwP5+MS
         KDw894xqYzOjnF8va3+o6+dDDJO0IllUC8k+7k70l5HUMOKNL2LMCBz1KW5Q8jREsMSd
         tn4e0nbzF+oPvLzZRwzGPOx1yuA8quswctEcv/v2hm2KEtXU8E3twBadTr6DnoPS3FHo
         cwCf3w1Ylq4XBA1vUMoDtYcavxKnqu3ffVhD4mMO0Iyj4oUT8O/B3LRqDsHncWHzGlG6
         J4gLdUzgmBUpS6G+Si7Mti+Zn3MiyRlFUYDjHUQ1DFJi3/SUsj0YQJSDaXGaebV7nQwz
         xdMg==
X-Gm-Message-State: AC+VfDzP8AmapyPcrYVJmN+8EM7C6SiZzCiu/kbk7pyBNwVIO+1n1GOW
        3FoYm06ojmuiqwHdCesBxg+0EUyuoDd378Khscftgp8DCPYf
X-Google-Smtp-Source: ACHHUZ6D9s9rOdNBKXxS13Fz+ZrUs8ugsA4dTQL62q9KEx2zFXOdgt9URg8GkzcCoMeXgEOLpdda/tq97cFuMd3+PcwvYSGI0i5X
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ac4:b0:763:b184:fe92 with SMTP id
 m4-20020a0566022ac400b00763b184fe92mr10927112iov.0.1684686001526; Sun, 21 May
 2023 09:20:01 -0700 (PDT)
Date:   Sun, 21 May 2023 09:20:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ade4f305fc36868f@google.com>
Subject: [syzbot] [mm?] kernel BUG in __page_table_check_zero
From:   syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
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

HEAD commit:    1b66c114d161 Merge tag 'nfsd-6.4-1' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ef2e5a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0db1213414a978
dashboard link: https://syzkaller.appspot.com/bug?extid=7a9bbb158a7a1071eb27
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b9e86280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a85bd6280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac769e66fb5a/disk-1b66c114.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bee287306a14/vmlinux-1b66c114.xz
kernel image: https://storage.googleapis.com/syzbot-assets/342e345ae447/bzImage-1b66c114.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fec20228c89
RDX: 0000000001000002 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007fff16e19850 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000011012 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:142!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5004 Comm: syz-executor464 Not tainted 6.4.0-rc2-syzkaller-00015-g1b66c114d161 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:__page_table_check_zero+0x175/0x1c0 mm/page_table_check.c:142
Code: 24 08 80 38 00 75 47 48 03 2d f7 d4 04 10 49 83 c4 01 e9 00 ff ff ff e8 79 50 a2 ff 0f 0b e8 72 50 a2 ff 0f 0b e8 6b 50 a2 ff <0f> 0b e8 64 50 a2 ff 0f 0b e8 5d 50 a2 ff 48 89 ef 48 83 c4 10 5b
RSP: 0018:ffffc90003b3fa10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880220c0000 RSI: ffffffff81e1f265 RDI: 0000000000000005
RBP: ffff888016090000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffffffff18f47c1 R12: 0000000000000000
R13: 000000000000000a R14: 0000000000000400 R15: dffffc0000000000
FS:  00005555572c2300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000064392c CR3: 000000007abec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_table_check_free include/linux/page_table_check.h:46 [inline]
 free_pages_prepare mm/page_alloc.c:1303 [inline]
 __free_pages_ok+0x9c8/0x1060 mm/page_alloc.c:1441
 hcd_buffer_free+0x1b9/0x250 drivers/usb/core/buffer.c:163
 usb_free_coherent+0x6b/0x80 drivers/usb/core/usb.c:1035
 dec_usb_memory_use_count+0x253/0x3f0 drivers/usb/core/devio.c:197
 usbdev_mmap+0x8d8/0xc40 drivers/usb/core/devio.c:277
 call_mmap include/linux/fs.h:1873 [inline]
 mmap_region+0x694/0x28d0 mm/mmap.c:2652
 do_mmap+0x831/0xf60 mm/mmap.c:1394
 vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fec20228c89
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff16e19838 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fec20228c89
RDX: 0000000001000002 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007fff16e19850 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000011012 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__page_table_check_zero+0x175/0x1c0 mm/page_table_check.c:142
Code: 24 08 80 38 00 75 47 48 03 2d f7 d4 04 10 49 83 c4 01 e9 00 ff ff ff e8 79 50 a2 ff 0f 0b e8 72 50 a2 ff 0f 0b e8 6b 50 a2 ff <0f> 0b e8 64 50 a2 ff 0f 0b e8 5d 50 a2 ff 48 89 ef 48 83 c4 10 5b
RSP: 0018:ffffc90003b3fa10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880220c0000 RSI: ffffffff81e1f265 RDI: 0000000000000005
RBP: ffff888016090000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffffffff18f47c1 R12: 0000000000000000
R13: 000000000000000a R14: 0000000000000400 R15: dffffc0000000000
FS:  00005555572c2300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056248b8b7008 CR3: 000000007abec000 CR4: 00000000003506f0
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
