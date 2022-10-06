Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0695F5E57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJFBQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJFBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:16:06 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145D486882
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:16:03 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so483153ilv.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 18:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dWBK0PeJlb7q4EWCh2HW1d212YEgbJN5ftwytS6qlU=;
        b=QYKbz1zu7tUBbp4DBWCD7eaoVc1XIKnEVQrr9i0CApGM1cqiT4vXh5e6blGGGA9lzm
         h/UGm0eHG3a8QhzLDUJ1EbqJu4pyMbhElX3jqqSygf8YzpWamGan9CoUvIXSP3lBvwjD
         Gi7LHxZGImMDBN0e0lzxWfmS644s9dBn2AMu4CogYAk35Dy46H+DYWKHJBgjXYY81hie
         By5HexemcPhoQCm1xTFmGDFujT6aoCRNHSaGPy/K8awds+9MEhq8jYTxCgz5xZJwf9RB
         nszLjVWnql3YP0JxW1fdYL0wzOT40XLr/NTiztz1lRB7v+hA9ByeqmfBwUFbyrBAJFIj
         Vsfw==
X-Gm-Message-State: ACrzQf0NwjdA9yUAe3Al1rolVcad3fEOu7QWsI6kugWmBCa0v+zLxybA
        K4U0JpG7hpyd7iX2JEqJQHgiuXxp2HVNhCcOXRzDidRNlwus
X-Google-Smtp-Source: AMsMyM7GK1sett8WQEFOpZ3fTYbw2xsA0GylA31kuN0MnoHOCQgNiRasL4rNg15YRuweM92V7HeZb+6hXgPn57Al5Jpenml0hLt1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2114:b0:363:5abd:f22c with SMTP id
 n20-20020a056638211400b003635abdf22cmr1256687jaj.298.1665018962431; Wed, 05
 Oct 2022 18:16:02 -0700 (PDT)
Date:   Wed, 05 Oct 2022 18:16:02 -0700
In-Reply-To: <4449089.LvFx2qVVIh@mypc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccd4ae05ea536f40@google.com>
Subject: Re: [syzbot] memory leak in __get_metapage
From:   syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
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

> On Tuesday, October 4, 2022 10:49:42 AM CEST syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    4fe89d07dcc2 Linux 6.0
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=169a7924880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=21254cf9c7c084e0
>> dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils 
> for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bdd7ec880000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/651a252f7035/
> disk-4fe89d07.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/776feb8e0e5b/
> vmlinux-4fe89d07.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com
>> 
>> BUG: memory leak
>> unreferenced object 0xffff888114339e80 (size 128):
>>   comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
>>   hex dump (first 32 bytes):
>>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> BUG: memory leak
>> unreferenced object 0xffff888114339e00 (size 128):
>>   comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
>>   hex dump (first 32 bytes):
>>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> BUG: memory leak
>> unreferenced object 0xffff888114339d80 (size 128):
>>   comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
>>   hex dump (first 32 bytes):
>>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> BUG: memory leak
>> unreferenced object 0xffff8881142f0300 (size 128):
>>   comm "syz-executor.0", pid 3676, jiffies 4295017533 (age 7.330s)
>>   hex dump (first 32 bytes):
>>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 

want 2 args (repo, branch), got 1

>
