Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C86574F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiL1Ju4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiL1JuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:50:25 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B72110043
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:50:14 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso4978907iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwSWzJqyMBbn/1Ywtyk9+BWui3OB4pahkbTwiBdNnsk=;
        b=Sg+cIFKIMiBNf9TwMU2AsY/Ko/+oJnoe7wnGmhAnkK+O8hiCq5e+lQsvGD48oAGKu3
         d5O0BZRgD/wdb62YhM8iaFIT1C6yeRYmI+3fxC0yTQyEnV0C3/tnjGyqgQA+6dfxWws0
         l7EqEoiU0lPPd3BjxpPyvuxnttFNhtMROkbBAWcwJsl/60/vJo9YibYVMk1cUd2caKVC
         amOj50NGOYiE/s4dexpIGhcX9/7bCNJ8lLgkCWJiSDWXmeSC5HfM2Q9br/NlxS8eVkan
         KHOoPjPg7L+35bK/3BPzIjI+lyDIzWIjPJ7z79sKw/g051S3wczTwMiRoTFN/lUaK+6D
         V5og==
X-Gm-Message-State: AFqh2ko0d3K2PUgQlkwb9Cod6VkN/lBh0oGnIpZk2TnrVofvxzpmWqwV
        c7fx/+kqCCWodRNkkq3TPCjlWKroQTQn57J1v8QUPfWomjjW
X-Google-Smtp-Source: AMrXdXvM2b5zve5NjNs2vaEyiME3mcpco4DpEcoc/+8kbtna/jlGzJ20PCc4/dmhqKD9zUjcm+VIsp/zLOjxJMgnyX4KSbESwaMR
MIME-Version: 1.0
X-Received: by 2002:a02:9a0a:0:b0:397:cb64:9696 with SMTP id
 b10-20020a029a0a000000b00397cb649696mr2017820jal.102.1672221014008; Wed, 28
 Dec 2022 01:50:14 -0800 (PST)
Date:   Wed, 28 Dec 2022 01:50:13 -0800
In-Reply-To: <20221228093841.2684-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086aa6e05f0e04b3a@google.com>
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
possible deadlock in ext4_find_inline_entry

EXT4-fs: Warning: mounting with an experimental mount option 'dioread_nolock' for blocksize < PAGE_SIZE
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-00172-ga5541c0811a0-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/3637 is trying to acquire lock:
ffff0000d11c93e8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_find_inline_entry+0x80/0x224 fs/ext4/inline.c:1690

but task is already holding lock:
ffff0000d11ca0b0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff0000d11ca0b0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: vfs_unlink+0x78/0x300 fs/namei.c:4241

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       ext4_xattr_inode_write+0x2f0/0x460 fs/ext4/xattr.c:1400
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1538 [inline]
       ext4_xattr_set_entry+0xd38/0xe08 fs/ext4/xattr.c:1662
       ext4_xattr_ibody_set+0x94/0x184 fs/ext4/xattr.c:2222
       ext4_xattr_set_handle+0x648/0x9a0 fs/ext4/xattr.c:2379
       ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2493
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

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       ext4_find_inline_entry+0x80/0x224 fs/ext4/inline.c:1690
       __ext4_find_entry+0xe8/0xb4c fs/ext4/namei.c:1596
       ext4_find_entry fs/ext4/namei.c:1731 [inline]
       __ext4_unlink+0xa8/0x3e4 fs/ext4/namei.c:3215
       ext4_unlink+0x150/0x200 fs/ext4/namei.c:3291
       vfs_unlink+0x1dc/0x300 fs/namei.c:4252
       do_unlinkat+0x200/0x3dc fs/namei.c:4320
       __do_sys_unlinkat fs/namei.c:4363 [inline]
       __se_sys_unlinkat fs/namei.c:4356 [inline]
       __arm64_sys_unlinkat+0x7c/0xa8 fs/namei.c:4356
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
  lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->xattr_sem);
                               lock(&ea_inode->i_rwsem#8/1);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz-executor.0/3637:
 #0: ffff0000cabc0460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:393
 #1: ffff0000d11c9720 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #1: ffff0000d11c9720 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0xf0/0x3dc fs/namei.c:4303
 #2: ffff0000d11ca0b0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff0000d11ca0b0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: vfs_unlink+0x78/0x300 fs/namei.c:4241

stack backtrace:
CPU: 0 PID: 3637 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-00172-ga5541c0811a0-dirty #0
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
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
 ext4_find_inline_entry+0x80/0x224 fs/ext4/inline.c:1690
 __ext4_find_entry+0xe8/0xb4c fs/ext4/namei.c:1596
 ext4_find_entry fs/ext4/namei.c:1731 [inline]
 __ext4_unlink+0xa8/0x3e4 fs/ext4/namei.c:3215
 ext4_unlink+0x150/0x200 fs/ext4/namei.c:3291
 vfs_unlink+0x1dc/0x300 fs/namei.c:4252
 do_unlinkat+0x200/0x3dc fs/namei.c:4320
 __do_sys_unlinkat fs/namei.c:4363 [inline]
 __se_sys_unlinkat fs/namei.c:4356 [inline]
 __arm64_sys_unlinkat+0x7c/0xa8 fs/namei.c:4356
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10d9aec4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=d3bb749184481f92deb5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15213e32480000

