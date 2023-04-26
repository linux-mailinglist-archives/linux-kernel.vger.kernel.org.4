Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8606EEC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbjDZBtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbjDZBtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:49:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C575D19A6B;
        Tue, 25 Apr 2023 18:49:29 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxzOoog0hkf9AAAA--.1377S3;
        Wed, 26 Apr 2023 09:49:28 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx97Uag0hkROI7AA--.15428S7;
        Wed, 26 Apr 2023 09:49:28 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: [PATCH 5/5] LoongArch: Abstract DYNAMIC_FTRACE_WITH_ARGS accesses
Date:   Wed, 26 Apr 2023 09:49:14 +0800
Message-Id: <1682473754-25077-6-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
References: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Dx97Uag0hkROI7AA--.15428S7
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uw1xCF1xJFWDJrWfWFWrAFb_yoW8uw48pr
        ySk3Z8GFW7CFs2k3W29F15Xr1rJryrAry8CryIkw13AFn8Jw18Zry3uryqyrWUtayxJrWa
        vF1akwsxWrn09a7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6rWOUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Zhang <zhangqing@loongson.cn>

1.Adds new ftrace_regs_{get,set}_*() helpers which can be used to manipulate
ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y, these can always
be used on any ftrace_regs, and when CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n
these can be used when regs are available. A new ftrace_regs_has_args(fregs)
helper is added which code can use to check when these are usable.
2.Prepare ftrace_regs_set_instruction_pointer support in advance.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index f789e680f633..30ee01243416 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -54,6 +54,31 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return &fregs->regs;
 }
 
+static __always_inline void
+ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
+				    unsigned long ip)
+{
+	regs_set_return_value(&fregs->regs, ip);
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
+{
+	return instruction_pointer(&fregs->regs);
+}
+
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(&(fregs)->regs, n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(&(fregs)->regs)
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(&(fregs)->regs)
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(&(fregs)->regs, ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(&(fregs)->regs)
+#define ftrace_regs_query_register_offset(name) \
+
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
-- 
2.37.1

