Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E796A87B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCBRSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:18:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C1E61A4;
        Thu,  2 Mar 2023 09:18:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C942F4;
        Thu,  2 Mar 2023 09:18:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41E473F67D;
        Thu,  2 Mar 2023 09:18:01 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, rostedt@goodmis.org, zanussi@kernel.org
Subject: [PATCH 1/2] tracing/hist: simplify contains_operator()
Date:   Thu,  2 Mar 2023 17:17:54 +0000
Message-Id: <20230302171755.1821653-2-mark.rutland@arm.com>
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

In a subsequent patch we'll add additional operators for histogram
expressions.

In preparation for adding additional operators, this patch refactors
contains_operator() to consider each operator within a precedence group
independently by using the 'sep' pointer as the current rightmost
operator, and removing the separate op pointers.

Within each precedence group, this allows operators to be checked
independently with a consistent pattern:

	op = strrchr(str, $OP_CHAR);
	if (op > *sep) {
		*sep = op;
		field_op = $FIELD_OP_TYPE;
	}

This makes it easy to add new operators of the same precedence without
needing to check multiple pointers, and without needing a final switch
statement to recover the relevant pointer.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/trace_events_hist.c | 80 ++++++++++++--------------------
 1 file changed, 30 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 10d36f751fcd..a308da2cde2f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1813,13 +1813,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 static int contains_operator(char *str, char **sep)
 {
 	enum field_op_id field_op = FIELD_OP_NONE;
-	char *minus_op, *plus_op, *div_op, *mult_op;
+	char *op;
 
+	*sep = NULL;
 
 	/*
-	 * Report the last occurrence of the operators first, so that the
-	 * expression is evaluated left to right. This is important since
-	 * subtraction and division are not associative.
+	 * For operators of the same precedence report the last occurrence of
+	 * the operators first, so that the expression is evaluated left to
+	 * right. This is important since subtraction and division are not
+	 * associative.
 	 *
 	 *	e.g
 	 *		64/8/4/2 is 1, i.e 64/8/4/2 = ((64/8)/4)/2
@@ -1830,68 +1832,46 @@ static int contains_operator(char *str, char **sep)
 	 * First, find lower precedence addition and subtraction
 	 * since the expression will be evaluated recursively.
 	 */
-	minus_op = strrchr(str, '-');
-	if (minus_op) {
+	op = strrchr(str, '-');
+	if (op > *sep) {
+		*sep = op;
+
 		/*
 		 * Unary minus is not supported in sub-expressions. If
 		 * present, it is always the next root operator.
 		 */
-		if (minus_op == str) {
-			field_op = FIELD_OP_UNARY_MINUS;
-			goto out;
-		}
+		if (op == str)
+			return FIELD_OP_UNARY_MINUS;
 
 		field_op = FIELD_OP_MINUS;
 	}
 
-	plus_op = strrchr(str, '+');
-	if (plus_op || minus_op) {
-		/*
-		 * For operators of the same precedence use to rightmost as the
-		 * root, so that the expression is evaluated left to right.
-		 */
-		if (plus_op > minus_op)
-			field_op = FIELD_OP_PLUS;
-		goto out;
+	op = strrchr(str, '+');
+	if (op > *sep) {
+		*sep = op;
+		field_op = FIELD_OP_PLUS;
 	}
 
 	/*
-	 * Multiplication and division have higher precedence than addition and
-	 * subtraction.
+	 * If we've found a low-precedence operator, we're done.
 	 */
-	div_op = strrchr(str, '/');
-	if (div_op)
-		field_op = FIELD_OP_DIV;
+	if (*sep)
+		return field_op;
 
-	mult_op = strrchr(str, '*');
 	/*
-	 * For operators of the same precedence use to rightmost as the
-	 * root, so that the expression is evaluated left to right.
+	 * Second, consider the higher precedence multiplication and division
+	 * operators.
 	 */
-	if (mult_op > div_op)
-		field_op = FIELD_OP_MULT;
+	op = strrchr(str, '/');
+	if (op > *sep) {
+		*sep = op;
+		field_op = FIELD_OP_DIV;
+	}
 
-out:
-	if (sep) {
-		switch (field_op) {
-		case FIELD_OP_UNARY_MINUS:
-		case FIELD_OP_MINUS:
-			*sep = minus_op;
-			break;
-		case FIELD_OP_PLUS:
-			*sep = plus_op;
-			break;
-		case FIELD_OP_DIV:
-			*sep = div_op;
-			break;
-		case FIELD_OP_MULT:
-			*sep = mult_op;
-			break;
-		case FIELD_OP_NONE:
-		default:
-			*sep = NULL;
-			break;
-		}
+	op = strrchr(str, '*');
+	if (op > *sep) {
+		*sep = op;
+		field_op = FIELD_OP_MULT;
 	}
 
 	return field_op;
-- 
2.30.2

