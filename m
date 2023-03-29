Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB76CF385
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjC2Tqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjC2Tp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F72126
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82DCDB82435
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4964CC4339E;
        Wed, 29 Mar 2023 19:45:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjy-002RhT-1H;
        Wed, 29 Mar 2023 15:45:50 -0400
Message-ID: <20230329194550.208773263@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 06/25] lib/test_fprobe: Add a testcase for skipping exit_handler
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add a testcase for skipping exit_handler if entry_handler
returns !0.

Link: https://lkml.kernel.org/r/167526700658.433354.12922388040490848613.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 lib/test_fprobe.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 9fa2ac9eda83..0fe5273e960b 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -21,6 +21,7 @@ static u32 (*target_nest)(u32 value, u32 (*nest)(u32));
 static unsigned long target_ip;
 static unsigned long target2_ip;
 static unsigned long target_nest_ip;
+static int entry_return_value;
 
 static noinline u32 fprobe_selftest_target(u32 value)
 {
@@ -52,7 +53,7 @@ static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 	} else
 		KUNIT_EXPECT_NULL(current_test, data);
 
-	return 0;
+	return entry_return_value;
 }
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -205,6 +206,28 @@ static void test_fprobe_nest(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+static void test_fprobe_skip(struct kunit *test)
+{
+	struct fprobe fp = {
+		.entry_handler = fp_entry_handler,
+		.exit_handler = fp_exit_handler,
+	};
+
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp, "fprobe_selftest_target", NULL));
+
+	entry_return_value = 1;
+	entry_val = 0;
+	exit_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_NE(test, 0, entry_val);
+	KUNIT_EXPECT_EQ(test, 0, exit_val);
+	KUNIT_EXPECT_EQ(test, 0, fp.nmissed);
+	entry_return_value = 0;
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -234,6 +257,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
 	KUNIT_CASE(test_fprobe_nest),
+	KUNIT_CASE(test_fprobe_skip),
 	{}
 };
 
-- 
2.39.1
