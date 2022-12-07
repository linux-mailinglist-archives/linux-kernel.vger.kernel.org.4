Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2C645F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLGQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLGQoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:44:02 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03B5E3C2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:44:00 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id k8-20020a05651c10a800b00279ff1459b6so3287558ljn.19
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMcxzvpQ79NigTE1Z+XywTBOeZAVWjGPGIVGHcTu/LY=;
        b=hB/sk0afJO4g4k73aTVkKJ1vNRhCYGcH2LDEGEF6h0UVflD/+52ZaUq0TwvY/20lIB
         V6Pm/Q6cInPd1VngVfp45sQ9arCcu3CBHL+Nj7lxzVXdU10/6FVwzJnRWROgriBMD3d9
         mvk0pi1qcBr9D7CcHlDHb6JyipEL5TwzF0CballDjeL88MIUVyHqnidLAgBo4va/GztN
         nmYu4nOMyRkrKQ596r/kTMY4z+snc/GTMkVNoUGS87kPV74Rgk3J7cMYgnuoTPgE0Jpe
         F37SUXjpOiiNvsfzW98G05VwdoRbpcXUMtC9BgJmGOxtqOHTNSr6wgahra+KRwFnkTF1
         3pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMcxzvpQ79NigTE1Z+XywTBOeZAVWjGPGIVGHcTu/LY=;
        b=avnPG/3g46UWlVmSbHtS2RaOCbCrQWQbrWre5Cj06j7dQU0M1XZ9EePO+Tmha6mQar
         +R2D3xS1Nro2WG0LFbkwWayAnOqxa8iks0Zdk4STB2CeRETSmlUDhVpKjiv7rgZ6u6iX
         tWvDcHCVu8OYDN4xqDVzxZ/duelOzs2PevAz7yNghJE76qhNGk6rQ819Oh3oL97bHeqw
         VmC1t5hGXI51/GQ6k3PQqKW6iqGJk19ghVIdLua1mtC3N+86jMMzkSFEPCoxy+hIF2O1
         NpqU049dK5ewFwknP1Q5137jU+e70dwlACiu0x6CG1hhK/+Ww+RLNHjpJ2KoPtLmEUio
         jbZg==
X-Gm-Message-State: ANoB5pl7CMCqjiSmTekIkNbFPP9PzQaCOs3JW8taL7T7jnGiHJfq6DJz
        bvBKNXumV0bCqYajAgCMxH8qix0OWXo+Lc2Q
X-Google-Smtp-Source: AA0mqf4xrI8w0q5oOG5W2+kw/G/DXZljwzYZt9o7MMuLcR38iNbo42aEEbZZw85XqQVA++M5vTtKinrJ/TIke8AN
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:3d6d:f78e:bc73:df])
 (user=mclapinski job=sendgmr) by 2002:a05:651c:1586:b0:277:38f:ffad with SMTP
 id h6-20020a05651c158600b00277038fffadmr21919328ljq.439.1670431438583; Wed,
 07 Dec 2022 08:43:58 -0800 (PST)
Date:   Wed,  7 Dec 2022 17:43:38 +0100
In-Reply-To: <20221207164338.1535591-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20221207164338.1535591-1-mclapinski@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207164338.1535591-3-mclapinski@google.com>
Subject: [PATCH 2/2] selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS
From:   Michal Clapinski <mclapinski@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of previously issued registrations and compare the result
with MEMBARRIER_CMD_GET_REGISTRATIONS return value.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 .../membarrier/membarrier_test_impl.h         | 33 +++++++++++++++++++
 .../membarrier/membarrier_test_multi_thread.c |  2 +-
 .../membarrier_test_single_thread.c           |  6 +++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index 186be69f0a59..af89855adb7b 100644
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
index ac5613e5b0eb..a9cc17facfb3 100644
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
index c1c963902854..4cdc8b1d124c 100644
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
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

