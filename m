Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2766051C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjAFQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjAFQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:52:52 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BFE6879E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:52:51 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id u24-20020a6be918000000b006ed1e9ad302so1071914iof.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 08:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyxM3kMT1/pG6kJ8IILzOaKDmeRAHlbtjq9desIhVzw=;
        b=U/KQM4oBxDqUaLBI4+J6tZgXeJg1nl34DbgJ1e1ducnKUlaNEuCXnaLAZ+kOBFau/m
         cmOQw5FcWr+4HfWj3oICdq/I8QbVJd+IM6zqXhAdGxR+IRW9z+OhKzYGPROgF0HsXJe2
         bZXF6T9oGUdbjhrET3FYRVB0orhYVw6wJCU46hnfYl2DtLga+m4eoyaoxjbGt2K+cVrR
         IDjxy5mNdWNXFDyJzvN1RzRPnvSIkG4I3eyp8evG03pdPxyEmgskuUIHan24mhUBWuGE
         0wFPkR4rnUA/f3LY/ZS5tfmqZKSvQUe/DOHd1Xy4UwT5/L/54SFMwu5Kg4K0zfRtgsu8
         Yh4A==
X-Gm-Message-State: AFqh2krYrLW2+QDTBbgXxlM1sI1o0zPSaLffjIInpcfnEWJSiK7zc7Fs
        fvGOq5YV5nvdW52JXn5sS5mi2wJhFu+m8wyu4rjck6dxJepy
X-Google-Smtp-Source: AMrXdXv2f19J2K++sJWf65GgF6eu+Zs5rhQYQ6Djg0s+Bm7d78Msjw+dnHBhD/4VuyS5kl3hCGXqdqZlviXjLfJq5iilyUlNOaDI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144b:b0:39e:5dc6:ebb2 with SMTP id
 l11-20020a056638144b00b0039e5dc6ebb2mr337560jad.71.1673023970415; Fri, 06 Jan
 2023 08:52:50 -0800 (PST)
Date:   Fri, 06 Jan 2023 08:52:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000751c0305f19b3faa@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in prepare_for_delete_or_cut
From:   syzbot <syzbot+e621a445f96fd0e94be4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yi.zhang@huawei.com
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

HEAD commit:    41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11f9c594480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=e621a445f96fd0e94be4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d8628a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159d6c4e480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/041403c21ee3/disk-41c03ba9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/579dec11b65a/vmlinux-41c03ba9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcb6cfc03c78/bzImage-41c03ba9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/014b8184a95e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e621a445f96fd0e94be4@syzkaller.appspotmail.com

REISERFS error (device loop0): vs-5150 search_by_key: invalid format found in block 532. Fsck?
REISERFS (device loop0): Remounting filesystem read-only
REISERFS error (device loop0): vs-13050 reiserfs_update_sd_size: i/o failure occurred trying to update [2 2 0x0 SD] stat data
REISERFS warning: reiserfs-5093 is_leaf: item entry count seems wrong *3.5*[2 1 0(1) DIR], item_len 35, item_location 4029, free_space(entry_count) 2
REISERFS error (device loop0): vs-5150 search_by_key: invalid format found in block 532. Fsck?
general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 5067 Comm: syz-executor356 Not tainted 6.2.0-rc2-syzkaller-00057-g41c03ba9beea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:reiserfs_node_data fs/reiserfs/reiserfs.h:2184 [inline]
RIP: 0010:item_head fs/reiserfs/reiserfs.h:2200 [inline]
RIP: 0010:tp_item_head fs/reiserfs/reiserfs.h:2226 [inline]
RIP: 0010:prepare_for_delete_or_cut+0x182/0x21a0 fs/reiserfs/stree.c:1050
Code: 89 d8 48 c1 e8 03 49 bc 00 00 00 00 00 fc ff df 42 8a 04 20 84 c0 0f 85 f2 17 00 00 4c 63 3b 49 83 c6 28 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 ef 41 b3 ff 4d 8b 36 48 b8 00 00
RSP: 0018:ffffc90003bff100 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffffc90003bff8c0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffc90003bff268 R08: ffffffff822e42d9 R09: ffffc90003bff730
R10: 0000000000000002 R11: ffff888023991d40 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000028 R15: 0000000000000000
FS:  0000555556956300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f656836c18 CR3: 000000007aa25000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_cut_from_item+0x38c/0x25b0 fs/reiserfs/stree.c:1682
 reiserfs_do_truncate+0x9d6/0x15a0 fs/reiserfs/stree.c:1973
 reiserfs_truncate_file+0x471/0x790 fs/reiserfs/inode.c:2310
 reiserfs_file_release+0x887/0xa30 fs/reiserfs/file.c:109
 __fput+0x3ba/0x880 fs/file_table.c:320
 task_work_run+0x243/0x300 kernel/task_work.c:179
 ptrace_notify+0x29a/0x340 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:251
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3739c112f3
Code: c7 c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffcb18bf408 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f3739c112f3
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007ffcb18bf418 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcb18bf420
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reiserfs_node_data fs/reiserfs/reiserfs.h:2184 [inline]
RIP: 0010:item_head fs/reiserfs/reiserfs.h:2200 [inline]
RIP: 0010:tp_item_head fs/reiserfs/reiserfs.h:2226 [inline]
RIP: 0010:prepare_for_delete_or_cut+0x182/0x21a0 fs/reiserfs/stree.c:1050
Code: 89 d8 48 c1 e8 03 49 bc 00 00 00 00 00 fc ff df 42 8a 04 20 84 c0 0f 85 f2 17 00 00 4c 63 3b 49 83 c6 28 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 ef 41 b3 ff 4d 8b 36 48 b8 00 00
RSP: 0018:ffffc90003bff100 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffffc90003bff8c0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffc90003bff268 R08: ffffffff822e42d9 R09: ffffc90003bff730
R10: 0000000000000002 R11: ffff888023991d40 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000028 R15: 0000000000000000
FS:  0000555556956300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f656836c18 CR3: 000000007aa25000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 d8                	mov    %ebx,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
   d:	fc ff df
  10:	42 8a 04 20          	mov    (%rax,%r12,1),%al
  14:	84 c0                	test   %al,%al
  16:	0f 85 f2 17 00 00    	jne    0x180e
  1c:	4c 63 3b             	movslq (%rbx),%r15
  1f:	49 83 c6 28          	add    $0x28,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 ef 41 b3 ff       	callq  0xffb34228
  39:	4d 8b 36             	mov    (%r14),%r14
  3c:	48                   	rex.W
  3d:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
