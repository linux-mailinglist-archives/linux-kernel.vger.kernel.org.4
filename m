Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBE636064
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiKWNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbiKWNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:49:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6498FFB6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:39:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so12903916ila.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5v6FVJiWDPwCtZbVBbR7imLaX6jhd6vr9IiwO5Qv4M=;
        b=EA006QR4hoBbuAO1cj34sNAT7IhbYO7F4lgSY07Yhbx+RXiOdLwyR66+EAoUCMsK0x
         DQt/H/1IaNEDoyJcn0PNsaOK7R84gpQZyjkW/v5LIkx4GN6p5WBxj0TDJA6deGu/bhag
         AqxXozGHnSzoPfWfpAC7PCQDKfp+TccOtMs86o7/MenyP8KgRwQMmyqSHAMkZJBKXmuh
         kZLUM8pZ1LeyJDHisMqpwEjO72jGTfag3dSW4D7vJ9FF+4QZDN2SpRhEIAIYH/deiknT
         X84jnze8QYHWQVt+ualXccAkfEJXqaedaHIcfMkm7RdHh9rgAYTEqztfr1LZgvl/Uud4
         /VBQ==
X-Gm-Message-State: ANoB5plUqLfV2Q5FtgXCmTQLwD7MQq1OnNaAUh6GLPJDA2iJYABoQbTC
        Dehl+el22AeBSzBGk7XRSVOFz39EoNlXZa5le3p9wOwR9qlI
X-Google-Smtp-Source: AA0mqf576t2sB8RxEr4aHp29KPgLonTD00mNU35QmiaoxRtGJIEx77JlP2vTylvd4gWH7izJ7lcF5PzpVupZK62sDC1WXn4ZAZLG
MIME-Version: 1.0
X-Received: by 2002:a02:5187:0:b0:375:175c:b00e with SMTP id
 s129-20020a025187000000b00375175cb00emr12513033jaa.215.1669210782082; Wed, 23
 Nov 2022 05:39:42 -0800 (PST)
Date:   Wed, 23 Nov 2022 05:39:42 -0800
In-Reply-To: <000000000000b04b4705e7ea36fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8acd305ee236b14@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in open_xa_dir
From:   syzbot <syzbot+3c530d01065fbfab6070@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
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

HEAD commit:    65762d97e6fa Merge branch 'for-next/perf' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12a2de53880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56d0c7c3a2304e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=3c530d01065fbfab6070
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17de2dfd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16df682d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52f702197b30/disk-65762d97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72189c2789ce/vmlinux-65762d97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec0349196c98/Image-65762d97.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/68a9fabb474d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/8ac3adab6aa9/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c530d01065fbfab6070@syzkaller.appspotmail.com

REISERFS (device loop0): Using tea hash to sort names
REISERFS warning (device loop0): jdm-20006 create_privroot: xattrs/ACLs enabled and couldn't find/create .reiserfs_priv. Failing mount.
loop0: detected capacity change from 0 to 32768
Unable to handle kernel paging request at virtual address dead4ead00000068
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[dead4ead00000068] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3114 Comm: syz-executor354 Not tainted 6.1.0-rc6-syzkaller-32653-g65762d97e6fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : d_really_is_negative include/linux/dcache.h:466 [inline]
pc : open_xa_root fs/reiserfs/xattr.c:124 [inline]
pc : open_xa_dir+0x48/0x2a8 fs/reiserfs/xattr.c:152
lr : open_xa_dir+0x34/0x2a8 fs/reiserfs/xattr.c:148
sp : ffff80000fc6b850
x29: ffff80000fc6b870 x28: 0000000000000030 x27: ffff0000c71289c0
x26: 0000000000000000 x25: 0000000000000000 x24: dead4ead00000000
x23: 0000000000000000 x22: 0000000000000002 x21: ffff0000caf387b8
x20: 0000000000000002 x19: ffff0000c9dd6000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000008000 x12: ffff80000d4fdd40
x11: ff8080000879c764 x10: 0000000000000000 x9 : ffff80000879c764
x8 : ffff0000c6bd2d00 x7 : ffff8000086b4590 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 0000000000000002 x0 : ffff0000caf387b8
Call trace:
 open_xa_root fs/reiserfs/xattr.c:121 [inline]
 open_xa_dir+0x48/0x2a8 fs/reiserfs/xattr.c:152
 xattr_lookup+0x34/0x198 fs/reiserfs/xattr.c:395
 reiserfs_xattr_get+0x8c/0x6a8 fs/reiserfs/xattr.c:677
 reiserfs_get_acl+0x84/0x1ac fs/reiserfs/xattr_acl.c:214
 get_acl+0x104/0x398 fs/posix_acl.c:153
 check_acl+0x40/0x178 fs/namei.c:306
 acl_permission_check fs/namei.c:351 [inline]
 generic_permission+0x270/0x32c fs/namei.c:404
 reiserfs_permission+0x4c/0x6c fs/reiserfs/xattr.c:954
 do_inode_permission fs/namei.c:458 [inline]
 inode_permission+0x128/0x244 fs/namei.c:525
 may_open+0x1e4/0x2bc fs/namei.c:3185
 do_open fs/namei.c:3555 [inline]
 path_openat+0xdd0/0x11c4 fs/namei.c:3713
 do_filp_open+0xdc/0x1b8 fs/namei.c:3740
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 390043ff a9007fff f9433e68 f942cd18 (f9403708) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	390043ff 	strb	wzr, [sp, #16]
   4:	a9007fff 	stp	xzr, xzr, [sp]
   8:	f9433e68 	ldr	x8, [x19, #1656]
   c:	f942cd18 	ldr	x24, [x8, #1432]
* 10:	f9403708 	ldr	x8, [x24, #104] <-- trapping instruction

