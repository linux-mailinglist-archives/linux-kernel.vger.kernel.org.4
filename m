Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BF6667CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjALAgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjALAgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:36:39 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1DB29
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:36:38 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so10081909iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5NkdbXtpWrwA9eNy6LrcID1wKrLywawHioj2RaTwSA=;
        b=dSpyvkaq4jSZwNbM1mktB/eNGf5kj2MSihp+dsZXIxEtxYf9A9vxF4C7azxj3mcsQn
         LM3LrHTRL70tYOL5vp3Wy0KVn/J5PddkfK24mFuQCSszf5i/Yd1vFBvdLYxiTsO/SwPI
         Y45Bq3hHkq/tGD99SNTc/9BwwPJda+3ZP2U+ueAZT6kfTVFk2tMRH8niwbiOtaA8s4ZX
         s2AF5qkElj7MqmO8f3KFMS5mqxPgMzFUJvqPymyMEP+dwCnwbbVq0sx5DINrmoizsgXq
         74GbxKmfASw959zzn7pIyD4BNp/PqWmUAccVZLS8YfyFg1K1EWQxnFpUBLFMRGYj713S
         AMvA==
X-Gm-Message-State: AFqh2ko3rjHh+4O/GQO4z7ZvnUtX4Mj+oFqO6IRDPgb5B5QpKjc8eiJa
        z0LLRZMRjf3CxnUTCnjUwGVwNPcu7qOgJa3hMCzymh6/UsND
X-Google-Smtp-Source: AMrXdXum0xAcqwssz4oaxqWVam753IwLETLYJzX6JY+Au3Q7EiXRmQMok5TRLuYPtPkwp5tO8G4WNOA3Y1qHiP0Bz8YI1bvZnzEe
MIME-Version: 1.0
X-Received: by 2002:a02:22cb:0:b0:38a:5321:ea6 with SMTP id
 o194-20020a0222cb000000b0038a53210ea6mr7269478jao.165.1673483797803; Wed, 11
 Jan 2023 16:36:37 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:36:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e3e8f05f2064f2d@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref
From:   syzbot <syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

HEAD commit:    ae87308093bc Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=152f9dfc480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cb176fd0bc15059
dashboard link: https://syzkaller.appspot.com/bug?extid=d4b971e744b1f5439336
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a38fec480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106ffae2480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1c9355518bc/disk-ae873080.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2db3dca5f602/vmlinux-ae873080.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1477d6145e3c/Image-ae873080.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/401f01482f1f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4b971e744b1f5439336@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ea_inode->i_rwsem" with key ext4_fs_type, but found a different class "&sb->s_type->i_mutex_key" with the same key
WARNING: CPU: 0 PID: 4452 at kernel/locking/lockdep.c:940 look_up_lock_class+0x158/0x160
Modules linked in:
CPU: 0 PID: 4452 Comm: syz-executor318 Not tainted 6.2.0-rc2-syzkaller-16046-gae87308093bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : look_up_lock_class+0x158/0x160
lr : look_up_lock_class+0x154/0x160 kernel/locking/lockdep.c:937
sp : ffff80000ff434e0
x29: ffff80000ff434e0 x28: 0000000000000000 x27: 0000000000000000
x26: ffff0000cafac6f0 x25: ffff800008877514 x24: 0000000000000000
x23: ffff80000f058000 x22: 0000000000000001 x21: ffff80000d6a1e68
x20: 0000000000000000 x19: ffff80000ddabc98 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
x14: 000000000000000d x13: 205d323534345420 x12: 5b5d303330383736
x11: ff808000081cbbc8 x10: 0000000000000000 x9 : b4969308ab43b000
x8 : b4969308ab43b000 x7 : 205b5d3033303837 x6 : ffff80000c121738
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : ffff80000ddabc98
Call trace:
 look_up_lock_class+0x158/0x160
 register_lock_class+0x4c/0x2f8 kernel/locking/lockdep.c:1289
 __lock_acquire+0xa8/0x3084 kernel/locking/lockdep.c:4934
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 ext4_xattr_inode_update_ref+0x4c/0x2cc fs/ext4/xattr.c:998
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1049 [inline]
 ext4_xattr_block_set+0x4b4/0x1404 fs/ext4/xattr.c:2150
 ext4_xattr_set_handle+0x724/0x9a0 fs/ext4/xattr.c:2390
 ext4_xattr_set+0x104/0x1d4 fs/ext4/xattr.c:2492
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x290/0x29c fs/xattr.c:202
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:236
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:297
 vfs_setxattr+0xf4/0x1f4 fs/xattr.c:323
 do_setxattr fs/xattr.c:608 [inline]
 setxattr fs/xattr.c:631 [inline]
 path_setxattr+0x32c/0x424 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:662
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 5901
hardirqs last  enabled at (5901): [<ffff80000c1268a4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (5901): [<ffff80000c1268a4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (5900): [<ffff80000c1266e0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (5900): [<ffff80000c1266e0>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (5822): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (5811): [<ffff800008017c90>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---

======================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
