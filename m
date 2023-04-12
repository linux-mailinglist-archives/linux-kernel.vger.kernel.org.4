Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824C96DFFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDLU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDLU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1D18F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A09D638F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F2C4339B;
        Wed, 12 Apr 2023 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331181;
        bh=PtEZ2XxRT+V9+YOlqDPVexSNm4/7T9Gs06ZBZ6BpOSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2pgvMDWoT9nJBFn0Rn1R0uCBjMOfrFyChbbIZ026c93YYDLFX/PFpqjuMdA160Qs
         lXdXXgDUYi5AqcnMuEbsJC8wGcPeBAJp/qsArOMkw2Z254qGFRjpxKquFi7rY+Qgr9
         WuqXMbWj9Nt3y6+QlOvPlT863k3mSIsK9aaXxoBNdFSQpAiwEDdPEpoetc0pITMkY1
         M0ENx/C0StKxtQk2y+fK+ZT0RXg/6IGKGH6x5XOnVWk+gXWk9bzUowvqIbT1hxwIj5
         Cm/VbbvLGD8McPER+7vtxBiu9IK3EFmvjgQDK9kp16QHvRQ9PJD7inpxzZZaMIRjy7
         ZytnaGGKemc5A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 1/3] objtool: Separate prefix code from stack validation code
Date:   Wed, 12 Apr 2023 13:26:13 -0700
Message-Id: <d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681331135.git.jpoimboe@kernel.org>
References: <cover.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the prefix code and make it a standalone feature.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 88 ++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 53940e2ac632..2f3136145b2e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4120,54 +4120,61 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
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
+	int ret, warnings = 0;
+
+	for_each_sec(file, sec) {
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
+		list_for_each_entry(func, &sec->symbol_list, list) {
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
@@ -4186,8 +4193,6 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	add_prefix_symbol(file, sym, insn);
-
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
@@ -4744,6 +4749,13 @@ int check(struct objtool_file *file)
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
-- 
2.39.2

