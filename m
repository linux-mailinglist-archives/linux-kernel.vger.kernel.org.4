Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24375BA4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIPC4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIPCzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:55:52 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B70D99266
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:55:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbWul5SNj08gaAA--.56059S9;
        Fri, 16 Sep 2022 10:55:42 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] LoongArch: modules/ftrace: Initialize PLT at load time
Date:   Fri, 16 Sep 2022 10:55:30 +0800
Message-Id: <20220916025533.18771-8-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220916025533.18771-1-zhangqing@loongson.cn>
References: <20220916025533.18771-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbWul5SNj08gaAA--.56059S9
X-Coremail-Antispam: 1UD129KBjvJXoWfGF47Jr13WF4rZFy8Gw1kGrg_yoWkGrWfpF
        yqyrn5GrWUGFn3Wa409rn8ur15GFZ7W34agFW3G342kw42qry5AF10krn0kFyFqws8WayS
        gayfur4j9ay7Xw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEnc
        xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4
        AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
        14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1U
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUyz6zUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To Implement ftrace trampiones through plt entry.

Tested by forcing ftrace_make_call() to use the module PLT, and then
loading up a module after setting up ftrace with:

| echo ":mod:<module-name>" > set_ftrace_filter;
| echo function > current_tracer;
| modprobe <module-name>

Since FTRACE_ADDR/FTRACE_REGS_ADDR is only defined when CONFIG_DYNAMIC_FTRACE
is selected, we wrap its use along with most of module_init_ftrace_plt() with
ifdeffery rather than using IS_ENABLED().

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h     |  4 ++
 arch/loongarch/include/asm/inst.h       |  3 +
 arch/loongarch/include/asm/module.h     |  5 +-
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/ftrace_dyn.c      | 79 +++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c            | 11 ++++
 arch/loongarch/kernel/module-sections.c | 11 ++++
 arch/loongarch/kernel/module.c          | 47 +++++++++++++++
 8 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 5cc13ae48164..807226aad1c0 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -6,6 +6,10 @@
 #ifndef _ASM_LOONGARCH_FTRACE_H
 #define _ASM_LOONGARCH_FTRACE_H
 
+#define FTRACE_PLT_IDX		0
+#define FTRACE_REGS_PLT_IDX	1
+#define NR_FTRACE_PLTS		2
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index f4a12f872a71..5a1aa977ae20 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -15,10 +15,12 @@
 
 #define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
 #define ADDR_IMMMASK_LU32ID	0x000FFFFF00000000
+#define ADDR_IMMMASK_LU12IW	0x00000000FFFFF000
 #define ADDR_IMMMASK_ADDU16ID	0x00000000FFFF0000
 
 #define ADDR_IMMSHIFT_LU52ID	52
 #define ADDR_IMMSHIFT_LU32ID	32
+#define ADDR_IMMSHIFT_LU12IW	12
 #define ADDR_IMMSHIFT_ADDU16ID	16
 
 #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
@@ -346,6 +348,7 @@ u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
 			enum loongarch_gpr rk);
 u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
 
+u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index b29b19a46f42..a311cfec2b23 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -20,6 +20,9 @@ struct mod_arch_specific {
 	struct mod_section got;
 	struct mod_section plt;
 	struct mod_section plt_idx;
+
+	/* for CONFIG_DYNAMIC_FTRACE */
+	struct plt_entry *ftrace_trampolines;
 };
 
 struct got_entry {
@@ -49,7 +52,7 @@ static inline struct plt_entry emit_plt_entry(unsigned long val)
 {
 	u32 lu12iw, lu32id, lu52id, jirl;
 
-	lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | LOONGARCH_GPR_T1);
+	lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
 	lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
 	lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
 	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
index a3d1bc0fcc72..438f09d4ccf4 100644
--- a/arch/loongarch/include/asm/module.lds.h
+++ b/arch/loongarch/include/asm/module.lds.h
@@ -5,4 +5,5 @@ SECTIONS {
 	.got : { BYTE(0) }
 	.plt : { BYTE(0) }
 	.plt.idx : { BYTE(0) }
+	.ftrace_trampoline : { BYTE(0) }
 }
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index f538829312d7..dd37185d446e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/inst.h>
+#include <asm/module.h>
 
 static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
 			      bool validate)
@@ -72,12 +73,63 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+static inline int __get_mod(struct module **mod, unsigned long addr)
+{
+	preempt_disable();
+	*mod = __module_text_address(addr);
+	preempt_enable();
+
+	if (WARN_ON(!(*mod)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+{
+	struct plt_entry *plt = mod->arch.ftrace_trampolines;
+
+	if (addr == FTRACE_ADDR)
+		return &plt[FTRACE_PLT_IDX];
+	if (addr == FTRACE_REGS_ADDR &&
+			IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return &plt[FTRACE_REGS_PLT_IDX];
+
+	return NULL;
+}
+
+static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
+{
+	struct plt_entry *plt;
+
+	plt = get_ftrace_plt(mod, addr);
+	if (!plt) {
+		pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
+		return -EINVAL;
+	}
+
+	return (unsigned long)plt;
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long pc;
+	long offset;
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+	}
 
 	old = larch_insn_gen_nop();
 	new = larch_insn_gen_bl(pc, addr);
@@ -89,9 +141,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	unsigned long pc;
+	long offset;
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+	}
 
 	new = larch_insn_gen_nop();
 	old = larch_insn_gen_bl(pc, addr);
@@ -108,6 +173,20 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+
+		old_addr = get_plt_addr(mod, old_addr);
+	}
 
 	old = larch_insn_gen_bl(pc, old_addr);
 	new = larch_insn_gen_bl(pc, addr);
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 2d2e942eb06a..0d6bd7000ba6 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -103,6 +103,17 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 	return insn.word;
 }
 
+u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
+{
+	union loongarch_instruction insn;
+
+	insn.reg1i20_format.opcode = lu12iw_op;
+	insn.reg1i20_format.rd = rd;
+	insn.reg1i20_format.immediate = imm;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index d296a70b758f..bd1a96691c98 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
@@ -103,6 +104,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
 	unsigned int i, num_plts = 0, num_gots = 0;
+	Elf_Shdr *tramp = NULL;
 
 	/*
 	 * Find the empty .plt sections.
@@ -114,6 +116,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.plt.shdr = sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
 			mod->arch.plt_idx.shdr = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".ftrace_trampoline"))
+			tramp = sechdrs + i;
 	}
 
 	if (!mod->arch.got.shdr) {
@@ -166,5 +170,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.plt_idx.num_entries = 0;
 	mod->arch.plt_idx.max_entries = num_plts;
 
+	if (tramp) {
+		tramp->sh_type = SHT_NOBITS;
+		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+		tramp->sh_addralign = __alignof__(struct plt_entry);
+		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
+	}
+
 	return 0;
 }
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 097595b2fc14..e036b1ebf98e 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -10,6 +10,7 @@
 
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
@@ -17,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <asm/inst.h>
 
 static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
 {
@@ -456,3 +458,48 @@ void *module_alloc(unsigned long size)
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
 }
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				    const char *name)
+{
+	const Elf_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+#endif
+
+static int module_init_ftrace_plt(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				  struct module *mod)
+{
+#ifdef CONFIG_DYNAMIC_FTRACE
+	const Elf_Shdr *s;
+	struct plt_entry *ftrace_plts;
+
+	s = find_section(hdr, sechdrs, ".ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	ftrace_plts = (void *)s->sh_addr;
+
+	ftrace_plts[FTRACE_PLT_IDX] = emit_plt_entry(FTRACE_ADDR);
+
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		ftrace_plts[FTRACE_REGS_PLT_IDX] = emit_plt_entry(FTRACE_REGS_ADDR);
+
+	mod->arch.ftrace_trampolines = ftrace_plts;
+#endif
+	return 0;
+}
+
+int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mod)
+{
+	return module_init_ftrace_plt(hdr, sechdrs, mod);
+
+}
-- 
2.36.1

