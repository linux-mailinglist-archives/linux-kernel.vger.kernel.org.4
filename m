Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE165F5E67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJFB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJFB2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:28:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872E5A81F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:28:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a26so1382028ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+jrS/QGH/pUVD9k6D6POGlMEiPy+3PwsTWkAJC84zJc=;
        b=YnmENS4blqGG1H+IVlsRScbhASYZ8vpVFvHhzhSuZkfd4YHTmCSxcV0O+Seik0uEzY
         GFxsnVJ/aLD6O5dA46HLCraVIJlq+Taq/SJOb0D+9fqgstEqKQ0ZcZYrf7lZABroHc6j
         tXUfBrfOwHMnxO4g4h/9SZv7WoucjxSjXhekU6q/lf0l0VISdj+KQJH7RwXlurxhMmiC
         jF+6hL4mI7URFHZjBRZjq97vFs3ovzqbg5oE0OiFG8AHpOvRhDKzcS8unDXptdYLWe07
         4MZGLy1uWvOQSX1tb1hINve1CKkdUXProaEw1WCwohpn+240rN38lEYpODiVxBohleVQ
         Js6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+jrS/QGH/pUVD9k6D6POGlMEiPy+3PwsTWkAJC84zJc=;
        b=e/4c9/Qm7Om2mMZBGbj7EcxdYxzsW3SLZHakm3fFCXhPICoXAQTPSCKYZVmAtZkxN9
         u6riWba1uqC51l86rsJMk3ArEiTKPF2jfXgh6kxg/T0Yx8v5IW7HhD75wMMbPA3ggUkd
         hf5iW5GEMwy79SVf/c6/ngBejuP6C9B26bDQv84YVS5xrKlOLlBpSh50cHlHwx/31DtN
         j7qQ1ohRjGtBR+m7SjtqKUIiY1+hjTVp+ODDEK8B33wESTQq5jiculOSx0XAbjMYvU7M
         aQb5tX1kD3/LgoZ8EFAo+1AdmSQEdI/HArUgDKDALdV2+qEtIhIHX/l3UDnUyXxtWh6R
         AiXw==
X-Gm-Message-State: ACrzQf0q0/p6dSzScj7TNcn+C/gDonG/Pvnph++3wtv/L233FQ9xojy3
        2lR3vUJtO7l0zmbHZiPwxhpWAHlsy7yDyA==
X-Google-Smtp-Source: AMsMyM4rd6yzHhcY2DSt1VxrZbYMurpraVq0PQYgpYGGyPpsiY4FCfhY9qGRuH9z8n8JQqvPXkX0Ag==
X-Received: by 2002:a17:907:9727:b0:78a:e09c:f2f9 with SMTP id jg39-20020a170907972700b0078ae09cf2f9mr1890447ejc.455.1665019710164;
        Wed, 05 Oct 2022 18:28:30 -0700 (PDT)
Received: from mypc.localnet (host-79-17-38-224.retail.telecomitalia.it. [79.17.38.224])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0078d01a38cc8sm3926557ejb.35.2022.10.05.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 18:28:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] memory leak in __get_metapage
Date:   Thu, 06 Oct 2022 03:28:29 +0200
Message-ID: <2217443.iZASKD2KPV@mypc>
In-Reply-To: <0000000000008a5a2e05ea318aa9@google.com>
References: <0000000000008a5a2e05ea318aa9@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1925904.PYKUYFuaPT"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1925904.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

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
#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6.0

--nextPart1925904.PYKUYFuaPT
Content-Disposition: attachment; filename="jfs.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="jfs.diff"

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 2e8461ce74de..b3ba1cefc230 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -678,6 +678,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 
 unlock:
 	unlock_page(page);
+	put_page(page);
 	return NULL;
 }
 

--nextPart1925904.PYKUYFuaPT--



