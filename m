Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4B5E609C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiIVLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiIVLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:10:29 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2882776;
        Thu, 22 Sep 2022 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844387;
        bh=K6bNMSJLdSPjVcSSblCnPxldKHtP70L+XvGALSqDEkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laf0+DDi2qDifabkP+KIBMm19TDOcvHz7AHX/e1dfEoWqacgUe8Se6K+3buMZO/e9
         QjNWVtgzGw5sdYCXDiwvTxI/JHZHqMBk2v4Lq6jxocOZKNJhnQb1SQAPOQkxZ1PVp5
         imMYFGJbxt/dE09GHwP3rJS4xSlDVv64f84btkFCGRyksTfJJj72ak863AjdlPhoAs
         ti7Hc+do5WM1iod7ZxR+M0qAFQ5zL7k1bKbMnb/CuoQxB8MC/8C/Yjt1vb/NvVCWps
         cmw7VKGKIEukROer0evZdVAy0AiG/xWUarIpuQc0Uh8/cCDL8+Zo5pA+esJPxUtT4F
         y7JjHwn/QEhxA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3Q6sYlzNnj;
        Thu, 22 Sep 2022 06:59:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 14/25] selftests/rseq: arm: Template memory ordering and percpu access mode
Date:   Thu, 22 Sep 2022 06:59:29 -0400
Message-Id: <20220922105941.237830-15-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a rseq-arm-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 tools/testing/selftests/rseq/rseq-arm-bits.h | 505 ++++++++++++++
 tools/testing/selftests/rseq/rseq-arm.h      | 695 +------------------
 2 files changed, 530 insertions(+), 670 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-arm-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-arm-bits.h b/tools/testing/selftests/rseq/rseq-arm-bits.h
new file mode 100644
index 000000000000..60c149d40ac5
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-arm-bits.h
@@ -0,0 +1,505 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-arm-bits.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expectnot], r0\n\t"
+		"beq %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expectnot], r0\n\t"
+		"beq %l[error2]\n\t"
+#endif
+		"str r0, %[load]\n\t"
+		"add r0, %[voffp]\n\t"
+		"ldr r0, [r0]\n\t"
+		/* final store */
+		"str r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		"ldr r0, %[v]\n\t"
+		"add r0, %[count]\n\t"
+		/* final store */
+		"str r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"ldr r0, %[v2]\n\t"
+		"cmp %[expect2], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+		"ldr r0, %[v2]\n\t"
+		"cmp %[expect2], r0\n\t"
+		"bne %l[error3]\n\t"
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_after_asm_goto();
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* try store */
+		"str %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"dmb\n\t"	/* full mb provides store-release */
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"str %[src], %[rseq_scratch0]\n\t"
+		"str %[dst], %[rseq_scratch1]\n\t"
+		"str %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 7f\n\t"
+#endif
+		/* try memcpy */
+		"cmp %[len], #0\n\t" \
+		"beq 333f\n\t" \
+		"222:\n\t" \
+		"ldrb %%r0, [%[src]]\n\t" \
+		"strb %%r0, [%[dst]]\n\t" \
+		"adds %[src], #1\n\t" \
+		"adds %[dst], #1\n\t" \
+		"subs %[len], #1\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"dmb\n\t"	/* full mb provides store-release */
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"ldr %[len], %[rseq_scratch2]\n\t"
+		"ldr %[dst], %[rseq_scratch1]\n\t"
+		"ldr %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      "ldr %[len], %[rseq_scratch2]\n\t"
+				      "ldr %[dst], %[rseq_scratch1]\n\t"
+				      "ldr %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_after_asm_goto();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_after_asm_goto();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_after_asm_goto();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 7445107f842b..eb906db604f0 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -2,7 +2,7 @@
 /*
  * rseq-arm.h
  *
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
 /*
@@ -143,679 +143,34 @@ do {									\
 		teardown						\
 		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
+/* Per-cpu-id indexing. */
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[error2]\n\t"
-#endif
-		/* final store */
-		"str %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expectnot], r0\n\t"
-		"beq %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		"ldr r0, %[v]\n\t"
-		"cmp %[expectnot], r0\n\t"
-		"beq %l[error2]\n\t"
-#endif
-		"str r0, %[load]\n\t"
-		"add r0, %[voffp]\n\t"
-		"ldr r0, [r0]\n\t"
-		/* final store */
-		"str r0, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"Ir" (voffp),
-		  [load]		"m" (*load)
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-#endif
-		"ldr r0, %[v]\n\t"
-		"add r0, %[count]\n\t"
-		/* final store */
-		"str r0, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  [v]			"m" (*v),
-		  [count]		"Ir" (count)
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[error2]\n\t"
-#endif
-		/* try store */
-		"str %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"str %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[error2]\n\t"
-#endif
-		/* try store */
-		"str %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		"dmb\n\t"	/* full mb provides store-release */
-		/* final store */
-		"str %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-		"ldr r0, %[v2]\n\t"
-		"cmp %[expect2], r0\n\t"
-		"bne %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne %l[error2]\n\t"
-		"ldr r0, %[v2]\n\t"
-		"cmp %[expect2], r0\n\t"
-		"bne %l[error3]\n\t"
-#endif
-		/* final store */
-		"str %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		"b 5f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
-		"5:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* cmp2 input */
-		  [v2]			"m" (*v2),
-		  [expect2]		"r" (expect2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2, error3
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("1st expected value comparison failed");
-error3:
-	rseq_after_asm_goto();
-	rseq_bug("2nd expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	uint32_t rseq_scratch[3];
+/* Per-vm-vcpu-id indexing. */
 
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"str %[src], %[rseq_scratch0]\n\t"
-		"str %[dst], %[rseq_scratch1]\n\t"
-		"str %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne 7f\n\t"
-#endif
-		/* try memcpy */
-		"cmp %[len], #0\n\t" \
-		"beq 333f\n\t" \
-		"222:\n\t" \
-		"ldrb %%r0, [%[src]]\n\t" \
-		"strb %%r0, [%[dst]]\n\t" \
-		"adds %[src], #1\n\t" \
-		"adds %[dst], #1\n\t" \
-		"subs %[len], #1\n\t" \
-		"bne 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"str %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"ldr %[len], %[rseq_scratch2]\n\t"
-		"ldr %[dst], %[rseq_scratch1]\n\t"
-		"ldr %[src], %[rseq_scratch0]\n\t"
-		"b 8f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4,
-				      /* teardown */
-				      "ldr %[len], %[rseq_scratch2]\n\t"
-				      "ldr %[dst], %[rseq_scratch1]\n\t"
-				      "ldr %[src], %[rseq_scratch0]\n\t",
-				      abort, 1b, 2b, 4f)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-					/* teardown */
-					"ldr %[len], %[rseq_scratch2]\n\t"
-					"ldr %[dst], %[rseq_scratch1]\n\t"
-					"ldr %[src], %[rseq_scratch0]\n\t",
-					cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-					/* teardown */
-					"ldr %[len], %[rseq_scratch2]\n\t"
-					"ldr %[dst], %[rseq_scratch1]\n\t"
-					"ldr %[src], %[rseq_scratch0]\n\t",
-					error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-					/* teardown */
-					"ldr %[len], %[rseq_scratch2]\n\t"
-					"ldr %[dst], %[rseq_scratch1]\n\t"
-					"ldr %[src], %[rseq_scratch0]\n\t",
-					error2)
-#endif
-		"8:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	uint32_t rseq_scratch[3];
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
 
-	RSEQ_INJECT_C(9)
+/* APIs which are not based on cpu ids. */
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"str %[src], %[rseq_scratch0]\n\t"
-		"str %[dst], %[rseq_scratch1]\n\t"
-		"str %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-		RSEQ_INJECT_ASM(3)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
-		"ldr r0, %[v]\n\t"
-		"cmp %[expect], r0\n\t"
-		"bne 7f\n\t"
-#endif
-		/* try memcpy */
-		"cmp %[len], #0\n\t" \
-		"beq 333f\n\t" \
-		"222:\n\t" \
-		"ldrb %%r0, [%[src]]\n\t" \
-		"strb %%r0, [%[dst]]\n\t" \
-		"adds %[src], #1\n\t" \
-		"adds %[dst], #1\n\t" \
-		"subs %[len], #1\n\t" \
-		"bne 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		"dmb\n\t"	/* full mb provides store-release */
-		/* final store */
-		"str %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"ldr %[len], %[rseq_scratch2]\n\t"
-		"ldr %[dst], %[rseq_scratch1]\n\t"
-		"ldr %[src], %[rseq_scratch0]\n\t"
-		"b 8f\n\t"
-		RSEQ_ASM_DEFINE_ABORT(3, 4,
-				      /* teardown */
-				      "ldr %[len], %[rseq_scratch2]\n\t"
-				      "ldr %[dst], %[rseq_scratch1]\n\t"
-				      "ldr %[src], %[rseq_scratch0]\n\t",
-				      abort, 1b, 2b, 4f)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-					/* teardown */
-					"ldr %[len], %[rseq_scratch2]\n\t"
-					"ldr %[dst], %[rseq_scratch1]\n\t"
-					"ldr %[src], %[rseq_scratch0]\n\t",
-					cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-					/* teardown */
-					"ldr %[len], %[rseq_scratch2]\n\t"
-					"ldr %[dst], %[rseq_scratch1]\n\t"
-					"ldr %[src], %[rseq_scratch0]\n\t",
-					error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-					/* teardown */
-					"ldr %[len], %[rseq_scratch2]\n\t"
-					"ldr %[dst], %[rseq_scratch1]\n\t"
-					"ldr %[src], %[rseq_scratch0]\n\t",
-					error2)
-#endif
-		"8:\n\t"
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		  RSEQ_INJECT_INPUT
-		: "r0", "memory", "cc"
-		  RSEQ_INJECT_CLOBBER
-		: abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1, error2
-#endif
-	);
-	rseq_after_asm_goto();
-	return 0;
-abort:
-	rseq_after_asm_goto();
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	rseq_after_asm_goto();
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_after_asm_goto();
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_after_asm_goto();
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.25.1

