Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800F5EC8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiI0QCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiI0QBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A42779A41
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56B84CE189A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F5BC433C1;
        Tue, 27 Sep 2022 16:01:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2h-00G2pv-26;
        Tue, 27 Sep 2022 12:02:43 -0400
Message-ID: <20220927160243.204183194@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 05/20] tracing: Add numeric delta time to the trace event benchmark
References: <20220927160216.349640304@goodmis.org>
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

In order to testing filtering and histograms via the trace event
benchmark, record the delta time of the last event as a numeric value
(currently, it just saves it within the string) so that filters and
histograms can use it.

Link: https://lkml.kernel.org/r/20220906225529.213677569@goodmis.org

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_benchmark.c | 2 +-
 kernel/trace/trace_benchmark.h | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 801c2a7f7605..54d5fa35c90a 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -51,7 +51,7 @@ static void trace_do_benchmark(void)
 
 	local_irq_disable();
 	start = trace_clock_local();
-	trace_benchmark_event(bm_str);
+	trace_benchmark_event(bm_str, bm_last);
 	stop = trace_clock_local();
 	local_irq_enable();
 
diff --git a/kernel/trace/trace_benchmark.h b/kernel/trace/trace_benchmark.h
index 79e6fbe5b365..c3e91060dc94 100644
--- a/kernel/trace/trace_benchmark.h
+++ b/kernel/trace/trace_benchmark.h
@@ -14,19 +14,21 @@ extern void trace_benchmark_unreg(void);
 
 TRACE_EVENT_FN(benchmark_event,
 
-	TP_PROTO(const char *str),
+	TP_PROTO(const char *str, u64 delta),
 
-	TP_ARGS(str),
+	TP_ARGS(str, delta),
 
 	TP_STRUCT__entry(
 		__array(	char,	str,	BENCHMARK_EVENT_STRLEN	)
+		__field(	u64,	delta)
 	),
 
 	TP_fast_assign(
 		memcpy(__entry->str, str, BENCHMARK_EVENT_STRLEN);
+		__entry->delta = delta;
 	),
 
-	TP_printk("%s", __entry->str),
+	TP_printk("%s delta=%llu", __entry->str, __entry->delta),
 
 	trace_benchmark_reg, trace_benchmark_unreg
 );
-- 
2.35.1
