Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00A16E2623
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDNOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjDNOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CFBB80;
        Fri, 14 Apr 2023 07:47:57 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1pnDeOj2DkiGlFyBHaObWLvQU8RNwsHlSbqAa5KmYE=;
        b=c40UlWwpl6Y9WliBgEo+vmQCthgAKU5y0WBm6Vz/owMa/VXYGPuahoCI/aUS3ANKYmDtCP
        fqe2JkCos1d2Sv1xk62GEkN8qPjQU45FAtBkInQfbJ94mh1CvGy/oiulLk2EqR2ntXZccU
        Kj3SeiqihtC7gNpIE7vVKuYC1W5ychP1+e44Oy1VefFTba6WOLkRiWmGyj49ZZECL0cdL3
        bPoWvYjftPOchL3V7hZ8bdLB1RgyHgqowHisSqIn/Z2EmpmqET/hFP0O/km9x4HgOypWMw
        wza1pAQhVqpjwt7FmOhRV6SGr2CeaK963QGISB9Qi5mZseqJwhqlZNJwODDhFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1pnDeOj2DkiGlFyBHaObWLvQU8RNwsHlSbqAa5KmYE=;
        b=O9uPG3Hg4hiHN/7Plte8p3OzAyTJM8DqEkPGTiGWnuGxRU7mEWQLebW2j4jpQ6snmO4SYC
        U6z6QH/jj9/+r2Dw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add symbol iteration helpers
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <59023e5886ab125aa30702e633be7732b1acaa7e.1681325924.git.jpoimboe@kernel.org>
References: <59023e5886ab125aa30702e633be7732b1acaa7e.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367548.404.6075366946520283125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9290e772baccecec324ae9f2e0b470f870c097de
Gitweb:        https://git.kernel.org/tip/9290e772baccecec324ae9f2e0b470f870c097de
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 12:03:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:29 +02:00

objtool: Add symbol iteration helpers

Add [sec_]for_each_sym() and use them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/59023e5886ab125aa30702e633be7732b1acaa7e.1681325924.git.jpoimboe@kernel.org
---
 tools/objtool/check.c               | 98 +++++++++++-----------------
 tools/objtool/elf.c                 |  2 +-
 tools/objtool/include/objtool/elf.h |  9 +++-
 3 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7d1a42b..9de3972 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -470,7 +470,7 @@ static int decode_instructions(struct objtool_file *file)
 
 //		printf("%s: last chunk used: %d\n", sec->name, (int)idx);
 
-		list_for_each_entry(func, &sec->symbol_list, list) {
+		sec_for_each_sym(sec, func) {
 			if (func->type != STT_NOTYPE && func->type != STT_FUNC)
 				continue;
 
@@ -924,7 +924,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 
 static int create_cfi_sections(struct objtool_file *file)
 {
-	struct section *sec, *s;
+	struct section *sec;
 	struct symbol *sym;
 	unsigned int *loc;
 	int idx;
@@ -937,19 +937,14 @@ static int create_cfi_sections(struct objtool_file *file)
 	}
 
 	idx = 0;
-	for_each_sec(file, s) {
-		if (!s->text)
+	for_each_sym(file, sym) {
+		if (sym->type != STT_FUNC)
 			continue;
 
-		list_for_each_entry(sym, &s->symbol_list, list) {
-			if (sym->type != STT_FUNC)
-				continue;
-
-			if (strncmp(sym->name, "__cfi_", 6))
-				continue;
+		if (strncmp(sym->name, "__cfi_", 6))
+			continue;
 
-			idx++;
-		}
+		idx++;
 	}
 
 	sec = elf_create_section(file->elf, ".cfi_sites", 0, sizeof(unsigned int), idx);
@@ -957,28 +952,23 @@ static int create_cfi_sections(struct objtool_file *file)
 		return -1;
 
 	idx = 0;
-	for_each_sec(file, s) {
-		if (!s->text)
+	for_each_sym(file, sym) {
+		if (sym->type != STT_FUNC)
 			continue;
 
-		list_for_each_entry(sym, &s->symbol_list, list) {
-			if (sym->type != STT_FUNC)
-				continue;
-
-			if (strncmp(sym->name, "__cfi_", 6))
-				continue;
+		if (strncmp(sym->name, "__cfi_", 6))
+			continue;
 
-			loc = (unsigned int *)sec->data->d_buf + idx;
-			memset(loc, 0, sizeof(unsigned int));
+		loc = (unsigned int *)sec->data->d_buf + idx;
+		memset(loc, 0, sizeof(unsigned int));
 
-			if (elf_add_reloc_to_insn(file->elf, sec,
-						  idx * sizeof(unsigned int),
-						  R_X86_64_PC32,
-						  s, sym->offset))
-				return -1;
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(unsigned int),
+					  R_X86_64_PC32,
+					  sym->sec, sym->offset))
+			return -1;
 
-			idx++;
-		}
+		idx++;
 	}
 
 	return 0;
@@ -2207,23 +2197,20 @@ static int add_func_jump_tables(struct objtool_file *file,
  */
 static int add_jump_table_alts(struct objtool_file *file)
 {
-	struct section *sec;
 	struct symbol *func;
 	int ret;
 
 	if (!file->rodata)
 		return 0;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
+	for_each_sym(file, func) {
+		if (func->type != STT_FUNC)
+			continue;
 
-			mark_func_jump_tables(file, func);
-			ret = add_func_jump_tables(file, func);
-			if (ret)
-				return ret;
-		}
+		mark_func_jump_tables(file, func);
+		ret = add_func_jump_tables(file, func);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2535,30 +2522,27 @@ static bool is_profiling_func(const char *name)
 
 static int classify_symbols(struct objtool_file *file)
 {
-	struct section *sec;
 	struct symbol *func;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->bind != STB_GLOBAL)
-				continue;
+	for_each_sym(file, func) {
+		if (func->bind != STB_GLOBAL)
+			continue;
 
-			if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
-				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
-				func->static_call_tramp = true;
+		if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+			     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
+			func->static_call_tramp = true;
 
-			if (arch_is_retpoline(func))
-				func->retpoline_thunk = true;
+		if (arch_is_retpoline(func))
+			func->retpoline_thunk = true;
 
-			if (arch_is_rethunk(func))
-				func->return_thunk = true;
+		if (arch_is_rethunk(func))
+			func->return_thunk = true;
 
-			if (arch_ftrace_match(func->name))
-				func->fentry = true;
+		if (arch_ftrace_match(func->name))
+			func->fentry = true;
 
-			if (is_profiling_func(func->name))
-				func->profiling_func = true;
-		}
+		if (is_profiling_func(func->name))
+			func->profiling_func = true;
 	}
 
 	return 0;
@@ -4213,7 +4197,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	struct symbol *func;
 	int warnings = 0;
 
-	list_for_each_entry(func, &sec->symbol_list, list) {
+	sec_for_each_sym(sec, func) {
 		if (func->type != STT_FUNC)
 			continue;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6806ce0..500e929 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -474,7 +474,7 @@ static int read_symbols(struct elf *elf)
 
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
-		list_for_each_entry(sym, &sec->symbol_list, list) {
+		sec_for_each_sym(sec, sym) {
 			char pname[MAX_NAME_LEN + 1];
 			size_t pnamelen;
 			if (sym->type != STT_FUNC)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index ad0024d..e1ca588 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -188,4 +188,13 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
+#define sec_for_each_sym(sec, sym)					\
+	list_for_each_entry(sym, &sec->symbol_list, list)
+
+#define for_each_sym(file, sym)						\
+	for (struct section *__sec, *__fake = (struct section *)1;	\
+	     __fake; __fake = NULL)					\
+		for_each_sec(file, __sec)				\
+			sec_for_each_sym(__sec, sym)
+
 #endif /* _OBJTOOL_ELF_H */
