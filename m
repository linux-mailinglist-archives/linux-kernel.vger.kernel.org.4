Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D400D7137D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1F1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 01:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE1F0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:26:47 -0400
Received: from mammoth.local.home (cpe-172-100-189-27.stny.res.rr.com [172.100.189.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A33DE;
        Sat, 27 May 2023 22:26:40 -0700 (PDT)
Received: by mammoth.local.home (Postfix, from userid 5657)
        id CF898300CD5; Sun, 28 May 2023 01:17:53 -0400 (EDT)
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 4/5] tracing: Only make selftest conditionals affect the global_trace
Date:   Sun, 28 May 2023 01:17:41 -0400
Message-Id: <20230528051742.1325503-5-rostedt@goodmis.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230528051742.1325503-1-rostedt@goodmis.org>
References: <20230528051742.1325503-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_PBL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The tracing_selftest_running and tracing_selftest_disabled variables were
to keep trace_printk() and other writes from affecting the tracing
selftests, as the tracing selftests would examine the ring buffer to see
if it contained what it expected or not. trace_printk() and friends could
add to the ring buffer and cause the selftests to fail (and then disable
the tracer that was being tested). To keep that from happening, these
variables were added and would keep trace_printk() and friends from
writing to the ring buffer while the tests were going on.

But this was only the top level ring buffer (owned by the global_trace
instance). There is no reason to prevent writing into ring buffers of
other instances via the trace_array_printk() and friends. For the
functions that could be used by other instances, check if the global_trace
is the tracer instance that is being written to before deciding to not
allow the write.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 004f5f99e943..64a4dde073ef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1054,7 +1054,10 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
-	if (unlikely(tracing_selftest_running || tracing_disabled))
+	if (unlikely(tracing_selftest_running && tr == &global_trace))
+		return 0;
+
+	if (unlikely(tracing_disabled))
 		return 0;
 
 	alloc = sizeof(*entry) + size + 2; /* possible \n added */
@@ -3512,7 +3515,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	unsigned int trace_ctx;
 	char *tbuffer;
 
-	if (tracing_disabled || tracing_selftest_running)
+	if (tracing_disabled)
 		return 0;
 
 	/* Don't pollute graph traces with trace_vprintk internals */
@@ -3560,6 +3563,9 @@ __printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
+	if (tracing_selftest_running && tr == &global_trace)
+		return 0;
+
 	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
 }
 
-- 
2.39.2

