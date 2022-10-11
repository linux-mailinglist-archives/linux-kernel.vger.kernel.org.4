Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09105FB0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiJKLAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:00:35 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BC2CDD7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:00:33 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id 7-20020a056a00070700b0056264748f0fso7200489pfl.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OBupGJfUlsBck0WLDpt6ifV+vV4bqTkfborNc+/nxg=;
        b=L7n1L8HR7ErQItp0o3Id7bGd6WOvPTMSi0ecujffrhn6Qos/7BIbtKtGmdM4SRuwKP
         cZW1Qmu8b++7AOT12O06TWbKbfqOwMxDjur2kiUq2HoA7Ur3k3k+EY8b1psdcvfPwmCf
         nRbBwS90p6Fw0uqCACcony5DLn0iQwmWSZH7lqkcar+4VmSRj+PX0sOK/R7zVWLT6a4I
         NPPgWJ997Cl5oOAqk86yy/nrLi0Los4NEPiFXoxbxDw2I4ASoqs4yR69d3v7naWDvSJz
         +1I1uEt4P5n8yhKcpWKEmTzHh4q2UD/tq2cGxlj2Z/N6+RPgUy7NCDaQbgfIA9x1PvEh
         7Cdg==
X-Gm-Message-State: ACrzQf2ZK0gUsUwn0kpH5D7r7dfk3nLIirrRgDzL5wjWtTJZOmA0PLx5
        7zZZtEyblKgdtMD8E9hPxh0PWBhc83kQcg91bRA7kRk1uck5
X-Google-Smtp-Source: AMsMyM6YbkfQy8kTEuw8w5ynkeuzS7bIkOFds9eGDyJisa4KJPH+sLLWrI4SlRZgcLJBOEm+m4raf163uo4w8S5Vju/W0NGFmWNY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d4:b0:6a3:f88e:4852 with SMTP id
 g20-20020a05660226d400b006a3f88e4852mr10343152ioo.55.1665486023284; Tue, 11
 Oct 2022 04:00:23 -0700 (PDT)
Date:   Tue, 11 Oct 2022 04:00:23 -0700
In-Reply-To: <4449089.LvFx2qVVIh@mypc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbe1c005eac02e1a@google.com>
Subject: Re: [syzbot] memory leak in __get_metapage
From:   syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __get_metapage

BUG: memory leak
unreferenced object 0xffff888115b53800 (size 128):
  comm "syz-executor.0", pid 4198, jiffies 4294944352 (age 13.760s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f373>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c4f24e>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c4f24e>] __get_metapage+0x3ae/0xae0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c37cc2>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c396b4>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c396b4>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c3b4df>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c4c1da>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c2e937>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f0df3>] vfs_mkdir+0x223/0x340 fs/namei.c:4035
    [<ffffffff815f9d65>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4060
    [<ffffffff815f9ed9>] __do_sys_mkdir fs/namei.c:4080 [inline]
    [<ffffffff815f9ed9>] __se_sys_mkdir fs/namei.c:4078 [inline]
    [<ffffffff815f9ed9>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4078
    [<ffffffff845fee85>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fee85>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888115b53880 (size 128):
  comm "syz-executor.0", pid 4198, jiffies 4294944352 (age 13.760s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f373>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c4f24e>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c4f24e>] __get_metapage+0x3ae/0xae0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c37cc2>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c396b4>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c396b4>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c3b4df>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c4c1da>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c2e937>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f0df3>] vfs_mkdir+0x223/0x340 fs/namei.c:4035
    [<ffffffff815f9d65>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4060
    [<ffffffff815f9ed9>] __do_sys_mkdir fs/namei.c:4080 [inline]
    [<ffffffff815f9ed9>] __se_sys_mkdir fs/namei.c:4078 [inline]
    [<ffffffff815f9ed9>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4078
    [<ffffffff845fee85>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fee85>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888115b53900 (size 128):
  comm "syz-executor.0", pid 4198, jiffies 4294944352 (age 13.760s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f373>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c4f24e>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c4f24e>] __get_metapage+0x3ae/0xae0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c37cc2>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c396b4>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c396b4>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c3b4df>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c4c1da>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c2e937>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f0df3>] vfs_mkdir+0x223/0x340 fs/namei.c:4035
    [<ffffffff815f9d65>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4060
    [<ffffffff815f9ed9>] __do_sys_mkdir fs/namei.c:4080 [inline]
    [<ffffffff815f9ed9>] __se_sys_mkdir fs/namei.c:4078 [inline]
    [<ffffffff815f9ed9>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4078
    [<ffffffff845fee85>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fee85>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888116622700 (size 128):
  comm "syz-executor.0", pid 4739, jiffies 4294944954 (age 7.740s)
  hex dump (first 32 bytes):
    00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8148f373>] mempool_alloc+0x73/0x230 mm/mempool.c:392
    [<ffffffff81c4f24e>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
    [<ffffffff81c4f24e>] __get_metapage+0x3ae/0xae0 fs/jfs/jfs_metapage.c:651
    [<ffffffff81c37cc2>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
    [<ffffffff81c396b4>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
    [<ffffffff81c396b4>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
    [<ffffffff81c3b4df>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
    [<ffffffff81c4c1da>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
    [<ffffffff81c2e937>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
    [<ffffffff815f0df3>] vfs_mkdir+0x223/0x340 fs/namei.c:4035
    [<ffffffff815f9d65>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4060
    [<ffffffff815f9ed9>] __do_sys_mkdir fs/namei.c:4080 [inline]
    [<ffffffff815f9ed9>] __se_sys_mkdir fs/namei.c:4078 [inline]
    [<ffffffff815f9ed9>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4078
    [<ffffffff845fee85>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fee85>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



Tested on:

commit:         60bb8154 Merge tag 'xfs-6.1-for-linus' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --
console output: https://syzkaller.appspot.com/x/log.txt?x=171a96dc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=589d84e4754dd2fa
dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1095fc78880000

