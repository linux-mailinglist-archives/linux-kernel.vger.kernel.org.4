Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CB716AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjE3RWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjE3RVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9DEF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB3063138
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6289DC433A0;
        Tue, 30 May 2023 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467297;
        bh=pNfbAmu0/tic6xcfteWUfNk4M0kZWxM3aNAl/VUcN9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kChLyN3RMKEm349Q59K+r3Bwcshk/vF0duCdtnLKqYmXwXbWFURcScsNVjas8VJiu
         Z/PE6hzQg1eSMRDBWsLwduTV3tGdymqtG58qVdMnPaTtA0r0DLwqGI6Ap/pqnypTag
         UwR5HqjWp5nJYekzctbf3yg4wnSfLYxCT0d9U270qWFT2f81h6O3x1mebY7ksdy3Sx
         EoIqSFRe69p/Z0SkC9x0lE0D+NaDyOXT13Eog4mUqNzb6bexZpQ6tVF5Rt0P/4mD+/
         Ipgv9gkzgDRKyN7QP3oSZetMSqBYSeq4dUV1Iwbp8OdMUxfHaV0ZjggypAIwiWiH17
         0Vkporxo7fbRw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 16/22] objtool: Get rid of reloc->addend
Date:   Tue, 30 May 2023 10:21:08 -0700
Message-Id: <ad2354f95d9ddd86094e3f7687acfa0750657784.1685464332.git.jpoimboe@kernel.org>
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

Get the addend from the embedded GElf_Rel[a] struct.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 42.10G
- After:  peak heap memory consumption: 40.37G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c     |  4 +-
 tools/objtool/arch/x86/special.c    |  2 +-
 tools/objtool/check.c               | 69 +++++++++++++++++------------
 tools/objtool/elf.c                 | 10 ++---
 tools/objtool/include/objtool/elf.h |  6 ++-
 tools/objtool/special.c             |  4 +-
 6 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index ffb12e83b238..2e1caabecb18 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -623,11 +623,11 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			if (!immr || strcmp(immr->sym->name, "pv_ops"))
 				break;
 
-			idx = (immr->addend + 8) / sizeof(void *);
+			idx = (reloc_addend(immr) + 8) / sizeof(void *);
 
 			func = disp->sym;
 			if (disp->sym->type == STT_SECTION)
-				func = find_symbol_by_offset(disp->sym->sec, disp->addend);
+				func = find_symbol_by_offset(disp->sym->sec, reloc_addend(disp));
 			if (!func) {
 				WARN("no func for pv_ops[]");
 				return -1;
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 1a54a249cb50..65f48f35b97e 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -105,7 +105,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	    !text_reloc->sym->sec->rodata)
 		return NULL;
 
-	table_offset = text_reloc->addend;
+	table_offset = reloc_addend(text_reloc);
 	table_sec = text_reloc->sym->sec;
 
 	if (reloc_type(text_reloc) == R_X86_64_PC32)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1d794d15bc53..12a9e6fb3fe7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -508,7 +508,8 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 
 		func = reloc->sym;
 		if (func->type == STT_SECTION)
-			func = find_symbol_by_offset(reloc->sym->sec, reloc->addend);
+			func = find_symbol_by_offset(reloc->sym->sec,
+						     reloc_addend(reloc));
 
 		idx = (reloc_offset(reloc) - sym->offset) / sizeof(unsigned long);
 
@@ -582,6 +583,7 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
+	s64 addend;
 
 	/*
 	 * Check for manually annotated dead ends.
@@ -591,23 +593,27 @@ static int add_dead_ends(struct objtool_file *file)
 		goto reachable;
 
 	for_each_reloc(rsec, reloc) {
+
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+
+		addend = reloc_addend(reloc);
+
+		insn = find_insn(file, reloc->sym->sec, addend);
 		if (insn)
 			insn = prev_insn_same_sec(file, insn);
-		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
+		else if (addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, reloc->addend);
+				     reloc->sym->sec->name, addend);
 				return -1;
 			}
 		} else {
 			WARN("can't find unreachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, reloc->addend);
+			     reloc->sym->sec->name, addend);
 			return -1;
 		}
 
@@ -626,23 +632,27 @@ static int add_dead_ends(struct objtool_file *file)
 		return 0;
 
 	for_each_reloc(rsec, reloc) {
+
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+
+		addend = reloc_addend(reloc);
+
+		insn = find_insn(file, reloc->sym->sec, addend);
 		if (insn)
 			insn = prev_insn_same_sec(file, insn);
-		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
+		else if (addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, reloc->addend);
+				     reloc->sym->sec->name, addend);
 				return -1;
 			}
 		} else {
 			WARN("can't find reachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, reloc->addend);
+			     reloc->sym->sec->name, addend);
 			return -1;
 		}
 
@@ -1025,7 +1035,7 @@ static void add_ignores(struct objtool_file *file)
 			break;
 
 		case STT_SECTION:
-			func = find_func_by_offset(reloc->sym->sec, reloc->addend);
+			func = find_func_by_offset(reloc->sym->sec, reloc_addend(reloc));
 			if (!func)
 				continue;
 			break;
@@ -1265,7 +1275,7 @@ static int add_ignore_alternatives(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.ignore_alts entry");
 			return -1;
@@ -1541,7 +1551,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			dest_off = arch_jump_destination(insn);
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
-			dest_off = arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc_addend(reloc));
 		} else if (reloc->sym->retpoline_thunk) {
 			add_retpoline_call(file, insn);
 			continue;
@@ -1558,7 +1568,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
 			dest_off = reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc->addend);
+				   arch_dest_reloc_offset(reloc_addend(reloc));
 		} else {
 			/* non-func asm code jumping to another file */
 			continue;
@@ -1675,7 +1685,7 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (reloc->sym->type == STT_SECTION) {
-			dest_off = arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc_addend(reloc));
 			dest = find_call_destination(reloc->sym->sec, dest_off);
 			if (!dest) {
 				WARN_INSN(insn, "can't find call dest symbol at %s+0x%lx",
@@ -2002,10 +2012,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 
 		/* Detect function pointers from contiguous objects: */
 		if (reloc->sym->sec == pfunc->sec &&
-		    reloc->addend == pfunc->offset)
+		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!dest_insn)
 			break;
 
@@ -2066,7 +2076,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		table_reloc = arch_find_switch_table(file, insn);
 		if (!table_reloc)
 			continue;
-		dest_insn = find_insn(file, table_reloc->sym->sec, table_reloc->addend);
+		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
@@ -2202,7 +2212,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("can't find insn for unwind_hints[%d]", i);
 			return -1;
@@ -2265,7 +2275,8 @@ static int read_noendbr_hints(struct objtool_file *file)
 		return 0;
 
 	for_each_reloc(rsec, reloc) {
-		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
+		insn = find_insn(file, reloc->sym->sec,
+				 reloc->sym->offset + reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.noendbr entry");
 			return -1;
@@ -2293,7 +2304,7 @@ static int read_retpoline_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.retpoline_safe entry");
 			return -1;
@@ -2329,7 +2340,7 @@ static int read_instr_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.instr_end entry");
 			return -1;
@@ -2348,7 +2359,7 @@ static int read_instr_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.instr_begin entry");
 			return -1;
@@ -2376,7 +2387,7 @@ static int read_validate_unret_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.instr_end entry");
 			return -1;
@@ -2407,7 +2418,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.intra_function_call entry");
 			return -1;
@@ -3307,7 +3318,7 @@ static inline const char *call_dest_name(struct instruction *insn)
 
 	reloc = insn_reloc(NULL, insn);
 	if (reloc && !strcmp(reloc->sym->name, "pv_ops")) {
-		idx = (reloc->addend / sizeof(void *));
+		idx = (reloc_addend(reloc) / sizeof(void *));
 		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
 		return pvname;
 	}
@@ -3325,7 +3336,7 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	if (!reloc || strcmp(reloc->sym->name, "pv_ops"))
 		return false;
 
-	idx = (arch_dest_reloc_offset(reloc->addend) / sizeof(void *));
+	idx = (arch_dest_reloc_offset(reloc_addend(reloc)) / sizeof(void *));
 
 	if (file->pv_ops[idx].clean)
 		return true;
@@ -4270,9 +4281,9 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 		off = reloc->sym->offset;
 		if (reloc_type(reloc) == R_X86_64_PC32 ||
 		    reloc_type(reloc) == R_X86_64_PLT32)
-			off += arch_dest_reloc_offset(reloc->addend);
+			off += arch_dest_reloc_offset(reloc_addend(reloc));
 		else
-			off += reloc->addend;
+			off += reloc_addend(reloc);
 
 		dest = find_insn(file, reloc->sym->sec, off);
 		if (!dest)
@@ -4329,7 +4340,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 	struct instruction *dest;
 
 	dest = find_insn(file, reloc->sym->sec,
-			 reloc->sym->offset + reloc->addend);
+			 reloc->sym->offset + reloc_addend(reloc));
 	if (!dest)
 		return 0;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be9d24dcdf56..16e019a1762c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -833,10 +833,10 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 
 	reloc->sec = rsec;
 	reloc->sym = sym;
-	reloc->addend = addend;
 
 	reloc->rel.r_offset = offset;
 	reloc->rel.r_info = GELF_R_INFO(sym->idx, type);
+	reloc->rela.r_addend = addend;
 
 	if (elf_write_reloc(elf, reloc))
 		return NULL;
@@ -911,8 +911,6 @@ static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
 		return -1;
 	}
 
-	reloc->addend = rela ? reloc->rela.r_addend : 0;
-
 	return 0;
 }
 
@@ -1231,12 +1229,10 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 	struct section *rsec = reloc->sec;
 	int ret;
 
-	if (rsec->sh.sh_type == SHT_RELA) {
-		reloc->rela.r_addend = reloc->addend;
+	if (rsec->sh.sh_type == SHT_RELA)
 		ret = gelf_update_rela(rsec->data, reloc_idx(reloc), &reloc->rela);
-	} else {
+	else
 		ret = gelf_update_rel(rsec->data, reloc_idx(reloc), &reloc->rel);
-	}
 
 	if (!ret) {
 		WARN_ELF("gelf_update_rela");
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 41d2149f8bb8..be08b32a93ee 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -75,7 +75,6 @@ struct reloc {
 	struct section *sec;
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
-	s64 addend;
 	bool jump_table_start;
 };
 
@@ -217,6 +216,11 @@ static inline void set_reloc_type(struct reloc *reloc, int type)
 	reloc->rel.r_info = GELF_R_INFO(GELF_R_SYM(reloc->rel.r_info), type);
 }
 
+static inline s64 reloc_addend(struct reloc *reloc)
+{
+	return reloc->rela.r_addend;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index baa85c31526b..91b1950f5bd8 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -62,7 +62,7 @@ static void reloc_to_sec_off(struct reloc *reloc, struct section **sec,
 			     unsigned long *off)
 {
 	*sec = reloc->sym->sec;
-	*off = reloc->sym->offset + reloc->addend;
+	*off = reloc->sym->offset + reloc_addend(reloc);
 }
 
 static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
@@ -126,7 +126,7 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 				  sec, offset + entry->key);
 			return -1;
 		}
-		alt->key_addend = key_reloc->addend;
+		alt->key_addend = reloc_addend(key_reloc);
 	}
 
 	return 0;
-- 
2.40.1

