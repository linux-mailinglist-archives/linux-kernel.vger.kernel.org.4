Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004875F3ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJDIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJDIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:49:44 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014B6477
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:49:43 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso5614804ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=VBeaHDpdMW1szRoAus88zuJw4xnVO7SqiCfgFw2DXwo=;
        b=n/5b3du8kYZDhB6CQlwGfDp7rutkWHZarNyzjuHWWUUSLQLt1ZDVLhECNnl9Cmgz5b
         CRjYeOUh1HMQp2Sk4qipSfG9g35SP6ISZ47MatYY7ROBtVvcjlkd8XTqb5wiGvdG8D3f
         pLeHrCIG4vqMQjcBZFbpla6c6eo9hdgd7Qeaz+gNwWkbJUEfKOytvPQM2bia+OMy9zAt
         rTfoyC7R95h8i4PM6quzj1KV4J7A22foIyI8+l3jwl0cavvbqo0seUODw7F4Hg2UjkOy
         2tnb2U4HFTI6wUpkyK8Wp0dMXdLVUGNPQExhkNyEsLD2TNkeskmOdzbglOsv/LHj4+zL
         sjQg==
X-Gm-Message-State: ACrzQf3+C0U9zKDK1vtBiY5XwryMZVwCa0dIDESVm9SvMYNIzhCQKj+V
        j+rtUsahXxw1J5aJcoAYHFVK914BiivZDGhZ/F3MsAtYX0ef
X-Google-Smtp-Source: AMsMyM46aFwfyzGc/e8EUFOd4K5gNimo5H9/+hwlW87B84h1xj8UFd8UKM1UcFjdTVlUV16LAKIj54cV/0aRq6q/xepCv/8l0Mm/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:2f1:fcbb:e6e0 with SMTP id
 s12-20020a056e0218cc00b002f1fcbbe6e0mr11469385ilu.139.1664873382171; Tue, 04
 Oct 2022 01:49:42 -0700 (PDT)
Date:   Tue, 04 Oct 2022 01:49:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a5a2e05ea318aa9@google.com>
Subject: [syzbot] memory leak in __get_metapage
From:   syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    4fe89d07dcc2 Linux 6.0
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169a7924880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21254cf9c7c084e0
dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bdd7ec880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/651a252f7035/disk-4fe89d07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/776feb8e0e5b/vmlinux-4fe89d07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888114339e80 (size 128):
  comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114339e00 (size 128):
  comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114339d80 (size 128):
  comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881142f0300 (size 128):
  comm "syz-executor.0", pid 3676, jiffies 4295017533 (age 7.330s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
