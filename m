Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8833F6CF379
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjC2TqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjC2Tpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3546DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F93C61E19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6075C433AA;
        Wed, 29 Mar 2023 19:45:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjx-002RgN-3A;
        Wed, 29 Mar 2023 15:45:49 -0400
Message-ID: <20230329194549.798918632@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 04/25] lib/test_fprobe: Add a test case for nr_maxactive
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add a test case for nr_maxactive. If the number of active
functions is more than nr_maxactive, it must be skipped.

Link: https://lkml.kernel.org/r/167526698856.433354.4430007340787176666.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 lib/test_fprobe.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 6c7ef5acea21..4b37d7022f35 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -17,8 +17,10 @@ static u32 rand1, entry_val, exit_val;
 /* Use indirect calls to avoid inlining the target functions */
 static u32 (*target)(u32 value);
 static u32 (*target2)(u32 value);
+static u32 (*target_nest)(u32 value, u32 (*nest)(u32));
 static unsigned long target_ip;
 static unsigned long target2_ip;
+static unsigned long target_nest_ip;
 
 static noinline u32 fprobe_selftest_target(u32 value)
 {
@@ -30,6 +32,11 @@ static noinline u32 fprobe_selftest_target2(u32 value)
 	return (value / div_factor) + 1;
 }
 
+static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
+{
+	return nest(value + 2);
+}
+
 static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip,
 				     struct pt_regs *regs, void *data)
 {
@@ -67,6 +74,19 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 		KUNIT_EXPECT_NULL(current_test, data);
 }
 
+static notrace void nest_entry_handler(struct fprobe *fp, unsigned long ip,
+				     struct pt_regs *regs, void *data)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+}
+
+static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
+				    struct pt_regs *regs, void *data)
+{
+	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
+}
+
 /* Test entry only (no rethook) */
 static void test_fprobe_entry(struct kunit *test)
 {
@@ -163,6 +183,25 @@ static void test_fprobe_data(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+/* Test nr_maxactive */
+static void test_fprobe_nest(struct kunit *test)
+{
+	static const char *syms[] = {"fprobe_selftest_target", "fprobe_selftest_nest_target"};
+	struct fprobe fp = {
+		.entry_handler = nest_entry_handler,
+		.exit_handler = nest_exit_handler,
+		.nr_maxactive = 1,
+	};
+
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe_syms(&fp, syms, 2));
+
+	target_nest(rand1, target);
+	KUNIT_EXPECT_EQ(test, 1, fp.nmissed);
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -178,8 +217,10 @@ static int fprobe_test_init(struct kunit *test)
 	rand1 = get_random_u32_above(div_factor);
 	target = fprobe_selftest_target;
 	target2 = fprobe_selftest_target2;
+	target_nest = fprobe_selftest_nest_target;
 	target_ip = get_ftrace_location(target);
 	target2_ip = get_ftrace_location(target2);
+	target_nest_ip = get_ftrace_location(target_nest);
 
 	return 0;
 }
@@ -189,6 +230,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe),
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
+	KUNIT_CASE(test_fprobe_nest),
 	{}
 };
 
-- 
2.39.1
