Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B577291A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbjFIHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbjFIHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6C30F1;
        Fri,  9 Jun 2023 00:47:40 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hMvckovWV0Su7Y8591yzljaU250O3AXpFJGucY7o/Q=;
        b=urZnutp60f+Omv4dHTmHCQZrYwCynZia6n8o1jRPyfhNXK4DbMELtDYUT8TZ1aQh5lt9oR
        qENuD0Sy+R+qlrAvAzqIit8fHp7tLT8HD8tlNa1wmw0IOgCk8NG+hSd0JS6fWmaY74npaF
        Lr/vyqOb8iqY5Fngwj3NFzbn6wb7Au6WwWuPINZZh/ICVIcrECmj9IxJAyjjWjdkM9f32D
        Tt8SUs8ciVhlNnPsb+caU/W6W71efrKlfj0lLHzKEBFBkPRHIvD7x1OxeLHmTQ8CloUJ06
        8Z/YO7fk5tI+7M/gEjivas72fLAfj4Y6ENOHduf4V2+vkfQFyarfWN89TPU5ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hMvckovWV0Su7Y8591yzljaU250O3AXpFJGucY7o/Q=;
        b=4yVpv7NnZkyCBFdm7kn+EN14s3/TjwQhHnVOtbQLSzdx2y4YK3VXT0u3TEwgkxLdZTzejf
        5tORczZUYejve5CA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->list
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <71e7a2c017dbc46bb497857ec97d67214f832d10.1685464332.git.jpoimboe@kernel.org>
References: <71e7a2c017dbc46bb497857ec97d67214f832d10.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685221.404.4241720251740781.tip-bot2@tip-bot2>
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

Commit-ID:     ebcef730a19ba7ca446169f391d2e51722d68043
Gitweb:        https://git.kernel.org/tip/ebcef730a19ba7ca446169f391d2e51722d68043
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:04 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:20 -07:00

objtool: Get rid of reloc->list

Now that all relocs are allocated in an array, the linked list is no
longer needed.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 49.02G
- After:  peak heap memory consumption: 45.56G

Link: https://lore.kernel.org/r/71e7a2c017dbc46bb497857ec97d67214f832d10.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 32 +++++++++++-----------------
 tools/objtool/include/objtool/elf.h | 18 +++++++++++-----
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5f69d45..19ac53a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -293,7 +293,6 @@ static int read_sections(struct elf *elf)
 		sec = &elf->section_data[i];
 
 		INIT_LIST_HEAD(&sec->symbol_list);
-		INIT_LIST_HEAD(&sec->reloc_list);
 
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
@@ -333,7 +332,7 @@ static int read_sections(struct elf *elf)
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 
 		if (is_reloc_sec(sec))
-			elf->num_relocs += sec->sh.sh_size / sec->sh.sh_entsize;
+			elf->num_relocs += sec_num_entries(sec);
 	}
 
 	if (opts.stats) {
@@ -407,7 +406,7 @@ static int read_symbols(struct elf *elf)
 		if (symtab_shndx)
 			shndx_data = symtab_shndx->data;
 
-		symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
+		symbols_nr = sec_num_entries(symtab);
 	} else {
 		/*
 		 * A missing symbol table is actually possible if it's an empty
@@ -701,7 +700,7 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 		return NULL;
 	}
 
-	new_idx = symtab->sh.sh_size / symtab->sh.sh_entsize;
+	new_idx = sec_num_entries(symtab);
 
 	if (GELF_ST_BIND(sym->sym.st_info) != STB_LOCAL)
 		goto non_local;
@@ -816,13 +815,13 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 {
 	struct reloc *reloc, empty = { 0 };
 
-	if (reloc_idx >= rsec->sh.sh_size / elf_rela_size(elf)) {
-		WARN("%s: bad reloc_idx %u for %s with size 0x%lx",
-		     __func__, reloc_idx, rsec->name, rsec->sh.sh_size);
+	if (reloc_idx >= sec_num_entries(rsec)) {
+		WARN("%s: bad reloc_idx %u for %s with %d relocs",
+		     __func__, reloc_idx, rsec->name, sec_num_entries(rsec));
 		return NULL;
 	}
 
-	reloc = &rsec->reloc_data[reloc_idx];
+	reloc = &rsec->relocs[reloc_idx];
 
 	if (memcmp(reloc, &empty, sizeof(empty))) {
 		WARN("%s: %s: reloc %d already initialized!",
@@ -841,7 +840,6 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 		return NULL;
 
 	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
-	list_add_tail(&reloc->list, &rsec->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 	return reloc;
@@ -944,14 +942,13 @@ static int read_relocs(struct elf *elf)
 		rsec->base->rsec = rsec;
 
 		nr_reloc = 0;
-		rsec->reloc_data = calloc(rsec->sh.sh_size / rsec->sh.sh_entsize,
-					  sizeof(*reloc));
-		if (!rsec->reloc_data) {
+		rsec->relocs = calloc(sec_num_entries(rsec), sizeof(*reloc));
+		if (!rsec->relocs) {
 			perror("calloc");
 			return -1;
 		}
-		for (i = 0; i < rsec->sh.sh_size / rsec->sh.sh_entsize; i++) {
-			reloc = &rsec->reloc_data[i];
+		for (i = 0; i < sec_num_entries(rsec); i++) {
+			reloc = &rsec->relocs[i];
 
 			if (read_reloc(rsec, i, reloc))
 				return -1;
@@ -967,7 +964,6 @@ static int read_relocs(struct elf *elf)
 			}
 
 			list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
-			list_add_tail(&reloc->list, &rsec->reloc_list);
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 			nr_reloc++;
@@ -1093,7 +1089,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	memset(sec, 0, sizeof(*sec));
 
 	INIT_LIST_HEAD(&sec->symbol_list);
-	INIT_LIST_HEAD(&sec->reloc_list);
 
 	s = elf_newscn(elf->elf);
 	if (!s) {
@@ -1186,9 +1181,8 @@ static struct section *elf_create_rela_section(struct elf *elf,
 	rsec->sh.sh_info = sec->idx;
 	rsec->sh.sh_flags = SHF_INFO_LINK;
 
-	rsec->reloc_data = calloc(rsec->sh.sh_size / rsec->sh.sh_entsize,
-				  sizeof(struct reloc));
-	if (!rsec->reloc_data) {
+	rsec->relocs = calloc(sec_num_entries(rsec), sizeof(struct reloc));
+	if (!rsec->relocs) {
 		perror("calloc");
 		return NULL;
 	}
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a938cb1..a09da20 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -33,14 +33,13 @@ struct section {
 	GElf_Shdr sh;
 	struct rb_root_cached symbol_tree;
 	struct list_head symbol_list;
-	struct list_head reloc_list;
 	struct section *base, *rsec;
 	struct symbol *sym;
 	Elf_Data *data;
 	char *name;
 	int idx;
 	bool _changed, text, rodata, noinstr, init, truncate;
-	struct reloc *reloc_data;
+	struct reloc *relocs;
 };
 
 struct symbol {
@@ -68,7 +67,6 @@ struct symbol {
 };
 
 struct reloc {
-	struct list_head list;
 	struct hlist_node hash;
 	union {
 		GElf_Rela rela;
@@ -197,6 +195,11 @@ static inline void mark_sec_changed(struct elf *elf, struct section *sec,
 	elf->changed |= changed;
 }
 
+static inline unsigned int sec_num_entries(struct section *sec)
+{
+	return sec->sh.sh_size / sec->sh.sh_entsize;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
@@ -210,10 +213,15 @@ static inline void mark_sec_changed(struct elf *elf, struct section *sec,
 			sec_for_each_sym(__sec, sym)
 
 #define for_each_reloc(rsec, reloc)					\
-	list_for_each_entry(reloc, &rsec->reloc_list, list)
+	for (int __i = 0, __fake = 1; __fake; __fake = 0)		\
+		for (reloc = rsec->relocs;				\
+		     __i < sec_num_entries(rsec);			\
+		     __i++, reloc++)
 
 #define for_each_reloc_from(rsec, reloc)				\
-	list_for_each_entry_from(reloc, &rsec->reloc_list, list)
+	for (int __i = reloc->idx;					\
+	     __i < sec_num_entries(rsec);				\
+	     __i++, reloc++)
 
 #define OFFSET_STRIDE_BITS	4
 #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
