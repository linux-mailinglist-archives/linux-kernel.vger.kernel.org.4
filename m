Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E340733FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbjFQJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbjFQJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC4D213F;
        Sat, 17 Jun 2023 02:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 573FA60FD3;
        Sat, 17 Jun 2023 09:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64846C433C0;
        Sat, 17 Jun 2023 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686995248;
        bh=vJO4M0HM7FCevR0pjwlrbpVfGQ59SezS/bPy03sX8pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyGEQgw4Q2w72iPZXh5b1bxNwyXW4JXDynPgp5zWd1ABzGpYi9g3u045HfMzERpy3
         2h2xEsvd0jbDYSVJagz/twLhNVin8adIAlIxLubOBAJf01Tz/cQTi0RTbCImjTkRQC
         GAQ0k69BDhz86FrmQhgCmPPjwZJ2Md/cTf/Hv57JgBu25br7YhCflm1tjsBJaBdFPr
         sB7lT8yMIqBXt4/ELvJIMoup5ntDsyLcvnZbvhw+WI2qUbFX6rKEf+O64uHWBOLS3M
         F/7mhU3ZOqCvVr7MAD090JsCaEEcKLE2LPZhKGfbyT1LwxyEOnjXrlceH04rGBIIO1
         Qm1vZe1NMEKFQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org
Subject: [PATCH 3/5] tracing/probes: Add string type check with BTF
Date:   Sat, 17 Jun 2023 18:47:25 +0900
Message-ID:  <168699524550.528797.10869028703938811455.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
References:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a string type checking with BTF information if possible.
This will check whether the given BTF argument (and field) is
signed char array or pointer to signed char. If not, it reject
the 'string' type. If it is pointer to signed char, it adds
a dereference opration so that it can correctly fetch the
string data from memory.

 # echo 'f getname_flags%return retval->name:string' >> dynamic_events
 # echo 't sched_switch next->comm:string' >> dynamic_events

The above cases, 'struct filename::name' is 'char *' and
'struct task_struct::comm' is 'char []'. But in both case,
user can specify ':string' to fetch the string data.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   89 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h |    3 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 0149d0abb5fd..85c9c939424c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -319,6 +319,77 @@ static u32 btf_type_int(const struct btf_type *t)
 	return *(u32 *)(t + 1);
 }
 
+static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
+{
+	const struct btf_type *real_type;
+	u32 intdata;
+	s32 tid;
+
+	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
+
+	intdata = btf_type_int(real_type);
+	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
+		&& BTF_INT_BITS(intdata) == 8;
+}
+
+static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
+{
+	const struct btf_type *real_type;
+	const struct btf_array *array;
+	u32 intdata;
+	s32 tid;
+
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
+		return false;
+
+	array = (const struct btf_array *)(type + 1);
+
+	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+
+	intdata = btf_type_int(real_type);
+	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
+		&& BTF_INT_BITS(intdata) == 8;
+}
+
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = traceprobe_get_btf();
+
+	if (!btf || !ctx->last_type)
+		return 0;
+
+	/* char [] does not need any change. */
+	if (btf_type_is_char_array(btf, ctx->last_type))
+		return 0;
+
+	/* char * requires dereference the pointer. */
+	if (btf_type_is_char_ptr(btf, ctx->last_type)) {
+		struct fetch_insn *code = *pcode + 1;
+
+		if (code->op == FETCH_OP_END) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+			return -E2BIG;
+		}
+		if (typename[0] == 'u')
+			code->op = FETCH_OP_UDEREF;
+		else
+			code->op = FETCH_OP_DEREF;
+		code->offset = 0;
+		*pcode = code;
+		return 0;
+	}
+	/* Other types are not available for string */
+	trace_probe_log_err(ctx->offset, BAD_TYPE4STR);
+	return -EINVAL;
+}
+
 static const char *fetch_type_from_btf_type(struct btf *btf,
 					const struct btf_type *type,
 					struct traceprobe_parse_context *ctx)
@@ -720,6 +791,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 
 #define is_btf_retval_void(funcname)	(false)
 
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	return 0;
+}
+
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
@@ -1159,8 +1237,15 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	/* Update storing type if BTF is available */
 	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
-	    !t && ctx->last_type)
-		parg->type = find_fetch_type_from_btf_type(ctx);
+	    ctx->last_type) {
+		if (!t) {
+			parg->type = find_fetch_type_from_btf_type(ctx);
+		} else if (strstr(t, "string")) {
+			ret = check_prepare_btf_string_fetch(t, &code, ctx);
+			if (ret)
+				goto fail;
+		}
+	}
 
 	ret = -EINVAL;
 	/* Store operation */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 7aae50633819..c6da67afa62c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -511,7 +511,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
-	C(BAD_BTF_TID,		"Failed to get BTF type info."),
+	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
+	C(BAD_TYPE4STR,		"This type does not fit for string."),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

