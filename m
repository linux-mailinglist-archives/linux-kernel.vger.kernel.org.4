Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB0716AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjE3RWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjE3RVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564EE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85E963134
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BFBC4339C;
        Tue, 30 May 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467296;
        bh=SzgZPlsWLNkI7F0pgFK7KJ4T9CY98WR4ayNrJxiorE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUXDqUKIDIImmiZODxKha9iN5Q5GMhFqDe7ZB+R7+5YeCCtP/RR4xoeHSA3c09NsQ
         D1ngrfqvcapjbqIb9sJw4TRF/XkjipantOIA7GB4gQmIHJT/pGW6qaY0x7KPo8SGRC
         ONZuegUvukCaa/hYqjlwskUpFs8DG3MkenJ1lR4wYmsliyg+5A9c3PKEtC6tOCsaaJ
         ieP7YhZQiJGRiM0B/V7d4ElgNnwpqzrMXCftm9j+0j8ePGQU/NCNMf/YPWb8SPE0/z
         lnLC04VApjTYbsEssluA6tWxXh32i1Vy7GI0BzCnouGXhM/2XL9uqMwzSNgdzp33df
         PiYGOK4WkSkCg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 12/22] objtool: Get rid of reloc->list
Date:   Tue, 30 May 2023 10:21:04 -0700
Message-Id: <71e7a2c017dbc46bb497857ec97d67214f832d10.1685464332.git.jpoimboe@kernel.org>
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

Now that all relocs are allocated in an array, the linked list is no
longer needed.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 49.02G
- After:  peak heap memory consumption: 45.56G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 32 ++++++++++++-----------------
 tools/objtool/include/objtool/elf.h | 18 +++++++++++-----
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5f69d4590117..19ac53ad76ee 100644
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
index a938cb1d4172..a09da208ddb8 100644
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
-- 
2.40.1

