Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB66B6571
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCLL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCLL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:28:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC352F61
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620456; x=1710156456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oTU4sxTXYKtAIVLwPW8AIWDYdktjaL52nQvpCjw3OeY=;
  b=mrUT0a6seE1VgRg1wfT2i0V+0C33nYPJn+MGiH1EZAtCAGc2bb4rFECi
   yzv5Cf567Y1PnChjK308EGUSm4tsCFvxyVmq9oXxLkeEVToAkl1MgtB9W
   fwNWpUBnYH++SMsmLRdarlZajOV0yAW27tyo0sHKPHsOUcQrCV0/HVnjF
   7Bv8hrVgbwlFC5EcnMb7jRRLiJiqEAIXl2gvWraPpWCWmeTGLCG/tBvZH
   ySlycjyc+fvWaNjloKrIesRlkDS0TrLHX8Rr/bVW5MxnEXyBQaFiqoEkf
   qKR3bAbWcVbZArLjBSj7fuhRgNt6tCgGHthTsWRLXCx4BRqJTvlRG7hMe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399577656"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="399577656"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="671580755"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671580755"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0BE2910D7BF; Sun, 12 Mar 2023 14:26:20 +0300 (+03)
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
Subject: [PATCHv16 17/17] selftests/x86/lam: Add test cases for LAM vs thread creation
Date:   Sun, 12 Mar 2023 14:26:12 +0300
Message-Id: <20230312112612.31869-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
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
2.39.2

