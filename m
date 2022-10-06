Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237C5F7215
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiJFXye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiJFXya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:54:30 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82586604B1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:54:21 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso2210775iob.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxdtOjk8S9rTADaHem6JSDHhaJv3J9+AGllHjfNZSRw=;
        b=AJmhiie/cVomW6Y4sIbON5eXFvsR2R2Y2pDqQ/wB9Nuj8tdpR+z5i8qOYBv6wZeaF1
         i3y9emhYAuYd86c02xb0t4qblMiS8RwrnKct2vSdxdJqhXd+u7SFdl/AmDcEuMTdX2Af
         gSGGsKqPUKbFKegue6NweIJYo5sjtzpa6iRsfGQEhD+I9DGkVpI1pQD/uNKqz5kUgcbG
         Hv6ngX1HBdszSnsogRRzjbdlpOjGlD0jUKcfF/8oddGAdglBXxHy7k87mKkeCm/4YIv9
         JY4B+aTK9ZCQsmb3aOUjBE4VcXfqxdcFz75l3DzEc8xtrmfTjR9wLHkF3Lb0xVuFDqUR
         avkA==
X-Gm-Message-State: ACrzQf2j519nRPb5aYV1OCfk2Cy3K6+rEPY8mJTrxFHqo8f/l9tsUxjZ
        MzuCL7Cq42p5olLV2yXVh49FUj2pV3PMsP6oSPbM8C91KlsN
X-Google-Smtp-Source: AMsMyM6bxh2gnneY3hwtVTulwlSmnwtBF7GxoR/OY3h77a2Rm4qfhN6tAvYV9WoC0jPQ2Ppze25juGmVW3OCzbbvFD5tmmqpRci1
MIME-Version: 1.0
X-Received: by 2002:a6b:c384:0:b0:6a4:3773:1fa9 with SMTP id
 t126-20020a6bc384000000b006a437731fa9mr1022612iof.181.1665100460903; Thu, 06
 Oct 2022 16:54:20 -0700 (PDT)
Date:   Thu, 06 Oct 2022 16:54:20 -0700
In-Reply-To: <2387955.jE0xQCEvom@mypc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cd19505ea66692e@google.com>
Subject: Re: [syzbot] memory leak in __get_metapage
From:   syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __get_metapage

BUG: memory leak
unreferenced object 0xffff88810abfae80 (size 128):
  comm "syz-executor.0", pid 4206, jiffies 4294944336 (age 14.270s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f863>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5adba>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5adba>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43722>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45114>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45114>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c46f3f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57c5a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a397>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f9a23>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff81602a05>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81602b79>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81602b79>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81602b79>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff846099a5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff846099a5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810abfaf00 (size 128):
  comm "syz-executor.0", pid 4206, jiffies 4294944336 (age 14.270s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f863>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5adba>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5adba>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43722>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45114>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45114>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c46f3f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57c5a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a397>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f9a23>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff81602a05>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81602b79>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81602b79>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81602b79>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff846099a5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff846099a5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810a5a7080 (size 128):
  comm "syz-executor.0", pid 4206, jiffies 4294944336 (age 14.270s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f863>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5adba>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5adba>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43722>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45114>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45114>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c46f3f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57c5a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a397>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f9a23>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff81602a05>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81602b79>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81602b79>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81602b79>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff846099a5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff846099a5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888114d44e80 (size 128):
  comm "syz-executor.0", pid 4734, jiffies 4294944949 (age 8.140s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f863>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c5adba>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c5adba>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c43722>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c45114>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c45114>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c46f3f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c57c5a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c3a397>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f9a23>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
    [<ffffffff81602a05>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
    [<ffffffff81602b79>] __do_sys_mkdir fs/namei.c:4058 [inline]
    [<ffffffff81602b79>] __se_sys_mkdir fs/namei.c:4056 [inline]
    [<ffffffff81602b79>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
    [<ffffffff846099a5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff846099a5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



Tested on:

commit:         ffb39098 Merge tag 'linux-kselftest-kunit-6.1-rc1' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c99b0a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10f41fbb818af57a
dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
