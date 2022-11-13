Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E821062704E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiKMPvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiKMPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:51:08 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDEEE024
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:51:07 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so7757973ilt.22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiE0H6US2i4xBIgAD5dAMU4mmGBAJXRfAUbbKJuMGC4=;
        b=4MUI269fUQNik1KHemuLUxy0tGj2tW6CkUzdNaA8MQi8jZ71gpRwmWFLgg/siNgQun
         GQJysk3dxxKtwyTRZy7ukPKCC2LVxfmquFL9shOyHFABgYeR31x+Jv5qfnCwn5IYBVyD
         1TnvP6BL3mz6awh9AyOjls+iC0v56QgYt/kiWxbWm/ztHj5rnDY8w8tIuW/uVlvUdFfH
         LtceLqT8S0Aa5nZSaDnwA7iqDTv+xI5Jgs/F1RfxI0kg9vMNnzNvFyZdLu50Issv2KFL
         KO5qloB7Mxi4hZkk1OemDiEP/qcTV5wLDZ6c6VEqvq3QbYB/P0N3SqKLjVOg18QwlRV9
         4pbQ==
X-Gm-Message-State: ANoB5pnhmxc9mtx5m5uuf3QFU/STe/xtbb9430rLg5xi0o1L4fO6snHt
        90+q/J6zk+yEWia3jVQdsbAFt5m3SX7nhfP2SqrGDUfAezvH
X-Google-Smtp-Source: AA0mqf5CzXHwa5DbfXf3ksF9yAiQLXUHIk1Ap7r6mtfwoI4REzExfcfAfC9F3e9peMw4ZrF/Tx9c4VETBCt+PsFUyIu2UONjHpgB
MIME-Version: 1.0
X-Received: by 2002:a02:8783:0:b0:375:1a70:9c5c with SMTP id
 t3-20020a028783000000b003751a709c5cmr4277119jai.129.1668354666487; Sun, 13
 Nov 2022 07:51:06 -0800 (PST)
Date:   Sun, 13 Nov 2022 07:51:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041665a05ed5c17db@google.com>
Subject: [syzbot] possible deadlock in vfs_fileattr_set
From:   syzbot <syzbot+abe01a74653f00aabe3e@syzkaller.appspotmail.com>
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

HEAD commit:    f8f60f322f06 Add linux-next specific files for 20221111
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16cdceae880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=abe01a74653f00aabe3e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138b76ae880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ab1bfe880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6008df424195/disk-f8f60f32.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/394340525f66/vmlinux-f8f60f32.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b13604a3343a/bzImage-f8f60f32.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1398dc40e272/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abe01a74653f00aabe3e@syzkaller.appspotmail.com

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc4-next-20221111-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor405/5247 is trying to acquire lock:
ffff888072c302e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff888072c302e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: vfs_fileattr_set+0x148/0xbe0 fs/ioctl.c:681

but task is already holding lock:
ffff88802ac5a460 (sb_writers#9){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:725 [inline]
ffff88802ac5a460 (sb_writers#9){.+.+}-{0:0}, at: do_vfs_ioctl+0xe0b/0x1580 fs/ioctl.c:839

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#9){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1792 [inline]
       sb_start_write include/linux/fs.h:1867 [inline]
       mnt_want_write_file+0x8e/0x590 fs/namespace.c:552
       reiserfs_ioctl+0x19e/0x320 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       reiserfs_write_lock+0x75/0xf0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x171/0x490 fs/reiserfs/namei.c:364
       __lookup_slow+0x24c/0x460 fs/namei.c:1685
       lookup_one_len+0x16a/0x1a0 fs/namei.c:2711
       reiserfs_lookup_privroot+0x92/0x280 fs/reiserfs/xattr.c:973
       reiserfs_fill_super+0x20e5/0x2e90 fs/reiserfs/super.c:2174
       mount_bdev+0x34d/0x410 fs/super.c:1401
       legacy_get_tree+0x105/0x220 fs/fs_context.c:610
       vfs_get_tree+0x89/0x2f0 fs/super.c:1531
       do_new_mount fs/namespace.c:3145 [inline]
       path_mount+0x1326/0x1e20 fs/namespace.c:3475
       do_mount fs/namespace.c:3488 [inline]
       __do_sys_mount fs/namespace.c:3696 [inline]
       __se_sys_mount fs/namespace.c:3673 [inline]
       __x64_sys_mount+0x27f/0x300 fs/namespace.c:3673
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
       down_write+0x90/0x220 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       vfs_fileattr_set+0x148/0xbe0 fs/ioctl.c:681
       ioctl_fssetxattr fs/ioctl.c:758 [inline]
       do_vfs_ioctl+0xe46/0x1580 fs/ioctl.c:845
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
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

1 lock held by syz-executor405/5247:
 #0: ffff88802ac5a460 (sb_writers#9){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:725 [inline]
 #0: ffff88802ac5a460 (sb_writers#9){.+.+}-{0:0}, at: do_vfs_ioctl+0xe0b/0x1580 fs/ioctl.c:839

stack backtrace:
CPU: 0 PID: 5247 Comm: syz-executor405 Not tainted 6.1.0-rc4-next-20221111-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
 down_write+0x90/0x220 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 vfs_fileattr_set+0x148/0xbe0 fs/ioctl.c:681
 ioctl_fssetxattr fs/ioctl.c:758 [inline]
 do_vfs_ioctl+0xe46/0x1580 fs/ioctl.c:845
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x108/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fceb6e16899
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd70f3258 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fceb6e16899
RDX: 0000000020000600 RSI: 0000000040086602 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007fceb6e84ec0 R09: 00007fceb6e84ec0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcd70f3280
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
