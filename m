Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842C26A03E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjBWIcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjBWIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:32:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3496C4AFE6;
        Thu, 23 Feb 2023 00:32:12 -0800 (PST)
Date:   Thu, 23 Feb 2023 08:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677141127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGU+nF7qav+OJ9LDkFSzeZ6IVlgKz2tfp2L/FR6tr9k=;
        b=iraDayoBsOB8EvDwBLqBnh3YYgQr9RHd6E26HuPxgh5j5XaUtCZYwNyiFvB4FfvEh/S540
        CFHlRiKxr8YUtTmcyrbnWknjasWZzeo1e4BKCJtwBo6RvsuqHbT2ZQJkBVZRfRBaHzPr2g
        nlsFlgJYjYOGdTyp4e8Wb7Td66Wojix8IldFjBEfwwP2ov/XsMaD2cAw+NhwRcb8LOWkuE
        taiQzfG83oH+YxvkNLKz8xY209r6sfAT21CVhtZ+ndCobzfklSAGnp+klhOcFpzMh4+W8t
        aBOllsaeZ6wLckAYYhx5FbvR/061Af0Nilb78N1irf8/PE4rMWLiHmCHzA6klg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677141127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGU+nF7qav+OJ9LDkFSzeZ6IVlgKz2tfp2L/FR6tr9k=;
        b=kD5MAyrhscBk8sm5n6A/Ljlf2twlFNQZJpp84nsEcC92kSvHE9SUozhAw6Q79zHnoL1EyK
        kuS+qDJzKarn10CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove instruction::reloc
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.572145269@infradead.org>
References: <20230208172245.572145269@infradead.org>
MIME-Version: 1.0
Message-ID: <167714112717.5837.1417212622885143717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0932dbe1f5680481e612cafe0c7d0f1796f68612
Gitweb:        https://git.kernel.org/tip/0932dbe1f5680481e612cafe0c7d0f1796f=
68612
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:18:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Feb 2023 09:21:17 +01:00

objtool: Remove instruction::reloc

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.572145269@infradead.org
---
 tools/objtool/check.c                 | 24 +++++++++++-------------
 tools/objtool/include/objtool/check.h |  6 +++---
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9f83e85..6d0ce23 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1305,26 +1305,24 @@ __weak bool arch_is_rethunk(struct symbol *sym)
 	return false;
 }
=20
-#define NEGATIVE_RELOC	((void *)-1L)
-
 static struct reloc *insn_reloc(struct objtool_file *file, struct instructio=
n *insn)
 {
-	if (insn->reloc =3D=3D NEGATIVE_RELOC)
+	struct reloc *reloc;
+
+	if (insn->no_reloc)
 		return NULL;
=20
-	if (!insn->reloc) {
-		if (!file)
-			return NULL;
+	if (!file)
+		return NULL;
=20
-		insn->reloc =3D find_reloc_by_dest_range(file->elf, insn->sec,
-						       insn->offset, insn->len);
-		if (!insn->reloc) {
-			insn->reloc =3D NEGATIVE_RELOC;
-			return NULL;
-		}
+	reloc =3D find_reloc_by_dest_range(file->elf, insn->sec,
+					 insn->offset, insn->len);
+	if (!reloc) {
+		insn->no_reloc =3D 1;
+		return NULL;
 	}
=20
-	return insn->reloc;
+	return reloc;
 }
=20
 static void remove_insn_ops(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index a497ee7..fffc8b8 100644
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
=20
 	s8 instr;
=20
@@ -65,7 +66,6 @@ struct instruction {
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
 	struct reloc *jump_table;
-	struct reloc *reloc;
 	struct alternative *alts;
 	struct symbol *sym;
 	struct stack_op *stack_ops;
