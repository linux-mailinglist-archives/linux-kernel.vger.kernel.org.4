Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDAF6A03E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjBWIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjBWIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:32:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38E4D61C;
        Thu, 23 Feb 2023 00:32:12 -0800 (PST)
Date:   Thu, 23 Feb 2023 08:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677141127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwrNXKne5HFSSFx4JRcNK7XBvrwT67vvQbynXrqu29I=;
        b=sewb1GiaNKXzHcGfnKramAq3JUbWX6u9jIEN3xN7FT7xwYpF3M0aGpRIY/wDBhyCay10Q1
        OKi3A43o3SsOE4zkfaImcVREV77ZD/NHLhilARbdexxVOWypgJ3Mn934aAOW3umulo5Jib
        RLV/EDU5FFYh2wkr8V8iwY59YOgFJ8HPhgxjpOOgWrjLlQM4tjC7E2jVLDdqyoF9BzIIyy
        uBNOPTl0Wm3n9CPDHO5+/beILT5/ZfEsYKHWp+AaFItaHsU1e8fcN8wNLBmRGYt3qdk6FT
        Lk6Z/NYxonleswsSQa7LaATOgXtVTXkuoGq8dP5LDy81dyp/Ko4feMqaUU2jGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677141127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwrNXKne5HFSSFx4JRcNK7XBvrwT67vvQbynXrqu29I=;
        b=Yksa79cls4Z+m/mHfdXOIeXs0w4+kIxzarKneeAQcqXwafzBcgIJ0RvZ5i2zLmukk+Yub/
        W2nSf6BvbX/XkHCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Shrink instruction::{type,visited}
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.501847188@infradead.org>
References: <20230208172245.501847188@infradead.org>
MIME-Version: 1.0
Message-ID: <167714112746.5837.4736451316414863518.tip-bot2@tip-bot2>
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

Commit-ID:     8b2de412158ecdb312c707918432e6650df808cc
Gitweb:        https://git.kernel.org/tip/8b2de412158ecdb312c707918432e6650df=
808cc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:18:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Feb 2023 09:21:12 +01:00

objtool: Shrink instruction::{type,visited}

Since we don't have that many types in enum insn_type, force it into a
u8 and re-arrange member to get rid of the holes, saves another 8
bytes.

 struct instruction {
 	struct list_head           list;                 /*     0    16 */
 	struct hlist_node          hash;                 /*    16    16 */
 	struct list_head           call_node;            /*    32    16 */
 	struct section *           sec;                  /*    48     8 */
 	long unsigned int          offset;               /*    56     8 */
 	/* --- cacheline 1 boundary (64 bytes) --- */
-	unsigned int               len;                  /*    64     4 */
-	enum insn_type             type;                 /*    68     4 */
-	long unsigned int          immediate;            /*    72     8 */
-	u16                        dead_end:1;           /*    80: 0  2 */
-	u16                        ignore:1;             /*    80: 1  2 */
-	u16                        ignore_alts:1;        /*    80: 2  2 */
-	u16                        hint:1;               /*    80: 3  2 */
-	u16                        save:1;               /*    80: 4  2 */
-	u16                        restore:1;            /*    80: 5  2 */
-	u16                        retpoline_safe:1;     /*    80: 6  2 */
-	u16                        noendbr:1;            /*    80: 7  2 */
-	u16                        entry:1;              /*    80: 8  2 */
+	long unsigned int          immediate;            /*    64     8 */
+	unsigned int               len;                  /*    72     4 */
+	u8                         type;                 /*    76     1 */

-	/* XXX 7 bits hole, try to pack */
+	/* Bitfield combined with previous fields */

-	s8                         instr;                /*    82     1 */
-	u8                         visited;              /*    83     1 */
+	u16                        dead_end:1;           /*    76: 8  2 */
+	u16                        ignore:1;             /*    76: 9  2 */
+	u16                        ignore_alts:1;        /*    76:10  2 */
+	u16                        hint:1;               /*    76:11  2 */
+	u16                        save:1;               /*    76:12  2 */
+	u16                        restore:1;            /*    76:13  2 */
+	u16                        retpoline_safe:1;     /*    76:14  2 */
+	u16                        noendbr:1;            /*    76:15  2 */
+	u16                        entry:1;              /*    78: 0  2 */
+	u16                        visited:4;            /*    78: 1  2 */

-	/* XXX 4 bytes hole, try to pack */
+	/* XXX 3 bits hole, try to pack */
+	/* Bitfield combined with next fields */

-	struct alt_group *         alt_group;            /*    88     8 */
-	struct symbol *            call_dest;            /*    96     8 */
-	struct instruction *       jump_dest;            /*   104     8 */
-	struct instruction *       first_jump_src;       /*   112     8 */
-	struct reloc *             jump_table;           /*   120     8 */
+	s8                         instr;                /*    79     1 */
+	struct alt_group *         alt_group;            /*    80     8 */
+	struct symbol *            call_dest;            /*    88     8 */
+	struct instruction *       jump_dest;            /*    96     8 */
+	struct instruction *       first_jump_src;       /*   104     8 */
+	struct reloc *             jump_table;           /*   112     8 */
+	struct reloc *             reloc;                /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
-	struct reloc *             reloc;                /*   128     8 */
-	struct alternative *       alts;                 /*   136     8 */
-	struct symbol *            sym;                  /*   144     8 */
-	struct stack_op *          stack_ops;            /*   152     8 */
-	struct cfi_state *         cfi;                  /*   160     8 */
+	struct alternative *       alts;                 /*   128     8 */
+	struct symbol *            sym;                  /*   136     8 */
+	struct stack_op *          stack_ops;            /*   144     8 */
+	struct cfi_state *         cfi;                  /*   152     8 */

-	/* size: 168, cachelines: 3, members: 29 */
-	/* sum members: 162, holes: 1, sum holes: 4 */
-	/* sum bitfield members: 9 bits, bit holes: 1, sum bit holes: 7 bits */
-	/* last cacheline: 40 bytes */
+	/* size: 160, cachelines: 3, members: 29 */
+	/* sum members: 158 */
+	/* sum bitfield members: 13 bits, bit holes: 1, sum bit holes: 3 bits */
+	/* last cacheline: 32 bytes */
 };

pre:	5:48.86 real,   220.30 user,    128.34 sys,     24834672 mem
post:	5:48.89 real,   220.96 user,    127.55 sys,     24834672 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.501847188@infradead.org
---
 tools/objtool/include/objtool/check.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 7966f60..a497ee7 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -42,9 +42,9 @@ struct instruction {
 	struct list_head call_node;
 	struct section *sec;
 	unsigned long offset;
-	unsigned int len;
-	enum insn_type type;
 	unsigned long immediate;
+	unsigned int len;
+	u8 type;
=20
 	u16 dead_end		: 1,
 	   ignore		: 1,
@@ -54,11 +54,11 @@ struct instruction {
 	   restore		: 1,
 	   retpoline_safe	: 1,
 	   noendbr		: 1,
-	   entry		: 1;
-		/* 7 bit hole */
+	   entry		: 1,
+	   visited		: 4;
+		/* 3 bit hole */
=20
 	s8 instr;
-	u8 visited;
=20
 	struct alt_group *alt_group;
 	struct symbol *call_dest;
