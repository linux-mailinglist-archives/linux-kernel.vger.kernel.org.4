Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C768F464
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBHRYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjBHRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E77EC45
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dWf0mF+CkANB3UjknX/6VNA3izZPStL4WfuVfUb/La0=; b=RjRDvoUb9moSjybIp7cnAw4pfY
        tSoZoJOJAGO0KL5lbysz5L2bljP11PAJtlrVMPOeWexevT7+Zf8Tt9w70DhYBETpzGVItUQfwsU6D
        JU4OA6ZgcLimyWOY6U8JFgvZ5W1k15qVtCU9R3c2HMQMrAPM3czGBcGj374RjuHQI2WbN+hGvFSF0
        j/nxUeu/VZJezzk+0WvzulBTAymZKB+iFs96QZ3CSQwp2Ro41FFMQN3LvGmEKihlOK3a7R7Ft36Zm
        Ux1IJckmUpBA65SOcfm6UyW8rMul5xei58aW/9c/hFMOjNMAaNUy/fq5oIi4El+teEqC5pm6mt7A5
        sHnOtFFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA4-007Vvd-05;
        Wed, 08 Feb 2023 17:23:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22C9A30080C;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0A12E203D3415; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.430556498@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:17:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 03/10] objtool: Make instruction::alts a single-linked list
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

 struct instruction {
 	struct list_head           list;                 /*     0    16 */
 	struct hlist_node          hash;                 /*    16    16 */
 	struct list_head           call_node;            /*    32    16 */
 	struct section *           sec;                  /*    48     8 */
 	long unsigned int          offset;               /*    56     8 */
 	/* --- cacheline 1 boundary (64 bytes) --- */
 	unsigned int               len;                  /*    64     4 */
 	enum insn_type             type;                 /*    68     4 */
 	long unsigned int          immediate;            /*    72     8 */
 	u16                        dead_end:1;           /*    80: 0  2 */
 	u16                        ignore:1;             /*    80: 1  2 */
 	u16                        ignore_alts:1;        /*    80: 2  2 */
 	u16                        hint:1;               /*    80: 3  2 */
 	u16                        save:1;               /*    80: 4  2 */
 	u16                        restore:1;            /*    80: 5  2 */
 	u16                        retpoline_safe:1;     /*    80: 6  2 */
 	u16                        noendbr:1;            /*    80: 7  2 */
 	u16                        entry:1;              /*    80: 8  2 */

 	/* XXX 7 bits hole, try to pack */

 	s8                         instr;                /*    82     1 */
 	u8                         visited;              /*    83     1 */

 	/* XXX 4 bytes hole, try to pack */

 	struct alt_group *         alt_group;            /*    88     8 */
 	struct symbol *            call_dest;            /*    96     8 */
 	struct instruction *       jump_dest;            /*   104     8 */
 	struct instruction *       first_jump_src;       /*   112     8 */
 	struct reloc *             jump_table;           /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
 	struct reloc *             reloc;                /*   128     8 */
-	struct list_head           alts;                 /*   136    16 */
-	struct symbol *            sym;                  /*   152     8 */
-	struct stack_op *          stack_ops;            /*   160     8 */
-	struct cfi_state *         cfi;                  /*   168     8 */
+	struct alternative *       alts;                 /*   136     8 */
+	struct symbol *            sym;                  /*   144     8 */
+	struct stack_op *          stack_ops;            /*   152     8 */
+	struct cfi_state *         cfi;                  /*   160     8 */

-	/* size: 176, cachelines: 3, members: 29 */
-	/* sum members: 170, holes: 1, sum holes: 4 */
+	/* size: 168, cachelines: 3, members: 29 */
+	/* sum members: 162, holes: 1, sum holes: 4 */
 	/* sum bitfield members: 9 bits, bit holes: 1, sum bit holes: 7 bits */
-	/* last cacheline: 48 bytes */
+	/* last cacheline: 40 bytes */
 };

pre:	5:58.50 real,   229.64 user,    128.65 sys,     26221520 mem
post:	5:48.86 real,   220.30 user,    128.34 sys,     24834672 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |   18 +++++++++---------
 tools/objtool/include/objtool/check.h |    2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -23,7 +23,7 @@
 #include <linux/static_call_types.h>
 
 struct alternative {
-	struct list_head list;
+	struct alternative *next;
 	struct instruction *insn;
 	bool skip_orig;
 };
@@ -395,7 +395,6 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 			memset(insn, 0, sizeof(*insn));
-			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
@@ -1768,7 +1767,6 @@ static int handle_group_alt(struct objto
 			return -1;
 		}
 		memset(nop, 0, sizeof(*nop));
-		INIT_LIST_HEAD(&nop->alts);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -1966,7 +1964,8 @@ static int add_special_section_alts(stru
 		alt->insn = new_insn;
 		alt->skip_orig = special_alt->skip_orig;
 		orig_insn->ignore_alts |= special_alt->skip_alt;
-		list_add_tail(&alt->list, &orig_insn->alts);
+		alt->next = orig_insn->alts;
+		orig_insn->alts = alt;
 
 		list_del(&special_alt->list);
 		free(special_alt);
@@ -2025,7 +2024,8 @@ static int add_jump_table(struct objtool
 		}
 
 		alt->insn = dest_insn;
-		list_add_tail(&alt->list, &insn->alts);
+		alt->next = insn->alts;
+		insn->alts = alt;
 		prev_offset = reloc->offset;
 	}
 
@@ -3576,10 +3576,10 @@ static int validate_branch(struct objtoo
 		if (propagate_alt_cfi(file, insn))
 			return 1;
 
-		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
+		if (!insn->ignore_alts && insn->alts) {
 			bool skip_orig = false;
 
-			list_for_each_entry(alt, &insn->alts, list) {
+			for (alt = insn->alts; alt; alt = alt->next) {
 				if (alt->skip_orig)
 					skip_orig = true;
 
@@ -3778,11 +3778,11 @@ static int validate_entry(struct objtool
 
 		insn->visited |= VISITED_ENTRY;
 
-		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
+		if (!insn->ignore_alts && insn->alts) {
 			struct alternative *alt;
 			bool skip_orig = false;
 
-			list_for_each_entry(alt, &insn->alts, list) {
+			for (alt = insn->alts; alt; alt = alt->next) {
 				if (alt->skip_orig)
 					skip_orig = true;
 
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -66,7 +66,7 @@ struct instruction {
 	struct instruction *first_jump_src;
 	struct reloc *jump_table;
 	struct reloc *reloc;
-	struct list_head alts;
+	struct alternative *alts;
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;


