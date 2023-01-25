Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED267B826
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjAYRNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjAYRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E6346B8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D2061590
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95487C433D2;
        Wed, 25 Jan 2023 17:13:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKjL8-004Nph-24;
        Wed, 25 Jan 2023 12:13:38 -0500
Message-ID: <20230125171338.453170548@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 12:12:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Ross Zwisler <zwisler@google.com>
Subject: [for-next][PATCH 01/12] tracing: Add a way to filter function addresses to function names
References: <20230125171252.431857411@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's been several times where an event records a function address in
its field and I needed to filter on that address for a specific function
name. It required looking up the function in kallsyms, finding its size,
and doing a compare of "field >= function_start && field < function_end".

But this would change from boot to boot and is unreliable in scripts.
Also, it is useful to have this at boot up, where the addresses will not
be known. For example, on the boot command line:

  trace_trigger="initcall_finish.traceoff if func.function == acpi_init"

To implement this, add a ".function" prefix, that will check that the
field is of size long, and the only operations allowed (so far) are "=="
and "!=".

Link: https://lkml.kernel.org/r/20221219183213.916833763@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/events.rst     | 12 ++++
 kernel/trace/trace_events.c        |  2 +-
 kernel/trace/trace_events_filter.c | 93 +++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..d0fd5c7220b7 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -207,6 +207,18 @@ field name::
 As the kernel will have to know how to retrieve the memory that the pointer
 is at from user space.
 
+You can convert any long type to a function address and search by function name::
+
+  call_site.function == security_prepare_creds
+
+The above will filter when the field "call_site" falls on the address within
+"security_prepare_creds". That is, it will compare the value of "call_site" and
+the filter will return true if it is greater than or equal to the start of
+the function "security_prepare_creds" and less than the end of that function.
+
+The ".function" postfix can only be attached to values of size long, and can only
+be compared with "==" or "!=".
+
 5.2 Setting filters
 -------------------
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 33e0b4f8ebe6..b07931ad97de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2822,7 +2822,7 @@ static __init int setup_trace_triggers(char *str)
 		if (!trigger)
 			break;
 		bootup_triggers[i].event = strsep(&trigger, ".");
-		bootup_triggers[i].trigger = strsep(&trigger, ".");
+		bootup_triggers[i].trigger = trigger;
 		if (!bootup_triggers[i].trigger)
 			break;
 	}
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e095c3b3a50d..1dad64267878 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -64,6 +64,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_PCHAR_USER,
 	FILTER_PRED_FN_PCHAR,
 	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
 };
@@ -71,6 +72,7 @@ enum filter_pred_fn {
 struct filter_pred {
 	enum filter_pred_fn 	fn_num;
 	u64 			val;
+	u64 			val2;
 	struct regex		regex;
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
@@ -103,6 +105,7 @@ struct filter_pred {
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
+	C(NO_FUNCTION,		"Function not found"),			\
 	C(ERRNO,		"Error"),				\
 	C(NO_FILTER,		"No filter found")
 
@@ -876,6 +879,17 @@ static int filter_pred_comm(struct filter_pred *pred, void *event)
 	return cmp ^ pred->not;
 }
 
+/* Filter predicate for functions. */
+static int filter_pred_function(struct filter_pred *pred, void *event)
+{
+	unsigned long *addr = (unsigned long *)(event + pred->offset);
+	unsigned long start = (unsigned long)pred->val;
+	unsigned long end = (unsigned long)pred->val2;
+	int ret = *addr >= start && *addr < end;
+
+	return pred->op == OP_EQ ? ret : !ret;
+}
+
 /*
  * regex_match_foo - Basic regex callbacks
  *
@@ -1335,6 +1349,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_FUNCTION:
+		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
 		return test_pred_visited_fn(pred, event);
 	default:
@@ -1350,8 +1366,13 @@ static int parse_pred(const char *str, void *data,
 	struct trace_event_call *call = data;
 	struct ftrace_event_field *field;
 	struct filter_pred *pred = NULL;
+	unsigned long offset;
+	unsigned long size;
+	unsigned long ip;
 	char num_buf[24];	/* Big enough to hold an address */
 	char *field_name;
+	char *name;
+	bool function = false;
 	bool ustring = false;
 	char q;
 	u64 val;
@@ -1393,6 +1414,12 @@ static int parse_pred(const char *str, void *data,
 		i += len;
 	}
 
+	/* See if the field is a kernel function name */
+	if ((len = str_has_prefix(str + i, ".function"))) {
+		function = true;
+		i += len;
+	}
+
 	while (isspace(str[i]))
 		i++;
 
@@ -1423,7 +1450,71 @@ static int parse_pred(const char *str, void *data,
 	pred->offset = field->offset;
 	pred->op = op;
 
-	if (ftrace_event_is_function(call)) {
+	if (function) {
+		/* The field must be the same size as long */
+		if (field->size != sizeof(long)) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
+		/* Function only works with '==' or '!=' and an unquoted string */
+		switch (op) {
+		case OP_NE:
+		case OP_EQ:
+			break;
+		default:
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			goto err_free;
+		}
+
+		if (isdigit(str[i])) {
+			/* We allow 0xDEADBEEF */
+			while (isalnum(str[i]))
+				i++;
+
+			len = i - s;
+			/* 0xfeedfacedeadbeef is 18 chars max */
+			if (len >= sizeof(num_buf)) {
+				parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
+				goto err_free;
+			}
+
+			strncpy(num_buf, str + s, len);
+			num_buf[len] = 0;
+
+			ret = kstrtoul(num_buf, 0, &ip);
+			if (ret) {
+				parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
+				goto err_free;
+			}
+		} else {
+			s = i;
+			for (; str[i] && !isspace(str[i]); i++)
+				;
+
+			len = i - s;
+			name = kmemdup_nul(str + s, len, GFP_KERNEL);
+			if (!name)
+				goto err_mem;
+			ip = kallsyms_lookup_name(name);
+			kfree(name);
+			if (!ip) {
+				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
+				goto err_free;
+			}
+		}
+
+		/* Now find the function start and end address */
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset)) {
+			parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
+			goto err_free;
+		}
+
+		pred->fn_num = FILTER_PRED_FN_FUNCTION;
+		pred->val = ip - offset;
+		pred->val2 = pred->val + size;
+
+	} else if (ftrace_event_is_function(call)) {
 		/*
 		 * Perf does things different with function events.
 		 * It only allows an "ip" field, and expects a string.
-- 
2.39.0
