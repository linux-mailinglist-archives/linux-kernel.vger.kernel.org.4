Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521D15BDAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiITDhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiITDhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:37:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 408255A14C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:37:17 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReJqNSlj7FseAA--.48978S5;
        Tue, 20 Sep 2022 11:37:16 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] samples/kprobes: Add LoongArch support
Date:   Tue, 20 Sep 2022 11:37:13 +0800
Message-Id: <1663645034-967-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
References: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxReJqNSlj7FseAA--.48978S5
X-Coremail-Antispam: 1UD129KBjvJXoWrZw4rWrW5CF1fJw1xZFWDJwb_yoW8JF1fpF
        n0y3W5t3yFyw13WFW3Jayvgry0yryjkay8u3ykC34Yya429ry5AF1rKayjyw4kur90qF43
        tr1FvryUGF1xZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI5fHUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LoongArch specific info in handler_pre() and handler_post().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 samples/kprobes/kprobe_example.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index fd346f5..ef44c61 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -55,6 +55,10 @@ static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 	pr_info("<%s> p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
 #endif
+#ifdef CONFIG_LOONGARCH
+	pr_info("<%s> p->addr = 0x%p, era = 0x%lx, estat = 0x%lx\n",
+		p->symbol_name, p->addr, regs->csr_era, regs->csr_estat);
+#endif
 
 	/* A dump_stack() here will give a stack backtrace */
 	return 0;
@@ -92,6 +96,10 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 	pr_info("<%s> p->addr, 0x%p, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->flags);
 #endif
+#ifdef CONFIG_LOONGARCH
+	pr_info("<%s> p->addr = 0x%p, estat = 0x%lx\n",
+		p->symbol_name, p->addr, regs->csr_estat);
+#endif
 }
 
 static int __init kprobe_init(void)
-- 
2.1.0

