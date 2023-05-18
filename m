Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB504707EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjERLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjERLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:09:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC8B8;
        Thu, 18 May 2023 04:08:30 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reyccmrVbEtQo1gmP2GIVXd4YlCn8iEs3gvKtsJ8TxE=;
        b=k/rFpu+b5V0mEZhg77DwTC4KjZ8MHE9n/WY7p8aNVk1pCiod+5ks3Nlyr1HUMKRfoZtu/d
        CLiqKoxOVfk4/nlaF00hzDT63gD+cwTBYDkd/Nwubtn/N3BSThQ+8E4M3FVRwo6A3MntHr
        S2giIYAZW+g9iuCuojD8eStTjF1Wxq8fzRclIjCTkdmu6Stj7GQXwq02cEX4aWtgTpuCcW
        zbZoUX/7Q9hGclCoOkCuDELqRKi3zMxw+lzRvr0Sqoo4PL/Gyvi3ALsGHhrKSjybprnjJ4
        Onq6uot03VL9a6oOW5xdnWicYmcUpEx2YQLTNz0AsitPAZTLbc57ST3sP9WX1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reyccmrVbEtQo1gmP2GIVXd4YlCn8iEs3gvKtsJ8TxE=;
        b=5X9lbzY1m/DVAIyLrq+3/OCneNvtqkzEO/kNjw1YRwrGGvO30F9OrWgtz4uPv0bH0O2dqx
        oOq7YK6VZZy7L6Bg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Include backtrace in verbose mode
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c255224fabcf7e64bac232fec1c77c9fc2d7d7ab.1681853186.git.jpoimboe@kernel.org>
References: <c255224fabcf7e64bac232fec1c77c9fc2d7d7ab.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808248.404.17518939246702923401.tip-bot2@tip-bot2>
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

Commit-ID:     ced23d2e3762ecfb859ae65d3a351218edff7205
Gitweb:        https://git.kernel.org/tip/ced23d2e3762ecfb859ae65d3a351218edff7205
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:49 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:52 -07:00

objtool: Include backtrace in verbose mode

Include backtrace in verbose mode.  This makes it easy to gather all the
information needed for diagnosing objtool warnings.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/c255224fabcf7e64bac232fec1c77c9fc2d7d7ab.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  4 ++--
 tools/objtool/check.c                   | 26 +++++++++---------------
 tools/objtool/include/objtool/warn.h    | 14 +++++++------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 8db1f29..9ec8cbf 100644
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
index 0bd0ca4..71985f3 100644
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
index f195dea..ac04d3f 100644
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
