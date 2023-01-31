Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9568325D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjAaQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAaQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:16:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47A577CF;
        Tue, 31 Jan 2023 08:16:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64BD0B81D6B;
        Tue, 31 Jan 2023 16:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F9C433D2;
        Tue, 31 Jan 2023 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181761;
        bh=wZT4Dx1G5sQKe7woMdQS0Dh9raDFOrBfH90F6GkZi2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2bAoknhA1HcGu0cf/FCj67G4E+Xvj/npbR1LrhukDIf1bzrO8wAhksaqNoSX3uZL
         bm92Q3QFz2YtOMaWlobyTNNiFwcDl/Hl+nRybBJdcAN0WmDE2cRmG/w1+YDoOl2mya
         Gn4rk8Qx28gjKxBYLEafz/Z+CWbsgwPMiWv/hgJOR48qcFCLYb0UNLeutFbOfDcmKY
         DGabPufNuaizroaJSe7H4QyMm35vMwIfdgsKG1hs3CBOAAIRm1+YTD0zZMIOD6fDuF
         jhePpBSmXQjS+jB5BQHJZRGvhX1YeJVr4ofsKveHgI6lv2S/ftTnjEc/rmE32ZWHhX
         5Og81gH+DrIsg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 06/10] lib/test_fprobe: Add a testcase for skipping exit_handler
Date:   Wed,  1 Feb 2023 01:15:56 +0900
Message-Id:  <167518175682.336834.14783435895267743380.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
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
 

