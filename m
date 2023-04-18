Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0486E6E29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjDRV2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjDRV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5EAD0F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BBC63945
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9872C433A4;
        Tue, 18 Apr 2023 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853280;
        bh=mkUcunGwZcbLDMBJzfgmVtTvYRmD88J1hdWzV9cPHn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8rTKQmVKoRowFB1Jq7qGx9DQ9/NsrY/BoSFNs1K1A9O4YYLn7ohcGN8TuFihLB+g
         TaTb3hO0eTLP2LBZvrGkcwkmN0GGyV89ICl3jyL6BZAkLOk+fC1e3+BtI55vftBGSr
         2ZP6o0Gczg/JnPUuXVViIT/qYPw63CdFJz5ZfXzV6f0sWnquxWV87W1dkvtUi7bWZ5
         42Ag6eY86awyKJWJIx8O9cRunf8u7jg1ZYxIr5cEXK8S+ks09CXhFV1uXCdIkMOZkT
         M0jP+AOkdATyQNedY3gsvuduYfPV8yxjkXaZVRk2YyBjlFz6dyad/n+fGrNI9Yon46
         OD6yD/yFptwww==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 2/8] objtool: Add verbose option for disassembling affected functions
Date:   Tue, 18 Apr 2023 14:27:48 -0700
Message-Id: <dd0fe13428ede186f09c74059a8001f4adcea5fc.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
References: <cover.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a warning is associated with a function, add an option to
disassemble that function.

This makes it easier for reporters to submit the information needed to
diagnose objtool warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  5 ++
 tools/objtool/builtin-check.c           |  5 ++
 tools/objtool/check.c                   | 77 +++++++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  1 +
 4 files changed, 88 insertions(+)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 8e53fc6735ef..4d6c5acde7a3 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -244,6 +244,11 @@ To achieve the validation, objtool enforces the following rules:
 Objtool warnings
 ----------------
 
+NOTE: When requesting help with an objtool warning, please recreate with
+OBJTOOL_VERBOSE=1 (e.g., "make OBJTOOL_VERBOSE=1") and send the full
+output, including any disassembly below the warning, to the objtool
+maintainers.
+
 For asm files, if you're getting an error which doesn't make sense,
 first make sure that the affected code follows the above rules.
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7c175198d09f..5e21cfb7661d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -93,6 +93,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
+	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
 
 	OPT_END(),
 };
@@ -118,6 +119,10 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 		parse_options(envc, envv, check_options, env_usage, 0);
 	}
 
+	env = getenv("OBJTOOL_VERBOSE");
+	if (env && !strcmp(env, "1"))
+		opts.verbose = true;
+
 	argc = parse_options(argc, argv, check_options, usage, 0);
 	if (argc != 1)
 		usage_with_options(usage, check_options);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a00931342c7e..c63e0867daca 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4530,6 +4530,81 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return warnings;
 }
 
+/* 'funcs' is a space-separated list of function names */
+static int disas_funcs(const char *funcs)
+{
+	const char *objdump_str, *cross_compile;
+	int size, ret;
+	char *cmd;
+
+	cross_compile = getenv("CROSS_COMPILE");
+
+	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
+			"BEGIN { split(_funcs, funcs); }"
+			"/^$/ { func_match = 0; }"
+			"/<.*>:/ { "
+				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
+				"for (i in funcs) {"
+					"if (funcs[i] == f) {"
+						"func_match = 1;"
+						"base = strtonum(\"0x\" $1);"
+						"break;"
+					"}"
+				"}"
+			"}"
+			"{"
+				"if (func_match) {"
+					"addr = strtonum(\"0x\" $1);"
+					"printf(\"%%04x \", addr - base);"
+					"print;"
+				"}"
+			"}' 1>&2";
+
+	/* fake snprintf() to calculate the size */
+	size = snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
+	if (size <= 0) {
+		WARN("objdump string size calculation failed");
+		return -1;
+	}
+
+	cmd = malloc(size);
+
+	/* real snprintf() */
+	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
+	ret = system(cmd);
+	if (ret) {
+		WARN("disassembly failed: %d", ret);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int disas_warned_funcs(struct objtool_file *file)
+{
+	struct symbol *sym;
+	char *funcs = NULL, *tmp;
+
+	for_each_sym(file, sym) {
+		if (sym->warned) {
+			if (!funcs) {
+				funcs = malloc(strlen(sym->name) + 1);
+				strcpy(funcs, sym->name);
+			} else {
+				tmp = malloc(strlen(funcs) + strlen(sym->name) + 2);
+				sprintf(tmp, "%s %s", funcs, sym->name);
+				free(funcs);
+				funcs = tmp;
+			}
+		}
+	}
+
+	if (funcs)
+		disas_funcs(funcs);
+
+	return 0;
+}
+
 int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
@@ -4674,6 +4749,8 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.verbose)
+		disas_warned_funcs(file);
 
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 2a108e648b7a..fcca6662c8b4 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -37,6 +37,7 @@ struct opts {
 	bool no_unreachable;
 	bool sec_address;
 	bool stats;
+	bool verbose;
 };
 
 extern struct opts opts;
-- 
2.39.2

