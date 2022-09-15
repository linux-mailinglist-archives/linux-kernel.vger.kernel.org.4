Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8225B9A08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiIOLoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiIOLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA237E328
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9OeUQ8WKvjmDCQa64vw6vBkwEukGFdObNeGXaylenLQ=; b=Dlf8r2UMJtDp0P3FmjUdDH6lQO
        peLUR5t68SZCw7c5DzwB1wQPGWHWTL32BFoYp6QXpsFinx3Pn9rC3n2rvC0wrNM5rAIJTSqY/lWPR
        XGbd3QDXQ2wEIY6dsztorpNnEjgIy1fJwypD0Z+X27m5zKJiXXw4owfnlMNQpJ7+AcNWPwaZkK48D
        X6iIwjvBwPTDpjxKpjlZWPT71ejegTBztToh2gVk9DkuSpEBSULT/DyOanqbpffJkjxTHsOSmdgv1
        USKF1jovVe4H3DAv0+OUpgotm45niC9K46aDAqRFrSRBNZyV6YbYTMkGRzlGOjk6uO5rrxKVjZj+f
        ZAfdAtKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDi-00CabE-9g; Thu, 15 Sep 2022 11:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0CCA302D80;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AB3A729A24305; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111146.434642471@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 34/59] objtool: Allow symbol range comparisons for IBT/ENDBR
References: <20220915111039.092790446@infradead.org>
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

From: Peter Zijlstra <peterz@infradead.org>

A semi common pattern is where code checks if a code address is
within a specific range. All text addresses require either ENDBR or
ANNOTATE_ENDBR, however the ANNOTATE_NOENDBR past the range is
unnatural.

Instead, suppress this warning when this is exactly at the end of a
symbol that itself starts with either ENDBR/ANNOTATE_ENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64_compat.S |    1 -
 tools/objtool/check.c            |   28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -128,7 +128,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
-	ANNOTATE_NOENDBR // is_sysenter_singlestep
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4016,6 +4016,24 @@ static void mark_endbr_used(struct instr
 		list_del_init(&insn->call_node);
 }
 
+static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
+{
+	struct symbol *sym = find_symbol_containing(insn->sec, insn->offset-1);
+	struct instruction *first;
+
+	if (!sym)
+		return false;
+
+	first = find_insn(file, sym->sec, sym->offset);
+	if (!first)
+		return false;
+
+	if (first->type != INSN_ENDBR && !first->noendbr)
+		return false;
+
+	return insn->offset == sym->offset + sym->len;
+}
+
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
@@ -4088,9 +4106,19 @@ static int validate_ibt_insn(struct objt
 			continue;
 		}
 
+		/*
+		 * Accept anything ANNOTATE_NOENDBR.
+		 */
 		if (dest->noendbr)
 			continue;
 
+		/*
+		 * Accept if this is the instruction after a symbol
+		 * that is (no)endbr -- typical code-range usage.
+		 */
+		if (noendbr_range(file, dest))
+			continue;
+
 		WARN_FUNC("relocation to !ENDBR: %s",
 			  insn->sec, insn->offset,
 			  offstr(dest->sec, dest->offset));


