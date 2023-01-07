Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D33660C00
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 03:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAGCkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 21:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGCkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 21:40:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8407577D34
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 18:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D4461FCD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF23CC433EF;
        Sat,  7 Jan 2023 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673059203;
        bh=B7qoLDlzwvRSwMyNM2RIruWx2dHuHoj1N+6UHOamxVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrRsbvnDpDh007HJPMIYbAWe6x8f24rwPW6WFIRuQwnc5iDm1mC5VNKC+oclYYPKK
         t8B0nj+6rniK1NTEiqOuJTpUy0fjVSKnO42hYohRKTgE6cxy+YoUdJ8OB8NWT7pK9V
         j1hvi6Eh5W1zwgcDOvgnKSirUvwjpCpHrnH4O+jPt/eBZQb/7gUMhqxW/vNFac0tyN
         sS0lD0vW0JsZeYltT+lO/zGXvZhbNonwZX3dp4iBL9zP/UrOLIetgszJcD8vGBsnJI
         yjJdDvAPrkdzgii9jsZH0opGOy3moxr4m+clrb5e3irbz31CNG2zGBmMVlj6KTPvoT
         y9RAH9CBYf1fg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Date:   Sat,  7 Jan 2023 02:39:54 +0000
Message-Id: <20230107023954.1841-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230107020126.1627-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liam,

On Sat, 7 Jan 2023 02:01:26 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Liam,
> 
> 
> I found 'make install' mm-unstable kernel fails from initramfs stage with
> 'not a dynamic executable' message.  I confirmed the issue is not reproducible
> before your patchset[1] but after the series[2].
> 
> I tried to bisect, but on a commit[3] middle of mm-unstable tree which this
> patch is applied, I get below error while booting.  Do you have an idea?

I further bisected for the boot failure.  The first bad commit was a8e0f2e12936
("mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma
iterator")[1].  The stacktrace on the commit is as below.


[    2.125001] BUG: kernel NULL pointer dereference, address: 0000000000000078
[    2.128035] #PF: supervisor read access in kernel mode
[    2.128035] #PF: error_code(0x0000) - not-present page
[    2.128035] PGD 0 P4D 0
[    2.128035] Oops: 0000 [#1] PREEMPT SMP PTI
[    2.128035] CPU: 27 PID: 238 Comm: modprobe Not tainted 6.2.0-rc1+ #24
[    2.128035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-pr4
[    2.128035] RIP: 0010:mas_wr_walk (lib/maple_tree.c:1401 lib/maple_tree.c:2259 lib/maple_tree.c:3732 lib/maple_tree.c:3757)
[ 2.128035] Code: 00 48 8b 51 18 30 d2 48 89 53 08 83 f8 02 0f 87 64 01 00 00 4c 8d 42 08 0f b6 80 e68

Code starting with the faulting instruction
===========================================
   0:   00 48 8b                add    %cl,-0x75(%rax)
   3:   51                      push   %rcx
   4:   18 30                   sbb    %dh,(%rax)
   6:   d2 48 89                rorb   %cl,-0x77(%rax)
   9:   53                      push   %rbx
   a:   08 83 f8 02 0f 87       or     %al,-0x78f0fd08(%rbx)
  10:   64 01 00                add    %eax,%fs:(%rax)
  13:   00 4c 8d 42             add    %cl,0x42(%rbp,%rcx,4)
  17:   08 0f                   or     %cl,(%rdi)
  19:   b6 80                   mov    $0x80,%dh
  1b:   68                      .byte 0x68
[    2.128035] RSP: 0018:ffffba49c11b3c28 EFLAGS: 00010246
[    2.128035] RAX: 000000000000000f RBX: ffffba49c11b3c78 RCX: ffffba49c11b3d60
[    2.128035] RDX: 0000000000000000 RSI: 000000000000000e RDI: 000000000000000e
[    2.128035] RBP: ffffba49c11b3c38 R08: 0000000000000008 R09: 0000000000000001
[    2.128035] R10: ffff8fe4ca713500 R11: ffff8fe4ca713f48 R12: ffffba49c11b3d60
[    2.128035] R13: ffff8fe4ca6f2140 R14: ffff8fe4ca711988 R15: 0000000000100073
[    2.128035] FS:  0000000000000000(0000) GS:ffff9002fdac0000(0000) knlGS:0000000000000000
[    2.128035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.128035] CR2: 0000000000000078 CR3: 000000010a6d6000 CR4: 00000000000006e0
[    2.128035] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.128035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.128035] Call Trace:
[    2.128035]  <TASK>
[    2.128035] mas_wr_store_entry (lib/maple_tree.c:4382)
[    2.128035] mas_store_prealloc (lib/maple_tree.c:249 lib/maple_tree.c:5706)
[    2.128035] mmap_region (mm/mmap.c:2765)
[    2.128035] do_mmap (mm/mmap.c:1488)
[    2.128035] ? security_mmap_file (security/security.c:1670)
[    2.128035] vm_mmap_pgoff (mm/util.c:542)
[    2.128035] ksys_mmap_pgoff (mm/mmap.c:1534)
[    2.128035] __x64_sys_mmap (arch/x86/kernel/sys_x86_64.c:86)
[    2.128035] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
[    2.128035] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[    2.128035] RIP: 0033:0x7fea50d24186
[ 2.128035] Code: 1f 44 00 00 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75 2b 55 48 89 fd 53 89 cb 48 85 ff 74f

Code starting with the faulting instruction
===========================================
   0:   1f                      (bad)
   1:   44 00 00                add    %r8b,(%rax)
   4:   f3 0f 1e fa             endbr64
   8:   41 f7 c1 ff 0f 00 00    test   $0xfff,%r9d
   f:   75 2b                   jne    0x3c
  11:   55                      push   %rbp
  12:   48 89 fd                mov    %rdi,%rbp
  15:   53                      push   %rbx
  16:   89 cb                   mov    %ecx,%ebx
  18:   48 85 ff                test   %rdi,%rdi
  1b:   4f                      rex.WRXB
[    2.128035] RSP: 002b:00007ffee1f7b1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[    2.128035] RAX: ffffffffffffffda RBX: 0000000000000022 RCX: 00007fea50d24186
[    2.176096] ata2: found unknown device (class 0)
[    2.128035] RDX: 0000000000000003 RSI: 0000000000002000 RDI: 0000000000000000
[    2.128035] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
[    2.181946] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.128035] R10: 0000000000000022 R11: 0000000000000246 R12: 00007fea50d34190
[    2.128035] R13: 000000000000000c R14: 00007fea50d33060 R15: 0000000000000000
[    2.188623] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.128035]  </TASK>
[    2.128035] Modules linked in:
[    2.128035] Dumping ftrace buffer:
[    2.128035]    (ftrace buffer empty)
[    2.128035] CR2: 0000000000000078
[    2.196913] ---[ end trace 0000000000000000 ]---
[    2.197932] RIP: 0010:mas_wr_walk (lib/maple_tree.c:1401 lib/maple_tree.c:2259 lib/maple_tree.c:3732 lib/maple_tree.c:3757)
[ 2.198869] Code: 00 48 8b 51 18 30 d2 48 89 53 08 83 f8 02 0f 87 64 01 00 00 4c 8d 42 08 0f b6 80 e68

Code starting with the faulting instruction
===========================================
   0:   00 48 8b                add    %cl,-0x75(%rax)
   3:   51                      push   %rcx
   4:   18 30                   sbb    %dh,(%rax)
   6:   d2 48 89                rorb   %cl,-0x77(%rax)
   9:   53                      push   %rbx
   a:   08 83 f8 02 0f 87       or     %al,-0x78f0fd08(%rbx)
  10:   64 01 00                add    %eax,%fs:(%rax)
  13:   00 4c 8d 42             add    %cl,0x42(%rbp,%rcx,4)
  17:   08 0f                   or     %cl,(%rdi)
  19:   b6 80                   mov    $0x80,%dh
  1b:   68                      .byte 0x68
[    2.202922] RSP: 0018:ffffba49c11b3c28 EFLAGS: 00010246
[    2.204060] RAX: 000000000000000f RBX: ffffba49c11b3c78 RCX: ffffba49c11b3d60
[    2.205608] RDX: 0000000000000000 RSI: 000000000000000e RDI: 000000000000000e
[    2.207143] RBP: ffffba49c11b3c38 R08: 0000000000000008 R09: 0000000000000001
[    2.208703] R10: ffff8fe4ca713500 R11: ffff8fe4ca713f48 R12: ffffba49c11b3d60
[    2.210239] R13: ffff8fe4ca6f2140 R14: ffff8fe4ca711988 R15: 0000000000100073
[    2.211781] FS:  0000000000000000(0000) GS:ffff9002fdac0000(0000) knlGS:0000000000000000
[    2.213520] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.214756] CR2: 0000000000000078 CR3: 000000010a6d6000 CR4: 00000000000006e0
[    2.216316] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=a8e0f2e12936b08e4abde7c867503177def79d12


Thanks,
SJ

> 
> [    2.118502] BUG: kernel NULL pointer dereference, address: 0000000000000078
> [    2.121516] #PF: supervisor read access in kernel mode
> [    2.121576] #PF: error_code(0x0000) - not-present page
> [    2.121576] PGD 0 P4D 0
> [    2.121576] Oops: 0000 [#1] PREEMPT SMP PTI
> [    2.121576] CPU: 2 PID: 237 Comm: modprobe Not tainted 6.2.0-rc1+ #18
> [    2.121576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-pr4
> [    2.121576] RIP: 0010:mas_wr_walk (lib/maple_tree.c:1401 lib/maple_tree.c:2259 lib/maple_tree.c:3732 lib/maple_tree.c:3757)
> [ 2.121576] Code: 00 48 8b 51 18 30 d2 48 89 53 08 83 f8 02 0f 87 64 01 00 00 4c 8d 42 08 0f b6 80 e68
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   00 48 8b                add    %cl,-0x75(%rax)
>    3:   51                      push   %rcx
>    4:   18 30                   sbb    %dh,(%rax)
>    6:   d2 48 89                rorb   %cl,-0x77(%rax)
>    9:   53                      push   %rbx
>    a:   08 83 f8 02 0f 87       or     %al,-0x78f0fd08(%rbx)
>   10:   64 01 00                add    %eax,%fs:(%rax)
>   13:   00 4c 8d 42             add    %cl,0x42(%rbp,%rcx,4)
>   17:   08 0f                   or     %cl,(%rdi)
>   19:   b6 80                   mov    $0x80,%dh
>   1b:   68                      .byte 0x68
> [    2.121576] RSP: 0018:ffffa5190119fc28 EFLAGS: 00010246
> [    2.121576] RAX: 000000000000000f RBX: ffffa5190119fc78 RCX: ffffa5190119fd60
> [    2.121576] RDX: 0000000000000000 RSI: 000000000000000e RDI: 000000000000000e
> [    2.121576] RBP: ffffa5190119fc38 R08: 0000000000000008 R09: 0000000000000001
> [    2.121576] R10: ffff95f5c3435300 R11: ffff95f5c3434c48 R12: ffffa5190119fd60
> [    2.121576] R13: ffff95f5c9a26880 R14: ffff95f5c3433690 R15: 0000000000100073
> [    2.121576] FS:  0000000000000000(0000) GS:ffff9613fd480000(0000) knlGS:0000000000000000
> [    2.121576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.121576] CR2: 0000000000000078 CR3: 0000000103430000 CR4: 00000000000006e0
> [    2.121576] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.121576] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.121576] Call Trace:
> [    2.121576]  <TASK>
> [    2.121576] mas_wr_store_entry (lib/maple_tree.c:4382)
> [    2.121576] mas_store_prealloc (lib/maple_tree.c:249 lib/maple_tree.c:5706)
> [    2.121576] mmap_region (mm/mmap.c:2808)
> [    2.121576] do_mmap (mm/mmap.c:1506)
> [    2.121576] ? security_mmap_file (security/security.c:1670)
> [    2.121576] vm_mmap_pgoff (mm/util.c:542)
> [    2.121576] ksys_mmap_pgoff (mm/mmap.c:1552)
> [    2.121576] __x64_sys_mmap (arch/x86/kernel/sys_x86_64.c:86)
> [    2.121576] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [    2.121576] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> [    2.121576] RIP: 0033:0x7ff228f7a186
> [ 2.121576] Code: 1f 44 00 00 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75 2b 55 48 89 fd 53 89 cb 48 85 ff 74f
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   1f                      (bad)
>    1:   44 00 00                add    %r8b,(%rax)
>    4:   f3 0f 1e fa             endbr64
>    8:   41 f7 c1 ff 0f 00 00    test   $0xfff,%r9d
>    f:   75 2b                   jne    0x3c
>   11:   55                      push   %rbp
>   12:   48 89 fd                mov    %rdi,%rbp
>   15:   53                      push   %rbx
>   16:   89 cb                   mov    %ecx,%ebx
>   18:   48 85 ff                test   %rdi,%rdi
>   1b:   4f                      rex.WRXB
> [    2.121576] RSP: 002b:00007ffcbc695148 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> [    2.121576] RAX: ffffffffffffffda RBX: 0000000000000022 RCX: 00007ff228f7a186
> [    2.121576] RDX: 0000000000000003 RSI: 0000000000002000 RDI: 0000000000000000
> [    2.121576] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> [    2.121576] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ff228f8a190
> [    2.121576] R13: 000000000000000c R14: 00007ff228f89060 R15: 0000000000000000
> [    2.121576]  </TASK>
> [    2.174098] ata2: found unknown device (class 0)
> [    2.121576] Modules linked in:
> [    2.121576] Dumping ftrace buffer:
> [    2.121576]    (ftrace buffer empty)
> [    2.121576] CR2: 0000000000000078
> [    2.179450] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    2.179774] ---[ end trace 0000000000000000 ]---
> [    2.183410] RIP: 0010:mas_wr_walk (lib/maple_tree.c:1401 lib/maple_tree.c:2259 lib/maple_tree.c:3732 lib/maple_tree.c:3757)
> [ 2.184545] Code: 00 48 8b 51 18 30 d2 48 89 53 08 83 f8 02 0f 87 64 01 00 00 4c 8d 42 08 0f b6 80 e68
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   00 48 8b                add    %cl,-0x75(%rax)
>    3:   51                      push   %rcx
>    4:   18 30                   sbb    %dh,(%rax)
>    6:   d2 48 89                rorb   %cl,-0x77(%rax)
>    9:   53                      push   %rbx
>    a:   08 83 f8 02 0f 87       or     %al,-0x78f0fd08(%rbx)
>   10:   64 01 00                add    %eax,%fs:(%rax)
>   13:   00 4c 8d 42             add    %cl,0x42(%rbp,%rcx,4)
>   17:   08 0f                   or     %cl,(%rdi)
>   19:   b6 80                   mov    $0x80,%dh
>   1b:   68                      .byte 0x68
> [    2.185835] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
> [    2.188543] RSP: 0018:ffffa5190119fc28 EFLAGS: 00010246
> [    2.188546] RAX: 000000000000000f RBX: ffffa5190119fc78 RCX: ffffa5190119fd60
> [    2.188547] RDX: 0000000000000000 RSI: 000000000000000e RDI: 000000000000000e
> [    2.188548] RBP: ffffa5190119fc38 R08: 0000000000000008 R09: 0000000000000001
> [    2.188550] R10: ffff95f5c3435300 R11: ffff95f5c3434c48 R12: ffffa5190119fd60
> [    2.188551] R13: ffff95f5c9a26880 R14: ffff95f5c3433690 R15: 0000000000100073
> [    2.188552] FS:  0000000000000000(0000) GS:ffff9613fd480000(0000) knlGS:0000000000000000
> [    2.188554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.188556] CR2: 0000000000000078 CR3: 0000000103430000 CR4: 00000000000006e0
> [    2.188559] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.206738] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=a13d6f0ec9b80674195d74ddfb6dfd94d352d2bb
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=1329c351b42e20fcd195829357f0eda607f3de09
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=f569105c34815dee1751a00bc9ca5154cc96dd6a
> 
> 
> Thanks,
> SJ
> 
