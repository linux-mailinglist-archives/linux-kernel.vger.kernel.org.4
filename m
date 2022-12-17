Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587AB64F996
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 16:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLQPEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 10:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLQPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 10:04:48 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1EE0F4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:04:47 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso3683030ilj.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omaK9fMsNTFLQFu8h+rdMbTpBSMkwRzhs2jI7TjkUT0=;
        b=p0o3yahZy/bbbVStRyGPrxw2U0KZYeugqeDrkjKGNw7rjWTM6Y/aK/c0kKQspRh0xc
         wXYKWLOlUqFcsGH0IEXszdILtUJDLIDOLKD/CBWtoxqgxEC9Om0UPQMxcYM89C3/+ulo
         2caZqQ6bkhB4m6iZFl4X4CGY2A7yzninOJ3MBAwf05n6kFT9BZ+AutFEa8nlDqrZk3LX
         35EHPJu3TPe8mqtjT9o1nQOvJ9mrsH/fbX34G2FTWR3801zXt00fEE0Gk1xA8iA5Oehs
         FRrmTensF+gYI2Mq2H+d3+1avgVNImYe6UbahHS2MCTRz44qHIDC8q47wwoS73EGb/jV
         EaTA==
X-Gm-Message-State: ANoB5pnT5fBEK+J2OWJYlNWT9DIkR3dvh8WybiuPuz3IsZDyPjq6WNb3
        tPkxNc2t8hvgkIql470kBH/S+yOjBkx5vU6FoUiOJuq5af2A
X-Google-Smtp-Source: AA0mqf7t8lfDnKiC98KvoSy+fx+/HSUyNi90WFAyDJlm4d+ZKZZrP28jqBjM4GPPNlKj821+oyCqJz09Zyo9A8DPwKFpdQ5G0s4U
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4395:b0:38a:a802:cfe with SMTP id
 bo21-20020a056638439500b0038aa8020cfemr2183751jab.45.1671289487069; Sat, 17
 Dec 2022 07:04:47 -0800 (PST)
Date:   Sat, 17 Dec 2022 07:04:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003198a505f0076823@google.com>
Subject: [syzbot] [udf?] BUG: unable to handle kernel NULL pointer dereference
 in __writepage
From:   syzbot <syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117055e7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55043d38f21f0e0f
dashboard link: https://syzkaller.appspot.com/bug?extid=c27475eb921c46bbdc62
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141da6e7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d81b8b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b78ce281e8c/disk-77856d91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8af6f6a5481b/vmlinux-77856d91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c902de7af92/bzImage-77856d91.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/280fb5acc0d8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 2bff1067 P4D 2bff1067 PUD 1f5dc067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9019 Comm: syz-executor202 Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000be3f6a8 EFLAGS: 00010246
RAX: 1ffffffff1659874 RBX: ffffea0001bf0e00 RCX: ffff8880183c57c0
RDX: 0000000000000000 RSI: ffffc9000be3fb00 RDI: ffffea0001bf0e00
RBP: ffffffff8b2cc3a0 R08: ffffffff81bf03f6 R09: fffffbfff1d200ae
R10: fffffbfff1d200ae R11: 1ffffffff1d200ad R12: dffffc0000000000
R13: ffffea0001bf0e00 R14: ffff8880738dbd28 R15: ffffc9000be3fb00
FS:  00007ff98e385700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001ca8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __writepage+0x60/0x120 mm/page-writeback.c:2537
 write_cache_pages+0x7dd/0x1350 mm/page-writeback.c:2472
 generic_writepages mm/page-writeback.c:2563 [inline]
 do_writepages+0x438/0x690 mm/page-writeback.c:2583
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 file_write_and_wait_range+0x228/0x330 mm/filemap.c:777
 __generic_file_fsync+0x6e/0x190 fs/libfs.c:1132
 generic_file_fsync+0x6f/0xe0 fs/libfs.c:1173
 generic_write_sync include/linux/fs.h:2882 [inline]
 udf_file_write_iter+0x4d6/0x5f0 fs/udf/file.c:176
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7b5/0xbb0 fs/read_write.c:584
 ksys_write+0x19b/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff9967027f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff98e3852f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff996780790 RCX: 00007ff9967027f9
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007ff99678079c R08: 00007ff98e385700 R09: 0000000000000000
R10: 00007ff98e385700 R11: 0000000000000246 R12: 00007ff99674cd70
R13: 00007ff99674c180 R14: 0000000020000c80 R15: 00007ff996780798
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000be3f6a8 EFLAGS: 00010246
RAX: 1ffffffff1659874 RBX: ffffea0001bf0e00 RCX: ffff8880183c57c0
RDX: 0000000000000000 RSI: ffffc9000be3fb00 RDI: ffffea0001bf0e00
RBP: ffffffff8b2cc3a0 R08: ffffffff81bf03f6 R09: fffffbfff1d200ae
R10: fffffbfff1d200ae R11: 1ffffffff1d200ad R12: dffffc0000000000
R13: ffffea0001bf0e00 R14: ffff8880738dbd28 R15: ffffc9000be3fb00
FS:  00007ff98e385700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001ca8e000 CR4: 00000000003506f0
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
