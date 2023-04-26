Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB56EEC09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbjDZBtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbjDZBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:49:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4847A122;
        Tue, 25 Apr 2023 18:49:19 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxuOkdg0hkWtAAAA--.1389S3;
        Wed, 26 Apr 2023 09:49:17 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx97Uag0hkROI7AA--.15428S3;
        Wed, 26 Apr 2023 09:49:16 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH 1/5] LoongArch: Fix build error if CONFIG_DYNAMIC_FTRACE_WITH_REGS is not set
Date:   Wed, 26 Apr 2023 09:49:10 +0800
Message-Id: <1682473754-25077-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
References: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx97Uag0hkROI7AA--.15428S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr13Gw1fWr13ur18Xw43ZFb_yoW8Aw4xpr
        W2kw1DJ3yUKFs7KF9F9ryrWrnrWrZrG34aqa17K34FkrWqq3WUXryUZr1DWa45t3s7WrWf
        ZFyfZrWqya17XwUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
        JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can see the following build error on LoongArch if CONFIG_DYNAMIC_FTRACE_WITH_REGS
is not set:

arch/loongarch/kernel/ftrace_dyn.c: In function ‘ftrace_make_call’:
arch/loongarch/kernel/ftrace_dyn.c:167:23: error: implicit declaration of function ‘__get_mod’
  167 |                 ret = __get_mod(&mod, pc);
      |                       ^~~~~~~~~
arch/loongarch/kernel/ftrace_dyn.c:171:24: error: implicit declaration of function ‘get_plt_addr’
  171 |                 addr = get_plt_addr(mod, addr);
      |                        ^~~~~~~~~~~~

The reason is that the __get_mod and get_plt_addr functions will be called
in ftrace_make_{call,nop}.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/kernel/ftrace_dyn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 4a3ef8516ccc..c5f4b4681ddc 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -30,8 +30,6 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new, bool validate)
 	return 0;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-
 #ifdef CONFIG_MODULES
 static inline int __get_mod(struct module **mod, unsigned long addr)
 {
@@ -72,6 +70,7 @@ static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
 }
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned long addr)
 {
 	u32 old, new;
@@ -102,7 +101,6 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned
 
 	return ftrace_modify_code(pc, old, new, true);
 }
-
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
-- 
2.37.1

