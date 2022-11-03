Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2510618954
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiKCUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKCUFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:15 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ECF205C4;
        Thu,  3 Nov 2022 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505902;
        bh=nQ3tEzhqpttUPdzZdmZ1topKxoxEb2txydHcB9R4ty8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wG7SpXlll3yAU8/jcT+n6RT4N3u1NgkVvcCBqj64GIUtGC6B1KMc6aS4PtN0Sd00h
         rjGWbtylO618hFL2CPMafrTZ88dYco+6HF0ISJJTt9j/7OI0MQCt/44+ma6GZsw8e3
         s3AMzAKpoU0e7bdRwMzMmmWaovetKKRWLsAPLSg1M2qogJCWQYBQUZywH2PT21tzyf
         KynQb7VZboiPNAXyQrk3AMvJIa9r15VvfVJGc0Z4PpZsXJLdqCJzb/BhwM2YCeB/Ms
         qRF96izYTO0jl2OTQFjk1ENn3jCNpw6juw/h861RM3DGud+mC8dRE1dK5mdwdV4ASb
         0jURbD8GFHfAw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F9B1KJRzg4l;
        Thu,  3 Nov 2022 16:05:02 -0400 (EDT)
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
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Eric Lin <eric.lin@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v5 18/24] selftests/rseq: riscv: Template memory ordering and percpu access mode
Date:   Thu,  3 Nov 2022 16:03:53 -0400
Message-Id: <20221103200359.328736-19-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
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

Introduce a rseq-riscv-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-vm-vcpu-id per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
Cc: Eric Lin <eric.lin@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v4:
- Use RSEQ_TEMPLATE_CPU_ID_FIELD.
---
 .../testing/selftests/rseq/rseq-riscv-bits.h  | 410 ++++++++++++++
 tools/testing/selftests/rseq/rseq-riscv.h     | 527 +-----------------
 2 files changed, 437 insertions(+), 500 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
new file mode 100644
index 000000000000..7a5ce10b8ccc
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
@@ -0,0 +1,410 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_STORE(load)
+				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(5)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expectnot]		"r" (expectnot),
+				    [load]		"m" (*load),
+				    [voffp]		"r" (voffp)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_LOAD(v)
+				  RSEQ_ASM_OP_R_ADD(count)
+				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [count]		"r" (count)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
+#endif
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]		"r" (cpu),
+				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [v]			"m" (*v),
+				    [expect]		"r" (expect),
+				    [v2]			"m" (*v2),
+				    [expect2]		"r" (expect2),
+				    [newv]		"r" (newv)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2, error3
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+#endif
+				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
+				  RSEQ_INJECT_ASM(4)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]			"r" (cpu),
+				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [ptr]			"r" (ptr),
+				    [off]			"er" (off),
+				    [inc]			"er" (inc)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID))
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_STORE(newv2, v2)
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]			"r" (cpu),
+				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]			"r" (expect),
+				    [v]				"m" (*v),
+				    [newv]			"r" (newv),
+				    [v2]			"m" (*v2),
+				    [newv2]			"r" (newv2)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __always_inline
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
+				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
+#endif
+				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+				  RSEQ_INJECT_ASM(3)
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
+				  RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
+				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
+#endif
+				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
+				  RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+#else
+				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+#endif
+				  RSEQ_INJECT_ASM(6)
+				  RSEQ_ASM_DEFINE_ABORT(4, abort)
+				  : /* gcc asm goto does not allow outputs */
+				  : [cpu_id]			"r" (cpu),
+				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+				    [expect]			"r" (expect),
+				    [v]				"m" (*v),
+				    [newv]			"r" (newv),
+				    [dst]			"r" (dst),
+				    [src]			"r" (src),
+				    [len]			"r" (len)
+				    RSEQ_INJECT_INPUT
+				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
+				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
+				    RSEQ_INJECT_CLOBBER
+				  : abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+				    , error1, error2
+#endif
+	);
+
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_VM_VCPU_ID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index b16d943a63e1..ad61ad06ef9f 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -165,507 +165,34 @@ do {									\
 	RSEQ_ASM_OP_R_ADD(inc)						\
 	__rseq_str(post_commit_label) ":\n"
 
-static inline __always_inline
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [v]			"m" (*v),
-				    [expect]		"r" (expect),
-				    [newv]		"r" (newv)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_R_LOAD(v)
-				  RSEQ_ASM_OP_R_STORE(load)
-				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
-				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [v]			"m" (*v),
-				    [expectnot]		"r" (expectnot),
-				    [load]		"m" (*load),
-				    [voffp]		"r" (voffp)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
+/* Per-cpu-id indexing. */
 
-static inline __always_inline
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-#endif
-				  RSEQ_ASM_OP_R_LOAD(v)
-				  RSEQ_ASM_OP_R_ADD(count)
-				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
-				  RSEQ_INJECT_ASM(4)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [v]			"m" (*v),
-				    [count]		"r" (count)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_STORE(newv2, v2)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [v2]			"m" (*v2),
-				    [newv2]		"r" (newv2)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_STORE(newv2, v2)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [v2]			"m" (*v2),
-				    [newv2]		"r" (newv2)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
-#endif
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [v]			"m" (*v),
-				    [expect]		"r" (expect),
-				    [v2]			"m" (*v2),
-				    [expect2]		"r" (expect2),
-				    [newv]		"r" (newv)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2, error3
-#endif
-	);
-
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-error3:
-	rseq_bug("2nd expected value comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [dst]			"r" (dst),
-				    [src]			"r" (src),
-				    [len]			"r" (len)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
-				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
-
-static inline __always_inline
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
-				  RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
-#endif
-				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
-				  RSEQ_INJECT_ASM(5)
-				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
-				  RSEQ_INJECT_ASM(6)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [expect]		"r" (expect),
-				    [v]			"m" (*v),
-				    [newv]		"r" (newv),
-				    [dst]			"r" (dst),
-				    [src]			"r" (src),
-				    [len]			"r" (len)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
-				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
-				    RSEQ_INJECT_CLOBBER
-				  : abort, cmpfail
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1, error2
-#endif
-	);
-
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-cmpfail:
-	return 1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-error2:
-	rseq_bug("expected value comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
 
-#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+/* Per-vm-vcpu-id indexing. */
 
-/*
- *   pval = *(ptr+off)
- *  *pval += inc;
- */
-static inline __always_inline
-int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
-#endif
-				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
-				  RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
-#endif
-				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
-				  RSEQ_INJECT_ASM(4)
-				  RSEQ_ASM_DEFINE_ABORT(4, abort)
-				  : /* gcc asm goto does not allow outputs */
-				  : [cpu_id]		"r" (cpu),
-				    [current_cpu_id]      "m" (rseq_get_abi()->cpu_id),
-				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
-				    [ptr]			"r" (ptr),
-				    [off]			"er" (off),
-				    [inc]			"er" (inc)
-				    RSEQ_INJECT_INPUT
-				  : "memory", RSEQ_ASM_TMP_REG_1
-				    RSEQ_INJECT_CLOBBER
-				  : abort
-#ifdef RSEQ_COMPARE_TWICE
-				    , error1
-#endif
-	);
-	return 0;
-abort:
-	RSEQ_INJECT_FAILED
-	return -1;
-#ifdef RSEQ_COMPARE_TWICE
-error1:
-	rseq_bug("cpu_id comparison failed");
-#endif
-}
+#define RSEQ_TEMPLATE_VM_VCPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_VM_VCPU_ID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
-- 
2.25.1

