Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753B1634DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiKWCdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiKWCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:33:42 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38145E3D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:33:40 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id c20-20020a5d9754000000b006dbd4e6a5abso1861593ioo.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIzFMM+Ikd/Q/BDGCMvL1j+zASrNppy03XUf3EFmi70=;
        b=5u27VPdjukBi8w5mgaMx92cGpU7qy6yP4Cf4RgUr6kLaiSOswVS887ux0ptBt3wDvT
         rJtf0sJasyfqnnc22LeUbWl2DAgXPrv+E3x11gYzbs7aTZDbWXLg4TTa4KQH736aQfUX
         aGKXm3YcVEbbKDfZBz92HkfYySd+pTVjZT+8C+qHWv6UCm4WYvFiviEwAtJTkNoeSKNV
         QZJEl237UJg+sD2IQ56IVg0pc4OMdC6fl9Vcv1YTZYzb46jS+eGq/+9gDNUMij7ZmV2D
         75UbnhbK+kfJJRBsCC+YU/jv035BjKGxin8Bg4A8vgysl4V05L6t3GWqJnMhbHC83irR
         bizg==
X-Gm-Message-State: ANoB5pl1HEvbFXdZCe3HyidBYPI9MirrmNpT5F7+r0IXQXDzRWBsTUS2
        H3EFzPWtYICbXsu1N87AzDVwounhNCmwRbwlLW290vgOrXHw
X-Google-Smtp-Source: AA0mqf791VK/5bhSRC5/9sysxojq9e9UXTKOHH00DzoOstixBVPAL60butSF5O1zx6ligMd7/7fIIQzeGONXcPi/dgq2PrYsRpqZ
MIME-Version: 1.0
X-Received: by 2002:a92:c5a4:0:b0:302:b27a:6f6f with SMTP id
 r4-20020a92c5a4000000b00302b27a6f6fmr3084942ilt.101.1669170819997; Tue, 22
 Nov 2022 18:33:39 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:33:39 -0800
In-Reply-To: <000000000000f250a605ec981d41@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cba69705ee1a1d4e@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write_file
From:   syzbot <syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155d6d45880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1167648d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1562d6c5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/aa387a5f9eda/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1047e42179f502f2b0a2@syzkaller.appspotmail.com

REISERFS (device loop0): Using tea hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor139/3633 is trying to acquire lock:
ffff888026b18460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write_file+0x5a/0x1f0 fs/namespace.c:437

but task is already holding lock:
ffff88801f89c090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x147/0x490 fs/reiserfs/namei.c:364
       __lookup_slow+0x266/0x3a0 fs/namei.c:1685
       lookup_one_len+0x430/0x690 fs/namei.c:2711
       reiserfs_lookup_privroot+0x85/0x1e0 fs/reiserfs/xattr.c:973
       reiserfs_fill_super+0x2071/0x24a0 fs/reiserfs/super.c:2174
       mount_bdev+0x26c/0x3a0 fs/super.c:1401
       legacy_get_tree+0xea/0x180 fs/fs_context.c:610
       vfs_get_tree+0x88/0x270 fs/super.c:1531
       do_new_mount+0x289/0xad0 fs/namespace.c:3040
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&type->i_mutex_dir_key#6){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       open_last_lookups fs/namei.c:3478 [inline]
       path_openat+0x7b9/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_writers#9){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
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

1 lock held by syz-executor139/3633:
 #0: ffff88801f89c090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 1 PID: 3633 Comm: syz-executor139 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
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
RIP: 0033:0x7f9c2c672829
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffe9d1ea8 EFLAGS:

