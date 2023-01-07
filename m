Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B322660BB0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 03:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjAGCBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 21:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAGCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 21:01:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A065184BC4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 18:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41683B81F4A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E15FC433D2;
        Sat,  7 Jan 2023 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673056888;
        bh=NYmn7FDnORJ5eVfJV0YYJXE1Pr5KtPIJYCtTW19mQGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMoP36LQQ8KjnBJqIjPXqvlZfr0deSIbd2GkCW/I9RIIulEUS7Fgvr7CALp023yhJ
         UDbsVVATqgV+rByfvSas6wj43wcpXW5JKIh/BgCQc6g56cPnns+uOHE7PhFEzVg1JV
         2DwtS9opgQnih6QNx5uSreN5RWnNG1sVWjC9Sye/Zjx6Nd4SfgV/qG5X19xi1Ee73Q
         kt65aoCylby997bONllfo98B1XcxFF10xQhtR4FeWoyzMJ0POJogipUf/+3n17w14g
         31TswUafFp/qiQv0PdBXXOOhEfYXD2SUI4nDh6Yk810PWzwT+ca0U4eS+y0BKxBzdr
         3dc5ZG46sCSZQ==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Date:   Sat,  7 Jan 2023 02:01:26 +0000
Message-Id: <20230107020126.1627-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105191517.3099082-23-Liam.Howlett@oracle.com>
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


I found 'make install' mm-unstable kernel fails from initramfs stage with
'not a dynamic executable' message.  I confirmed the issue is not reproducible
before your patchset[1] but after the series[2].

I tried to bisect, but on a commit[3] middle of mm-unstable tree which this
patch is applied, I get below error while booting.  Do you have an idea?

[    2.118502] BUG: kernel NULL pointer dereference, address: 0000000000000078
[    2.121516] #PF: supervisor read access in kernel mode
[    2.121576] #PF: error_code(0x0000) - not-present page
[    2.121576] PGD 0 P4D 0
[    2.121576] Oops: 0000 [#1] PREEMPT SMP PTI
[    2.121576] CPU: 2 PID: 237 Comm: modprobe Not tainted 6.2.0-rc1+ #18
[    2.121576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-pr4
[    2.121576] RIP: 0010:mas_wr_walk (lib/maple_tree.c:1401 lib/maple_tree.c:2259 lib/maple_tree.c:3732 lib/maple_tree.c:3757)
[ 2.121576] Code: 00 48 8b 51 18 30 d2 48 89 53 08 83 f8 02 0f 87 64 01 00 00 4c 8d 42 08 0f b6 80 e68

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
[    2.121576] RSP: 0018:ffffa5190119fc28 EFLAGS: 00010246
[    2.121576] RAX: 000000000000000f RBX: ffffa5190119fc78 RCX: ffffa5190119fd60
[    2.121576] RDX: 0000000000000000 RSI: 000000000000000e RDI: 000000000000000e
[    2.121576] RBP: ffffa5190119fc38 R08: 0000000000000008 R09: 0000000000000001
[    2.121576] R10: ffff95f5c3435300 R11: ffff95f5c3434c48 R12: ffffa5190119fd60
[    2.121576] R13: ffff95f5c9a26880 R14: ffff95f5c3433690 R15: 0000000000100073
[    2.121576] FS:  0000000000000000(0000) GS:ffff9613fd480000(0000) knlGS:0000000000000000
[    2.121576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.121576] CR2: 0000000000000078 CR3: 0000000103430000 CR4: 00000000000006e0
[    2.121576] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.121576] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.121576] Call Trace:
[    2.121576]  <TASK>
[    2.121576] mas_wr_store_entry (lib/maple_tree.c:4382)
[    2.121576] mas_store_prealloc (lib/maple_tree.c:249 lib/maple_tree.c:5706)
[    2.121576] mmap_region (mm/mmap.c:2808)
[    2.121576] do_mmap (mm/mmap.c:1506)
[    2.121576] ? security_mmap_file (security/security.c:1670)
[    2.121576] vm_mmap_pgoff (mm/util.c:542)
[    2.121576] ksys_mmap_pgoff (mm/mmap.c:1552)
[    2.121576] __x64_sys_mmap (arch/x86/kernel/sys_x86_64.c:86)
[    2.121576] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
[    2.121576] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[    2.121576] RIP: 0033:0x7ff228f7a186
[ 2.121576] Code: 1f 44 00 00 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75 2b 55 48 89 fd 53 89 cb 48 85 ff 74f

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
[    2.121576] RSP: 002b:00007ffcbc695148 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[    2.121576] RAX: ffffffffffffffda RBX: 0000000000000022 RCX: 00007ff228f7a186
[    2.121576] RDX: 0000000000000003 RSI: 0000000000002000 RDI: 0000000000000000
[    2.121576] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
[    2.121576] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ff228f8a190
[    2.121576] R13: 000000000000000c R14: 00007ff228f89060 R15: 0000000000000000
[    2.121576]  </TASK>
[    2.174098] ata2: found unknown device (class 0)
[    2.121576] Modules linked in:
[    2.121576] Dumping ftrace buffer:
[    2.121576]    (ftrace buffer empty)
[    2.121576] CR2: 0000000000000078
[    2.179450] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.179774] ---[ end trace 0000000000000000 ]---
[    2.183410] RIP: 0010:mas_wr_walk (lib/maple_tree.c:1401 lib/maple_tree.c:2259 lib/maple_tree.c:3732 lib/maple_tree.c:3757)
[ 2.184545] Code: 00 48 8b 51 18 30 d2 48 89 53 08 83 f8 02 0f 87 64 01 00 00 4c 8d 42 08 0f b6 80 e68

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
[    2.185835] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.188543] RSP: 0018:ffffa5190119fc28 EFLAGS: 00010246
[    2.188546] RAX: 000000000000000f RBX: ffffa5190119fc78 RCX: ffffa5190119fd60
[    2.188547] RDX: 0000000000000000 RSI: 000000000000000e RDI: 000000000000000e
[    2.188548] RBP: ffffa5190119fc38 R08: 0000000000000008 R09: 0000000000000001
[    2.188550] R10: ffff95f5c3435300 R11: ffff95f5c3434c48 R12: ffffa5190119fd60
[    2.188551] R13: ffff95f5c9a26880 R14: ffff95f5c3433690 R15: 0000000000100073
[    2.188552] FS:  0000000000000000(0000) GS:ffff9613fd480000(0000) knlGS:0000000000000000
[    2.188554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.188556] CR2: 0000000000000078 CR3: 0000000103430000 CR4: 00000000000006e0
[    2.188559] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.206738] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=a13d6f0ec9b80674195d74ddfb6dfd94d352d2bb
[2] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=1329c351b42e20fcd195829357f0eda607f3de09
[3] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=f569105c34815dee1751a00bc9ca5154cc96dd6a


Thanks,
SJ


On Thu, 5 Jan 2023 19:15:58 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the vma iterator so that the iterator can be invalidated or updated
> to avoid each caller doing so.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4dd7e48a312f..80f12fcf158c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2446,7 +2446,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>  
> -		error = __split_vma(mm, vma, start, 0);
> +		error = vmi__split_vma(vmi, mm, vma, start, 0);
>  		if (error)
>  			goto start_split_failed;
>  
> @@ -2467,7 +2467,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (next->vm_end > end) {
>  			struct vm_area_struct *split;
>  
> -			error = __split_vma(mm, next, end, 1);
> +			error = vmi__split_vma(vmi, mm, next, end, 1);
>  			if (error)
>  				goto end_split_failed;
>  
> -- 
> 2.35.1
> 
> 
