Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F185F6E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiJFTnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiJFTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:43:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EEAE3186
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:43:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y100so4293074ede.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Z52TEyBLmpDPfqpEt0pP2srXNmLwOFGJDCl8oQzyuzI=;
        b=HArJHQ44HzWDUvVYfXQUih9OOsAtiP8L2nsfwLdwgMNKebWpvoondUYDS9kYIAevxC
         TQ22sAxBeCunuQ5ZqeFhRSpVBsGqN/R+lPSfmgEnTzke9+SkkJhe0KDKZpV2Dnok0Yjy
         ptSDlPuXqgCw89JJIz2rTGhxbQ6EpBKHvY/+MWWtpKhsHXBq4Hdl97YxTahtSvsaC3zp
         lTfTTbcIAjGbTlxv0nfEEoL8WLNbuDtkVOqJKsj/3Zs3ySTQy244MC7b5ZWnkB62vEQB
         8tL/E2IJ0FmfmSauSG2PLK8PXoSDus5QfkI0D2NHxVJHL8uIkzD+L5WGmAuO5p1EmQhr
         iDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z52TEyBLmpDPfqpEt0pP2srXNmLwOFGJDCl8oQzyuzI=;
        b=CgFmei3LcEuOy4vn9gE0HQaPKAMLw1Xxd7DrKI7a17TvUJp5bfv8IGF4Z9f/kyF6sF
         dlNZ72X9CzzOYVaGkgUmaWJskMPQ2KwrWpFtfhSKv1BXHwhlOsZG7XykZ7Qfqg7VcCLQ
         cP0vNVrem9G8dhZSq/iJMqU7gFd+wpvYRrupORgQ5Xq/EweWq3kTKYFu1JRPsuOqhZ6u
         RgRd/a6Pwf5IZjtthpn5LzuJPpXYgAo2699ho9SS6V16I5VtgCLAqnrCPlbxrDnSbUI9
         N9Uhj6NyaJKjLThiky67RtG1lDjKgCxiRjBpowzH698hk5kJ8p4a1RN0u9Oxr1hf/Eej
         IlSA==
X-Gm-Message-State: ACrzQf2tQMXASMjV6gQ8H5odTmMM9PMIIeQPeVD3hQa43d751OvMlj3E
        c79/9rt8podxJqrRpLZUX00=
X-Google-Smtp-Source: AMsMyM6E0HAyBdBCBSH7Tw/ysXNgwiJBAMslMuH/EkIwC6jica9o+AqtxsyfhdP926f2HfkzWylYug==
X-Received: by 2002:a05:6402:3718:b0:453:a46c:386c with SMTP id ek24-20020a056402371800b00453a46c386cmr1372530edb.97.1665085386320;
        Thu, 06 Oct 2022 12:43:06 -0700 (PDT)
Received: from mypc.localnet (host-79-17-38-224.retail.telecomitalia.it. [79.17.38.224])
        by smtp.gmail.com with ESMTPSA id a1-20020a50c301000000b004580b26e32esm39538edb.81.2022.10.06.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:43:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>,
        Ira <ira.weiny@intel.com>
Subject: Re: [syzbot] memory leak in __get_metapage
Date:   Thu, 06 Oct 2022 21:43:06 +0200
Message-ID: <12068295.O9o76ZdvQC@mypc>
In-Reply-To: <0000000000008a5a2e05ea318aa9@google.com>
References: <0000000000008a5a2e05ea318aa9@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 4, 2022 10:49:42 AM CEST syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4fe89d07dcc2 Linux 6.0
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169a7924880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=21254cf9c7c084e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils 
for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bdd7ec880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/651a252f7035/
disk-4fe89d07.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/776feb8e0e5b/
vmlinux-4fe89d07.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888114339e80 (size 128):
>   comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
>   hex dump (first 32 bytes):
>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> BUG: memory leak
> unreferenced object 0xffff888114339e00 (size 128):
>   comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
>   hex dump (first 32 bytes):
>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> BUG: memory leak
> unreferenced object 0xffff888114339d80 (size 128):
>   comm "syz-executor.0", pid 3673, jiffies 4295017005 (age 12.610s)
>   hex dump (first 32 bytes):
>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> BUG: memory leak
> unreferenced object 0xffff8881142f0300 (size 128):
>   comm "syz-executor.0", pid 3676, jiffies 4295017533 (age 7.330s)
>   hex dump (first 32 bytes):
>     00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814927b3>] mempool_alloc+0x73/0x230 mm/mempool.c:392
>     [<ffffffff81c5aefa>] alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
>     [<ffffffff81c5aefa>] __get_metapage+0x38a/0x9b0 fs/jfs/jfs_metapage.c:651
>     [<ffffffff81c43862>] diNewExt+0x3f2/0x9d0 fs/jfs/jfs_imap.c:2265
>     [<ffffffff81c45254>] diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
>     [<ffffffff81c45254>] diAllocAG+0x9a4/0xd50 fs/jfs/jfs_imap.c:1662
>     [<ffffffff81c4707f>] diAlloc+0x31f/0x900 fs/jfs/jfs_imap.c:1583
>     [<ffffffff81c57d9a>] ialloc+0x6a/0x3a0 fs/jfs/jfs_inode.c:56
>     [<ffffffff81c3a4c7>] jfs_mkdir+0xf7/0x480 fs/jfs/namei.c:225
>     [<ffffffff815fc703>] vfs_mkdir+0x223/0x340 fs/namei.c:4013
>     [<ffffffff816056e5>] do_mkdirat+0x1a5/0x1e0 fs/namei.c:4038
>     [<ffffffff81605859>] __do_sys_mkdir fs/namei.c:4058 [inline]
>     [<ffffffff81605859>] __se_sys_mkdir fs/namei.c:4056 [inline]
>     [<ffffffff81605859>] __x64_sys_mkdir+0x69/0x90 fs/namei.c:4056
>     [<ffffffff845eab95>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845eab95>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 

I'm still providing the "syz test" command with wrong syntax.
Let's try what I found in older tests of mine...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
master



