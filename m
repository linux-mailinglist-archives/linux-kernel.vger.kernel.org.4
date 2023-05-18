Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C319707EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjERLJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjERLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:09:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8BF2134;
        Thu, 18 May 2023 04:08:34 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4l2NYHmbJ9RLaYs6c6lgF3CKWCorQeRK5kkXH/k0WVA=;
        b=CZl8PdzbETXyq4DgVVb+dbWxsrmTi2JVR+zUXijPn3ndaR7B4vWBKOEyaQ5XF8y9/qhOIy
        1wUSpHU+wZdacqebipQHpy6G6NbUvRfTV7UXSgTXNMfP0KiMpSFokciPQ8c+SnrMLumsK9
        zOfp8d4ETA74JbtpQKcDLAL6Xk03zZfHGfNLL5CxUz2rWDaPd1+6e5pfkvEAfSEh/AXs8V
        87aR2sIdXWxlfAwX0hKMSH8ZW/0U4T7BpHNGCMPJ2k3us1XjLtzh+lhAXXuBDkSuAoBmlk
        Ni6rSSLXMlbj9KgLwh5bI/N3Rlzk7NwnJGCTmcIIVqx26/WBawu9FHsuVBTonQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4l2NYHmbJ9RLaYs6c6lgF3CKWCorQeRK5kkXH/k0WVA=;
        b=OUVSZqpI7DmB5YP/CtRxNe5fGDqwXLmq/ps+1RaOsBG7NmtLQmUK2zqbBF0Kj2jKlzf3AL
        NiXGhYXcIXcz5mDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add verbose option for disassembling
 affected functions
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dd0fe13428ede186f09c74059a8001f4adcea5fc.1681853186.git.jpoimboe@kernel.org>
References: <dd0fe13428ede186f09c74059a8001f4adcea5fc.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808274.404.5668260031593336858.tip-bot2@tip-bot2>
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

Commit-ID:     ca653464dd097fe64e69f1735e9f348b2a0f8037
Gitweb:        https://git.kernel.org/tip/ca653464dd097fe64e69f1735e9f348b2a0f8037
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:48 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:51 -07:00

objtool: Add verbose option for disassembling affected functions

When a warning is associated with a function, add an option to
disassemble that function.

This makes it easier for reporters to submit the information needed to
diagnose objtool warnings.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/dd0fe13428ede186f09c74059a8001f4adcea5fc.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  5 ++-
 tools/objtool/builtin-check.c           |  5 ++-
 tools/objtool/check.c                   | 77 ++++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |  1 +-
 4 files changed, 88 insertions(+)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 744db42..8db1f29 100644
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
index 7c17519..5e21cfb 100644
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
index 98e6c3b..0bd0ca4 100644
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
index 2a108e6..fcca666 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -37,6 +37,7 @@ struct opts {
 	bool no_unreachable;
 	bool sec_address;
 	bool stats;
+	bool verbose;
 };
 
 extern struct opts opts;
