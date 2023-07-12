Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8F74FDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGLDcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGLDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:31:59 -0400
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F27A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:31:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---.TrdHx1m_1689132706;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TrdHx1m_1689132706)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 11:31:47 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "=?UTF-8?B?bWFpbnRhaW5lcjpYODYgQVJDSElURUNUVVJFIDMyLUJJVCBBTkQgNjQtQklU?=" 
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "=?UTF-8?B?UGV0ZXIgWmlqbHN0cmEgKEludGVsKQ==?=" <peterz@infradead.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "=?UTF-8?B?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?=" 
        <mhiramat@kernel.org>, "Masahiro Yamada" <masahiroy@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Usama Arif" <usama.arif@bytedance.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "=?UTF-8?B?b3BlbiBsaXN0OkNMQU5HL0xMVk0gQlVJTEQgU1VQUE9SVA==?=" 
        <llvm@lists.linux.dev>
Subject: [PATCH RFC 5/7] x86/head/64: Build the head code as PIE
Date:   Wed, 12 Jul 2023 11:30:09 +0800
Message-Id: <12bb41e38979f68760a98be3b25cc66cb955e559.1689130310.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the early boot stage, the head code runs in a low identity
address, so all absolute references would be incorrect. However, the
compiler doesn't have to generate PC-relative references when accessing
globals. To work around this problem, every global variable access must
be adjusted using fixup_pointer(). Nevertheless, the compiler could
generate absolute references for some global variable accesses, and the
behavior differs between GCC and CLANG. For example, GCC generates
PC-relative references for 'next_early_pgt', while CLANG generates
absolute references. Moreover, the rule is not always clear, e.g.,
'pgdir_shift' is a non-static global variable similar to
'next_early_pgt', but the compiler could generate the right PC-relative
reference, so fixup_pointer() is not applied when using the PGDIR_SHIFT
macro.

To avoid such cases, build the head code as PIE to force the generation
of PC-relative references and eliminate the need for fixup_pointer().
However, it may be necessary to obtain an absolute virtual address for
some symbols in the head code. In this case, use 'movabsq'.
Additionally, the 'mcmodel=kernel' option is not compatible with the
'fPIE' option and needs to be removed. This will result in using the
'%fs' register for stack canary access if the stack protector is
enabled. The 'mstack-protector-guard-reg' compiler option could be used
to fix this, but it is only used in 32-bit now and 64-bit is still using
the fixed location version. Since the head code is in the early booting
stage, it is safe to disable the stack protector for the head code.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/include/asm/setup.h      |   2 +-
 arch/x86/kernel/Makefile          |  11 +++
 arch/x86/kernel/head64_identity.c | 112 +++++++++++-------------------
 arch/x86/kernel/head_64.S         |   2 -
 4 files changed, 52 insertions(+), 75 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f3495623ac99..b893b0cdddac 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,7 +50,7 @@ extern unsigned long saved_video_mode;
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern void startup_64_setup_env(unsigned long physbase);
+extern void startup_64_setup_env(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2fd9a4fe27b1..6564113f5298 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,17 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
+# The 'mcmodel=kernel' option is not compatible with the 'fPIE' option and
+# needs to be removed. This will result in using the '%fs' register for stack
+# canary access if the stack protector is enabled. The
+# 'mstack-protector-guard-reg' compiler option could be used to fix this, but
+# it is only used in 32-bit now and 64-bit is still using the fixed location
+# version. Since the head code is in the early booting stage, it is safe to
+# disable the stack protector for the head code.
+CFLAGS_REMOVE_head64_identity.o += -mcmodel=kernel
+CFLAGS_head64_identity.o += -fPIE -include $(srctree)/include/linux/hidden.h
+CFLAGS_head64_identity.o += -fno-stack-protector
+
 obj-y			+= head_$(BITS).o
 obj-y			+= head$(BITS).o
 obj-y			+= ebda.o
diff --git a/arch/x86/kernel/head64_identity.c b/arch/x86/kernel/head64_identity.c
index a10acbe00fe9..93f5831917bc 100644
--- a/arch/x86/kernel/head64_identity.c
+++ b/arch/x86/kernel/head64_identity.c
@@ -45,23 +45,8 @@ static struct desc_ptr startup_gdt_descr __initdata = {
 
 #define __head __section(".head.text")
 
-static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
-{
-	return ptr - (void *)_text + (void *)physaddr;
-}
-
-static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
 #ifdef CONFIG_X86_5LEVEL
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
-static bool __head check_la57_support(unsigned long physaddr)
+static bool __head check_la57_support(void)
 {
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
@@ -70,22 +55,27 @@ static bool __head check_la57_support(unsigned long physaddr)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
+	__pgtable_l5_enabled = 1;
+	pgdir_shift = 48;
+	ptrs_per_p4d = 512;
+	page_offset_base = __PAGE_OFFSET_BASE_L5;
+	vmalloc_base = __VMALLOC_BASE_L5;
+	vmemmap_base = __VMEMMAP_BASE_L5;
 
 	return true;
 }
 #else
-static bool __head check_la57_support(unsigned long physaddr)
+static bool __head check_la57_support(void)
 {
 	return false;
 }
 #endif
 
+#define SYM_ABS_VA(sym) ({					\
+	unsigned long __v;					\
+	asm("movabsq $" __stringify(sym) ", %0":"=r"(__v));	\
+	__v; })
+
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
@@ -101,8 +91,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		vaddr = SYM_ABS_VA(__start_bss_decrypted);
+		vaddr_end = SYM_ABS_VA(__end_bss_decrypted);
 
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
 			/*
@@ -129,12 +119,6 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	return sme_get_me_mask();
 }
 
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
- */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
@@ -144,12 +128,10 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
-	pteval_t *mask_ptr;
 	bool la57;
 	int i;
-	unsigned int *next_pgt_ptr;
 
-	la57 = check_la57_support(physaddr);
+	la57 = check_la57_support();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -159,7 +141,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = physaddr - (SYM_ABS_VA(_text) - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -170,26 +152,24 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(&early_top_pgt, physaddr);
+	pgd = (pgdval_t *)early_top_pgt;
 	p = pgd + pgd_index(__START_KERNEL_map);
 	if (la57)
 		*p = (unsigned long)level4_kernel_pgt;
 	else
 		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+	*p += _PAGE_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
+		p4d = (p4dval_t *)level4_kernel_pgt;
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	level3_kernel_pgt[510].pud += load_delta;
+	level3_kernel_pgt[511].pud += load_delta;
 
-	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		pmd[i] += load_delta;
+		level2_fixmap_pgt[i].pmd += load_delta;
 
 	/*
 	 * Set up the identity mapping for the switchover.  These
@@ -198,15 +178,13 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * it avoids problems around wraparound.
 	 */
 
-	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
-	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
-	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
+	pud = (pudval_t *)early_dynamic_pgts[next_early_pgt++];
+	pmd = (pmdval_t *)early_dynamic_pgts[next_early_pgt++];
 
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
-				    physaddr);
+		p4d = (p4dval_t *)early_dynamic_pgts[next_early_pgt++];
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
@@ -227,8 +205,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
-	pmd_entry &= *mask_ptr;
+	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
@@ -253,15 +230,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * speculative access to some reserved areas is caught as an
 	 * error, causing the BIOS to halt the system.
 	 */
-
-	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
+	pmd = (pmdval_t *)level2_kernel_pgt;
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(SYM_ABS_VA(_text)); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(SYM_ABS_VA(_end)); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
@@ -273,37 +249,29 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
+	phys_base += load_delta - sme_get_me_mask();
 
 	return sme_postprocess_startup(bp, pmd);
 }
 
 /* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
+static void __head startup_64_load_idt(void)
 {
-	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
-	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		void *handler;
-
-		/* VMM Communication Exception */
-		handler = fixup_pointer(vc_no_ghcb, physbase);
-		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
-	}
+	/* VMM Communication Exception */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_no_ghcb);
 
-	desc->address = (unsigned long)idt;
-	native_load_idt(desc);
+	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
+	native_load_idt(&bringup_idt_descr);
 }
 
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_env(void)
 {
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	startup_gdt_descr.address = (unsigned long)startup_gdt;
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -311,5 +279,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt();
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c5b9289837dc..5b46da66d6c8 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -66,8 +66,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	leaq	_text(%rip), %rdi
-
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-- 
2.31.1

