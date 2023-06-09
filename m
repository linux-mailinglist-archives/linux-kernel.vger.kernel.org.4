Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E06729DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjFIPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbjFIPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608DC2D6B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686323057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWVIdw42kvaUEVB9fypVLDqQXfw7FfQjjY+1yjJwfjg=;
        b=VaCpMck9wnDWLIjD5vkqBOGr62oD8vhCqLbqs8hDxD7UN2M4lix2aYRM8M+vWLaSDQREMG
        HhFAyZIdQq/nKy+geAoBg66LaG594N5ZQ+MKZEVNmHMxJDFbXoGWjXp8o4Bs/94uHVI9gC
        hojH9BrtT/xj0t1hYTxMdfb6D/0wPoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-VQM2C7eiOsWVLUt4-WUDNw-1; Fri, 09 Jun 2023 11:04:14 -0400
X-MC-Unique: VQM2C7eiOsWVLUt4-WUDNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE9A8185A78B;
        Fri,  9 Jun 2023 15:04:13 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D3D4087C62;
        Fri,  9 Jun 2023 15:04:11 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RFC PATCH 2/5] tracing/filters: Enable filtering a cpumask field by another cpumask
Date:   Fri,  9 Jun 2023 16:03:21 +0100
Message-Id: <20230609150324.143538-3-vschneid@redhat.com>
In-Reply-To: <20230609150324.143538-1-vschneid@redhat.com>
References: <20230609150324.143538-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced ipi_send_cpumask trace event contains a cpumask
field, but it currently cannot be used in filter expressions.

Make event filtering aware of cpumask fields, and allow these to be
filtered by a user-provided cpumask.

The user-provided cpumask is to be given in cpulist format and wrapped as:
"MASK{$cpulist}". The use of curly braces instead of parentheses is to
prevent predicate_parse() from parsing the contents of MASK{...} as a
full-fledged predicate subexpression.

This enables e.g.:

$ trace-cmd record -e 'ipi_send_cpumask' -f 'cpu & MASK{2,4,6,8-32}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace_events_filter.c | 85 +++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c4a0b72334eb..974ef37a06c83 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -804,6 +804,7 @@ enum {
 	FILTER_RDYN_STRING,
 	FILTER_PTR_STRING,
 	FILTER_TRACE_FN,
+	FILTER_CPUMASK,
 	FILTER_COMM,
 	FILTER_CPU,
 	FILTER_STACKTRACE,
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d999a218fe833..8af00caa363f7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -64,6 +64,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_PCHAR_USER,
 	FILTER_PRED_FN_PCHAR,
 	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
@@ -71,6 +72,7 @@ enum filter_pred_fn {
 
 struct filter_pred {
 	struct regex		*regex;
+	struct cpumask          *mask;
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
 	u64			val;
@@ -94,6 +96,8 @@ struct filter_pred {
 	C(TOO_MANY_OPEN,	"Too many '('"),			\
 	C(TOO_MANY_CLOSE,	"Too few '('"),				\
 	C(MISSING_QUOTE,	"Missing matching quote"),		\
+	C(MISSING_BRACE_OPEN,   "Missing '{'"),				\
+	C(MISSING_BRACE_CLOSE,  "Missing '}'"),				\
 	C(OPERAND_TOO_LONG,	"Operand too long"),			\
 	C(EXPECT_STRING,	"Expecting string field"),		\
 	C(EXPECT_DIGIT,		"Expecting numeric field"),		\
@@ -103,6 +107,7 @@ struct filter_pred {
 	C(BAD_SUBSYS_FILTER,	"Couldn't find or set field in one of a subsystem's events"), \
 	C(TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
+	C(INVALID_CPULIST,	"Invalid cpulist"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
 	C(NO_FUNCTION,		"Function not found"),			\
@@ -189,6 +194,7 @@ enum {
 static void free_predicate(struct filter_pred *pred)
 {
 	kfree(pred->regex);
+	kfree(pred->mask);
 	kfree(pred);
 }
 
@@ -875,6 +881,26 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+/* Filter predicate for cpumasks. */
+static int filter_pred_cpumask(struct filter_pred *pred, void *event)
+{
+	u32 item = *(u32 *)(event + pred->offset);
+	int loc = item & 0xffff;
+	const struct cpumask *mask = (event + loc);
+	const struct cpumask *cmp = pred->mask;
+
+	switch (pred->op) {
+	case OP_EQ:
+		return cpumask_equal(mask, cmp);
+	case OP_NE:
+		return !cpumask_equal(mask, cmp);
+	case OP_BAND:
+		return cpumask_intersects(mask, cmp);
+	default:
+		return 0;
+	}
+}
+
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
@@ -1242,8 +1268,12 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 
 int filter_assign_type(const char *type)
 {
-	if (strstr(type, "__data_loc") && strstr(type, "char"))
-		return FILTER_DYN_STRING;
+	if (strstr(type, "__data_loc")) {
+		if (strstr(type, "char"))
+			return FILTER_DYN_STRING;
+		if (strstr(type, "cpumask_t"))
+			return FILTER_CPUMASK;
+		}
 
 	if (strstr(type, "__rel_loc") && strstr(type, "char"))
 		return FILTER_RDYN_STRING;
@@ -1355,6 +1385,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPUMASK:
+		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
@@ -1566,6 +1598,55 @@ static int parse_pred(const char *str, void *data,
 		strncpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
+	} else if (!strncmp(str + i, "MASK", 4)) {
+		unsigned int maskstart;
+		char *tmp;
+
+		if (field->filter_type != FILTER_CPUMASK) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		/* Skip MASK */
+		i += 4;
+		if (str[i++] != '{') {
+			parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos + i);
+			goto err_free;
+		}
+		maskstart = i;
+
+		/* Walk the cpulist until closing } */
+		for (; str[i] && str[i] != '}'; i++);
+		if (str[i] != '}') {
+			parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos + i);
+			goto err_free;
+		}
+
+		if (maskstart == i) {
+			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
+			goto err_free;
+		}
+
+		/* Copy the cpulist between { and } */
+		tmp = kmalloc(i - maskstart + 1, GFP_KERNEL);
+		strncpy(tmp, str + maskstart, i - maskstart);
+		tmp[i - maskstart] = '\0';
+
+		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
+		if (!pred->mask)
+			goto err_mem;
+
+		/* Now parse it */
+		if (cpulist_parse(tmp, pred->mask)) {
+			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
+			goto err_free;
+		}
+
+		/* Move along */
+		i++;
+		if (field->filter_type == FILTER_CPUMASK)
+			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
 		char q = str[i];
-- 
2.31.1

