Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BB6E2622
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDNOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjDNOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:47:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191BB748;
        Fri, 14 Apr 2023 07:47:56 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3vxGja9f4eMtuDashMJ8NhHcbldqcXJTbhqo15/T+8=;
        b=pQmFMCW+fVb4CzW7MNISY8cnbvg+hlJxK6GXEup1UA5X7E7IOshW4pOd9TM9yUjolLi79M
        9Z9igxXiBp18cz/O0bLIu4/TvMBVZ/Kzu41/1MGxAuVm49HdaudoRQC/pr47KydcgS4Wy7
        mDlBA/bX9RB3fNz+wvrsogC71AfLHpSeeNPQNvV6uwG9aIwq8Q75l9Rq6SWmhKWj92fleg
        2uV8JTXLxKwHEPUhbmOjiE84CT+ctbJyvSYZfbRklr2fdn9I0YOWfVmqQ3tkJgyCWmKIjH
        KDKjFMemrcpzuopD/dJO6WoV7OgBB77KoVMiOhgegNbWRpD2j3ychoWsOee1Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3vxGja9f4eMtuDashMJ8NhHcbldqcXJTbhqo15/T+8=;
        b=WdnytkO5Fqwuigmbl8RFl9dEv7URIUaDwPEOLmjmybR6vCFOlsbqcmvzDWKtZ+/va1t3Q1
        MtWfGd48/ytiWIDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Separate prefix code from stack validation code
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org>
References: <d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367491.404.14493212462771615260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bd456a1bedd20cebd37493f8cb0291294a7356ea
Gitweb:        https://git.kernel.org/tip/bd456a1bedd20cebd37493f8cb0291294a7356ea
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 13:26:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:29 +02:00

objtool: Separate prefix code from stack validation code

Simplify the prefix code by moving it after
validate_reachable_instructions().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 88 +++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1cf2e28..8ee4d51 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4114,54 +4114,61 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	return false;
 }
 
-static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
-			     struct instruction *insn)
+static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
 {
-	if (!opts.prefix)
-		return 0;
+	struct instruction *insn, *prev;
 
-	for (;;) {
-		struct instruction *prev = prev_insn_same_sec(file, insn);
-		u64 offset;
+	insn = find_insn(file, func->sec, func->offset);
+	if (!insn)
+		return -1;
 
-		if (!prev)
-			break;
+	for (prev = prev_insn_same_sec(file, insn);
+	     prev;
+	     prev = prev_insn_same_sec(file, prev)) {
+		u64 offset;
 
 		if (prev->type != INSN_NOP)
-			break;
+			return -1;
 
 		offset = func->offset - prev->offset;
-		if (offset >= opts.prefix) {
-			if (offset == opts.prefix) {
-				/*
-				 * Since the sec->symbol_list is ordered by
-				 * offset (see elf_add_symbol()) the added
-				 * symbol will not be seen by the iteration in
-				 * validate_section().
-				 *
-				 * Hence the lack of list_for_each_entry_safe()
-				 * there.
-				 *
-				 * The direct concequence is that prefix symbols
-				 * don't get visited (because pointless), except
-				 * for the logic in ignore_unreachable_insn()
-				 * that needs the terminating insn to be visited
-				 * otherwise it will report the hole.
-				 *
-				 * Hence mark the first instruction of the
-				 * prefix symbol as visisted.
-				 */
-				prev->visited |= VISITED_BRANCH;
-				elf_create_prefix_symbol(file->elf, func, opts.prefix);
-			}
-			break;
-		}
-		insn = prev;
+
+		if (offset > opts.prefix)
+			return -1;
+
+		if (offset < opts.prefix)
+			continue;
+
+		elf_create_prefix_symbol(file->elf, func, opts.prefix);
+		break;
 	}
 
+	if (!prev)
+		return -1;
+
 	return 0;
 }
 
+static int add_prefix_symbols(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *func;
+	int warnings = 0;
+
+	for_each_sec(file, sec) {
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
+		sec_for_each_sym(sec, func) {
+			if (func->type != STT_FUNC)
+				continue;
+
+			add_prefix_symbol(file, func);
+		}
+	}
+
+	return warnings;
+}
+
 static int validate_symbol(struct objtool_file *file, struct section *sec,
 			   struct symbol *sym, struct insn_state *state)
 {
@@ -4180,8 +4187,6 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	add_prefix_symbol(file, sym, insn);
-
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
@@ -4621,6 +4626,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.prefix) {
+		ret = add_prefix_symbols(file);
+		if (ret < 0)
+			return ret;
+		warnings += ret;
+	}
+
 	if (opts.ibt) {
 		ret = create_ibt_endbr_seal_sections(file);
 		if (ret < 0)
