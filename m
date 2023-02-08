Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7A68F462
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBHRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjBHRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9817D37B5E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GvO8aVeF7JKwzvQc7hhJHgk9VBm8YhlWG+s1YwCYQvE=; b=M8movAMwfAbHmAKhR1cTW3NTbS
        tY9ts2TQCEnA4Yz7KFMm31MAR7KopSfB85a8YlwIjf+k1kzP114AUTPp+MBBJHgaVfBW2memKa+lM
        HsyoWxGFJrxcHNvQ099cbYjeiQh4hv34h602NFfrdE/jGraVNx2m67Lc7heVP38bhDwfkxU/VK1Z5
        jo0grckrq/yrBgFISK5/UnTWj0sh0fIekIiBLZWz1Az3cNZM580DRZmCgbMJ45vnC4BNP/IUJcxJs
        H8zmnbKRE5W75yUVsOqnvrADLBSZhGoIY559M3z9h9514a6liwQTsNx+u/XuLB8bVG3z6NZF33m26
        CU66KdVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA4-007Vvj-2I;
        Wed, 08 Feb 2023 17:23:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 497B53010E0;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1269923698889; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.572145269@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 05/10] objtool: Remove instruction::reloc
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

Instead of caching the reloc for each instruction, only keep a
negative cache of not having a reloc (by far the most common case).

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
+	u16                        no_reloc:1;           /*    78: 5  2 */

-	/* XXX 3 bits hole, try to pack */
+	/* XXX 2 bits hole, try to pack */
 	/* Bitfield combined with next fields */

 	s8                         instr;                /*    79     1 */
 	struct alt_group *         alt_group;            /*    80     8 */
 	struct symbol *            call_dest;            /*    88     8 */
 	struct instruction *       jump_dest;            /*    96     8 */
 	struct instruction *       first_jump_src;       /*   104     8 */
 	struct reloc *             jump_table;           /*   112     8 */
-	struct reloc *             reloc;                /*   120     8 */
+	struct alternative *       alts;                 /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
-	struct alternative *       alts;                 /*   128     8 */
-	struct symbol *            sym;                  /*   136     8 */
-	struct stack_op *          stack_ops;            /*   144     8 */
-	struct cfi_state *         cfi;                  /*   152     8 */
+	struct symbol *            sym;                  /*   128     8 */
+	struct stack_op *          stack_ops;            /*   136     8 */
+	struct cfi_state *         cfi;                  /*   144     8 */

-	/* size: 160, cachelines: 3, members: 29 */
-	/* sum members: 158 */
-	/* sum bitfield members: 13 bits, bit holes: 1, sum bit holes: 3 bits */
-	/* last cacheline: 32 bytes */
+	/* size: 152, cachelines: 3, members: 29 */
+	/* sum members: 150 */
+	/* sum bitfield members: 14 bits, bit holes: 1, sum bit holes: 2 bits */
+	/* last cacheline: 24 bytes */
 };

pre:	5:48.89 real,   220.96 user,    127.55 sys,     24834672 mem
post:	5:39.35 real,   215.58 user,    123.69 sys,     23448736 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |   26 ++++++++++++--------------
 tools/objtool/include/objtool/check.h |    6 +++---
 2 files changed, 15 insertions(+), 17 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1307,26 +1307,24 @@ __weak bool arch_is_rethunk(struct symbo
 	return false;
 }
 
-#define NEGATIVE_RELOC	((void *)-1L)
-
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
-	if (insn->reloc == NEGATIVE_RELOC)
+	struct reloc *reloc;
+
+	if (insn->no_reloc)
 		return NULL;
 
-	if (!insn->reloc) {
-		if (!file)
-			return NULL;
-
-		insn->reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-						       insn->offset, insn->len);
-		if (!insn->reloc) {
-			insn->reloc = NEGATIVE_RELOC;
-			return NULL;
-		}
+	if (!file)
+		return NULL;
+
+	reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					 insn->offset, insn->len);
+	if (!reloc) {
+		insn->no_reloc = 1;
+		return NULL;
 	}
 
-	return insn->reloc;
+	return reloc;
 }
 
 static void remove_insn_ops(struct instruction *insn)
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -55,8 +55,9 @@ struct instruction {
 	   retpoline_safe	: 1,
 	   noendbr		: 1,
 	   entry		: 1,
-	   visited		: 4;
-		/* 3 bit hole */
+	   visited		: 4,
+	   no_reloc		: 1;
+		/* 2 bit hole */
 
 	s8 instr;
 
@@ -65,7 +66,6 @@ struct instruction {
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
 	struct reloc *jump_table;
-	struct reloc *reloc;
 	struct alternative *alts;
 	struct symbol *sym;
 	struct stack_op *stack_ops;


