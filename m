Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6F61ECFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiKGIfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:35:06 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E322140BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:35:05 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso6706409iox.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 00:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4dhM167qDUDFvkC7KReo/7Zl6ufN9cwSkSj/ZA1YBw=;
        b=LnWJo4qB7ZmC2HVKa5AYqy+On0TFEmk5yWLcELdEIhvU3cjCxDmu7O7RzGrCTdRiSQ
         48BOo/u+KP/nzz7mBf5GnTAt/fv8oMMhQBiGpLItrvgerS5kf/ADk2mD7f5t//Z/6FaU
         C5zjgZfjU2A18evv2CXUPKpwgQ4DNoYyCPNyqVV0o/NzkvkTCoyUhSyoLdmc801iebN7
         AGLgIFZzwmHeE3GXQ7qxsQqTGha/FmL2Qo6/xwQYWFQdOrpbYV+G0cMTD/Nwy28qLfG4
         SZLxoxQcYkdiXwqGaBwdtCXGqdP1TRz5LwdpC1h/slZzP0GX9/gRXFKNvn+ov/3dbIO2
         t7Sw==
X-Gm-Message-State: ACrzQf2igYgiztTEmFq+4jWOVYe4SRHuHOozHgLpR8bFRXSshrZjMYUA
        pmD/5zBHug+eh1mYvuHnOR43wSQwhfH8QnaY3Jwf+qC9BxBn
X-Google-Smtp-Source: AMsMyM7rpWrlEzjb5uKwbac5QnvRv6DRftQmuDOBzLsBrTamz68xqWTKBpsqW56qwGBRN62zXiPzwDQd6IhuaOB+bSvi70NtOuWs
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d2:b0:6a3:f044:a942 with SMTP id
 g18-20020a05660226d200b006a3f044a942mr29373909ioo.50.1667810082893; Mon, 07
 Nov 2022 00:34:42 -0800 (PST)
Date:   Mon, 07 Nov 2022 00:34:42 -0800
In-Reply-To: <00000000000057abae05eaaccf58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b356505ecdd4b93@google.com>
Subject: Re: [syzbot] WARNING: locking bug in evict
From:   syzbot <syzbot+0cebf0474baedad38dc5@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16044c99880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=0cebf0474baedad38dc5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce4505880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/af5e4ec0c8db/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0cebf0474baedad38dc5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 24392 at kernel/locking/lockdep.c:466 lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
WARNING: CPU: 0 PID: 24392 at kernel/locking/lockdep.c:466 lock_acquire+0x1cc/0x1f8 kernel/locking/lockdep.c:5668
Modules linked in:
CPU: 0 PID: 24392 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
pc : lock_acquire+0x1cc/0x1f8 kernel/locking/lockdep.c:5668
lr : lockdep_recursion_finish kernel/locking/lockdep.c:466 [inline]
lr : lock_acquire+0x10c/0x1f8 kernel/locking/lockdep.c:5668
sp : ffff8000136639f0
x29: ffff800013663a30 x28: 0000000000000000 x27: 0000000000000000
x26: ffff80000d260cbf x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: ffff0000d13369d8 x21: ffff8000085ed654
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000000000f3
x17: 0000000000000000 x16: ffff80000db49158 x15: ffff0000d1951a80
x14: 0000000000000008 x13: 00000000ffffffff x12: ffff0000d1951a80
x11: ff808000095d19c0 x10: 0000000000000000 x9 : 00000000000000ff
x8 : ffff8001f1d5e000 x7 : ffff8000085ed654 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000008 x1 : ffff80000cb431b1 x0 : ffff80000ce4fec5
Call trace:
 lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
 lock_acquire+0x1cc/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_sb_list_del fs/inode.c:503 [inline]
 evict+0x90/0x334 fs/inode.c:654
 iput_final fs/inode.c:1748 [inline]
 iput+0x2c4/0x324 fs/inode.c:1774
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs3/super.c:1190
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 4160
hardirqs last  enabled at (4159): [<ffff80000bfb8138>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (4159): [<ffff80000bfb8138>] exit_to_kernel_mode+0xe8/0x118 arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (4160): [<ffff80000bfb5fbc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:404
softirqs last  enabled at (3076): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (2999): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---

