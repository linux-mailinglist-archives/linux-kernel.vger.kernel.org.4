Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD780716AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjE3RVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjE3RVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE49E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940A263120
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C249EC4339B;
        Tue, 30 May 2023 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467293;
        bh=ObRta/cmQf+Y5yZ8nzlOMvBFJEPR6qPtpNwKwUR6Mh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSPomr8CpVJD+AazpC7kUdFbyw14WTCcI1+eg8EUGQE6UUKPaNDK+rgIN0SpFe5H/
         VWkO7QXG6a7+2pETEQmgmFP0QQP7pjegOjvFPYZHwgPW25ovyVxQKijyqF+PrafkKv
         rVhNWkuFOhq4V264zXO8d4WSG/WLkbGrP43kkez86QAWogNWTvT4UqdzxbvnddzyNy
         bp8wzdxDMdk/Kj6L4/kkht9Cby0Md9UjZEshadpiAx20mrwpc1zjxpSeubIMOASSZ4
         UGKNYVcm5CnafrOJAJKhZm/vRwsxOh/lptSr4wi9VcmkDk0p3dVw3V7lftQ9hyfY0S
         nEnFCURNjOpwg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 03/22] objtool: Improve reloc naming
Date:   Tue, 30 May 2023 10:20:55 -0700
Message-Id: <8b790e403df46f445c21003e7893b8f53b99a6f3.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- The term "reloc" is overloaded to mean both "an instance of struct
  reloc" and "a reloc section".  Change the latter to "rsec".

- For variable names, use "sec" for regular sections and "rsec" for rela
  sections to prevent them getting mixed up.

- For struct reloc variables, use "reloc" instead of "rel" everywhere
  for consistency.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 134 +++++++++++------------
 tools/objtool/elf.c                 | 164 ++++++++++++++--------------
 tools/objtool/include/objtool/elf.h |   2 +-
 3 files changed, 151 insertions(+), 149 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bc6771550423..189b4161e713 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -493,7 +493,7 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 {
 	struct symbol *sym, *func;
 	unsigned long off, end;
-	struct reloc *rel;
+	struct reloc *reloc;
 	int idx;
 
 	sym = find_symbol_by_name(file->elf, symname);
@@ -503,19 +503,19 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 	off = sym->offset;
 	end = off + sym->len;
 	for (;;) {
-		rel = find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
-		if (!rel)
+		reloc = find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
+		if (!reloc)
 			break;
 
-		func = rel->sym;
+		func = reloc->sym;
 		if (func->type == STT_SECTION)
-			func = find_symbol_by_offset(rel->sym->sec, rel->addend);
+			func = find_symbol_by_offset(reloc->sym->sec, reloc->addend);
 
-		idx = (rel->offset - sym->offset) / sizeof(unsigned long);
+		idx = (reloc->offset - sym->offset) / sizeof(unsigned long);
 
 		objtool_pv_add(file, idx, func);
 
-		off = rel->offset + 1;
+		off = reloc->offset + 1;
 		if (off > end)
 			break;
 	}
@@ -580,20 +580,20 @@ static struct instruction *find_last_insn(struct objtool_file *file,
  */
 static int add_dead_ends(struct objtool_file *file)
 {
-	struct section *sec;
+	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
 
 	/*
 	 * Check for manually annotated dead ends.
 	 */
-	sec = find_section_by_name(file->elf, ".rela.discard.unreachable");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.unreachable");
+	if (!rsec)
 		goto reachable;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
@@ -622,13 +622,13 @@ static int add_dead_ends(struct objtool_file *file)
 	 * GCC doesn't know the "ud2" is fatal, so it generates code as if it's
 	 * not a dead end.
 	 */
-	sec = find_section_by_name(file->elf, ".rela.discard.reachable");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.reachable");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
@@ -1043,15 +1043,15 @@ static int create_direct_call_sections(struct objtool_file *file)
 static void add_ignores(struct objtool_file *file)
 {
 	struct instruction *insn;
-	struct section *sec;
+	struct section *rsec;
 	struct symbol *func;
 	struct reloc *reloc;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
+	if (!rsec)
 		return;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		switch (reloc->sym->type) {
 		case STT_FUNC:
 			func = reloc->sym;
@@ -1064,7 +1064,8 @@ static void add_ignores(struct objtool_file *file)
 			break;
 
 		default:
-			WARN("unexpected relocation symbol type in %s: %d", sec->name, reloc->sym->type);
+			WARN("unexpected relocation symbol type in %s: %d",
+			     rsec->name, reloc->sym->type);
 			continue;
 		}
 
@@ -1283,17 +1284,17 @@ static void add_uaccess_safe(struct objtool_file *file)
  */
 static int add_ignore_alternatives(struct objtool_file *file)
 {
-	struct section *sec;
+	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
@@ -2203,7 +2204,7 @@ static void set_func_state(struct cfi_state *state)
 static int read_unwind_hints(struct objtool_file *file)
 {
 	struct cfi_state cfi = init_cfi;
-	struct section *sec, *relocsec;
+	struct section *sec;
 	struct unwind_hint *hint;
 	struct instruction *insn;
 	struct reloc *reloc;
@@ -2213,8 +2214,7 @@ static int read_unwind_hints(struct objtool_file *file)
 	if (!sec)
 		return 0;
 
-	relocsec = sec->reloc;
-	if (!relocsec) {
+	if (!sec->rsec) {
 		WARN("missing .rela.discard.unwind_hints section");
 		return -1;
 	}
@@ -2289,15 +2289,15 @@ static int read_unwind_hints(struct objtool_file *file)
 
 static int read_noendbr_hints(struct objtool_file *file)
 {
-	struct section *sec;
 	struct instruction *insn;
+	struct section *rsec;
 	struct reloc *reloc;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.noendbr");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.noendbr");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.noendbr entry");
@@ -2312,17 +2312,17 @@ static int read_noendbr_hints(struct objtool_file *file)
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
-	struct section *sec;
+	struct section *rsec;
 	struct instruction *insn;
 	struct reloc *reloc;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
@@ -2348,17 +2348,17 @@ static int read_retpoline_hints(struct objtool_file *file)
 
 static int read_instr_hints(struct objtool_file *file)
 {
-	struct section *sec;
+	struct section *rsec;
 	struct instruction *insn;
 	struct reloc *reloc;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.instr_end");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.instr_end");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
@@ -2371,13 +2371,13 @@ static int read_instr_hints(struct objtool_file *file)
 		insn->instr--;
 	}
 
-	sec = find_section_by_name(file->elf, ".rela.discard.instr_begin");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.instr_begin");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
@@ -2395,17 +2395,17 @@ static int read_instr_hints(struct objtool_file *file)
 
 static int read_validate_unret_hints(struct objtool_file *file)
 {
-	struct section *sec;
+	struct section *rsec;
 	struct instruction *insn;
 	struct reloc *reloc;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.validate_unret");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.validate_unret");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", sec->name);
+			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
@@ -2424,19 +2424,19 @@ static int read_validate_unret_hints(struct objtool_file *file)
 static int read_intra_function_calls(struct objtool_file *file)
 {
 	struct instruction *insn;
-	struct section *sec;
+	struct section *rsec;
 	struct reloc *reloc;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
-	if (!sec)
+	rsec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
+	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		unsigned long dest_off;
 
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s",
-			     sec->name);
+			     rsec->name);
 			return -1;
 		}
 
@@ -3332,15 +3332,15 @@ static inline bool func_uaccess_safe(struct symbol *func)
 static inline const char *call_dest_name(struct instruction *insn)
 {
 	static char pvname[19];
-	struct reloc *rel;
+	struct reloc *reloc;
 	int idx;
 
 	if (insn_call_dest(insn))
 		return insn_call_dest(insn)->name;
 
-	rel = insn_reloc(NULL, insn);
-	if (rel && !strcmp(rel->sym->name, "pv_ops")) {
-		idx = (rel->addend / sizeof(void *));
+	reloc = insn_reloc(NULL, insn);
+	if (reloc && !strcmp(reloc->sym->name, "pv_ops")) {
+		idx = (reloc->addend / sizeof(void *));
 		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
 		return pvname;
 	}
@@ -3351,14 +3351,14 @@ static inline const char *call_dest_name(struct instruction *insn)
 static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 {
 	struct symbol *target;
-	struct reloc *rel;
+	struct reloc *reloc;
 	int idx;
 
-	rel = insn_reloc(file, insn);
-	if (!rel || strcmp(rel->sym->name, "pv_ops"))
+	reloc = insn_reloc(file, insn);
+	if (!reloc || strcmp(reloc->sym->name, "pv_ops"))
 		return false;
 
-	idx = (arch_dest_reloc_offset(rel->addend) / sizeof(void *));
+	idx = (arch_dest_reloc_offset(reloc->addend) / sizeof(void *));
 
 	if (file->pv_ops[idx].clean)
 		return true;
@@ -4401,7 +4401,7 @@ static int validate_ibt(struct objtool_file *file)
 		if (sec->sh.sh_flags & SHF_EXECINSTR)
 			continue;
 
-		if (!sec->reloc)
+		if (!sec->rsec)
 			continue;
 
 		/*
@@ -4428,7 +4428,7 @@ static int validate_ibt(struct objtool_file *file)
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
-		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
+		list_for_each_entry(reloc, &sec->rsec->reloc_list, list)
 			warnings += validate_ibt_data_reloc(file, reloc);
 	}
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7598c0a2633d..86ae62dfdba2 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -233,17 +233,17 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 				     unsigned long offset, unsigned int len)
 {
 	struct reloc *reloc, *r = NULL;
+	struct section *rsec;
 	unsigned long o;
 
-	if (!sec->reloc)
+	rsec = sec->rsec;
+	if (!rsec)
 		return NULL;
 
-	sec = sec->reloc;
-
 	for_offset_range(o, offset, offset + len) {
 		elf_hash_for_each_possible(reloc, reloc, hash,
-					   sec_offset_hash(sec, o)) {
-			if (reloc->sec != sec)
+					   sec_offset_hash(rsec, o)) {
+			if (reloc->sec != rsec)
 				continue;
 
 			if (reloc->offset >= offset && reloc->offset < offset + len) {
@@ -534,7 +534,7 @@ static int read_symbols(struct elf *elf)
 }
 
 static struct section *elf_create_reloc_section(struct elf *elf,
-						struct section *base,
+						struct section *sec,
 						int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
@@ -542,7 +542,7 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 {
 	struct reloc *reloc;
 
-	if (!sec->reloc && !elf_create_reloc_section(elf, sec, SHT_RELA))
+	if (!sec->rsec && !elf_create_reloc_section(elf, sec, SHT_RELA))
 		return -1;
 
 	reloc = malloc(sizeof(*reloc));
@@ -552,18 +552,18 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	}
 	memset(reloc, 0, sizeof(*reloc));
 
-	reloc->sec = sec->reloc;
+	reloc->sec = sec->rsec;
 	reloc->offset = offset;
 	reloc->type = type;
 	reloc->sym = sym;
 	reloc->addend = addend;
 
 	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
-	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
+	list_add_tail(&reloc->list, &sec->rsec->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
-	sec->reloc->sh.sh_size += sec->reloc->sh.sh_entsize;
-	sec->reloc->changed = true;
+	sec->rsec->sh.sh_size += sec->rsec->sh.sh_entsize;
+	sec->rsec->changed = true;
 
 	return 0;
 }
@@ -865,9 +865,9 @@ int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 	return elf_add_reloc(elf, sec, offset, type, sym, addend);
 }
 
-static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
+static int read_rel_reloc(struct section *rsec, int i, struct reloc *reloc, unsigned int *symndx)
 {
-	if (!gelf_getrel(sec->data, i, &reloc->rel)) {
+	if (!gelf_getrel(rsec->data, i, &reloc->rel)) {
 		WARN_ELF("gelf_getrel");
 		return -1;
 	}
@@ -878,9 +878,9 @@ static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsig
 	return 0;
 }
 
-static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
+static int read_rela_reloc(struct section *rsec, int i, struct reloc *reloc, unsigned int *symndx)
 {
-	if (!gelf_getrela(sec->data, i, &reloc->rela)) {
+	if (!gelf_getrela(rsec->data, i, &reloc->rela)) {
 		WARN_ELF("gelf_getrela");
 		return -1;
 	}
@@ -894,7 +894,7 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 static int read_relocs(struct elf *elf)
 {
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
-	struct section *sec;
+	struct section *rsec;
 	struct reloc *reloc;
 	unsigned int symndx;
 	struct symbol *sym;
@@ -903,51 +903,52 @@ static int read_relocs(struct elf *elf)
 	if (!elf_alloc_hash(reloc, elf->text_size / 16))
 		return -1;
 
-	list_for_each_entry(sec, &elf->sections, list) {
-		if ((sec->sh.sh_type != SHT_RELA) &&
-		    (sec->sh.sh_type != SHT_REL))
+	list_for_each_entry(rsec, &elf->sections, list) {
+		if ((rsec->sh.sh_type != SHT_RELA) &&
+		    (rsec->sh.sh_type != SHT_REL))
 			continue;
 
-		sec->base = find_section_by_index(elf, sec->sh.sh_info);
-		if (!sec->base) {
+		rsec->base = find_section_by_index(elf, rsec->sh.sh_info);
+		if (!rsec->base) {
 			WARN("can't find base section for reloc section %s",
-			     sec->name);
+			     rsec->name);
 			return -1;
 		}
 
-		sec->base->reloc = sec;
+		rsec->base->rsec = rsec;
 
 		nr_reloc = 0;
-		sec->reloc_data = calloc(sec->sh.sh_size / sec->sh.sh_entsize, sizeof(*reloc));
-		if (!sec->reloc_data) {
+		rsec->reloc_data = calloc(rsec->sh.sh_size / rsec->sh.sh_entsize,
+					  sizeof(*reloc));
+		if (!rsec->reloc_data) {
 			perror("calloc");
 			return -1;
 		}
-		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
-			reloc = &sec->reloc_data[i];
-			switch (sec->sh.sh_type) {
+		for (i = 0; i < rsec->sh.sh_size / rsec->sh.sh_entsize; i++) {
+			reloc = &rsec->reloc_data[i];
+			switch (rsec->sh.sh_type) {
 			case SHT_REL:
-				if (read_rel_reloc(sec, i, reloc, &symndx))
+				if (read_rel_reloc(rsec, i, reloc, &symndx))
 					return -1;
 				break;
 			case SHT_RELA:
-				if (read_rela_reloc(sec, i, reloc, &symndx))
+				if (read_rela_reloc(rsec, i, reloc, &symndx))
 					return -1;
 				break;
 			default: return -1;
 			}
 
-			reloc->sec = sec;
+			reloc->sec = rsec;
 			reloc->idx = i;
 			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
 				WARN("can't find reloc entry symbol %d for %s",
-				     symndx, sec->name);
+				     symndx, rsec->name);
 				return -1;
 			}
 
 			list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
-			list_add_tail(&reloc->list, &sec->reloc_list);
+			list_add_tail(&reloc->list, &rsec->reloc_list);
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 			nr_reloc++;
@@ -1140,40 +1141,41 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	return sec;
 }
 
-static struct section *elf_create_rel_reloc_section(struct elf *elf, struct section *base)
+static struct section *elf_create_rel_reloc_section(struct elf *elf,
+						    struct section *sec)
 {
 	char *relocname;
-	struct section *sec;
+	struct section *rsec;
 
-	relocname = malloc(strlen(base->name) + strlen(".rel") + 1);
+	relocname = malloc(strlen(sec->name) + strlen(".rel") + 1);
 	if (!relocname) {
 		perror("malloc");
 		return NULL;
 	}
 	strcpy(relocname, ".rel");
-	strcat(relocname, base->name);
+	strcat(relocname, sec->name);
 
-	sec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
+	rsec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
 	free(relocname);
-	if (!sec)
+	if (!rsec)
 		return NULL;
 
-	base->reloc = sec;
-	sec->base = base;
+	sec->rsec = rsec;
+	rsec->base = sec;
 
-	sec->sh.sh_type = SHT_REL;
-	sec->sh.sh_addralign = 8;
-	sec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
-	sec->sh.sh_info = base->idx;
-	sec->sh.sh_flags = SHF_INFO_LINK;
+	rsec->sh.sh_type = SHT_REL;
+	rsec->sh.sh_addralign = 8;
+	rsec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
+	rsec->sh.sh_info = sec->idx;
+	rsec->sh.sh_flags = SHF_INFO_LINK;
 
-	return sec;
+	return rsec;
 }
 
 static struct section *elf_create_rela_reloc_section(struct elf *elf, struct section *base)
 {
 	char *relocname;
-	struct section *sec;
+	struct section *rsec;
 	int addrsize = elf_class_addrsize(elf);
 
 	relocname = malloc(strlen(base->name) + strlen(".rela") + 1);
@@ -1185,23 +1187,23 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 	strcat(relocname, base->name);
 
 	if (addrsize == sizeof(u32))
-		sec = elf_create_section(elf, relocname, sizeof(Elf32_Rela), 0);
+		rsec = elf_create_section(elf, relocname, sizeof(Elf32_Rela), 0);
 	else
-		sec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
+		rsec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
 	free(relocname);
-	if (!sec)
+	if (!rsec)
 		return NULL;
 
-	base->reloc = sec;
-	sec->base = base;
+	base->rsec = rsec;
+	rsec->base = base;
 
-	sec->sh.sh_type = SHT_RELA;
-	sec->sh.sh_addralign = addrsize;
-	sec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
-	sec->sh.sh_info = base->idx;
-	sec->sh.sh_flags = SHF_INFO_LINK;
+	rsec->sh.sh_type = SHT_RELA;
+	rsec->sh.sh_addralign = addrsize;
+	rsec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
+	rsec->sh.sh_info = base->idx;
+	rsec->sh.sh_flags = SHF_INFO_LINK;
 
-	return sec;
+	return rsec;
 }
 
 static struct section *elf_create_reloc_section(struct elf *elf,
@@ -1215,28 +1217,28 @@ static struct section *elf_create_reloc_section(struct elf *elf,
 	}
 }
 
-static int elf_rebuild_rel_reloc_section(struct section *sec)
+static int elf_rebuild_rel_reloc_section(struct section *rsec)
 {
 	struct reloc *reloc;
 	int idx = 0;
 	void *buf;
 
 	/* Allocate a buffer for relocations */
-	buf = malloc(sec->sh.sh_size);
+	buf = malloc(rsec->sh.sh_size);
 	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = buf;
-	sec->data->d_size = sec->sh.sh_size;
-	sec->data->d_type = ELF_T_REL;
+	rsec->data->d_buf = buf;
+	rsec->data->d_size = rsec->sh.sh_size;
+	rsec->data->d_type = ELF_T_REL;
 
 	idx = 0;
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		if (!gelf_update_rel(sec->data, idx, &reloc->rel)) {
+		if (!gelf_update_rel(rsec->data, idx, &reloc->rel)) {
 			WARN_ELF("gelf_update_rel");
 			return -1;
 		}
@@ -1246,29 +1248,29 @@ static int elf_rebuild_rel_reloc_section(struct section *sec)
 	return 0;
 }
 
-static int elf_rebuild_rela_reloc_section(struct section *sec)
+static int elf_rebuild_rela_reloc_section(struct section *rsec)
 {
 	struct reloc *reloc;
 	int idx = 0;
 	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	buf = malloc(sec->sh.sh_size);
+	buf = malloc(rsec->sh.sh_size);
 	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = buf;
-	sec->data->d_size = sec->sh.sh_size;
-	sec->data->d_type = ELF_T_RELA;
+	rsec->data->d_buf = buf;
+	rsec->data->d_size = rsec->sh.sh_size;
+	rsec->data->d_type = ELF_T_RELA;
 
 	idx = 0;
-	list_for_each_entry(reloc, &sec->reloc_list, list) {
+	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		reloc->rela.r_offset = reloc->offset;
 		reloc->rela.r_addend = reloc->addend;
 		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		if (!gelf_update_rela(sec->data, idx, &reloc->rela)) {
+		if (!gelf_update_rela(rsec->data, idx, &reloc->rela)) {
 			WARN_ELF("gelf_update_rela");
 			return -1;
 		}
@@ -1278,11 +1280,11 @@ static int elf_rebuild_rela_reloc_section(struct section *sec)
 	return 0;
 }
 
-static int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
+static int elf_rebuild_reloc_section(struct elf *elf, struct section *rsec)
 {
-	switch (sec->sh.sh_type) {
-	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec);
-	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec);
+	switch (rsec->sh.sh_type) {
+	case SHT_REL:  return elf_rebuild_rel_reloc_section(rsec);
+	case SHT_RELA: return elf_rebuild_rela_reloc_section(rsec);
 	default:       return -1;
 	}
 }
@@ -1308,13 +1310,13 @@ int elf_write_insn(struct elf *elf, struct section *sec,
 
 int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 {
-	struct section *sec = reloc->sec;
+	struct section *rsec = reloc->sec;
 
-	if (sec->sh.sh_type == SHT_REL) {
+	if (rsec->sh.sh_type == SHT_REL) {
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
 		reloc->rel.r_offset = reloc->offset;
 
-		if (!gelf_update_rel(sec->data, reloc->idx, &reloc->rel)) {
+		if (!gelf_update_rel(rsec->data, reloc->idx, &reloc->rel)) {
 			WARN_ELF("gelf_update_rel");
 			return -1;
 		}
@@ -1323,7 +1325,7 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 		reloc->rela.r_addend = reloc->addend;
 		reloc->rela.r_offset = reloc->offset;
 
-		if (!gelf_update_rela(sec->data, reloc->idx, &reloc->rela)) {
+		if (!gelf_update_rela(rsec->data, reloc->idx, &reloc->rela)) {
 			WARN_ELF("gelf_update_rela");
 			return -1;
 		}
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2c28aeeb3cb2..a4e43a69f922 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -33,7 +33,7 @@ struct section {
 	struct rb_root_cached symbol_tree;
 	struct list_head symbol_list;
 	struct list_head reloc_list;
-	struct section *base, *reloc;
+	struct section *base, *rsec;
 	struct symbol *sym;
 	Elf_Data *data;
 	char *name;
-- 
2.40.1

