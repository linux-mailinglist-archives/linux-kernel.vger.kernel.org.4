Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228E5BC1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiISDRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiISDQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:16:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5A0013CC4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:16:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmsQ3ydjUW4dAA--.34031S8;
        Mon, 19 Sep 2022 11:16:41 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/10] LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support
Date:   Mon, 19 Sep 2022 11:16:28 +0800
Message-Id: <20220919031632.15374-7-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220919031632.15374-1-zhangqing@loongson.cn>
References: <20220919031632.15374-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvmsQ3ydjUW4dAA--.34031S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3XFW3WrykGFWrWw13XFb_yoW5AF1DpF
        yIy3Z8JF47uFsa9asF9Fy5Wrs8Xr97C34avayxJa4rAF1DXFyUZr1xAr4DXFyUt3s7GrWI
        vFyrKwnxCF45X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8MqcUUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
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
index 9b701784f7a9..3c82e7d55a3f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -89,6 +89,7 @@ config LOONGARCH
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
 	select HAVE_EXIT_THREAD
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index a3f974a7a5ce..5cc13ae48164 100644
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
2.36.1

