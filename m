Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4696699E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbjAMOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjAMOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:14:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD46CFF6;
        Fri, 13 Jan 2023 06:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Dv3+FM+OaFYC0iFWAyns2j4A+xe8xD8lA/RgeeSuPs=; b=UldURO5XtCKFnSmm1nfeOdz7ZG
        mTwoTM36BAKkL8U1ITsc6pCVZl8dWWoDv8Jc2lKGMBnWYTyIr4tM7o/2R4/Gkh77bYNCIks2ny6Xl
        O/rL+g//kkFkqnlSMBlL0oAKoRypzQOf1i5K17VNPxBpseS17ZGXW0gyhVkhLAQXA5Li7aYVMKTo/
        c3BnUVj+6yhnJ9l3arDP6p8JhKxzkJ/9XVxiLFpQbiTB99pee/ITDyfC/dvWBJDLQvMEoUVRtOrCC
        ivr6Pjb9zMEfM/O23JcaqEyGlZf/Ufa3fa9qtZw+jnpAXEru2LLgYoR/klZcK/Li5PPUp6hkhxpk7
        x7iHyoJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGKo7-0069l4-9A; Fri, 13 Jan 2023 14:13:23 +0000
Date:   Fri, 13 Jan 2023 14:13:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+65231569237fd5c39d34@syzkaller.appspotmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [syzbot] linux-next boot error: general protection fault in
 _compound_head
Message-ID: <Y8FnAwWOxLrfoWTN@casper.infradead.org>
References: <000000000000807c7805f2205df1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000807c7805f2205df1@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is Kefeng's patch:

    mm: memory: convert wp_page_copy() to use folios

+++ b/mm/memory.c
@@ -3044,7 +3044,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
        struct vm_area_struct *vma = vmf->vma;
        struct mm_struct *mm = vma->vm_mm;
        struct page *old_page = vmf->page;
+       struct folio *old_folio = page_folio(old_page);
        struct page *new_page = NULL;
+       struct folio *new_folio = NULL;
        pte_t entry;
        int page_copied = 0;
        struct mmu_notifier_range range;

If old_page was NULL, calling page_folio() on it generates a NULL
pointer dereference.  Suggest dropping this patch; I don't think it was
tested before being posted.

On Thu, Jan 12, 2023 at 11:41:45PM -0800, syzbot wrote:
> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 PID: 1 Comm: init Not tainted 6.2.0-rc3-next-20230113-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:_compound_head+0x21/0x150 include/linux/page-flags.h:251
> Code: e8 34 6a 14 00 eb ee 66 90 41 54 55 53 48 89 fb e8 44 a2 c6 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 fd 00 00 00 48 8b 6b 08 31 ff 49 89 ec 41 83 e4
> RSP: 0000:ffffc90000067bb0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff81bb265c RDI: 0000000000000008
> RBP: ffff88801be3bd20 R08: 0000000000000000 R09: ffff88801c278303
> R10: ffffed100384f060 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffc90000067da8 R14: ffffc90000067d80 R15: 0000000000000000
> FS:  00007f92c0dc0800(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f92c0e4c300 CR3: 000000001bf3c000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  wp_page_copy mm/memory.c:3047 [inline]
>  do_wp_page+0x749/0x3880 mm/memory.c:3425
>  handle_pte_fault mm/memory.c:4937 [inline]
>  __handle_mm_fault+0x2183/0x3eb0 mm/memory.c:5061
>  handle_mm_fault+0x1b6/0x850 mm/memory.c:5207
>  do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1407
>  handle_page_fault arch/x86/mm/fault.c:1498 [inline]
>  exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1554
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7f92c0e2df98
> Code: 0b 8b 3d 6f d3 01 00 e9 9e ff ff ff c3 55 53 48 8d 1d 9c e3 01 00 52 48 8b 3d 74 e3 01 00 48 8d ab 00 01 00 00 e8 08 f1 ff ff <48> c7 05 5d e3 01 00 00 00 00 00 48 8b 3b 48 83 c3 08 e8 f1 f0 ff
> RSP: 002b:00007ffd667702e0 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 00007f92c0e4c320 RCX: 000055ba317c6480
> RDX: 0000000000000007 RSI: 000055ba317c6480 RDI: 0000000000000000
> RBP: 00007f92c0e4c420 R08: 0000000000000000 R09: 000055ba317c64d0
> R10: 0000000000000011 R11: 000000000000000c R12: 0000000000000000
> R13: 00007ffd6677036c R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:_compound_head+0x21/0x150 include/linux/page-flags.h:251
> Code: e8 34 6a 14 00 eb ee 66 90 41 54 55 53 48 89 fb e8 44 a2 c6 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 fd 00 00 00 48 8b 6b 08 31 ff 49 89 ec 41 83 e4
> RSP: 0000:ffffc90000067bb0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff81bb265c RDI: 0000000000000008
> RBP: ffff88801be3bd20 R08: 0000000000000000 R09: ffff88801c278303
> R10: ffffed100384f060 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffc90000067da8 R14: ffffc90000067d80 R15: 0000000000000000
> FS:  00007f92c0dc0800(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f92c0e4c300 CR3: 000000001bf3c000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	e8 34 6a 14 00       	callq  0x146a39
>    5:	eb ee                	jmp    0xfffffff5
>    7:	66 90                	xchg   %ax,%ax
>    9:	41 54                	push   %r12
>    b:	55                   	push   %rbp
>    c:	53                   	push   %rbx
>    d:	48 89 fb             	mov    %rdi,%rbx
>   10:	e8 44 a2 c6 ff       	callq  0xffc6a259
>   15:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:	0f 85 fd 00 00 00    	jne    0x131
>   34:	48 8b 6b 08          	mov    0x8(%rbx),%rbp
>   38:	31 ff                	xor    %edi,%edi
>   3a:	49 89 ec             	mov    %rbp,%r12
>   3d:	41                   	rex.B
>   3e:	83                   	.byte 0x83
>   3f:	e4                   	.byte 0xe4
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
