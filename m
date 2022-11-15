Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539A62AE52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiKOW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiKOW0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7F31375;
        Tue, 15 Nov 2022 14:26:25 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIIVFgJx/pouM5q6Q7NJZwfH58BW4SlO7J0Ngwf4XOA=;
        b=PtZN8w2+puJs0STRyFg3p7FHuSY37zAYjBBjnnEXxTvekELIyGmAlvwEgXMggnH69nKVfS
        RnTZD7Aihnp4ek/4rvOfhVzVAkMQFexmz1Ug4VkOAL2lVr2tb4ZbMscvofU0Q88mUdjfm/
        tFkLUBSS3f2pUcuM2dHm69JAwOWm1+iYXLa7Oa8hsG3Odj1EFocRQCseIBQAbZupf/KBsl
        +ZYH89ZAUmC2uAI+ibuf9kHV3Jvugq/JF6k4gt+9m7tmbJrKjDClrk+/yg1QZam/s+w6Tn
        wrVfmi64s1Z37c41UEz4WMohFbGhDa10OFHx5hrX6fTHCbBvvKPmNOyLGqmVZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIIVFgJx/pouM5q6Q7NJZwfH58BW4SlO7J0Ngwf4XOA=;
        b=AdXDGdc1vxst4yhgkbbdSPBL3p8yh2S8nE7lrhN1PWGVe2OpZzT6k9OmWMyHXv8iRutZpY
        e8lGkHrE16smHICQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Populate KASAN shadow for entire per-CPU range
 of CPU entry area
Cc:     syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110203504.1985010-3-seanjc@google.com>
References: <20221110203504.1985010-3-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <166855118326.4906.13329103756426094268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4917fc63dc646d6346f5d67ce8c10df874a6f4fe
Gitweb:        https://git.kernel.org/tip/4917fc63dc646d6346f5d67ce8c10df874a6f4fe
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:01 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:59 +01:00

x86/mm: Populate KASAN shadow for entire per-CPU range of CPU entry area

Populate a KASAN shadow for the entire possible per-CPU range of the CPU
entry area instead of requiring that each individual chunk map a shadow.
Mapping shadows individually is error prone, e.g. the per-CPU GDT mapping
was left behind, which can lead to not-present page faults during KASAN
validation if the kernel performs a software lookup into the GDT.  The DS
buffer is also likely affected.

The motivation for mapping the per-CPU areas on-demand was to avoid
mapping the entire 512GiB range that's reserved for the CPU entry area,
shaving a few bytes by not creating shadows for potentially unused memory
was not a goal.

The bug is most easily reproduced by doing a sigreturn with a garbage
CS in the sigcontext, e.g.

  int main(void)
  {
    struct sigcontext regs;

    syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
    syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
    syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);

    memset(&regs, 0, sizeof(regs));
    regs.cs = 0x1d0;
    syscall(__NR_rt_sigreturn);
    return 0;
  }

to coerce the kernel into doing a GDT lookup to compute CS.base when
reading the instruction bytes on the subsequent #GP to determine whether
or not the #GP is something the kernel should handle, e.g. to fixup UMIP
violations or to emulate CLI/STI for IOPL=3 applications.

  BUG: unable to handle page fault for address: fffffbc8379ace00
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 16c03a067 P4D 16c03a067 PUD 15b990067 PMD 15b98f067 PTE 0
  Oops: 0000 [#1] PREEMPT SMP KASAN
  CPU: 3 PID: 851 Comm: r2 Not tainted 6.1.0-rc3-next-20221103+ #432
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kasan_check_range+0xdf/0x190
  Call Trace:
   <TASK>
   get_desc+0xb0/0x1d0
   insn_get_seg_base+0x104/0x270
   insn_fetch_from_user+0x66/0x80
   fixup_umip_exception+0xb1/0x530
   exc_general_protection+0x181/0x210
   asm_exc_general_protection+0x22/0x30
  RIP: 0003:0x0
  Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  RSP: 0003:0000000000000000 EFLAGS: 00000202
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000001d0
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Link: https://lkml.kernel.org/r/20221110203504.1985010-3-seanjc@google.com
---
 arch/x86/mm/cpu_entry_area.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index d831aae..7c855df 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -91,11 +91,6 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 static void __init
 cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 {
-	phys_addr_t pa = per_cpu_ptr_to_phys(ptr);
-
-	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE,
-					early_pfn_to_nid(PFN_DOWN(pa)));
-
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
 		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
@@ -195,6 +190,9 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
+	kasan_populate_shadow_for_vaddr(cea, CPU_ENTRY_AREA_SIZE,
+					early_cpu_to_node(cpu));
+
 	cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
 
 	cea_map_percpu_pages(&cea->entry_stack_page,
