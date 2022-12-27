Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A48656708
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 04:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiL0DJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 22:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiL0DJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:09:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706EB60EA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672110537; x=1703646537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/1WmzpYknIw+qctuMHiI9dXZs4L/e/XIgoQK8Su5Ss=;
  b=HOGWHEVxQOTyrWUwzz1njDmCUAOPz/vPcNSyg/RkjdTzKAFf1qZf+L8h
   QSdMZ4OtaCcw+YAehr5f+OlSfGbdfJIelji67bwQQzxtPs6fwalwLeJ5M
   PYFPQT6TafwGEmhP0riyU2t2mJS/9Vi1fqtheJVo23+NsRQAVKGE5led/
   i+AQL39StC2fSoXrOT/cTZ9dfpUakATwAtQDTeiREue6Q2nsRQGQ4Gw5P
   sAVXTzX8j/PNvRSWQ+kdGPjktuas8GOqqX4hXQ001Tn+cjI7pxFP1JTM+
   AjOwWsuBsjOSANu3qSSDSBvOUFyJnOhF1Qiq44Ec1HosKKR1ph87G+MSV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="300994737"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="300994737"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 19:08:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="741605234"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="741605234"
Received: from ppogotov-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.62.152])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 19:08:52 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2DC6210BBBD; Tue, 27 Dec 2022 06:08:37 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv13 16/16] selftests/x86/lam: Add test cases for LAM vs thread creation
Date:   Tue, 27 Dec 2022 06:08:29 +0300
Message-Id: <20221227030829.12508-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAM enabling is only allowed when the process has single thread.
LAM mode is inherited into child thread.

Trying to enable LAM after spawning a thread has to fail.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 tools/testing/selftests/x86/lam.c | 92 +++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 52a876a7ccb8..93e6089164b6 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -12,6 +13,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <sched.h>
 
 #include <sys/uio.h>
 #include <linux/io_uring.h>
@@ -50,6 +52,8 @@
 
 #define PAGE_SIZE               (4 << 10)
 
+#define STACK_SIZE		65536
+
 #define barrier() ({						\
 		   __asm__ __volatile__("" : : : "memory");	\
 })
@@ -731,6 +735,75 @@ static int handle_inheritance(struct testcases *test)
 	return 0;
 }
 
+static int thread_fn_get_lam(void *arg)
+{
+	return get_lam();
+}
+
+static int thread_fn_set_lam(void *arg)
+{
+	struct testcases *test = arg;
+
+	return set_lam(test->lam);
+}
+
+static int handle_thread(struct testcases *test)
+{
+	char stack[STACK_SIZE];
+	int ret, child_ret;
+	int lam = 0;
+	pid_t pid;
+
+	/* Set LAM mode in parent process */
+	if (!test->later) {
+		lam = test->lam;
+		if (set_lam(lam) != 0)
+			return 1;
+	}
+
+	pid = clone(thread_fn_get_lam, stack + STACK_SIZE,
+		    SIGCHLD | CLONE_FILES | CLONE_FS | CLONE_VM, NULL);
+	if (pid < 0) {
+		perror("Clone failed.");
+		return 1;
+	}
+
+	waitpid(pid, &child_ret, 0);
+	ret = WEXITSTATUS(child_ret);
+
+	if (lam != ret)
+		return 1;
+
+	if (test->later) {
+		if (set_lam(test->lam) != 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int handle_thread_enable(struct testcases *test)
+{
+	char stack[STACK_SIZE];
+	int ret, child_ret;
+	int lam = test->lam;
+	pid_t pid;
+
+	pid = clone(thread_fn_set_lam, stack + STACK_SIZE,
+		    SIGCHLD | CLONE_FILES | CLONE_FS | CLONE_VM, test);
+	if (pid < 0) {
+		perror("Clone failed.");
+		return 1;
+	}
+
+	waitpid(pid, &child_ret, 0);
+	ret = WEXITSTATUS(child_ret);
+
+	if (lam != ret)
+		return 1;
+
+	return 0;
+}
 static void run_test(struct testcases *test, int count)
 {
 	int i, ret = 0;
@@ -846,6 +919,25 @@ static struct testcases inheritance_cases[] = {
 		.test_func = handle_inheritance,
 		.msg = "FORK: LAM_U57, child process should get LAM mode same as parent\n",
 	},
+	{
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread,
+		.msg = "THREAD: LAM_U57, child thread should get LAM mode same as parent\n",
+	},
+	{
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread_enable,
+		.msg = "THREAD: [NEGATIVE] Enable LAM in child.\n",
+	},
+	{
+		.expected = 1,
+		.later = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread,
+		.msg = "THREAD: [NEGATIVE] Enable LAM in parent after thread created.\n",
+	},
 	{
 		.expected = 0,
 		.lam = LAM_U57_BITS,
-- 
2.38.2

