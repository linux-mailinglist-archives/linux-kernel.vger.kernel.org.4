Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301B8654360
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiLVOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLVOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:50:52 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63744140BE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:50:51 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso782400iow.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvCDHTZz8XZgDHWgSHzRw1HHbu1w6RGcC+QRODVz9tU=;
        b=q8VRkvSsUd4yoz0RJI61pGIqyJKH3kkIzd8unIdQDxV0A8qe3eeC3DJCq0dsd6YvWx
         8OMoT75lrav5WypQe75njOGgTjyT15b6/CCs8bBDLfuS9pvp5XP2orTck3agciUDbU51
         l2D8kTU4UGm/uPm86mFhtFiC4On51RxnF2pyAh78gnx5f9BLOMIJpYTh8WsNEhniLdkw
         lvZSTAUyoXQb1186s9LF2GjoJE0OfvXj6vCPjtTGYtjGesw6sDG3IzQ4aoScUS5OhMjr
         KZWPHj9AbSCl34oJHOCE2wQxb40LA92JN55lA+5np/w9RBtRUNjFzBQas4vt4KSdTDnn
         N00Q==
X-Gm-Message-State: AFqh2krsTiQTcuxMmfcai6Lvmoz/8Fj1kvqGvcoNps5ps95BfKdg9hL+
        4gzvg5CdUNyhGAe/FDAxTppF43UpQSx2Pnbj2B0lxvWZ1to9
X-Google-Smtp-Source: AMrXdXul9Lw78c52HR0EIK9tYsTDqGbi0N8fx6kCpC0JHI1kBmPLBK8Y6HoOQCGI/rIUgUkX1uBBk0VV90BrBxydGPjYbsBntK3f
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:491:b0:30a:b1d7:7b19 with SMTP id
 b17-20020a056e02049100b0030ab1d77b19mr637852ils.290.1671720650733; Thu, 22
 Dec 2022 06:50:50 -0800 (PST)
Date:   Thu, 22 Dec 2022 06:50:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d00ec05f06bcb35@google.com>
Subject: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
From:   syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1130468c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141a9390480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166a0317880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9bf67d96dec4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 3 extents in 0ms
Unable to handle kernel NULL pointer dereference at virtual address 00000000000004b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010d0e4000
[00000000000004b8] pgd=080000010d0ef003, p4d=080000010d0ef003, pud=080000010c843003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3073 Comm: syz-executor647 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : gfs2_rindex_update+0x4c/0x21c fs/gfs2/rgrp.c:1037
lr : gfs2_rindex_update+0x3c/0x21c fs/gfs2/rgrp.c:1035
sp : ffff800012f13610
x29: ffff800012f13650 x28: 0000000000000000 x27: 0000000000000000
x26: ffff0000ca97a580 x25: ffff0000cb5ee000 x24: ffff0000cb5ee174
x23: 0000000000000000 x22: ffff80000925c6b0 x21: ffff800012f13850
x20: ffff0000cb5ee000 x19: 0000000000000000 x18: ffff800012f132d0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c99bcec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c99bcec0
x11: ff808000092a1b7c x10: 0000000000000000 x9 : ffff8000092a1b7c
x8 : ffff0000c99bcec0 x7 : ffff80000846001c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 gfs2_rindex_update+0x4c/0x21c fs/gfs2/rgrp.c:1038
 punch_hole+0x578/0x18b8 fs/gfs2/bmap.c:1796
 gfs2_truncatei_resume+0x28/0x68 fs/gfs2/bmap.c:2154
 inode_go_held+0xb8/0xe0 fs/gfs2/glops.c:513
 gfs2_instantiate+0xf0/0x208 fs/gfs2/glock.c:529
 gfs2_glock_holder_ready fs/gfs2/glock.c:1326 [inline]
 gfs2_glock_wait+0x10c/0x164 fs/gfs2/glock.c:1346
 gfs2_glock_nq+0x104/0x220 fs/gfs2/glock.c:1596
 gfs2_glock_nq_init fs/gfs2/glock.h:264 [inline]
 init_statfs fs/gfs2/ops_fstype.c:696 [inline]
 init_journal+0x7a8/0xcbc fs/gfs2/ops_fstype.c:820
 init_inodes+0x74/0x184 fs/gfs2/ops_fstype.c:889
 gfs2_fill_super+0x630/0x874 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 gfs2_get_tree+0x30/0xc0 fs/gfs2/ops_fstype.c:1330
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
Code: f943a293 b947c697 2a1f03e0 a902ffff (f9425e75) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f943a293 	ldr	x19, [x20, #1856]
   4:	b947c697 	ldr	w23, [x20, #1988]
   8:	2a1f03e0 	mov	w0, wzr
   c:	a902ffff 	stp	xzr, xzr, [sp, #40]
* 10:	f9425e75 	ldr	x21, [x19, #1208] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
