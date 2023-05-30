Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C691F716ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjE3RWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjE3RVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06496B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 854D961179
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC06C433A1;
        Tue, 30 May 2023 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467294;
        bh=1E8+NZr2wa3zbKFfb87sPwKr84rMmdbhoxlyBO6Tvz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnZlUeQ8JOPhSdMlG0CXnAPGJoc+NCTAYl7zr+CGG3xDqWwPlr9INZ4g0jS2pMUZ9
         EAU83JUWnZb9rq2RJqLz4HpjgHNp02vA6AL3ScMJpQRoasqP/tLLTtC5/A4XCbIUiR
         3/5W1NBqDojAEfF/BLS4CgWjVyjdth4pfz244tWZ9o41twxPYS77jrvD47xvY4P8ST
         C52oiJ/k+Vnp431oCNOFzrJLcoR2E6hiKpCM/uN4HhHT/6BK1h4JnMAiVCEYdQxe18
         EGhMHNEnIP74EkdUh3fkajbdQ0oY7bG8fQ7as0EVp5hp9zXJsuQVo+7NO/mMRLwayR
         Os5EvOTgB7Qaw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 07/22] objtool: Add elf_create_section_pair()
Date:   Tue, 30 May 2023 10:20:59 -0700
Message-Id: <048e908f3ede9b66c15e44672b6dda992b1dae3e.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating an annotation section, allocate the reloc section data at
the beginning.  This simplifies the data model a bit and also saves
memory due to the removal of malloc() in elf_rebuild_reloc_section().

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 53.49G
- After:  peak heap memory consumption: 49.02G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/powerpc/include/arch/elf.h |  11 +-
 tools/objtool/arch/x86/include/arch/elf.h     |  11 +-
 tools/objtool/check.c                         | 129 ++++++---------
 tools/objtool/elf.c                           | 151 +++++++++++-------
 tools/objtool/include/objtool/elf.h           |  33 +++-
 tools/objtool/orc_gen.c                       |   6 +-
 6 files changed, 184 insertions(+), 157 deletions(-)

diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
index 73f9ae172fe5..66814fa28024 100644
--- a/tools/objtool/arch/powerpc/include/arch/elf.h
+++ b/tools/objtool/arch/powerpc/include/arch/elf.h
@@ -1,10 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-
 #ifndef _OBJTOOL_ARCH_ELF
 #define _OBJTOOL_ARCH_ELF
 
-#define R_NONE R_PPC_NONE
-#define R_ABS64 R_PPC64_ADDR64
-#define R_ABS32 R_PPC_ADDR32
+#define R_NONE		R_PPC_NONE
+#define R_ABS64		R_PPC64_ADDR64
+#define R_ABS32		R_PPC_ADDR32
+#define R_DATA32	R_PPC_REL32
+#define R_DATA64	R_PPC64_REL64
+#define R_TEXT32	R_PPC_REL32
+#define R_TEXT64	R_PPC64_REL32
 
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
index ac14987cf687..7131f7f51a4e 100644
--- a/tools/objtool/arch/x86/include/arch/elf.h
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -1,8 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _OBJTOOL_ARCH_ELF
 #define _OBJTOOL_ARCH_ELF
 
-#define R_NONE R_X86_64_NONE
-#define R_ABS64 R_X86_64_64
-#define R_ABS32 R_X86_64_32
+#define R_NONE		R_X86_64_NONE
+#define R_ABS32		R_X86_64_32
+#define R_ABS64		R_X86_64_64
+#define R_DATA32	R_X86_64_PC32
+#define R_DATA64	R_X86_64_PC32
+#define R_TEXT32	R_X86_64_PC32
+#define R_TEXT64	R_X86_64_PC32
 
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6d0cb24085b..88f54bb1b01c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/mman.h>
 
-#include <arch/elf.h>
 #include <objtool/builtin.h>
 #include <objtool/cfi.h>
 #include <objtool/arch.h>
@@ -655,8 +654,8 @@ static int add_dead_ends(struct objtool_file *file)
 
 static int create_static_call_sections(struct objtool_file *file)
 {
-	struct section *sec;
 	struct static_call_site *site;
+	struct section *sec;
 	struct instruction *insn;
 	struct symbol *key_sym;
 	char *key_name, *tmp;
@@ -676,25 +675,21 @@ static int create_static_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->static_call_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, ".static_call_sites",
-				 sizeof(struct static_call_site), idx);
+	sec = elf_create_section_pair(file->elf, ".static_call_sites",
+				      sizeof(*site), idx, idx * 2);
 	if (!sec)
 		return -1;
 
-	/* Allow modules to set the low bits of static_call_site::key */
+	/* Allow modules to modify the low bits of static_call_site::key */
 	sec->sh.sh_flags |= SHF_WRITE;
 
 	idx = 0;
 	list_for_each_entry(insn, &file->static_call_list, call_node) {
 
-		site = (struct static_call_site *)sec->data->d_buf + idx;
-		memset(site, 0, sizeof(struct static_call_site));
-
 		/* populate reloc for 'addr' */
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(struct static_call_site),
-					  R_X86_64_PC32,
-					  insn->sec, insn->offset))
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(*site), idx * 2,
+					     insn->sec, insn->offset))
 			return -1;
 
 		/* find key symbol */
@@ -734,10 +729,10 @@ static int create_static_call_sections(struct objtool_file *file)
 		free(key_name);
 
 		/* populate reloc for 'key' */
-		if (elf_add_reloc(file->elf, sec,
-				  idx * sizeof(struct static_call_site) + 4,
-				  R_X86_64_PC32, key_sym,
-				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
+		if (!elf_init_reloc_data_sym(file->elf, sec,
+					     idx * sizeof(*site) + 4,
+					     (idx * 2) + 1, key_sym,
+					     is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
 
 		idx++;
@@ -765,26 +760,18 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".retpoline_sites",
-				 sizeof(int), idx);
-	if (!sec) {
-		WARN("elf_create_section: .retpoline_sites");
+	sec = elf_create_section_pair(file->elf, ".retpoline_sites",
+				      sizeof(int), idx, idx);
+	if (!sec)
 		return -1;
-	}
 
 	idx = 0;
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 
-		int *site = (int *)sec->data->d_buf + idx;
-		*site = 0;
-
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(int),
-					  R_X86_64_PC32,
-					  insn->sec, insn->offset)) {
-			WARN("elf_add_reloc_to_insn: .retpoline_sites");
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(int), idx,
+					     insn->sec, insn->offset))
 			return -1;
-		}
 
 		idx++;
 	}
@@ -811,26 +798,18 @@ static int create_return_sites_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".return_sites",
-				 sizeof(int), idx);
-	if (!sec) {
-		WARN("elf_create_section: .return_sites");
+	sec = elf_create_section_pair(file->elf, ".return_sites",
+				      sizeof(int), idx, idx);
+	if (!sec)
 		return -1;
-	}
 
 	idx = 0;
 	list_for_each_entry(insn, &file->return_thunk_list, call_node) {
 
-		int *site = (int *)sec->data->d_buf + idx;
-		*site = 0;
-
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(int),
-					  R_X86_64_PC32,
-					  insn->sec, insn->offset)) {
-			WARN("elf_add_reloc_to_insn: .return_sites");
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(int), idx,
+					     insn->sec, insn->offset))
 			return -1;
-		}
 
 		idx++;
 	}
@@ -863,12 +842,10 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".ibt_endbr_seal",
-				 sizeof(int), idx);
-	if (!sec) {
-		WARN("elf_create_section: .ibt_endbr_seal");
+	sec = elf_create_section_pair(file->elf, ".ibt_endbr_seal",
+				      sizeof(int), idx, idx);
+	if (!sec)
 		return -1;
-	}
 
 	idx = 0;
 	list_for_each_entry(insn, &file->endbr_list, call_node) {
@@ -883,13 +860,10 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 		     !strcmp(sym->name, "cleanup_module")))
 			WARN("%s(): not an indirect call target", sym->name);
 
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(int),
-					  R_X86_64_PC32,
-					  insn->sec, insn->offset)) {
-			WARN("elf_add_reloc_to_insn: .ibt_endbr_seal");
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(int), idx,
+					     insn->sec, insn->offset))
 			return -1;
-		}
 
 		idx++;
 	}
@@ -901,7 +875,6 @@ static int create_cfi_sections(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *sym;
-	unsigned int *loc;
 	int idx;
 
 	sec = find_section_by_name(file->elf, ".cfi_sites");
@@ -922,7 +895,8 @@ static int create_cfi_sections(struct objtool_file *file)
 		idx++;
 	}
 
-	sec = elf_create_section(file->elf, ".cfi_sites", sizeof(unsigned int), idx);
+	sec = elf_create_section_pair(file->elf, ".cfi_sites",
+				      sizeof(unsigned int), idx, idx);
 	if (!sec)
 		return -1;
 
@@ -934,13 +908,9 @@ static int create_cfi_sections(struct objtool_file *file)
 		if (strncmp(sym->name, "__cfi_", 6))
 			continue;
 
-		loc = (unsigned int *)sec->data->d_buf + idx;
-		memset(loc, 0, sizeof(unsigned int));
-
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(unsigned int),
-					  R_X86_64_PC32,
-					  sym->sec, sym->offset))
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(unsigned int), idx,
+					     sym->sec, sym->offset))
 			return -1;
 
 		idx++;
@@ -970,7 +940,8 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, "__mcount_loc", addr_size, idx);
+	sec = elf_create_section_pair(file->elf, "__mcount_loc", addr_size,
+				      idx, idx);
 	if (!sec)
 		return -1;
 
@@ -978,17 +949,17 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 
 	idx = 0;
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
-		void *loc;
 
-		loc = sec->data->d_buf + idx;
-		memset(loc, 0, addr_size);
+		struct reloc *reloc;
 
-		if (elf_add_reloc_to_insn(file->elf, sec, idx,
-					  addr_size == sizeof(u64) ? R_ABS64 : R_ABS32,
-					  insn->sec, insn->offset))
+		reloc = elf_init_reloc_text_sym(file->elf, sec, idx * addr_size, idx,
+					       insn->sec, insn->offset);
+		if (!reloc)
 			return -1;
 
-		idx += addr_size;
+		reloc->type = addr_size == 8 ? R_ABS64 : R_ABS32;
+
+		idx++;
 	}
 
 	return 0;
@@ -998,7 +969,6 @@ static int create_direct_call_sections(struct objtool_file *file)
 {
 	struct instruction *insn;
 	struct section *sec;
-	unsigned int *loc;
 	int idx;
 
 	sec = find_section_by_name(file->elf, ".call_sites");
@@ -1015,20 +985,17 @@ static int create_direct_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->call_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, ".call_sites", sizeof(unsigned int), idx);
+	sec = elf_create_section_pair(file->elf, ".call_sites",
+				      sizeof(unsigned int), idx, idx);
 	if (!sec)
 		return -1;
 
 	idx = 0;
 	list_for_each_entry(insn, &file->call_list, call_node) {
 
-		loc = (unsigned int *)sec->data->d_buf + idx;
-		memset(loc, 0, sizeof(unsigned int));
-
-		if (elf_add_reloc_to_insn(file->elf, sec,
-					  idx * sizeof(unsigned int),
-					  R_X86_64_PC32,
-					  insn->sec, insn->offset))
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(unsigned int), idx,
+					     insn->sec, insn->offset))
 			return -1;
 
 		idx++;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 67967c231972..5cbc9d578a45 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -533,41 +533,6 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
-static struct section *elf_create_rela_section(struct elf *elf,
-					       struct section *sec);
-
-int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, s64 addend)
-{
-	struct reloc *reloc;
-
-	if (!sec->rsec && !elf_create_rela_section(elf, sec))
-		return -1;
-
-	reloc = malloc(sizeof(*reloc));
-	if (!reloc) {
-		perror("malloc");
-		return -1;
-	}
-	memset(reloc, 0, sizeof(*reloc));
-
-	reloc->sec = sec->rsec;
-	reloc->offset = offset;
-	reloc->type = type;
-	reloc->sym = sym;
-	reloc->addend = addend;
-
-	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
-	list_add_tail(&reloc->list, &sec->rsec->reloc_list);
-	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
-
-	sec->rsec->sh.sh_size += sec->rsec->sh.sh_entsize;
-
-	mark_sec_changed(elf, sec->rsec, true);
-
-	return 0;
-}
-
 /*
  * Ensure that any reloc section containing references to @sym is marked
  * changed such that it will get re-generated in elf_rebuild_reloc_sections()
@@ -841,13 +806,57 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
 	return sym;
 }
 
-int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
-			  unsigned long offset, unsigned int type,
-			  struct section *insn_sec, unsigned long insn_off)
+static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
+				    unsigned int reloc_idx,
+				    unsigned long offset, struct symbol *sym,
+				    s64 addend, unsigned int type)
+{
+	struct reloc *reloc;
+
+	if (reloc_idx >= rsec->sh.sh_size / elf_rela_size(elf)) {
+		WARN("%s: bad reloc_idx %u for %s with size 0x%lx",
+		     __func__, reloc_idx, rsec->name, rsec->sh.sh_size);
+		return NULL;
+	}
+
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(reloc, 0, sizeof(*reloc));
+
+	reloc->idx = reloc_idx;
+	reloc->sec = rsec;
+	reloc->offset = offset;
+	reloc->type = type;
+	reloc->sym = sym;
+	reloc->addend = addend;
+
+	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
+	list_add_tail(&reloc->list, &rsec->reloc_list);
+	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
+
+	mark_sec_changed(elf, rsec, true);
+
+	return reloc;
+}
+
+struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
+				      unsigned long offset,
+				      unsigned int reloc_idx,
+				      struct section *insn_sec,
+				      unsigned long insn_off)
 {
 	struct symbol *sym = insn_sec->sym;
 	int addend = insn_off;
 
+	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
+		WARN("bad call to %s() for data symbol %s",
+		     __func__, sym->name);
+		return NULL;
+	}
+
 	if (!sym) {
 		/*
 		 * Due to how weak functions work, we must use section based
@@ -857,12 +866,29 @@ int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 		 */
 		sym = elf_create_section_symbol(elf, insn_sec);
 		if (!sym)
-			return -1;
+			return NULL;
 
 		insn_sec->sym = sym;
 	}
 
-	return elf_add_reloc(elf, sec, offset, type, sym, addend);
+	return elf_init_reloc(elf, sec->rsec, reloc_idx, offset, sym, addend,
+			      elf_text_rela_type(elf));
+}
+
+struct reloc *elf_init_reloc_data_sym(struct elf *elf, struct section *sec,
+				      unsigned long offset,
+				      unsigned int reloc_idx,
+				      struct symbol *sym,
+				      s64 addend)
+{
+	if (sym->sec && (sec->sh.sh_flags & SHF_EXECINSTR)) {
+		WARN("bad call to %s() for text symbol %s",
+		     __func__, sym->name);
+		return NULL;
+	}
+
+	return elf_init_reloc(elf, sec->rsec, reloc_idx, offset, sym, addend,
+			      elf_data_rela_type(elf));
 }
 
 static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
@@ -1048,7 +1074,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   size_t entsize, int nr)
+				   size_t entsize, unsigned int nr)
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
@@ -1129,7 +1155,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 }
 
 static struct section *elf_create_rela_section(struct elf *elf,
-					       struct section *sec)
+					       struct section *sec,
+					       unsigned int reloc_nr)
 {
 	struct section *rsec;
 	char *rsec_name;
@@ -1142,46 +1169,50 @@ static struct section *elf_create_rela_section(struct elf *elf,
 	strcpy(rsec_name, ".rela");
 	strcat(rsec_name, sec->name);
 
-	rsec = elf_create_section(elf, rsec_name, elf_rela_size(elf), 0);
+	rsec = elf_create_section(elf, rsec_name, elf_rela_size(elf), reloc_nr);
 	free(rsec_name);
 	if (!rsec)
 		return NULL;
 
-	sec->rsec = rsec;
-	rsec->base = sec;
-
+	rsec->data->d_type = ELF_T_RELA;
 	rsec->sh.sh_type = SHT_RELA;
 	rsec->sh.sh_addralign = elf_addr_size(elf);
 	rsec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
 	rsec->sh.sh_info = sec->idx;
 	rsec->sh.sh_flags = SHF_INFO_LINK;
 
+	sec->rsec = rsec;
+	rsec->base = sec;
+
 	return rsec;
 }
 
+struct section *elf_create_section_pair(struct elf *elf, const char *name,
+					size_t entsize, unsigned int nr,
+					unsigned int reloc_nr)
+{
+	struct section *sec;
+
+	sec = elf_create_section(elf, name, entsize, nr);
+	if (!sec)
+		return NULL;
+
+	if (!elf_create_rela_section(elf, sec, reloc_nr))
+		return NULL;
+
+	return sec;
+}
+
 static int elf_rebuild_reloc_section(struct elf *elf, struct section *rsec)
 {
-	bool rela = rsec->sh.sh_type == SHT_RELA;
 	struct reloc *reloc;
 	int idx = 0, ret;
-	void *buf;
-
-	/* Allocate a buffer for relocations */
-	buf = malloc(rsec->sh.sh_size);
-	if (!buf) {
-		perror("malloc");
-		return -1;
-	}
-
-	rsec->data->d_buf = buf;
-	rsec->data->d_size = rsec->sh.sh_size;
-	rsec->data->d_type = rela ? ELF_T_RELA : ELF_T_REL;
 
 	idx = 0;
 	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		if (rela) {
+		if (rsec->sh.sh_type == SHT_RELA) {
 			reloc->rela.r_addend = reloc->addend;
 			ret = gelf_update_rela(rsec->data, idx, &reloc->rela);
 		} else {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 56b66ff91943..74f63934afd3 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -111,15 +111,26 @@ struct elf {
 };
 
 struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
+
+struct section *elf_create_section(struct elf *elf, const char *name,
+				   size_t entsize, unsigned int nr);
+struct section *elf_create_section_pair(struct elf *elf, const char *name,
+					size_t entsize, unsigned int nr,
+					unsigned int reloc_nr);
 
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
-int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, s64 addend);
-int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
-			  unsigned long offset, unsigned int type,
-			  struct section *insn_sec, unsigned long insn_off);
+struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
+				      unsigned long offset,
+				      unsigned int reloc_idx,
+				      struct section *insn_sec,
+				      unsigned long insn_off);
+
+struct reloc *elf_init_reloc_data_sym(struct elf *elf, struct section *sec,
+				      unsigned long offset,
+				      unsigned int reloc_idx,
+				      struct symbol *sym,
+				      s64 addend);
 
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
@@ -159,6 +170,16 @@ static inline size_t elf_rela_size(struct elf *elf)
 	return elf_addr_size(elf) == 4 ? sizeof(Elf32_Rela) : sizeof(Elf64_Rela);
 }
 
+static inline unsigned int elf_data_rela_type(struct elf *elf)
+{
+	return elf_addr_size(elf) == 4 ? R_DATA32 : R_DATA64;
+}
+
+static inline unsigned int elf_text_rela_type(struct elf *elf)
+{
+	return elf_addr_size(elf) == 4 ? R_TEXT32 : R_TEXT64;
+}
+
 static inline bool is_reloc_sec(struct section *sec)
 {
 	return sec->sh.sh_type == SHT_RELA || sec->sh.sh_type == SHT_REL;
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index d5f750be7d7d..bae343908867 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -118,8 +118,8 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
 
 	/* populate reloc for ip */
-	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
-				  insn_sec, insn_off))
+	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
+				     insn_sec, insn_off))
 		return -1;
 
 	return 0;
@@ -242,7 +242,7 @@ int orc_create(struct objtool_file *file)
 	if (!orc_sec)
 		return -1;
 
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", sizeof(int), nr);
+	sec = elf_create_section_pair(file->elf, ".orc_unwind_ip", sizeof(int), nr, nr);
 	if (!sec)
 		return -1;
 
-- 
2.40.1

