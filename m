Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782706C532F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCVSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCVSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC561881;
        Wed, 22 Mar 2023 11:01:29 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679508088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BexXVoRcJd5zje4QT3srhs2vRf3aYNZJMqHysVQnmHg=;
        b=KzDWczA8CjuhS42907bcK6zZHBJ66Sfe731MJAEp2qF1f0GJvNtEml6CciXX70DiKqDGPn
        l/vrLDvEJbikcW1hXmWXm5hvyu6IBBe9qFTcgMjDIbNqhjQTc2Yr0t5hvTjz/ZrIBZg7Ax
        H0djq4eiQPggW2EIXd0N73f1qU1k8VByoMtudCOS5j0UVeuSL1/o9lAwfd9Z0RaR07tD+b
        9lCf2onkkJE4Ers6jFqAl2UYFuYGj8PP8UX1OcLYjb3pv2gMqXIDLrnq58cP40jIN0BtCq
        EsvUHEb/qfcYWmVNaxRHM0wsl9T0zXVtHxeXNLbipQc2IuMr9cjgh1QfaEmH0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679508088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BexXVoRcJd5zje4QT3srhs2vRf3aYNZJMqHysVQnmHg=;
        b=zyMlx2xl5KWd0GYMFlrBE6lD6fbeUv+IdPUvj4381re0VCS8iDpwwRIhmIY2yynnGDmrr/
        gPmRmBV9l+JgEECg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86/amx: Add a ptrace test
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950808744.5837.4136774718227344167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     eab6469e3e7c5df8ff7bbea353a3a5e237d6fa87
Gitweb:        https://git.kernel.org/tip/eab6469e3e7c5df8ff7bbea353a3a5e237d6fa87
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Mon, 27 Feb 2023 13:05:04 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 10:57:30 -07:00

selftests/x86/amx: Add a ptrace test

Include a test case to validate the XTILEDATA injection to the target.

Also, it ensures the kernel's ability to copy states between different
XSAVE formats.

Refactor the memcmp() code to be usable for the state validation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230227210504.18520-3-chang.seok.bae%40intel.com
---
 tools/testing/selftests/x86/amx.c | 108 ++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 625e429..d884fd6 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -14,8 +14,10 @@
 #include <sys/auxv.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
+#include <sys/ptrace.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
+#include <sys/uio.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
 
@@ -583,6 +585,13 @@ static void test_dynamic_state(void)
 	_exit(0);
 }
 
+static inline int __compare_tiledata_state(struct xsave_buffer *xbuf1, struct xsave_buffer *xbuf2)
+{
+	return memcmp(&xbuf1->bytes[xtiledata.xbuf_offset],
+		      &xbuf2->bytes[xtiledata.xbuf_offset],
+		      xtiledata.size);
+}
+
 /*
  * Save current register state and compare it to @xbuf1.'
  *
@@ -599,9 +608,7 @@ static inline bool __validate_tiledata_regs(struct xsave_buffer *xbuf1)
 		fatal_error("failed to allocate XSAVE buffer\n");
 
 	xsave(xbuf2, XFEATURE_MASK_XTILEDATA);
-	ret = memcmp(&xbuf1->bytes[xtiledata.xbuf_offset],
-		     &xbuf2->bytes[xtiledata.xbuf_offset],
-		     xtiledata.size);
+	ret = __compare_tiledata_state(xbuf1, xbuf2);
 
 	free(xbuf2);
 
@@ -826,6 +833,99 @@ static void test_context_switch(void)
 	free(finfo);
 }
 
+/* Ptrace test */
+
+/*
+ * Make sure the ptracee has the expanded kernel buffer on the first
+ * use. Then, initialize the state before performing the state
+ * injection from the ptracer.
+ */
+static inline void ptracee_firstuse_tiledata(void)
+{
+	load_rand_tiledata(stashed_xsave);
+	init_xtiledata();
+}
+
+/*
+ * Ptracer injects the randomized tile data state. It also reads
+ * before and after that, which will execute the kernel's state copy
+ * functions. So, the tester is advised to double-check any emitted
+ * kernel messages.
+ */
+static void ptracer_inject_tiledata(pid_t target)
+{
+	struct xsave_buffer *xbuf;
+	struct iovec iov;
+
+	xbuf = alloc_xbuf();
+	if (!xbuf)
+		fatal_error("unable to allocate XSAVE buffer");
+
+	printf("\tRead the init'ed tiledata via ptrace().\n");
+
+	iov.iov_base = xbuf;
+	iov.iov_len = xbuf_size;
+
+	memset(stashed_xsave, 0, xbuf_size);
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		fatal_error("PTRACE_GETREGSET");
+
+	if (!__compare_tiledata_state(stashed_xsave, xbuf))
+		printf("[OK]\tThe init'ed tiledata was read from ptracee.\n");
+	else
+		printf("[FAIL]\tThe init'ed tiledata was not read from ptracee.\n");
+
+	printf("\tInject tiledata via ptrace().\n");
+
+	load_rand_tiledata(xbuf);
+
+	memcpy(&stashed_xsave->bytes[xtiledata.xbuf_offset],
+	       &xbuf->bytes[xtiledata.xbuf_offset],
+	       xtiledata.size);
+
+	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		fatal_error("PTRACE_SETREGSET");
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		fatal_error("PTRACE_GETREGSET");
+
+	if (!__compare_tiledata_state(stashed_xsave, xbuf))
+		printf("[OK]\tTiledata was correctly written to ptracee.\n");
+	else
+		printf("[FAIL]\tTiledata was not correctly written to ptracee.\n");
+}
+
+static void test_ptrace(void)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (!child) {
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			err(1, "PTRACE_TRACEME");
+
+		ptracee_firstuse_tiledata();
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	do {
+		wait(&status);
+	} while (WSTOPSIG(status) != SIGTRAP);
+
+	ptracer_inject_tiledata(child);
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		err(1, "ptrace test");
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -846,6 +946,8 @@ int main(void)
 	ctxtswtest_config.num_threads = 5;
 	test_context_switch();
 
+	test_ptrace();
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
