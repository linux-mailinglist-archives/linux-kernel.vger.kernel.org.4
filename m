Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5B62CEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiKPXdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiKPXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:33:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3DB845;
        Wed, 16 Nov 2022 15:33:52 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668641630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b4NJm/J85WDhML83BlSewbD+4+BuXSYTmZQa+gXq+ds=;
        b=Ww2ESadqTUHsTafSEk459yN5SEVbwkoMYApCZzFrO8Zp/yEYibZHLJVmdVtGtYrmlsg/HR
        0WDTR/TmJneFYitWD9wUxByQL8mG9tAw+ipjO+XUOWya9FDn1nTviYHZSAv7Gs7zUG2MoY
        mXSD6mPHzuDMbE/RZqrPo7LSEMTdwb70DV8K7iI43Ue/zZjEuA6YV8dMEReSbKS16wRjZZ
        oczqEY/6wkPjCtr71O47I84BXLLXVb7GFwjkvdF+rIh42B2p3U5I2PoEuCAsIbtrDJyu7G
        pJob342J5YePSJ1FG7jN1bVLVJcCX3we9sjz6v5onRHNaORq6Svz7jtoDYQwWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668641630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b4NJm/J85WDhML83BlSewbD+4+BuXSYTmZQa+gXq+ds=;
        b=bhyskC8YYiT7fF10YYZAgwwR3H3KRdboDlSKT5blAHJMNk7fnVOc2gfeSZ082t2iDgKBJ9
        1e3XtK2AcUtG/bBg==
From:   "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/vm/pkeys: Add a regression test for setting
 PKRU through ptrace
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166864162756.4906.16717385072130477506.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6ea25770b043c7997ab21d1ce95ba5de4d3d85d9
Gitweb:        https://git.kernel.org/tip/6ea25770b043c7997ab21d1ce95ba5de4d3d85d9
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Tue, 15 Nov 2022 15:09:32 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 16 Nov 2022 15:07:10 -08:00

selftests/vm/pkeys: Add a regression test for setting PKRU through ptrace

This tests PTRACE_SETREGSET with NT_X86_XSTATE modifying PKRU directly and
removing the PKRU bit from XSTATE_BV.

Signed-off-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221115230932.7126-7-khuey%40kylehuey.com
---
 tools/testing/selftests/vm/pkey-x86.h        |  12 ++-
 tools/testing/selftests/vm/protection_keys.c | 131 +++++++++++++++++-
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index b078ce9..72c14cd 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -104,6 +104,18 @@ static inline int cpu_has_pkeys(void)
 	return 1;
 }
 
+static inline int cpu_max_xsave_size(void)
+{
+	unsigned long XSTATE_CPUID = 0xd;
+	unsigned int eax;
+	unsigned int ebx;
+	unsigned int ecx;
+	unsigned int edx;
+
+	__cpuid_count(XSTATE_CPUID, 0, eax, ebx, ecx, edx);
+	return ecx;
+}
+
 static inline u32 pkey_bit_position(int pkey)
 {
 	return pkey * PKEY_BITS_PER_PKEY;
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 291bc1e..95f403a 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -18,12 +18,13 @@
  *	do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
  *
  * Compile like this:
- *	gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
- *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
+ *	gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
+ *	gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
  */
 #define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__
 #include <errno.h>
+#include <linux/elf.h>
 #include <linux/futex.h>
 #include <time.h>
 #include <sys/time.h>
@@ -1550,6 +1551,129 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
 }
 
+#if defined(__i386__) || defined(__x86_64__)
+void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+{
+	u32 new_pkru;
+	pid_t child;
+	int status, ret;
+	int pkey_offset = pkey_reg_xstate_offset();
+	size_t xsave_size = cpu_max_xsave_size();
+	void *xsave;
+	u32 *pkey_register;
+	u64 *xstate_bv;
+	struct iovec iov;
+
+	new_pkru = ~read_pkey_reg();
+	/* Don't make PROT_EXEC mappings inaccessible */
+	new_pkru &= ~3;
+
+	child = fork();
+	pkey_assert(child >= 0);
+	dprintf3("[%d] fork() ret: %d\n", getpid(), child);
+	if (!child) {
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		/* Stop and allow the tracer to modify PKRU directly */
+		raise(SIGSTOP);
+
+		/*
+		 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
+		 * checking
+		 */
+		if (__read_pkey_reg() != new_pkru)
+			exit(1);
+
+		/* Stop and allow the tracer to clear XSTATE_BV for PKRU */
+		raise(SIGSTOP);
+
+		if (__read_pkey_reg() != 0)
+			exit(1);
+
+		/* Stop and allow the tracer to examine PKRU */
+		raise(SIGSTOP);
+
+		exit(0);
+	}
+
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	xsave = (void *)malloc(xsave_size);
+	pkey_assert(xsave > 0);
+
+	/* Modify the PKRU register directly */
+	iov.iov_base = xsave;
+	iov.iov_len = xsave_size;
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	pkey_register = (u32 *)(xsave + pkey_offset);
+	pkey_assert(*pkey_register == read_pkey_reg());
+
+	*pkey_register = new_pkru;
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	/* Test that the modification is visible in ptrace before any execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == new_pkru);
+
+	/* Execute the tracee */
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
+	/* Test that the tracee saw the PKRU value change */
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	/* Test that the modification is visible in ptrace after execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == new_pkru);
+
+	/* Clear the PKRU bit from XSTATE_BV */
+	xstate_bv = (u64 *)(xsave + 512);
+	*xstate_bv &= ~(1 << 9);
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+
+	/* Test that the modification is visible in ptrace before any execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == 0);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
+	/* Test that the tracee saw the PKRU value go to 0 */
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	/* Test that the modification is visible in ptrace after execution */
+	memset(xsave, 0xCC, xsave_size);
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(*pkey_register == 0);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFEXITED(status));
+	pkey_assert(WEXITSTATUS(status) == 0);
+	free(xsave);
+}
+#endif
+
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
@@ -1585,6 +1709,9 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
 	test_pkey_alloc_free_attach_pkey0,
+#if defined(__i386__) || defined(__x86_64__)
+	test_ptrace_modifies_pkru,
+#endif
 };
 
 void run_tests_once(void)
