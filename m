Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3313660E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbjAGKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjAGKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:53:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F11AA35;
        Sat,  7 Jan 2023 02:53:02 -0800 (PST)
Date:   Sat, 07 Jan 2023 10:52:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29IFVQKkBM2d3cUMvgcNHzznzn5qBc+AsfivuOcJal0=;
        b=b/jFfricaL+KuACzOOF72nHenKyfLcUsnFdvXswCadJQkxy4YlZgVgGJsgtPu5Li4BkHxe
        Rm9DWJbLKDwFVnzkpjW5uTEH08kTsnqy3TL43bsw7a16lrErlakCrcweF1gzTYkSSxls2A
        6sPAUa0/KFOCzoGyRIwztvg+FSXHSUIUdR31MKcwWxsh0KThFaEOKcdAxOgtVgdlDeCtvZ
        cDTmgMrpIlhIWGwn6n1JuHLKJv+CEFf2Kuv3DrVfcVtAGHrVuS1DP7DJAX8NdhhFy3wF7c
        oA4dWKjtl5+itp7qnEpx6iHo6fU8l4avVu4o5ztrf5YIld5hahe1jRQEK2zSAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29IFVQKkBM2d3cUMvgcNHzznzn5qBc+AsfivuOcJal0=;
        b=pIqLlM4oFrAY7MwloLk8nuWQFJbhdnqDieOV1x94QPFe+noDrsetbj6dTktht0EGvlmFUi
        9YBJqQYimJZg4VCQ==
From:   "tip-bot2 for Michal Clapinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS
Cc:     Michal Clapinski <mclapinski@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221207164338.1535591-3-mclapinski@google.com>
References: <20221207164338.1535591-3-mclapinski@google.com>
MIME-Version: 1.0
Message-ID: <167308877964.4906.16867629366047157464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d74f87f37672e71457bfcc14eca5eeb1d61b6438
Gitweb:        https://git.kernel.org/tip/d74f87f37672e71457bfcc14eca5eeb1d61b6438
Author:        Michal Clapinski <mclapinski@google.com>
AuthorDate:    Wed, 07 Dec 2022 17:43:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 11:29:29 +01:00

selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS

Keep track of previously issued registrations and compare the result
with MEMBARRIER_CMD_GET_REGISTRATIONS return value.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20221207164338.1535591-3-mclapinski@google.com
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h          | 33 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c  |  2 +-
 tools/testing/selftests/membarrier/membarrier_test_single_thread.c |  6 +++++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index 186be69..af89855 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -9,11 +9,38 @@
 
 #include "../kselftest.h"
 
+static int registrations;
+
 static int sys_membarrier(int cmd, int flags)
 {
 	return syscall(__NR_membarrier, cmd, flags);
 }
 
+static int test_membarrier_get_registrations(int cmd)
+{
+	int ret, flags = 0;
+	const char *test_name =
+		"sys membarrier MEMBARRIER_CMD_GET_REGISTRATIONS";
+
+	registrations |= cmd;
+
+	ret = sys_membarrier(MEMBARRIER_CMD_GET_REGISTRATIONS, 0);
+	if (ret < 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	} else if (ret != registrations) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, ret = %d, registrations = %d\n",
+			test_name, flags, ret, registrations);
+	}
+	ksft_test_result_pass(
+		"%s test: flags = %d, ret = %d, registrations = %d\n",
+		test_name, flags, ret, registrations);
+
+	return 0;
+}
+
 static int test_membarrier_cmd_fail(void)
 {
 	int cmd = -1, flags = 0;
@@ -113,6 +140,8 @@ static int test_membarrier_register_private_expedited_success(void)
 	ksft_test_result_pass(
 		"%s test: flags = %d\n",
 		test_name, flags);
+
+	test_membarrier_get_registrations(cmd);
 	return 0;
 }
 
@@ -170,6 +199,8 @@ static int test_membarrier_register_private_expedited_sync_core_success(void)
 	ksft_test_result_pass(
 		"%s test: flags = %d\n",
 		test_name, flags);
+
+	test_membarrier_get_registrations(cmd);
 	return 0;
 }
 
@@ -204,6 +235,8 @@ static int test_membarrier_register_global_expedited_success(void)
 	ksft_test_result_pass(
 		"%s test: flags = %d\n",
 		test_name, flags);
+
+	test_membarrier_get_registrations(cmd);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index ac5613e..a9cc17f 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -62,7 +62,7 @@ static int test_mt_membarrier(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(13);
+	ksft_set_plan(16);
 
 	test_membarrier_query();
 
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index c1c9639..4cdc8b1 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -12,7 +12,9 @@
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(13);
+	ksft_set_plan(18);
+
+	test_membarrier_get_registrations(/*cmd=*/0);
 
 	test_membarrier_query();
 
@@ -20,5 +22,7 @@ int main(int argc, char **argv)
 
 	test_membarrier_success();
 
+	test_membarrier_get_registrations(/*cmd=*/0);
+
 	return ksft_exit_pass();
 }
