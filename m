Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC8686AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBAP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjBAP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:56:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4D7518D;
        Wed,  1 Feb 2023 07:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 221AB617B0;
        Wed,  1 Feb 2023 15:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7CBC433D2;
        Wed,  1 Feb 2023 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675266992;
        bh=YdubDtuCfm7Xts6OWX58bu+Wvj70SvDo8OqjX07IXzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DH7WG9aTyWZA/I8yMRPpT/qZYJyHdHyNJDh5iBrO5tfEgOapn41xboTPtMJaNckaG
         51BSnmj8x76SLodK7vzz+S4anjf/WDqX+a+Z/Sa8mk/L6jL6zMWXoNKQ3fCQ+qUoqJ
         YKT7qwG7Puj60NRtwWMMMEa3qs9BbUMqhhAH2sm1uqI2kOMF8uxc/YuszrsJcJfPH4
         v+Alo0cRMicxC80KahPa1AhL0PM9fQBXx1QxYPX3tOE5v4igjnMjC+44oDDs6VbW/m
         kWVqQnpFNw8vDLafuCWybq3GSyZUjOjaHxy0DuoYOr63f5BcJn/8kz5DuxvFOHz6xg
         AFYBJ9KWAAWYw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 04/10] lib/test_fprobe: Add a test case for nr_maxactive
Date:   Thu,  2 Feb 2023 00:56:28 +0900
Message-Id:  <167526698856.433354.4430007340787176666.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167526695292.433354.8949652607331707144.stgit@mhiramat.roam.corp.google.com>
References:  <167526695292.433354.8949652607331707144.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a test case for nr_maxactive. If the number of active
functions is more than nr_maxactive, it must be skipped.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/test_fprobe.c |   42 ++++++++++++++++++++++++++++++++++++++++++
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
 

