Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A668F460
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjBHRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjBHRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599EE303EB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tf6weflLVL5UNGPZOQBPuXAtnzAI3KVAbkARyh3VqT8=; b=ICLCoCx5dEH4rNkQwezCwmC3gk
        AU72ccSNgmlMRkx02M1/krwPZba/bbsuzgrewgBt7aIC2dppxiF0eMQ4IStWQiMqvtV3FogXR4Voe
        KFHp+zQruIu8h1cIGSqnf302/TE2BgdPT4QmBzgTT0a4LAZr6rXv1IRFnL+Jv3qe+eV5gHor6cKKk
        5fPE7nlHBBjJ4l6ZOhFf7MSs8DM5nbNTip07kANOKNG3KSTRTeupjiaNRUk4c/5W4t0IVMI6FkXN7
        FfHE2KV/dGAcP1C+Ze2C4LeaQLof6wgX1GpfMnnwIxMkvJ3vVgv0mYvLcln477JvsglN6EwST4yRl
        7uL6p8mQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA4-007Vvk-2T;
        Wed, 08 Feb 2023 17:23:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4970C300AFB;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1697A23D8CFB2; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.640914454@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 06/10] objtool: Union instruction::{call_dest,jump_table}
References: <20230208171756.898991570@infradead.org>
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

The instruction call_dest and jump_table members can never be used at
the same time, their usage depends on type.

 struct instruction {
 	struct list_head           list;                 /*     0    16 */
 	struct hlist_node          hash;                 /*    16    16 */
 	struct list_head           call_node;            /*    32    16 */
 	struct section *           sec;                  /*    48     8 */
 	long unsigned int          offset;               /*    56     8 */
 	/* --- cacheline 1 boundary (64 bytes) --- */
 	long unsigned int          immediate;            /*    64     8 */
 	unsigned int               len;                  /*    72     4 */
 	u8                         type;                 /*    76     1 */

 	/* Bitfield combined with previous fields */

 	u16                        dead_end:1;           /*    76: 8  2 */
 	u16                        ignore:1;             /*    76: 9  2 */
 	u16                        ignore_alts:1;        /*    76:10  2 */
 	u16                        hint:1;               /*    76:11  2 */
 	u16                        save:1;               /*    76:12  2 */
 	u16                        restore:1;            /*    76:13  2 */
 	u16                        retpoline_safe:1;     /*    76:14  2 */
 	u16                        noendbr:1;            /*    76:15  2 */
 	u16                        entry:1;              /*    78: 0  2 */
 	u16                        visited:4;            /*    78: 1  2 */
 	u16                        no_reloc:1;           /*    78: 5  2 */

 	/* XXX 2 bits hole, try to pack */
 	/* Bitfield combined with next fields */

 	s8                         instr;                /*    79     1 */
 	struct alt_group *         alt_group;            /*    80     8 */
-	struct symbol *            call_dest;            /*    88     8 */
-	struct instruction *       jump_dest;            /*    96     8 */
-	struct instruction *       first_jump_src;       /*   104     8 */
-	struct reloc *             jump_table;           /*   112     8 */
-	struct alternative *       alts;                 /*   120     8 */
+	struct instruction *       jump_dest;            /*    88     8 */
+	struct instruction *       first_jump_src;       /*    96     8 */
+	union {
+		struct symbol *    _call_dest;           /*   104     8 */
+		struct reloc *     _jump_table;          /*   104     8 */
+	};                                               /*   104     8 */
+	struct alternative *       alts;                 /*   112     8 */
+	struct symbol *            sym;                  /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
-	struct symbol *            sym;                  /*   128     8 */
-	struct stack_op *          stack_ops;            /*   136     8 */
-	struct cfi_state *         cfi;                  /*   144     8 */
+	struct stack_op *          stack_ops;            /*   128     8 */
+	struct cfi_state *         cfi;                  /*   136     8 */

-	/* size: 152, cachelines: 3, members: 29 */
-	/* sum members: 150 */
+	/* size: 144, cachelines: 3, members: 28 */
+	/* sum members: 142 */
 	/* sum bitfield members: 14 bits, bit holes: 1, sum bit holes: 2 bits */
-	/* last cacheline: 24 bytes */
+	/* last cacheline: 16 bytes */
 };

pre:	5:39.35 real,   215.58 user,    123.69 sys,     23448736 mem
post:	5:38.18 real,   213.25 user,    124.90 sys,     23449040 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |   73 +++++++++++++++++++++-------------
 tools/objtool/include/objtool/check.h |    6 +-
 2 files changed, 50 insertions(+), 29 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -114,16 +114,34 @@ static struct instruction *prev_insn_sam
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static inline struct symbol *insn_call_dest(struct instruction *insn)
+{
+	if (insn->type == INSN_JUMP_DYNAMIC ||
+	    insn->type == INSN_CALL_DYNAMIC)
+		return NULL;
+
+	return insn->_call_dest;
+}
+
+static inline struct reloc *insn_jump_table(struct instruction *insn)
+{
+	if (insn->type == INSN_JUMP_DYNAMIC ||
+	    insn->type == INSN_CALL_DYNAMIC)
+		return insn->_jump_table;
+
+	return NULL;
+}
+
 static bool is_jump_table_jump(struct instruction *insn)
 {
 	struct alt_group *alt_group = insn->alt_group;
 
-	if (insn->jump_table)
+	if (insn_jump_table(insn))
 		return true;
 
 	/* Retpoline alternative for a jump table? */
 	return alt_group && alt_group->orig_group &&
-	       alt_group->orig_group->first_insn->jump_table;
+	       insn_jump_table(alt_group->orig_group->first_insn);
 }
 
 static bool is_sibling_call(struct instruction *insn)
@@ -137,8 +155,8 @@ static bool is_sibling_call(struct instr
 			return !is_jump_table_jump(insn);
 	}
 
-	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
-	return (is_static_jump(insn) && insn->call_dest);
+	/* add_jump_destinations() sets insn_call_dest(insn) for sibling calls. */
+	return (is_static_jump(insn) && insn_call_dest(insn));
 }
 
 /*
@@ -273,8 +291,8 @@ static void init_insn_state(struct objto
 
 	/*
 	 * We need the full vmlinux for noinstr validation, otherwise we can
-	 * not correctly determine insn->call_dest->sec (external symbols do
-	 * not have a section).
+	 * not correctly determine insn_call_dest(insn)->sec (external symbols
+	 * do not have a section).
 	 */
 	if (opts.link && opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
@@ -677,7 +695,7 @@ static int create_static_call_sections(s
 			return -1;
 
 		/* find key symbol */
-		key_name = strdup(insn->call_dest->name);
+		key_name = strdup(insn_call_dest(insn)->name);
 		if (!key_name) {
 			perror("strdup");
 			return -1;
@@ -708,7 +726,7 @@ static int create_static_call_sections(s
 			 * trampoline address.  This is fixed up in
 			 * static_call_add_module().
 			 */
-			key_sym = insn->call_dest;
+			key_sym = insn_call_dest(insn);
 		}
 		free(key_name);
 
@@ -1342,7 +1360,7 @@ static void annotate_call_site(struct ob
 			       struct instruction *insn, bool sibling)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
-	struct symbol *sym = insn->call_dest;
+	struct symbol *sym = insn_call_dest(insn);
 
 	if (!sym)
 		sym = reloc->sym;
@@ -1427,7 +1445,7 @@ static void annotate_call_site(struct ob
 static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 			  struct symbol *dest, bool sibling)
 {
-	insn->call_dest = dest;
+	insn->_call_dest = dest;
 	if (!dest)
 		return;
 
@@ -1685,12 +1703,12 @@ static int add_call_destinations(struct
 			if (insn->ignore)
 				continue;
 
-			if (!insn->call_dest) {
+			if (!insn_call_dest(insn)) {
 				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
 				return -1;
 			}
 
-			if (insn_func(insn) && insn->call_dest->type != STT_FUNC) {
+			if (insn_func(insn) && insn_call_dest(insn)->type != STT_FUNC) {
 				WARN_FUNC("unsupported call to non-function",
 					  insn->sec, insn->offset);
 				return -1;
@@ -2127,7 +2145,7 @@ static void mark_func_jump_tables(struct
 		reloc = find_jump_table(file, func, insn);
 		if (reloc) {
 			reloc->jump_table_start = true;
-			insn->jump_table = reloc;
+			insn->_jump_table = reloc;
 		}
 	}
 }
@@ -2139,10 +2157,10 @@ static int add_func_jump_tables(struct o
 	int ret;
 
 	func_for_each_insn(file, func, insn) {
-		if (!insn->jump_table)
+		if (!insn_jump_table(insn))
 			continue;
 
-		ret = add_jump_table(file, insn, insn->jump_table);
+		ret = add_jump_table(file, insn, insn_jump_table(insn));
 		if (ret)
 			return ret;
 	}
@@ -2614,8 +2632,8 @@ static int decode_sections(struct objtoo
 static bool is_fentry_call(struct instruction *insn)
 {
 	if (insn->type == INSN_CALL &&
-	    insn->call_dest &&
-	    insn->call_dest->fentry)
+	    insn_call_dest(insn) &&
+	    insn_call_dest(insn)->fentry)
 		return true;
 
 	return false;
@@ -3322,8 +3340,8 @@ static inline const char *call_dest_name
 	struct reloc *rel;
 	int idx;
 
-	if (insn->call_dest)
-		return insn->call_dest->name;
+	if (insn_call_dest(insn))
+		return insn_call_dest(insn)->name;
 
 	rel = insn_reloc(NULL, insn);
 	if (rel && !strcmp(rel->sym->name, "pv_ops")) {
@@ -3405,13 +3423,13 @@ static int validate_call(struct objtool_
 			 struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(file, insn, insn->call_dest)) {
+	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
-	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
+	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -3849,11 +3867,11 @@ static int validate_entry(struct objtool
 
 			/* fallthrough */
 		case INSN_CALL:
-			dest = find_insn(file, insn->call_dest->sec,
-					 insn->call_dest->offset);
+			dest = find_insn(file, insn_call_dest(insn)->sec,
+					 insn_call_dest(insn)->offset);
 			if (!dest) {
 				WARN("Unresolved function after linking!?: %s",
-				     insn->call_dest->name);
+				     insn_call_dest(insn)->name);
 				return -1;
 			}
 
@@ -3954,13 +3972,13 @@ static int validate_retpoline(struct obj
 static bool is_kasan_insn(struct instruction *insn)
 {
 	return (insn->type == INSN_CALL &&
-		!strcmp(insn->call_dest->name, "__asan_handle_no_return"));
+		!strcmp(insn_call_dest(insn)->name, "__asan_handle_no_return"));
 }
 
 static bool is_ubsan_insn(struct instruction *insn)
 {
 	return (insn->type == INSN_CALL &&
-		!strcmp(insn->call_dest->name,
+		!strcmp(insn_call_dest(insn)->name,
 			"__ubsan_handle_builtin_unreachable"));
 }
 
@@ -4038,7 +4056,8 @@ static bool ignore_unreachable_insn(stru
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
 	prev_insn = list_prev_entry(insn, list);
-	if ((prev_insn->dead_end || dead_end_function(file, prev_insn->call_dest)) &&
+	if ((prev_insn->dead_end ||
+	     dead_end_function(file, insn_call_dest(prev_insn))) &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -62,10 +62,12 @@ struct instruction {
 	s8 instr;
 
 	struct alt_group *alt_group;
-	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
-	struct reloc *jump_table;
+	union {
+		struct symbol *_call_dest;
+		struct reloc *_jump_table;
+	};
 	struct alternative *alts;
 	struct symbol *sym;
 	struct stack_op *stack_ops;


