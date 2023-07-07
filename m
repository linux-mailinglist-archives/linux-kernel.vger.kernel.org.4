Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3374B5AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGGRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjGGRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BA213B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MztT6zopkdxP15yr7fLnq4htUTcbRI9GOo9ppcHk5OI=;
        b=AWBhngT1A0o9jk6BbJrPL8meKmLn5CQnZqRUl0iWE14eSvkaGH7ZBZmb0cliBCkg5c1SH0
        WzbS5wQnia5bzRppwhpALMmutJb7O+hXxmbpRtrwzfiZOnrQsFHO6jxpw3X0X9Iq7CMAPB
        /qJ294t4LL9W88qFeibBouFMHgjCSIo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-mYEs5dQ8PBGTkyd4WdhfUQ-1; Fri, 07 Jul 2023 13:22:17 -0400
X-MC-Unique: mYEs5dQ8PBGTkyd4WdhfUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3ABD3811801;
        Fri,  7 Jul 2023 17:22:16 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 754921454142;
        Fri,  7 Jul 2023 17:22:15 +0000 (UTC)
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
Subject: [PATCH v2 2/9] tracing/filters: Enable filtering a cpumask field by another cpumask
Date:   Fri,  7 Jul 2023 18:21:48 +0100
Message-Id: <20230707172155.70873-3-vschneid@redhat.com>
In-Reply-To: <20230707172155.70873-1-vschneid@redhat.com>
References: <20230707172155.70873-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
"CPUS{$cpulist}". The use of curly braces instead of parentheses is to
prevent predicate_parse() from parsing the contents of CPUS{...} as a
full-fledged predicate subexpression.

This enables e.g.:

$ trace-cmd record -e 'ipi_send_cpumask' -f 'cpumask & CPUS{2,4,6,8-32}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace_events_filter.c | 97 +++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)

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
index 91fc9990107f1..cb1863dfa280b 100644
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
@@ -190,6 +195,7 @@ static void free_predicate(struct filter_pred *pred)
 {
 	if (pred) {
 		kfree(pred->regex);
+		kfree(pred->mask);
 		kfree(pred);
 	}
 }
@@ -877,6 +883,26 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+/* Filter predicate for cpumask field vs user-provided cpumask */
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
@@ -1244,8 +1270,12 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 
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
@@ -1357,6 +1387,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPUMASK:
+		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
@@ -1568,6 +1600,67 @@ static int parse_pred(const char *str, void *data,
 		strncpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
+	} else if (!strncmp(str + i, "CPUS", 4)) {
+		unsigned int maskstart;
+		char *tmp;
+
+		switch (field->filter_type) {
+		case FILTER_CPUMASK:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		switch (op) {
+		case OP_EQ:
+		case OP_NE:
+		case OP_BAND:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		/* Skip CPUS */
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
+		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
+		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
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

