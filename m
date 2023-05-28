Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3C7137D0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE1F1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 01:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjE1F0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:26:47 -0400
Received: from mammoth.local.home (cpe-172-100-189-27.stny.res.rr.com [172.100.189.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEE8CDC;
        Sat, 27 May 2023 22:26:40 -0700 (PDT)
Received: by mammoth.local.home (Postfix, from userid 5657)
        id C1A87300A64; Sun, 28 May 2023 01:17:53 -0400 (EDT)
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 2/5] tracing: Have tracer selftests call cond_resched() before running
Date:   Sun, 28 May 2023 01:17:39 -0400
Message-Id: <20230528051742.1325503-3-rostedt@goodmis.org>
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

As there are more and more internal selftests being added to the Linux
kernel (KSAN, lockdep, etc) the selftests are taking longer to run when
these are enabled. Add a cond_resched() to the calling of
do_run_tracer_selftest() to force a schedule if NEED_RESCHED is set,
otherwise the soft lockup watchdog may trigger on boot up.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 87e5920b141f..70f2b511b9cd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2045,6 +2045,13 @@ static int do_run_tracer_selftest(struct tracer *type)
 {
 	int ret;
 
+	/*
+	 * Tests can take a long time, especially if they are run one after the
+	 * other, as does happen during bootup when all the tracers are
+	 * registered. This could cause the soft lockup watchdog to trigger.
+	 */
+	cond_resched();
+
 	tracing_selftest_running = true;
 	ret = run_tracer_selftest(type);
 	tracing_selftest_running = false;
-- 
2.39.2

