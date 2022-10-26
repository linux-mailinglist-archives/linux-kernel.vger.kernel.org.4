Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1360DEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiJZKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiJZKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:41:28 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE35A231F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:41:23 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666780844t14jq9v9
Received: from localhost.localdomain ( [101.6.93.82])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Oct 2022 18:40:39 +0800 (CST)
X-QQ-SSF: 0140000000000060B000000A0000000
X-QQ-FEAT: LG+NUo/f6sH/5cg3evHTTvo84aPoo8de19Y7L/kvt0DQWpVkBQ87B8w35Spxc
        r7yWzeAKHrTO4ar9iZQKg0C6tgnLQgquRZJz67RCahATJwXLarxPJku1iYNue5PPLvw6zI9
        1DoJ3tDWf61LB3gsRazJpM2WTznKu5ba2scVA6PJ9B8ZAGNukYi8RfkfdU8NUIVMSUiZKlD
        yLs3sI7wmwg9G+fzeY0Y46u9uCUVeVi2pvx0KoZlNsSGPJ++SbjpxVM4UCAKp6VDALOFxq9
        m5/wEGveIT0Gob4/F8lX3Mt4cLudhdq2q5S9STDbRaMpgWoFFwHTUw7HxEcptFhLXSoc2QS
        Mw8xXDFJRK2o28+/A9QL6fcL/quzThVhvuGafDRIVvSkLQvu4dwfngoCy38F+anzYHUw47T
        3HKaaYKWF2o=
X-QQ-GoodBg: 1
From:   Wen Yao <haiwenyao@uniontech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org,
        cl@linux.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Wen Yao <haiwenyao@uniontech.com>
Subject: [PATCH 1/2] riscv: percpu:Add riscv percpu operations
Date:   Wed, 26 Oct 2022 18:40:14 +0800
Message-Id: <20221026104015.565468-2-haiwenyao@uniontech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026104015.565468-1-haiwenyao@uniontech.com>
References: <20221026104015.565468-1-haiwenyao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch use riscv AMO(Atomic Memory Operation) instructions to
optimise some this_cpu_and this_cpu_or this_cpu_add operations.
It reuse cmpxchg_local() to impletment this_cpu_cmpxchg macros.
It reuse xchg_relaxed() to impletment this_cpu_xchg macros.

Signed-off-by: Wen Yao <haiwenyao@uniontech.com>
---
 arch/riscv/include/asm/percpu.h | 101 ++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
new file mode 100644
index 000000000000..ae796e328442
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Union Tech Software Technology Corporation Limited
+ */
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+#include <asm/cmpxchg.h>
+
+#define PERCPU_OP(op, asm_op, c_op)                                            \
+	static inline unsigned long __percpu_##op(void *ptr,                   \
+						  unsigned long val, int size) \
+	{                                                                      \
+		unsigned long ret;                                             \
+		switch (size) {                                                \
+		case 4:                                                        \
+			__asm__ __volatile__(                                  \
+				"amo" #asm_op ".w"                             \
+				" %[ret], %[val], %[ptr]\n"                   \
+				: [ret] "=&r"(ret), [ptr] "+A"(*(u32 *)ptr)    \
+				: [val] "r"(val));                             \
+			break;                                                 \
+		case 8:                                                        \
+			__asm__ __volatile__(                                  \
+				"amo" #asm_op ".d"                             \
+				" %[ret], %[val], %[ptr]\n"                   \
+				: [ret] "=&r"(ret), [ptr] "+A"(*(u64 *)ptr)    \
+				: [val] "r"(val));                             \
+			break;                                                 \
+		default:                                                       \
+			ret = 0;                                               \
+			BUILD_BUG();                                           \
+		}                                                              \
+										\
+		return ret c_op val;                                           \
+	}
+
+PERCPU_OP(add, add, +)
+PERCPU_OP(and, and, &)
+PERCPU_OP(or, or, |)
+#undef PERCPU_OP
+
+/* this_cpu_xchg */
+#define _protect_xchg_local(pcp, val)                           \
+	({                                                      \
+		typeof(*raw_cpu_ptr(&(pcp))) __ret;             \
+		preempt_disable_notrace();                      \
+		__ret = xchg_relaxed(raw_cpu_ptr(&(pcp)), val); \
+		preempt_enable_notrace();                       \
+		__ret;                                          \
+	})
+
+/* this_cpu_cmpxchg */
+#define _protect_cmpxchg_local(pcp, o, n)                         \
+	({                                                        \
+		typeof(*raw_cpu_ptr(&(pcp))) __ret;               \
+		preempt_disable_notrace();                        \
+		__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n); \
+		preempt_enable_notrace();                         \
+		__ret;                                            \
+	})
+
+#define _pcp_protect(operation, pcp, val)                                     \
+	({                                                                    \
+		typeof(pcp) __retval;                                         \
+		preempt_disable_notrace();                                    \
+		__retval = (typeof(pcp))operation(raw_cpu_ptr(&(pcp)), (val), \
+						  sizeof(pcp));               \
+		preempt_enable_notrace();                                     \
+		__retval;                                                     \
+	})
+
+#define _percpu_add(pcp, val) _pcp_protect(__percpu_add, pcp, val)
+
+#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
+
+#define _percpu_and(pcp, val) _pcp_protect(__percpu_and, pcp, val)
+
+#define _percpu_or(pcp, val) _pcp_protect(__percpu_or, pcp, val)
+
+#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
+#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
+
+#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
+#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
+
+#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
+#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
+
+#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
+#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
+
+#define this_cpu_xchg_4(pcp, val) _protect_xchg_local(pcp, val)
+#define this_cpu_xchg_8(pcp, val) _protect_xchg_local(pcp, val)
+
+#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
-- 
2.25.1

