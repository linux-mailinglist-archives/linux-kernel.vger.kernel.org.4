Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D6656AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiL0MPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiL0MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B5DE66;
        Tue, 27 Dec 2022 04:13:52 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143230;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXJhBbL/0bVc+DLm/r2kJoHRgcDL+AKrbTrdFjgtx7k=;
        b=rPPFlc965R4bLEo2jqOsJtJbkIYT7JihgDGeu642nac4NvTyO4nGOYpJtgfgfItrN2alJp
        +xJ9kyS7Yjk02NF0x+5/0dFCRJFpHWiJwBVRDIRqKm3AXLKAP0c0Uc/T/5hDE2LMJwwdRb
        MkyWZP8QL304adjZGetgyBm3RPZewPY7BXT5kcJQZdaxKCvklQ/xI7fb+9o+ioCUmb5czo
        THD1Pmnb5L36NE5vFTZNkcHP5iALT+u3WjIItm4OV0McVNDGl4vgjWHkX4BbFyiYzJ54ea
        8Y5TnKd/ht4MaxgA7nxY2vMVdReHZu1DEgIkw5Z41qE0G4hkvBjGzbel9i08YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143230;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXJhBbL/0bVc+DLm/r2kJoHRgcDL+AKrbTrdFjgtx7k=;
        b=axNdlUw3bBk9Lb3gXS8N9i6hL5SwCDPn7SpCZpAB4E2p31LrjNuZFDKbysAl7jyLsnqdrm
        xoCAudGezR36TuDA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: riscv: Template memory ordering and
 percpu access mode
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-18-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-18-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214322965.4906.16200043215728058902.tip-bot2@tip-bot2>
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

Commit-ID:     171586a6ab66fb6be064e399ac2024ab459dfcf9
Gitweb:        https://git.kernel.org/tip/171586a6ab66fb6be064e399ac2024ab459dfcf9
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:19 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:14 +01:00

selftests/rseq: riscv: Template memory ordering and percpu access mode

Introduce a rseq-riscv-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-mm-cid per-cpu data access.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-18-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-riscv-bits.h | 410 ++++++++++++-
 tools/testing/selftests/rseq/rseq-riscv.h      | 527 +----------------
 2 files changed, 437 insertions(+), 500 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h

diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
new file mode 100644
index 0000000..de31a01
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
@@ -0,0 +1,410 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
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
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
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
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index b16d943..17932a7 100644
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
+/* Per-mm-cid indexing. */
 
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
+#define RSEQ_TEMPLATE_MM_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_CID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
