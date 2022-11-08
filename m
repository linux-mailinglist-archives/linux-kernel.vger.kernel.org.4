Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C426218C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiKHPuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiKHPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:49:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11645C764;
        Tue,  8 Nov 2022 07:49:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D2F7CE1BD9;
        Tue,  8 Nov 2022 15:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE6AC433D6;
        Tue,  8 Nov 2022 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922593;
        bh=F/6mNWeMxsAl5sO9bPrQ/z7sSueL8mpIe+JI9wyTpYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8FmuCdMpK+lpMhQo9J82CHO7rwMk1BCa7U0M97ydkONfEyQEEyVVpxw4oSF+EgPK
         yKv6X0HxVdO+8VeIRCG1fWqO+MaQsTAVxBDt7HTRWsAg7iVWw1UX86cgLng8RY1YrY
         aOzQxaQ/I3sKuBojHDCq7T3Yvk8cAj3YrOai2l5mK6mFZV+yZj5hXpKOAfYbK4IsSC
         8U15dj5bTc1ehQVQlVBNHWbzUod08f//omP9ZKLjJuwtHPcP6qBg9ATuRGdk8+5n1O
         ycPdUV4siXqESznuqvTwSmcEG7tmcKJkhRQ1qdzLRuJ77VTtqwLG/ffMUTWDnXdnpS
         1ucBLdHPd4q9w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 4/9] lib/test_fprobe: Add a test case for nr_maxactive
Date:   Wed,  9 Nov 2022 00:49:49 +0900
Message-Id: <166792258988.919356.1550112303992706866.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <166792255429.919356.14116090269057513181.stgit@devnote3>
References: <166792255429.919356.14116090269057513181.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 941bf5234c31..976fb3f7cb01 100644
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
@@ -181,8 +220,10 @@ static int fprobe_test_init(struct kunit *test)
 
 	target = fprobe_selftest_target;
 	target2 = fprobe_selftest_target2;
+	target_nest = fprobe_selftest_nest_target;
 	target_ip = get_ftrace_location(target);
 	target2_ip = get_ftrace_location(target2);
+	target_nest_ip = get_ftrace_location(target_nest);
 
 	return 0;
 }
@@ -192,6 +233,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe),
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
+	KUNIT_CASE(test_fprobe_nest),
 	{}
 };
 

