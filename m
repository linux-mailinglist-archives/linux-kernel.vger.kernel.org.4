Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BAA5FACE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJKGfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:35:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A35C606BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:35:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso8136868ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbiXEdBRujkz0+9tjdy23X2wJxWkJWVMFAQgXyUcr2k=;
        b=wzRsmwhKBwlou7CO8M6xx+RoldKvcdjlpQ+Iv9TbcNCrNJa9WwCQjIqxwE4mKTmlDA
         65MS5OzVTd7FQBMiGtFEHq3ZopE+TQVw5aUNxwn8+WIo0eGR8o2e94beNrmVW1BE9EZA
         yeueguWTh2opv+GcZnwc/EBGFLrjMShFG3Dpgs9K5ME9RGhaA7AoeeDPDkAzluLap4gF
         8Ep43eP9aYGa50aOsZ0v2WoOOvXGH40hiq7GXU5ZwO86RnRW+5sL+PFPIzudmZ4ZfVNX
         9QW9QtV15HHQarj/kNOqL8ZazbOU+KHwz4WbcN79oOKb6BpzuuhFqpYsqIGtBunwJjzo
         ngSw==
X-Gm-Message-State: ACrzQf3M4twLJYO+pMDoJPUdZt+MNg8/zs22RliVFbMygwh/5Wx+Wq3d
        yRZHabGWNL7Tw7DRmxXJOi2cH0Iojt6TpncEvXDQ0dK6Omlb
X-Google-Smtp-Source: AMsMyM4x3m/c5mhm7Kgr16uESQ5gjrJ5VzglByktq+xcSUsE/5tYIi+ZWR8iPDsTxpowJUeIRBLtg1KQyku0UqPzVRzMJvrnLWRw
MIME-Version: 1.0
X-Received: by 2002:a6b:6709:0:b0:6bc:269e:e81a with SMTP id
 b9-20020a6b6709000000b006bc269ee81amr4600601ioc.174.1665470138503; Mon, 10
 Oct 2022 23:35:38 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:35:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd56c405eabc7b6d@google.com>
Subject: [syzbot] possible deadlock in path_openat (2)
From:   syzbot <syzbot+a844a888fbc0ba4829ce@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    833477fce7a1 Merge tag 'sound-6.1-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ea9e2a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd3623e135f4c106
dashboard link: https://syzkaller.appspot.com/bug?extid=a844a888fbc0ba4829ce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dfb81a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a68f24880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c58f480421f/disk-833477fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a50ac7bd40b/vmlinux-833477fc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a95d12af3a6f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a844a888fbc0ba4829ce@syzkaller.appspotmail.com

REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.0.0-syzkaller-05118-g833477fce7a1 #0 Not tainted
------------------------------------------------------
syz-executor874/3610 is trying to acquire lock:
ffff888073d582e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff888073d582e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: open_last_lookups fs/namei.c:3478 [inline]
ffff888073d582e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: path_openat+0x7b9/0x2df0 fs/namei.c:3688

but task is already holding lock:
ffff888075052460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#9){.+.+}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_write+0x4d/0x1a0 include/linux/fs.h:1901
       mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437
       reiserfs_ioctl+0x16e/0x340 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x147/0x490 fs/reiserfs/namei.c:364
       __lookup_slow+0x266/0x3a0 fs/namei.c:1685
       lookup_one_len+0x430/0x690 fs/namei.c:2711
       reiserfs_lookup_privroot+0x85/0x1e0 fs/reiserfs/xattr.c:973
       reiserfs_fill_super+0x2071/0x24a0 fs/reiserfs/super.c:2176
       mount_bdev+0x26c/0x3a0 fs/super.c:1400
       legacy_get_tree+0xea/0x180 fs/fs_context.c:610
       vfs_get_tree+0x88/0x270 fs/super.c:1530
       do_new_mount+0x289/0xad0 fs/namespace.c:3040
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain+0x18c1/0x6bd0 kernel/locking/lockdep.c:3829
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_write+0x95/0x170 kernel/locking/rwsem.c:1552
       inode_lock include/linux/fs.h:756 [inline]
       open_last_lookups fs/namei.c:3478 [inline]
       path_openat+0x7b9/0x2df0 fs/namei.c:3688
       do_filp_open+0x264/0x4f0 fs/namei.c:3718
       do_sys_openat2+0x124/0x4e0 fs/open.c:1313
       do_sys_open fs/open.c:1329 [inline]
       __do_sys_creat fs/open.c:1405 [inline]
       __se_sys_creat fs/open.c:1399 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1399
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#6 --> &sbi->lock --> sb_writers#9

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#9);
                               lock(&sbi->lock);
                               lock(sb_writers#9);
  lock(&type->i_mutex_dir_key#6);

 *** DEADLOCK ***

1 lock held by syz-executor874/3610:
 #0: ffff888075052460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393

stack backtrace:
CPU: 0 PID: 3610 Comm: syz-executor874 Not tainted 6.0.0-syzkaller-05118-g833477fce7a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain+0x18c1/0x6bd0 kernel/locking/lockdep.c:3829
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
 down_write+0x95/0x170 kernel/locking/rwsem.c:1552
 inode_lock include/linux/fs.h:756 [inline]
 open_last_lookups fs/namei.c:3478 [inline]
 path_openat+0x7b9/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_creat fs/open.c:1405 [inline]
 __se_sys_creat fs/open.c:1399 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4f0b64b899
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffdc5eba48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f0b64b899
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 0000000000000000 R08: 00007f4f0b6b9ec0 R09: 00007f4f0b6b9ec0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffdc5eba70
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
