Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301575F5E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJFBVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJFBVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:21:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01A237EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:20:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e18so796816edj.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 18:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ozmaCo4IglvucM3+UT9O+BvBaBRui0dOpeb2s0RQrI0=;
        b=lHHRodbbni68Kr3SdH92rJSiWCaQ3aQTEKs1X+NUj7EeEMcs2S7H02JppW3/hxvFFH
         gbSS5Hy0K8RhhSS0EjJ5jk27faOMkxdx2f/qsTUgLsk1Lr3592nHTLvngb9tts0GWSs5
         aK+JFuqC9fb8k5ntVUbgdKxVknAd0FdvkOsZEDIGGH1Rnwp6cwSU2XCmolN6Qx1ekito
         k0hqXqfRI1BxyAqaOydRx/A2PsRA+d3lAj2RoMjVh6wwC9e6DtZ/1fYdCArT4g/f36WN
         2NJfAP+vFDjfkDEVUszN9ntPQy+Vh867WmXJDrEoCPKYTx/V/5GMxUxIlPz47NDef69D
         Vy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ozmaCo4IglvucM3+UT9O+BvBaBRui0dOpeb2s0RQrI0=;
        b=2CUwaTxjQxsBbfxWs4NREYtEwLG1/JODzix9bRNTOUwyro7jvh3zyQTXOxXqMxOUK7
         G2zoCpH6FlqBbCvmfxfBjm3STFrVGTpOm4j0KM/6k5rCAQCyER+RRSkyiuFABOUcN21I
         bnhw3VD7X0VC/SHCCNcdwBs9of0aIVw2hQIGQMtuE887Z06enxkhBI8vf4c2qgg/WMDH
         KHz7GGD4pIgYn6DWRUsvepWQBWc1L7CWrcws4vNU51h625Wcahde6eCumRF288VALS5I
         6vNbDJPBHZZfZpOCMzKOLhFz5A07IBODcnTyv6GzGOmIeK9H6Btkf0oIqfo9GKvJ1QRL
         FNvA==
X-Gm-Message-State: ACrzQf3VqX0URvvcLSmyie7zG9vGZYDt9Iy/qJzlP8XszGb7vYbkRtyv
        C/1HCj3EuI8CHDEyDH8+jiH1ATzBK6CoUw==
X-Google-Smtp-Source: AMsMyM4vojMbvEf5uzvzIudlN+ia1m5ksUWPz8WyyBQVk5CZSgufC6RUK2g8YGiUh1xJsa62SefSMQ==
X-Received: by 2002:a05:6402:169a:b0:458:fe61:d3b4 with SMTP id a26-20020a056402169a00b00458fe61d3b4mr2239003edv.140.1665019251314;
        Wed, 05 Oct 2022 18:20:51 -0700 (PDT)
Received: from mypc.localnet (host-79-17-38-224.retail.telecomitalia.it. [79.17.38.224])
        by smtp.gmail.com with ESMTPSA id c23-20020a1709060fd700b0078afe360800sm6270940ejk.199.2022.10.05.18.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 18:20:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] memory leak in __get_metapage
Date:   Thu, 06 Oct 2022 03:20:50 +0200
Message-ID: <2136501.irdbgypaU6@mypc>
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
4fe89d07dcc2 Linux 6.0

> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
"syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/
syzkaller-bugs/0000000000008a5a2e05ea318aa9%40google.com.
> 




