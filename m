Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6968F423
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjBHRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBHRQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:16:37 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E174ED19
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675876595;
        bh=FjG2q/BqmWHWGDdVBl1Ir4njZnUEulypldGQfN1H+3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ie3gUh/MbhglAnDqK2TkQcTdZtmi8xGA6iq/3hKaKWtRK3uN1fk3I4+Y3btes9xrV
         Xn6luu77wXK8Fz1WJOGc6nilw/DldlP13iE4QuKpxBdiAAwLtvDGbGO7WyA/W2KeB/
         HNRg/ea0KRLUY6Z3necLzeV2aq5uY0o7tdZB8hdI=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1174:d100:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 6C55465C53;
        Wed,  8 Feb 2023 12:16:31 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 2/5] LoongArch: Use la.pcrel instead of la.abs for exception handlers
Date:   Thu,  9 Feb 2023 01:16:04 +0800
Message-Id: <20230208171607.391107-3-xry111@xry111.site>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208171607.391107-1-xry111@xry111.site>
References: <20230208171607.391107-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needed to build the kernel as a PIE, or the linker will complain.

For the consideration about performance, we copy the exception handlers
to a dedicated 64 KB area for each CPU.  So, the PC-relative offset
calculated at link time will be incorrect and we need to relocate the
exception handlers after copying them.

For the simplicity, we don't use the ELF R_LARCH_* relocations, but code
an relocation entry as simply (offset_in_the_handler, symbol_addr).  For
each exception handler, we also code the number of relocation entries.
Then we can use the relocation information to fix up the handlers after
copying them.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/inst.h       |   1 +
 arch/loongarch/include/asm/setup.h      |   6 +-
 arch/loongarch/include/asm/stackframe.h |   3 +-
 arch/loongarch/kernel/genex.S           |  40 +++++-
 arch/loongarch/kernel/traps.c           | 158 ++++++++++++++++++++----
 arch/loongarch/mm/tlb.c                 |  23 ++--
 arch/loongarch/mm/tlbex.S               |  69 +++++++++--
 7 files changed, 255 insertions(+), 45 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 7eedd83fd0d7..426054518a3d 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -32,6 +32,7 @@ enum reg1i20_op {
 	lu12iw_op	= 0x0a,
 	lu32id_op	= 0x0b,
 	pcaddi_op	= 0x0c,
+	pcalau12i_op	= 0x0d,
 	pcaddu12i_op	= 0x0e,
 	pcaddu18i_op	= 0x0f,
 };
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 72ead58039f3..f0a2b34365f1 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -11,6 +11,9 @@
 
 #define VECSIZE 0x200
 
+struct handler_reloc;
+
+extern struct handler_reloc *eentry_reloc[];
 extern unsigned long eentry;
 extern unsigned long tlbrentry;
 extern char init_command_line[COMMAND_LINE_SIZE];
@@ -18,7 +21,8 @@ extern void tlb_init(int cpu);
 extern void cpu_cache_init(void);
 extern void cache_error_setup(void);
 extern void per_cpu_trap_init(int cpu);
-extern void set_handler(unsigned long offset, void *addr, unsigned long len);
+extern void set_handler(unsigned long exccode, void *addr);
 extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len);
+extern void reloc_handler(unsigned long handler, struct handler_reloc *rel);
 
 #endif /* __SETUP_H */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 7deb043ce387..bbec1e56b61b 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -77,7 +77,8 @@
  * new value in sp.
  */
 	.macro	get_saved_sp docfi=0
-	la.abs	  t1, kernelsp
+	/* The label is used for generating reloc tables for handlers */
+514:	la.pcrel  t1, t0, kernelsp
 #ifdef CONFIG_SMP
 	csrrd	  t0, PERCPU_BASE_KS
 	LONG_ADD  t1, t1, t0
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 7e5c293ed89f..005a10fe5a50 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -34,7 +34,7 @@ SYM_FUNC_END(__arch_cpu_idle)
 SYM_FUNC_START(handle_vint)
 	BACKUP_T0T1
 	SAVE_ALL
-	la.abs	t1, __arch_cpu_idle
+0:	la.pcrel t1, t2, __arch_cpu_idle
 	LONG_L	t0, sp, PT_ERA
 	/* 32 byte rollback region */
 	ori	t0, t0, 0x1f
@@ -43,11 +43,25 @@ SYM_FUNC_START(handle_vint)
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
 	move	a1, sp
-	la.abs	t0, do_vint
+2:	la.pcrel t0, t2, do_vint
 	jirl	ra, t0, 0
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_vint)
 
+SYM_DATA_START(rel_handle_vint)
+LONG	3
+
+LONG	514b - handle_vint
+LONG	kernelsp
+
+LONG	0b - handle_vint
+LONG	__arch_cpu_idle
+
+LONG	2b - handle_vint
+LONG	do_vint
+
+SYM_DATA_END(rel_handle_vint)
+
 SYM_FUNC_START(except_vec_cex)
 	b	cache_parity_error
 SYM_FUNC_END(except_vec_cex)
@@ -72,12 +86,24 @@ SYM_FUNC_END(except_vec_cex)
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
-	la.abs	t0, do_\handler
+	667:
+	la.pcrel t0, t1, do_\handler
 	jirl	ra, t0, 0
 	668:
 	RESTORE_ALL_AND_RET
 	SYM_FUNC_END(handle_\exception)
 	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
+
+	SYM_DATA_START(rel_handle_\exception)
+	LONG	2
+
+	LONG	514b - 666b
+	LONG	kernelsp
+
+	LONG	667b - 666b
+	LONG	do_\handler
+
+	SYM_DATA_END(rel_handle_\exception)
 	.endm
 
 	BUILD_HANDLER ade ade badv
@@ -93,6 +119,12 @@ SYM_FUNC_END(except_vec_cex)
 	BUILD_HANDLER reserved reserved none	/* others */
 
 SYM_FUNC_START(handle_sys)
-	la.abs	t0, handle_syscall
+	la.pcrel t0, t1, handle_syscall
 	jr	t0
 SYM_FUNC_END(handle_sys)
+
+SYM_DATA_START(rel_handle_sys)
+LONG	1
+LONG	0
+LONG	handle_syscall
+SYM_DATA_END(rel_handle_sys)
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index c38a146a973b..7e073854f493 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -62,6 +62,127 @@ extern asmlinkage void handle_reserved(void);
 extern asmlinkage void handle_watch(void);
 extern asmlinkage void handle_vint(void);
 
+struct handler_reloc_entry {
+	unsigned long offset;
+	unsigned long sym;
+};
+
+struct handler_reloc {
+	unsigned long cnt;
+	struct handler_reloc_entry entries[];
+};
+
+extern struct handler_reloc rel_handle_tlb_load;
+extern struct handler_reloc rel_handle_tlb_store;
+extern struct handler_reloc rel_handle_tlb_modify;
+extern struct handler_reloc rel_handle_tlb_protect;
+extern struct handler_reloc rel_handle_ade;
+extern struct handler_reloc rel_handle_ale;
+extern struct handler_reloc rel_handle_sys;
+extern struct handler_reloc rel_handle_bp;
+extern struct handler_reloc rel_handle_ri;
+extern struct handler_reloc rel_handle_fpu;
+extern struct handler_reloc rel_handle_lsx;
+extern struct handler_reloc rel_handle_lasx;
+extern struct handler_reloc rel_handle_fpe;
+extern struct handler_reloc rel_handle_lbt;
+extern struct handler_reloc rel_handle_watch;
+extern struct handler_reloc rel_handle_reserved;
+extern struct handler_reloc rel_handle_vint;
+
+struct handler_reloc *eentry_reloc[128] = {
+	[0] = NULL, /* merr handler */
+	[EXCCODE_TLBL] = &rel_handle_tlb_load,
+	[EXCCODE_TLBS] = &rel_handle_tlb_store,
+	[EXCCODE_TLBI] = &rel_handle_tlb_load,
+	[EXCCODE_TLBM] = &rel_handle_tlb_modify,
+	[EXCCODE_TLBNR] = &rel_handle_tlb_protect,
+	[EXCCODE_TLBNX] = &rel_handle_tlb_protect,
+	[EXCCODE_TLBPE] = &rel_handle_tlb_protect,
+	[EXCCODE_ADE] = &rel_handle_ade,
+	[EXCCODE_ALE] = &rel_handle_ale,
+	[EXCCODE_SYS] = &rel_handle_sys,
+	[EXCCODE_BP] = &rel_handle_bp,
+	[EXCCODE_INE] = &rel_handle_ri,
+	[EXCCODE_IPE] = &rel_handle_ri,
+	[EXCCODE_FPDIS] = &rel_handle_fpu,
+	[EXCCODE_LSXDIS] = &rel_handle_lsx,
+	[EXCCODE_LASXDIS] = &rel_handle_lasx,
+	[EXCCODE_FPE] = &rel_handle_fpe,
+	[EXCCODE_BTDIS] = &rel_handle_lbt,
+	[EXCCODE_WATCH] = &rel_handle_watch,
+	[(EXCCODE_WATCH + 1) ... (EXCCODE_INT_START - 1)] = &rel_handle_reserved,
+	[EXCCODE_INT_START ... (EXCCODE_INT_END - 1)] = &rel_handle_vint,
+};
+
+void reloc_handler(unsigned long handler, struct handler_reloc *rel)
+{
+	if (!rel)
+		return;
+
+	for (unsigned long i = 0; i < rel->cnt; i++) {
+		unsigned long pc = handler + rel->entries[i].offset;
+		union loongarch_instruction *insn =
+			(union loongarch_instruction *)pc;
+		u32 imm[4];
+		unsigned long v = rel->entries[i].sym;
+
+		/* GNU as >= 2.40 uses pcalau12i for la.pcrel, but GNU ld <= 2.39
+		 * uses pcaddu12i.
+		 */
+		if (insn->reg1i20_format.opcode == pcalau12i_op) {
+			/* Use s32 deliberately for sign extension. */
+			s32 offset_hi20 = ((v + 0x800) & ~0xfff) -
+					  (pc & ~0xfff);
+			unsigned long anchor = (pc & ~0xfff) + offset_hi20;
+			unsigned long offset_rem = v - anchor;
+
+			imm[0] = (offset_hi20 >> 12) & 0xfffff;
+			imm[1] = v & 0xfff;
+			imm[2] = (offset_rem >> 32) & 0xfffff;
+			imm[3] = offset_rem >> 52;
+		} else if (insn->reg1i20_format.opcode == pcaddu12i_op) {
+			/* Use s32 deliberately for sign extension. */
+			s32 offset_lo = v - pc;
+			unsigned long offset_hi = v - pc - offset_lo;
+
+			imm[0] = (offset_lo >> 12) & 0xfffff;
+			imm[1] = offset_lo & 0xfff;
+			imm[2] = (offset_hi >> 32) & 0xfffff;
+			imm[3] = offset_hi >> 52;
+		} else
+			panic("Cannot fixup la.pcrel for exception handler at %lu: unexpected instruction %d!",
+			      pc, insn->word);
+
+		insn[0].reg1i20_format.immediate = imm[0];
+		insn[1].reg2i12_format.immediate = imm[1];
+		insn[2].reg1i20_format.immediate = imm[2];
+		insn[3].reg2i12_format.immediate = imm[3];
+	}
+}
+
+/* Install CPU exception handler */
+static void do_set_handler(unsigned long exccode, void *addr,
+			   struct handler_reloc *rel)
+{
+	unsigned long dest_addr = eentry + exccode * VECSIZE;
+
+	memcpy((void *)dest_addr, addr, VECSIZE);
+	reloc_handler(dest_addr, rel);
+	local_flush_icache_range(dest_addr, dest_addr + VECSIZE);
+}
+
+/* Install CPU exception handler, with the reloc table from eentry_reloc */
+void set_handler(unsigned long exccode, void *addr)
+{
+	do_set_handler(exccode, addr, eentry_reloc[exccode]);
+}
+
+static void set_handler_reserved(unsigned long exccode)
+{
+	do_set_handler(exccode, handle_reserved, &rel_handle_reserved);
+}
+
 static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 			   const char *loglvl, bool user)
 {
@@ -704,19 +825,12 @@ void per_cpu_trap_init(int cpu)
 	/* Initialise exception handlers */
 	if (cpu == 0)
 		for (i = 0; i < 64; i++)
-			set_handler(i * VECSIZE, handle_reserved, VECSIZE);
+			set_handler_reserved(i);
 
 	tlb_init(cpu);
 	cpu_cache_init();
 }
 
-/* Install CPU exception handler */
-void set_handler(unsigned long offset, void *addr, unsigned long size)
-{
-	memcpy((void *)(eentry + offset), addr, size);
-	local_flush_icache_range(eentry + offset, eentry + offset + size);
-}
-
 static const char panic_null_cerr[] =
 	"Trying to set NULL cache error exception handler\n";
 
@@ -741,20 +855,20 @@ void __init trap_init(void)
 
 	/* Set interrupt vector handler */
 	for (i = EXCCODE_INT_START; i < EXCCODE_INT_END; i++)
-		set_handler(i * VECSIZE, handle_vint, VECSIZE);
-
-	set_handler(EXCCODE_ADE * VECSIZE, handle_ade, VECSIZE);
-	set_handler(EXCCODE_ALE * VECSIZE, handle_ale, VECSIZE);
-	set_handler(EXCCODE_SYS * VECSIZE, handle_sys, VECSIZE);
-	set_handler(EXCCODE_BP * VECSIZE, handle_bp, VECSIZE);
-	set_handler(EXCCODE_INE * VECSIZE, handle_ri, VECSIZE);
-	set_handler(EXCCODE_IPE * VECSIZE, handle_ri, VECSIZE);
-	set_handler(EXCCODE_FPDIS * VECSIZE, handle_fpu, VECSIZE);
-	set_handler(EXCCODE_LSXDIS * VECSIZE, handle_lsx, VECSIZE);
-	set_handler(EXCCODE_LASXDIS * VECSIZE, handle_lasx, VECSIZE);
-	set_handler(EXCCODE_FPE * VECSIZE, handle_fpe, VECSIZE);
-	set_handler(EXCCODE_BTDIS * VECSIZE, handle_lbt, VECSIZE);
-	set_handler(EXCCODE_WATCH * VECSIZE, handle_watch, VECSIZE);
+		set_handler(i, handle_vint);
+
+	set_handler(EXCCODE_ADE, handle_ade);
+	set_handler(EXCCODE_ALE, handle_ale);
+	set_handler(EXCCODE_SYS, handle_sys);
+	set_handler(EXCCODE_BP, handle_bp);
+	set_handler(EXCCODE_INE, handle_ri);
+	set_handler(EXCCODE_IPE, handle_ri);
+	set_handler(EXCCODE_FPDIS, handle_fpu);
+	set_handler(EXCCODE_LSXDIS, handle_lsx);
+	set_handler(EXCCODE_LASXDIS, handle_lasx);
+	set_handler(EXCCODE_FPE, handle_fpe);
+	set_handler(EXCCODE_BTDIS, handle_lbt);
+	set_handler(EXCCODE_WATCH, handle_watch);
 
 	cache_error_setup();
 
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 8bad6b0cff59..6f70aab7202a 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -253,7 +253,6 @@ static void output_pgtable_bits_defines(void)
 #ifdef CONFIG_NUMA
 unsigned long pcpu_handlers[NR_CPUS];
 #endif
-extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 
 void setup_tlb_handler(int cpu)
 {
@@ -264,19 +263,20 @@ void setup_tlb_handler(int cpu)
 	if (cpu == 0) {
 		memcpy((void *)tlbrentry, handle_tlb_refill, 0x80);
 		local_flush_icache_range(tlbrentry, tlbrentry + 0x80);
-		set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_load, VECSIZE);
-		set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_load, VECSIZE);
-		set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_store, VECSIZE);
-		set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_modify, VECSIZE);
-		set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, VECSIZE);
-		set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, VECSIZE);
-		set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, VECSIZE);
+		set_handler(EXCCODE_TLBI, handle_tlb_load);
+		set_handler(EXCCODE_TLBL, handle_tlb_load);
+		set_handler(EXCCODE_TLBS, handle_tlb_store);
+		set_handler(EXCCODE_TLBM, handle_tlb_modify);
+		set_handler(EXCCODE_TLBNR, handle_tlb_protect);
+		set_handler(EXCCODE_TLBNX, handle_tlb_protect);
+		set_handler(EXCCODE_TLBPE, handle_tlb_protect);
 	}
 #ifdef CONFIG_NUMA
 	else {
 		void *addr;
+		unsigned long addr_ul;
 		struct page *page;
-		const int vec_sz = sizeof(exception_handlers);
+		const int vec_sz = VECSIZE * 128;
 
 		if (pcpu_handlers[cpu])
 			return;
@@ -286,8 +286,11 @@ void setup_tlb_handler(int cpu)
 			return;
 
 		addr = page_address(page);
+		addr_ul = (unsigned long)addr;
 		pcpu_handlers[cpu] = (unsigned long)addr;
-		memcpy((void *)addr, (void *)eentry, vec_sz);
+		memcpy(addr, (void *)eentry, vec_sz);
+		for (unsigned long i = 0; i < 128; i++)
+			reloc_handler(addr_ul + i * VECSIZE, eentry_reloc[i]);
 		local_flush_icache_range((unsigned long)addr, (unsigned long)addr + vec_sz);
 		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
 		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 3dd2a9615cd9..044c2190771a 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -39,11 +39,21 @@ SYM_FUNC_START(handle_tlb_protect)
 	move		a1, zero
 	csrrd		a2, LOONGARCH_CSR_BADV
 	REG_S		a2, sp, PT_BVADDR
-	la.abs		t0, do_page_fault
+1:	la.pcrel	t0, t1, do_page_fault
 	jirl		ra, t0, 0
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_tlb_protect)
 
+SYM_DATA_START(rel_handle_tlb_protect)
+	LONG	2
+
+	LONG	514b - handle_tlb_protect
+	LONG	kernelsp
+
+	LONG	1b - handle_tlb_protect
+	LONG	do_page_fault
+SYM_DATA_END(rel_handle_tlb_protect)
+
 SYM_FUNC_START(handle_tlb_load)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
@@ -115,7 +125,8 @@ smp_pgtable_change_load:
 
 #ifdef CONFIG_64BIT
 vmalloc_load:
-	la.abs		t1, swapper_pg_dir
+	/* The first insn of vmalloc_done_load overwrites ra */
+1:	la.pcrel	t1, ra, swapper_pg_dir
 	b		vmalloc_done_load
 #endif
 
@@ -186,10 +197,24 @@ tlb_huge_update_load:
 nopage_tlb_load:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_0
+2:	la.pcrel	t0, t1, tlb_do_page_fault_0
 	jr		t0
 SYM_FUNC_END(handle_tlb_load)
 
+SYM_DATA_START(rel_handle_tlb_load)
+#ifdef CONFIG_64BIT
+	LONG	2
+
+	LONG	1b - handle_tlb_load
+	LONG	swapper_pg_dir
+#else
+	LONG	1
+#endif
+
+	LONG	2b - handle_tlb_load
+	LONG	tlb_do_page_fault_0
+SYM_DATA_END(rel_handle_tlb_load)
+
 SYM_FUNC_START(handle_tlb_store)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
@@ -262,7 +287,8 @@ smp_pgtable_change_store:
 
 #ifdef CONFIG_64BIT
 vmalloc_store:
-	la.abs		t1, swapper_pg_dir
+	/* The first insn of vmalloc_done_store overwrites ra */
+1:	la.pcrel	t1, ra, swapper_pg_dir
 	b		vmalloc_done_store
 #endif
 
@@ -335,10 +361,24 @@ tlb_huge_update_store:
 nopage_tlb_store:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_1
+2:	la.pcrel	t0, t1, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_store)
 
+SYM_DATA_START(rel_handle_tlb_store)
+#ifdef CONFIG_64BIT
+	LONG	2
+
+	LONG	1b - handle_tlb_store
+	LONG	swapper_pg_dir
+#else
+	LONG	1
+#endif
+
+	LONG	2b - handle_tlb_store
+	LONG	tlb_do_page_fault_1
+SYM_DATA_END(rel_handle_tlb_store)
+
 SYM_FUNC_START(handle_tlb_modify)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
@@ -410,7 +450,8 @@ smp_pgtable_change_modify:
 
 #ifdef CONFIG_64BIT
 vmalloc_modify:
-	la.abs		t1, swapper_pg_dir
+	/* The first insn of vmalloc_done_modify overwrites ra */
+1:	la.pcrel	t1, ra, swapper_pg_dir
 	b		vmalloc_done_modify
 #endif
 
@@ -482,10 +523,24 @@ tlb_huge_update_modify:
 nopage_tlb_modify:
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
-	la.abs		t0, tlb_do_page_fault_1
+2:	la.pcrel	t0, t1, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_modify)
 
+SYM_DATA_START(rel_handle_tlb_modify)
+#ifdef CONFIG_64BIT
+	LONG	2
+
+	LONG	1b - handle_tlb_modify
+	LONG	swapper_pg_dir
+#else
+	LONG	1
+#endif
+
+	LONG	2b - handle_tlb_modify
+	LONG	tlb_do_page_fault_1
+SYM_DATA_END(rel_handle_tlb_modify)
+
 SYM_FUNC_START(handle_tlb_refill)
 	csrwr		t0, LOONGARCH_CSR_TLBRSAVE
 	csrrd		t0, LOONGARCH_CSR_PGD
-- 
2.39.1

