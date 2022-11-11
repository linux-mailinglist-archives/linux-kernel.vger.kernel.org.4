Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876F3626107
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKKS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiKKS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:26:51 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C64D5CE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:26:50 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id c4-20020a056e020bc400b0030098df879dso4442983ilu.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzRzIhnjx35JZdGRQwG5/ah7DslEnUv+KIUJaourmX8=;
        b=Q88ZYrNM+au0E3k3T4o+45Y8gwCFndwR8+WtKtWqyroDpsYchEEziyUQaaRzd72eFC
         K121XT0uNYzHkejESHUFHbLcBG3YhMFzYYQM0gyfxXo9giuz69ydEJQGhunqwIk7tPpE
         oG5lWGyAeDjyygGQHspeP/SW7/5LfTfRAf0x4QpU0TKPb9lzkJZcVwDZ2Lf0DjVxmESY
         dX4E6jzfpd3qYS1nExGUihnOFBF0jjBjY7rSY09OD2T2tEC23lRSTYiGyl6jnTITmMat
         Y3AOMgVu0JjKee1S9rDIOC5I9SU8G0Iwok76fMVj2ttGRChL7p1E0+z4q7uwtISUdmOp
         hgSA==
X-Gm-Message-State: ANoB5plm2WdCuEcJhyFDoTIatjeTFP7CNYDomTrpOcLyyfokVMSVJ05O
        lgYtMmMe3QJj0F75S5BiTnZbqZ3Uig10pAhpJyHmszcDrfaq
X-Google-Smtp-Source: AA0mqf5GPaZFpdNnEJXzHWm+qL4EK7cFO8pwan9qKLjlE30kbZg0oAX+wIWSkclEMeUB7emUaj7nG5+lw2mwqyQVNeMLn8HbnqJN
MIME-Version: 1.0
X-Received: by 2002:a92:c8cb:0:b0:2ff:9805:2a6a with SMTP id
 c11-20020a92c8cb000000b002ff98052a6amr1663023ilq.268.1668191209625; Fri, 11
 Nov 2022 10:26:49 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:26:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000779efd05ed36086d@google.com>
Subject: [syzbot] possible deadlock in reiserfs_ioctl
From:   syzbot <syzbot+79c303ad05f4041e0dad@syzkaller.appspotmail.com>
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

HEAD commit:    0cdb3579f1ee Add linux-next specific files for 20221104
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1608948e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8b29628d1d8538b
dashboard link: https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f2b215880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d3c525880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d0fa4b872bd/disk-0cdb3579.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/797f855f0497/vmlinux-0cdb3579.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c5c130d649d/bzImage-0cdb3579.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/41524a2c0287/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79c303ad05f4041e0dad@syzkaller.appspotmail.com

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc3-next-20221104-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor418/5242 is trying to acquire lock:
ffff8880289b2460 (sb_writers#9){.+.+}-{0:0}, at: reiserfs_ioctl+0x19e/0x320 fs/reiserfs/ioctl.c:103

but task is already holding lock:
ffff888016eec090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x75/0xf0 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->lock){+.+.}-{3:3}:
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

-> #1 (&type->i_mutex_dir_key#6){+.+.}-{3:3}:
       down_write+0x90/0x220 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       chmod_common+0x14b/0x410 fs/open.c:600
       vfs_fchmod fs/open.c:622 [inline]
       __do_sys_fchmod fs/open.c:631 [inline]
       __se_sys_fchmod fs/open.c:625 [inline]
       __x64_sys_fchmod+0x10e/0x190 fs/open.c:625
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_writers#9){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
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

other info that might help us debug this:

Chain exists of:
  sb_writers#9 --> &type->i_mutex_dir_key#6 --> &sbi->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(&type->i_mutex_dir_key#6);
                               lock(&sbi->lock);
  lock(sb_writers#9);

 *** DEADLOCK ***

1 lock held by syz-executor418/5242:
 #0: ffff888016eec090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x75/0xf0 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 1 PID: 5242 Comm: syz-executor418 Not tainted 6.1.0-rc3-next-20221104-syzkaller #0
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
RIP: 0033:0x7f157998c889
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe2dd23488 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f157998c889
RDX: 0000000000000000 RSI: 0000000040087602 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007f15799faec0 R09: 00007f15799faec0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe2dd234b0
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
