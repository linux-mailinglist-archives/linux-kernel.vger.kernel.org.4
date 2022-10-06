Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C655F5E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJFBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJFBXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:23:36 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA602AC43
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:23:35 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id z4-20020a921a44000000b002f8da436b83so461998ill.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 18:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiiXurAviyrzL9sT7OZ8NDEOBWPoTXkeASlEMNAqGmk=;
        b=0Zu40xSA0uny/pC4AqnUHFuK9euMAKMbthPuuOMf0y1hlXBPpEYadlI/f0uX7mEn6Q
         CZRSD7shFJCRo30dS5Cplt5lFVKZ0pnnfbb/f28A/gaUQ+uzqjBj/pKgv3glleyHKsN9
         cyK12QBvrtzo7v9nwNnFyUv4BLlzre1pUWn/zHzEsfiIWMkkeXx57JhuQg2wdi4enlly
         Z/TcCtuutq8U1YVfVf/dJ9/JOPP75R/GjN6tBOizHXcP1myg6qq1yBStBxiM9BJ/uUKh
         WgUaABgUyRrxf3pK783/18CNevsnTYP5ppQVl8IHIZTX1gt1F6WqYYsT7oGnN+QO7otM
         EzMw==
X-Gm-Message-State: ACrzQf3/fmKyodDEoayuITqQMVOrkfX4liypkJnrHSow3LrRdHGp5jT6
        Fm8s5PYWRK3TW5dg29RDlkiJv4CHpFuPbZQE3+bY+SDYP4aQ
X-Google-Smtp-Source: AMsMyM6/tLVj3W3198ggSkOt5sGKksOdW9LA8vu5C8EiRiRqaC1/KiOkpLggpY2i2ZsvBw82cx5L5jDlU9JIN0rqVF0hsA6KeHDG
MIME-Version: 1.0
X-Received: by 2002:a6b:8d0a:0:b0:6b7:6cd7:78e5 with SMTP id
 p10-20020a6b8d0a000000b006b76cd778e5mr1152808iod.47.1665019414845; Wed, 05
 Oct 2022 18:23:34 -0700 (PDT)
Date:   Wed, 05 Oct 2022 18:23:34 -0700
In-Reply-To: <2867034.e9J7NaK4W3@mypc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4204105ea538a8a@google.com>
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

want 2 args (repo, branch), got 3

> Linux 6.0
>
>
>
>
