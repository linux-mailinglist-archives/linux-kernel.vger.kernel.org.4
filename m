Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5837291B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbjFIHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbjFIHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD82D7B;
        Fri,  9 Jun 2023 00:47:42 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bISO4DU1g/7Mbu+wpPAPMEkfyDiQtnKzfMa8fcPRU34=;
        b=pNFNRnwln9XzRwNw3M4AohRLQWhe/afzlSn+p8+vByuqCJay2gGQqutWt9e0PQYxzkGw0b
        PdNRiFeH6V6RZMsaMivych1PPw+2rXyjbX/x/3kBPhlRWUpWlVXGh6BTt5M8i4ttwS+mUQ
        QxQiWIxcbhab39KjCY0gqUZ0lw9pqKjBtXN6Nwef+HsR+C00OSAbDytLdVutzV0UTVW5rr
        Vw/Lm41Vq1r2I9jGQJ8Ymu9HUiEoNyLxCjkX/DzG4tn03N1Caj9WXhNgrxOSBzOEhPDFiK
        HOax/QULhu7BI5vwEkd23g/+k9AJV2DN2zgMdxAfQWY0jOB5oKVhaBxHvRIuiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bISO4DU1g/7Mbu+wpPAPMEkfyDiQtnKzfMa8fcPRU34=;
        b=TnfKiQxFgEHURUQOyZ1vAj1xMGqVFM9YEJQN9gqLF44wsdO8ZQAYGikZCTSO2vTqNH8SoA
        93siRQyEhcRRotCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Consolidate rel/rela handling
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dcabf6df400ca500ea929f1e4284f5e5ec0b27c8.1685464332.git.jpoimboe@kernel.org>
References: <dcabf6df400ca500ea929f1e4284f5e5ec0b27c8.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685730.404.12644418124752393707.tip-bot2@tip-bot2>
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

Commit-ID:     53257a977a69b5eabbaafb64dcd767d2a4fef2b3
Gitweb:        https://git.kernel.org/tip/53257a977a69b5eabbaafb64dcd767d2a4fef2b3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:20:56 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:15 -07:00

objtool: Consolidate rel/rela handling

The GElf_Rel[a] structs have more similarities than differences.  It's
safe to hard-code the assumptions about their shared fields as they will
never change.  Consolidate their handling where possible, getting rid of
duplicated code.

Also, at least for now we only ever create rela sections, so simplify
the relocation creation code to be rela-only.

Link: https://lore.kernel.org/r/dcabf6df400ca500ea929f1e4284f5e5ec0b27c8.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               |  12 +-
 tools/objtool/elf.c                 | 202 +++++++--------------------
 tools/objtool/include/objtool/elf.h |  13 +-
 3 files changed, 68 insertions(+), 159 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f4c52a2..2ab8699 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -952,7 +952,7 @@ static int create_cfi_sections(struct objtool_file *file)
 
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
-	int addrsize = elf_class_addrsize(file->elf);
+	size_t addr_size = elf_addr_size(file->elf);
 	struct instruction *insn;
 	struct section *sec;
 	int idx;
@@ -971,25 +971,25 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, "__mcount_loc", addrsize, idx);
+	sec = elf_create_section(file->elf, "__mcount_loc", addr_size, idx);
 	if (!sec)
 		return -1;
 
-	sec->sh.sh_addralign = addrsize;
+	sec->sh.sh_addralign = addr_size;
 
 	idx = 0;
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
 		void *loc;
 
 		loc = sec->data->d_buf + idx;
-		memset(loc, 0, addrsize);
+		memset(loc, 0, addr_size);
 
 		if (elf_add_reloc_to_insn(file->elf, sec, idx,
-					  addrsize == sizeof(u64) ? R_ABS64 : R_ABS32,
+					  addr_size == sizeof(u64) ? R_ABS64 : R_ABS32,
 					  insn->sec, insn->offset))
 			return -1;
 
-		idx += addrsize;
+		idx += addr_size;
 	}
 
 	return 0;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 86ae62d..4bbdd8e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -533,16 +533,15 @@ err:
 	return -1;
 }
 
-static struct section *elf_create_reloc_section(struct elf *elf,
-						struct section *sec,
-						int reltype);
+static struct section *elf_create_rela_section(struct elf *elf,
+					       struct section *sec);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, s64 addend)
 {
 	struct reloc *reloc;
 
-	if (!sec->rsec && !elf_create_reloc_section(elf, sec, SHT_RELA))
+	if (!sec->rsec && !elf_create_rela_section(elf, sec))
 		return -1;
 
 	reloc = malloc(sizeof(*reloc));
@@ -865,29 +864,25 @@ int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 	return elf_add_reloc(elf, sec, offset, type, sym, addend);
 }
 
-static int read_rel_reloc(struct section *rsec, int i, struct reloc *reloc, unsigned int *symndx)
+static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
 {
-	if (!gelf_getrel(rsec->data, i, &reloc->rel)) {
-		WARN_ELF("gelf_getrel");
-		return -1;
-	}
-	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
-	reloc->addend = 0;
-	reloc->offset = reloc->rel.r_offset;
-	*symndx = GELF_R_SYM(reloc->rel.r_info);
-	return 0;
-}
+	bool rela = rsec->sh.sh_type == SHT_RELA;
+	void *retp;
 
-static int read_rela_reloc(struct section *rsec, int i, struct reloc *reloc, unsigned int *symndx)
-{
-	if (!gelf_getrela(rsec->data, i, &reloc->rela)) {
+	if (rela)
+		retp = gelf_getrela(rsec->data, i, &reloc->rela);
+	else
+		retp = gelf_getrel(rsec->data, i, &reloc->rel);
+
+	if (!retp) {
 		WARN_ELF("gelf_getrela");
 		return -1;
 	}
-	reloc->type = GELF_R_TYPE(reloc->rela.r_info);
-	reloc->addend = reloc->rela.r_addend;
-	reloc->offset = reloc->rela.r_offset;
-	*symndx = GELF_R_SYM(reloc->rela.r_info);
+
+	reloc->offset = reloc->rel.r_offset;
+	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
+	reloc->addend = rela ? reloc->rela.r_addend : 0;
+
 	return 0;
 }
 
@@ -926,20 +921,13 @@ static int read_relocs(struct elf *elf)
 		}
 		for (i = 0; i < rsec->sh.sh_size / rsec->sh.sh_entsize; i++) {
 			reloc = &rsec->reloc_data[i];
-			switch (rsec->sh.sh_type) {
-			case SHT_REL:
-				if (read_rel_reloc(rsec, i, reloc, &symndx))
-					return -1;
-				break;
-			case SHT_RELA:
-				if (read_rela_reloc(rsec, i, reloc, &symndx))
-					return -1;
-				break;
-			default: return -1;
-			}
+
+			if (read_reloc(rsec, i, reloc))
+				return -1;
 
 			reloc->sec = rsec;
 			reloc->idx = i;
+			symndx = GELF_R_SYM(reloc->rel.r_info);
 			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
 				WARN("can't find reloc entry symbol %d for %s",
@@ -1141,86 +1129,42 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	return sec;
 }
 
-static struct section *elf_create_rel_reloc_section(struct elf *elf,
-						    struct section *sec)
+static struct section *elf_create_rela_section(struct elf *elf,
+					       struct section *sec)
 {
-	char *relocname;
 	struct section *rsec;
+	char *rsec_name;
 
-	relocname = malloc(strlen(sec->name) + strlen(".rel") + 1);
-	if (!relocname) {
+	rsec_name = malloc(strlen(sec->name) + strlen(".rela") + 1);
+	if (!rsec_name) {
 		perror("malloc");
 		return NULL;
 	}
-	strcpy(relocname, ".rel");
-	strcat(relocname, sec->name);
+	strcpy(rsec_name, ".rela");
+	strcat(rsec_name, sec->name);
 
-	rsec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
-	free(relocname);
+	rsec = elf_create_section(elf, rsec_name, elf_rela_size(elf), 0);
+	free(rsec_name);
 	if (!rsec)
 		return NULL;
 
 	sec->rsec = rsec;
 	rsec->base = sec;
 
-	rsec->sh.sh_type = SHT_REL;
-	rsec->sh.sh_addralign = 8;
-	rsec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
-	rsec->sh.sh_info = sec->idx;
-	rsec->sh.sh_flags = SHF_INFO_LINK;
-
-	return rsec;
-}
-
-static struct section *elf_create_rela_reloc_section(struct elf *elf, struct section *base)
-{
-	char *relocname;
-	struct section *rsec;
-	int addrsize = elf_class_addrsize(elf);
-
-	relocname = malloc(strlen(base->name) + strlen(".rela") + 1);
-	if (!relocname) {
-		perror("malloc");
-		return NULL;
-	}
-	strcpy(relocname, ".rela");
-	strcat(relocname, base->name);
-
-	if (addrsize == sizeof(u32))
-		rsec = elf_create_section(elf, relocname, sizeof(Elf32_Rela), 0);
-	else
-		rsec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
-	free(relocname);
-	if (!rsec)
-		return NULL;
-
-	base->rsec = rsec;
-	rsec->base = base;
-
 	rsec->sh.sh_type = SHT_RELA;
-	rsec->sh.sh_addralign = addrsize;
+	rsec->sh.sh_addralign = elf_addr_size(elf);
 	rsec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
-	rsec->sh.sh_info = base->idx;
+	rsec->sh.sh_info = sec->idx;
 	rsec->sh.sh_flags = SHF_INFO_LINK;
 
 	return rsec;
 }
 
-static struct section *elf_create_reloc_section(struct elf *elf,
-					 struct section *base,
-					 int reltype)
-{
-	switch (reltype) {
-	case SHT_REL:  return elf_create_rel_reloc_section(elf, base);
-	case SHT_RELA: return elf_create_rela_reloc_section(elf, base);
-	default:       return NULL;
-	}
-}
-
-static int elf_rebuild_rel_reloc_section(struct section *rsec)
+static int elf_rebuild_reloc_section(struct elf *elf, struct section *rsec)
 {
+	bool rela = rsec->sh.sh_type == SHT_RELA;
 	struct reloc *reloc;
-	int idx = 0;
+	int idx = 0, ret;
 	void *buf;
 
 	/* Allocate a buffer for relocations */
@@ -1232,46 +1176,20 @@ static int elf_rebuild_rel_reloc_section(struct section *rsec)
 
 	rsec->data->d_buf = buf;
 	rsec->data->d_size = rsec->sh.sh_size;
-	rsec->data->d_type = ELF_T_REL;
+	rsec->data->d_type = rela ? ELF_T_RELA : ELF_T_REL;
 
 	idx = 0;
 	list_for_each_entry(reloc, &rsec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		if (!gelf_update_rel(rsec->data, idx, &reloc->rel)) {
-			WARN_ELF("gelf_update_rel");
-			return -1;
+		if (rela) {
+			reloc->rela.r_addend = reloc->addend;
+			ret = gelf_update_rela(rsec->data, idx, &reloc->rela);
+		} else {
+			ret = gelf_update_rel(rsec->data, idx, &reloc->rel);
 		}
-		idx++;
-	}
-
-	return 0;
-}
-
-static int elf_rebuild_rela_reloc_section(struct section *rsec)
-{
-	struct reloc *reloc;
-	int idx = 0;
-	void *buf;
-
-	/* Allocate a buffer for relocations with addends */
-	buf = malloc(rsec->sh.sh_size);
-	if (!buf) {
-		perror("malloc");
-		return -1;
-	}
-
-	rsec->data->d_buf = buf;
-	rsec->data->d_size = rsec->sh.sh_size;
-	rsec->data->d_type = ELF_T_RELA;
-
-	idx = 0;
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
-		reloc->rela.r_offset = reloc->offset;
-		reloc->rela.r_addend = reloc->addend;
-		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		if (!gelf_update_rela(rsec->data, idx, &reloc->rela)) {
-			WARN_ELF("gelf_update_rela");
+		if (!ret) {
+			WARN_ELF("gelf_update_rel");
 			return -1;
 		}
 		idx++;
@@ -1280,15 +1198,6 @@ static int elf_rebuild_rela_reloc_section(struct section *rsec)
 	return 0;
 }
 
-static int elf_rebuild_reloc_section(struct elf *elf, struct section *rsec)
-{
-	switch (rsec->sh.sh_type) {
-	case SHT_REL:  return elf_rebuild_rel_reloc_section(rsec);
-	case SHT_RELA: return elf_rebuild_rela_reloc_section(rsec);
-	default:       return -1;
-	}
-}
-
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn)
@@ -1311,24 +1220,21 @@ int elf_write_insn(struct elf *elf, struct section *sec,
 int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 {
 	struct section *rsec = reloc->sec;
+	int ret;
 
-	if (rsec->sh.sh_type == SHT_REL) {
-		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		reloc->rel.r_offset = reloc->offset;
+	reloc->rel.r_offset = reloc->offset;
+	reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
 
-		if (!gelf_update_rel(rsec->data, reloc->idx, &reloc->rel)) {
-			WARN_ELF("gelf_update_rel");
-			return -1;
-		}
-	} else {
-		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+	if (rsec->sh.sh_type == SHT_RELA) {
 		reloc->rela.r_addend = reloc->addend;
-		reloc->rela.r_offset = reloc->offset;
+		ret = gelf_update_rela(rsec->data, reloc->idx, &reloc->rela);
+	} else {
+		ret = gelf_update_rel(rsec->data, reloc->idx, &reloc->rel);
+	}
 
-		if (!gelf_update_rela(rsec->data, reloc->idx, &reloc->rela)) {
-			WARN_ELF("gelf_update_rela");
-			return -1;
-		}
+	if (!ret) {
+		WARN_ELF("gelf_update_rela");
+		return -1;
 	}
 
 	elf->changed = true;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a4e43a6..6f82f25 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -12,6 +12,7 @@
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
 #include <linux/jhash.h>
+#include <arch/elf.h>
 
 #ifdef LIBELF_USE_DEPRECATED
 # define elf_getshdrnum    elf_getshnum
@@ -147,12 +148,14 @@ static inline bool has_multiple_files(struct elf *elf)
 	return elf->num_files > 1;
 }
 
-static inline int elf_class_addrsize(struct elf *elf)
+static inline size_t elf_addr_size(struct elf *elf)
 {
-	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
-		return sizeof(u32);
-	else
-		return sizeof(u64);
+	return elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32 ? 4 : 8;
+}
+
+static inline size_t elf_rela_size(struct elf *elf)
+{
+	return elf_addr_size(elf) == 4 ? sizeof(Elf32_Rela) : sizeof(Elf64_Rela);
 }
 
 #define for_each_sec(file, sec)						\
