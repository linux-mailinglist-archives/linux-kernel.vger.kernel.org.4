Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C43615F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKBJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKBJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D1659C;
        Wed,  2 Nov 2022 02:20:07 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbwfrCrvtuAvxUh4bsLS6G61Og5QZLgQO4inPEEtQHQ=;
        b=wuPg6dgwLLNQx5YAXMTXciSqwavydhUmrXdMoKzA7cACFuKVHn4nz/TX5uUlUL1iQjye6d
        Qu+W1ljNlrEpT3OWgIZzF9VrvnxF7f2jF6NKD91xiFWdM4UmhIYjlTFmReaCa98e/9On30
        5G35E+lOk99kBB8wbi3YSrLy54j3J6yxDi52PRdwHwzFNuDhW1EDUs5QrQycz9gcEFvdXW
        jvQoqpqQg8JH7Uyf7sqQmegffz5Kjlp0prsFnwkLc4Lk6V/W6cOESE+qU6pE3L0ce4W9Vl
        pohRfJw+AeQDRomL0OuLET1lqcsDFCtdkvuMTpFhYEa4fgY3vGW1AtACsent0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbwfrCrvtuAvxUh4bsLS6G61Og5QZLgQO4inPEEtQHQ=;
        b=9DdBlAnWGXOyjJU0fERnuB0KNDALLwe16Pn0LsDxZBUKvEdG6ebdU35g80JfdnhR8Q+WW/
        mWP8ZzqVNKJJsoDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add option to generate prefix symbols
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yujie Liu <yujie.liu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028194453.526899822@infradead.org>
References: <20221028194453.526899822@infradead.org>
MIME-Version: 1.0
Message-ID: <166738080414.7716.5006663778628933694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9f2899fe36a623885d8576604cb582328ad32b3c
Gitweb:        https://git.kernel.org/tip/9f2899fe36a623885d8576604cb582328ad32b3c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Oct 2022 15:50:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:09 +01:00

objtool: Add option to generate prefix symbols

When code is compiled with:

  -fpatchable-function-entry=${PADDING_BYTES},${PADDING_BYTES}

functions will have PADDING_BYTES of NOP in front of them. Unwinders
and other things that symbolize code locations will typically
attribute these bytes to the preceding function.

Given that these bytes nominally belong to the following symbol this
mis-attribution is confusing.

Inspired by the fact that CFI_CLANG emits __cfi_##name symbols to
claim these bytes, allow objtool to emit __pfx_##name symbols to do
the same.

Therefore add the objtool --prefix=N argument, to conditionally place
a __pfx_##name symbol at N bytes ahead of symbol 'name' when: all
these preceding bytes are NOP and name-N is an instruction boundary.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Link: https://lkml.kernel.org/r/20221028194453.526899822@infradead.org
---
 tools/objtool/builtin-check.c           |  1 +-
 tools/objtool/check.c                   | 33 +++++++++++++++++++++++-
 tools/objtool/elf.c                     | 31 +++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |  1 +-
 tools/objtool/include/objtool/elf.h     |  2 +-
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 0a04f8e..95fcece 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -75,6 +75,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN(0,   "rethunk", &opts.rethunk, "validate and annotate rethunk usage"),
 	OPT_BOOLEAN(0,   "unret", &opts.unret, "validate entry unret placement"),
+	OPT_INTEGER(0,   "prefix", &opts.prefix, "generate prefix symbols"),
 	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
 	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
 	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7936312..27f35f5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3417,7 +3417,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
-			if (!strncmp(func->name, "__cfi_", 6))
+			if (!strncmp(func->name, "__cfi_", 6) ||
+			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
 			WARN("%s() falls through to next function %s()",
@@ -3972,6 +3973,34 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	return false;
 }
 
+static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
+			     struct instruction *insn)
+{
+	if (!opts.prefix)
+		return 0;
+
+	for (;;) {
+		struct instruction *prev = list_prev_entry(insn, list);
+		u64 offset;
+
+		if (&prev->list == &file->insn_list)
+			break;
+
+		if (prev->type != INSN_NOP)
+			break;
+
+		offset = func->offset - prev->offset;
+		if (offset >= opts.prefix) {
+			if (offset == opts.prefix)
+				elf_create_prefix_symbol(file->elf, func, opts.prefix);
+			break;
+		}
+		insn = prev;
+	}
+
+	return 0;
+}
+
 static int validate_symbol(struct objtool_file *file, struct section *sec,
 			   struct symbol *sym, struct insn_state *state)
 {
@@ -3990,6 +4019,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
+	add_prefix_symbol(file, sym, insn);
+
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 36dc787..3d636d1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -819,6 +819,37 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
 	return sym;
 }
 
+static int elf_add_string(struct elf *elf, struct section *strtab, char *str);
+
+struct symbol *
+elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
+{
+	struct symbol *sym = calloc(1, sizeof(*sym));
+	size_t namelen = strlen(orig->name) + sizeof("__pfx_");
+	char *name = malloc(namelen);
+
+	if (!sym || !name) {
+		perror("malloc");
+		return NULL;
+	}
+
+	snprintf(name, namelen, "__pfx_%s", orig->name);
+
+	sym->name = name;
+	sym->sec = orig->sec;
+
+	sym->sym.st_name = elf_add_string(elf, NULL, name);
+	sym->sym.st_info = orig->sym.st_info;
+	sym->sym.st_value = orig->sym.st_value - size;
+	sym->sym.st_size = size;
+
+	sym = __elf_create_symbol(elf, sym);
+	if (sym)
+		elf_add_symbol(elf, sym);
+
+	return sym;
+}
+
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 			  unsigned long offset, unsigned int type,
 			  struct section *insn_sec, unsigned long insn_off)
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 22092a9..f341b62 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool stackval;
 	bool static_call;
 	bool uaccess;
+	int prefix;
 
 	/* options: */
 	bool backtrace;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9e96a61..b6974e3 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -146,6 +146,8 @@ static inline bool has_multiple_files(struct elf *elf)
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
+struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
+
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, s64 addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
