Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE766A87B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCBRSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCBRSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:18:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5BD0CA26;
        Thu,  2 Mar 2023 09:18:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD251169E;
        Thu,  2 Mar 2023 09:18:46 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE54D3F67D;
        Thu,  2 Mar 2023 09:18:02 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, rostedt@goodmis.org, zanussi@kernel.org
Subject: [PATCH 2/2] tracing/hist: add modulus operator
Date:   Thu,  2 Mar 2023 17:17:55 +0000
Message-Id: <20230302171755.1821653-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302171755.1821653-1-mark.rutland@arm.com>
References: <20230302171755.1821653-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently historgram field expressions can use addition ('+'),
substraction ('-'), division ('/'), and multiplication ('*') operators.
It would be helpful to also have a modulus ('%') operator.

This is helpful for capturing the alignment of pointers. For example, on
arm64 with CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, we can record the size and
alignment of copies to user with:

| # echo 'p:copy_to_user __arch_copy_to_user to=$arg1 from=$arg2 n=$arg3' >> /sys/kernel/tracing/kprobe_events
| # echo 'hist keys=n,to%8:vals=hitcount:sort=n,to%8' > /sys/kernel/tracing/events/kprobes/copy_to_user/trigger
| # cat /sys/kernel/tracing/events/kprobes/copy_to_user/hist
| # event histogram
| #
| # trigger info: hist:keys=n,to%8:vals=hitcount:sort=n,to%8:size=2048 [active]
| #
|
| { n:          1, to%8:          1 } hitcount:          5
| { n:          8, to%8:          0 } hitcount:          3
| { n:         16, to%8:          0 } hitcount:          2
| { n:         32, to%8:          0 } hitcount:          1
| { n:         36, to%8:          0 } hitcount:          1
| { n:        128, to%8:          0 } hitcount:          4
| { n:        336, to%8:          0 } hitcount:          1
| { n:        832, to%8:          0 } hitcount:          3
|
| Totals:
|     Hits: 20
|     Entries: 8
|     Dropped: 0

Add a modulus operator, with the same precedence as multiplication and
division, matching C's operator precedence.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 Documentation/trace/histogram.rst |  4 ++--
 kernel/trace/trace_events_hist.c  | 35 +++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index f95459aa984f..534fb190ebe0 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1771,8 +1771,8 @@ using the same key and variable from yet another event::
 
   # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
-Expressions support the use of addition, subtraction, multiplication and
-division operators (+-\*/).
+Expressions support the use of addition, subtraction, multiplication,
+division, modulus operators (+-\*/%).
 
 Note if division by zero cannot be detected at parse time (i.e. the
 divisor is not a constant), the result will be -1.
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a308da2cde2f..629896aaed54 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -103,6 +103,7 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 	FIELD_OP_DIV,
 	FIELD_OP_MULT,
+	FIELD_OP_MOD,
 };
 
 enum hist_field_fn {
@@ -131,6 +132,7 @@ enum hist_field_fn {
 	HIST_FIELD_FN_PLUS,
 	HIST_FIELD_FN_DIV,
 	HIST_FIELD_FN_MULT,
+	HIST_FIELD_FN_MOD,
 	HIST_FIELD_FN_DIV_POWER2,
 	HIST_FIELD_FN_DIV_NOT_POWER2,
 	HIST_FIELD_FN_DIV_MULT_SHIFT,
@@ -436,6 +438,21 @@ static u64 hist_field_mult(struct hist_field *hist_field,
 	return val1 * val2;
 }
 
+static u64 hist_field_mod(struct hist_field *hist_field,
+			  struct tracing_map_elt *elt,
+			  struct trace_buffer *buffer,
+			  struct ring_buffer_event *rbe,
+			  void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
+
+	return val1 % val2;
+}
+
 static u64 hist_field_unary_minus(struct hist_field *hist_field,
 				  struct tracing_map_elt *elt,
 				  struct trace_buffer *buffer,
@@ -1796,6 +1813,9 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	case FIELD_OP_MULT:
 		strcat(expr, "*");
 		break;
+	case FIELD_OP_MOD:
+		strcat(expr, "%");
+		break;
 	default:
 		kfree(expr);
 		return NULL;
@@ -1859,8 +1879,8 @@ static int contains_operator(char *str, char **sep)
 		return field_op;
 
 	/*
-	 * Second, consider the higher precedence multiplication and division
-	 * operators.
+	 * Second, consider the higher precedence multiplication, division, and
+	 * modulus operators.
 	 */
 	op = strrchr(str, '/');
 	if (op > *sep) {
@@ -1874,6 +1894,12 @@ static int contains_operator(char *str, char **sep)
 		field_op = FIELD_OP_MULT;
 	}
 
+	op = strrchr(str, '%');
+	if (op > *sep) {
+		*sep = op;
+		field_op = FIELD_OP_MOD;
+	}
+
 	return field_op;
 }
 
@@ -2698,6 +2724,9 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	case FIELD_OP_MULT:
 		op_fn = HIST_FIELD_FN_MULT;
 		break;
+	case FIELD_OP_MOD:
+		op_fn = HIST_FIELD_FN_MOD;
+		break;
 	default:
 		ret = -EINVAL;
 		goto free_operands;
@@ -4289,6 +4318,8 @@ static u64 hist_fn_call(struct hist_field *hist_field,
 		return hist_field_div(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_MULT:
 		return hist_field_mult(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_MOD:
+		return hist_field_mod(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_DIV_POWER2:
 		return div_by_power_of_two(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_DIV_NOT_POWER2:
-- 
2.30.2

