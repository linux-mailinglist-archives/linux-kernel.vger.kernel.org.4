Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF911635230
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiKWIVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiKWIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:21:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B4FC70C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:21:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA83461986
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA63BC433D6;
        Wed, 23 Nov 2022 08:20:57 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] LoongArch: module: Use got/plt section indices for relocations
Date:   Wed, 23 Nov 2022 16:18:20 +0800
Message-Id: <20221123081820.1705216-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of saving a pointer to the .got, .plt and .plt_idx sections to
apply {got,plt}-based relocations, save and use their section indices
instead.

The mod->arch.{core,init}.{got,plt} pointers were problematic for live-
patch because they pointed within temporary section headers (provided by
the module loader via info->sechdrs) that would be freed after module
load. Since livepatch modules may need to apply relocations post-module-
load (for example, to patch a module that is loaded later), using section
indices to offset into the section headers (instead of accessing them
through a saved pointer) allows livepatch modules on LoongArch to pass
in their own copy of the section headers to apply_relocate_add() to
apply delayed relocations.

The method used is same as commit c8ebf64eab743 ("arm64/module: use plt
section indices for relocations").

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/module.h     | 22 +++++-----
 arch/loongarch/kernel/module-sections.c | 54 +++++++++++++------------
 arch/loongarch/kernel/module.c          | 39 ++++++++++++------
 3 files changed, 68 insertions(+), 47 deletions(-)

diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index b29b19a46f42..60dc62a1146e 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -11,7 +11,7 @@
 #define RELA_STACK_DEPTH 16
 
 struct mod_section {
-	Elf_Shdr *shdr;
+	int shndx;
 	int num_entries;
 	int max_entries;
 };
@@ -37,8 +37,8 @@ struct plt_idx_entry {
 	Elf_Addr symbol_addr;
 };
 
-Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val);
-Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Addr val);
+Elf_Addr module_emit_got_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val);
+Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val);
 
 static inline struct got_entry emit_got_entry(Elf_Addr val)
 {
@@ -62,10 +62,10 @@ static inline struct plt_idx_entry emit_plt_idx_entry(unsigned long val)
 	return (struct plt_idx_entry) { val };
 }
 
-static inline int get_plt_idx(unsigned long val, const struct mod_section *sec)
+static inline int get_plt_idx(unsigned long val, Elf_Shdr *sechdrs, const struct mod_section *sec)
 {
 	int i;
-	struct plt_idx_entry *plt_idx = (struct plt_idx_entry *)sec->shdr->sh_addr;
+	struct plt_idx_entry *plt_idx = (struct plt_idx_entry *)sechdrs[sec->shndx].sh_addr;
 
 	for (i = 0; i < sec->num_entries; i++) {
 		if (plt_idx[i].symbol_addr == val)
@@ -76,11 +76,12 @@ static inline int get_plt_idx(unsigned long val, const struct mod_section *sec)
 }
 
 static inline struct plt_entry *get_plt_entry(unsigned long val,
-				      const struct mod_section *sec_plt,
-				      const struct mod_section *sec_plt_idx)
+					      Elf_Shdr *sechdrs,
+					      const struct mod_section *sec_plt,
+					      const struct mod_section *sec_plt_idx)
 {
-	int plt_idx = get_plt_idx(val, sec_plt_idx);
-	struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
+	int plt_idx = get_plt_idx(val, sechdrs, sec_plt_idx);
+	struct plt_entry *plt = (struct plt_entry *)sechdrs[sec_plt->shndx].sh_addr;
 
 	if (plt_idx < 0)
 		return NULL;
@@ -89,10 +90,11 @@ static inline struct plt_entry *get_plt_entry(unsigned long val,
 }
 
 static inline struct got_entry *get_got_entry(Elf_Addr val,
+					      Elf_Shdr *sechdrs,
 					      const struct mod_section *sec)
 {
-	struct got_entry *got = (struct got_entry *)sec->shdr->sh_addr;
 	int i;
+	struct got_entry *got = (struct got_entry *)sechdrs[sec->shndx].sh_addr;
 
 	for (i = 0; i < sec->num_entries; i++)
 		if (got[i].symbol_addr == val)
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index d296a70b758f..13d9a427325a 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -7,17 +7,17 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val)
+Elf_Addr module_emit_got_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val)
 {
 	struct mod_section *got_sec = &mod->arch.got;
 	int i = got_sec->num_entries;
-	struct got_entry *got = get_got_entry(val, got_sec);
+	struct got_entry *got = get_got_entry(val, sechdrs, got_sec);
 
 	if (got)
 		return (Elf_Addr)got;
 
 	/* There is no GOT entry for val yet, create a new one. */
-	got = (struct got_entry *)got_sec->shdr->sh_addr;
+	got = (struct got_entry *)sechdrs[got_sec->shndx].sh_addr;
 	got[i] = emit_got_entry(val);
 
 	got_sec->num_entries++;
@@ -33,12 +33,12 @@ Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val)
 	return (Elf_Addr)&got[i];
 }
 
-Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Addr val)
+Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val)
 {
 	int nr;
 	struct mod_section *plt_sec = &mod->arch.plt;
 	struct mod_section *plt_idx_sec = &mod->arch.plt_idx;
-	struct plt_entry *plt = get_plt_entry(val, plt_sec, plt_idx_sec);
+	struct plt_entry *plt = get_plt_entry(val, sechdrs, plt_sec, plt_idx_sec);
 	struct plt_idx_entry *plt_idx;
 
 	if (plt)
@@ -47,9 +47,9 @@ Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Addr val)
 	nr = plt_sec->num_entries;
 
 	/* There is no duplicate entry, create a new one */
-	plt = (struct plt_entry *)plt_sec->shdr->sh_addr;
+	plt = (struct plt_entry *)sechdrs[plt_sec->shndx].sh_addr;
 	plt[nr] = emit_plt_entry(val);
-	plt_idx = (struct plt_idx_entry *)plt_idx_sec->shdr->sh_addr;
+	plt_idx = (struct plt_idx_entry *)sechdrs[plt_idx_sec->shndx].sh_addr;
 	plt_idx[nr] = emit_plt_idx_entry(val);
 
 	plt_sec->num_entries++;
@@ -103,28 +103,29 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
 	unsigned int i, num_plts = 0, num_gots = 0;
+	Elf_Shdr *got_sec, *plt_sec, *plt_idx_sec;
 
 	/*
 	 * Find the empty .plt sections.
 	 */
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
-			mod->arch.got.shdr = sechdrs + i;
+			mod->arch.got.shndx = i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
-			mod->arch.plt.shdr = sechdrs + i;
+			mod->arch.plt.shndx = i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
-			mod->arch.plt_idx.shdr = sechdrs + i;
+			mod->arch.plt_idx.shndx = i;
 	}
 
-	if (!mod->arch.got.shdr) {
+	if (!mod->arch.got.shndx) {
 		pr_err("%s: module GOT section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
-	if (!mod->arch.plt.shdr) {
+	if (!mod->arch.plt.shndx) {
 		pr_err("%s: module PLT section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
-	if (!mod->arch.plt_idx.shdr) {
+	if (!mod->arch.plt_idx.shndx) {
 		pr_err("%s: module PLT.IDX section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
@@ -145,24 +146,27 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		count_max_entries(relas, num_rela, &num_plts, &num_gots);
 	}
 
-	mod->arch.got.shdr->sh_type = SHT_NOBITS;
-	mod->arch.got.shdr->sh_flags = SHF_ALLOC;
-	mod->arch.got.shdr->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.got.shdr->sh_size = (num_gots + 1) * sizeof(struct got_entry);
+	got_sec = sechdrs + mod->arch.got.shndx;
+	got_sec->sh_type = SHT_NOBITS;
+	got_sec->sh_flags = SHF_ALLOC;
+	got_sec->sh_addralign = L1_CACHE_BYTES;
+	got_sec->sh_size = (num_gots + 1) * sizeof(struct got_entry);
 	mod->arch.got.num_entries = 0;
 	mod->arch.got.max_entries = num_gots;
 
-	mod->arch.plt.shdr->sh_type = SHT_NOBITS;
-	mod->arch.plt.shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.plt.shdr->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.plt.shdr->sh_size = (num_plts + 1) * sizeof(struct plt_entry);
+	plt_sec = sechdrs + mod->arch.plt.shndx;
+	plt_sec->sh_type = SHT_NOBITS;
+	plt_sec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	plt_sec->sh_addralign = L1_CACHE_BYTES;
+	plt_sec->sh_size = (num_plts + 1) * sizeof(struct plt_entry);
 	mod->arch.plt.num_entries = 0;
 	mod->arch.plt.max_entries = num_plts;
 
-	mod->arch.plt_idx.shdr->sh_type = SHT_NOBITS;
-	mod->arch.plt_idx.shdr->sh_flags = SHF_ALLOC;
-	mod->arch.plt_idx.shdr->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.plt_idx.shdr->sh_size = (num_plts + 1) * sizeof(struct plt_idx_entry);
+	plt_idx_sec = sechdrs + mod->arch.plt_idx.shndx;
+	plt_idx_sec->sh_type = SHT_NOBITS;
+	plt_idx_sec->sh_flags = SHF_ALLOC;
+	plt_idx_sec->sh_addralign = L1_CACHE_BYTES;
+	plt_idx_sec->sh_size = (num_plts + 1) * sizeof(struct plt_idx_entry);
 	mod->arch.plt_idx.num_entries = 0;
 	mod->arch.plt_idx.max_entries = num_plts;
 
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 825fcf77f9e7..899dc677cec3 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -99,16 +99,17 @@ static int apply_r_larch_sop_push_dup(struct module *mod, u32 *location, Elf_Add
 	return 0;
 }
 
-static int apply_r_larch_sop_push_plt_pcrel(struct module *mod, u32 *location, Elf_Addr v,
+static int apply_r_larch_sop_push_plt_pcrel(struct module *mod,
+			Elf_Shdr *sechdrs, u32 *location, Elf_Addr v,
 			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
 
 	if (offset >= SZ_128M)
-		v = module_emit_plt_entry(mod, v);
+		v = module_emit_plt_entry(mod, sechdrs, v);
 
 	if (offset < -SZ_128M)
-		v = module_emit_plt_entry(mod, v);
+		v = module_emit_plt_entry(mod, sechdrs, v);
 
 	return apply_r_larch_sop_push_pcrel(mod, location, v, rela_stack, rela_stack_top, type);
 }
@@ -272,17 +273,18 @@ static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
 	}
 }
 
-static int apply_r_larch_b26(struct module *mod, u32 *location, Elf_Addr v,
+static int apply_r_larch_b26(struct module *mod,
+			Elf_Shdr *sechdrs, u32 *location, Elf_Addr v,
 			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
 	union loongarch_instruction *insn = (union loongarch_instruction *)location;
 
 	if (offset >= SZ_128M)
-		v = module_emit_plt_entry(mod, v);
+		v = module_emit_plt_entry(mod, sechdrs, v);
 
 	if (offset < -SZ_128M)
-		v = module_emit_plt_entry(mod, v);
+		v = module_emit_plt_entry(mod, sechdrs, v);
 
 	offset = (void *)v - (void *)location;
 
@@ -339,10 +341,11 @@ static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
 	return 0;
 }
 
-static int apply_r_larch_got_pc(struct module *mod, u32 *location, Elf_Addr v,
+static int apply_r_larch_got_pc(struct module *mod,
+			Elf_Shdr *sechdrs, u32 *location, Elf_Addr v,
 			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
-	Elf_Addr got = module_emit_got_entry(mod, v);
+	Elf_Addr got = module_emit_got_entry(mod, sechdrs, v);
 
 	if (!got)
 		return -EINVAL;
@@ -387,13 +390,10 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_SOP_PUSH_PCREL]			     = apply_r_larch_sop_push_pcrel,
 	[R_LARCH_SOP_PUSH_ABSOLUTE]			     = apply_r_larch_sop_push_absolute,
 	[R_LARCH_SOP_PUSH_DUP]				     = apply_r_larch_sop_push_dup,
-	[R_LARCH_SOP_PUSH_PLT_PCREL]			     = apply_r_larch_sop_push_plt_pcrel,
 	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     = apply_r_larch_sop,
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
-	[R_LARCH_B26]					     = apply_r_larch_b26,
 	[R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]	     = apply_r_larch_pcala,
-	[R_LARCH_GOT_PC_HI20...R_LARCH_GOT_PC_LO12]	     = apply_r_larch_got_pc,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
@@ -444,7 +444,22 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       sym->st_value, rel[i].r_addend, (u64)location);
 
 		v = sym->st_value + rel[i].r_addend;
-		err = handler(mod, location, v, rela_stack, &rela_stack_top, type);
+		switch (type) {
+		case R_LARCH_B26:
+			err = apply_r_larch_b26(mod, sechdrs, location,
+						     v, rela_stack, &rela_stack_top, type);
+			break;
+		case R_LARCH_GOT_PC_HI20...R_LARCH_GOT_PC_LO12:
+			err = apply_r_larch_got_pc(mod, sechdrs, location,
+						     v, rela_stack, &rela_stack_top, type);
+			break;
+		case R_LARCH_SOP_PUSH_PLT_PCREL:
+			err = apply_r_larch_sop_push_plt_pcrel(mod, sechdrs, location,
+						     v, rela_stack, &rela_stack_top, type);
+			break;
+		default:
+			err = handler(mod, location, v, rela_stack, &rela_stack_top, type);
+		}
 		if (err)
 			return err;
 	}
-- 
2.31.1

