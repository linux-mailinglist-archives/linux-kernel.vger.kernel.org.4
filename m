Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA66218C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiKHPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiKHPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:49:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DB41A05C;
        Tue,  8 Nov 2022 07:49:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11B35CE1C04;
        Tue,  8 Nov 2022 15:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA5DC433D6;
        Tue,  8 Nov 2022 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922575;
        bh=/kBV/jdXFFKQ7g+a2x8FqSBZ13fmPZyh2fMeYv/CAeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X51RIF5NnDzgd9OUoZAaVIRxeEIQeJ55JFZxRL72D+H7Vcbtz7IFOEzIjxeQyc+12
         /ZDkVDuDKdiIHfhHJ2xZdpiv+EWrq+/yuMMqHHtsxPov2s/zWtKuhc0+9sSD2yMM3v
         7x9ywFabpoQ3dkQLAbDRqTm2Nwi9pppz6sErxXwOhrxMuW1UloMvOemPvI9ULmfI4E
         3vSobm5MO9BHP3lBXSM8gVDpnVjPktzC+NwNV3KcHqyJnqvsJx7heNYWQxjw4FKE2Y
         ZmRAik0KSTNYu5hGghwjvXM3r+QlLZTynq2a4PPDAa5m1K709CzCuwK6M114iOdlZl
         cS5oesrBMrH/A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 2/9] lib/test_fprobe: Add private entry_data testcases
Date:   Wed,  9 Nov 2022 00:49:32 +0900
Message-Id: <166792257200.919356.18367653034787369847.stgit@devnote3>
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

Add test cases for checking whether private entry_data is
correctly passed or not.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/test_fprobe.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 34fa5a5bbda1..941bf5234c31 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -38,6 +38,12 @@ static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip,
 	if (ip != target_ip)
 		KUNIT_EXPECT_EQ(current_test, ip, target2_ip);
 	entry_val = (rand1 / div_factor);
+	if (fp->entry_data_size) {
+		KUNIT_EXPECT_NOT_NULL(current_test, data);
+		if (data)
+			*(u32 *)data = entry_val;
+	} else
+		KUNIT_EXPECT_NULL(current_test, data);
 }
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -53,6 +59,12 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 		KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor));
 	KUNIT_EXPECT_EQ(current_test, entry_val, (rand1 / div_factor));
 	exit_val = entry_val + div_factor;
+	if (fp->entry_data_size) {
+		KUNIT_EXPECT_NOT_NULL(current_test, data);
+		if (data)
+			KUNIT_EXPECT_EQ(current_test, *(u32 *)data, entry_val);
+	} else
+		KUNIT_EXPECT_NULL(current_test, data);
 }
 
 /* Test entry only (no rethook) */
@@ -134,6 +146,23 @@ static void test_fprobe_syms(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+/* Test private entry_data */
+static void test_fprobe_data(struct kunit *test)
+{
+	struct fprobe fp = {
+		.entry_handler = fp_entry_handler,
+		.exit_handler = fp_exit_handler,
+		.entry_data_size = sizeof(u32),
+	};
+
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp, "fprobe_selftest_target", NULL));
+
+	target(rand1);
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -162,6 +191,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_entry),
 	KUNIT_CASE(test_fprobe),
 	KUNIT_CASE(test_fprobe_syms),
+	KUNIT_CASE(test_fprobe_data),
 	{}
 };
 

