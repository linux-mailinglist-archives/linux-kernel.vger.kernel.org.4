Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FA6564FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLZUkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 15:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLZUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 15:40:37 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90F10C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 12:40:36 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i7-20020a056e021b0700b003033a763270so7604298ilv.19
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 12:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6LPm+7jf2gMUBY5UKDDtmShLVXC7oKCmLg+EK6Jv1c=;
        b=Bdpnp9o/hmdW5j21WKopta8kpv/smQwweNM+z07SfYm916wAGm+KagVjwnCEKTjKHH
         xpvCJEjeIMyKkyDaz5199SJhipsfoRQWq2h+iRRaEe4A9dwa0U1PfYqtiYqhJ+hXasMK
         /Gkp7dRPowW8FpiU+PW9leMpaFaiZ/khdWkXgtSPe/RYdPuqWEbP6/S1GOHQ2VLhb33u
         UYEIf7b3XsyiUfvK4xkZpWAeZ7nVOnER1rHvMHYBfK2OsHmHGR9W/w9tz2MVg/R6xcmO
         db4aQRJuUOOeOHGl8FGBQZXRIAaDz1ShYSWKqDmA670/LOwPGqt4sgoktIAfnPZEiohx
         9MMQ==
X-Gm-Message-State: AFqh2kqj/1gGac1GmgM9GUP98WdqyUz1LyzsvjhdYAgTS77Kc5IiNvFb
        cNpyvuui31MDoGuoH/4zNa37McQqQS8OcSl2B1+dljKb2egP
X-Google-Smtp-Source: AMrXdXuX2fiHsarqGhJtMvhB81vRP0OlhyTwSe2bQXrd8HDgG1Zoq0+lHE2jszckuRcXGv/bizGK0tpgTfZHXKJPG4wZPB53ZyPU
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a47:b0:6e3:8c1:35cf with SMTP id
 k7-20020a0566022a4700b006e308c135cfmr1513362iov.12.1672087235425; Mon, 26 Dec
 2022 12:40:35 -0800 (PST)
Date:   Mon, 26 Dec 2022 12:40:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b37bea05f0c125be@google.com>
Subject: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rgrp_dump
From:   syzbot <syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11859c50480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101babb4480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bfb18c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0bee075b0175/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com

ri_length = 1
ri_data0 = 19
ri_data = 2060
ri_bitbytes = 514
start=0 len=514 offset=128
gfs2: fsid=syz:syz.s:  R: n:18 f:00 b:0/0 i:0 q:0 r:0 e:0
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010e23f000
[0000000000000004] pgd=080000010b804003, p4d=080000010b804003, pud=080000010a4e8003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor147 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2313
lr : gfs2_rgrp_dump+0x90/0x138
sp : ffff80000fb93780
x29: ffff80000fb937a0 x28: ffff0000cb82a000 x27: ffff0000cb82a000
x26: ffff0000ca4de000 x25: 0000000000000808 x24: 000000000000080c
x23: 000000000001c103 x22: ffff0000ca4de000 x21: 0000000000000000
x20: ffff80000fb937e0 x19: ffff0000ca4de080 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c6800000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6800000
x11: ff808000092a5154 x10: 0000000000000000 x9 : ffff8000092a5154
x8 : 0000000000000000 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : ffff80000cc9c685 x0 : 0000000000000000
Call trace:
 gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2312
 gfs2_consist_rgrpd_i+0x78/0xe4 fs/gfs2/util.c:480
 read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
 gfs2_ri_update+0x398/0x7e4 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x1b0/0x21c fs/gfs2/rgrp.c:1051
 init_inodes+0x11c/0x184 fs/gfs2/ops_fstype.c:917
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
Code: f94036c8 f001cfa1 911a1421 aa1503e0 (2940a909) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f94036c8 	ldr	x8, [x22, #104]
   4:	f001cfa1 	adrp	x1, 0x39f7000
   8:	911a1421 	add	x1, x1, #0x685
   c:	aa1503e0 	mov	x0, x21
* 10:	2940a909 	ldp	w9, w10, [x8, #4] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
