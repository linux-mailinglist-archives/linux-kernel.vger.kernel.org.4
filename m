Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A44656381
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiLZOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLZOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:42:35 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993823F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:42:34 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so3724276ioc.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbQqDJM7rNEn/w9o07nQo5LxtMxnlWVdv8R6yb+ZPeM=;
        b=LWlfEranN9jdYprmNHo9DpopYWuPGIspRU/SxwlKK13NOoFLWKyIQr2I19QMY1ulZ/
         /BZKWUFevdl/ehKbxLUM9QpCgbdnOItBAGwimul4AkrEmgifb/rsHWNzUN+knAenGtuT
         fUPYk194xJftg2bB+OS3OmDOzKhJGBuCarxSfxtNNnGerNfcWg7LYlvPXdn+xqQ92XdN
         fu8b/qOitojiw4NknKIuKUSXmawumr6wOSaRtJA6TsBi5z7DlwmsAnIhVCYeLN2GXjow
         xQsaZOxWrMQFqL2p3WWNfKJQq5Eqe+cDqvt2Q92NI9mH7fZ8LjsTaYGhJvMt6ylOXWtB
         2XWg==
X-Gm-Message-State: AFqh2krlfgJwXbDkp02qcxVRjO0My8SoxOI/iMKuXENLNmtAqP89w8j+
        R7JpKKwxxsMtf1uoFub+lE+l9kxQs8G7f1u8N8uXGERG+9di
X-Google-Smtp-Source: AMrXdXujo4kXMZZ00hcXHEAD7vPMaQuPsD2v7cPqIHVy2Q+FaZdct6dJ3Bqv22rtAP/htBOT4TWOoom/vDvS+ww+du0v4XC88bZX
MIME-Version: 1.0
X-Received: by 2002:a92:da8b:0:b0:302:f62a:53e7 with SMTP id
 u11-20020a92da8b000000b00302f62a53e7mr1598651iln.273.1672065753772; Mon, 26
 Dec 2022 06:42:33 -0800 (PST)
Date:   Mon, 26 Dec 2022 06:42:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b7b3a05f0bc25f8@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in __lock_acquire (5)
From:   syzbot <syzbot+0bc4c0668351ce1cab8f@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1550a5b4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc4c0668351ce1cab8f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fe2b94480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1567f993880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bcef00e22a50/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bc4c0668351ce1cab8f@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 4096
ntfs3: loop3: Different NTFS' sector size (1024) and media sector size (512)
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __lock_acquire+0x3074/0x3084 kernel/locking/lockdep.c:5055
CPU: 1 PID: 7324 Comm: syz-executor176 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 warn_bogus_irq_restore+0x0/0x40 kernel/panic.c:703
 __lock_acquire+0x3074/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 _atomic_dec_and_lock+0xc8/0x130 lib/dec_and_lock.c:28
 iput+0x50/0x324 fs/inode.c:1765
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs3/super.c:1190
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00000,040e0108,4c017203
Memory Limit: none
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
