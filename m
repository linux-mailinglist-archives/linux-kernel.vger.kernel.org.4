Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECA6CA9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjC0QBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjC0QBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:01:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318B061AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A302CE1895
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8987AC433EF;
        Mon, 27 Mar 2023 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932855;
        bh=bYtZM+fVMt9qB3FBfutuXiVUqLBuKD6bVnTa58kw0c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fe77Ph3byGHORIBfErdD+mVoeIP2sM1YLoQpXcTU8uUmT0Mi0ltNPXcjNEqat5nfq
         vAlmx04lOmS0ABs1gV2fZ+GuQpzu+xcCiqXmXWbbhyvZgp7+p5bTf8PL5lnwqj+aVj
         c5/CNYra7ebHh5TyKogdYYCbayNuBbCBQjiK8j6VWTXq271ipXmDYY4MpR1WhgTleb
         dqbLjTvjW1YT5lvyUXviy2Ud2srDdPl5py7Ty3LmLUI/V/0YOm/a51ywXVhG1LmV6B
         JesC/cgl4tz2kHv3l46Wwe9v1BTKOak5ZpCG/hnliWuvoiC/PS0JPmOgYw+3oUXnc7
         bT6z4qOAnJpmw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/5] objtool: Add '--verbose' option for disassembling affected functions
Date:   Mon, 27 Mar 2023 09:00:44 -0700
Message-Id: <217a005fe22f9d33f99fed499d6508af9f5cabd0.1679932620.git.jpoimboe@kernel.org>
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

When a warning is associated with a function, add an option to
disassemble that function.

This makes it easier for reporters to submit the information needed to
diagnose objtool warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  5 ++++
 tools/objtool/builtin-check.c           |  1 +
 tools/objtool/include/objtool/builtin.h |  1 +
 tools/objtool/include/objtool/warn.h    | 38 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 8e53fc6735ef..7c1a46af322f 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -244,6 +244,11 @@ To achieve the validation, objtool enforces the following rules:
 Objtool warnings
 ----------------
 
+NOTE: When requesting help with an objtool warning, please re-run the
+kernel build with `OBJTOOL_ARGS="--verbose" make <whatever>` and send
+the full warning output (including any function disassembly below the
+warning) to the objtool maintainers.
+
 For asm files, if you're getting an error which doesn't make sense,
 first make sure that the affected code follows the above rules.
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7c175198d09f..b8de42f6778e 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -93,6 +93,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
+	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
 
 	OPT_END(),
 };
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
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index a3e79ae75f2e..b85aa440ee1f 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,6 +11,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
 
@@ -41,6 +42,41 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	return str;
 }
 
+static inline void objdump_func(struct section *sec, unsigned long offset)
+{
+	struct symbol *sym = find_func_containing(sec, offset);
+	const char *script_relative = "scripts/objdump-func";
+	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
+	char *cmd, *srctree, *script;
+
+	if (is_text)
+		sym = find_func_containing(sec, offset);
+	if (!sym)
+		sym = find_symbol_containing(sec, offset);
+	if (!sym)
+		return;
+
+	srctree = getenv("abs_srctree");
+	if (!srctree)
+		return;
+
+	script = malloc(strlen(srctree) + strlen(script_relative) + 2);
+	if (!script)
+		return;
+
+	sprintf(script, "%s/%s", srctree, script_relative);
+
+	if (access(script, X_OK))
+		return;
+
+	cmd = malloc(strlen(script) + strlen(objname) + strlen(sym->name) + 10);
+	if (!cmd)
+		return;
+
+	sprintf(cmd, "%s %s %s 1>&2", script, objname, sym->name);
+	system(cmd);
+}
+
 #define WARN(format, ...)				\
 	fprintf(stderr,					\
 		"%s: warning: objtool: " format "\n",	\
@@ -51,6 +87,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	char *_str = offstr(sec, offset);		\
 	WARN("%s: " format, _str, ##__VA_ARGS__);	\
 	free(_str);					\
+	if (opts.verbose)				\
+		objdump_func(sec, offset);		\
 })
 
 #define BT_FUNC(format, insn, ...)			\
-- 
2.39.2

