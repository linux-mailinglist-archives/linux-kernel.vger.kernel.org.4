Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8521F6A5417
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjB1IEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjB1IEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:04:07 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3D37234DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:03:43 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxJYxatf1j+GUGAA--.6516S3;
        Tue, 28 Feb 2023 16:03:38 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB707tf1jb3tAAA--.49681S6;
        Tue, 28 Feb 2023 16:03:32 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] LoongArch: Drop pernode exception handlers
Date:   Tue, 28 Feb 2023 16:02:55 +0800
Message-Id: <20230228080257.28807-5-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230228080257.28807-1-hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB707tf1jb3tAAA--.49681S6
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KryfuFyDtr4xWFW5Aw1xGrg_yoW8Jr18to
        Wava1jyr1rGw47t343t3Zxta48ZF9IyrWkC3sayan3Wr9rAFyUWw4UKFn8t3ySgwn5Jryx
        Ca43Wrn8Zas7Xr1kn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gAw7UUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1, set the value of CSR.EENTRY to &__ex_handlers.
2, set the value of CSR.TLBRENTRY to &__tlbr_entry.
3, set the value of CSR.MERRENTRY to &__ex_handlers.
Then, we can drop the pernode exception handlers.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/setup.h      |  7 ---
 arch/loongarch/include/asm/traps.h      | 29 ++++++++++
 arch/loongarch/kernel/genex.S           |  8 ---
 arch/loongarch/kernel/traps.c           | 74 +------------------------
 arch/loongarch/kernel/unwind_prologue.c | 62 +--------------------
 arch/loongarch/mm/cache.c               |  6 --
 arch/loongarch/mm/tlb.c                 | 40 -------------
 arch/loongarch/power/suspend.c          |  5 +-
 8 files changed, 33 insertions(+), 198 deletions(-)

diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index be05c0e706a2..4074225339ec 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -9,17 +9,10 @@
 #include <linux/types.h>
 #include <uapi/asm/setup.h>
 
-#define VECSIZE 0x200
-
-extern unsigned long eentry;
-extern unsigned long tlbrentry;
 extern char init_command_line[COMMAND_LINE_SIZE];
 extern void tlb_init(int cpu);
 extern void cpu_cache_init(void);
-extern void cache_error_setup(void);
 extern void per_cpu_trap_init(int cpu);
-extern void set_handler(unsigned long offset, void *addr, unsigned long len);
-extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len);
 
 #ifdef CONFIG_RELOCATABLE
 
diff --git a/arch/loongarch/include/asm/traps.h b/arch/loongarch/include/asm/traps.h
index b348d66c16a1..8f276253f145 100644
--- a/arch/loongarch/include/asm/traps.h
+++ b/arch/loongarch/include/asm/traps.h
@@ -34,6 +34,35 @@
 	.pushsection .tlbrhandler, "ax";			\
 	__VA_ARGS__;						\
 	.popsection;
+
+#else /* __ASSEMBLY__ */
+
+#define VECSIZE	0x200
+extern void *__ex_handlers;
+extern void *__tlbr_entry;
+
+static inline void set_eentry(void *entry)
+{
+	csr_write64((unsigned long)entry, LOONGARCH_CSR_EENTRY);
+}
+
+static inline void set_tlbrentry(void *entry)
+{
+	csr_write64((unsigned long)entry, LOONGARCH_CSR_TLBRENTRY);
+}
+
+static inline void set_merrentry(void *entry)
+{
+	csr_write64((unsigned long)entry, LOONGARCH_CSR_MERRENTRY);
+}
+
+static inline void configure_exception_vector(void)
+{
+	set_eentry(&__ex_handlers);
+	set_tlbrentry(&__tlbr_entry);
+	set_merrentry(&__ex_handlers);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 86abafc8b95b..256e2e5b83d4 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -72,19 +72,14 @@ SYM_FUNC_END(except_vec_cex)
 	.macro	BUILD_HANDLER exception handler prep
 	.align	5
 SYM_FUNC_START(handle_\exception)
-	666:
 	BACKUP_T0T1
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
 	la_abs	t0, do_\handler
 	jirl	ra, t0, 0
-	668:
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_\exception)
-	.pushsection .rodata
-SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
-	.popsection
 	.endm
 
 SET_EXCEPTION_HANDLER(EXCCODE_SIP0,  _handle_vint)
@@ -123,6 +118,3 @@ SET_EXCEPTION_HANDLER(\i, BUILD_HANDLER reserved\i reserved none)
 .irp i, EXCCODE_NOHND
 SET_EXCEPTION_HANDLER(\i, BUILD_HANDLER reserved\i reserved none)
 .endr
-
-/* Create handle_reserved for temporary build. */
-BUILD_HANDLER reserved reserved none
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index c8b3bd76c941..84ac78bc8c57 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -43,6 +43,7 @@
 #include <asm/siginfo.h>
 #include <asm/stacktrace.h>
 #include <asm/tlb.h>
+#include <asm/traps.h>
 #include <asm/types.h>
 #include <asm/unwind.h>
 
@@ -798,25 +799,8 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 	irqentry_exit(regs, state);
 }
 
-unsigned long eentry;
-unsigned long tlbrentry;
-
-long exception_handlers[VECSIZE * 128 / sizeof(long)] __aligned(SZ_64K);
-
-static void configure_exception_vector(void)
-{
-	eentry    = (unsigned long)exception_handlers;
-	tlbrentry = (unsigned long)exception_handlers + 80*VECSIZE;
-
-	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
-	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
-	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
-}
-
 void per_cpu_trap_init(int cpu)
 {
-	unsigned int i;
-
 	setup_vint_size(VECSIZE);
 
 	configure_exception_vector();
@@ -829,62 +813,6 @@ void per_cpu_trap_init(int cpu)
 	BUG_ON(current->mm);
 	enter_lazy_tlb(&init_mm, current);
 
-	/* Initialise exception handlers */
-	if (cpu == 0)
-		for (i = 0; i < 64; i++)
-			set_handler(i * VECSIZE, handle_reserved, VECSIZE);
-
 	tlb_init(cpu);
 	cpu_cache_init();
 }
-
-/* Install CPU exception handler */
-void set_handler(unsigned long offset, void *addr, unsigned long size)
-{
-	memcpy((void *)(eentry + offset), addr, size);
-	local_flush_icache_range(eentry + offset, eentry + offset + size);
-}
-
-static const char panic_null_cerr[] =
-	"Trying to set NULL cache error exception handler\n";
-
-/*
- * Install uncached CPU exception handler.
- * This is suitable only for the cache error exception which is the only
- * exception handler that is being run uncached.
- */
-void set_merr_handler(unsigned long offset, void *addr, unsigned long size)
-{
-	unsigned long uncached_eentry = TO_UNCACHE(__pa(eentry));
-
-	if (!addr)
-		panic(panic_null_cerr);
-
-	memcpy((void *)(uncached_eentry + offset), addr, size);
-}
-
-void __init trap_init(void)
-{
-	long i;
-
-	/* Set interrupt vector handler */
-	for (i = EXCCODE_INT_START; i < EXCCODE_INT_END; i++)
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
-
-	cache_error_setup();
-
-	local_flush_icache_range(eentry, eentry + 0x400);
-}
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index 9095fde8e55d..de18335c6ba6 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -12,69 +12,9 @@
 #include <asm/setup.h>
 #include <asm/unwind.h>
 
-extern const int unwind_hint_ade;
-extern const int unwind_hint_ale;
-extern const int unwind_hint_bp;
-extern const int unwind_hint_fpe;
-extern const int unwind_hint_fpu;
-extern const int unwind_hint_lsx;
-extern const int unwind_hint_lasx;
-extern const int unwind_hint_lbt;
-extern const int unwind_hint_ri;
-extern const int unwind_hint_watch;
-extern unsigned long eentry;
-#ifdef CONFIG_NUMA
-extern unsigned long pcpu_handlers[NR_CPUS];
-#endif
-
-static inline bool scan_handlers(unsigned long entry_offset)
-{
-	int idx, offset;
-
-	if (entry_offset >= EXCCODE_INT_START * VECSIZE)
-		return false;
-
-	idx = entry_offset / VECSIZE;
-	offset = entry_offset % VECSIZE;
-	switch (idx) {
-	case EXCCODE_ADE:
-		return offset == unwind_hint_ade;
-	case EXCCODE_ALE:
-		return offset == unwind_hint_ale;
-	case EXCCODE_BP:
-		return offset == unwind_hint_bp;
-	case EXCCODE_FPE:
-		return offset == unwind_hint_fpe;
-	case EXCCODE_FPDIS:
-		return offset == unwind_hint_fpu;
-	case EXCCODE_LSXDIS:
-		return offset == unwind_hint_lsx;
-	case EXCCODE_LASXDIS:
-		return offset == unwind_hint_lasx;
-	case EXCCODE_BTDIS:
-		return offset == unwind_hint_lbt;
-	case EXCCODE_INE:
-		return offset == unwind_hint_ri;
-	case EXCCODE_WATCH:
-		return offset == unwind_hint_watch;
-	default:
-		return false;
-	}
-}
-
 static inline bool fix_exception(unsigned long pc)
 {
-#ifdef CONFIG_NUMA
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		if (!pcpu_handlers[cpu])
-			continue;
-		if (scan_handlers(pc - pcpu_handlers[cpu]))
-			return true;
-	}
-#endif
-	return scan_handlers(pc - eentry);
+	return false;
 }
 
 /*
diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 72685a48eaf0..d8e53702d61f 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -25,12 +25,6 @@
 #include <asm/processor.h>
 #include <asm/setup.h>
 
-void cache_error_setup(void)
-{
-	extern char __weak except_vec_cex;
-	set_merr_handler(0x0, &except_vec_cex, 0x80);
-}
-
 /*
  * LoongArch maintains ICache/DCache coherency by hardware,
  * we just need "ibar" to avoid instruction hazard here.
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 8bad6b0cff59..dda35eae1c49 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -250,50 +250,10 @@ static void output_pgtable_bits_defines(void)
 	pr_debug("\n");
 }
 
-#ifdef CONFIG_NUMA
-unsigned long pcpu_handlers[NR_CPUS];
-#endif
-extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
-
 void setup_tlb_handler(int cpu)
 {
 	setup_ptwalker();
 	local_flush_tlb_all();
-
-	/* The tlb handlers are generated only once */
-	if (cpu == 0) {
-		memcpy((void *)tlbrentry, handle_tlb_refill, 0x80);
-		local_flush_icache_range(tlbrentry, tlbrentry + 0x80);
-		set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_load, VECSIZE);
-		set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_load, VECSIZE);
-		set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_store, VECSIZE);
-		set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_modify, VECSIZE);
-		set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, VECSIZE);
-		set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, VECSIZE);
-		set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, VECSIZE);
-	}
-#ifdef CONFIG_NUMA
-	else {
-		void *addr;
-		struct page *page;
-		const int vec_sz = sizeof(exception_handlers);
-
-		if (pcpu_handlers[cpu])
-			return;
-
-		page = alloc_pages_node(cpu_to_node(cpu), GFP_ATOMIC, get_order(vec_sz));
-		if (!page)
-			return;
-
-		addr = page_address(page);
-		pcpu_handlers[cpu] = (unsigned long)addr;
-		memcpy((void *)addr, (void *)eentry, vec_sz);
-		local_flush_icache_range((unsigned long)addr, (unsigned long)addr + vec_sz);
-		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
-		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
-		csr_write64(pcpu_handlers[cpu] + 80*VECSIZE, LOONGARCH_CSR_TLBRENTRY);
-	}
-#endif
 }
 
 void tlb_init(int cpu)
diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
index 5e19733e5e05..b2a10a33b372 100644
--- a/arch/loongarch/power/suspend.c
+++ b/arch/loongarch/power/suspend.c
@@ -14,6 +14,7 @@
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/tlbflush.h>
+#include <asm/traps.h>
 
 u64 loongarch_suspend_addr;
 
@@ -45,9 +46,7 @@ static void arch_common_resume(void)
 	sync_counter();
 	local_flush_tlb_all();
 	csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
-	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
-	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
-	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+	configure_exception_vector();
 
 	csr_write64(saved_regs.pgd, LOONGARCH_CSR_PGDL);
 	csr_write64(saved_regs.kpgd, LOONGARCH_CSR_PGDH);
-- 
2.34.3

