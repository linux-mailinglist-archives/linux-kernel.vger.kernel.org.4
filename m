Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F29658853
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiL2BX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2BXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:23:24 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD713F80
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:23:23 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so10973719ilt.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeJLsnPHPnTdoII+fk4/DB6TZ+ww6Hs/SN0JpWJO4S8=;
        b=HolCuuqJ6PGHDYIKHPTNswLfMlvlsSoahZnEhC8THnjCQ3YdLE/Qo7U7TX+F19NBr3
         U8r4n+8BOl8ulgeoEyamuAppQljGo95GX9zcr/pkjcHi96Hx1O2ohiGohROb8/qr+UkT
         SA/fIqAB0sOwjGT7c2ky9hM+Kg1HpZP0BBcZ498hjArXk3rLTT/jRHH4js0AaBNTHczq
         +FcHJP/7C7YlJ30slBkWoNGyoFV17XmHjK5/026OF9X4tlCK2u9IH8I9krgwoFjXZ5Ax
         1jYfB7HCwAAd18seCdXqpzTUMErshaGHCLyCtudhAj/BxDktKVqKD1xb/mFTqEWscLKG
         A5Cw==
X-Gm-Message-State: AFqh2krl+Gq0DQki2GcG3PLnm9sGpAEYxnT3aPxFwKkAk9WcBQoAHVtx
        d5GX3fHE/mFqK5Er+NZOQ2Y0eQ4+l6ZYcadPYSdMe34+kZ3U
X-Google-Smtp-Source: AMrXdXsohTMDZ+IMtekOV3KljYZi/ZPObBKromXUuAQVIARbMjkM0pmO3zxqW7NnZRfx4FrWwnhn4MUOrF3KWRoCG4Y+wfemZjCC
MIME-Version: 1.0
X-Received: by 2002:a02:c64a:0:b0:38a:c06e:daa5 with SMTP id
 k10-20020a02c64a000000b0038ac06edaa5mr2339690jan.238.1672277002674; Wed, 28
 Dec 2022 17:23:22 -0800 (PST)
Date:   Wed, 28 Dec 2022 17:23:22 -0800
In-Reply-To: <20221229005540.2777-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5e7b405f0ed54fb@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_find_inline_entry
From:   syzbot <syzbot+d3bb749184481f92deb5@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ext4_xattr_set_entry

EXT4-fs: Warning: mounting with an experimental mount option 'dioread_nolock' for blocksize < PAGE_SIZE
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-00172-ga5541c0811a0-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/3668 is trying to acquire lock:
ffff0000cf16bd60 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff0000cf16bd60 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_xattr_inode_create fs/ext4/xattr.c:1453 [inline]
ffff0000cf16bd60 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1536 [inline]
ffff0000cf16bd60 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_xattr_set_entry+0xdbc/0xe00 fs/ext4/xattr.c:1664

but task is already holding lock:
ffff0000cf16b098 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff0000cf16b098 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0xd0/0x9a0 fs/ext4/xattr.c:2308

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->xattr_sem){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       ext4_xattr_get+0x90/0x418 fs/ext4/xattr.c:665
       ext4_xattr_security_get+0x40/0x54 fs/ext4/xattr_security.c:20
       __vfs_getxattr+0x1fc/0x20c fs/xattr.c:407
       cap_inode_need_killpriv+0x34/0x5c security/commoncap.c:301
       security_inode_need_killpriv+0x34/0x88 security/security.c:1422
       dentry_needs_remove_privs fs/inode.c:1995 [inline]
       __file_remove_privs+0xe0/0x308 fs/inode.c:2026
       file_modified_flags+0x60/0x330 fs/inode.c:2148
       file_modified+0x24/0x34 fs/inode.c:2177
       ext4_write_checks fs/ext4/file.c:264 [inline]
       ext4_buffered_write_iter+0x12c/0x294 fs/ext4/file.c:280
       ext4_file_write_iter+0x84/0x408 fs/ext4/file.c:700
       call_write_iter include/linux/fs.h:2199 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x2dc/0x46c fs/read_write.c:584
       ksys_write+0xb4/0x160 fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       __se_sys_write fs/read_write.c:646 [inline]
       __arm64_sys_write+0x24/0x34 fs/read_write.c:646
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1453 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1536 [inline]
       ext4_xattr_set_entry+0xdbc/0xe00 fs/ext4/xattr.c:1664
       ext4_xattr_ibody_set+0x94/0x184 fs/ext4/xattr.c:2224
       ext4_xattr_set_handle+0x648/0x9a0 fs/ext4/xattr.c:2381
       ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
       ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
       __vfs_setxattr+0x250/0x260 fs/xattr.c:182
       __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
       __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
       vfs_setxattr+0xf4/0x1f4 fs/xattr.c:309
       do_setxattr fs/xattr.c:594 [inline]
       setxattr fs/xattr.c:617 [inline]
       path_setxattr+0x354/0x414 fs/xattr.c:636
       __do_sys_lsetxattr fs/xattr.c:659 [inline]
       __se_sys_lsetxattr fs/xattr.c:655 [inline]
       __arm64_sys_lsetxattr+0x2c/0x40 fs/xattr.c:655
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(&sb->s_type->i_mutex_key#8);
                               lock(&ei->xattr_sem);
  lock(&sb->s_type->i_mutex_key#8);

 *** DEADLOCK ***

3 locks held by syz-executor.0/3668:
 #0: ffff0000c9dee460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:393
 #1: ffff0000cf16b3d0 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff0000cf16b3d0 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0xd4/0x1f4 fs/xattr.c:308
 #2: ffff0000cf16b098 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff0000cf16b098 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0xd0/0x9a0 fs/ext4/xattr.c:2308

stack backtrace:
CPU: 1 PID: 3668 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-00172-ga5541c0811a0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 ext4_xattr_inode_create fs/ext4/xattr.c:1453 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1536 [inline]
 ext4_xattr_set_entry+0xdbc/0xe00 fs/ext4/xattr.c:1664
 ext4_xattr_ibody_set+0x94/0x184 fs/ext4/xattr.c:2224
 ext4_xattr_set_handle+0x648/0x9a0 fs/ext4/xattr.c:2381
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0xf4/0x1f4 fs/xattr.c:309
 do_setxattr fs/xattr.c:594 [inline]
 setxattr fs/xattr.c:617 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:636
 __do_sys_lsetxattr fs/xattr.c:659 [inline]
 __se_sys_lsetxattr fs/xattr.c:655 [inline]
 __arm64_sys_lsetxattr+0x2c/0x40 fs/xattr.c:655
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


Tested on:

commit:         a5541c08 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f5d4bc480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=d3bb749184481f92deb5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15be6de4480000

