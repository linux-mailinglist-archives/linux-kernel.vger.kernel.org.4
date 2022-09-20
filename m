Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6B5BE9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiITPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiITPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31718606A7;
        Tue, 20 Sep 2022 08:15:49 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX4mV3FPczpTJm;
        Tue, 20 Sep 2022 23:12:58 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <jolsa@kernel.org>, <guoren@kernel.org>, <nsaenzju@redhat.com>,
        <frederic@kernel.org>, <changbin.du@intel.com>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 3/7] riscv: stacktrace: Save pt_regs in encoded fp on irq entry
Date:   Tue, 20 Sep 2022 23:11:58 +0800
Message-ID: <20220920151202.180057-4-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920151202.180057-1-chenzhongjin@huawei.com>
References: <20220920151202.180057-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support stack unwinding at irq entry, the position of pt_regs saved
on stack is nessesary. Because for some functions, compiler only push
s0/fp on stack without ra.

As the situation described in
commit f766f77a74f5("riscv/stacktrace: Fix stack output without ra on the stack top")

When irq happens there, the the function frame looks like:

prev function	|       ...       |
		|                 |
normal function +-----------------+
		| ra to prev      |
		| s0 of prev      |
		|       ...       |<-+
leaf function	+-----------------+  |
		| s0 of normal    |  |
		| empty slot      |  |
irq pt_regs	+-----------------+  |
		| epc (ra to leaf)|  |
		| ra  (ra to norm)|  |
		| ...             |  |
                | s0 of leaf      |--+
		| ...             |
		+-----------------+

If the position of register in pt_regs is {epc, s0}, we can easily
unwind from irq frame to leaf function, as normal functions do.

However when unwinding from unwinding from leaf to normal, beacause
(ra to norm) is saved in pt_regs, but not stackframe of leaf, we
have to get pt_regs for that.

To get pt_regs position on stack, we can save the encoded *pt_regs
in s0, as x86 architecture did. Then we can get s0, epc and ra
easily.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/riscv/include/asm/frame.h | 45 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/entry.S      |  3 +++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/riscv/include/asm/frame.h

diff --git a/arch/riscv/include/asm/frame.h b/arch/riscv/include/asm/frame.h
new file mode 100644
index 000000000000..2a1f45cf3a4e
--- /dev/null
+++ b/arch/riscv/include/asm/frame.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_FRAME_H
+#define _ASM_RISCV_FRAME_H
+
+#include <asm/asm.h>
+
+#ifdef CONFIG_FRAME_POINTER
+
+#ifdef __ASSEMBLY__
+
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just setting the LSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * This macro must be used when sp point to pt_regs
+ */
+.macro ENCODE_FRAME_POINTER
+	add s0, sp, 0x1
+.endm
+
+#else /* !__ASSEMBLY__ */
+
+#define ENCODE_FRAME_POINTER			\
+	"add s0, sp, 0x1\n\t"
+
+#endif /* __ASSEMBLY__ */
+
+#else /* !CONFIG_FRAME_POINTER */
+
+#ifdef __ASSEMBLY__
+
+.macro ENCODE_FRAME_POINTER ptregs_offset=0
+.endm
+
+#else /* !__ASSEMBLY */
+
+#define ENCODE_FRAME_POINTER
+
+#endif /* !__ASSEMBLY */
+
+#endif /* CONFIG_FRAME_POINTER */
+
+#endif /* _ASM_RISCV_FRAME_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b9eda3fcbd6d..ecb15c7430b4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -13,6 +13,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
+#include <asm/frame.h>
 
 #if !IS_ENABLED(CONFIG_PREEMPTION)
 .set resume_kernel, restore_all
@@ -95,6 +96,8 @@ _save_context:
 	REG_S s4, PT_CAUSE(sp)
 	REG_S s5, PT_TP(sp)
 
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * Set the scratch register to 0, so that if a recursive exception
 	 * occurs, the exception vector knows it came from the kernel
-- 
2.17.1

