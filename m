Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C6656AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiL0MQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiL0MOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A51E91;
        Tue, 27 Dec 2022 04:13:54 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1Trgmrbf0E2qni+VPZ4bvQvrexugaMSwByC+xh53XM=;
        b=prR9HDT/gkY8dLaUscLiui7QcJhjiojYl6xHMI1IY0oQaOWogckVlqy6CaV3lNR8C8Ro4B
        vVLa5ZD/KPEjTU3S80/YX4PCogw538RinSbDJbsPSQV7Ur1LOo+Jm0IcUmZkFNS0rFe4gW
        FvY4/bfxvpFB95djiQRtO5Hxz/2xxqZX7S0Vz7LqUQxed6rq7l5D/fguM8txZnPOFchy5G
        gMKuzCBGgbkDgd93sU8NER2X44ePfc09iWpsspmHcfXKH0fFq9zks7LWFJb91zFa97icMS
        X00tJKRHNg1FUwmL0p3YnQ2UITztpo1GRFdEVwmmiU6iba0dvPodyKsCYhxM0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1Trgmrbf0E2qni+VPZ4bvQvrexugaMSwByC+xh53XM=;
        b=rucNiHF1O+se+AnzA9ts6fpxA1j4Rf8WlQdZlxfzWMTf5p6rGGP8Fp8PerbBVOWKngE9I4
        VhXUvOj64ZPu77AQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: x86: Template memory ordering and
 percpu access mode
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-12-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-12-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323087.4906.8978055657883628396.tip-bot2@tip-bot2>
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

Commit-ID:     ae31573843028ad17b1a807081c542d17fa9a83a
Gitweb:        https://git.kernel.org/tip/ae31573843028ad17b1a807081c542d17fa9a83a
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:13 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:12 +01:00

selftests/rseq: x86: Template memory ordering and percpu access mode

Introduce a rseq-x86-bits.h template header which is internally included
to generate the static inline functions covering:

- relaxed and release memory ordering,
- per-cpu-id and per-mm-cid per-cpu data access.

This introduces changes to the rseq.h selftests API which require to
update the rseq selftest programs. Similar API/templating changes need
to be done for other architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-12-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/compiler.h           |    6 +-
 tools/testing/selftests/rseq/rseq-bits-reset.h    |   11 +-
 tools/testing/selftests/rseq/rseq-bits-template.h |   41 +-
 tools/testing/selftests/rseq/rseq-x86-bits.h      |  993 ++++++++++-
 tools/testing/selftests/rseq/rseq-x86.h           | 1181 +------------
 tools/testing/selftests/rseq/rseq.h               |  159 ++-
 6 files changed, 1241 insertions(+), 1150 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-reset.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-template.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-bits.h

diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
index 876eb6a..f47092b 100644
--- a/tools/testing/selftests/rseq/compiler.h
+++ b/tools/testing/selftests/rseq/compiler.h
@@ -27,4 +27,10 @@
  */
 #define rseq_after_asm_goto()	asm volatile ("" : : : "memory")
 
+/* Combine two tokens. */
+#define RSEQ__COMBINE_TOKENS(_tokena, _tokenb)	\
+	_tokena##_tokenb
+#define RSEQ_COMBINE_TOKENS(_tokena, _tokenb)	\
+	RSEQ__COMBINE_TOKENS(_tokena, _tokenb)
+
 #endif  /* RSEQ_COMPILER_H_ */
diff --git a/tools/testing/selftests/rseq/rseq-bits-reset.h b/tools/testing/selftests/rseq/rseq-bits-reset.h
new file mode 100644
index 0000000..e865508
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-bits-reset.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-bits-reset.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#undef RSEQ_TEMPLATE_IDENTIFIER
+#undef RSEQ_TEMPLATE_CPU_ID_FIELD
+#undef RSEQ_TEMPLATE_CPU_ID_OFFSET
+#undef RSEQ_TEMPLATE_SUFFIX
diff --git a/tools/testing/selftests/rseq/rseq-bits-template.h b/tools/testing/selftests/rseq/rseq-bits-template.h
new file mode 100644
index 0000000..65698d6
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-bits-template.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-bits-template.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifdef RSEQ_TEMPLATE_CPU_ID
+# define RSEQ_TEMPLATE_CPU_ID_OFFSET	RSEQ_CPU_ID_OFFSET
+# define RSEQ_TEMPLATE_CPU_ID_FIELD	cpu_id
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release_cpu_id
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed_cpu_id
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
+#elif defined(RSEQ_TEMPLATE_MM_CID)
+# define RSEQ_TEMPLATE_CPU_ID_OFFSET	RSEQ_MM_CID_OFFSET
+# define RSEQ_TEMPLATE_CPU_ID_FIELD	mm_cid
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release_mm_cid
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed_mm_cid
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
+#elif defined (RSEQ_TEMPLATE_CPU_ID_NONE)
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
+#else
+# error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+#endif
+
+#define RSEQ_TEMPLATE_IDENTIFIER(x)	RSEQ_COMBINE_TOKENS(x, RSEQ_TEMPLATE_SUFFIX)
+
diff --git a/tools/testing/selftests/rseq/rseq-x86-bits.h b/tools/testing/selftests/rseq/rseq-x86-bits.h
new file mode 100644
index 0000000..8a9431e
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-x86-bits.h
@@ -0,0 +1,993 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-x86-bits.h
+ *
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include "rseq-bits-template.h"
+
+#ifdef __x86_64__
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
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
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movq %%rbx, %[load]\n\t"
+		"addq %[voffp], %%rbx\n\t"
+		"movq (%%rbx), %%rbx\n\t"
+		/* final store */
+		"movq %%rbx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"er" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "rax", "rbx"
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* final store */
+		"addq %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"er" (count)
+		: "memory", "cc", "rax"
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
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, long off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* get p+v */
+		"movq %[ptr], %%rbx\n\t"
+		"addq %[off], %%rbx\n\t"
+		/* get pv */
+		"movq (%%rbx), %%rcx\n\t"
+		/* *pv += inc */
+		"addq %[inc], (%%rcx)\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [ptr]			"m" (*ptr),
+		  [off]			"er" (off),
+		  [inc]			"er" (inc)
+		: "memory", "cc", "rax", "rbx", "rcx"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
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
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
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
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movq %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
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
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint64_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movq %[src], %[rseq_scratch0]\n\t"
+		"movq %[dst], %[rseq_scratch1]\n\t"
+		"movq %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movq %[rseq_scratch2], %[len]\n\t"
+		"movq %[rseq_scratch1], %[dst]\n\t"
+		"movq %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
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
+		: "memory", "cc", "rax"
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
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#elif defined(__i386__)
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
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
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movl %%ebx, %[load]\n\t"
+		"addl %[voffp], %%ebx\n\t"
+		"movl (%%ebx), %%ebx\n\t"
+		/* final store */
+		"movl %%ebx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"ir" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "eax", "ebx"
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+#endif
+		/* final store */
+		"addl %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"ir" (count)
+		: "memory", "cc", "eax"
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
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"m" (newv)
+		: "memory", "cc", "eax"
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
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movl %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"lock; addl $0,-128(%%esp)\n\t"
+#endif
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
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
+
+}
+
+/* TODO: implement a faster memcpy. */
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		"movl %[src], %[rseq_scratch0]\n\t"
+		"movl %[dst], %[rseq_scratch1]\n\t"
+		"movl %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_TEMPLATE_CPU_ID_OFFSET(%[rseq_offset]), 6f)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"lock; addl $0,-128(%%esp)\n\t"
+#endif
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movl %[rseq_scratch2], %[len]\n\t"
+		"movl %[rseq_scratch1], %[dst]\n\t"
+		"movl %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"m" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "eax"
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
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#endif
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index e148dfb..fb65ef5 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -2,9 +2,13 @@
 /*
  * rseq-x86.h
  *
- * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
+#ifndef RSEQ_H
+#error "Never use <rseq-x86.h> directly; include <rseq.h> instead."
+#endif
+
 #include <stdint.h>
 
 /*
@@ -22,9 +26,10 @@
  * address through a "r" input operand.
  */
 
-/* Offset of cpu_id and rseq_cs fields in struct rseq. */
+/* Offset of cpu_id, rseq_cs, and mm_cid fields in struct rseq. */
 #define RSEQ_CPU_ID_OFFSET	4
 #define RSEQ_CS_OFFSET		8
+#define RSEQ_MM_CID_OFFSET	24
 
 #ifdef __x86_64__
 
@@ -108,523 +113,6 @@ do {									\
 		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
 		".popsection\n\t"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "rax"
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
-/*
- * Compare @v against @expectnot. When it does _not_ match, load @v
- * into @load, and store the content of *@v + voffp into @v.
- */
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movq %[v], %%rbx\n\t"
-		"cmpq %%rbx, %[expectnot]\n\t"
-		"je %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"movq %[v], %%rbx\n\t"
-		"cmpq %%rbx, %[expectnot]\n\t"
-		"je %l[error2]\n\t"
-#endif
-		"movq %%rbx, %[load]\n\t"
-		"addq %[voffp], %%rbx\n\t"
-		"movq (%%rbx), %%rbx\n\t"
-		/* final store */
-		"movq %%rbx, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"er" (voffp),
-		  [load]		"m" (*load)
-		: "memory", "cc", "rax", "rbx"
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-#endif
-		/* final store */
-		"addq %[count], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [count]		"er" (count)
-		: "memory", "cc", "rax"
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
-#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
-
-/*
- *   pval = *(ptr+off)
- *  *pval += inc;
- */
-static inline __attribute__((always_inline))
-int rseq_offset_deref_addv(intptr_t *ptr, long off, intptr_t inc, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-#endif
-		/* get p+v */
-		"movq %[ptr], %%rbx\n\t"
-		"addq %[off], %%rbx\n\t"
-		/* get pv */
-		"movq (%%rbx), %%rcx\n\t"
-		/* *pv += inc */
-		"addq %[inc], (%%rcx)\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [ptr]			"m" (*ptr),
-		  [off]			"er" (off),
-		  [inc]			"er" (inc)
-		: "memory", "cc", "rax", "rbx", "rcx"
-		  RSEQ_INJECT_CLOBBER
-		: abort
-#ifdef RSEQ_COMPARE_TWICE
-		  , error1
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
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* try store */
-		"movq %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "rax"
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
-/* x86-64 is TSO. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	return rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2, newv, cpu);
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-		"cmpq %[v2], %[expect2]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpq %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-		"cmpq %[v2], %[expect2]\n\t"
-		"jnz %l[error3]\n\t"
-#endif
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* cmp2 input */
-		  [v2]			"m" (*v2),
-		  [expect2]		"r" (expect2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "rax"
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
-	uint64_t rseq_scratch[3];
-
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"movq %[src], %[rseq_scratch0]\n\t"
-		"movq %[dst], %[rseq_scratch1]\n\t"
-		"movq %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
-		"cmpq %[v], %[expect]\n\t"
-		"jnz 7f\n\t"
-#endif
-		/* try memcpy */
-		"test %[len], %[len]\n\t" \
-		"jz 333f\n\t" \
-		"222:\n\t" \
-		"movb (%[src]), %%al\n\t" \
-		"movb %%al, (%[dst])\n\t" \
-		"inc %[src]\n\t" \
-		"inc %[dst]\n\t" \
-		"dec %[len]\n\t" \
-		"jnz 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"movq %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"movq %[rseq_scratch2], %[len]\n\t"
-		"movq %[rseq_scratch1], %[dst]\n\t"
-		"movq %[rseq_scratch0], %[src]\n\t"
-		RSEQ_ASM_DEFINE_ABORT(4,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			abort)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-			"movq %[rseq_scratch2], %[len]\n\t"
-			"movq %[rseq_scratch1], %[dst]\n\t"
-			"movq %[rseq_scratch0], %[src]\n\t",
-			error2)
-#endif
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
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
-		: "memory", "cc", "rax"
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
-/* x86-64 is TSO. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
-					    newv, cpu);
-}
-
 #elif defined(__i386__)
 
 #define RSEQ_ASM_TP_SEGMENT	%%gs
@@ -711,643 +199,36 @@ do {									\
 		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
 		".popsection\n\t"
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* final store */
-		"movl %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "eax"
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
-/*
- * Compare @v against @expectnot. When it does _not_ match, load @v
- * into @load, and store the content of *@v + voffp into @v.
- */
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[v], %%ebx\n\t"
-		"cmpl %%ebx, %[expectnot]\n\t"
-		"je %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"movl %[v], %%ebx\n\t"
-		"cmpl %%ebx, %[expectnot]\n\t"
-		"je %l[error2]\n\t"
-#endif
-		"movl %%ebx, %[load]\n\t"
-		"addl %[voffp], %%ebx\n\t"
-		"movl (%%ebx), %%ebx\n\t"
-		/* final store */
-		"movl %%ebx, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expectnot]		"r" (expectnot),
-		  [voffp]		"ir" (voffp),
-		  [load]		"m" (*load)
-		: "memory", "cc", "eax", "ebx"
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-#endif
-		/* final store */
-		"addl %[count], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [count]		"ir" (count)
-		: "memory", "cc", "eax"
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
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* try store */
-		"movl %[newv2], %%eax\n\t"
-		"movl %%eax, %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		/* final store */
-		"movl %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"m" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "eax"
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
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
-
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %[v], %%eax\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"movl %[expect], %%eax\n\t"
-		"cmpl %[v], %%eax\n\t"
-		"jnz %l[error2]\n\t"
-#endif
-		/* try store */
-		"movl %[newv2], %[v2]\n\t"
-		RSEQ_INJECT_ASM(5)
-		"lock; addl $0,-128(%%esp)\n\t"
-		/* final store */
-		"movl %[newv], %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* try store input */
-		  [v2]			"m" (*v2),
-		  [newv2]		"r" (newv2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"m" (expect),
-		  [newv]		"r" (newv)
-		: "memory", "cc", "eax"
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
 #endif
 
-}
+/* Per-cpu-id indexing. */
 
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
-#endif
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(4)
-		"cmpl %[expect2], %[v2]\n\t"
-		"jnz %l[cmpfail]\n\t"
-		RSEQ_INJECT_ASM(5)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), %l[error1])
-		"cmpl %[v], %[expect]\n\t"
-		"jnz %l[error2]\n\t"
-		"cmpl %[expect2], %[v2]\n\t"
-		"jnz %l[error3]\n\t"
-#endif
-		"movl %[newv], %%eax\n\t"
-		/* final store */
-		"movl %%eax, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* cmp2 input */
-		  [v2]			"m" (*v2),
-		  [expect2]		"r" (expect2),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"r" (expect),
-		  [newv]		"m" (newv)
-		: "memory", "cc", "eax"
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
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
 
-/* TODO: implement a faster memcpy. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	uint32_t rseq_scratch[3];
+/* Per-mm-cid indexing. */
 
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_MM_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"movl %[src], %[rseq_scratch0]\n\t"
-		"movl %[dst], %[rseq_scratch1]\n\t"
-		"movl %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 7f\n\t"
-#endif
-		/* try memcpy */
-		"test %[len], %[len]\n\t" \
-		"jz 333f\n\t" \
-		"222:\n\t" \
-		"movb (%[src]), %%al\n\t" \
-		"movb %%al, (%[dst])\n\t" \
-		"inc %[src]\n\t" \
-		"inc %[dst]\n\t" \
-		"dec %[len]\n\t" \
-		"jnz 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		"movl %[newv], %%eax\n\t"
-		/* final store */
-		"movl %%eax, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"movl %[rseq_scratch2], %[len]\n\t"
-		"movl %[rseq_scratch1], %[dst]\n\t"
-		"movl %[rseq_scratch0], %[src]\n\t"
-		RSEQ_ASM_DEFINE_ABORT(4,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			abort)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error2)
-#endif
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"m" (expect),
-		  [newv]		"m" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		: "memory", "cc", "eax"
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
-/* TODO: implement a faster memcpy. */
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	uint32_t rseq_scratch[3];
-
-	RSEQ_INJECT_C(9)
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_CID
 
-	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
-		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
-#endif
-		"movl %[src], %[rseq_scratch0]\n\t"
-		"movl %[dst], %[rseq_scratch1]\n\t"
-		"movl %[len], %[rseq_scratch2]\n\t"
-		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 4f)
-		RSEQ_INJECT_ASM(3)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 5f\n\t"
-		RSEQ_INJECT_ASM(4)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_ASM_TP_SEGMENT:RSEQ_CPU_ID_OFFSET(%[rseq_offset]), 6f)
-		"movl %[expect], %%eax\n\t"
-		"cmpl %%eax, %[v]\n\t"
-		"jnz 7f\n\t"
-#endif
-		/* try memcpy */
-		"test %[len], %[len]\n\t" \
-		"jz 333f\n\t" \
-		"222:\n\t" \
-		"movb (%[src]), %%al\n\t" \
-		"movb %%al, (%[dst])\n\t" \
-		"inc %[src]\n\t" \
-		"inc %[dst]\n\t" \
-		"dec %[len]\n\t" \
-		"jnz 222b\n\t" \
-		"333:\n\t" \
-		RSEQ_INJECT_ASM(5)
-		"lock; addl $0,-128(%%esp)\n\t"
-		"movl %[newv], %%eax\n\t"
-		/* final store */
-		"movl %%eax, %[v]\n\t"
-		"2:\n\t"
-		RSEQ_INJECT_ASM(6)
-		/* teardown */
-		"movl %[rseq_scratch2], %[len]\n\t"
-		"movl %[rseq_scratch1], %[dst]\n\t"
-		"movl %[rseq_scratch0], %[src]\n\t"
-		RSEQ_ASM_DEFINE_ABORT(4,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			abort)
-		RSEQ_ASM_DEFINE_CMPFAIL(5,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			cmpfail)
-#ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_DEFINE_CMPFAIL(6,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error1)
-		RSEQ_ASM_DEFINE_CMPFAIL(7,
-			"movl %[rseq_scratch2], %[len]\n\t"
-			"movl %[rseq_scratch1], %[dst]\n\t"
-			"movl %[rseq_scratch0], %[src]\n\t",
-			error2)
-#endif
-		: /* gcc asm goto does not allow outputs */
-		: [cpu_id]		"r" (cpu),
-		  [rseq_offset]		"r" (rseq_offset),
-		  /* final store input */
-		  [v]			"m" (*v),
-		  [expect]		"m" (expect),
-		  [newv]		"m" (newv),
-		  /* try memcpy input */
-		  [dst]			"r" (dst),
-		  [src]			"r" (src),
-		  [len]			"r" (len),
-		  [rseq_scratch0]	"m" (rseq_scratch[0]),
-		  [rseq_scratch1]	"m" (rseq_scratch[1]),
-		  [rseq_scratch2]	"m" (rseq_scratch[2])
-		: "memory", "cc", "eax"
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
+/* APIs which are not based on cpu ids. */
 
-#endif
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 10ebf13..d7364ea 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -74,6 +74,20 @@ extern unsigned int rseq_flags;
  */
 extern unsigned int rseq_feature_size;
 
+enum rseq_mo {
+	RSEQ_MO_RELAXED = 0,
+	RSEQ_MO_CONSUME = 1,	/* Unused */
+	RSEQ_MO_ACQUIRE = 2,	/* Unused */
+	RSEQ_MO_RELEASE = 3,
+	RSEQ_MO_ACQ_REL = 4,	/* Unused */
+	RSEQ_MO_SEQ_CST = 5,	/* Unused */
+};
+
+enum rseq_percpu_mode {
+	RSEQ_PERCPU_CPU_ID = 0,
+	RSEQ_PERCPU_MM_CID = 1,
+};
+
 static inline struct rseq_abi *rseq_get_abi(void)
 {
 	return (struct rseq_abi *) ((uintptr_t) rseq_thread_pointer() + rseq_offset);
@@ -222,4 +236,149 @@ static inline void rseq_prepare_unload(void)
 	rseq_clear_rseq_cs();
 }
 
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+		       intptr_t *v, intptr_t expect,
+		       intptr_t newv, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_cmpeqv_storev_relaxed_cpu_id(v, expect, newv, cpu);
+	case RSEQ_PERCPU_MM_CID:
+		return rseq_cmpeqv_storev_relaxed_mm_cid(v, expect, newv, cpu);
+	}
+	return -1;
+}
+
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+			       intptr_t *v, intptr_t expectnot, long voffp, intptr_t *load,
+			       int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_cmpnev_storeoffp_load_relaxed_cpu_id(v, expectnot, voffp, load, cpu);
+	case RSEQ_PERCPU_MM_CID:
+		return rseq_cmpnev_storeoffp_load_relaxed_mm_cid(v, expectnot, voffp, load, cpu);
+	}
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+	      intptr_t *v, intptr_t count, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_addv_relaxed_cpu_id(v, count, cpu);
+	case RSEQ_PERCPU_MM_CID:
+		return rseq_addv_relaxed_mm_cid(v, count, cpu);
+	}
+	return -1;
+}
+
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int rseq_offset_deref_addv(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+			   intptr_t *ptr, long off, intptr_t inc, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_offset_deref_addv_relaxed_cpu_id(ptr, off, inc, cpu);
+	case RSEQ_PERCPU_MM_CID:
+		return rseq_offset_deref_addv_relaxed_mm_cid(ptr, off, inc, cpu);
+	}
+	return -1;
+}
+#endif
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+				 intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	switch (rseq_mo) {
+	case RSEQ_MO_RELAXED:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trystorev_storev_relaxed_cpu_id(v, expect, v2, newv2, newv, cpu);
+		case RSEQ_PERCPU_MM_CID:
+			return rseq_cmpeqv_trystorev_storev_relaxed_mm_cid(v, expect, v2, newv2, newv, cpu);
+		}
+		return -1;
+	case RSEQ_MO_RELEASE:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trystorev_storev_release_cpu_id(v, expect, v2, newv2, newv, cpu);
+		case RSEQ_PERCPU_MM_CID:
+			return rseq_cmpeqv_trystorev_storev_release_mm_cid(v, expect, v2, newv2, newv, cpu);
+		}
+		return -1;
+	default:
+		return -1;
+	}
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+			      intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	switch (percpu_mode) {
+	case RSEQ_PERCPU_CPU_ID:
+		return rseq_cmpeqv_cmpeqv_storev_relaxed_cpu_id(v, expect, v2, expect2, newv, cpu);
+	case RSEQ_PERCPU_MM_CID:
+		return rseq_cmpeqv_cmpeqv_storev_relaxed_mm_cid(v, expect, v2, expect2, newv, cpu);
+	}
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
+				 intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	switch (rseq_mo) {
+	case RSEQ_MO_RELAXED:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trymemcpy_storev_relaxed_cpu_id(v, expect, dst, src, len, newv, cpu);
+		case RSEQ_PERCPU_MM_CID:
+			return rseq_cmpeqv_trymemcpy_storev_relaxed_mm_cid(v, expect, dst, src, len, newv, cpu);
+		}
+		return -1;
+	case RSEQ_MO_RELEASE:
+		switch (percpu_mode) {
+		case RSEQ_PERCPU_CPU_ID:
+			return rseq_cmpeqv_trymemcpy_storev_release_cpu_id(v, expect, dst, src, len, newv, cpu);
+		case RSEQ_PERCPU_MM_CID:
+			return rseq_cmpeqv_trymemcpy_storev_release_mm_cid(v, expect, dst, src, len, newv, cpu);
+		}
+		return -1;
+	default:
+		return -1;
+	}
+}
+
 #endif  /* RSEQ_H_ */
