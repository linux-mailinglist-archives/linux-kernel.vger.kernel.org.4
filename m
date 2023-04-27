Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7266EFF42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbjD0COC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbjD0CN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:13:56 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39AE74224;
        Wed, 26 Apr 2023 19:12:47 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxBekd2klk414BAA--.2572S3;
        Thu, 27 Apr 2023 10:12:45 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrYQ2klkZ_U9AA--.18515S6;
        Thu, 27 Apr 2023 10:12:42 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: [PATCH v2 4/5] LoongArch: ftrace: Add direct call trampoline samples support
Date:   Thu, 27 Apr 2023 10:12:31 +0800
Message-Id: <1682561552-32324-5-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
References: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxqrYQ2klkZ_U9AA--.18515S6
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3JrW3XFW7JF4UZFW5CFyrXrb_yoWxWrW8pF
        WxurZ3G3WFyFsrKas7ua4xWF17Xry8u3y7KasxAa4jvasIk3yDJrW7Krn7AryxJr13ZFZ7
        XFyUZryYkF4UZaUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace samples need per-architecture trampoline implementations
to save and restore argument registers around the calls to
my_direct_func* and to restore polluted registers (eg: ra).

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig                      |  2 +
 samples/ftrace/ftrace-direct-modify.c       | 34 +++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 41 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 25 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 27 ++++++++++++++
 samples/ftrace/ftrace-direct.c              | 23 ++++++++++++
 6 files changed, 152 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b4e039729bc7..5e87eb686ed3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -122,6 +122,8 @@ config LOONGARCH
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_SETUP_PER_CPU_AREA if NUMA
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index d93abbcb1f4c..ca72c3b710eb 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -96,6 +96,40 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_LOONGARCH
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi.d	$sp, $sp, -16\n"
+"	st.d	$t0, $sp, 0\n"
+"	st.d	$ra, $sp, 8\n"
+"	bl	my_direct_func1\n"
+"	ld.d	$t0, $sp, 0\n"
+"	ld.d	$ra, $sp, 8\n"
+"	addi.d	$sp, $sp, 16\n"
+"	jr	$t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"	addi.d	$sp, $sp, -16\n"
+"	st.d	$t0, $sp, 0\n"
+"	st.d	$ra, $sp, 8\n"
+"	bl	my_direct_func2\n"
+"	ld.d	$t0, $sp, 0\n"
+"	ld.d	$ra, $sp, 8\n"
+"	addi.d	$sp, $sp, 16\n"
+"	jr	$t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_LOONGARCH */
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index b58c594efb51..4708c24d47c6 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -103,6 +103,47 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_LOONGARCH
+#include <asm/asm.h>
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi.d	$sp, $sp, -32\n"
+"	st.d	$a0, $sp, 0\n"
+"	st.d	$t0, $sp, 8\n"
+"	st.d	$ra, $sp, 16\n"
+"	move	$a0, $t0\n"
+"	bl	my_direct_func1\n"
+"	ld.d	$a0, $sp, 0\n"
+"	ld.d	$t0, $sp, 8\n"
+"	ld.d	$ra, $sp, 16\n"
+"	addi.d	$sp, $sp, 32\n"
+"	jr	$t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"	addi.d	$sp, $sp, -32\n"
+"	st.d	$a0, $sp, 0\n"
+"	st.d	$t0, $sp, 8\n"
+"	st.d	$ra, $sp, 16\n"
+"	move	$a0, $t0\n"
+"	bl	my_direct_func2\n"
+"	ld.d	$a0, $sp, 0\n"
+"	ld.d	$t0, $sp, 8\n"
+"	ld.d	$ra, $sp, 16\n"
+"	addi.d	$sp, $sp, 32\n"
+"	jr	$t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_LOONGARCH */
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index c27cf130c319..c2f1652c67bc 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -66,6 +66,31 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_LOONGARCH
+
+#include <asm/asm.h>
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:\n"
+"	addi.d	$sp, $sp, -32\n"
+"	st.d	$a0, $sp, 0\n"
+"	st.d	$t0, $sp, 8\n"
+"	st.d	$ra, $sp, 16\n"
+"	move	$a0, $t0\n"
+"	bl	my_direct_func\n"
+"	ld.d	$a0, $sp, 0\n"
+"	ld.d	$t0, $sp, 8\n"
+"	ld.d	$ra, $sp, 16\n"
+"	addi.d	$sp, $sp, 32\n"
+"	jr	$t0\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_LOONGARCH */
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_multi_init(void)
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 8139dce2a31c..ef64d7509773 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -70,6 +70,33 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_LOONGARCH
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:\n"
+"	addi.d	$sp, $sp, -48\n"
+"	st.d	$a0, $sp, 0\n"
+"	st.d	$a1, $sp, 8\n"
+"	st.d	$a2, $sp, 16\n"
+"	st.d	$t0, $sp, 24\n"
+"	st.d	$ra, $sp, 32\n"
+"	bl	my_direct_func\n"
+"	ld.d	$a0, $sp, 0\n"
+"	ld.d	$a1, $sp, 8\n"
+"	ld.d	$a2, $sp, 16\n"
+"	ld.d	$t0, $sp, 24\n"
+"	ld.d	$ra, $sp, 32\n"
+"	addi.d	$sp, $sp, 48\n"
+"	jr	$t0\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_LOONGARCH */
+
 static int __init ftrace_direct_init(void)
 {
 	return register_ftrace_direct((unsigned long)handle_mm_fault,
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1d3d307ca33d..9be720957bf8 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -63,6 +63,29 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_LOONGARCH
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:\n"
+"	addi.d	$sp, $sp, -32\n"
+"	st.d	$a0, $sp, 0\n"
+"	st.d	$t0, $sp, 8\n"
+"	st.d	$ra, $sp, 16\n"
+"	bl	my_direct_func\n"
+"	ld.d	$a0, $sp, 0\n"
+"	ld.d	$t0, $sp, 8\n"
+"	ld.d	$ra, $sp, 16\n"
+"	addi.d	$sp, $sp, 32\n"
+"	jr	$t0\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_LOONGARCH */
+
 static int __init ftrace_direct_init(void)
 {
 	return register_ftrace_direct((unsigned long)wake_up_process,
-- 
2.37.1

