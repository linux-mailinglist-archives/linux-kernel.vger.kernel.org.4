Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDEE6348A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiKVUmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiKVUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:40:28 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4297EC81;
        Tue, 22 Nov 2022 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149595;
        bh=iVMCYAmS3XeOy575q0F4bpZRCi+r4Ash4gZrAlnOTWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gx0rqgoxO0RU2ChrQS5GdeCgyTs7X06YQ32SKanbAgP9TUBQPQ3aO8onXBX6NzdCr
         nJGH6oDE2qg2UL/93XRX1Kl0DjLdX+LL/AYVt09pfybJXdrXjMAQqb72wTUs7QwSpr
         AEQPxbJG+UodnZv3Xvhw/nFVZZB2DSI3tNe+gzn+FXHlsxtUbkfLm0oSlqG2XIyg7K
         yi1FZsU3wZ1myE0nueEdI4w01QyjuVdnJQfjv/ffA7XzqgEggIL5w5F7HrtIrYLiDH
         lXAnyF2Tso7tZPX4GixpweFxsBbxAv4GY8bt1rDyxUW6orhC0yMGiy90Oz5/GsAWMZ
         BOKbFomzp3bqQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2g16fnzXLS;
        Tue, 22 Nov 2022 15:39:55 -0500 (EST)
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
Subject: [PATCH 26/30] selftests/rseq: x86: Implement rseq_load_u32_u32
Date:   Tue, 22 Nov 2022 15:39:28 -0500
Message-Id: <20221122203932.231377-27-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow loading a pair of u32 within a rseq critical section. It can be
used in situations where both rseq_abi()->mm_numa_cid and
rseq_abi()->node_id need to be sampled atomically with respect to
preemption, signal delivery and migration.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-x86-bits.h | 43 ++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h          | 14 +++++++
 2 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-x86-bits.h b/tools/testing/selftests/rseq/rseq-x86-bits.h
index 8a9431eec467..fdf5ef398393 100644
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
index d7364ea4d201..b6095c2a5da6 100644
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

