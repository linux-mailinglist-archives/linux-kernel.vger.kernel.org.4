Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D70618955
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKCUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiKCUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:16 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2A205DA;
        Thu,  3 Nov 2022 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505903;
        bh=GiIwE9YHQOYSV1t9xMmzh55nme/2oo46Ec0cLTbVyBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK9MetJuTwG0Fg0JVJbVkhIanpaS8JS+zHzx0juAZx54apDnZdlReSL/2AjtLTpWB
         /g9QKkZ1/x1w12aZthGzNc8gYFxw6ikdIgkRseBO/C3yiUB3Hpss/zMt2uHJL8kO7+
         vZUaTRkhhxHFgU2j+BpXhOL1BIp9Tb2sKk2PY2z7js+wEx50a9l3PfdkhoIhLR8ab2
         yj4nvqt0vKQHaTpRJy0evCeKIEdXaAjNhnaZAUacAlaO2r38bqEerlAizHib1s1Q6z
         4VA2qzkjKcpjU4HkFOROw9QppXEjwRvEgSp+EE4UG6JbzhR6vcB8UjIhdp9aM03Ado
         HyDuK28UsvZsg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F9C2hGvzg2n;
        Thu,  3 Nov 2022 16:05:03 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v5 21/24] selftests/rseq: x86: Implement rseq_load_u32_u32
Date:   Thu,  3 Nov 2022 16:03:56 -0400
Message-Id: <20221103200359.328736-22-mathieu.desnoyers@efficios.com>
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

Allow loading a pair of u32 within a rseq critical section. It can be
used in situations where both rseq_abi()->vm_vcpu_id and
rseq_abi()->node_id need to be sampled atomically with respect to
preemption, signal delivery and migration.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-x86-bits.h | 43 ++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h          | 14 +++++++
 2 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-x86-bits.h b/tools/testing/selftests/rseq/rseq-x86-bits.h
index 28ca77cc876c..ef961ab012e5 100644
--- a/tools/testing/selftests/rseq/rseq-x86-bits.h
+++ b/tools/testing/selftests/rseq/rseq-x86-bits.h
@@ -990,4 +990,47 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 
 #endif
 
+#if defined(RSEQ_TEMPLATE_CPU_ID_NONE) && defined(RSEQ_TEMPLATE_MO_RELAXED)
+
+#define RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_load_u32_u32)(uint32_t *dst1, uint32_t *src1,
+		      uint32_t *dst2, uint32_t *src2)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_ASM_TP_SEGMENT:RSEQ_CS_OFFSET(%[rseq_offset]))
+		RSEQ_INJECT_ASM(3)
+		"movl %[src1], %%eax\n\t"
+		"movl %%eax, %[dst1]\n\t"
+		"movl %[src2], %%eax\n\t"
+		"movl %%eax, %[dst2]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [rseq_offset]		"r" (rseq_offset),
+		  /* final store input */
+		  [dst1]		"m" (*dst1),
+		  [src1]		"m" (*src1),
+		  [dst2]		"m" (*dst2),
+		  [src2]		"m" (*src2)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+	);
+	rseq_after_asm_goto();
+	return 0;
+abort:
+	rseq_after_asm_goto();
+	RSEQ_INJECT_FAILED
+	return -1;
+}
+
+#endif /* defined(RSEQ_TEMPLATE_CPU_ID_NONE) && defined(RSEQ_TEMPLATE_MO_RELAXED) */
+
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 95a76a1c3b27..30fa8bfd874e 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -381,4 +381,18 @@ int rseq_cmpeqv_trymemcpy_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode per
 	}
 }
 
+#ifdef RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static inline __attribute__((always_inline))
+int rseq_load_u32_u32(enum rseq_mo rseq_mo,
+		      uint32_t *dst1, uint32_t *src1,
+		      uint32_t *dst2, uint32_t *src2)
+{
+	if (rseq_mo != RSEQ_MO_RELAXED)
+		return -1;
+	return rseq_load_u32_u32_relaxed(dst1, src1, dst2, src2);
+}
+
+#endif
+
 #endif  /* RSEQ_H_ */
-- 
2.25.1

