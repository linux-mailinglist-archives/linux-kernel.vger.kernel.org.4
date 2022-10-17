Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D56011E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJQO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJQOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34756919B;
        Mon, 17 Oct 2022 07:54:00 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wEbSB4eYOnzEgjZLzAxChD4UceIefjlICnfOr05C2gc=;
        b=m6JyQ0xDyTmdSD/7qlqK7x/P1rSTn15xlpesMyuDzO5UM2c7J6kgqzIkjvAyabObVPfG5m
        DBH+nTe5nJTEBJ5W/CMIWJNMypSH6AiTyNeoumHLQdQlPYfTvTrBi1MKVdO0Er8GIjCibm
        j1yyOBHva89KBCtib0ud9nvUmb5nG+UgpUso29yDzFLfdZUOlDSkJjDZpm/KYtCKRNKoIB
        MDdzz49T8+4Xae/XhjnzlTtllflmq2J/rdgLRw+qpYzW5IqiG7ifDVtBc1dd5we2lkSXd+
        djV9CEDhCLaxeCGSyaeG4yQs61egTrdSJERA4P0FZM0CfXRYP21R4EUP1nwnTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wEbSB4eYOnzEgjZLzAxChD4UceIefjlICnfOr05C2gc=;
        b=21lr+pkk6b+WAPNm0Fpi6KXSyu4UeweB3K4U/pe5/Wfx9eb4oD3S3KPREiY3NwGATzKaSI
        yHLzqAs3fskevGAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Allow STT_NOTYPE -> STT_FUNC+0 sibling-calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166601843470.401.18305296132807566901.tip-bot2@tip-bot2>
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

Commit-ID:     5a9c361a416fc3a3301e859ff09587cc1b933eb8
Gitweb:        https://git.kernel.org/tip/5a9c361a416fc3a3301e859ff09587cc1b933eb8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 11 Jul 2022 11:49:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:09 +02:00

objtool: Allow STT_NOTYPE -> STT_FUNC+0 sibling-calls

Teach objtool about STT_NOTYPE -> STT_FUNC+0 sibling calls. Doing do
allows slightly simpler .S files.

There is a slight complication in that we specifically do not want to
allow sibling calls from symbol holes (previously covered by STT_WEAK
symbols) -- such things exist where a weak function has a .cold
subfunction for example.

Additionally, STT_NOTYPE tail-calls are allowed to happen with a
modified stack frame, they don't need to obey the normal rules after
all.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c | 74 ++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e532efb..7936312 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -129,16 +129,13 @@ static bool is_jump_table_jump(struct instruction *insn)
 static bool is_sibling_call(struct instruction *insn)
 {
 	/*
-	 * Assume only ELF functions can make sibling calls.  This ensures
-	 * sibling call detection consistency between vmlinux.o and individual
-	 * objects.
+	 * Assume only STT_FUNC calls have jump-tables.
 	 */
-	if (!insn_func(insn))
-		return false;
-
-	/* An indirect jump is either a sibling call or a jump to a table. */
-	if (insn->type == INSN_JUMP_DYNAMIC)
-		return !is_jump_table_jump(insn);
+	if (insn_func(insn)) {
+		/* An indirect jump is either a sibling call or a jump to a table. */
+		if (insn->type == INSN_JUMP_DYNAMIC)
+			return !is_jump_table_jump(insn);
+	}
 
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
 	return (is_static_jump(insn) && insn->call_dest);
@@ -1400,21 +1397,18 @@ static void add_return_call(struct objtool_file *file, struct instruction *insn,
 		list_add_tail(&insn->call_node, &file->return_thunk_list);
 }
 
-static bool same_function(struct instruction *insn1, struct instruction *insn2)
-{
-	return insn_func(insn1)->pfunc == insn_func(insn2)->pfunc;
-}
-
-static bool is_first_func_insn(struct objtool_file *file, struct instruction *insn)
+static bool is_first_func_insn(struct objtool_file *file,
+			       struct instruction *insn, struct symbol *sym)
 {
-	if (insn->offset == insn_func(insn)->offset)
+	if (insn->offset == sym->offset)
 		return true;
 
+	/* Allow direct CALL/JMP past ENDBR */
 	if (opts.ibt) {
 		struct instruction *prev = prev_insn_same_sym(file, insn);
 
 		if (prev && prev->type == INSN_ENDBR &&
-		    insn->offset == insn_func(insn)->offset + prev->len)
+		    insn->offset == sym->offset + prev->len)
 			return true;
 	}
 
@@ -1422,6 +1416,32 @@ static bool is_first_func_insn(struct objtool_file *file, struct instruction *in
 }
 
 /*
+ * A sibling call is a tail-call to another symbol -- to differentiate from a
+ * recursive tail-call which is to the same symbol.
+ */
+static bool jump_is_sibling_call(struct objtool_file *file,
+				 struct instruction *from, struct instruction *to)
+{
+	struct symbol *fs = from->sym;
+	struct symbol *ts = to->sym;
+
+	/* Not a sibling call if from/to a symbol hole */
+	if (!fs || !ts)
+		return false;
+
+	/* Not a sibling call if not targeting the start of a symbol. */
+	if (!is_first_func_insn(file, to, ts))
+		return false;
+
+	/* Disallow sibling calls into STT_NOTYPE */
+	if (ts->type == STT_NOTYPE)
+		return false;
+
+	/* Must not be self to be a sibling */
+	return fs->pfunc != ts->pfunc;
+}
+
+/*
  * Find the destination instructions for all jumps.
  */
 static int add_jump_destinations(struct objtool_file *file)
@@ -1519,18 +1539,18 @@ static int add_jump_destinations(struct objtool_file *file)
 			    strstr(insn_func(jump_dest)->name, ".cold")) {
 				insn_func(insn)->cfunc = insn_func(jump_dest);
 				insn_func(jump_dest)->pfunc = insn_func(insn);
-
-			} else if (!same_function(insn, jump_dest) &&
-				   is_first_func_insn(file, jump_dest)) {
-				/*
-				 * Internal sibling call without reloc or with
-				 * STT_SECTION reloc.
-				 */
-				add_call_dest(file, insn, insn_func(jump_dest), true);
-				continue;
 			}
 		}
 
+		if (jump_is_sibling_call(file, insn, jump_dest)) {
+			/*
+			 * Internal sibling call without reloc or with
+			 * STT_SECTION reloc.
+			 */
+			add_call_dest(file, insn, insn_func(jump_dest), true);
+			continue;
+		}
+
 		insn->jump_dest = jump_dest;
 	}
 
@@ -3309,7 +3329,7 @@ static int validate_sibling_call(struct objtool_file *file,
 				 struct instruction *insn,
 				 struct insn_state *state)
 {
-	if (has_modified_stack_frame(insn, state)) {
+	if (insn_func(insn) && has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
