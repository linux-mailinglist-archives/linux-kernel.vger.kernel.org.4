Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC525F9726
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiJJDJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJJDJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:09:41 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFCD8D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:09:38 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so6622090ioe.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 20:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Civfcs2JBg/Mj54wvoRvnaalPboaswdzomoVTd6Wq2Q=;
        b=7YcXFyTQA3x5iSgQw2n8bip4uit0WT8vLW8jvokqx8+KhOpuhjRb38BW0RhOfkAw53
         H9shYoTtQWbo/wOZyQHnyzNxIn67gs7KHczj1t7IzFIVjS5KnYFIJpvTwzIJRLPYDwAA
         IL3mzZslnj6gAkPPMrSu2lLgjCWOMDJOsCLRHTaOZEUiwaNS1tAQLMHHxoOJ/Zy0Te3C
         WSgkCfoT31dd9+TgSZtrHB2vVl1EHAB/kzdu1rNPgCDJlHNrcn8G8BSIs0/86XbM03fH
         FamUXzvyGx4HLn6Wa/Wz1RSG9lnwoPBkW4IcW0NeFKY8Atr8xeTalUSLvztx5eBiMkOJ
         EJ/w==
X-Gm-Message-State: ACrzQf007D21wNqU0JtLLGdNzFQoqmP0tLhYU1OtXGRgLdmGe/P92Qyq
        Vv1gJyq1e3AfHF0IFt4NDE94kfOGNSYkCN4jFd6763sSE+mM
X-Google-Smtp-Source: AMsMyM6Y+iU7z6qmvkmWt08GQ2856RDu6Esz0+kSCokFliynaNEeGALD0K+p777iuLEaCasnYspFvbiBJTjC0N3iPPiFbfhzF/gR
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c94:b0:6a1:d9ff:6c8a with SMTP id
 i20-20020a0566022c9400b006a1d9ff6c8amr8235882iow.117.1665371377697; Sun, 09
 Oct 2022 20:09:37 -0700 (PDT)
Date:   Sun, 09 Oct 2022 20:09:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006308a805eaa57d87@google.com>
Subject: [syzbot] possible deadlock in chown_common
From:   syzbot <syzbot+3abaeed5039cc1c49c7c@syzkaller.appspotmail.com>
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

HEAD commit:    2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=169d7034880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3abaeed5039cc1c49c7c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1539e7b8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c6cb32880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9885e6765755/disk-2bca25ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e78c91286aa/vmlinux-2bca25ea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a0aa130c8e62/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3abaeed5039cc1c49c7c@syzkaller.appspotmail.com

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.0.0-syzkaller-03015-g2bca25eaeba6 #0 Not tainted
------------------------------------------------------
syz-executor428/3608 is trying to acquire lock:
ffff8880704302e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff8880704302e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: chown_common+0x414/0x8f0 fs/open.c:729

but task is already holding lock:
ffff888020438460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393

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
       chown_common+0x414/0x8f0 fs/open.c:729
       do_fchownat+0x165/0x240 fs/open.c:767
       __do_sys_lchown fs/open.c:792 [inline]
       __se_sys_lchown fs/open.c:790 [inline]
       __x64_sys_lchown+0x81/0x90 fs/open.c:790
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

1 lock held by syz-executor428/3608:
 #0: ffff888020438460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393

stack backtrace:
CPU: 0 PID: 3608 Comm: syz-executor428 Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
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
 chown_common+0x414/0x8f0 fs/open.c:729
 do_fchownat+0x165/0x240 fs/open.c:767
 __do_sys_lchown fs/open.c:792 [inline]
 __se_sys_lchown fs/open.c:790 [inline]
 __x64_sys_lchown+0x81/0x90 fs/open.c:790
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7b93991899
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd35199f8 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7b93991899
RDX: 0000000000000000 RSI: 000000000000ee01 RDI: 0000000020000080
RBP: 0000000000000000 R08: 00007f7b939ffec0 R09: 00007f7b939ffec0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcd3519a20
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
