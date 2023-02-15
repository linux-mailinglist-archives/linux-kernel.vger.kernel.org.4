Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA96978E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjBOJZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjBOJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:25:42 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032153770B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:25:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxldjspOxjRuAAAA--.1656S3;
        Wed, 15 Feb 2023 17:25:00 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHuTopOxj3MczAA--.59761S2;
        Wed, 15 Feb 2023 17:24:56 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] LoongArch: ptrace: Add function argument access API
Date:   Wed, 15 Feb 2023 17:24:56 +0800
Message-Id: <20230215092456.30446-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHuTopOxj3MczAA--.59761S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr1kZFyfCF4fWF1DurWrAFb_yoW5JFWrpa
        4kA3ZxGr48urs3uFW3J3WrZryrZrs7CrWSkr1Ik34Syr9FqryrJFWkXr1qy3WktrWUJFWI
        gF15t3yYgFs8Z3JanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        ba8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7IU0NJ57UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regs_get_argument() which returns N th argument of the function
call, This enables ftrace kprobe events to access kernel function
arguments via $argN syntax.

eg:
echo 'p bio_add_page arg1=$arg1' > kprobe_events
bash: echo: write error: Invalid argument

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ptrace.h | 33 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e3eba2eb4b44..103046966893 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -97,6 +97,7 @@ config LOONGARCH
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 66a0e6c480a3..f6ffcc00753c 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -120,6 +120,39 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return regs->regs[4];
 }
 
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:       pt_regs of that context
+ * @n:          function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ * Note that this chooses most probably assignment, in some case
+ * it can be incorrect.
+ * This is expected to be called from kprobes or ftrace with regs
+ * where the top of stack is the return address.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+	static const unsigned int argument_offs[] = {
+		offsetof(struct pt_regs, regs[4]),
+		offsetof(struct pt_regs, regs[5]),
+		offsetof(struct pt_regs, regs[6]),
+		offsetof(struct pt_regs, regs[7]),
+		offsetof(struct pt_regs, regs[8]),
+		offsetof(struct pt_regs, regs[9]),
+		offsetof(struct pt_regs, regs[10]),
+		offsetof(struct pt_regs, regs[11]),
+#define NR_REG_ARGUMENTS 8
+	};
+
+	if (n >= NR_REG_ARGUMENTS) {
+		n -= NR_REG_ARGUMENTS;
+		return regs_get_kernel_stack_nth(regs, n);
+	} else
+		return regs_get_register(regs, argument_offs[n]);
+}
+
 #define instruction_pointer(regs) ((regs)->csr_era)
 #define profile_pc(regs) instruction_pointer(regs)
 
-- 
2.36.0

