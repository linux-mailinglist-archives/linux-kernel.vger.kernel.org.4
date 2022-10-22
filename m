Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1707608B32
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJVKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJVKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:00:06 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A946137390
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:14:57 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id k4-20020a056e02156400b002fcfa0da521so5338567ilu.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xW5dbkCNbxwHkMv3yQFNNURiyChnL8UlXJR4JwK/Sc=;
        b=NxNPsB8LTyAK+VQDWP8hyWsxurYjqeILgnm5Pqc74Q8r1bg0SPYtq7HBEPNuxVnB8+
         K8bMRhwFitxUI0f3v0NsQw4eVB3mGvCI772/qRftIm5LUV0S90iGuLAaVVn14wzq53UI
         oG0bJgT86r27SpIIfRrJm/p6sxoru8PPyc8+gxhC5ToeIJ0aMJ4ezDEHezgimqUrrgCF
         Bzg2AtCuN5rlWfzsQYmaz0uikM3o89BAVy7QqWhx7oDvs2/yH7RCqJLrOQM6oQI/Fk0P
         XkUsTXpufkh57LrzbWU2bJKT3hoQ/iA9bBbfKUEAvDrPoBBBrUeuhGxBFe0iWR9w7OHA
         Y0Ww==
X-Gm-Message-State: ACrzQf1SWzBTk1vfrvPYj5eyTu5HpwJNOJCN/3+fD3I3+8BxLBZfyP1p
        0GBieR2MiBbdy2loIe2CKtAJXFsAA61OB5JDVX/tV0ez/D2C
X-Google-Smtp-Source: AMsMyM6UIyo8kQ7W0F1xUfc8UH3LYe9JzyRVh3VhfLo4MpQLwo0SPi1zDBprPGaUPKBjmcMf2BNsAUfNkIxo9p8HeahfeBtBHvwZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ac9:b0:6bc:17dd:3800 with SMTP id
 m9-20020a0566022ac900b006bc17dd3800mr14640181iov.72.1666429475473; Sat, 22
 Oct 2022 02:04:35 -0700 (PDT)
Date:   Sat, 22 Oct 2022 02:04:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edd6c905eb9bd8c2@google.com>
Subject: [syzbot] kernel BUG in dbAllocNear
From:   syzbot <syzbot+c6357942fbe0fce51c76@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=177d4f76880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c6357942fbe0fce51c76
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1730f9b4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14361c36880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a968af44b418/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6357942fbe0fce51c76@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BUG at fs/jfs/jfs_dmap.c:2984 assert(bitno < 32)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:2984!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3065 Comm: syz-executor423 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dbFindBits fs/jfs/jfs_dmap.c:2984 [inline]
pc : dbAllocNear+0x2d4/0x2d8 fs/jfs/jfs_dmap.c:1224
lr : dbFindBits fs/jfs/jfs_dmap.c:2984 [inline]
lr : dbAllocNear+0x2d4/0x2d8 fs/jfs/jfs_dmap.c:1224
sp : ffff8000126db790
x29: ffff8000126db790 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000020 x24: 0000000000000001
x23: 0000000000000020 x22: ffff0000cbd65000 x21: ffff0000cac8d000
x20: 0000000000000001 x19: ffff8000126db880 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c68b4f80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c68b4f80
x11: ff808000081c0d5c x10: 0000000000000000 x9 : 6b29d6d39c8a4400
x8 : 6b29d6d39c8a4400 x7 : ffff80000819545c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000000 x0 : 0000000000000030
Call trace:
 dbFindBits fs/jfs/jfs_dmap.c:2984 [inline]
 dbAllocNear+0x2d4/0x2d8 fs/jfs/jfs_dmap.c:1224
 dbAlloc+0x4fc/0x694 fs/jfs/jfs_dmap.c:813
 ea_get+0x354/0x548 fs/jfs/xattr.c:514
 __jfs_setxattr+0x2ac/0x5f4 fs/jfs/xattr.c:718
 __jfs_xattr_set+0x84/0x108 fs/jfs/xattr.c:917
 jfs_xattr_set+0x58/0x70 fs/jfs/xattr.c:941
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_setxattr fs/xattr.c:658 [inline]
 __se_sys_setxattr fs/xattr.c:654 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:654
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 91052821 91110863 52817502 94c9993b (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
