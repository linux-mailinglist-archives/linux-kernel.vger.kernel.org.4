Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D263A593
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiK1KB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiK1KBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:01:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83469193F3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:01:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i8-20020a056e0212c800b00302578e6d78so8347767ilm.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meZqAfJnCZ5ik/tFsnvgcy1+Tn57jSXxlDiHQEvNtHY=;
        b=fEsn6lWgQP/+HYIFPiEIgvbanfPoEqVhREAUwuX1RBAJlwqgNEJUvHAUoNImBy1cNt
         eiRULQrdhjv7H4M5pQpNfqugYmb4WPjAd+mg/BsHCu/jKCW+i43btcpjj8BydtzyI9uL
         LacHxeXR2ILJKluMfhgdGSdYa00+amWzKX/V4JU5v2aoaUrKLQ7pTDqQV3MqLlF6+DOU
         ifTB9pDKZmbZIdAPuA8DP0ffCPi6OeY1DIWEj93Fo7OkElJQiGnILTiz9v0XWy/lV+Sf
         H0IihHfkFBTMIMuJpHbdFn5MYhifR22zugujWy6n7n3u0FAMb2wnpdOUaVvWpYP1vbSF
         p9Kg==
X-Gm-Message-State: ANoB5pk8mR2sjvAcUQmurUp6v2HxZEzyl0tAWtNrVcHLufq9GqWgScEN
        o+9EwsOOp6nZUjZqeulbUDI9e2RXbHInEBubQrzdUSgEIxgD
X-Google-Smtp-Source: AA0mqf7I0jSW7TaduJCBKtzMZfFs3hiMFR0hsd93iSXtU4MC6sARnQcq2AgJbwCREG9o2Yq7zBqxTZeC4Px0jTZtOwbmo4nAob6m
MIME-Version: 1.0
X-Received: by 2002:a92:de45:0:b0:302:c84a:6278 with SMTP id
 e5-20020a92de45000000b00302c84a6278mr15515994ilr.218.1669629697902; Mon, 28
 Nov 2022 02:01:37 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:01:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ccf9a05ee84f5b0@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __getblk_gfp
From:   syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
To:     hch@infradead.org, linux-kernel@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13bf0dc3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1282cf9b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a7ad75880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a1592babcac/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com

Buffer I/O error on dev loop0, logical block 13466417, async page read
syz-executor380: attempt to access beyond end of device
loop0: rw=0, sector=16147212, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8073606, async page read
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3632 Comm: syz-executor380 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
syz-executor380: attempt to access beyond end of device
loop0: rw=0, sector=6491548, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 3245774, async page read
syz-executor380: attempt to access beyond end of device
loop0: rw=0, sector=17669878, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8834939, async page read
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at include/linux/pagemap.h:937
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 folio_lock include/linux/pagemap.h:937 [inline]
 __filemap_get_folio+0x43c/0x1260 mm/filemap.c:1931
 pagecache_get_page+0x28/0x260 mm/folio-compat.c:110
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grow_dev_page+0xba/0x920 fs/buffer.c:946
 grow_buffers fs/buffer.c:1011 [inline]
 __getblk_slow fs/buffer.c:1038 [inline]
 __getblk_gfp+0x16c/0x290 fs/buffer.c:1333
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at fs/buffer.c:1331
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711
 #1: ffffffff8d3e65f8 (pointers_lock){.+.+}-{2:2}, at: get_block+0x159/0x16d0 fs/sysv/itree.c:217
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3632 Comm: syz-executor380 Tainted: G        W          6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 __might_resched+0x4e9/0x6b0 kernel/sched/core.c:9908
 __getblk_gfp+0x41/0x290 fs/buffer.c:1331
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 get_branch+0x2ce/0x680 fs/sysv/itree.c:104
 get_block+0x175/0x16d0 fs/sysv/itree.c:218
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 dir_get_page fs/sysv/dir.c:58 [inline]
 sysv_find_entry+0x1b3/0x440 fs/sysv/dir.c:146
 sysv_inode_by_name+0x74/0x1b0 fs/sysv/dir.c:360
 sysv_lookup+0x62/0xe0 fs/sysv/namei.c:38
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5ab3064739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfc2aa1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f5ab3064739
RDX: 0000000000000000 RSI: 0000000020004280 RDI: 00000000ffffff9c
RBP: 00007f5ab3023fd0 R08: 0000000000009e04 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ab3024060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
BUG: sleeping function called from invalid context at include/linux/pagemap.h:937
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3632, name: syz-executor380
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor380/3632:
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #0: ffff888073674188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x7aa/0x2df0 fs/namei.c:3711


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
