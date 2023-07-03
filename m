Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573677465A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGCWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGCWGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7B187
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D926103C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1268EC433C8;
        Mon,  3 Jul 2023 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688421961;
        bh=mtkUBuCCSU5DaXd05Snv/FTvcvEwzH/oTyDXEsh8TgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpzDZxP2z7pNreZ6uJUSuYm1C5ID6By88inTDhUoPzotWkDQLSXinPyUicCXUmEf3
         fYyEorKTYkeiJhulHHpmyk+ooTtb43A6psj6jXbeHLNGbeut+LFL2ZvC8m0J/clTyz
         TaOWbERkrYzKV+QZ6n8BQgOvieoE3+hLlO9GMC4lioEQhYkuSbZ9yhXNrqkHYT1sEM
         eAq0uq4jQv/DaYf8z7LxPNpJy8C1CjoCxSBkfhzYxCHL4YNhE+mBac3IJj2dzxOIrc
         0l1HuIW0ehSDge6KVjbjbWj2XiOCNHX5P+xo2Ll38zPmKl7y2Pfh/fBxHIAEzXEEI1
         TJM/WygxaLKzw==
From:   SeongJae Park <sj@kernel.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH 3/4] mm/memory: convert do_shared_fault() to folios
Date:   Mon,  3 Jul 2023 22:05:59 +0000
Message-Id: <20230703220559.1360-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703055850.227169-3-sidhartha.kumar@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidharta,

On Sun, 2 Jul 2023 22:58:49 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Saves three implicit calls to compound_head().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/memory.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 93480e846ace6..33bf13431974c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4594,6 +4594,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret, tmp;
> +	struct folio *folio = page_folio(vmf->page);
>  
>  	ret = __do_fault(vmf);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
> @@ -4604,11 +4605,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  	 * about to become writable
>  	 */
>  	if (vma->vm_ops->page_mkwrite) {
> -		unlock_page(vmf->page);
> +		folio_unlock(folio);
>  		tmp = do_page_mkwrite(vmf);
>  		if (unlikely(!tmp ||
>  				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> -			put_page(vmf->page);
> +			folio_put(folio);
>  			return tmp;
>  		}
>  	}
> @@ -4616,8 +4617,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  	ret |= finish_fault(vmf);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
>  					VM_FAULT_RETRY))) {
> -		unlock_page(vmf->page);
> -		put_page(vmf->page);
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		return ret;
>  	}

I found the latest mm-unstable tree fails booting with stacktraces like below,
and bisecting points this patch (commit a43f078c7a3b of mm-unstable).  Do you
have any idea?

[    7.388551] BUG: kernel NULL pointer dereference, address: 0000000000000008
[    7.389149] systemd[1]: Starting Load Kernel Module pstore_zone...
[    7.390101] #PF: supervisor read access in kernel mode
[    7.392370] #PF: error_code(0x0000) - not-present page
[    7.392372] PGD 0 P4D 0
[    7.392376] Oops: 0000 [#1] PREEMPT SMP PTI
[    7.392379] CPU: 9 PID: 594 Comm: systemd-journal Not tainted 6.4.0+ #8
[         S7t.a3r9t2i3n82] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-4
[    7.392384] RIP: 0010:_compound_head (include/linux/page-flags.h:245)
[ 7.400935] Code: e8 35 b5 cd ff 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90f

Code starting with the faulting instruction
===========================================
   0:   e8 35 b5 cd ff          callq  0xffffffffffcdb53a
   5:   5d                      pop    %rbp
   6:   c3                      retq
   7:   cc                      int3
   8:   cc                      int3
   9:   cc                      int3
   a:   cc                      int3
   b:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
  12:   00 00 00 00
  16:   0f 1f 40 00             nopl   0x0(%rax)
  1a:   90                      nop
  1b:   0f                      .byte 0xf
[    7.405283] RSP: 0000:ffffb86140cd3d58 EFLAGS: 00010202
[    7.406551] RAX: ffff96d3c19c4d38 RBX: ffffffffa103f080 RCX: 00000001019c4067
[    7.408233] RDX: 0000000000000000 RSI: ffff96d2c0000d38 RDI: 0000000000000000
[    7.409893] RBP: ffffb86140cd3d90 R08: ffff96d3c19c4d38 R09: 0000000000000067
[    7.411457] R10: 0000000000000000 R11: 00007f2ae19d5fff R12: ffffb86140cd3dd0
[    7.412792] R13: 0000000000000001 R14: ffff96d3cb7aa450 R15: 0000000000000860
[    7.414139] FS:  00007f2ae0f40980(0000) GS:ffff96f1fd640000(0000) knlGS:0000000000000000
[    7.415699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.416780] CR2: 0000000000000008 CR3: 0000000104830000 CR4: 00000000000006e0
[    7.418115] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.419492] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.420830] Call Trace:
[    7.421308]  <TASK>
[    7.421722] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[    7.422411] ? __die_body (arch/x86/kernel/dumpstack.c:421)
[    7.423113] ? __die (arch/x86/kernel/dumpstack.c:435)
[    7.423716] ? page_fault_oops (arch/x86/mm/fault.c:707)
[    7.424504] ? search_bpf_extables (kernel/bpf/core.c:751)
[    7.425329] ? __pfx__compound_head (include/linux/page-flags.h:245)
[    7.426171] ? search_exception_tables (kernel/extable.c:64)
[    7.427084] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:762)
[    7.427995] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:860)
[    7.428891] ? up_read (arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1616)
[    7.429514] ? bad_area_nosemaphore (arch/x86/mm/fault.c:867)
[    7.430367] ? do_user_addr_fault (arch/x86/mm/fault.c:1458)
[    7.431238] ? exc_page_fault (arch/x86/include/asm/paravirt.h:695 arch/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)
[    7.431998] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
[    7.432802] ? __pfx__compound_head (include/linux/page-flags.h:245)
[    7.433640] ? do_pte_missing (mm/memory.c:4610 mm/memory.c:4682 mm/memory.c:3670)
[    7.434425] __handle_mm_fault (mm/memory.c:4947 mm/memory.c:5087)
[    7.435234] handle_mm_fault (mm/memory.c:5252)
[    7.435976] do_user_addr_fault (arch/x86/mm/fault.c:1393)
[    7.436786] exc_page_fault (arch/x86/include/asm/paravirt.h:695 arch/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)
[    7.437517] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
[    7.438294] RIP: 0033:0x7f2ae1480ace
[ 7.439035] Code: 8d a0 48 00 00 00 49 8b 44 24 08 48 0b 85 48 00 00 00 74 28 48 8d 3d f1 63 1d 00 e8f

Code starting with the faulting instruction
===========================================
   0:   8d a0 48 00 00 00       lea    0x48(%rax),%esp
   6:   49 8b 44 24 08          mov    0x8(%r12),%rax
   b:   48 0b 85 48 00 00 00    or     0x48(%rbp),%rax
  12:   74 28                   je     0x3c
  14:   48 8d 3d f1 63 1d 00    lea    0x1d63f1(%rip),%rdi        # 0x1d640c
  1b:   8f                      .byte 0x8f
[    7.442519] RSP: 002b:00007ffdfa53bc70 EFLAGS: 00010246
[    7.443524] RAX: 0000000000000000 RBX: 00007f2ae19a7028 RCX: fffffffffffff000
[    7.444857] RDX: 00007f2ae0f412e0 RSI: a3d70a3d70a3d70b RDI: 00007f2ae1656eb0
[    7.446195] RBP: 00007f2ae0f40828 R08: 0000000000000001 R09: 00007f2ae19a7000
[    7.447572] R10: 000055f8d50a1010 R11: 0000000000000246 R12: 00007f2ae0f40870
[    7.448939] R13: 000055f8d50a7110 R14: 000055f8d50a2fd0 R15: 0000000000000001
[    7.450277]  </TASK>
[    7.450725] Modules linked in: ip_tables x_tables autofs4 raid10 raid456 libcrc32c async_raid6_recov 4
[    7.454653] Dumping ftrace buffer:
[    7.455321]    (ftrace buffer empty)
[    7.456014] CR2: 0000000000000008
[    7.456686] ---[ end trace 0000000000000000 ]---
[    7.457576] RIP: 0010:_compound_head (include/linux/page-flags.h:245)
[ 7.458440] Code: e8 35 b5 cd ff 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90f

Code starting with the faulting instruction
===========================================
   0:   e8 35 b5 cd ff          callq  0xffffffffffcdb53a
   5:   5d                      pop    %rbp
   6:   c3                      retq
   7:   cc                      int3
   8:   cc                      int3
   9:   cc                      int3
   a:   cc                      int3
   b:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
  12:   00 00 00 00
  16:   0f 1f 40 00             nopl   0x0(%rax)
  1a:   90                      nop
  1b:   0f                      .byte 0xf
[    7.461986] RSP: 0000:ffffb86140cd3d58 EFLAGS: 00010202
[    7.463014] RAX: ffff96d3c19c4d38 RBX: ffffffffa103f080 RCX: 00000001019c4067
[    7.464374] RDX: 0000000000000000 RSI: ffff96d2c0000d38 RDI: 0000000000000000
[    7.465731] RBP: ffffb86140cd3d90 R08: ffff96d3c19c4d38 R09: 0000000000000067
[    7.467114] R10: 0000000000000000 R11: 00007f2ae19d5fff R12: ffffb86140cd3dd0
[    7.468469] R13: 0000000000000001 R14: ffff96d3cb7aa450 R15: 0000000000000860
[    7.469824] FS:  00007f2ae0f40980(0000) GS:ffff96f1fd640000(0000) knlGS:0000000000000000
[    7.471383] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.472482] CR2: 0000000000000008 CR3: 0000000104830000 CR4: 00000000000006e0
[    7.473835] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.475216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Thanks,
SJ
