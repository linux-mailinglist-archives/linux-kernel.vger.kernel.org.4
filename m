Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35CB678A50
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjAWWH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjAWWHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:07:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A439BA8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674511598; x=1706047598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aL4h23Fj04DVJyvMyBqOftpxNoBnsmucH0zYgJ3jJBA=;
  b=P53Rd+KuO95YzuCKMSB9x0ih1xlUINz4P6XD+ILfTKBjuNi3dqOy2FQc
   Je54ElTEYwJ5LPYeFaVStpkN0ZzhdDJtdOvhpGxZiM5SbQ9Uz8LxpbMnh
   7HDekTKA53O1d8iHw8Y4i/BKTMwKBbWYo1fugaN3vIDuwFWq+B7zDn/OD
   PPB71PvTV9JDyD/hlm2uTr3ypSyhV5IRjjx8TwBneOWPy89UPJdsQML9O
   yt1NWxQhhFU6izSjm7he9AvWwWXOoucTBddmnlZq21g1kA1iLV8LG4Cvd
   Mvn2IQR5pp/J05LxKN8eiBv/kR+2X3wXe1Nfz8j+vuXjFTxa5UB/t1G00
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326198288"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="326198288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 14:05:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694103572"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694103572"
Received: from ssauty-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.46.171])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 14:05:27 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D3EA2109B86; Tue, 24 Jan 2023 01:05:03 +0300 (+03)
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
Subject: [PATCHv15 17/17] selftests/x86/lam: Add test cases for LAM vs thread creation
Date:   Tue, 24 Jan 2023 01:05:00 +0300
Message-Id: <20230123220500.21077-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/x86/lam.c | 92 +++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index a8c91829b616..eb0e46905bf9 100644
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
2.39.1

