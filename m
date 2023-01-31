Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5868325B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjAaQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjAaQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:15:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D45529C;
        Tue, 31 Jan 2023 08:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC6FDB81D12;
        Tue, 31 Jan 2023 16:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDC4C433EF;
        Tue, 31 Jan 2023 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181742;
        bh=YdubDtuCfm7Xts6OWX58bu+Wvj70SvDo8OqjX07IXzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egfF9OwZaD08gGNt3sVnkF44XOTe9+FnXE3hzXl7dp+97b8vBqT/c6TSL04KvXC2Z
         mrx8zlHRBzPMJO9ClFDI/FoGbIrZE+gYRYWBhOjvFtFWodimn6H3MdELLODCFntl9v
         wm2Dkr6e+6+pQpGxrqux1vZ5l5o1T3xVkgaSbvLM4IgMg8T1gSdE1jVaxaP1RVisCy
         f3ohfRkR72Ax5+f1N8hl9+Kn8M6MX1yI9FI4XBRzx/o2W681OQ51lP6rflWB1aqBVz
         AZ6NtuIiuJ+wLTtUWFp/65J3nOqJyrK9zagZ+rHRjYlD+mnkgnLzQ2RACHSJ9An/Q9
         d8mUvHbw87b3A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 04/10] lib/test_fprobe: Add a test case for nr_maxactive
Date:   Wed,  1 Feb 2023 01:15:39 +0900
Message-Id:  <167518173937.336834.17693222408736869418.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
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
 

