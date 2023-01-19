Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07A674A97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjATE2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjATE23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:28:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A072AED9D;
        Thu, 19 Jan 2023 20:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 391BEB82591;
        Thu, 19 Jan 2023 15:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2592EC433F0;
        Thu, 19 Jan 2023 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674142391;
        bh=4e9cU3XBF+njXHs+pBSJ/+9iR11GsQtP644znMOpRCQ=;
        h=From:To:Subject:Date:From;
        b=G+e4arH4OfCYHRXWwufncZh+jDrE3WtcxlJNWepbCKPMuesaVoGoMuHVcL1xoRD01
         uWqJYHsG7etX41q3vAt2QWsGKVPwx24YFWbKDHsZ7+N804l2xEb5lQ4n2c06bO5xuw
         +IHYMyNCAKd0JsGt4OGqLg1g+n+Mc7tzM6SIIHHF9LxF/uRGYk4D/JlkVRXkLHnei4
         i3pq3ErykfgV2MIwJ4/dbausFxGsbJOMAlOzHro7QeST7XTAh+WUA2fly4/N1Mpcmd
         0a8bgIFPzwezZE4jNb2eiGbniG4Wkm3L/ztAjA/ftGyhZW8KouR9AHhscxygIZItOx
         0dtwS8HRqRYWQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] test_kprobes: Add recursed kprobe test case
Date:   Fri, 20 Jan 2023 00:33:07 +0900
Message-Id: <167414238758.2301956.258548940194352895.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
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

Add a recursed kprobe test case to the KUnit test module for kprobes.
This will probe a function which is called from the pre_handler and
post_handler itself. If the kprobe is correctly implemented, the recursed
kprobe handlers will be skipped and the number of skipped kprobe will
be counted on kprobe::nmissed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/test_kprobes.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
index 1c95e5719802..0648f7154f5c 100644
--- a/lib/test_kprobes.c
+++ b/lib/test_kprobes.c
@@ -14,6 +14,7 @@
 
 static u32 rand1, preh_val, posth_val;
 static u32 (*target)(u32 value);
+static u32 (*recursed_target)(u32 value);
 static u32 (*target2)(u32 value);
 static struct kunit *current_test;
 
@@ -27,18 +28,27 @@ static noinline u32 kprobe_target(u32 value)
 	return (value / div_factor);
 }
 
+static noinline u32 kprobe_recursed_target(u32 value)
+{
+	return (value / div_factor);
+}
+
 static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
-	preh_val = (rand1 / div_factor);
+
+	preh_val = recursed_target(rand1);
 	return 0;
 }
 
 static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
 		unsigned long flags)
 {
+	u32 expval = recursed_target(rand1);
+
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
-	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
+	KUNIT_EXPECT_EQ(current_test, preh_val, expval);
+
 	posth_val = preh_val + div_factor;
 }
 
@@ -136,6 +146,29 @@ static void test_kprobes(struct kunit *test)
 	unregister_kprobes(kps, 2);
 }
 
+static struct kprobe kp_missed = {
+	.symbol_name = "kprobe_recursed_target",
+	.pre_handler = kp_pre_handler,
+	.post_handler = kp_post_handler,
+};
+
+static void test_kprobe_missed(struct kunit *test)
+{
+	current_test = test;
+	preh_val = 0;
+	posth_val = 0;
+
+	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp_missed));
+
+	recursed_target(rand1);
+
+	KUNIT_EXPECT_EQ(test, 2, kp_missed.nmissed);
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+	KUNIT_EXPECT_NE(test, 0, posth_val);
+
+	unregister_kprobe(&kp_missed);
+}
+
 #ifdef CONFIG_KRETPROBES
 static u32 krph_val;
 
@@ -336,6 +369,7 @@ static int kprobes_test_init(struct kunit *test)
 {
 	target = kprobe_target;
 	target2 = kprobe_target2;
+	recursed_target = kprobe_recursed_target;
 	stacktrace_target = kprobe_stacktrace_target;
 	internal_target = kprobe_stacktrace_internal_target;
 	stacktrace_driver = kprobe_stacktrace_driver;
@@ -346,6 +380,7 @@ static int kprobes_test_init(struct kunit *test)
 static struct kunit_case kprobes_testcases[] = {
 	KUNIT_CASE(test_kprobe),
 	KUNIT_CASE(test_kprobes),
+	KUNIT_CASE(test_kprobe_missed),
 #ifdef CONFIG_KRETPROBES
 	KUNIT_CASE(test_kretprobe),
 	KUNIT_CASE(test_kretprobes),

