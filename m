Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A736218C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiKHPu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiKHPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:50:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626835C778;
        Tue,  8 Nov 2022 07:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEFC9CE1C04;
        Tue,  8 Nov 2022 15:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF5C433C1;
        Tue,  8 Nov 2022 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922611;
        bh=5l8khZ1P9sioaYF0TNk9KOSmOx0dNhLQfbQv88Ag2GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmJOd5tLr2rZ8+4PpywGm9an1ASrxZWDnV/e5slb8g2RnRHqCmGwINtQ0pcWTLyxL
         kUU8pqouH6BHKUWc9ZtJJxv121Iptz13Rw9+dsSqBFM3g4OjNvd+UFN+a8Jv4yDdH9
         XvCXTYAX487i4T5i/NYCVHTAzsX/yEi4R78qq+1lBEjzDPdACh/c+oPezk/ASygmGS
         GkLs8T8xw9H7khaioLq/GJuPMMVd2IfahFyNB81K2wJqVy1IqtVM62Sxf8fiPsAahb
         grW3AjO+4cirMehZnRH3AbU8Af2/O/cUDy/sLM4z6WJNQ4QqyV0SFOzopf+QxVbN9N
         yWbeH/GzR+KaQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 6/9] lib/test_fprobe: Add a testcase for skipping exit_handler
Date:   Wed,  9 Nov 2022 00:50:07 +0900
Message-Id: <166792260740.919356.5736843826698103180.stgit@devnote3>
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

Add a testcase for skipping exit_handler if entry_handler
returns !0.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/test_fprobe.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index e78176d252ae..926d5104b291 100644
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
@@ -237,6 +260,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
 	KUNIT_CASE(test_fprobe_nest),
+	KUNIT_CASE(test_fprobe_skip),
 	{}
 };
 

