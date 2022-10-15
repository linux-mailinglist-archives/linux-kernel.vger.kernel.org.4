Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D949E5FFBF5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJOU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJOU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 16:59:46 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F071021
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 13:59:44 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g13-20020a056e021e0d00b002fc57cd18e3so6350382ila.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 13:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH9dVoHRUBan0sgayrCVSm8yxgRDX6QPzKwlZYOrzi0=;
        b=Kr0SPprXea5fx8nNj5eqvhpQSSSJNiEy2q5MQ6x/OAZIDOHrgJC6VO8qTnSGY7tnqU
         W5DUeRSRyOga8T9Z0WHkNYyaeZD2gxnumJYCqIbeVACxIbVB2DK+yqZvfJ/XvL4FY6h+
         uCkiRbWibyg5RabUoWxCQWKY8Ll/k++5eIwemMy3UB1Xu5NSTBjGi2LGk5d7PUomJSVV
         OaMD4/8QdntZi40u80IiqxZXI8/WrLa1CyZUND52TwskmbQIx8YXyGh1ZJMEPFqQ3IfD
         g6Gj058n8lNZMpavB2XmYNYs/BfUSOdkQONbHvcqi6LjrNqhsJesorCKTQNrUvfNLGuR
         Qnwg==
X-Gm-Message-State: ACrzQf2AI12GSKmbGWv/mhzoewQzvpmvi+VzeHzOsMP2NwHomC3DctJz
        H+Preiq2pLDzuK1XH6PxvJcxVjOhTMdz3C6wbbROCn1x88gD
X-Google-Smtp-Source: AMsMyM4+AFJcSIigzEZInVmd24TPQ0p81z/mCmHRm9+xh8qz36ZFYrqA6ddQ1G6JuQlSikb4x+a/kbryfvoRwPkMKKw4Qp3T51AI
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1616:b0:6bc:ac72:e6a4 with SMTP id
 x22-20020a056602161600b006bcac72e6a4mr1678691iow.67.1665867583902; Sat, 15
 Oct 2022 13:59:43 -0700 (PDT)
Date:   Sat, 15 Oct 2022 13:59:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094d9bd05eb190572@google.com>
Subject: [syzbot] kernel BUG in reiserfs_in_journal
From:   syzbot <syzbot+79bf80830388272ba2f9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        jlayton@kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122b2026880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=79bf80830388272ba2f9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1120a464880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176bead6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/68b2c50cb1a1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79bf80830388272ba2f9@syzkaller.appspotmail.com

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:505!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3614 Comm: syz-executor429 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:reiserfs_in_journal+0xa9b/0xaa0 fs/reiserfs/journal.c:505
Code: e8 da 45 b4 ff e9 15 f6 ff ff 48 8b 4c 24 30 80 e1 07 80 c1 03 38 c1 7c a8 48 8b 7c 24 30 e8 bc 45 b4 ff eb 9c e8 a5 da 60 ff <0f> 0b 0f 1f 00 55 41 57 41 56 41 55 41 54 53 50 49 89 fc 49 be 00
RSP: 0018:ffffc90003dbee80 EFLAGS: 00010293
RAX: ffffffff8225a6ab RBX: ffffc90003e63048 RCX: ffff888074a38000
RDX: 0000000000000000 RSI: 0000000000000213 RDI: 0000000000000213
RBP: ffffc90003e63050 R08: ffffffff82259ed2 R09: ffffed100ac4fc09
R10: ffffed100ac4fc09 R11: 1ffff1100ac4fc08 R12: ffff88802353c000
R13: dffffc0000000000 R14: ffff88802353c678 R15: 0000000000000213
FS:  00005555571e1300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020012000 CR3: 000000001e222000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 is_block_in_journal fs/reiserfs/bitmap.c:125 [inline]
 scan_bitmap_block+0x447/0xf60 fs/reiserfs/bitmap.c:203
 scan_bitmap fs/reiserfs/bitmap.c:408 [inline]
 allocate_without_wrapping_disk fs/reiserfs/bitmap.c:1161 [inline]
 blocknrs_and_prealloc_arrays_from_search_start fs/reiserfs/bitmap.c:1274 [inline]
 reiserfs_allocate_blocknrs+0x3640/0x53c0 fs/reiserfs/bitmap.c:1375
 reiserfs_get_block+0x32a5/0x5180 fs/reiserfs/inode.c:756
 __block_write_begin_int+0x5f6/0x1ba0 fs/buffer.c:2006
 reiserfs_write_begin+0x247/0x510 fs/reiserfs/inode.c:2775
 generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3745
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3873
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3905
 call_write_iter include/linux/fs.h:2190 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f718fa0d8c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8e2494b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f718fa0d8c9
RDX: 000000006db6e559 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f718fa7bec0 R09: 00007f718fa7bec0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff8e2494e0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reiserfs_in_journal+0xa9b/0xaa0 fs/reiserfs/journal.c:505
Code: e8 da 45 b4 ff e9 15 f6 ff ff 48 8b 4c 24 30 80 e1 07 80 c1 03 38 c1 7c a8 48 8b 7c 24 30 e8 bc 45 b4 ff eb 9c e8 a5 da 60 ff <0f> 0b 0f 1f 00 55 41 57 41 56 41 55 41 54 53 50 49 89 fc 49 be 00
RSP: 0018:ffffc90003dbee80 EFLAGS: 00010293
RAX: ffffffff8225a6ab RBX: ffffc90003e63048 RCX: ffff888074a38000
RDX: 0000000000000000 RSI: 0000000000000213 RDI: 0000000000000213
RBP: ffffc90003e63050 R08: ffffffff82259ed2 R09: ffffed100ac4fc09
R10: ffffed100ac4fc09 R11: 1ffff1100ac4fc08 R12: ffff88802353c000
R13: dffffc0000000000 R14: ffff88802353c678 R15: 0000000000000213
FS:  00005555571e1300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f718fa7f130 CR3: 000000001e222000 CR4: 00000000003506f0
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
