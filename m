Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE15F71BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiJFX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiJFX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:26:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D257EB7C7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:26:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so7874697ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7D8QgEofMj2OjunkWtdlnIwE468nRY6vum59Ytv9TME=;
        b=iOM9RdZMPhkEE/aOJbZvxM9cJarrCNE6IgIBf1wTC98XmC9IQG+gkgukHMdL90vWYt
         8qWU8JUUTx3do3MzpsVG962AAWziCQ4x1nxi01QIJnkFe7AnqnYgoG22N4qMOjGeZwan
         eSmC/H7byn6wfm6JYsCnc7wXhHshKiU4eoElLgVQ+5xfAU/qm7dyDVEkupcOi6fG3EeD
         +quryQGMDi+Q3Dla2oeHOAzVFk9uLUBzgAGKjrFabTdaP7eWoy9tO+u6i8COrCMm6gO7
         k0dG9UFd+omGwiIhpyaq/saVf4XeDlaInR2nlKNLOChjTKCtbd2m7C6ADSvip7aXRM/Y
         CSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7D8QgEofMj2OjunkWtdlnIwE468nRY6vum59Ytv9TME=;
        b=UIXThYqdvurWngnho0phnqmGOtg9B7xVDhM/i6mGhFR0t4gctD4tbEfTTu8soJsN3F
         Z23BdKu5POycb94Stnhqs+dSDswAY89qbu7tLEe/SY+YIQSZklukWL6uDuZ3FLyDaHOr
         owL7uyCDrXl44T5WjDuI+SIt33Y50sLOMfkVFhjwdI1K3igOfBn045X2iFJC2++17cEy
         55z6icX9CuWGU7zj2Qmtvli0XoEhUY5qTBjMNqd6UOU4yWtxmWnWC3g/gWYJyAqz98Gq
         CzkiDaANK1YKpeQQtFtPWuLhIbfANI0S0cYeZle1Tjghn/QbjwsjR8HAlb6KoD+t6NdM
         AE6w==
X-Gm-Message-State: ACrzQf2BYuR0CvjfCK4LkDY0JOkQqm5mHKTy9XNWYE+E5D9/6IEBmUSf
        CUN8Ym3CB5gpoJdwQ/MevR8=
X-Google-Smtp-Source: AMsMyM6WO0uZEQ04lSneiEz2Dils+6r7lWyd5w03swLpMxe72l4vHabEpasRZJkzmHjlqYd20bbj5A==
X-Received: by 2002:a17:906:eeca:b0:730:6880:c397 with SMTP id wu10-20020a170906eeca00b007306880c397mr1785207ejb.593.1665098800620;
        Thu, 06 Oct 2022 16:26:40 -0700 (PDT)
Received: from mypc.localnet (host-95-248-187-1.retail.telecomitalia.it. [95.248.187.1])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b0078d38cda2b1sm291097ejo.202.2022.10.06.16.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:26:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] memory leak in __get_metapage
Date:   Fri, 07 Oct 2022 01:26:41 +0200
Message-ID: <2387955.jE0xQCEvom@mypc>
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
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
master




