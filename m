Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA362B521
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiKPI0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiKPIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:25:00 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B489FFE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:23:46 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxStgRnnRjDLQHAA--.20760S3;
        Wed, 16 Nov 2022 16:23:45 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_1cKnnRjxqMUAA--.54947S8;
        Wed, 16 Nov 2022 16:23:45 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8 RESEND 6/9] LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support
Date:   Wed, 16 Nov 2022 16:23:35 +0800
Message-Id: <20221116082338.5145-7-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116082338.5145-1-zhangqing@loongson.cn>
References: <20221116082338.5145-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_1cKnnRjxqMUAA--.54947S8
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZrW3XFW3WrykGFWrWw13XFb_yoW5AF1DpF
        yIy3Z8JF47uFsa9asF9FyUWrs8Zr97u34avayxta4rAF1DXFyUZr1xAr1DXFyUt34kGrWI
        vFyfKwnIkF45X3JanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bhxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2
        jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4U
        JVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUnc4S5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for arguments to be passed in to ftrace_regs by default,
If this is set, then arguments and stack can be found from
the pt_regs.

1. HAVE_DYNAMIC_FTRACE_WITH_ARGS don't need special hook for graph
tracer entry point, but instead we can use graph_ops::func function
to install the return_hooker.
2. Livepatch requires this option in the future.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h | 17 +++++++++++++++++
 arch/loongarch/kernel/ftrace_dyn.c  | 12 ++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 12e3e91a68ae..5c4f1dc87f84 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -90,6 +90,7 @@ config LOONGARCH
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
 	select HAVE_EXIT_THREAD
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index e2803582e110..9c3d05c727e3 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -15,6 +15,23 @@ extern void _mcount(void);
 #define mcount _mcount
 #endif
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+struct ftrace_ops;
+
+struct ftrace_regs {
+	struct pt_regs regs;
+};
+
+static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
+{
+	return &fregs->regs;
+}
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index ec3d951be50c..f538829312d7 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -144,6 +144,17 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
 		*parent = return_hooker;
 }
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = &fregs->regs;
+	unsigned long *parent = (unsigned long *)&regs->regs[1];
+
+	prepare_ftrace_return(ip, (unsigned long *)parent);
+}
+#else
+
 static int ftrace_modify_graph_caller(bool enable)
 {
 	unsigned long pc, func;
@@ -170,4 +181,5 @@ int ftrace_disable_ftrace_graph_caller(void)
 {
 	return ftrace_modify_graph_caller(false);
 }
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.36.0

