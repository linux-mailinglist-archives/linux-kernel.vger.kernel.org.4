Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1637611B25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJ1Ts1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJ1TsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:48:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EC52441A3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=z2Eui6jBMsF3Ela2LYf1dY1EBM7vCZblnAbR38nKIkI=; b=BVqYFG1epHvfEzIIJb0n58krM9
        xnJTzqfsYLp/JBl9vrfbgqtBjvzlBYQybmClTjleQ0/gC+pgAFkRaFphTPExqCrYN+dXAjIe9isRM
        K09mxSJKJPhNe9iTfcsZMTiWLVQlGsQW7B8WC2g0WeBuOb8FqPCSsXfLB3l3rxdXyegK2w/bwmz6k
        mx4YSscqMTPvHDPfg2Gt9jBpfm0+SKncvir8OnW7z8nI88YiycDbTocKrevtF4ZV2eBUXbRaO7EZO
        4Bchr3inxodksr2ZlK62noDmzNgrPPNWy6YoJst3TMhAaTAs07W7JJ5b4Yc+CnfdPRigs2QoWn3qJ
        Hm2cvT/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVKR-007ARC-1D; Fri, 28 Oct 2022 19:47:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD18B300BAE;
        Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A37982C6DAB2D; Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Message-ID: <20221028194453.526899822@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Oct 2022 21:40:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        djwong@kernel.org, yujie.liu@intel.com, tglx@linutronix.de,
        jpoimboe@kernel.org, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: [PATCH 4/5] objtool: Add option to generate prefix symbols
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/builtin-check.c           |    1 +
 tools/objtool/check.c                   |   27 +++++++++++++++++++++++++++
 tools/objtool/elf.c                     |   30 ++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |    1 +
 tools/objtool/include/objtool/elf.h     |    2 ++
 5 files changed, 61 insertions(+)

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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3972,6 +3972,31 @@ static bool ignore_unreachable_insn(stru
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
+
+		if (&prev->list == &file->insn_list)
+			break;
+
+		if (prev->type != INSN_NOP)
+			break;
+
+		insn = prev;
+		if (func->offset - prev->offset == opts.prefix) {
+			elf_create_prefix_symbol(file->elf, func, -opts.prefix);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int validate_symbol(struct objtool_file *file, struct section *sec,
 			   struct symbol *sym, struct insn_state *state)
 {
@@ -3990,6 +4015,8 @@ static int validate_symbol(struct objtoo
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
+	add_prefix_symbol(file, sym, insn);
+
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -819,6 +819,36 @@ elf_create_section_symbol(struct elf *el
 	return sym;
 }
 
+static int elf_add_string(struct elf *elf, struct section *strtab, char *str);
+
+struct symbol *
+elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend)
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
+	sym->sym.st_value = orig->sym.st_value + addend;
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
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool stackval;
 	bool static_call;
 	bool uaccess;
+	int prefix;
 
 	/* options: */
 	bool backtrace;
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -146,6 +146,8 @@ static inline bool has_multiple_files(st
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
+struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend);
+
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, s64 addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,


