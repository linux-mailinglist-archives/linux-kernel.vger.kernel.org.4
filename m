Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBC6E6E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjDRV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjDRV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B62BBB1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E606395A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4AEC433A0;
        Tue, 18 Apr 2023 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853280;
        bh=pBU1V3n8RoeNydoWkCOq7gRDOLCsSaGVqI+g1UM+LHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mG5cYVFRVoVveup0sM4ym0gMevTAZG6FJHEsWSU21tEm7ayDCeF9gOXAR0VM8DZjr
         5C14MITk1NDLNM/Ax3aI8n6SmbQHnNTz1tpR3JqM/fVwKUB5JEcWwScT9AQ9zO/zY0
         V1TwpLTdaU5F9enIOoKlMdTbPwx1rbwpyKYZOWDlCS0imSE3fdi0Dsd401W/kkHwol
         0izRQKppbnRm2/maVb9w6Cr3xQ6XBvQctEelTOU8j+IePma+pdIBNa2pHnB7euNPQ4
         PWK8kIF7YPEiIyvdoRk7E6utFwNxEuncCeijR6PmxWB9a0R0jyyTsNqY526UEUvwUz
         0HAzKEFGPD6WA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 3/8] objtool: Include backtrace in verbose mode
Date:   Tue, 18 Apr 2023 14:27:49 -0700
Message-Id: <c255224fabcf7e64bac232fec1c77c9fc2d7d7ab.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
References: <cover.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include backtrace in verbose mode.  This makes it easy to gather all the
information needed for diagnosing objtool warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  4 ++--
 tools/objtool/check.c                   | 26 ++++++++++---------------
 tools/objtool/include/objtool/warn.h    | 14 +++++++------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 4d6c5acde7a3..5a69c207a10e 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -246,8 +246,8 @@ Objtool warnings
 
 NOTE: When requesting help with an objtool warning, please recreate with
 OBJTOOL_VERBOSE=1 (e.g., "make OBJTOOL_VERBOSE=1") and send the full
-output, including any disassembly below the warning, to the objtool
-maintainers.
+output, including any disassembly or backtrace below the warning, to the
+objtool maintainers.
 
 For asm files, if you're getting an error which doesn't make sense,
 first make sure that the affected code follows the above rules.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c63e0867daca..aa083296af1e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3657,8 +3657,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
-					if (opts.backtrace)
-						BT_FUNC("(alt)", insn);
+					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
@@ -3703,8 +3702,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
-					if (opts.backtrace)
-						BT_FUNC("(branch)", insn);
+					BT_INSN(insn, "(branch)");
 					return ret;
 				}
 			}
@@ -3802,8 +3800,8 @@ static int validate_unwind_hint(struct objtool_file *file,
 {
 	if (insn->hint && !insn->visited && !insn->ignore) {
 		int ret = validate_branch(file, insn_func(insn), insn, *state);
-		if (ret && opts.backtrace)
-			BT_FUNC("<=== (hint)", insn);
+		if (ret)
+			BT_INSN(insn, "<=== (hint)");
 		return ret;
 	}
 
@@ -3861,8 +3859,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 				ret = validate_unret(file, alt->insn);
 				if (ret) {
-				        if (opts.backtrace)
-						BT_FUNC("(alt)", insn);
+					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
@@ -3888,10 +3885,8 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 				}
 				ret = validate_unret(file, insn->jump_dest);
 				if (ret) {
-					if (opts.backtrace) {
-						BT_FUNC("(branch%s)", insn,
-							insn->type == INSN_JUMP_CONDITIONAL ? "-cond" : "");
-					}
+					BT_INSN(insn, "(branch%s)",
+						insn->type == INSN_JUMP_CONDITIONAL ? "-cond" : "");
 					return ret;
 				}
 
@@ -3913,8 +3908,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 			ret = validate_unret(file, dest);
 			if (ret) {
-				if (opts.backtrace)
-					BT_FUNC("(call)", insn);
+				BT_INSN(insn, "(call)");
 				return ret;
 			}
 			/*
@@ -4216,8 +4210,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
-	if (ret && opts.backtrace)
-		BT_FUNC("<=== (sym)", insn);
+	if (ret)
+		BT_INSN(insn, "<=== (sym)");
 	return ret;
 }
 
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index f195deab456e..ac04d3fe4dd9 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -63,12 +63,14 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 		_insn->sym->warned = 1;					\
 })
 
-#define BT_FUNC(format, insn, ...)			\
-({							\
-	struct instruction *_insn = (insn);		\
-	char *_str = offstr(_insn->sec, _insn->offset); \
-	WARN("  %s: " format, _str, ##__VA_ARGS__);	\
-	free(_str);					\
+#define BT_INSN(insn, format, ...)				\
+({								\
+	if (opts.verbose || opts.backtrace) {			\
+		struct instruction *_insn = (insn);		\
+		char *_str = offstr(_insn->sec, _insn->offset); \
+		WARN("  %s: " format, _str, ##__VA_ARGS__);	\
+		free(_str);					\
+	}							\
 })
 
 #define WARN_ELF(format, ...)				\
-- 
2.39.2

