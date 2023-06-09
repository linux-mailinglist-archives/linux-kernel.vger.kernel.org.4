Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770F7291A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbjFIHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjFIHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1430D1;
        Fri,  9 Jun 2023 00:47:29 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1mwN28ikUFnCodV3ejcYE9sR44dgkghNYZ3MXhBSAE=;
        b=YBo9vb0VL8LjFkZjKJRFl1ei4+O4WEq+QIfPwECHJi/Vjzla+PBsuLGgP5+TpGn0qt30J4
        LOHVqVtA4Oi6f0WquavtnEVaoc7BcYulXrRUkeLKoGKuFtHxtAxAB/Na+SBuakhY5iOqR8
        kDwvxRslAOFpwak39VJAO0zTIF9QSPsmARoNm6xdzBonDI5SjyF5gMRMhQ3x0VWtEOj5Tw
        jjKE1u7JmkJbgPUBKv+LrB0C11L253RbcoZMJffiaFVy4zaM8p6ZzpajVNSJir5ZN0IsaO
        AraiAcwI2mC4rKB5IuxJqZjabz85ali90Oc0+RTWgEOOcYbv+XhzExwY8p2n2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1mwN28ikUFnCodV3ejcYE9sR44dgkghNYZ3MXhBSAE=;
        b=KR9djzjEffkndSjBRjYX54vwshY1RMedurz1e9Pnm+RgeMIsPLk9qtCRSZWdwwdnaKD0HC
        ckwsytT1MFRj5CAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->rel[a]
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2be32323de6d8cc73179ee0ff14b71f4e7cefaa0.1685464332.git.jpoimboe@kernel.org>
References: <2be32323de6d8cc73179ee0ff14b71f4e7cefaa0.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684711.404.3309531830197954025.tip-bot2@tip-bot2>
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

Commit-ID:     ec24b927c1fbfc91cf7a48276d9fd92072b17d3b
Gitweb:        https://git.kernel.org/tip/ec24b927c1fbfc91cf7a48276d9fd92072b17d3b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:12 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:26 -07:00

objtool: Get rid of reloc->rel[a]

Get the relocation entry info from the underlying rsec->data.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 35.12G
- After:  peak heap memory consumption: 29.93G

Link: https://lore.kernel.org/r/2be32323de6d8cc73179ee0ff14b71f4e7cefaa0.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 20 ++----
 tools/objtool/elf.c                 | 60 ++----------------
 tools/objtool/include/objtool/elf.h | 94 ++++++++++++++++++++++++----
 3 files changed, 96 insertions(+), 78 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7fb6467..47ff130 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -968,7 +968,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		if (!reloc)
 			return -1;
 
-		set_reloc_type(reloc, addr_size == 8 ? R_ABS64 : R_ABS32);
+		set_reloc_type(file->elf, reloc, addr_size == 8 ? R_ABS64 : R_ABS32);
 
 		idx++;
 	}
@@ -1363,10 +1363,8 @@ static void annotate_call_site(struct objtool_file *file,
 	 * noinstr text.
 	 */
 	if (opts.hack_noinstr && insn->sec->noinstr && sym->profiling_func) {
-		if (reloc) {
-			set_reloc_type(reloc, R_NONE);
-			elf_write_reloc(file->elf, reloc);
-		}
+		if (reloc)
+			set_reloc_type(file->elf, reloc, R_NONE);
 
 		elf_write_insn(file->elf, insn->sec,
 			       insn->offset, insn->len,
@@ -1392,10 +1390,8 @@ static void annotate_call_site(struct objtool_file *file,
 		if (sibling)
 			WARN_INSN(insn, "tail call to __fentry__ !?!?");
 		if (opts.mnop) {
-			if (reloc) {
-				set_reloc_type(reloc, R_NONE);
-				elf_write_reloc(file->elf, reloc);
-			}
+			if (reloc)
+				set_reloc_type(file->elf, reloc, R_NONE);
 
 			elf_write_insn(file->elf, insn->sec,
 				       insn->offset, insn->len,
@@ -1874,10 +1870,8 @@ static int handle_jump_alt(struct objtool_file *file,
 	if (opts.hack_jump_label && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
-		if (reloc) {
-			set_reloc_type(reloc, R_NONE);
-			elf_write_reloc(file->elf, reloc);
-		}
+		if (reloc)
+			set_reloc_type(file->elf, reloc, R_NONE);
 		elf_write_insn(file->elf, orig_insn->sec,
 			       orig_insn->offset, orig_insn->len,
 			       arch_nop_insn(orig_insn->len));
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 04038b1..54d182d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -575,11 +575,8 @@ static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
 {
 	struct reloc *reloc;
 
-	for (reloc = sym->relocs; reloc; reloc = reloc->sym_next_reloc) {
-		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc_type(reloc));
-		if (elf_write_reloc(elf, reloc))
-			return -1;
-	}
+	for (reloc = sym->relocs; reloc; reloc = reloc->sym_next_reloc)
+		set_reloc_sym(elf, reloc, reloc->sym->idx);
 
 	return 0;
 }
@@ -869,12 +866,10 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	reloc->sec = rsec;
 	reloc->sym = sym;
 
-	reloc->rel.r_offset = offset;
-	reloc->rel.r_info = GELF_R_INFO(sym->idx, type);
-	reloc->rela.r_addend = addend;
-
-	if (elf_write_reloc(elf, reloc))
-		return NULL;
+	set_reloc_offset(elf, reloc, offset);
+	set_reloc_sym(elf, reloc, sym->idx);
+	set_reloc_type(elf, reloc, type);
+	set_reloc_addend(elf, reloc, addend);
 
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 	reloc->sym_next_reloc = sym->relocs;
@@ -932,24 +927,6 @@ struct reloc *elf_init_reloc_data_sym(struct elf *elf, struct section *sec,
 			      elf_data_rela_type(elf));
 }
 
-static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
-{
-	bool rela = rsec->sh.sh_type == SHT_RELA;
-	void *retp;
-
-	if (rela)
-		retp = gelf_getrela(rsec->data, i, &reloc->rela);
-	else
-		retp = gelf_getrel(rsec->data, i, &reloc->rel);
-
-	if (!retp) {
-		WARN_ELF("gelf_getrela");
-		return -1;
-	}
-
-	return 0;
-}
-
 static int read_relocs(struct elf *elf)
 {
 	unsigned long nr_reloc, max_reloc = 0;
@@ -984,11 +961,8 @@ static int read_relocs(struct elf *elf)
 		for (i = 0; i < sec_num_entries(rsec); i++) {
 			reloc = &rsec->relocs[i];
 
-			if (read_reloc(rsec, i, reloc))
-				return -1;
-
 			reloc->sec = rsec;
-			symndx = GELF_R_SYM(reloc->rel.r_info);
+			symndx = reloc_sym(reloc);
 			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
 				WARN("can't find reloc entry symbol %d for %s",
@@ -1261,26 +1235,6 @@ int elf_write_insn(struct elf *elf, struct section *sec,
 	return 0;
 }
 
-int elf_write_reloc(struct elf *elf, struct reloc *reloc)
-{
-	struct section *rsec = reloc->sec;
-	int ret;
-
-	if (rsec->sh.sh_type == SHT_RELA)
-		ret = gelf_update_rela(rsec->data, reloc_idx(reloc), &reloc->rela);
-	else
-		ret = gelf_update_rel(rsec->data, reloc_idx(reloc), &reloc->rel);
-
-	if (!ret) {
-		WARN_ELF("gelf_update_rela");
-		return -1;
-	}
-
-	mark_sec_changed(elf, rsec, true);
-
-	return 0;
-}
-
 /*
  * When Elf_Scn::sh_size is smaller than the combined Elf_Data::d_size
  * do you:
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 03a9040..c532d70 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -72,10 +72,6 @@ struct symbol {
 
 struct reloc {
 	struct elf_hash_node hash;
-	union {
-		GElf_Rela rela;
-		GElf_Rel  rel;
-	};
 	struct section *sec;
 	struct symbol *sym;
 	struct reloc *sym_next_reloc;
@@ -132,7 +128,6 @@ struct reloc *elf_init_reloc_data_sym(struct elf *elf, struct section *sec,
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
-int elf_write_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
@@ -204,24 +199,99 @@ static inline unsigned int reloc_idx(struct reloc *reloc)
 	return reloc - reloc->sec->relocs;
 }
 
-static inline unsigned long reloc_offset(struct reloc *reloc)
+static inline void *reloc_rel(struct reloc *reloc)
 {
-	return reloc->rel.r_offset;
+	struct section *rsec = reloc->sec;
+
+	return rsec->data->d_buf + (reloc_idx(reloc) * rsec->sh.sh_entsize);
 }
 
-static inline unsigned int reloc_type(struct reloc *reloc)
+static inline bool is_32bit_reloc(struct reloc *reloc)
 {
-	return GELF_R_TYPE(reloc->rel.r_info);
+	/*
+	 * Elf32_Rel:   8 bytes
+	 * Elf32_Rela: 12 bytes
+	 * Elf64_Rel:  16 bytes
+	 * Elf64_Rela: 24 bytes
+	 */
+	return reloc->sec->sh.sh_entsize < 16;
 }
 
-static inline void set_reloc_type(struct reloc *reloc, int type)
+#define __get_reloc_field(reloc, field)					\
+({									\
+	is_32bit_reloc(reloc) ?						\
+		((Elf32_Rela *)reloc_rel(reloc))->field :		\
+		((Elf64_Rela *)reloc_rel(reloc))->field;		\
+})
+
+#define __set_reloc_field(reloc, field, val)				\
+({									\
+	if (is_32bit_reloc(reloc))					\
+		((Elf32_Rela *)reloc_rel(reloc))->field = val;		\
+	else								\
+		((Elf64_Rela *)reloc_rel(reloc))->field = val;		\
+})
+
+static inline u64 reloc_offset(struct reloc *reloc)
 {
-	reloc->rel.r_info = GELF_R_INFO(GELF_R_SYM(reloc->rel.r_info), type);
+	return __get_reloc_field(reloc, r_offset);
+}
+
+static inline void set_reloc_offset(struct elf *elf, struct reloc *reloc, u64 offset)
+{
+	__set_reloc_field(reloc, r_offset, offset);
+	mark_sec_changed(elf, reloc->sec, true);
 }
 
 static inline s64 reloc_addend(struct reloc *reloc)
 {
-	return reloc->rela.r_addend;
+	return __get_reloc_field(reloc, r_addend);
+}
+
+static inline void set_reloc_addend(struct elf *elf, struct reloc *reloc, s64 addend)
+{
+	__set_reloc_field(reloc, r_addend, addend);
+	mark_sec_changed(elf, reloc->sec, true);
+}
+
+
+static inline unsigned int reloc_sym(struct reloc *reloc)
+{
+	u64 info = __get_reloc_field(reloc, r_info);
+
+	return is_32bit_reloc(reloc) ?
+		ELF32_R_SYM(info) :
+		ELF64_R_SYM(info);
+}
+
+static inline unsigned int reloc_type(struct reloc *reloc)
+{
+	u64 info = __get_reloc_field(reloc, r_info);
+
+	return is_32bit_reloc(reloc) ?
+		ELF32_R_TYPE(info) :
+		ELF64_R_TYPE(info);
+}
+
+static inline void set_reloc_sym(struct elf *elf, struct reloc *reloc, unsigned int sym)
+{
+	u64 info = is_32bit_reloc(reloc) ?
+		ELF32_R_INFO(sym, reloc_type(reloc)) :
+		ELF64_R_INFO(sym, reloc_type(reloc));
+
+	__set_reloc_field(reloc, r_info, info);
+
+	mark_sec_changed(elf, reloc->sec, true);
+}
+static inline void set_reloc_type(struct elf *elf, struct reloc *reloc, unsigned int type)
+{
+	u64 info = is_32bit_reloc(reloc) ?
+		ELF32_R_INFO(reloc_sym(reloc), type) :
+		ELF64_R_INFO(reloc_sym(reloc), type);
+
+	__set_reloc_field(reloc, r_info, info);
+
+	mark_sec_changed(elf, reloc->sec, true);
 }
 
 #define for_each_sec(file, sec)						\
