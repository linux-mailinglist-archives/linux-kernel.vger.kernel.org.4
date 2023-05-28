Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437417137CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjE1F0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 01:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjE1F0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:26:47 -0400
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 May 2023 22:26:40 PDT
Received: from mammoth.local.home (cpe-172-100-189-27.stny.res.rr.com [172.100.189.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94AC7D8;
        Sat, 27 May 2023 22:26:40 -0700 (PDT)
Received: by mammoth.local.home (Postfix, from userid 5657)
        id D650C30113E; Sun, 28 May 2023 01:17:53 -0400 (EDT)
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5/5] tracing: Have function_graph selftest call cond_resched()
Date:   Sun, 28 May 2023 01:17:42 -0400
Message-Id: <20230528051742.1325503-6-rostedt@goodmis.org>
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

When all kernel debugging is enabled (lockdep, KSAN, etc), the function
graph enabling and disabling can take several seconds to complete. The
function_graph selftest enables and disables function graph tracing
several times. With full debugging enabled, the soft lockup watchdog was
triggering because the selftest was running without ever scheduling.

Add cond_resched() throughout the test to make sure it does not trigger
the soft lockup detector.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index a931d9aaea26..529590499b1f 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -848,6 +848,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	}
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * These tests can take some time to run. Make sure on non PREEMPT
+	 * kernels, we do not trigger the softlockup detector.
+	 */
+	cond_resched();
+
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
 
@@ -869,6 +875,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	if (ret)
 		goto out;
 
+	cond_resched();
+
 	ret = register_ftrace_graph(&fgraph_ops);
 	if (ret) {
 		warn_failed_init_tracer(trace, ret);
@@ -891,6 +899,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	if (ret)
 		goto out;
 
+	cond_resched();
+
 	tracing_start();
 
 	if (!ret && !count) {
-- 
2.39.2

