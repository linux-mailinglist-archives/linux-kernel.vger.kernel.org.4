Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A52D74FDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGLDb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjGLDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:31:45 -0400
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422311BD6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:31:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---.TrdETZJ_1689132690;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TrdETZJ_1689132690)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 11:31:31 +0800
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
        "Tom Rix" <trix@redhat.com>, "Brian Gerst" <brgerst@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "=?UTF-8?B?UGV0ZXIgWmlqbHN0cmEgKEludGVsKQ==?=" <peterz@infradead.org>,
        "=?UTF-8?B?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?=" 
        <mhiramat@kernel.org>, "Masahiro Yamada" <masahiroy@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "=?UTF-8?B?b3BlbiBsaXN0OkNMQU5HL0xMVk0gQlVJTEQgU1VQUE9SVA==?=" 
        <llvm@lists.linux.dev>
Subject: [PATCH RFC 3/7] x86/head/64: Move all head code from head64.c into another file
Date:   Wed, 12 Jul 2023 11:30:07 +0800
Message-Id: <7c026a8167cd90a3b3605a0f617dee5ebee16a36.1689130310.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
References: <cover.1689130310.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for building the head code as PIE and getting rid of
all fixup_pointer() calls.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/include/asm/desc.h       |  12 ++
 arch/x86/kernel/Makefile          |   5 +-
 arch/x86/kernel/head64.c          | 307 +----------------------------
 arch/x86/kernel/head64_identity.c | 315 ++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+), 305 deletions(-)
 create mode 100644 arch/x86/kernel/head64_identity.c

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ab97b22ac04a..b568331b0caa 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -431,6 +431,18 @@ static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
 #endif
 }
 
+static inline void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	struct idt_data data;
+	gate_desc desc;
+
+	init_idt_data(&data, n, handler);
+	idt_init_desc(&desc, &data);
+	native_write_idt_entry(idt, n, &desc);
+#endif
+}
+
 extern unsigned long system_vectors[];
 
 extern void load_current_idt(void);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4070a01c11b7..2fd9a4fe27b1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -16,11 +16,13 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_head64_identity.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
+KASAN_SANITIZE_head64_identity.o			:= n
 KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
@@ -31,6 +33,7 @@ KASAN_SANITIZE_sev.o					:= n
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
+KMSAN_SANITIZE_head64_identity.o			:= n
 KMSAN_SANITIZE_nmi.o					:= n
 
 # If instrumentation of this dir is enabled, boot hangs during first second.
@@ -153,5 +156,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_GART_IOMMU)	+= amd_gart_64.o aperture_64.o
 
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
-	obj-y				+= vsmp_64.o
+	obj-y				+= vsmp_64.o head64_identity.o
 endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5066189b00ac..6eca5fe97c1f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -46,7 +46,7 @@
  * Manage page tables very early on.
  */
 extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
-static unsigned int __initdata next_early_pgt;
+unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
@@ -66,259 +66,6 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
-/*
- * GDT used on the boot CPU before switching to virtual addresses.
- */
-static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
-};
-
-/*
- * Address needs to be set at runtime because it references the startup_gdt
- * while the kernel still uses a direct mapping.
- */
-static struct desc_ptr startup_gdt_descr __initdata = {
-	.size = sizeof(startup_gdt),
-	.address = 0,
-};
-
-#define __head	__section(".head.text")
-
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
-#ifdef CONFIG_X86_5LEVEL
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
-
-static bool __head check_la57_support(unsigned long physaddr)
-{
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
-
-	return true;
-}
-#else
-static bool __head check_la57_support(unsigned long physaddr)
-{
-	return false;
-}
-#endif
-
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
-{
-	unsigned long vaddr, vaddr_end;
-	int i;
-
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 */
-	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			/*
-			 * On SNP, transition the page to shared in the RMP table so that
-			 * it is consistent with the page table attribute change.
-			 *
-			 * __start_bss_decrypted has a virtual address in the high range
-			 * mapping (kernel .text). PVALIDATE, by way of
-			 * early_snp_set_memory_shared(), requires a valid virtual
-			 * address but the kernel is currently running off of the identity
-			 * mapping so use __pa() to get a *currently* valid virtual address.
-			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
-
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
-}
-
-/* Code in __startup_64() can be relocated during execution, but the compiler
- * doesn't have to generate PC-relative relocations when accessing globals from
- * that function. Clang actually does not generate them, which leads to
- * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
- */
-unsigned long __head __startup_64(unsigned long physaddr,
-				  struct boot_params *bp)
-{
-	unsigned long load_delta, *p;
-	unsigned long pgtable_flags;
-	pgdval_t *pgd;
-	p4dval_t *p4d;
-	pudval_t *pud;
-	pmdval_t *pmd, pmd_entry;
-	pteval_t *mask_ptr;
-	bool la57;
-	int i;
-	unsigned int *next_pgt_ptr;
-
-	la57 = check_la57_support(physaddr);
-
-	/* Is the address too large? */
-	if (physaddr >> MAX_PHYSMEM_BITS)
-		for (;;);
-
-	/*
-	 * Compute the delta between the address I am compiled to run at
-	 * and the address I am actually running at.
-	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
-
-	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_MASK)
-		for (;;);
-
-	/* Include the SME encryption mask in the fixup value */
-	load_delta += sme_get_me_mask();
-
-	/* Fixup the physical addresses in the page table */
-
-	pgd = fixup_pointer(&early_top_pgt, physaddr);
-	p = pgd + pgd_index(__START_KERNEL_map);
-	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
-	else
-		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
-
-	if (la57) {
-		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
-		p4d[511] += load_delta;
-	}
-
-	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
-
-	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
-	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		pmd[i] += load_delta;
-
-	/*
-	 * Set up the identity mapping for the switchover.  These
-	 * entries should *NOT* have the global bit set!  This also
-	 * creates a bunch of nonsense entries but that is fine --
-	 * it avoids problems around wraparound.
-	 */
-
-	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
-	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
-	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
-
-	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
-
-	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
-				    physaddr);
-
-		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
-		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
-		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
-
-		i = physaddr >> P4D_SHIFT;
-		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
-		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
-	} else {
-		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
-		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
-		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
-	}
-
-	i = physaddr >> PUD_SHIFT;
-	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
-	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
-
-	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
-	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
-	pmd_entry &= *mask_ptr;
-	pmd_entry += sme_get_me_mask();
-	pmd_entry +=  physaddr;
-
-	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
-		int idx = i + (physaddr >> PMD_SHIFT);
-
-		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
-	}
-
-	/*
-	 * Fixup the kernel text+data virtual addresses. Note that
-	 * we might write invalid pmds, when the kernel is relocated
-	 * cleanup_highmap() fixes this up along with the mappings
-	 * beyond _end.
-	 *
-	 * Only the region occupied by the kernel image has so far
-	 * been checked against the table of usable memory regions
-	 * provided by the firmware, so invalidate pages outside that
-	 * region. A page table entry that maps to a reserved area of
-	 * memory would allow processor speculation into that area,
-	 * and on some hardware (particularly the UV platform) even
-	 * speculative access to some reserved areas is caught as an
-	 * error, causing the BIOS to halt the system.
-	 */
-
-	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
-
-	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
-		pmd[i] &= ~_PAGE_PRESENT;
-
-	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
-		if (pmd[i] & _PAGE_PRESENT)
-			pmd[i] += load_delta;
-
-	/* invalidate pages after the kernel image */
-	for (; i < PTRS_PER_PMD; i++)
-		pmd[i] &= ~_PAGE_PRESENT;
-
-	/*
-	 * Fixup phys_base - remove the memory encryption mask to obtain
-	 * the true physical address.
-	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
-
-	return sme_postprocess_startup(bp, pmd);
-}
-
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
 {
@@ -568,44 +315,13 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  * configured which require certain CPU state to be setup already (like TSS),
  * which also hasn't happened yet in early CPU bringup.
  */
-static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
+gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static struct desc_ptr bringup_idt_descr = {
+struct desc_ptr bringup_idt_descr = {
 	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
 	.address	= 0, /* Set at runtime */
 };
 
-static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
-{
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	struct idt_data data;
-	gate_desc desc;
-
-	init_idt_data(&data, n, handler);
-	idt_init_desc(&desc, &data);
-	native_write_idt_entry(idt, n, &desc);
-#endif
-}
-
-/* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
-{
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
-
-	desc->address = (unsigned long)idt;
-	native_load_idt(desc);
-}
-
 /* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
@@ -618,20 +334,3 @@ void early_setup_idt(void)
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
 }
-
-/*
- * Setup boot CPU state needed before kernel switches to virtual addresses.
- */
-void __head startup_64_setup_env(unsigned long physbase)
-{
-	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
-	native_load_gdt(&startup_gdt_descr);
-
-	/* New GDT is live - reload data segment registers */
-	asm volatile("movl %%eax, %%ds\n"
-		     "movl %%eax, %%ss\n"
-		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
-
-	startup_64_load_idt(physbase);
-}
diff --git a/arch/x86/kernel/head64_identity.c b/arch/x86/kernel/head64_identity.c
new file mode 100644
index 000000000000..a10acbe00fe9
--- /dev/null
+++ b/arch/x86/kernel/head64_identity.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  prepare to run common code
+ *
+ *  Copyright (C) 2000 Andrea Arcangeli <andrea@suse.de> SuSE
+ */
+
+#define DISABLE_BRANCH_PROFILING
+
+/* cpu_feature_enabled() cannot be used this early */
+#define USE_EARLY_PGTABLE_L5
+
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pgtable.h>
+
+#include <asm/desc.h>
+#include <asm/sections.h>
+#include <asm/trapnr.h>
+#include <asm/sev.h>
+
+extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
+extern unsigned int next_early_pgt;
+extern gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS];
+extern struct desc_ptr bringup_idt_descr;
+
+/*
+ * GDT used on the boot CPU before switching to virtual addresses.
+ */
+static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+};
+
+/*
+ * Address needs to be set at runtime because it references the startup_gdt
+ * while the kernel still uses a direct mapping.
+ */
+static struct desc_ptr startup_gdt_descr __initdata = {
+	.size = sizeof(startup_gdt),
+	.address = 0,
+};
+
+#define __head __section(".head.text")
+
+static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
+{
+	return ptr - (void *)_text + (void *)physaddr;
+}
+
+static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
+{
+	return fixup_pointer(ptr, physaddr);
+}
+
+#ifdef CONFIG_X86_5LEVEL
+static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
+{
+	return fixup_pointer(ptr, physaddr);
+}
+
+static bool __head check_la57_support(unsigned long physaddr)
+{
+	/*
+	 * 5-level paging is detected and enabled at kernel decompression
+	 * stage. Only check if it has been enabled there.
+	 */
+	if (!(native_read_cr4() & X86_CR4_LA57))
+		return false;
+
+	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
+	*fixup_int(&pgdir_shift, physaddr) = 48;
+	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
+	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
+	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
+	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
+
+	return true;
+}
+#else
+static bool __head check_la57_support(unsigned long physaddr)
+{
+	return false;
+}
+#endif
+
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+{
+	unsigned long vaddr, vaddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (sme_get_me_mask()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * On SNP, transition the page to shared in the RMP table so that
+			 * it is consistent with the page table attribute change.
+			 *
+			 * __start_bss_decrypted has a virtual address in the high range
+			 * mapping (kernel .text). PVALIDATE, by way of
+			 * early_snp_set_memory_shared(), requires a valid virtual
+			 * address but the kernel is currently running off of the identity
+			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
+/* Code in __startup_64() can be relocated during execution, but the compiler
+ * doesn't have to generate PC-relative relocations when accessing globals from
+ * that function. Clang actually does not generate them, which leads to
+ * boot-time crashes. To work around this problem, every global pointer must
+ * be adjusted using fixup_pointer().
+ */
+unsigned long __head __startup_64(unsigned long physaddr,
+				  struct boot_params *bp)
+{
+	unsigned long load_delta, *p;
+	unsigned long pgtable_flags;
+	pgdval_t *pgd;
+	p4dval_t *p4d;
+	pudval_t *pud;
+	pmdval_t *pmd, pmd_entry;
+	pteval_t *mask_ptr;
+	bool la57;
+	int i;
+	unsigned int *next_pgt_ptr;
+
+	la57 = check_la57_support(physaddr);
+
+	/* Is the address too large? */
+	if (physaddr >> MAX_PHYSMEM_BITS)
+		for (;;);
+
+	/*
+	 * Compute the delta between the address I am compiled to run at
+	 * and the address I am actually running at.
+	 */
+	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+
+	/* Is the address not 2M aligned? */
+	if (load_delta & ~PMD_MASK)
+		for (;;);
+
+	/* Include the SME encryption mask in the fixup value */
+	load_delta += sme_get_me_mask();
+
+	/* Fixup the physical addresses in the page table */
+
+	pgd = fixup_pointer(&early_top_pgt, physaddr);
+	p = pgd + pgd_index(__START_KERNEL_map);
+	if (la57)
+		*p = (unsigned long)level4_kernel_pgt;
+	else
+		*p = (unsigned long)level3_kernel_pgt;
+	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+
+	if (la57) {
+		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
+		p4d[511] += load_delta;
+	}
+
+	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
+	pud[510] += load_delta;
+	pud[511] += load_delta;
+
+	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
+	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
+		pmd[i] += load_delta;
+
+	/*
+	 * Set up the identity mapping for the switchover.  These
+	 * entries should *NOT* have the global bit set!  This also
+	 * creates a bunch of nonsense entries but that is fine --
+	 * it avoids problems around wraparound.
+	 */
+
+	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
+	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
+	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
+
+	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
+
+	if (la57) {
+		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
+				    physaddr);
+
+		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
+		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
+		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
+
+		i = physaddr >> P4D_SHIFT;
+		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+	} else {
+		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
+		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
+		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
+	}
+
+	i = physaddr >> PUD_SHIFT;
+	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+
+	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
+	pmd_entry &= *mask_ptr;
+	pmd_entry += sme_get_me_mask();
+	pmd_entry +=  physaddr;
+
+	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
+		int idx = i + (physaddr >> PMD_SHIFT);
+
+		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
+	}
+
+	/*
+	 * Fixup the kernel text+data virtual addresses. Note that
+	 * we might write invalid pmds, when the kernel is relocated
+	 * cleanup_highmap() fixes this up along with the mappings
+	 * beyond _end.
+	 *
+	 * Only the region occupied by the kernel image has so far
+	 * been checked against the table of usable memory regions
+	 * provided by the firmware, so invalidate pages outside that
+	 * region. A page table entry that maps to a reserved area of
+	 * memory would allow processor speculation into that area,
+	 * and on some hardware (particularly the UV platform) even
+	 * speculative access to some reserved areas is caught as an
+	 * error, causing the BIOS to halt the system.
+	 */
+
+	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
+
+	/* invalidate pages before the kernel image */
+	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	/* fixup pages that are part of the kernel image */
+	for (; i <= pmd_index((unsigned long)_end); i++)
+		if (pmd[i] & _PAGE_PRESENT)
+			pmd[i] += load_delta;
+
+	/* invalidate pages after the kernel image */
+	for (; i < PTRS_PER_PMD; i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	/*
+	 * Fixup phys_base - remove the memory encryption mask to obtain
+	 * the true physical address.
+	 */
+	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
+
+	return sme_postprocess_startup(bp, pmd);
+}
+
+/* This runs while still in the direct mapping */
+static void __head startup_64_load_idt(unsigned long physbase)
+{
+	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
+	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
+
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		void *handler;
+
+		/* VMM Communication Exception */
+		handler = fixup_pointer(vc_no_ghcb, physbase);
+		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
+	}
+
+	desc->address = (unsigned long)idt;
+	native_load_idt(desc);
+}
+
+/*
+ * Setup boot CPU state needed before kernel switches to virtual addresses.
+ */
+void __head startup_64_setup_env(unsigned long physbase)
+{
+	/* Load GDT */
+	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	native_load_gdt(&startup_gdt_descr);
+
+	/* New GDT is live - reload data segment registers */
+	asm volatile("movl %%eax, %%ds\n"
+		     "movl %%eax, %%ss\n"
+		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+
+	startup_64_load_idt(physbase);
+}
-- 
2.31.1

