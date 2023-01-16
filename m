Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9266BB98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAPKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAPKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:22:01 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BD512847
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:21:57 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so2080016ild.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8Ioxv32rX4tCvh+LRON4bGSQTYnk1jYyZqAqdJVnbY=;
        b=iZRzy73PpkHZyNZPeNu0AL1htaUuUY0vMtpSmRzj2WY4W1joE5QVStca/3PiiBCtKl
         ZRRVOOPv+MUMHd8HcYuoPLKCrdRtKwyuzhmM6ixIwdB0VHqEe012ciFVHpykrkS/f7qf
         S3ofzdR2znlGRe6tYCF70SgOhuWvxcvhYmJVsXyeJbOy4DGunncmSr9NhCG+SUMo6/Me
         HyXF3XZpX2Kb4o7P2kRgIL4OyfdbgpyWG9n6qB90VQsqYxO+ykGIdzGM9yEk1lxPwj1O
         kCmrM/ce/6/UMFSttgtb/B3sNHf8DJQJit2hBNfSBBkFp8VZBB3fQYCRQioqOCm08WIS
         YLCg==
X-Gm-Message-State: AFqh2kr1Rx0mGDzK6V8BYhFTNTnB95xoJ89YBri0I1OUdhmeDVOd+Sn6
        fkr4bcxTE7iGWDguVBBnY2uis4Jw/i9N45L3/QbwD0HAKiNX
X-Google-Smtp-Source: AMrXdXttgwQ2RhJoMOaZ4FwtGIczcVOvNshBCXrysMDIkTr/KLOwnwd/I+KMNSTHxvkjg2d+PTDyMZYlrjgsJx9nWnKXdXRzAXuE
MIME-Version: 1.0
X-Received: by 2002:a92:6a04:0:b0:30e:ef8d:de57 with SMTP id
 f4-20020a926a04000000b0030eef8dde57mr594204ilc.153.1673864517088; Mon, 16 Jan
 2023 02:21:57 -0800 (PST)
Date:   Mon, 16 Jan 2023 02:21:57 -0800
In-Reply-To: <000000000000520d3405f075a026@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f17bea05f25ef32b@google.com>
Subject: Re: [syzbot] [reiserfs?] divide error in do_journal_end (3)
From:   syzbot <syzbot+74b838cfa47fc9554471@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, jack@suse.cz,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, song@kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yi.zhang@huawei.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    5dc4c995db9e Linux 6.2-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17104a36480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d1e01fb80d3df97
dashboard link: https://syzkaller.appspot.com/bug?extid=74b838cfa47fc9554471
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10169b86480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b27089480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e52acf94631e/disk-5dc4c995.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ead5c940574/vmlinux-5dc4c995.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6b43b71bf31/bzImage-5dc4c995.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/964c239d9caf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74b838cfa47fc9554471@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5068 Comm: syz-executor317 Not tainted 6.2.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:do_journal_end+0x1822/0x4a30 fs/reiserfs/journal.c:4091
Code: 04 28 84 c0 0f 85 f7 2b 00 00 4a 8d 5c 33 01 4c 89 e0 48 c1 e8 03 42 8a 04 28 84 c0 0f 85 ff 2b 00 00 41 8b 0f 48 89 d8 31 d2 <48> f7 f1 48 89 d3 48 03 5c 24 20 48 8b 84 24 d8 00 00 00 42 80 3c
RSP: 0018:ffffc90003b7f820 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888029c4f000
RBP: ffffc90003b7fa90 R08: dffffc0000000000 R09: ffff888029c4f000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807a8e9017
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88807a8e9014
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000026e6b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_sync_fs+0xbb/0x130 fs/reiserfs/super.c:78
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f24fcf1bad9
Code: Unable to access opcode bytes at 0x7f24fcf1baaf.
RSP: 002b:00007ffda2e53128 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f24fcf91350 RCX: 00007f24fcf1bad9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f24fcf8be40
R10: 000000000001ff01 R11: 0000000000000246 R12: 00007f24fcf91350
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_journal_end+0x1822/0x4a30 fs/reiserfs/journal.c:4091
Code: 04 28 84 c0 0f 85 f7 2b 00 00 4a 8d 5c 33 01 4c 89 e0 48 c1 e8 03 42 8a 04 28 84 c0 0f 85 ff 2b 00 00 41 8b 0f 48 89 d8 31 d2 <48> f7 f1 48 89 d3 48 03 5c 24 20 48 8b 84 24 d8 00 00 00 42 80 3c
RSP: 0018:ffffc90003b7f820 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888029c4f000
RBP: ffffc90003b7fa90 R08: dffffc0000000000 R09: ffff888029c4f000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807a8e9017
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88807a8e9014
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056252d1db088 CR3: 000000001da35000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	04 28                	add    $0x28,%al
   2:	84 c0                	test   %al,%al
   4:	0f 85 f7 2b 00 00    	jne    0x2c01
   a:	4a 8d 5c 33 01       	lea    0x1(%rbx,%r14,1),%rbx
   f:	4c 89 e0             	mov    %r12,%rax
  12:	48 c1 e8 03          	shr    $0x3,%rax
  16:	42 8a 04 28          	mov    (%rax,%r13,1),%al
  1a:	84 c0                	test   %al,%al
  1c:	0f 85 ff 2b 00 00    	jne    0x2c21
  22:	41 8b 0f             	mov    (%r15),%ecx
  25:	48 89 d8             	mov    %rbx,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	48 89 d3             	mov    %rdx,%rbx
  30:	48 03 5c 24 20       	add    0x20(%rsp),%rbx
  35:	48 8b 84 24 d8 00 00 	mov    0xd8(%rsp),%rax
  3c:	00
  3d:	42                   	rex.X
  3e:	80                   	.byte 0x80
  3f:	3c                   	.byte 0x3c

