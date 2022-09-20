Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AD5BDAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiITDh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITDhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:37:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA4E15A14A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:37:16 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReJqNSlj7FseAA--.48978S4;
        Tue, 20 Sep 2022 11:37:15 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] LoongArch: Add kretprobe support
Date:   Tue, 20 Sep 2022 11:37:12 +0800
Message-Id: <1663645034-967-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
References: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxReJqNSlj7FseAA--.48978S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxAw1kuFWxJF1UWF4Uurg_yoW5Gw1fpF
        9Iyr9xGr45WrZ3ZrZxJ34FvF4S9rn7u3y7GrZrJa4rCFy5XryUJr1xXrW2vFyrGrZYvr1S
        qF4rJryYkFW7J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jw4SrUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic kretprobe trampoline handler to add kretprobe
support for LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig          |  1 +
 arch/loongarch/kernel/kprobes.c | 49 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 6b01073..5f8503a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -95,6 +95,7 @@ config LOONGARCH
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
+	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PCI
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index b2c73a5..8c3efe5 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -303,7 +303,54 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
+/*
+ * For function-return probes, init_kprobes() establishes a probepoint
+ * here. When a retprobed function returns, this probe is hit and
+ * trampoline_probe_handler() runs, calling the kretprobe's handler.
+ */
+static void __used kretprobe_trampoline_holder(void)
+{
+	asm volatile(".global __kretprobe_trampoline\n"
+		     "__kretprobe_trampoline:\n"
+		     "nop\n");
+}
+
+/* Called when the probe at kretprobe trampoline is hit */
+static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs, NULL);
+	/*
+	 * By returning a non-zero value, we are telling
+	 * kprobe_handler() that we don't want the post_handler
+	 * to run (and have re-enabled preemption)
+	 */
+	return 1;
+}
+NOKPROBE_SYMBOL(trampoline_probe_handler);
+
+static struct kprobe trampoline_p = {
+	.addr = (kprobe_opcode_t *)__kretprobe_trampoline,
+	.pre_handler = trampoline_probe_handler
+};
+
+void arch_prepare_kretprobe(struct kretprobe_instance *ri,
+			    struct pt_regs *regs)
+{
+	ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
+	ri->fp = NULL;
+
+	/* Replace the return addr with trampoline addr */
+	regs->regs[1] = (unsigned long)__kretprobe_trampoline;
+}
+NOKPROBE_SYMBOL(arch_prepare_kretprobe);
+
+int arch_trampoline_kprobe(struct kprobe *p)
+{
+	return p->addr == trampoline_p.addr;
+}
+NOKPROBE_SYMBOL(arch_trampoline_kprobe);
+
 int __init arch_init_kprobes(void)
 {
-	return 0;
+	return register_kprobe(&trampoline_p);
 }
-- 
2.1.0

