Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3389167ECAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjA0Rlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjA0Rlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:41:46 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA477D6D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:41:43 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g5-20020a92d7c5000000b00310afb74005so3484985ilq.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miKO8nRIAl/PPu614CPsgHa5rh/GvcHtJLm9Wlk+k9s=;
        b=jtLChuo7x0p8rJqLHaMQBJ5nW7sWzq6yq9dE4b9ILadEc1WlOlrQb5/sg+ecTp3qDo
         AX8kNdGPDXkS1YnCKC21OAFPBWFoLekz7qTepTzu4CpRHIlOa/2u9/y6c7aebfkQZBKW
         Sc5c7mi37Un7Kq7d9YTO7ZosoE9oxHOWoN6mIhOMoojDSOi4sNT995rnoXNhK191cIY8
         nr2LK36DOdZHhQNsjexFsnHkRJOsdyfc9VFrp9RirHF33DSqpdQiHtdfy93vhsCpg+1V
         vSMETq8LunbMVzGcCOw3yVp6UwhHgpyTbRoFbXePGurEDGQyGlRTqcv2hzks2moOdMg7
         Q73A==
X-Gm-Message-State: AFqh2ko1zRyj8/yrv+6Nzr2LrMgG+8lzL/vk47+je7PcOVCEIRtmA3Kf
        KQF3gutT1tKMd+zqxjeJJQF93tx4YFWXCRI6mBB+Zci0v5vp
X-Google-Smtp-Source: AMrXdXu7OX/QUqJfC/WAyUx+HnKc2Nt4wn5iS3QQof5w6mH0iHQtjF68B/52N/IQgbdE3jJhxl1RM4pd5Da+WTx74lXf6KKxzUXr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:30c:5f8d:886f with SMTP id
 s11-20020a056e02216b00b0030c5f8d886fmr4750534ilv.7.1674841303048; Fri, 27 Jan
 2023 09:41:43 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:41:43 -0800
In-Reply-To: <0000000000003d19f805f25b3c71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec6bdf05f3426051@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in __destroy_extent_tree
From:   syzbot <syzbot+15d87e3695975269de2c@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1dc22be1f91f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=121135cd480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8cf742d9a45bfb6
dashboard link: https://syzkaller.appspot.com/bug?extid=15d87e3695975269de2c
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1322f625480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154ae485480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae0fce51809c/disk-1dc22be1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e13fba82ffb/vmlinux-1dc22be1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8d97a32221e2/Image-1dc22be1.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6bb4c8db9bf2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15d87e3695975269de2c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/extent_cache.c:1191!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4444 Comm: syz-executor879 Not tainted 6.2.0-rc5-syzkaller-17295-g1dc22be1f91f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __destroy_extent_tree+0x2dc/0x324 fs/f2fs/extent_cache.c:1191
lr : __destroy_extent_tree+0x2dc/0x324 fs/f2fs/extent_cache.c:1191
sp : ffff80000ff0ba90
x29: ffff80000ff0bac0 x28: ffff0000caf45200 x27: 0000000000000000
x26: ffff0000ca1c2000 x25: ffff0000caf77000 x24: 0000000000000001
x23: ffff0000ca1c2bf0 x22: 0000000000000001 x21: ffff0000caf75120
x20: ffff0000caf44bf0 x19: 0000000000000000 x18: 0000000000000109
x17: 0000000000000000 x16: ffff80000dd97118 x15: ffff0000c9558000
x14: 00000000000000c0 x13: 00000000ffffffff x12: ffff0000c9558000
x11: ff8080000937af04 x10: 0000000000000000 x9 : ffff80000937af04
x8 : ffff0000c9558000 x7 : ffff80000937ae40 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000c9558000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 __destroy_extent_tree+0x2dc/0x324 fs/f2fs/extent_cache.c:1191
 f2fs_destroy_extent_tree+0x24/0x40 fs/f2fs/extent_cache.c:1204
 f2fs_evict_inode+0x180/0x97c fs/f2fs/inode.c:789
 evict+0xec/0x334 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x2c4/0x324 fs/inode.c:1773
 f2fs_abort_atomic_write+0x60/0x2c0 fs/f2fs/segment.c:196
 f2fs_ioc_abort_atomic_write fs/f2fs/file.c:2182 [inline]
 __f2fs_ioctl+0x1338/0x3320 fs/f2fs/file.c:4156
 f2fs_ioctl+0x74/0xbc fs/f2fs/file.c:4242
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x104 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 17ffffed 97bce56a d4210000 97bce568 (d4210000) 
---[ end trace 0000000000000000 ]---

