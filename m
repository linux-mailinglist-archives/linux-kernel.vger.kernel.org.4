Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341AF5FD5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJMIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJMIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:05:59 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE561463A2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:05:52 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id m3-20020a170902bb8300b0017f7e7e4385so888618pls.20
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnynIjrdRLYAS1wshaEi17rI4OwZ/VwE4UdIwgeg8Wo=;
        b=nb/J0IN4DEkK1AUbGewqfS1fIuzLO2hptkgIzMHJocseELPxjtQAfivrdNAsF+ge0R
         erZSGefaj7LDI2n87QJZPK6rME3qrMnNT4JL9sXYv828EzwyQWAxTLe+qD1FZgzYBQFI
         5JV3WdCPk/7ueDiPVItLuX4J9IFY4boEuY78+u1TgdAqjhZwzzwVA9C7bh46gSzDW5x2
         svcQfKdQD+AyGbjVHb8FxgZVub4y0ZgADeTQUyts2IgR6EvbDRCUeTqzimNgtMhUhOAa
         6BGH5FATROUm3iqLrPaNoTBSA9N02ryPxZQfQhRm2DAT4eBTWcSfeOjbHpT/lsJwOF7U
         ttig==
X-Gm-Message-State: ACrzQf3ZwAjFiJ6lsylvg+4K7PdSa8kEPIaU5c3/OboYRz4KVH6Q+QYl
        W6ZNxwqUiVRYJXOqJLL/e+c+Ob7CdBotQtgNAa7Kso3iF1wV
X-Google-Smtp-Source: AMsMyM77KVcqgU4rj+5WPf3iBXhzyOVk7SvjSuSFL1LszHxTyP1980YaQbwyOgLk3/F99GgKByCpeT8CA85vUSDA7c5M5KFBo3ji
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id
 m10-20020a056e02158a00b002d3f1c06b68mr16704213ilu.38.1665648340638; Thu, 13
 Oct 2022 01:05:40 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:05:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa237005eae5f9da@google.com>
Subject: [syzbot] memory leak in vfs_tmpfile_open
From:   syzbot <syzbot+fd749a7ea127a84e0ffd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    49da07006239 Merge tag 'memblock-v6.1-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fea734880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a068149f16da5bd
dashboard link: https://syzkaller.appspot.com/bug?extid=fd749a7ea127a84e0ffd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dfc1a4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123af8aa880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/827598b3022b/disk-49da0700.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6e5b024841f/vmlinux-49da0700.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd749a7ea127a84e0ffd@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888105a4b500 (size 256):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 23.770s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
  backtrace:
    [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881024495a0 (size 24):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 23.770s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
    [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
    [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105b4b900 (size 176):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 23.760s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888100c4bb80 (size 32):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 23.760s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
    [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
    [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
    [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105a4b500 (size 256):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 25.050s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
  backtrace:
    [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881024495a0 (size 24):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 25.050s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
    [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
    [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105b4b900 (size 176):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 25.040s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888100c4bb80 (size 32):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 25.040s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
    [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
    [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
    [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105a4b500 (size 256):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 26.330s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
  backtrace:
    [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881024495a0 (size 24):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 26.330s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
    [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
    [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105b4b900 (size 176):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 26.320s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888100c4bb80 (size 32):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 26.320s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
    [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
    [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
    [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105a4b500 (size 256):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 27.580s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
  backtrace:
    [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881024495a0 (size 24):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 27.580s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
    [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
    [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105b4b900 (size 176):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 27.570s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888100c4bb80 (size 32):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 27.570s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
    [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
    [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
    [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105a4b500 (size 256):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.460s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
  backtrace:
    [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881024495a0 (size 24):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.460s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
    [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
    [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105b4b900 (size 176):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.450s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888100c4bb80 (size 32):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
    [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
    [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
    [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105a4b500 (size 256):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.490s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
  backtrace:
    [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881024495a0 (size 24):
  comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.490s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
    [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
    [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
    [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
    [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
    [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
    [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
    [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
    [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
    [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
    [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
    [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
    [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
    [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
    [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
    [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
    [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888105b4b900 (size 176):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.480s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888100c4bb80 (size 32):
  comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.480s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
    [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
    [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
    [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
    [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
    [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
    [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

executing program
executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
