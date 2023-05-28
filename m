Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040BC7137CF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE1F05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 01:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1F0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:26:47 -0400
Received: from mammoth.local.home (cpe-172-100-189-27.stny.res.rr.com [172.100.189.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC282E1;
        Sat, 27 May 2023 22:26:40 -0700 (PDT)
Received: by mammoth.local.home (Postfix, from userid 5657)
        id C8B2D300CB6; Sun, 28 May 2023 01:17:53 -0400 (EDT)
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 3/5] tracing: Make tracing_selftest_running/delete nops when not used
Date:   Sun, 28 May 2023 01:17:40 -0400
Message-Id: <20230528051742.1325503-4-rostedt@goodmis.org>
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

There's no reason to test the condition variables tracing_selftest_running
or tracing_selftest_delete when tracing selftests are not enabled. Make
them define 0s when not the selftests are not configured in.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 70f2b511b9cd..004f5f99e943 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -60,6 +60,7 @@
  */
 bool ring_buffer_expanded;
 
+#ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
  * We need to change this state when a selftest is running.
  * A selftest will lurk into the ring-buffer to count the
@@ -75,7 +76,6 @@ static bool __read_mostly tracing_selftest_running;
  */
 bool __read_mostly tracing_selftest_disabled;
 
-#ifdef CONFIG_FTRACE_STARTUP_TEST
 void __init disable_tracing_selftest(const char *reason)
 {
 	if (!tracing_selftest_disabled) {
@@ -83,6 +83,9 @@ void __init disable_tracing_selftest(const char *reason)
 		pr_info("Ftrace startup test is disabled due to %s\n", reason);
 	}
 }
+#else
+#define tracing_selftest_running	0
+#define tracing_selftest_disabled	0
 #endif
 
 /* Pipe tracepoints to printk */
-- 
2.39.2

