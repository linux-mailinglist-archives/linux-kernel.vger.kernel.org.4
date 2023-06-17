Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAEC733FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbjFQJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbjFQJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157C172A;
        Sat, 17 Jun 2023 02:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D3360A2C;
        Sat, 17 Jun 2023 09:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3CCC433C0;
        Sat, 17 Jun 2023 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686995240;
        bh=xuogGb7rV3OR5mTY5x/kVEP90kY4oCcvhU0IrpGAk1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLzGxA4qB2mn3c+bhmXxbeRenqE+jTL1VIi1LV0Az/YyY9J0dnc7dx5922Dphv1qO
         9K+EKQ67dHSgzOzs3i8QDYOlXZuqQHVPi5mZuL7GNS+BLLyhmgcHVIiUHqnSSr45a2
         5MNk8EAAUZ62y7UfLkNCFZptRKcIkMAcKoENV4oLBSMex0beUD7VpT2MH7hJ+CQR8m
         ZRc6ftcr9rX/mJpcuGyVBGjVuTB/PaaN9ATz6xplopx9BQXMS4XmOAFc+WyxGUdiQ0
         /weAGIEiOxBX+V057hxt7T0CDuL65DVRqMLKSYNgTEN9zV5zKkGXalCeoZQMxdt3ts
         8baAL2IbB5C2A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org
Subject: [PATCH 2/5] tracing/probes: Support BTF field access from retval
Date:   Sat, 17 Jun 2023 18:47:16 +0900
Message-ID:  <168699523643.528797.2114547152033345802.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
References:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Introduce 'retval' (Not '$retval') BTF argument for function return events
including kretprobe and fprobe for accessing the return value. This also
allows user to access its fields if the return value is a pointer of a
data structure.

E.g.
 # echo 'f getname_flags%return +0(retval->name):string' \
   > dynamic_events
 # echo 1 > events/fprobes/getname_flags__exit/enable
 # ls > /dev/null
 # head -n 40 trace | tail
              ls-87      [000] ...1.  8067.616101: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./function_profile_enabled"
              ls-87      [000] ...1.  8067.616108: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./trace_stat"
              ls-87      [000] ...1.  8067.616115: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_notrace"
              ls-87      [000] ...1.  8067.616122: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_function"
              ls-87      [000] ...1.  8067.616129: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace"
              ls-87      [000] ...1.  8067.616135: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_filter"
              ls-87      [000] ...1.  8067.616143: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./touched_functions"
              ls-87      [000] ...1.  8067.616237: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./enabled_functions"
              ls-87      [000] ...1.  8067.616245: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./available_filter_functions"
              ls-87      [000] ...1.  8067.616253: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace_pid"


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   54 +++++++++++++++++---------------------------
 kernel/trace/trace_probe.h |    7 ++++++
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1f05c819633f..0149d0abb5fd 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -585,6 +585,21 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (ctx->flags & TPARG_FL_RETURN) {
+		if (strcmp(varname, "retval") != 0) {
+			trace_probe_log_err(ctx->offset, NO_BTFARG);
+			return -ENOENT;
+		}
+		type = find_btf_func_proto(ctx->funcname);
+		if (type->type == 0) {
+			trace_probe_log_err(ctx->offset, NO_RETVAL);
+			return -ENOENT;
+		}
+		code->op = FETCH_OP_RETVAL;
+		tid = type->type;
+		goto found;
+	}
+
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
@@ -605,7 +620,6 @@ static int parse_btf_arg(char *varname,
 				code->param = i + 1;
 			else
 				code->param = i;
-
 			tid = params[i].type;
 			goto found;
 		}
@@ -630,7 +644,7 @@ static int parse_btf_arg(char *varname,
 	return 0;
 }
 
-static const struct fetch_type *parse_btf_arg_type(
+static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
 	struct btf *btf = traceprobe_get_btf();
@@ -642,26 +656,6 @@ static const struct fetch_type *parse_btf_arg_type(
 	return find_fetch_type(typestr, ctx->flags);
 }
 
-static const struct fetch_type *parse_btf_retval_type(
-					struct traceprobe_parse_context *ctx)
-{
-	struct btf *btf = traceprobe_get_btf();
-	const char *typestr = NULL;
-	const struct btf_type *type;
-	s32 tid;
-
-	if (btf && ctx->funcname) {
-		type = find_btf_func_proto(ctx->funcname);
-		if (!IS_ERR(type)) {
-			type = btf_type_skip_modifiers(btf, type->type, &tid);
-			if (type)
-				typestr = fetch_type_from_btf_type(btf, type, ctx);
-		}
-	}
-
-	return find_fetch_type(typestr, ctx->flags);
-}
-
 static int parse_btf_bitfield(struct fetch_insn **pcode,
 			      struct traceprobe_parse_context *ctx)
 {
@@ -721,10 +715,7 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return -EOPNOTSUPP;
 }
 
-#define parse_btf_arg_type(ctx)		\
-	find_fetch_type(NULL, ctx->flags)
-
-#define parse_btf_retval_type(ctx)		\
+#define find_fetch_type_from_btf_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
 #define is_btf_retval_void(funcname)	(false)
@@ -1010,7 +1001,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
-			if (!tparg_is_function_entry(ctx->flags)) {
+			if (!tparg_is_btf_available(ctx->flags)) {
 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
 				return -EINVAL;
 			}
@@ -1167,12 +1158,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		goto fail;
 
 	/* Update storing type if BTF is available */
-	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
-		if (ctx->last_type)
-			parg->type = parse_btf_arg_type(ctx);
-		else if (ctx->flags & TPARG_FL_RETURN)
-			parg->type = parse_btf_retval_type(ctx);
-	}
+	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
+	    !t && ctx->last_type)
+		parg->type = find_fetch_type_from_btf_type(ctx);
 
 	ret = -EINVAL;
 	/* Store operation */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 050909aaaa1b..7aae50633819 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -381,6 +381,13 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 	return (flags & TPARG_FL_LOC_MASK) == (TPARG_FL_KERNEL | TPARG_FL_FENTRY);
 }
 
+/* BTF is available at the kernel function entry and exit */
+static inline bool tparg_is_btf_available(unsigned int flags)
+{
+	return (flags & TPARG_FL_KERNEL) &&
+		(flags & (TPARG_FL_FENTRY | TPARG_FL_RETURN));
+}
+
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
 	const struct btf_param *params;

