Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008EA608534
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJVGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2CF55C5E;
        Fri, 21 Oct 2022 23:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD0F160AC9;
        Sat, 22 Oct 2022 06:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C201C433C1;
        Sat, 22 Oct 2022 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666420742;
        bh=OneMAjv7dte3IHfFM/IyguO9/rP+v5sWL0jPHhHH07g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRuXRnQlK3hZC46aOdeNphzLqMjV2Og4r4j8AWOyRVEad7WSu45wyfcv7H3lSo4nx
         ig6Z0NDGPUFiZsL3BY5Nw3f5p9PZWAcjXEG2SLLvDSOqELOOrqPgspt6SfOIB1SeX4
         gryPYTaibQVvTUfgBZaic5LoYbKZrT0dK9Piu7pQgCnY7ymeMf0kjQ+ijY1nvaIe9j
         jP7OqqZWHeRIWBAdIxWpQwENyexnQhziYVyCvF+4+5N7NzI/yiQh2+ZCSWZPRj8o+D
         maYRZm8CA+mdPgxUz93GchyeGiiVkXm0dvESXtT8b/vtNItOd7kdtp6kTkVc7wrHtw
         UGInHfopuerqA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Primiano Tucci <primiano@google.com>
Subject: [PATCH 2/2] tracing/probes: Reject symbol/symstr type for uprobe
Date:   Sat, 22 Oct 2022 15:38:59 +0900
Message-Id:  <166642073923.718058.4288627873889528808.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To:  <166642072204.718058.1479401089273534841.stgit@mhiramat.roam.corp.google.com>
References:  <166642072204.718058.1479401089273534841.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since uprobe's argument must contain the user-space data, that
should not be converted to kernel symbols. Reject if user
specifies these types on uprobe events. e.g.

 /sys/kernel/debug/tracing # echo 'p /bin/sh:10 %ax:symbol' >> uprobe_events
 sh: write error: Invalid argument
 /sys/kernel/debug/tracing # echo 'p /bin/sh:10 %ax:symstr' >> uprobe_events
 sh: write error: Invalid argument
 /sys/kernel/debug/tracing # cat error_log
 [ 1783.134883] trace_uprobe: error: Unknown type is specified
   Command: p /bin/sh:10 %ax:symbol
                             ^
 [ 1792.201120] trace_uprobe: error: Unknown type is specified
   Command: p /bin/sh:10 %ax:symstr
                             ^

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c                         |   21 ++++++++++++--------
 kernel/trace/trace_probe.h                         |    3 ++-
 kernel/trace/trace_uprobe.c                        |    3 ++-
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 +++++
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dfec4af857b4..960bb7693a84 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -100,10 +100,15 @@ static const struct fetch_type probe_fetch_types[] = {
 	ASSIGN_FETCH_TYPE_END
 };
 
-static const struct fetch_type *find_fetch_type(const char *type)
+static const struct fetch_type *find_fetch_type(const char *type, unsigned long flags)
 {
 	int i;
 
+	/* Reject the symbol/symstr for uprobes */
+	if (type && (flags & TPARG_FL_USER) &&
+	    (!strcmp(type, "symbol") || !strcmp(type, "symstr")))
+		return NULL;
+
 	if (!type)
 		type = DEFAULT_FETCH_TYPE_STR;
 
@@ -121,13 +126,13 @@ static const struct fetch_type *find_fetch_type(const char *type)
 
 		switch (bs) {
 		case 8:
-			return find_fetch_type("u8");
+			return find_fetch_type("u8", flags);
 		case 16:
-			return find_fetch_type("u16");
+			return find_fetch_type("u16", flags);
 		case 32:
-			return find_fetch_type("u32");
+			return find_fetch_type("u32", flags);
 		case 64:
-			return find_fetch_type("u64");
+			return find_fetch_type("u64", flags);
 		default:
 			goto fail;
 		}
@@ -480,7 +485,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 					    DEREF_OPEN_BRACE);
 			return -EINVAL;
 		} else {
-			const struct fetch_type *t2 = find_fetch_type(NULL);
+			const struct fetch_type *t2 = find_fetch_type(NULL, flags);
 
 			*tmp = '\0';
 			ret = parse_probe_arg(arg, t2, &code, end, flags, offs);
@@ -632,9 +637,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		/* The type of $comm must be "string", and not an array. */
 		if (parg->count || (t && strcmp(t, "string")))
 			goto out;
-		parg->type = find_fetch_type("string");
+		parg->type = find_fetch_type("string", flags);
 	} else
-		parg->type = find_fetch_type(t);
+		parg->type = find_fetch_type(t, flags);
 	if (!parg->type) {
 		trace_probe_log_err(offset + (t ? (t - arg) : 0), BAD_TYPE);
 		goto out;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0838b74f403b..e63ac6453f5c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -358,7 +358,8 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
 #define TPARG_FL_TPOINT BIT(3)
-#define TPARG_FL_MASK	GENMASK(3, 0)
+#define TPARG_FL_USER BIT(4)
+#define TPARG_FL_MASK	GENMASK(4, 0)
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				const char *argv, unsigned int flags);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fb58e86dd117..8d64b6553aed 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -691,7 +691,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		trace_probe_log_set_index(i + 2);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i],
-					is_return ? TPARG_FL_RETURN : 0);
+					(is_return ? TPARG_FL_RETURN : 0) |
+					TPARG_FL_USER);
 		if (ret)
 			goto error;
 	}
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index f5e3f9e4a01f..c817158b99db 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -23,4 +23,9 @@ check_error 'p /bin/sh:10^%hoge'	# BAD_ADDR_SUFFIX
 check_error 'p /bin/sh:10(10)^%return'	# BAD_REFCNT_SUFFIX
 fi
 
+# symstr is not supported by uprobe
+if grep -q ".*symstr.*" README; then
+check_error 'p /bin/sh:10 $stack0:^symstr'	# BAD_TYPE
+fi
+
 exit 0

