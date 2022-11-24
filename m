Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6F63726D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKXGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:39:37 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F321DAD12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:39:36 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so688529ild.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWKhGwqKONv8lf/xZZq9190DxesFkjuqvGpZvKPrzrY=;
        b=cRdGrGhE6b+iwWkQnfblOCs+UNWsxQjcuxDWRfPa759dxZWtY50A3gegtrJaLvdCFJ
         9DzIaUQZ1i8rb1xjGs0UW69ehdUVvKfDKlxcXhZM45BuSbaIrXSYcrx1i+2Q2CeWpE6d
         zXZa8MC2+XHj7B6c6IncL8K/mQRfbPcCg0qW5pqxPJD3k8U8WhrEeZQfWsXRtzc/dd5Z
         cBecA19VhP3VbiqUHEfyaNb2+W/y8CYCDbrX6x33uAEY5zN/d4exNyfu2upFMlJNKkD5
         BzFQGslFj+lOL41RDzr7yQbu9nUaKhIHTfYuQuUWTsnbw2hEHtZlTHEuZWl3MFgeIt53
         wIbQ==
X-Gm-Message-State: ANoB5pnH13NfomJnbbQO1QwkJgDItyjCmEOfp73Tg2yCue5o9OklFdyu
        S9fkpPVens6cpCLxjrhihJCvjNRr9P/iAoiVPEI3yXjtNWgu
X-Google-Smtp-Source: AA0mqf4BLaFMfuAEb3wnoMbMDrVmJ9RH3loeOz8ahJYV/DFePuUcJo/LYsy2Yc7TCvF71CiUDZh9SoPcX/9gXWjMJiPcy09VknXa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a5:b0:300:d831:8c90 with SMTP id
 k5-20020a056e0205a500b00300d8318c90mr7087177ils.21.1669271975882; Wed, 23 Nov
 2022 22:39:35 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:39:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027f81605ee31ab88@google.com>
Subject: [syzbot] KMSAN: uninit-value in reiserfs_new_inode (2)
From:   syzbot <syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com>
To:     brauner@kernel.org, damien.lemoal@opensource.wdc.com,
        edward.shishkin@gmail.com, glider@google.com, jack@suse.cz,
        jlayton@kernel.org, linuszeng@tencent.com,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    ddce02aa9c40 net: kmsan: check sk_buffs passed to __netdev..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1200559b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1429f86b132e6d40
dashboard link: https://syzkaller.appspot.com/bug?extid=6450929faa7a97cd42d1
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40435685a7d7/disk-ddce02aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4960172e71de/vmlinux-ddce02aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d91bc515d95/bzImage-ddce02aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in reiserfs_new_inode+0x193a/0x24e0 fs/reiserfs/inode.c:2050
 reiserfs_new_inode+0x193a/0x24e0 fs/reiserfs/inode.c:2050
 reiserfs_create+0x738/0xe60 fs/reiserfs/namei.c:668
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x28e9/0x5600 fs/namei.c:3710
 do_filp_open+0x249/0x660 fs/namei.c:3740
 do_sys_openat2+0x1f0/0x910 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __ia32_sys_creat+0xed/0x160 fs/open.c:1396
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5578
 alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x1b5/0x1010 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 reiserfs_alloc_inode+0x5e/0x140 fs/reiserfs/super.c:642
 alloc_inode+0x83/0x440 fs/inode.c:259
 iget5_locked+0xa5/0x200 fs/inode.c:1241
 reiserfs_fill_super+0x212b/0x3a00 fs/reiserfs/super.c:2053
 mount_bdev+0x508/0x840 fs/super.c:1401
 get_super_block+0x49/0x60 fs/reiserfs/super.c:2601
 legacy_get_tree+0x10c/0x280 fs/fs_context.c:610
 vfs_get_tree+0xa1/0x500 fs/super.c:1531
 do_new_mount+0x694/0x1580 fs/namespace.c:3040
 path_mount+0x71a/0x1eb0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3568
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 0 PID: 3857 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller-63553-gddce02aa9c40 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
