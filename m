Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D06CA9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjC0QBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjC0QBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223306181
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDEC61360
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4DBC433A0;
        Mon, 27 Mar 2023 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932856;
        bh=cs2v2L19PFI4Qr/i72VjLOqDUF7s1Wn6MGxQhSSimu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2SNBv4/oV5HVK55UwiwjP/7gI449xEUPzntxXzYyIOMgx8cEOEqsJN5BCl3XKnD9
         HFKXK7eddyNJXaCniPst8agGIweJj1vz+44vj590+kKwLbAorTQmAIOAzKS6nKVwV9
         Mx9njW+yjbCwPYHztyIevU1qcIEW8V3CHsrHcZKTk0q152nBKdrDgIvMWIpMesWIdM
         z1hySE8w3imxYYw8tGMSGMI08Ub+VQtAEqLPt3OGTVoSPXaUMzx2YfNiAlbR+tjhN4
         9213HzYPRShcAzedB9KtYb6rAbLRvM6CIxXlO2Pzg9vzzGZY1IVSmSVS1nzy5GRWtK
         3vq8/B+fF+0BQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/5] objtool: Combine '--backtrace' with '--verbose'
Date:   Mon, 27 Mar 2023 09:00:45 -0700
Message-Id: <ef477e7cf3f188c623279764e831772eab2a4016.1679932620.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679932620.git.jpoimboe@kernel.org>
References: <cover.1679932620.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the '--backtrace' option, instead including that
functionality in '--verbose'.  This makes it easy to gather all the
information needed for diagnosing objtool warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  4 ++--
 tools/objtool/builtin-check.c           |  1 -
 tools/objtool/check.c                   | 22 ++++++++--------------
 tools/objtool/include/objtool/builtin.h |  1 -
 tools/objtool/include/objtool/warn.h    | 14 ++++++++------
 5 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c1a46af322f..ec6f82fb414c 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -246,8 +246,8 @@ Objtool warnings
 
 NOTE: When requesting help with an objtool warning, please re-run the
 kernel build with `OBJTOOL_ARGS="--verbose" make <whatever>` and send
-the full warning output (including any function disassembly below the
-warning) to the objtool maintainers.
+the full warning output (including any function disassembly or objtool
+backtrace below the warning) to the objtool maintainers.
 
 For asm files, if you're getting an error which doesn't make sense,
 first make sure that the affected code follows the above rules.
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index b8de42f6778e..937ba5d78e08 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -84,7 +84,6 @@ static const struct option check_options[] = {
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
-	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
 	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cae6ac6ff246..a652b9e5c805 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3708,8 +3708,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
-					if (opts.backtrace)
-						BT_FUNC("(alt)", insn);
+					BT_FUNC("(alt)", insn);
 					return ret;
 				}
 			}
@@ -3755,8 +3754,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
-					if (opts.backtrace)
-						BT_FUNC("(branch)", insn);
+					BT_FUNC("(branch)", insn);
 					return ret;
 				}
 			}
@@ -3855,7 +3853,7 @@ static int validate_unwind_hint(struct objtool_file *file,
 {
 	if (insn->hint && !insn->visited && !insn->ignore) {
 		int ret = validate_branch(file, insn_func(insn), insn, *state);
-		if (ret && opts.backtrace)
+		if (ret)
 			BT_FUNC("<=== (hint)", insn);
 		return ret;
 	}
@@ -3914,8 +3912,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 				ret = validate_unret(file, alt->insn);
 				if (ret) {
-				        if (opts.backtrace)
-						BT_FUNC("(alt)", insn);
+					BT_FUNC("(alt)", insn);
 					return ret;
 				}
 			}
@@ -3942,10 +3939,8 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 				}
 				ret = validate_unret(file, insn->jump_dest);
 				if (ret) {
-					if (opts.backtrace) {
-						BT_FUNC("(branch%s)", insn,
-							insn->type == INSN_JUMP_CONDITIONAL ? "-cond" : "");
-					}
+					BT_FUNC("(branch%s)", insn,
+						insn->type == INSN_JUMP_CONDITIONAL ? "-cond" : "");
 					return ret;
 				}
 
@@ -3967,8 +3962,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 			ret = validate_unret(file, dest);
 			if (ret) {
-				if (opts.backtrace)
-					BT_FUNC("(call)", insn);
+				BT_FUNC("(call)", insn);
 				return ret;
 			}
 			/*
@@ -4254,7 +4248,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
-	if (ret && opts.backtrace)
+	if (ret)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fcca6662c8b4..38aef760465e 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -28,7 +28,6 @@ struct opts {
 	bool cfi;
 
 	/* options: */
-	bool backtrace;
 	bool backup;
 	bool dryrun;
 	bool link;
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index b85aa440ee1f..a9ec1ed6a2e3 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -91,12 +91,14 @@ static inline void objdump_func(struct section *sec, unsigned long offset)
 		objdump_func(sec, offset);		\
 })
 
-#define BT_FUNC(format, insn, ...)			\
-({							\
-	struct instruction *_insn = (insn);		\
-	char *_str = offstr(_insn->sec, _insn->offset); \
-	WARN("  %s: " format, _str, ##__VA_ARGS__);	\
-	free(_str);					\
+#define BT_FUNC(format, insn, ...)				\
+({								\
+	if (opts.verbose) {					\
+		struct instruction *_insn = (insn);		\
+		char *_str = offstr(_insn->sec, _insn->offset); \
+		WARN("  %s: " format, _str, ##__VA_ARGS__);	\
+		free(_str);					\
+	}							\
 })
 
 #define WARN_ELF(format, ...)				\
-- 
2.39.2

