Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CF68F45E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjBHRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjBHRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06CA2C665
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=c4iXDIqTZJbezvVFwGhR/tsclWYbiTSQB02fC9Oia0s=; b=hNNye+947Z9LCWb8YzeJ6lRyUv
        rTTT2sZx442WDoWjt6m6VKy2MzplIkf6PaKWA42xBamy2yb+GumhiCiKWp2yFIMVKMB03NZ1xle21
        Z0vJP1Jq05cmHP07MeaZCc2tAg3jYr/oOPk5B32Oc9XchAcd4BJLUX+Wa4LhDfz03SQ9R09hPJqeN
        u05fieyFJ1n0Iif0cLEJB/kHAsi/tMpGrYZKmL8+0+w8YXwvG+026+LmG4xGb+yu2Wgmv5E7VH4ws
        1zu6jHhjnoAn4gWk3LtxSzW4HiWM9VySQO1foPna4z6wkuSgy+sX5hGAgnlEb1rFhGj+a5uzCZccw
        wZKkWwCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPoAg-001PY3-6C; Wed, 08 Feb 2023 17:23:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26795300912;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0E352203C2EC8; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.501847188@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 04/10] objtool: Shrink instruction::{type,visited}
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
---
 tools/objtool/include/objtool/check.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
 
 	s8 instr;
-	u8 visited;
 
 	struct alt_group *alt_group;
 	struct symbol *call_dest;


