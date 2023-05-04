Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583AB6EFEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbjD0BTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbjD0BTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A9044A0;
        Wed, 26 Apr 2023 18:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517DD6207D;
        Thu, 27 Apr 2023 01:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAB1C433D2;
        Thu, 27 Apr 2023 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682558326;
        bh=LDY2f8kdAf4TdWZhbcZXqaoLg+La4nzOvu6ntHVp9I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YV7PYsv+G7pJvQwlXaR49qv25ckTnMuBoU7bbT5dthcXxgMseLTfCArxexhPV/hvO
         pBZkFdc2t5fwzqtjx7tDL0LazxfZasAYv9mR3coUywSQWTZxYRV8nKgxT68p1HyPKl
         tMzRLyRoOHrDH8YgJdw7ijlaGren+kRczuGPEVJZk7Q9ew2JN+IWGuu7zVqGzzSWzM
         iSg0U3jM9ElIDwC9TkLEDcgmXcO22/oJdG/X+t2Tsc3KV0+fMghSJfum4979QKKgo4
         MfoBVB4Yv/jNLm35qHPY1LqcLfoORjptKha+CfsTlExVUOGTaxqyS0xtNe6TdRUs3q
         i98p15Cng3+iQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v7 06/11] tracing/probes: Support function parameters if BTF is available
Date:   Thu, 27 Apr 2023 10:18:42 +0900
Message-ID:  <168255832270.2565678.7407547972891951978.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To:  <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
References:  <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support function or tracepoint parameters by name if BTF support is enabled
and the event is for function entry (this feature can be used with kprobe-
events, fprobe-events and tracepoint probe events.)

Note that the BTF variable syntax does not require a prefix. If it starts
with an alphabetic character or an underscore ('_') without a prefix like
'$' and '%', it is considered as a BTF variable.
If you specify only the BTF variable name, the argument name will also
be the same name instead of 'arg*'.

 # echo 'p vfs_read count pos' >> dynamic_events
 # echo 'f vfs_write count pos' >> dynamic_events
 # echo 't sched_overutilized_tp rd overutilized' >> dynamic_events
 # cat dynamic_events
p:kprobes/p_vfs_read_0 vfs_read count=count pos=pos
f:fprobes/vfs_write__entry vfs_write count=count pos=pos
t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
---
Changes in v7:
 - Add BTF_KIND_ENUM64 support
 - Fix to check the ERR_PTR() type return value of bpf_get_btf_vmlinux().
Changes in v6:
 - update patch description.
 - use bpf_get_btf_vmlinux() instead of btf_parse_vmlinux().
---
 kernel/trace/Kconfig        |   11 ++
 kernel/trace/trace.c        |    4 +
 kernel/trace/trace_fprobe.c |   49 +++++++----
 kernel/trace/trace_kprobe.c |   12 +--
 kernel/trace/trace_probe.c  |  191 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |    9 ++
 6 files changed, 247 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8e10a9453c96..e2b415b9fcd4 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -664,6 +664,17 @@ config FPROBE_EVENTS
 	  and the kprobe events on function entry and exit will be
 	  transparently converted to this fprobe events.
 
+config PROBE_EVENTS_BTF_ARGS
+	depends on HAVE_FUNCTION_ARG_ACCESS_API
+	depends on FPROBE_EVENTS || KPROBE_EVENTS
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	bool "Support BTF function arguments for probe events"
+	default y
+	help
+	  The user can specify the arguments of the probe event using the names
+	  of the arguments of the probed function. This feature only works if
+	  the probe location is a kernel function entry or a tracepoint.
+
 config KPROBE_EVENTS
 	depends on KPROBES
 	depends on HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abcc2ca615e8..7bd2741356ef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5670,7 +5670,11 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<offset>],\n"
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
+	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>, <argname>\n"
+#else
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
+#endif
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 1dba45dfd234..a34081113fa8 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -367,6 +367,7 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
+					       struct tracepoint *tpoint,
 					       int maxactive,
 					       int nargs, bool is_return)
 {
@@ -386,6 +387,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 	else
 		tf->fp.entry_handler = fentry_dispatcher;
 
+	tf->tpoint = tpoint;
 	tf->fp.nr_maxactive = maxactive;
 
 	ret = trace_probe_init(&tf->tp, event, group, false);
@@ -929,8 +931,12 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	int maxactive = 0;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
-	unsigned int flags = TPARG_FL_KERNEL;
+	char sbuf[KSYM_NAME_LEN];
 	bool is_tracepoint = false;
+	struct tracepoint *tpoint = NULL;
+	struct traceprobe_parse_context ctx = {
+		.flags = TPARG_FL_KERNEL | TPARG_FL_FENTRY,
+	};
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
 		return -ECANCELED;
@@ -994,12 +1000,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		goto parse_error;
 	}
 
-	flags |= TPARG_FL_FENTRY;
-	if (is_return)
-		flags |= TPARG_FL_RETURN;
-	if (is_tracepoint)
-		flags |= TPARG_FL_TPOINT;
-
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1011,7 +1011,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (!event) {
 		/* Make a new event name */
 		if (is_tracepoint)
-			strscpy(buf, symbol, MAX_EVENT_NAME_LEN);
+			snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
+				 isdigit(*symbol) ? "_" : "", symbol);
 		else
 			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
 				 is_return ? "exit" : "entry");
@@ -1019,8 +1020,25 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		event = buf;
 	}
 
+	if (is_return)
+		ctx.flags |= TPARG_FL_RETURN;
+
+	if (is_tracepoint) {
+		ctx.flags |= TPARG_FL_TPOINT;
+		tpoint = find_tracepoint(symbol);
+		if (!tpoint) {
+			trace_probe_log_set_index(1);
+			trace_probe_log_err(0, NO_TRACEPOINT);
+			goto parse_error;
+		}
+		ctx.funcname = kallsyms_lookup(
+				(unsigned long)tpoint->probestub,
+				NULL, NULL, NULL, sbuf);
+	} else
+		ctx.funcname = symbol;
+
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, maxactive,
+	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
 				argc - 2, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
@@ -1029,24 +1047,15 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		goto out;	/* We know tf is not allocated */
 	}
 
-	if (is_tracepoint) {
-		tf->tpoint = find_tracepoint(tf->symbol);
-		if (!tf->tpoint) {
-			trace_probe_log_set_index(1);
-			trace_probe_log_err(0, NO_TRACEPOINT);
-			goto parse_error;
-		}
+	if (is_tracepoint)
 		tf->mod = __module_text_address(
 				(unsigned long)tf->tpoint->probestub);
-	}
 
 	argc -= 2; argv += 2;
-
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		struct traceprobe_parse_context ctx = { .flags = flags };
-
 		trace_probe_log_set_index(i + 2);
+		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
 		if (ret)
 			goto error;	/* This can be -ENOMEM */
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fd62de2a2f51..aff6c1a5e161 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -742,7 +742,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
-	unsigned int flags = TPARG_FL_KERNEL;
+	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
 	case 'r':
@@ -823,10 +823,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			goto parse_error;
 		}
 		if (is_return)
-			flags |= TPARG_FL_RETURN;
+			ctx.flags |= TPARG_FL_RETURN;
 		ret = kprobe_on_func_entry(NULL, symbol, offset);
 		if (ret == 0)
-			flags |= TPARG_FL_FENTRY;
+			ctx.flags |= TPARG_FL_FENTRY;
 		/* Defer the ENOENT case until register kprobe */
 		if (ret == -EINVAL && is_return) {
 			trace_probe_log_err(0, BAD_RETPROBE);
@@ -856,7 +856,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
-			       argc - 2, is_return);
+				argc - 2, is_return);
 	if (IS_ERR(tk)) {
 		ret = PTR_ERR(tk);
 		/* This must return -ENOMEM, else there is a bug */
@@ -866,10 +866,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	argc -= 2; argv += 2;
 
 	/* parse arguments */
+	ctx.funcname = symbol;
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		struct traceprobe_parse_context ctx = { .flags = flags };
-
 		trace_probe_log_set_index(i + 2);
+		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
 		if (ret)
 			goto error;	/* This can be -ENOMEM */
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 84a9f0446390..346673e9dfd4 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -11,6 +11,8 @@
  */
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
+#include <linux/bpf.h>
+
 #include "trace_probe.h"
 
 #undef C
@@ -300,6 +302,171 @@ static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
 	return -ENOENT;
 }
 
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
+
+static struct btf *traceprobe_get_btf(void)
+{
+	struct btf *btf = bpf_get_btf_vmlinux();
+
+	if (IS_ERR_OR_NULL(btf))
+		return NULL;
+
+	return btf;
+}
+
+static u32 btf_type_int(const struct btf_type *t)
+{
+	return *(u32 *)(t + 1);
+}
+
+static const char *type_from_btf_id(struct btf *btf, s32 id)
+{
+	const struct btf_type *t;
+	u32 intdata;
+	s32 tid;
+
+	/* TODO: const char * could be converted as a string */
+	t = btf_type_skip_modifiers(btf, id, &tid);
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_ENUM:
+		/* enum is "int", so convert to "s32" */
+		return "s32";
+	case BTF_KIND_ENUM64:
+		return "s64";
+	case BTF_KIND_PTR:
+		/* pointer will be converted to "x??" */
+		if (IS_ENABLED(CONFIG_64BIT))
+			return "x64";
+		else
+			return "x32";
+	case BTF_KIND_INT:
+		intdata = btf_type_int(t);
+		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
+			switch (BTF_INT_BITS(intdata)) {
+			case 8:
+				return "s8";
+			case 16:
+				return "s16";
+			case 32:
+				return "s32";
+			case 64:
+				return "s64";
+			}
+		} else {	/* unsigned */
+			switch (BTF_INT_BITS(intdata)) {
+			case 8:
+				return "u8";
+			case 16:
+				return "u16";
+			case 32:
+				return "u32";
+			case 64:
+				return "u64";
+			}
+		}
+	}
+	/* TODO: support other types */
+
+	return NULL;
+}
+
+static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
+{
+	struct btf *btf = traceprobe_get_btf();
+	const struct btf_type *t;
+	s32 id;
+
+	if (!btf || !funcname || !nr)
+		return ERR_PTR(-EINVAL);
+
+	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
+	if (id <= 0)
+		return ERR_PTR(-ENOENT);
+
+	/* Get BTF_KIND_FUNC type */
+	t = btf_type_by_id(btf, id);
+	if (!btf_type_is_func(t))
+		return ERR_PTR(-ENOENT);
+
+	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
+	t = btf_type_by_id(btf, t->type);
+	if (!btf_type_is_func_proto(t))
+		return ERR_PTR(-ENOENT);
+
+	*nr = btf_type_vlen(t);
+
+	if (*nr)
+		return (const struct btf_param *)(t + 1);
+	else
+		return NULL;
+}
+
+static int parse_btf_arg(const char *varname, struct fetch_insn *code,
+			 struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+	const struct btf_param *params;
+	int i;
+
+	if (!btf) {
+		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+		return -EOPNOTSUPP;
+	}
+
+	if (WARN_ON_ONCE(!ctx->funcname))
+		return -EINVAL;
+
+	if (!ctx->params) {
+		params = find_btf_func_param(ctx->funcname, &ctx->nr_params);
+		if (IS_ERR(params)) {
+			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
+			return PTR_ERR(params);
+		}
+		ctx->params = params;
+	} else
+		params = ctx->params;
+
+	for (i = 0; i < ctx->nr_params; i++) {
+		const char *name = btf_name_by_offset(btf, params[i].name_off);
+
+		if (name && !strcmp(name, varname)) {
+			code->op = FETCH_OP_ARG;
+			code->param = i;
+			return 0;
+		}
+	}
+	trace_probe_log_err(ctx->offset, NO_BTFARG);
+	return -ENOENT;
+}
+
+static const struct fetch_type *parse_btf_arg_type(int arg_idx,
+					struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+	const char *typestr = NULL;
+
+	if (btf && ctx->params)
+		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
+
+	return find_fetch_type(typestr, ctx->flags);
+}
+#else
+static struct btf *traceprobe_get_btf(void)
+{
+	return NULL;
+}
+
+static int parse_btf_arg(const char *varname, struct fetch_insn *code,
+			 struct traceprobe_parse_context *ctx)
+{
+	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+	return -EOPNOTSUPP;
+}
+#define parse_btf_arg_type(idx, ctx)		\
+	find_fetch_type(NULL, ctx->flags)
+#endif
+
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
@@ -556,6 +723,15 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				code->op = FETCH_OP_IMM;
 		}
 		break;
+	default:
+		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
+			if (!tparg_is_function_entry(ctx->flags)) {
+				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+				return -EINVAL;
+			}
+			ret = parse_btf_arg(arg, code, ctx);
+			break;
+		}
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {
 		/* Parsed, but do not find fetch method */
@@ -704,6 +880,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	if (ret)
 		goto fail;
 
+	/* Update storing type if BTF is available */
+	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
+	    !t && code->op == FETCH_OP_ARG)
+		parg->type = parse_btf_arg_type(code->param, ctx);
+
 	ret = -EINVAL;
 	/* Store operation */
 	if (parg->type->is_string) {
@@ -857,8 +1038,14 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
 		body++;
 	} else {
-		/* If argument name is omitted, set "argN" */
-		parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
+		/*
+		 * If argument name is omitted, try arg as a name (BTF variable)
+		 * or "argN".
+		 */
+		if (is_good_name(arg))
+			parg->name = kstrdup(arg, GFP_KERNEL);
+		else
+			parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
 		body = arg;
 	}
 	if (!parg->name)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 2dc1e5c4c9e8..9ea5c7e8753f 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -23,6 +23,7 @@
 #include <linux/limits.h>
 #include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/btf.h>
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
@@ -376,6 +377,9 @@ static inline bool tparg_is_function_entry(unsigned int flags)
 
 struct traceprobe_parse_context {
 	struct trace_event_call *event;
+	const struct btf_param *params;
+	s32 nr_params;
+	const char *funcname;
 	unsigned int flags;
 	int offset;
 };
@@ -474,7 +478,10 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
 	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
 	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
-	C(NO_EP_FILTER,		"No filter rule after 'if'"),
+	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
+	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
+	C(NO_BTFARG,		"This variable is not found at this probe point"),\
+	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

