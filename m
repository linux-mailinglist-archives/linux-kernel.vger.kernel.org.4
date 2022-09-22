Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243EE5E6093
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiIVLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIVLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:10:24 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116786FC4;
        Thu, 22 Sep 2022 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844390;
        bh=GiIwE9YHQOYSV1t9xMmzh55nme/2oo46Ec0cLTbVyBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTWXc0aH8nagv1sG4a/1BnYxtYlT7HgUJdIrz/5IehKnxao26LaFM/JbVxUphD0Sd
         CyAmyp2vj0l9GnpmxIctPlG4ybyzO8FyFvThOw7Ghu8Ek7c68k4yKSg0OFpioAQ+JD
         c94wjbf9MVWQR299ajNkKw5/wp+NI5DtPqq8i2mHeH5RrTTOZ7Htwz2ys7DLFUjBuh
         MOmQ1UvxzfN/vy3QhzI3N+PS5ZF/GC4nm7djsXncd4/qQYpsNvxm5rAr646XozLxbk
         Xr+pFUsMo3Mvx4cKEWpCsGCzbnDnZoNq42NwBSZ+cNL6g7g5fGr0FVBJbTHliqctSQ
         HYAxUamIIHkyA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3V11wDzNLB;
        Thu, 22 Sep 2022 06:59:50 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 22/25] selftests/rseq: x86: Implement rseq_load_u32_u32
Date:   Thu, 22 Sep 2022 06:59:37 -0400
Message-Id: <20220922105941.237830-23-mathieu.desnoyers@efficios.com>
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

