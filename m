Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE26DFE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDLTD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634A519AD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F32C763871
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9879AC433A0;
        Wed, 12 Apr 2023 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326226;
        bh=xaXnGfbC/VMDQDGu1YDrIHmJbcCkfgf/aMjvRsvTeLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLyqRwZ7Cm9rjuMjVK1mOv2LqbY4qSfm/yt2qOzI90jMhIHqgq3Ne5OXSfZj5MnfC
         /G9y/FHQz5d2PLw0bF5VWTTAthGhPRPxoBpO+1f1ZzzDnPcLclndGWA2e5eC6nbWU5
         tKJ8Jl5bhwLJ2D0jboWiZimpuyS92Mss683UZM8Qz+owmWnqpp9lFOgsckrwPOonmt
         gLNYTiI2BWey0p+J4oSdLlrU4WZhr/hoY38iDSJmW4vSZCHfap0N0AA+YanzZY4jzV
         //2ty/m4b9zemQ/58plj+1OcX8fQdafga5hgJcAAOV14c2ktHILY7a8B1nT7ja+n4L
         kOa8ttD6I5loQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 4/9] objtool: Add symbol iteration helpers
Date:   Wed, 12 Apr 2023 12:03:19 -0700
Message-Id: <59023e5886ab125aa30702e633be7732b1acaa7e.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681325924.git.jpoimboe@kernel.org>
References: <cover.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add [sec_]for_each_sym() and use them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 98 ++++++++++++-----------------
 tools/objtool/elf.c                 |  2 +-
 tools/objtool/include/objtool/elf.h |  9 +++
 3 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index de0d0234527d..d1d47baa252c 100644
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
@@ -2205,23 +2195,20 @@ static int add_func_jump_tables(struct objtool_file *file,
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
@@ -2533,30 +2520,27 @@ static bool is_profiling_func(const char *name)
 
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
@@ -4222,7 +4206,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	struct symbol *func;
 	int warnings = 0;
 
-	list_for_each_entry(func, &sec->symbol_list, list) {
+	sec_for_each_sym(sec, func) {
 		if (func->type != STT_FUNC)
 			continue;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6806ce01d933..500e92979a31 100644
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
index a668173a5869..78e2d0fc21ca 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -189,4 +189,13 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset);
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
-- 
2.39.2

