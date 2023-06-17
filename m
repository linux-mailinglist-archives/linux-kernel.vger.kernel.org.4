Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3976733F6A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbjFQIFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbjFQIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:05:04 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A61BDF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:05:03 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77d89a08a50so147092439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989102; x=1689581102;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VRqqk+KnI8bsq63moaUWeoHIlR4mBeW0CyKozfhswNU=;
        b=Q8KGDNSjApSWZmN/5LLPyAeLnrv9sbYZlZWAjrn+OBqfvXra54n6pgAxDfzUszos//
         AOeVzXmM47E9cYNuS27FAK4BrfejFbT6b8QsShoc29lm5ef2tAqVYhxst4qyMwDWWBwU
         xvUy3g9nFC0Ueh57pxeLSt+0T4JUBcYSoCCSXrbgGX3rBqq427IDnS7buxFGfcdhp4eB
         daa2W3HDzUBDl+Ws9DjmgZUEROe/46hkeQCshak1bLqNYrJ+vpMh/5MdrreuojgEkPnj
         kB0lLkIGL9lp0ZyFouB1wHnNXxWQUUpBCaZvUWAiLarJd2heYcajl4EwgRZoqvRY7KAs
         guEA==
X-Gm-Message-State: AC+VfDze9YMBrC9hsbVoS45N7uUaI6FuWpn4Y7s+XJHS9JB/Nt703Fqz
        Yj1uD0BuKP+ynC4WLX+b9c9VHHsj7R+mF+rKhnrsitPPECP/
X-Google-Smtp-Source: ACHHUZ62fPJVvXvzTsmYmAXHcXDDK+ZVeEDx0Y3e3i7f9Ssn/Mxma2nP2a/rQxe7pK2insHlzfYQkml8Se73M6rfx/gIFdpeBRkj
MIME-Version: 1.0
X-Received: by 2002:a6b:7b46:0:b0:777:b438:2926 with SMTP id
 m6-20020a6b7b46000000b00777b4382926mr1037633iop.3.1686989102697; Sat, 17 Jun
 2023 01:05:02 -0700 (PDT)
Date:   Sat, 17 Jun 2023 01:05:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034d5e005fe4ec280@google.com>
Subject: [syzbot] [block?] WARNING in blkdev_get_by_dev
From:   syzbot <syzbot+00cd27751f78817f167b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, hare@suse.de, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    1f6ce8392d6f Add linux-next specific files for 20230613
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17899407280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=00cd27751f78817f167b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16102c55280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1202453b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d9bf45aeae9/disk-1f6ce839.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0b03ef83e17/vmlinux-1f6ce839.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6c21a24174d/bzImage-1f6ce839.xz

The issue was bisected to:

commit 2736e8eeb0ccdc71d1f4256c9c9a28f58cc43307
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 8 11:02:43 2023 +0000

    block: use the holder as indication for exclusive opens

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1164889b280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1364889b280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1564889b280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00cd27751f78817f167b@syzkaller.appspotmail.com
Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5024 at block/bdev.c:794 blkdev_get_by_dev.part.0+0x8ea/0xb50 block/bdev.c:794
Modules linked in:
CPU: 1 PID: 5024 Comm: syz-executor231 Not tainted 6.4.0-rc6-next-20230613-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:blkdev_get_by_dev.part.0+0x8ea/0xb50 block/bdev.c:794
Code: 44 24 08 e8 c8 94 7c fd 48 85 ed 4c 63 6c 24 08 0f 85 5f fe ff ff e9 ca fe ff ff e8 40 62 e3 fd e9 fe f8 ff ff e8 86 23 90 fd <0f> 0b 49 c7 c5 fb ff ff ff e9 c2 fe ff ff e8 73 23 90 fd 48 8b 44
RSP: 0018:ffffc90003a0fc98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801e5f2e00 RCX: 0000000000000000
RDX: ffff88807e089dc0 RSI: ffffffff83f4524a RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000001 R12: ffff88801fc56000
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000004
FS:  0000555556bcf300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007ceb9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blkdev_get_by_dev+0x79/0x80 block/bdev.c:845
 disk_scan_partitions+0x1e2/0x300 block/genhd.c:368
 blkdev_common_ioctl+0x5b8/0x1a40 block/ioctl.c:531
 blkdev_ioctl+0x24f/0x760 block/ioctl.c:600
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9e3c0e35c9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc336b7018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e3c0e35c9
RDX: 0000000000000000 RSI: 000000000000125f RDI: 0000000000000003
RBP: 00007f9e3c0a30d0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 00007f9e3c0a3160
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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
