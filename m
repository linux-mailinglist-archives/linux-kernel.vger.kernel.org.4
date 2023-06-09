Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79BF72919C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbjFIHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbjFIHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5E30DA;
        Fri,  9 Jun 2023 00:47:36 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhonaPLNHziSdGh+w51FNXAaoIs/kTMByksqN94vphw=;
        b=Hw3u76FqyDPyBB9mJ8Gf34H+3ACnNXPsbMCv5nQR9K/fvCI2cits8JigcmWBgZwO32xCZx
        TDhyTAs14/FaiexDC0XZ4kagHmE5EmI1PuPeb/t9RKsYrBFUchvzn5f3SVlWhhAEvtroKP
        qdmbKEeXiHY+Xd5rF0UUA/MLFAhmvbCi+GOoM1zFcIXBo47X0OzoylIj5WNVwohNCblX30
        r1sJXJ8ug8l8pIoiK3aGNXzVCwTxNMd776NNiWGhul1H57h7x3W0p/WY7FzO7Ah0hW3eKf
        GOtE7QTNkuhy34XiMuOw1Zs7TjJtRZ5bQ6LmsSN4H2FlXKYx8xDfdTSuKxjHOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhonaPLNHziSdGh+w51FNXAaoIs/kTMByksqN94vphw=;
        b=Etxv/Ypb9tVf7U0DJxIQIMWkW5GqQOXMVNOjuCrV2H277vj8FJ0ZTIXC0HTBm+awdwq52C
        87NA4YV9oO+R2BAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->addend
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ad2354f95d9ddd86094e3f7687acfa0750657784.1685464332.git.jpoimboe@kernel.org>
References: <ad2354f95d9ddd86094e3f7687acfa0750657784.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684971.404.5745844395090770076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0696b6e314dbe4bd2f24d5e749469f57ea095a9f
Gitweb:        https://git.kernel.org/tip/0696b6e314dbe4bd2f24d5e749469f57ea095a9f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:08 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:23 -07:00

objtool: Get rid of reloc->addend

Get the addend from the embedded GElf_Rel[a] struct.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 42.10G
- After:  peak heap memory consumption: 40.37G

Link: https://lore.kernel.org/r/ad2354f95d9ddd86094e3f7687acfa0750657784.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c     |  4 +-
 tools/objtool/arch/x86/special.c    |  2 +-
 tools/objtool/check.c               | 69 ++++++++++++++++------------
 tools/objtool/elf.c                 | 10 +---
 tools/objtool/include/objtool/elf.h |  6 +-
 tools/objtool/special.c             |  4 +-
 6 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index ffb12e8..2e1caab 100644
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
index 1a54a24..65f48f3 100644
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
index 04b4152..745487d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -509,7 +509,8 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 
 		func = reloc->sym;
 		if (func->type == STT_SECTION)
-			func = find_symbol_by_offset(reloc->sym->sec, reloc->addend);
+			func = find_symbol_by_offset(reloc->sym->sec,
+						     reloc_addend(reloc));
 
 		idx = (reloc_offset(reloc) - sym->offset) / sizeof(unsigned long);
 
@@ -583,6 +584,7 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
+	s64 addend;
 
 	/*
 	 * Check for manually annotated dead ends.
@@ -592,23 +594,27 @@ static int add_dead_ends(struct objtool_file *file)
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
 
@@ -627,23 +633,27 @@ reachable:
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
 
@@ -1026,7 +1036,7 @@ static void add_ignores(struct objtool_file *file)
 			break;
 
 		case STT_SECTION:
-			func = find_func_by_offset(reloc->sym->sec, reloc->addend);
+			func = find_func_by_offset(reloc->sym->sec, reloc_addend(reloc));
 			if (!func)
 				continue;
 			break;
@@ -1266,7 +1276,7 @@ static int add_ignore_alternatives(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.ignore_alts entry");
 			return -1;
@@ -1542,7 +1552,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			dest_off = arch_jump_destination(insn);
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
-			dest_off = arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc_addend(reloc));
 		} else if (reloc->sym->retpoline_thunk) {
 			add_retpoline_call(file, insn);
 			continue;
@@ -1559,7 +1569,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
 			dest_off = reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc->addend);
+				   arch_dest_reloc_offset(reloc_addend(reloc));
 		} else {
 			/* non-func asm code jumping to another file */
 			continue;
@@ -1676,7 +1686,7 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (reloc->sym->type == STT_SECTION) {
-			dest_off = arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc_addend(reloc));
 			dest = find_call_destination(reloc->sym->sec, dest_off);
 			if (!dest) {
 				WARN_INSN(insn, "can't find call dest symbol at %s+0x%lx",
@@ -2003,10 +2013,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 
 		/* Detect function pointers from contiguous objects: */
 		if (reloc->sym->sec == pfunc->sec &&
-		    reloc->addend == pfunc->offset)
+		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!dest_insn)
 			break;
 
@@ -2067,7 +2077,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		table_reloc = arch_find_switch_table(file, insn);
 		if (!table_reloc)
 			continue;
-		dest_insn = find_insn(file, table_reloc->sym->sec, table_reloc->addend);
+		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
@@ -2203,7 +2213,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("can't find insn for unwind_hints[%d]", i);
 			return -1;
@@ -2271,7 +2281,8 @@ static int read_noendbr_hints(struct objtool_file *file)
 		return 0;
 
 	for_each_reloc(rsec, reloc) {
-		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
+		insn = find_insn(file, reloc->sym->sec,
+				 reloc->sym->offset + reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.noendbr entry");
 			return -1;
@@ -2299,7 +2310,7 @@ static int read_retpoline_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.retpoline_safe entry");
 			return -1;
@@ -2335,7 +2346,7 @@ static int read_instr_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.instr_end entry");
 			return -1;
@@ -2354,7 +2365,7 @@ static int read_instr_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.instr_begin entry");
 			return -1;
@@ -2382,7 +2393,7 @@ static int read_validate_unret_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.instr_end entry");
 			return -1;
@@ -2413,7 +2424,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 			return -1;
 		}
 
-		insn = find_insn(file, reloc->sym->sec, reloc->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!insn) {
 			WARN("bad .discard.intra_function_call entry");
 			return -1;
@@ -3317,7 +3328,7 @@ static inline const char *call_dest_name(struct instruction *insn)
 
 	reloc = insn_reloc(NULL, insn);
 	if (reloc && !strcmp(reloc->sym->name, "pv_ops")) {
-		idx = (reloc->addend / sizeof(void *));
+		idx = (reloc_addend(reloc) / sizeof(void *));
 		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
 		return pvname;
 	}
@@ -3335,7 +3346,7 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	if (!reloc || strcmp(reloc->sym->name, "pv_ops"))
 		return false;
 
-	idx = (arch_dest_reloc_offset(reloc->addend) / sizeof(void *));
+	idx = (arch_dest_reloc_offset(reloc_addend(reloc)) / sizeof(void *));
 
 	if (file->pv_ops[idx].clean)
 		return true;
@@ -4279,9 +4290,9 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
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
@@ -4338,7 +4349,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 	struct instruction *dest;
 
 	dest = find_insn(file, reloc->sym->sec,
-			 reloc->sym->offset + reloc->addend);
+			 reloc->sym->offset + reloc_addend(reloc));
 	if (!dest)
 		return 0;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be9d24d..16e019a 100644
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
index 41d2149..be08b32 100644
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
index baa85c3..91b1950 100644
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
