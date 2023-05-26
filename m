Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415A5711F23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbjEZFQY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241876AbjEZFQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:16:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08048194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:13 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKnHgQ028990
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt9vqn5mb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:12 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 22:16:11 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 5683B1E38AFFF; Thu, 25 May 2023 22:15:57 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <mcgrof@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <x86@kernel.org>, <rppt@kernel.org>,
        <kent.overstreet@linux.dev>, Song Liu <song@kernel.org>
Subject: [PATCH 3/3] x86/module: Use module_alloc_type
Date:   Thu, 25 May 2023 22:15:29 -0700
Message-ID: <20230526051529.3387103-4-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526051529.3387103-1-song@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HDUxmKsIqlZxsy9vF-pA9QI_Q1I5O0pN
X-Proofpoint-ORIG-GUID: HDUxmKsIqlZxsy9vF-pA9QI_Q1I5O0pN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable module_alloc_type to

1. Allocate ROX data for MOD_TEXT and MOD_INIT_TEXT;
2. Allocate RO data for MOD_RODATA and MOD_INIT_RODATA;
3. Allocate RW data for other types.

Also, update users of module_alloc_type (BPF, ftrace, kprobe) to handle
these restrictions.

arch_prepare_bpf_trampoline() cannot jit directly into module memory yet,
so we have to use module_memory_force_[un]protect() in it.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/kernel/alternative.c  |  37 +++++++----
 arch/x86/kernel/ftrace.c       |  44 +++++++------
 arch/x86/kernel/kprobes/core.c |   8 +--
 arch/x86/kernel/module.c       | 114 +++++++++++++++++++++++----------
 arch/x86/kernel/unwind_orc.c   |  13 ++--
 arch/x86/net/bpf_jit_comp.c    |  22 +++++--
 kernel/bpf/core.c              |   6 +-
 7 files changed, 160 insertions(+), 84 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d93..bb4e6c3225bf 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -122,6 +122,17 @@ extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
 
+static void __init_or_module do_text_poke(void *addr, const void *opcode, size_t len)
+{
+	if (system_state < SYSTEM_RUNNING) {
+		text_poke_early(addr, opcode, len);
+	} else {
+		mutex_lock(&text_mutex);
+		text_poke(addr, opcode, len);
+		mutex_unlock(&text_mutex);
+	}
+}
+
 /*
  * Are we looking at a near JMP with a 1 or 4-byte displacement.
  */
@@ -331,7 +342,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		do_text_poke(instr, insn_buff, insn_buff_sz);
 
 next:
 		optimize_nops(instr, a->instrlen);
@@ -564,7 +575,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 			optimize_nops(bytes, len);
 			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
-			text_poke_early(addr, bytes, len);
+			do_text_poke(addr, bytes, len);
 		}
 	}
 }
@@ -638,7 +649,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 		if (len == insn.length) {
 			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
-			text_poke_early(addr, bytes, len);
+			do_text_poke(addr, bytes, len);
 		}
 	}
 }
@@ -674,7 +685,7 @@ static void poison_endbr(void *addr, bool warn)
 	 */
 	DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
 	DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
-	text_poke_early(addr, &poison, 4);
+	do_text_poke(addr, &poison, 4);
 }
 
 /*
@@ -869,7 +880,7 @@ static int cfi_disable_callers(s32 *start, s32 *end)
 		if (!hash) /* nocfi callers */
 			continue;
 
-		text_poke_early(addr, jmp, 2);
+		do_text_poke(addr, jmp, 2);
 	}
 
 	return 0;
@@ -892,7 +903,7 @@ static int cfi_enable_callers(s32 *start, s32 *end)
 		if (!hash) /* nocfi callers */
 			continue;
 
-		text_poke_early(addr, mov, 2);
+		do_text_poke(addr, mov, 2);
 	}
 
 	return 0;
@@ -913,7 +924,7 @@ static int cfi_rand_preamble(s32 *start, s32 *end)
 			return -EINVAL;
 
 		hash = cfi_rehash(hash);
-		text_poke_early(addr + 1, &hash, 4);
+		do_text_poke(addr + 1, &hash, 4);
 	}
 
 	return 0;
@@ -932,9 +943,9 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 			 addr, addr, 5, addr))
 			return -EINVAL;
 
-		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
+		do_text_poke(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
-		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
+		do_text_poke(addr + fineibt_preamble_hash, &hash, 4);
 	}
 
 	return 0;
@@ -953,7 +964,7 @@ static int cfi_rand_callers(s32 *start, s32 *end)
 		hash = decode_caller_hash(addr);
 		if (hash) {
 			hash = -cfi_rehash(hash);
-			text_poke_early(addr + 2, &hash, 4);
+			do_text_poke(addr + 2, &hash, 4);
 		}
 	}
 
@@ -971,9 +982,9 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 		addr -= fineibt_caller_size;
 		hash = decode_caller_hash(addr);
 		if (hash) {
-			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
+			do_text_poke(addr, fineibt_caller_start, fineibt_caller_size);
 			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
-			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+			do_text_poke(addr + fineibt_caller_hash, &hash, 4);
 		}
 		/* rely on apply_retpolines() */
 	}
@@ -1243,7 +1254,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 
 		/* Pad the rest with nops */
 		add_nops(insn_buff + used, p->len - used);
-		text_poke_early(p->instr, insn_buff, p->len);
+		do_text_poke(p->instr, insn_buff, p->len);
 	}
 }
 extern struct paravirt_patch_site __start_parainstructions[],
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 5e7ead52cfdb..a41af9e49afb 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -119,8 +119,11 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 	/* replace the text with the new text */
 	if (ftrace_poke_late)
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
-	else
-		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
+	else {
+		mutex_lock(&text_mutex);
+		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
+		mutex_unlock(&text_mutex);
+	}
 	return 0;
 }
 
@@ -265,11 +268,11 @@ void arch_ftrace_update_code(int command)
 /* Module allocation simplifies allocating memory for code */
 static inline void *alloc_tramp(unsigned long size)
 {
-	return module_alloc(size);
+	return module_alloc_type(size, MOD_TEXT);
 }
 static inline void tramp_free(void *tramp)
 {
-	module_memfree(tramp);
+	module_memfree_type(tramp, MOD_TEXT);
 }
 #else
 /* Trampolines can only be created if modules are supported */
@@ -319,7 +322,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long call_offset;
 	unsigned long jmp_offset;
 	unsigned long offset;
-	unsigned long npages;
 	unsigned long size;
 	unsigned long *ptr;
 	void *trampoline;
@@ -328,7 +330,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
 	union ftrace_op_code_union op_ptr;
-	int ret;
 
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 		start_offset = (unsigned long)ftrace_regs_caller;
@@ -356,18 +357,16 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		return 0;
 
 	*tramp_size = size + RET_SIZE + sizeof(void *);
-	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
-	ret = copy_from_kernel_nofault(trampoline, (void *)start_offset, size);
-	if (WARN_ON(ret < 0))
+	if (WARN_ON(text_poke_copy(trampoline, (void *)start_offset, size) == NULL))
 		goto fail;
 
 	ip = trampoline + size;
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
 		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
-		memcpy(ip, retq, sizeof(retq));
+		text_poke_copy(ip, retq, sizeof(retq));
 
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
@@ -375,8 +374,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		ret = copy_from_kernel_nofault(ip, x86_nops[2], 2);
-		if (ret < 0)
+		if (text_poke_copy(ip, x86_nops[2], 2) == NULL)
 			goto fail;
 	}
 
@@ -389,7 +387,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 */
 
 	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
-	*ptr = (unsigned long)ops;
+	text_poke_copy(ptr, &ops, sizeof(unsigned long));
 
 	op_offset -= start_offset;
 	memcpy(&op_ptr, trampoline + op_offset, OP_REF_SIZE);
@@ -405,7 +403,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	op_ptr.offset = offset;
 
 	/* put in the new offset to the ftrace_ops */
-	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
+	text_poke_copy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
 	/* put in the call to the function */
 	mutex_lock(&text_mutex);
@@ -415,15 +413,14 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the depth accounting before the call already.
 	 */
 	dest = ftrace_ops_get_func(ops);
-	memcpy(trampoline + call_offset,
-	       text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
-	       CALL_INSN_SIZE);
+	text_poke_copy_locked(trampoline + call_offset,
+	      text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
+	      CALL_INSN_SIZE, false);
 	mutex_unlock(&text_mutex);
 
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
-	set_memory_rox((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline);
@@ -667,4 +664,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 }
 #endif
 
+void ftrace_swap_func(void *a, void *b, int n)
+{
+	unsigned long t;
+
+	WARN_ON_ONCE(n != sizeof(t));
+
+	t = *((unsigned long *)a);
+	text_poke_copy(a, b, sizeof(t));
+	text_poke_copy(b, &t, sizeof(t));
+}
+
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f7f6042eb7e6..96f56e663cbe 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -414,16 +414,10 @@ void *alloc_insn_page(void)
 {
 	void *page;
 
-	page = module_alloc(PAGE_SIZE);
+	page = module_alloc_type(PAGE_SIZE, MOD_TEXT);
 	if (!page)
 		return NULL;
 
-	/*
-	 * TODO: Once additional kernel code protection mechanisms are set, ensure
-	 * that the page was not maliciously altered and it is still zeroed.
-	 */
-	set_memory_rox((unsigned long)page, 1);
-
 	return page;
 }
 
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b05f62ee2344..80c2ee1a4f7f 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -67,24 +67,82 @@ static unsigned long int get_module_load_offset(void)
 
 void *module_alloc(unsigned long size)
 {
-	gfp_t gfp_mask = GFP_KERNEL;
-	void *p;
-
-	if (PAGE_ALIGN(size) > MODULES_LEN)
-		return NULL;
-
-	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				 MODULES_VADDR + get_module_load_offset(),
-				 MODULES_END, gfp_mask, PAGE_KERNEL,
-				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
-				 NUMA_NO_NODE, __builtin_return_address(0));
+	WARN(true, "x86 should not use module_alloc\n");
+	return NULL;
+}
 
-	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
-		vfree(p);
-		return NULL;
-	}
+static void *x86_module_invalidate_text(void *ptr, size_t len)
+{
+	return text_poke_set(ptr, 0xcc, len);
+}
 
-	return p;
+static struct mod_type_allocator x86_mod_allocator_text = {
+	.params = {
+		.flags		= MOD_ALLOC_KASAN_MODULE_SHADOW | MOD_ALLOC_SET_MEMORY,
+		.granularity	= PAGE_SIZE,
+		.alignment	= MODULE_ALIGN,
+		.fill		= text_poke_copy,
+		.invalidate	= x86_module_invalidate_text,
+	},
+};
+
+static struct mod_type_allocator x86_mod_allocator_rw_data = {
+	.params = {
+		.flags		= MOD_ALLOC_KASAN_MODULE_SHADOW,
+		.granularity	= PAGE_SIZE,
+		.alignment	= MODULE_ALIGN,
+	},
+};
+
+static struct mod_type_allocator x86_mod_allocator_ro_data = {
+	.params = {
+		.flags		= MOD_ALLOC_KASAN_MODULE_SHADOW | MOD_ALLOC_SET_MEMORY,
+		.granularity	= PAGE_SIZE,
+		.alignment	= MODULE_ALIGN,
+		.fill		= text_poke_copy,
+		.invalidate	= x86_module_invalidate_text,
+	},
+};
+
+void __init module_alloc_type_init(struct mod_allocators *allocators)
+{
+	struct mod_alloc_params *params = &x86_mod_allocator_text.params;
+	struct vmalloc_params *vmp = &params->vmp[0];
+
+	vmp->start = MODULES_VADDR + get_module_load_offset();
+	vmp->end = MODULES_END;
+	vmp->gfp_mask = GFP_KERNEL;
+	vmp->pgprot = PAGE_KERNEL_EXEC;
+	vmp->vm_flags = VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK |
+		VM_ALLOW_HUGE_VMAP;
+
+	for_class_mod_mem_type(type, text)
+		allocators->types[type] = &x86_mod_allocator_text;
+
+	params = &x86_mod_allocator_rw_data.params;
+	vmp = &params->vmp[0];
+
+	vmp->start = MODULES_VADDR + get_module_load_offset();
+	vmp->end = MODULES_END;
+	vmp->gfp_mask = GFP_KERNEL;
+	vmp->pgprot = PAGE_KERNEL_EXEC;
+	vmp->vm_flags = VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK;
+
+	allocators->types[MOD_DATA] = &x86_mod_allocator_rw_data;
+	allocators->types[MOD_INIT_DATA] = &x86_mod_allocator_rw_data;
+	allocators->types[MOD_RO_AFTER_INIT] = &x86_mod_allocator_rw_data;
+
+	params = &x86_mod_allocator_ro_data.params;
+	vmp = &params->vmp[0];
+
+	vmp->start = MODULES_VADDR + get_module_load_offset();
+	vmp->end = MODULES_END;
+	vmp->gfp_mask = GFP_KERNEL;
+	vmp->pgprot = PAGE_KERNEL_EXEC;
+	vmp->vm_flags = VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK;
+
+	allocators->types[MOD_RODATA] = &x86_mod_allocator_ro_data;
+	allocators->types[MOD_INIT_RODATA] = &x86_mod_allocator_ro_data;
 }
 
 #ifdef CONFIG_X86_32
@@ -134,7 +192,6 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 		   unsigned int symindex,
 		   unsigned int relsec,
 		   struct module *me,
-		   void *(*write)(void *dest, const void *src, size_t len),
 		   bool apply)
 {
 	unsigned int i;
@@ -202,14 +259,14 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 				       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
 				return -ENOEXEC;
 			}
-			write(loc, &val, size);
+			text_poke(loc, &val, size);
 		} else {
 			if (memcmp(loc, &val, size)) {
 				pr_warn("x86/modules: Invalid relocation target, existing value does not match expected value for type %d, loc %p, val %Lx\n",
 					(int)ELF64_R_TYPE(rel[i].r_info), loc, val);
 				return -ENOEXEC;
 			}
-			write(loc, &zero, size);
+			text_poke(loc, &zero, size);
 		}
 	}
 	return 0;
@@ -230,22 +287,11 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
 			      bool apply)
 {
 	int ret;
-	bool early = me->state == MODULE_STATE_UNFORMED;
-	void *(*write)(void *, const void *, size_t) = memcpy;
-
-	if (!early) {
-		write = text_poke;
-		mutex_lock(&text_mutex);
-	}
-
-	ret = __write_relocate_add(sechdrs, strtab, symindex, relsec, me,
-				   write, apply);
-
-	if (!early) {
-		text_poke_sync();
-		mutex_unlock(&text_mutex);
-	}
 
+	mutex_lock(&text_mutex);
+	ret = __write_relocate_add(sechdrs, strtab, symindex, relsec, me, apply);
+	text_poke_sync();
+	mutex_unlock(&text_mutex);
 	return ret;
 }
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 3ac50b7298d1..264188ec50c9 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,6 +7,7 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
+#include <asm/text-patching.h>
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
@@ -222,18 +223,22 @@ static void orc_sort_swap(void *_a, void *_b, int size)
 	struct orc_entry orc_tmp;
 	int *a = _a, *b = _b, tmp;
 	int delta = _b - _a;
+	int val;
 
 	/* Swap the .orc_unwind_ip entries: */
 	tmp = *a;
-	*a = *b + delta;
-	*b = tmp - delta;
+	val = *b + delta;
+	text_poke_copy(a, &val, sizeof(val));
+	val = tmp - delta;
+	text_poke_copy(b, &val, sizeof(val));
 
 	/* Swap the corresponding .orc_unwind entries: */
 	orc_a = cur_orc_table + (a - cur_orc_ip_table);
 	orc_b = cur_orc_table + (b - cur_orc_ip_table);
 	orc_tmp = *orc_a;
-	*orc_a = *orc_b;
-	*orc_b = orc_tmp;
+
+	text_poke_copy(orc_a, orc_b, sizeof(*orc_b));
+	text_poke_copy(orc_b, &orc_tmp, sizeof(orc_tmp));
 }
 
 static int orc_sort_cmp(const void *_a, const void *_b)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..846228fb12f2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/moduleloader.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -226,7 +227,7 @@ static u8 simple_alu_opcodes[] = {
 static void jit_fill_hole(void *area, unsigned int size)
 {
 	/* Fill whole space with INT3 instructions */
-	memset(area, 0xcc, size);
+	text_poke_set(area, 0xcc, size);
 }
 
 int bpf_arch_text_invalidate(void *dst, size_t len)
@@ -2202,6 +2203,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		orig_call += X86_PATCH_SIZE;
 	}
 
+	module_memory_force_unprotect((void *)((unsigned long)image & PAGE_MASK),
+				      PAGE_SIZE, MOD_TEXT);
 	prog = image;
 
 	EMIT_ENDBR();
@@ -2238,20 +2241,24 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
 		if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
 			ret = -EINVAL;
-			goto cleanup;
+			goto reprotect_memory;
 		}
 	}
 
 	if (fentry->nr_links)
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
-			return -EINVAL;
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET)) {
+			ret = -EINVAL;
+			goto reprotect_memory;
+		}
 
 	if (fmod_ret->nr_links) {
 		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
 				   GFP_KERNEL);
-		if (!branches)
-			return -ENOMEM;
+		if (!branches) {
+			ret =  -ENOMEM;
+			goto reprotect_memory;
+		}
 
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
 				       run_ctx_off, branches)) {
@@ -2336,6 +2343,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 cleanup:
 	kfree(branches);
+reprotect_memory:
+	module_memory_force_protect((void *)((unsigned long)image & PAGE_MASK),
+				    PAGE_SIZE, MOD_TEXT);
 	return ret;
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4c989a8fe8b8..90f09218d30f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1092,8 +1092,10 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 		return NULL;
 	}
 
-	/* Fill space with illegal/arch-dep instructions. */
-	bpf_fill_ill_insns(*rw_header, size);
+	/* bpf_fill_ill_insns is used to write to RO memory, so we cannot
+	 * use it on rw_header, use memset(0) instead.
+	 */
+	memset(*rw_header, 0, size);
 	(*rw_header)->size = size;
 
 	hole = min_t(unsigned int, size - (proglen + sizeof(*ro_header)),
-- 
2.34.1

