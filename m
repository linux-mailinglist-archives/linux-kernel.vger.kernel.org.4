Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D16DFE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDLTEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDLTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96CBE6F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11EAC6387F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD80C433EF;
        Wed, 12 Apr 2023 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326227;
        bh=ALLHXWLy6y39aAaEiGHQFmrawumL94Hfe6ZlVC/BQUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aStfXEpTrgz7R5gGwQpVWCMa1e/aFwS0LM8H2J0mdNSdYpbXavmcZtOxgVFbFpU8s
         vLQT4p9dMG2o903/IMeW3fY17wQh51/QR8X4zc512DYPheoP4Wqtar8Ah7KDTJetKS
         rqv2mdZJV3/PfYwz2anB86tac0IFJzJZAvgBX6QfpZK+43o/yOe2oIwGtArCUgcYdX
         jgAgQhD1Lub4/h32jSgH+q6JPUr+KVy8gnFYY/VMPuYYQPSZDZUXnA9hzXqEMKIadw
         NhMT7HmI7X84gsO9hiuIcRTvn1NAcOFfRqGqsENcQP3Qor9n5rdeJiujmGh3xeqvWC
         6h4subfi9ayvw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 6/9] objtool: Include backtrace in verbose mode
Date:   Wed, 12 Apr 2023 12:03:21 -0700
Message-Id: <6a11522b7d2fdb713ec80a89fe8cb199ddb511b6.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681325924.git.jpoimboe@kernel.org>
References: <cover.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index bc9dd69c9a45..b9e5e0e9c1ee 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3654,8 +3654,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
-					if (opts.backtrace)
-						BT_FUNC("(alt)", insn);
+					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
@@ -3700,8 +3699,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
-					if (opts.backtrace)
-						BT_FUNC("(branch)", insn);
+					BT_INSN(insn, "(branch)");
 					return ret;
 				}
 			}
@@ -3799,8 +3797,8 @@ static int validate_unwind_hint(struct objtool_file *file,
 {
 	if (insn->hint && !insn->visited && !insn->ignore) {
 		int ret = validate_branch(file, insn_func(insn), insn, *state);
-		if (ret && opts.backtrace)
-			BT_FUNC("<=== (hint)", insn);
+		if (ret)
+			BT_INSN(insn, "<=== (hint)");
 		return ret;
 	}
 
@@ -3858,8 +3856,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 				ret = validate_unret(file, alt->insn);
 				if (ret) {
-				        if (opts.backtrace)
-						BT_FUNC("(alt)", insn);
+					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
@@ -3885,10 +3882,8 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
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
 
@@ -3910,8 +3905,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 			ret = validate_unret(file, dest);
 			if (ret) {
-				if (opts.backtrace)
-					BT_FUNC("(call)", insn);
+				BT_INSN(insn, "(call)");
 				return ret;
 			}
 			/*
@@ -4195,8 +4189,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
-	if (ret && opts.backtrace)
-		BT_FUNC("<=== (sym)", insn);
+	if (ret)
+		BT_INSN(insn, "<=== (sym)");
 	return ret;
 }
 
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 4ef9b278e5fd..856ea8bc10d7 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -61,12 +61,14 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 		insn->sym->warned = 1;					\
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

